# 1.Vue.js 中使用 MQTT 
在 Vue.js 中使用 MQTT 进行实时消息通信，主要涉及客户端连接、消息订阅/发布和生命周期管理。下面是一个完整的实现指南：

## 📦 安装与基础使用

### 1. 安装 MQTT 客户端库
```bash
# 安装 MQTT.js
npm install mqtt --save

# 或使用 Paho（WebSocket 专用）
npm install paho-mqtt --save
```

### 2. 创建 MQTT 工具类
```javascript
// utils/mqtt.js
import mqtt from 'mqtt'

class MQTTClient {
  constructor() {
    this.client = null
    this.subscriptions = new Map() // 存储订阅回调
  }
  
  /**
   * 连接MQTT服务器
   * @param {Object} options 连接配置
   */
  connect(options = {}) {
    const {
      host = 'ws://broker.emqx.io:8083/mqtt',
      clientId = `client_${Date.now()}`,
      username = '',
      password = '',
      clean = true,
      connectTimeout = 4000,
      reconnectPeriod = 1000
    } = options
    
    const connectUrl = `${host}`
    
    this.client = mqtt.connect(connectUrl, {
      clientId,
      username,
      password,
      clean,
      connectTimeout,
      reconnectPeriod
    })
    
    // 绑定事件监听
    this.client.on('connect', this.handleConnect.bind(this))
    this.client.on('message', this.handleMessage.bind(this))
    this.client.on('error', this.handleError.bind(this))
    this.client.on('close', this.handleClose.bind(this))
  }
  
  handleConnect() {
    console.log('✅ MQTT连接成功')
    // 自动重新订阅之前的话题
    this.subscriptions.forEach((callbacks, topic) => {
      this.client.subscribe(topic)
    })
  }
  
  handleMessage(topic, message) {
    const data = message.toString()
    console.log(`📨 收到消息 [${topic}]:`, data)
    
    // 触发该话题的所有回调
    const callbacks = this.subscriptions.get(topic) || []
    callbacks.forEach(callback => {
      try {
        callback(JSON.parse(data))
      } catch {
        callback(data) // 如果不是JSON，直接传递字符串
      }
    })
  }
  
  handleError(error) {
    console.error('❌ MQTT错误:', error)
  }
  
  handleClose() {
    console.log('🔌 MQTT连接关闭')
  }
  
  /**
   * 订阅主题
   * @param {string} topic 主题
   * @param {Function} callback 回调函数
   */
  subscribe(topic, callback) {
    if (!this.client || !this.client.connected) {
      console.warn('MQTT客户端未连接')
      return
    }
    
    // 存储回调
    if (!this.subscriptions.has(topic)) {
      this.subscriptions.set(topic, [])
      this.client.subscribe(topic, { qos: 1 }, (err) => {
        if (!err) console.log(`✅ 订阅成功: ${topic}`)
      })
    }
    
    const callbacks = this.subscriptions.get(topic)
    if (!callbacks.includes(callback)) {
      callbacks.push(callback)
    }
  }
  
  /**
   * 取消订阅
   * @param {string} topic 主题
   * @param {Function} callback 要移除的回调
   */
  unsubscribe(topic, callback = null) {
    if (!this.subscriptions.has(topic)) return
    
    if (callback) {
      const callbacks = this.subscriptions.get(topic)
      const index = callbacks.indexOf(callback)
      if (index > -1) callbacks.splice(index, 1)
      
      if (callbacks.length === 0) {
        this.client.unsubscribe(topic)
        this.subscriptions.delete(topic)
      }
    } else {
      this.client.unsubscribe(topic)
      this.subscriptions.delete(topic)
    }
  }
  
  /**
   * 发布消息
   * @param {string} topic 主题
   * @param {any} message 消息内容
   * @param {number} qos 服务质量等级
   */
  publish(topic, message, qos = 1) {
    if (!this.client || !this.client.connected) {
      console.warn('MQTT客户端未连接，无法发布消息')
      return
    }
    
    const payload = typeof message === 'object' 
      ? JSON.stringify(message) 
      : String(message)
    
    this.client.publish(topic, payload, { qos }, (err) => {
      if (err) {
        console.error('发布消息失败:', err)
      } else {
        console.log(`📤 发布成功 [${topic}]:`, message)
      }
    })
  }
  
  /**
   * 断开连接
   */
  disconnect() {
    if (this.client) {
      this.subscriptions.clear()
      this.client.end()
      this.client = null
    }
  }
  
  /**
   * 获取连接状态
   */
  isConnected() {
    return this.client && this.client.connected
  }
}

export default new MQTTClient()
```

