# 1.Canvas组件用来干啥

Canvas的意思是画布 ，它是UGUI中所有UI元素能够被显示的根本，它主要负责渲染自己的所有UI子对象。 
**如果UI控件对象不是Canvas的子对象，那么控件将不能被渲染**
我们可以通过修改Canvas组件上的参数修改渲染方式

## 1.1 场景中可以有多个canvas对象
场景中允许有多个Canvas对象，可以分别管理不同画布的渲染方式，分辨率适应方式等等参数。
如果没有特殊需求，一般情况场景上一个Canvas即可。

## 1.2 Canvas的三种渲染方式（Render Mode）
 
ScreenSpace-Overlay：屏幕空间，覆盖模式，UI始终在前
ScreenSpace－Camera：屏幕空间，摄像机模式，3D物体可以显示在UI之前
WorldSpace：世界空间，3D模式，主要用于VR