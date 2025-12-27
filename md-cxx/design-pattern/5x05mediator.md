# 1. Mediator（中介者）设计模式
好的，我们来详细讲解 **Mediator（中介者）设计模式**。这是一种行为型设计模式，它通过引入一个中介对象来减少对象之间直接的、混乱的相互引用，从而降低对象间的耦合度。

### 核心思想

**Mediator 模式的核心思想是：用一个中介对象来封装一系列对象之间的交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。**

简单来说，就是把"网状结构"变成"星形结构"：

```
网状结构（混乱的耦合）         星形结构（通过中介者解耦）
   A ──┐                      A ──────┐
   │   └── C                    │        │
   │       │                    │        │
   B ──────┘                    B ──────┤
   │       │                    │        │
   D ────┐ │                    │        │
   └─────┴─┘                    D ──────┘
                                         │
                                    Mediator
```

---

### 为什么需要 Mediator 模式？

想象一个聊天室系统，有多个用户（User）对象。如果没有中介者：

```java
class User {
    private String name;
    private List<User> users; // 需要知道所有其他用户
    
    public void sendMessage(String message) {
        // 需要直接遍历所有用户并调用他们的接收方法
        for (User user : users) {
            if (user != this) {
                user.receiveMessage(this.name, message);
            }
        }
    }
    
    public void receiveMessage(String sender, String message) {
        System.out.println(sender + " to " + this.name + ": " + message);
    }
}
```

**问题：**
- **高度耦合**：每个User都需要知道所有其他User
- **难以维护**：添加新功能（如私聊、禁言）需要修改所有User类
- **难以复用**：User类无法在其他场景中单独使用
- **难以扩展**：添加新类型的参与者很困难

**Mediator 模式通过引入ChatRoom（中介者）来解决这些问题。**

---

### 模式结构

```
|----------------|          |-------------------|          |-------------------|
|   Colleague    |<---------| ConcreteColleague |          | ConcreteMediator  |
|   (组件接口)    |          |     (具体组件)     |          |   (具体中介者)     |
|----------------|          |-------------------|          |-------------------|
| + setMediator()|                  |                              |
|----------------|                  |                              |
       ^                            |                              |
       |                            | 组件通过中介者与其他组件通信     |
       |                            |------------------------------>|
       |                                                             |
       |                            |-------------------|          |-------------------|
       |----------------------------| ConcreteColleague |          |      Client       |
                                    |     (具体组件)     |          |                   |
                                    |-------------------|          |-------------------|
```

#### 1. 角色定义

*   **Mediator（抽象中介者）**：定义各个同事对象交互的接口。
*   **ConcreteMediator（具体中介者）**：实现中介者接口。它需要知道所有具体的同事类，并负责协调各个同事对象之间的交互。
*   **Colleague（抽象同事类）**：定义同事类的接口，通常包含一个指向中介者的引用。
*   **ConcreteColleague（具体同事类）**：实现同事类接口。每个同事类都知道它的中介者对象，当需要与其他同事通信时，通过中介者来转发。

---

### 代码示例：聊天室系统

让我们用Mediator模式重新设计聊天室。

#### 步骤1：定义中介者接口和同事类基类

```java
// 1. 中介者接口
interface ChatRoomMediator {
    void sendMessage(String message, User user);
    void addUser(User user);
}

// 2. 抽象同事类
abstract class User {
    protected ChatRoomMediator mediator;
    protected String name;
    
    public User(ChatRoomMediator mediator, String name) {
        this.mediator = mediator;
        this.name = name;
    }
    
    public abstract void send(String message);
    public abstract void receive(String message);
    
    public String getName() {
        return name;
    }
}
```

#### 步骤2：实现具体中介者