### 3. Vue组件中使用
```vue
<!-- components/MQTTDemo.vue -->
<template>
  <div class="mqtt-demo">
    <div class="status">
      连接状态: 
      <span :class="['status-indicator', isConnected ? 'connected' : 'disconnected']">
        {{ isConnected ? '已连接' : '未连接' }}
      </span>
    </div>
    
    <div class="control-panel">
      <button @click="connectMQTT" :disabled="isConnected">
        连接MQTT
      </button>
      
      <button @click="disconnectMQTT" :disabled="!isConnected">
        断开连接
      </button>
      
      <div class="topic-input">
        <input v-model="subscribeTopic" placeholder="输入订阅主题">
        <button @click="subscribeTopicHandler" :disabled="!isConnected">
          订阅
        </button>
      </div>
      
      <div class="publish-panel">
        <input v-model="publishTopic" placeholder="发布主题">
        <input v-model="publishMessage" placeholder="发布内容">
        <button @click="publishMessageHandler" :disabled="!isConnected">
          发布
        </button>
      </div>
    </div>
    
    <div class="messages">
      <h3>收到的消息:</h3>
      <ul>
        <li v-for="(msg, index) in receivedMessages" :key="index">
          [{{ msg.topic }}] {{ msg.message }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import mqttClient from '@/utils/mqtt'

export default {
  name: 'MQTTDemo',
  data() {
    return {
      isConnected: false,
      subscribeTopic: 'test/topic',
      publishTopic: 'test/topic',
      publishMessage: 'Hello MQTT!',
      receivedMessages: []
    }
  },
  
  mounted() {
    // 监听连接状态变化
    this.checkConnection()
    this.interval = setInterval(this.checkConnection, 2000)
    
    // 自动连接示例
    this.connectMQTT()
  },
  
  beforeDestroy() {
    clearInterval(this.interval)
    // 组件销毁时断开连接
    mqttClient.disconnect()
  },
  
  methods: {
    checkConnection() {
      this.isConnected = mqttClient.isConnected()
    },
    
    connectMQTT() {
      mqttClient.connect({
        host: 'ws://broker.emqx.io:8083/mqtt',
        clientId: `vue_client_${Date.now()}`,
        clean: true
      })
    },
    
    disconnectMQTT() {
      mqttClient.disconnect()
      this.receivedMessages = []
    },
    
    subscribeTopicHandler() {
      if (!this.subscribeTopic.trim()) return
      
      mqttClient.subscribe(this.subscribeTopic, (data) => {
        this.receivedMessages.unshift({
          topic: this.subscribeTopic,
          message: typeof data === 'object' ? JSON.stringify(data) : data,
          time: new Date().toLocaleTimeString()
        })
        
        // 限制消息数量
        if (this.receivedMessages.length > 50) {
          this.receivedMessages.pop()
        }
      })
    },
    
    publishMessageHandler() {
      if (!this.publishTopic.trim() || !this.publishMessage.trim()) return
      
      mqttClient.publish(this.publishTopic, this.publishMessage)
    }
  }
}
</script>

<style scoped>
.mqtt-demo {
  padding: 20px;
  max-width: 600px;
  margin: 0 auto;
}

.status-indicator {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-left: 8px;
}

.connected {
  background-color: #52c41a;
}

.disconnected {
  background-color: #ff4d4f;
}

.control-panel {
  margin: 20px 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

button {
  padding: 8px 16px;
  background-color: #1890ff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background-color: #d9d9d9;
  cursor: not-allowed;
}

input {
  padding: 8px;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  flex: 1;
}

.topic-input, .publish-panel {
  display: flex;
  gap: 10px;
}

.messages {
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  padding: 15px;
  max-height: 300px;
  overflow-y: auto;
}

.messages ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.messages li {
  padding: 8px 0;
  border-bottom: 1px solid #f0f0f0;
  font-family: monospace;
  font-size: 12px;
}
</style>
```

## 🎯 高级使用模式

### 1. Vue插件封装
```javascript
// plugins/mqtt.js
import mqtt from 'mqtt'

const MQTTPlugin = {
  install(Vue, options) {
    const defaultOptions = {
      host: 'ws://broker.emqx.io:8083/mqtt',
      clientId: `vue_client_${Math.random().toString(16).substr(2, 8)}`,
      ...options
    }
    
    const mqttClient = mqtt.connect(
      defaultOptions.host, 
      defaultOptions
    )
    
    // 全局混入
    Vue.mixin({
      created() {
        if (this.$options.mqtt) {
          this.$mqtt = mqttClient
          
          // 自动订阅
          const subscriptions = this.$options.mqtt.subscriptions
          if (subscriptions) {
            Object.keys(subscriptions).forEach(topic => {
              mqttClient.subscribe(topic)
              mqttClient.on('message', (topic, message) => {
                if (topic === topic) {
                  subscriptions[topic].call(this, message)
                }
              })
            })
          }
        }
      },
      
      beforeDestroy() {
        if (this.$options.mqtt && this.$options.mqtt.subscriptions) {
          Object.keys(this.$options.mqtt.subscriptions).forEach(topic => {
            mqttClient.unsubscribe(topic)
          })
        }
      }
    })
    
    // 全局属性
    Vue.prototype.$mqtt = mqttClient
  }
}

export default MQTTPlugin
```

