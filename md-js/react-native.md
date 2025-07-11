# 1.react native

React Native 是 Facebook 开发的开源框架，用于构建跨平台移动应用（iOS、Android）。它允许开发者使用 **JavaScript 和 React** 语法编写代码，同时保持原生应用的性能和体验。


### **核心特性**
1. **跨平台开发**  
   一套代码同时运行于 iOS 和 Android，节省 30%-50% 开发成本。
   ```jsx
   // 同一组件在 iOS 和 Android 上自动适配
   import { View, Text, Button } from 'react-native';

   function App() {
     return (
       <View>
         <Text>Hello, React Native!</Text>
         <Button title="点击我" onPress={() => alert('Hello!')} />
       </View>
     );
   }
   ```

2. **原生组件渲染**  
   使用 React 语法，但最终渲染为原生 UI 组件（如 iOS 的 `UIButton`、Android 的 `Button`）。

3. **热更新（Hot Reloading）**  
   修改代码后无需重新编译，实时查看效果，提升开发效率。

4. **丰富的原生 API 支持**  
   可访问相机、GPS、蓝牙等硬件功能，通过 `NativeModules` 与原生代码交互。


### **与 React Web 的区别**
| **特性**         | **React（Web）**              | **React Native**               |
|------------------|-------------------------------|--------------------------------|
| **渲染目标**     | HTML DOM 元素                 | 原生移动组件（如 UIView、TextView） |
| **样式系统**     | CSS 类、内联样式               | Flexbox + StyleSheet 对象       |
| **导航方式**     | 浏览器路由（URL）             | 自定义导航组件（StackNavigator） |
| **常用组件**     | `<div>`, `<button>`, `<input>` | `<View>`, `<Text>`, `<Image>`   |


### **快速开始**
1. **安装开发环境**：
   ```bash
   npm install -g expo-cli  # Expo 快速启动工具
   expo init my-react-native-app
   cd my-react-native-app
   npm start
   ```

2. **在模拟器或真机上运行**：
   - 按 `i` 启动 iOS 模拟器（需安装 Xcode）
   - 按 `a` 启动 Android 模拟器（需安装 Android Studio）
   - 或通过 Expo Go 应用在真机上扫码预览


### **示例：Todo 应用**
```jsx
import React, { useState } from 'react';
import { View, Text, TextInput, Button, FlatList } from 'react-native';

function TodoApp() {
  const [todo, setTodo] = useState('');
  const [todos, setTodos] = useState([]);

  const addTodo = () => {
    if (todo.trim()) {
      setTodos([...todos, { id: Date.now(), text: todo }]);
      setTodo('');
    }
  };

  return (
    <View style={{ padding: 20, marginTop: 50 }}>
      <TextInput
        value={todo}
        onChangeText={setTodo}
        placeholder="输入待办事项"
        style={{ borderBottomWidth: 1, padding: 10, marginBottom: 10 }}
      />
      <Button title="添加" onPress={addTodo} />
      
      <FlatList
        data={todos}
        keyExtractor={item => item.id.toString()}
        renderItem={({ item }) => (
          <Text style={{ padding: 10, borderBottomWidth: 1, borderColor: '#eee' }}>
            {item.text}
          </Text>
        )}
      />
    </View>
  );
}

export default TodoApp;
```


### **导航（Navigation）**
使用 `@react-navigation/native` 实现页面间跳转：
```bash
npm install @react-navigation/native
npm install @react-navigation/stack
```

**示例代码**：
```jsx
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```


### **状态管理**
- **轻量级**：使用 React Context API + useReducer
- **复杂应用**：Redux、MobX 或 Zustand
- **持久化**：结合 `@react-native-async-storage/async-storage`

**示例（Redux）**：
```bash
npm install @reduxjs/toolkit react-redux
```


### **性能优化**
1. **使用 `shouldComponentUpdate` 或 `React.memo`**  
   避免不必要的重渲染：
   ```jsx
   const MyComponent = React.memo(({ data }) => {
     return <Text>{data}</Text>;
   });
   ```