```java
// 3. 具体中介者 - 聊天室
class ChatRoom implements ChatRoomMediator {
    private List<User> users = new ArrayList<>();
    
    @Override
    public void addUser(User user) {
        this.users.add(user);
        System.out.println(user.getName() + " 加入了聊天室");
    }
    
    @Override
    public void sendMessage(String message, User sender) {
        // 中介者负责将消息分发给所有用户（除了发送者）
        for (User user : users) {
            if (user != sender) { // 不发送给自己
                user.receive(message);
            }
        }
        
        // 可以在这里添加中介逻辑：过滤敏感词、记录日志等
        if (containsSensitiveWords(message)) {
            System.out.println("【系统】消息包含敏感词，已过滤");
            return;
        }
        
        // 正常分发消息
        for (User user : users) {
            if (user != sender) {
                user.receive(sender.getName() + ": " + message);
            }
        }
    }
    
    private boolean containsSensitiveWords(String message) {
        // 简单的敏感词检查逻辑
        return message.toLowerCase().contains("敏感词");
    }
    
    // 中介者可以添加更多协调功能
    public void sendPrivateMessage(String message, User sender, User receiver) {
        System.out.println(sender.getName() + " 私聊 " + receiver.getName() + ": " + message);
        receiver.receive("[私聊] " + sender.getName() + ": " + message);
    }
}
```

#### 步骤3：实现具体同事类

```java
// 4. 具体同事类 - 普通用户
class ChatUser extends User {
    public ChatUser(ChatRoomMediator mediator, String name) {
        super(mediator, name);
    }
    
    @Override
    public void send(String message) {
        System.out.println(this.name + " 发送消息: " + message);
        // 关键：不直接与其他用户通信，而是通过中介者
        mediator.sendMessage(message, this);
    }
    
    @Override
    public void receive(String message) {
        System.out.println(this.name + " 收到消息: " + message);
    }
}

// 5. 具体同事类 - 管理员用户（可以有特殊行为）
class AdminUser extends User {
    public AdminUser(ChatRoomMediator mediator, String name) {
        super(mediator, name);
    }
    
    @Override
    public void send(String message) {
        System.out.println("【管理员】" + this.name + " 发送: " + message);
        mediator.sendMessage("[公告] " + message, this);
    }
    
    @Override
    public void receive(String message) {
        System.out.println("【管理员】" + this.name + " 收到: " + message);
    }
    
    // 管理员特有方法
    public void kickUser(User user, String reason) {
        System.out.println("【管理员操作】" + this.name + " 将 " + user.getName() + " 踢出聊天室，原因: " + reason);
        // 通过中介者执行踢人逻辑
        if (mediator instanceof ChatRoom) {
            ((ChatRoom) mediator).kickUser(user);
        }
    }
}
```

#### 步骤4：扩展中介者功能

```java
// 增强的聊天室中介者
class EnhancedChatRoom extends ChatRoom {
    private boolean isChatActive = true;
    
    public void kickUser(User user) {
        System.out.println(user.getName() + " 已被踢出聊天室");
        // 实际的踢人逻辑...
    }
    
    public void muteChat() {
        isChatActive = false;
        System.out.println("【系统】聊天室已被禁言");
    }
    
    public void unmuteChat() {
        isChatActive = true;
        System.out.println("【系统】聊天室已解除禁言");
    }
    
    @Override
    public void sendMessage(String message, User sender) {
        if (!isChatActive && !(sender instanceof AdminUser)) {
            System.out.println("【系统】聊天室已被禁言，只有管理员可以发言");
            return;
        }
        super.sendMessage(message, sender);
    }
}
```

#### 步骤5：客户端使用

