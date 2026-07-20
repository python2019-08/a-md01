# 1.Object.keys  、 Object.fromEntries 、Object.entries

这三个方法是 **JavaScript 对象 ↔ 数组互转** 的核心工具，也是你处理后端返回数据、重构配置项时的高频武器。

我用一个**实战视角**给你讲清楚，保证你能直接用在项目里。

---

## 一句话速记

| 方法 | 作用 | 比喻 |
|---|---|---|
| `Object.keys()` | **对象 → 键数组** | 把“目录”抽出来 |
| `Object.entries()` | **对象 → 键值对数组** | 把书拆成一页页 |
| `Object.fromEntries()` | **键值对数组 → 对象** | 把页装订成书 |

---

## 1️⃣ Object.keys()
👉 **只拿 key**

```js
const user = {
  id: 1,
  name: 'Abner',
  role: 'admin'
};

Object.keys(user);
// ['id', 'name', 'role']
```

### ✅ 常见用法
#### 遍历对象
```js
Object.keys(user).forEach(key => {
  console.log(key, user[key]);
});
```

#### 判断是否为空对象
```js
const isEmpty = obj => Object.keys(obj).length === 0;
```

---

## 2️⃣ Object.entries()
👉 **对象 → [key, value] 二维数组**

```js
Object.entries(user);
/*
[
  ['id', 1],
  ['name', 'Abner'],
  ['role', 'admin']
]
*/
```

### ✅ 常见用法
#### 条件过滤对象（非常实用）
```js
const filtered = Object.fromEntries(
  Object.entries(user).filter(([key]) => key !== 'role')
);

// { id: 1, name: 'Abner' }
```

#### 重命名字段（前后端字段不一致时）
```js
const map = {
  user_name: 'username',
  user_id: 'id'
};

const newObj = Object.fromEntries(
  Object.entries(user).map(([k, v]) => [map[k] || k, v])
);
```

---

## 3️⃣ Object.fromEntries()
👉 **把 entries 变回对象**

```js
const entries = [
  ['a', 1],
  ['b', 2]
];

Object.fromEntries(entries);
// { a: 1, b: 2 }
```

### ✅ 典型组合拳（最重要）
**Object → 处理 → Object**

```js
const result = Object.fromEntries(
  Object.entries(user)
    .filter(([_, v]) => v !== 'admin')
    .map(([k, v]) => [k.toUpperCase(), v])
);

// { ID: 1, NAME: 'Abner' }
```

---

## 🔥 真实业务场景（你一定会用到）

### ✅ 场景 1：后端返回 snake_case，前端要 camelCase
```js
function toCamel(obj) {
  return Object.fromEntries(
    Object.entries(obj).map(([k, v]) =>
      [k.replace(/_([a-z])/g, g => g[1].toUpperCase()), v]
    )
  );
}

toCamel({ user_name: 'abner', login_count: 10 });
// { userName: 'abner', loginCount: 10 }
```

---

### ✅ 场景 2：删除对象中的空值（常用于表单提交）
```js
const clean = obj =>
  Object.fromEntries(
    Object.entries(obj).filter(([_, v]) => v !== '' && v != null)
  );

clean({ a: 1, b: '', c: null, d: undefined });
// { a: 1 }
```

---

### ✅ 场景 3：React / Ant Design 表单回填
```js
const formData = Object.fromEntries(
  Object.entries(apiData).map(([k, v]) => [k, v ?? ''])
);
```

---

## ⚠️ 注意事项（面试 & 踩坑）

1. **不包含 Symbol 键**
```js
const o = { [Symbol('a')]: 1, b: 2 };
Object.keys(o); // ['b']
```

2. **顺序规则**
- 数字 key 排前面（升序）
- 字符串 key 按插入顺序
- Symbol 永远不在其中

3. **Object.fromEntries 是 ES2019**
- Node ≥ 12 ✅
- 老浏览器需 polyfill

---

## 🧠 记忆口诀
> **keys 拿名，entries 拆开，fromEntries 装回去**

如果你愿意，我可以直接帮你**改写一段你现在的 React / Golang 返回数据处理逻辑**，让你感受这三者有多爽 😄