2. **虚拟列表**  
   使用 `FlatList` 或 `SectionList` 处理长列表：
   ```jsx
   <FlatList
     data={largeDataArray}
     renderItem={({ item }) => <Text>{item.name}</Text>}
     keyExtractor={item => item.id}
   />
   ```


### **发布应用**
1. **iOS**：生成 `.ipa` 文件，提交到 App Store
2. **Android**：生成 `.apk` 或 `.aab` 文件，提交到 Google Play

使用 **Expo** 可简化发布流程，无需配置原生开发环境。


### **适用场景**
- **跨平台应用**：需要同时覆盖 iOS 和 Android 的项目
- **快速迭代**：MVP 或需求频繁变更的产品
- **团队资源有限**：前端团队主导，无需专职 iOS/Android 开发

React Native 让开发者能用熟悉的 React 语法开发高性能移动应用，大幅降低跨平台开发成本，是当前主流的移动应用开发方案之一。

==========================================
# 2.react native生成的apk 比原生的apk大多少

React Native（RN）生成的 APK 通常比原生 Android 应用大 2-4 倍，具体差异取决于以下因素：


### **一、APK 大小对比（典型情况）**
| **应用类型**       | **原生 APK 大小** | **React Native APK 大小** | **差异**          |
|--------------------|------------------|--------------------------|-------------------|
| **简单应用**       | 5-10 MB          | 20-30 MB                | **2-3 倍**        |
| **中等复杂度应用** | 15-25 MB         | 40-60 MB                | **2-4 倍**        |
| **大型应用**       | 30+ MB           | 80+ MB                  | **2-3 倍以上**    |


### **二、体积差异的主要原因**
1. **JavaScript 引擎**  
   RN 包含 JavaScript 引擎（如 Hermes 或 JSC），占约 **10-15 MB**。原生应用无需此依赖。

2. **React Native 框架代码**  
   RN 核心库（约 **10-20 MB**），包含组件、桥接层和运行时代码。

3. **资源重复打包**  
   原生应用可更精细地优化资源（如图片），而 RN 默认打包所有资源。

4. **多平台兼容代码**  
   RN 代码需同时支持 iOS 和 Android，包含冗余逻辑。


### **三、优化措施**
#### **1. 使用 Hermes 引擎**
- **效果**：减少 APK 大小约 **5-10 MB**，并提升运行性能。
- **配置**：
  ```bash
  # android/gradle.properties
  hermesEnabled=true
  ```

#### **2. 拆分 APK（App Bundles）**
- **效果**：按架构（arm64-v8a、armeabi-v7a、x86_64）拆分，减少单个 APK 大小。
- **配置**：
  ```groovy
  // android/app/build.gradle
  android {
    bundle {
      language {
        enableSplit = false
      }
      density {
        enableSplit = true
      }
      abi {
        enableSplit = true
      }
    }
  }
  ```

#### **3. 移除未使用资源**
- 使用 `react-native-unused-resources` 工具清理未引用的图片和文件。

#### **4. 代码分割**
- 对大型应用，使用动态导入（Dynamic Import）减少初始包体积：
  ```jsx
  const HeavyComponent = React.lazy(() => import('./HeavyComponent'));
  ```


### **四、实际案例参考**
1. **小型应用**：  
   - 原生：6 MB  
   - RN（未优化）：22 MB  
   - RN（Hermes + 拆分）：14 MB

2. **中型应用**：  
   - 原生：20 MB  
   - RN（未优化）：55 MB  
   - RN（优化后）：35 MB


### **五、权衡与建议**
1. **优势**：  
   - RN 开发效率提升 30%-50%，适合快速迭代。  
   - 用户下载量差异在 4G 时代影响较小（平均应用下载大小 >100 MB）。

2. **适用场景**：  
   - **优先考虑开发效率**：创业公司、MVP 项目。  
   - **严格限制 APK 大小**：资源受限的应用（如预装软件）。

3. **替代方案**：  
   - **Flutter**：APK 体积与原生接近（约大 10-20%），但需学习 Dart。  
   - **原生**：对性能和体积有极致要求的应用。

通过合理优化，RN APK 体积可控制在可接受范围，同时保留跨平台开发的优势。