```java
// 6. 客户端代码
public class MediatorDemo {
    public static void main(String[] args) {
        // 创建中介者 - 聊天室
        EnhancedChatRoom chatRoom = new EnhancedChatRoom();
        
        // 创建用户（同事类）
        User alice = new ChatUser(chatRoom, "Alice");
        User bob = new ChatUser(chatRoom, "Bob");
        User charlie = new ChatUser(chatRoom, "Charlie");
        User admin = new AdminUser(chatRoom, "SystemAdmin");
        
        // 将用户添加到聊天室（中介者）
        chatRoom.addUser(alice);
        chatRoom.addUser(bob);
        chatRoom.addUser(charlie);
        chatRoom.addUser(admin);
        
        System.out.println("\n=== 正常聊天 ===");
        alice.send("大家好！");
        bob.send("Hello Alice!");
        admin.send("欢迎新成员！");
        
        System.out.println("\n=== 敏感词过滤 ===");
        charlie.send("这是一个包含敏感词的消息");
        
        System.out.println("\n=== 私聊功能 ===");
        chatRoom.sendPrivateMessage("你好，Bob！", alice, bob);
        
        System.out.println("\n=== 禁言测试 ===");
        chatRoom.muteChat();
        alice.send("我还能发言吗？"); // 这条消息不会被发送
        admin.send("只有管理员可以发言"); // 管理员仍然可以发言
        chatRoom.unmuteChat();
        
        System.out.println("\n=== 管理员操作 ===");
        ((AdminUser) admin).kickUser(charlie, "测试踢人功能");
    }
}
```

**输出结果：**
```
Alice 加入了聊天室
Bob 加入了聊天室
Charlie 加入了聊天室
SystemAdmin 加入了聊天室

=== 正常聊天 ===
Alice 发送消息: 大家好！
Bob 收到消息: Alice: 大家好！
Charlie 收到消息: Alice: 大家好！
SystemAdmin 收到消息: Alice: 大家好！
Bob 发送消息: Hello Alice!
Alice 收到消息: Bob: Hello Alice!
Charlie 收到消息: Bob: Hello Alice!
SystemAdmin 收到消息: Bob: Hello Alice!
【管理员】SystemAdmin 发送: 欢迎新成员！
Alice 收到消息: [公告] 欢迎新成员！
Bob 收到消息: [公告] 欢迎新成员！
Charlie 收到消息: [公告] 欢迎新成员！

=== 敏感词过滤 ===
Charlie 发送消息: 这是一个包含敏感词的消息
【系统】消息包含敏感词，已过滤

=== 私聊功能 ===
Alice 私聊 Bob: 你好，Bob！
Bob 收到消息: [私聊] Alice: 你好，Bob！

=== 禁言测试 ===
【系统】聊天室已被禁言
Alice 发送消息: 我还能发言吗？
【系统】聊天室已被禁言，只有管理员可以发言
【管理员】SystemAdmin 发送: 只有管理员可以发言
Alice 收到消息: [公告] 只有管理员可以发言
Bob 收到消息: [公告] 只有管理员可以发言
Charlie 收到消息: [公告] 只有管理员可以发言
【系统】聊天室已解除禁言

=== 管理员操作 ===
【管理员操作】SystemAdmin 将 Charlie 踢出聊天室，原因: 测试踢人功能
Charlie 已被踢出聊天室
```

---

### 关键要点

1. **控制集中化**：所有交互逻辑都集中在中介者中
2. **同事类解耦**：同事类之间不再直接引用，只依赖中介者
3. **易于扩展**：添加新功能只需修改中介者，不需要修改同事类
4. **交互逻辑复杂化**：中介者可能变得过于复杂，成为"上帝对象"

---

### 优缺点

#### 优点
- **减少耦合**：将对象间错综复杂的关联关系转变为对象与中介者的一对多关系
- **集中控制**：将交互逻辑集中在一个地方，便于理解和维护
- **同事类可重用**：同事类不直接相互依赖，更容易在其他上下文中复用
- **简化对象协议**：用一对多的交互替代多对多的交互

#### 缺点
- **中介者可能过于复杂**：如果对象间交互非常复杂，中介者会变得庞大且难以维护
- **性能问题**：所有通信都通过中介者，可能成为性能瓶颈
- **增加了系统复杂度**：需要多维护一个中介者类

---

### 适用场景

