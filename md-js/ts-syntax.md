# 1.TypeScript 接口和数组

```ts
interface T1 { 
   [index:number]:string 
} 

interface T2 {
    [key: string]: number;
}
```
T1 和 T2 有区别吗?


有显著区别。虽然它们都使用了索引签名，但约束的对象属性（Key）和值（Value）类型完全不同：
### 1. 属性（Key）类型的区别
T1：只能使用 number（数字）作为键。这通常用于模拟类数组（Array-like）结构。
T2：可以使用 string（字符串）作为键。这是最常见的字典/映射（Map/Dictionary）结构。
### 2. 值（Value）类型的区别
T1：所有属性的值必须是 string。
T2：所有属性的值必须是 number。
 
### 3. TypeScript 的特殊行为（自动转换）
这是一个核心知识点：在 JavaScript/TypeScript 中，string 索引包含 number 索引。
对于 T2 ([key: string])：你可以通过 obj["a"] 访问，也可以通过 obj[1] 访问（数字会被转为字符串 "1"）。
对于 T1 ([index: number])：你只能使用数字索引。

### 代码示例对比：
```ts
// T1 示例：类似数组
let list: T1 = {
    0: "Hello",
    1: "World"
};
// list["a"] = "Error"; // ❌ 错误：键必须是数字

// T2 示例：类似普通对象/哈希表
let map: T2 = {
    "power": 100,
    "speed": 50,
    123: 60 // ✅ 正确：数字键会自动转为字符串 "123"
};
```

### 4. 总结
* 如果你在处理列表、序列数据（如之前风机数据的行号索引），用 T1。
* 如果你在处理字段名、配置项（如风机字段名 activePower 对应数值），用 T2。

* 关键点：由于你之前在解析 CSV 数据，通常表头是字符串，数值是浮点数，因此 T2 ([key: string]: number) 才是你最常用的结构。

===============================================================
# 2. T1 、 T2 和 Map 对象的区别

```ts
interface T1 { 
   [index:number]:string 
} 

interface T2 {
    [key: string]: number;
}
```
T1 、 T2 和 Map 对象的区别？


这三者在功能上都能实现“键值对”存储，但在底层机制、类型约束和使用场景上有本质区别。
###  1. T1 vs T2：接口索引签名的内部逻辑
这两个是 普通 JavaScript 对象 的类型约束。

* T1 ([index: number]: string)：
本质：约束对象的键必须是数字（常用于类数组结构）。
限制：在 JS 中，对象的键最终都会被转为字符串。

* T2 ([key: string]: number)：
本质：约束对象的键为字符串（最通用的字典结构）。
特殊点：在 TS 中，string 索引签名可以兼容 number 键，因为 obj[1] 等同于 obj["1"]。

### 2. 接口对象 (T1/T2) vs 标准 Map
这是 Plain Object (POJO) 与 内置集合对象 的对决：

特性 | T1 / T2 (Object) | Map<K, V>
---|------------------|----------
键的类型 | 只能是 string 或 symbol（即使定义为 number 也会被转换） | 任意类型：对象、函数、数字、NaN 都可以作为键
顺序性 | 键的顺序不完全可靠（尤其是数字键会排在前面） | 严格有序：按照插入顺序进行迭代
性能 | 在频繁增删键值对时性能略逊 | 针对频繁增删操作做了专门优化
属性干扰 | 会继承 Object.prototype 的属性（如 toString） | 纯粹的键值存储，不会受原型链干扰
大小获取 | 必须手动计算：Object.keys(obj).length | 直接通过 .size 属性获取
序列化 | 原生支持 JSON：直接 JSON.stringify(obj) | 不支持 JSON：直接转换会得到 {}，需手动转换


### 3. 开发建议：该选哪一个？

#### 场景 A：解析风机数据（CSV）
如果你只是从文件读入数据并进行简单的逻辑运算（如你之前的 evaluate_regulation_capacity）：
选 T2。因为解析结果通常要转为 JSON 传给前端，或者配合 Object.values() 快速获取数组进行数学计算。

#### 场景 B：管理大量动态状态或复杂缓存
如果你在开发机器人调度系统，需要用“整个配置对象”作为键，或者需要严格保证数据的插入顺序：
选 Map。例如：const cache = new Map<Config, Status>();

#### 场景 C：模拟数组
如果你定义的索引是连续的数字（如数据行号）：
选 T1。但通常更建议直接用数组 string[]。

### 代码示例：

```ts
// 使用 Map 处理复杂的键
const powerMap = new Map<number, string>();
powerMap.set(110, "B4-110-有功功率");

// 使用 T2 处理普通的 CSV 行数据
const rowData: T2 = {
    "activePower": 1500,
    "windSpeed": 12
};
```

你目前的代码中，active_power 是作为数组传递的。如果你想记录“特定时间点”对应的“功率”，你更倾向于用时间戳字符串作为 Key，还是用毫秒数数字作为 Key？这将决定你选择 T2 还是 Map。