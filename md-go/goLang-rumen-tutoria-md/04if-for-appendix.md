# 1.golang为啥没有do while

Golang没有`do while`循环，主要是因为Go语言设计时追求简洁性和一致性，希望用更统一的语法处理循环场景。具体原因如下：

- **简化语法设计**：Go语言设计者认为`for`循环已能覆盖所有循环需求，无需额外的`do while`语法。比如`do while`的逻辑可通过`for`实现：
```go
for {
    // 循环体
    if condition {
        break
    }
}
```
- **保持语言简洁**：Go强调“少即是多”，避免冗余语法。类似`do while`这种可由基础语法组合实现的功能，会被设计为通过`for`循环配合条件判断完成。
- **一致性原则**：Go的循环体系仅保留`for`一种关键字，无论是遍历、条件循环还是无限循环，都通过`for`的不同形式实现，降低学习和使用成本。

这种设计虽让习惯`do while`的开发者稍感不适应，但从语言整体简洁性和一致性来看，是Go的典型设计风格。
## 1.2 goto语句的优雅替代

 c++中用`do{   if(condition){break;}   }while(0);`语句优雅代替goto语句
```C++
do{   
    if(condition){
        break;// goto
    }   
}while(0);
```


所以golang中，用下面的结构优雅替代goto语句
```go
for {
    // 循环体
    if condition {
        break // goto
    }

    break // while(0)
}
```