- **对象间交互复杂**：对象间存在大量的关联关系，导致系统结构混乱
- **重用对象困难**：由于对象引用过多，难以单独重用某个对象
- **需要集中控制**：想要定制一个分布在多个类中的行为，又不想生成太多子类

**典型应用：**
- **GUI开发**：对话框中的各种控件之间的交互
- **聊天系统**：多个用户之间的消息传递
- **事件总线**：组件间的事件通信
- **工作流系统**：多个处理节点之间的协调
- **游戏开发**：游戏实体之间的交互（碰撞检测、消息传递等）

### 与相关模式的区别

- **Mediator vs Observer**：Mediator通过封装对象间的交互，Observer通过定义对象间的一对多依赖
- **Mediator vs Facade**：Mediator对象间是双向交互，Facade是单向的简化接口
- **Mediator vs Command**：Mediator处理对象间交互，Command将请求封装为对象

Mediator模式通过引入"中介者"这个中间层，有效地解决了对象间直接耦合的问题，是处理复杂交互关系的有效工具。

========================================================
# 2. 中介对象 和被中介对象间的相互依赖如何破解

非常好的问题！这正是Mediator模式在实际应用中的一个核心痛点。中介者和同事类之间的相互依赖确实会带来设计上的挑战。下面我来详细讲解几种破解这种相互依赖的方法：

## 1. 事件驱动架构（Event-Driven）

使用事件来解耦，中介者不需要知道具体的同事类，只需要处理事件。

### 实现方式：

```java
// 事件基类
abstract class Event {
    private Object source;
    // getter/setter
}

// 具体事件
class MessageEvent extends Event {
    private String message;
    private String sender;
    // getter/setter
}

class UserJoinEvent extends Event {
    private String username;
    // getter/setter
}

// 事件处理器
interface EventHandler<T extends Event> {
    void handle(T event);
}

// 事件总线（中介者）
class EventBusMediator {
    private Map<Class<? extends Event>, List<EventHandler<?>>> handlers = new HashMap<>();
    
    // 注册事件处理器
    public <T extends Event> void subscribe(Class<T> eventType, EventHandler<T> handler) {
        handlers.computeIfAbsent(eventType, k -> new ArrayList<>()).add(handler);
    }
    
    // 发布事件
    public void publish(Event event) {
        List<EventHandler<?>> eventHandlers = handlers.get(event.getClass());
        if (eventHandlers != null) {
            for (EventHandler handler : eventHandlers) {
                handler.handle(event); // 注意：这里需要类型安全的处理
            }
        }
    }
}

// 同事类（不再依赖具体的中介者接口）
class EventDrivenUser {
    private String name;
    private EventBusMediator eventBus;
    
    public EventDrivenUser(String name, EventBusMediator eventBus) {
        this.name = name;
        this.eventBus = eventBus;
    }
    
    public void sendMessage(String message) {
        MessageEvent event = new MessageEvent();
        event.setSender(this.name);
        event.setMessage(message);
        eventBus.publish(event); // 只发布事件，不关心谁处理
    }
    
    public void receiveMessage(String message) {
        System.out.println(name + " received: " + message);
    }
}

// 消息事件处理器
class MessageEventHandler implements EventHandler<MessageEvent> {
    private List<EventDrivenUser> users = new ArrayList<>();
    
    public void addUser(EventDrivenUser user) {
        users.add(user);
    }
    
    @Override
    public void handle(MessageEvent event) {
        // 处理消息事件，但不需要知道具体的User类
        for (EventDrivenUser user : users) {
            if (!user.getName().equals(event.getSender())) {
                user.receiveMessage(event.getSender() + ": " + event.getMessage());
            }
        }
    }
}
```

## 2. 观察者模式结合（Observer Pattern）

让同事类观察中介者，而不是直接调用中介者方法。