### 2. Composition API 使用
```javascript
// composables/useMQTT.js
import { ref, onUnmounted } from 'vue'
import mqttClient from '@/utils/mqtt'

export function useMQTT(topic, options = {}) {
  const message = ref(null)
  const isConnected = ref(false)
  const error = ref(null)
  
  const connect = (connectOptions) => {
    mqttClient.connect(connectOptions)
  }
  
  const subscribe = (callback) => {
    if (topic) {
      mqttClient.subscribe(topic, (data) => {
        message.value = data
        if (callback) callback(data)
      })
    }
  }
  
  const publish = (msg, publishTopic = topic) => {
    mqttClient.publish(publishTopic, msg)
  }
  
  const disconnect = () => {
    mqttClient.disconnect()
  }
  
  // 监听连接状态
  const checkConnection = () => {
    isConnected.value = mqttClient.isConnected()
  }
  
  // 定时检查连接状态
  const interval = setInterval(checkConnection, 2000)
  
  onUnmounted(() => {
    clearInterval(interval)
    if (topic) {
      mqttClient.unsubscribe(topic)
    }
  })
  
  return {
    message,
    isConnected,
    error,
    connect,
    subscribe,
    publish,
    disconnect
  }
}
```

## 📊 最佳实践建议

### 1. 连接配置
```javascript
// 生产环境推荐配置
mqttClient.connect({
  host: process.env.VUE_APP_MQTT_HOST, // 从环境变量读取
  clientId: `client_${getDeviceId()}`, // 使用设备唯一ID
  username: 'your_username',
  password: 'your_password',
  clean: true, // 清理会话
  reconnectPeriod: 5000, // 5秒重连间隔
  connectTimeout: 10000, // 10秒连接超时
  keepalive: 60, // 60秒心跳
  protocolVersion: 5, // MQTT 5.0
  properties: {
    sessionExpiryInterval: 3600 // 会话过期时间
  }
})
```

### 2. 错误处理与重连策略
```javascript
// 增强的错误处理
class RobustMQTTClient extends MQTTClient {
  constructor() {
    super()
    this.retryCount = 0
    this.maxRetries = 5
  }
  
  handleError(error) {
    console.error('MQTT错误:', error)
    
    // 重连逻辑
    if (this.retryCount < this.maxRetries) {
      this.retryCount++
      setTimeout(() => {
        console.log(`尝试重连 (${this.retryCount}/${this.maxRetries})`)
        this.reconnect()
      }, Math.min(1000 * Math.pow(2, this.retryCount), 30000))
    }
  }
  
  handleConnect() {
    console.log('MQTT连接成功')
    this.retryCount = 0 // 重置重试计数
  }
}
```

### 3. 主题设计规范
```javascript
// 使用分层主题结构
const topics = {
  // 设备相关
  DEVICE_STATUS: 'device/+/status',      // 设备状态
  DEVICE_CONTROL: 'device/{id}/control',  // 控制设备
  
  // 用户相关
  USER_ONLINE: 'user/+/online',          // 用户在线状态
  USER_MESSAGE: 'user/{id}/message',     // 用户消息
  
  // 系统相关
  SYSTEM_ALERT: 'system/alert',          // 系统告警
  SYSTEM_METRICS: 'system/metrics'       // 系统指标
}

// 使用通配符
// +: 单层通配符
// #: 多层通配符
mqttClient.subscribe('home/+/temperature')
mqttClient.subscribe('home/#') // 所有home下的主题
```

## ⚠️ 注意事项

1. **WebSocket支持**：浏览器环境需要使用WebSocket连接（`ws://` 或 `wss://`）

2. **跨域问题**：确保MQTT代理服务器支持CORS

3. **内存管理**：
   - 及时取消订阅不再需要的主题
   - 组件销毁时断开连接
   - 限制消息队列长度

4. **安全性**：
   - 生产环境使用WSS（加密连接）
   - 使用Token认证
   - 验证主题权限

5. **性能优化**：
   - 合并高频小消息
   - 使用QoS等级（0-最快，1-至少一次，2-正好一次）
   - 启用消息持久化

这个实现方案既包含了基础使用，也提供了高级封装和最佳实践，你可以根据实际项目需求选择合适的实现方式。