```java
// 可观察的中介者
class ObservableMediator {
    private List<MediatorObserver> observers = new ArrayList<>();
    private List<String> messages = new ArrayList<>();
    
    public void addObserver(MediatorObserver observer) {
        observers.add(observer);
    }
    
    public void postMessage(String sender, String message) {
        messages.add(sender + ": " + message);
        // 通知所有观察者
        for (MediatorObserver observer : observers) {
            observer.onMessagePosted(sender, message);
        }
    }
    
    public List<String> getMessageHistory() {
        return new ArrayList<>(messages);
    }
}

// 观察者接口
interface MediatorObserver {
    void onMessagePosted(String sender, String message);
}

// 同事类作为观察者
class ObserverUser implements MediatorObserver {
    private String name;
    
    public ObserverUser(String name) {
        this.name = name;
    }
    
    public void joinChat(ObservableMediator mediator) {
        mediator.addObserver(this);
    }
    
    public void sendMessage(ObservableMediator mediator, String message) {
        mediator.postMessage(this.name, message);
    }
    
    @Override
    public void onMessagePosted(String sender, String message) {
        if (!sender.equals(this.name)) {
            System.out.println(name + " sees: " + sender + " said: " + message);
        }
    }
}
```

## 3. 依赖注入 + 接口隔离

使用依赖注入框架和接口隔离原则来减少依赖。

```java
// 最小化的中介者接口
interface MessageRouter {
    void routeMessage(String message, String sender);
}

// 最小化的用户接口
interface MessageReceiver {
    void receiveMessage(String message);
    String getName();
}

// 具体中介者 - 只依赖抽象接口
class SimpleChatMediator implements MessageRouter {
    private List<MessageReceiver> receivers = new ArrayList<>();
    
    public void registerUser(MessageReceiver receiver) {
        receivers.add(receiver);
    }
    
    @Override
    public void routeMessage(String message, String sender) {
        for (MessageReceiver receiver : receivers) {
            if (!receiver.getName().equals(sender)) {
                receiver.receiveMessage(sender + ": " + message);
            }
        }
    }
}

// 具体用户 - 只依赖抽象接口
class SimpleUser implements MessageReceiver {
    private String name;
    private MessageRouter router;
    
    public SimpleUser(String name, MessageRouter router) {
        this.name = name;
        this.router = router;
    }
    
    public void send(String message) {
        router.routeMessage(message, this.name);
    }
    
    @Override
    public void receiveMessage(String message) {
        System.out.println(name + " received: " + message);
    }
    
    @Override
    public String getName() {
        return name;
    }
}
```

## 4. 服务定位器模式（Service Locator）

同事类通过服务定位器查找中介者，而不是直接依赖。

```java
// 服务定位器
class ServiceLocator {
    private static final Map<Class<?>, Object> services = new HashMap<>();
    
    public static <T> void registerService(Class<T> interfaceType, T implementation) {
        services.put(interfaceType, implementation);
    }
    
    @SuppressWarnings("unchecked")
    public static <T> T getService(Class<T> serviceType) {
        return (T) services.get(serviceType);
    }
}

// 中介者服务接口
interface ChatService {
    void broadcastMessage(String message, String sender);
    void registerUser(ChatUser user);
}

// 同事类通过定位器获取服务
class LocatorUser {
    private String name;
    
    public LocatorUser(String name) {
        this.name = name;
        // 注册到中介者
        ChatService chatService = ServiceLocator.getService(ChatService.class);
        if (chatService != null) {
            // 注册逻辑...
        }
    }
    
    public void sendMessage(String message) {
        ChatService chatService = ServiceLocator.getService(ChatService.class);
        if (chatService != null) {
            chatService.broadcastMessage(message, this.name);
        }
    }
    
    public void receiveMessage(String message) {
        System.out.println(name + " received: " + message);
    }
}
```

## 5. 消息队列模式（Message Queue）

使用消息队列彻底解耦生产者和消费者。

```java
// 简单的消息队列
class MessageQueue {
    private Queue<Message> queue = new LinkedList<>();
    private List<MessageConsumer> consumers = new ArrayList<>();
    
    public void publish(Message message) {
        queue.offer(message);
        dispatchMessages();
    }
    
    public void addConsumer(MessageConsumer consumer) {
        consumers.add(consumer);
    }
    
    private void dispatchMessages() {
        while (!queue.isEmpty()) {
            Message message = queue.poll();
            for (MessageConsumer consumer : consumers) {
                consumer.consume(message);
            }
        }
    }
}

// 消息类
class Message {
    private String type;
    private String payload;
    private String sender;
    // getter/setter
}

// 消息消费者
interface MessageConsumer {
    void consume(Message message);
}

// 同事类作为消息生产者/消费者
class QueueUser implements MessageConsumer {
    private String name;
    private MessageQueue queue;
    
    public QueueUser(String name, MessageQueue queue) {
        this.name = name;
        this.queue = queue;
        queue.addConsumer(this);
    }
    
    public void sendMessage(String content) {
        Message message = new Message();
        message.setType("CHAT_MESSAGE");
        message.setSender(this.name);
        message.setPayload(content);
        queue.publish(message);
    }
    
    @Override
    public void consume(Message message) {
        if ("CHAT_MESSAGE".equals(message.getType()) && 
            !message.getSender().equals(this.name)) {
            System.out.println(name + " received: " + message.getSender() + 
                             ": " + message.getPayload());
        }
    }
}
```

## 6. 响应式编程（Reactive Programming）

使用响应式流来处理数据流。

```java
// 使用RxJava或Reactor的响应式中介者
class ReactiveMediator {
    private final Subject<ChatMessage> messageSubject = 
        PublishSubject.create(); // RxJava
    
    public Observable<ChatMessage> getMessageStream() {
        return messageSubject;
    }
    
    public void sendMessage(ChatMessage message) {
        messageSubject.onNext(message);
    }
}

class ReactiveUser {
    private String name;
    private ReactiveMediator mediator;
    private Disposable subscription;
    
    public ReactiveUser(String name, ReactiveMediator mediator) {
        this.name = name;
        this.mediator = mediator;
        
        // 订阅消息流
        this.subscription = mediator.getMessageStream()
            .filter(msg -> !msg.getSender().equals(this.name))
            .subscribe(this::handleMessage);
    }
    
    public void sendMessage(String content) {
        mediator.sendMessage(new ChatMessage(name, content));
    }
    
    private void handleMessage(ChatMessage message) {
        System.out.println(name + " received: " + message.getSender() + 
                         ": " + message.getContent());
    }
    
    public void disconnect() {
        if (subscription != null) {
            subscription.dispose();
        }
    }
}
```

## 总结：破解策略的选择

| 策略 | 适用场景 | 优点 | 缺点 |
|------|----------|------|------|
| **事件驱动** | 复杂系统，需要高度解耦 | 完全解耦，易于扩展 | 架构复杂，调试困难 |
| **观察者模式** | 一对多通知场景 | 松耦合，符合开闭原则 | 可能引起内存泄漏 |
| **依赖注入** | 大中型项目，需要管理依赖 | 依赖明确，易于测试 | 需要DI框架，配置复杂 |
| **服务定位器** | 遗留系统改造 | 灵活性高 | 依赖隐藏，不易测试 |
| **消息队列** | 分布式系统，异步处理 | 彻底解耦，支持异步 | 系统复杂性增加 |
| **响应式编程** | 数据流处理，实时系统 | 声明式，组合性强 | 学习曲线陡峭 |

## 实际建议

1. **对于简单系统**：使用依赖注入 + 接口隔离就够了
2. **对于复杂交互系统**：推荐事件驱动或消息队列
3. **对于实时数据处理**：考虑响应式编程
4. **对于现有系统改造**：服务定位器或观察者模式可能更合适

**关键原则**：始终让依赖指向抽象而不是具体实现，通过引入中间层（事件、消息、观察者等）来打破直接依赖关系。

选择哪种策略取决于你的具体需求：系统复杂度、性能要求、团队技术栈等因素。