# Three.js重建真实地形【教程 

新缸中之脑 于 2021-07-07 21:25:07 发布
     
本文链接：[https://blog.csdn.net/shebao3333/article/details/118557685](https://blog.csdn.net/shebao3333/article/details/118557685) 

 

在这个教程中，我们将学习如何搭建一个3D场景，如何编写GLSL程序并使用Vertex Shader 和Fragment Shader重建澳洲著名的Ululu巨岩附近的真实地形。为了方便起见，我们将使用Three.js和React来编写本教程中的示例代码。

### 0、飞行模拟器

你可能知道微软去年8月发布的游戏 Flight Simulator，如果你和我一样对飞行模拟器或在计算机中重建现实生活中场景，可能已经花了很多时间敬畏地注意到这个游戏中的那些惊人的细节。

![在这里插入图片描述](./three.js-build-terrain_files/9762414c6c34ced2d8f56c9ab1775aee.png)

Terrain in Microsoft Flight Simulator (2020).Image by Asobo Studio/Xbox Game Studios Flight Simulator使用Bing地图的卫星扫描和地形数据实时生成地形。我不会详细解释这里的细节，不过你可以在这里查看具体说明。可以肯定地说，游戏的确准确的重建了现实生活中的地方，有人说，他们甚至在飞过所在城镇时发现自己的房子。

这篇文章将帮助你重现类似的现实场景，尽管细节要小得多，规模要小得多，然而我想你依然会发现这是令人兴奋的。

让我们开始吧。

### 1、WebGL和Three.js

自从WebGL将OpenGL的强大功能引入Web以来，开发可以通过Web访问的具有复杂纹理和照明的 3D 环境就变得可行。Webgl为开发人员提供了一种在带有 Web 浏览器和支持 WebGL的任何平台上展示其作品的方法。如今，支持 WebGL的平台列表相当庞大，已经覆盖了很大一部分用户群。

Three.js允许开发人员在JavaScript中编写代码并与浏览器API（如DOM、音频
API和WebSockets）进行交互，从而让开发人员更容易使用。此外，Three.js还允许你直接调用WebGL层的API。

最近，一个名为react-three-fiber的js库更进一步，支持开发人员毫不费力地使用 JSX声明式地编写其Three.js代码。

### 2、牛刀小试

我们将尝试在Three.js中重现一片地形，并尝试使其尽可能逼真。
但首先，让我们建立一个最小可运行的程序，以便得到一些有形的东西。

我们将首先中创建一个小场景。此场景将包含：
-   在3D空间中的一个正方形的平面，最终将变成一块地形。
-   光源，以便我们可以看到创建的地形。
-   控制，以便我们可以环顾地形四周。

以下是实现的效果，代码可以访问[这里](https://codesandbox.io/s/react-three-fiber-plane-2f4yn?from-embed)

![在这里插入图片描述](./three.js-build-terrain_files/3fcf13f377f251f28996c6a46bb06a4e.png)

要更全面地了解此代码的工作原理，你应该查看Vikrant的文章，中有关react-three-fiber基本原理的解释。

我们要构建的 "地形" 现在只是一个绿色的方块。因此，下一步将获取所需的数据，使其看起来更像地球。

首先，让我们在地球上选一个好地方。

### 3、选择要重建的地点

在这篇文章中，我们将使用一个现实生活中的位置。乌鲁鲁（也称为艾尔斯岩）是澳大利亚中部的自然岩层，它已经被列为联合国教科文组织世界遗产。乌鲁鲁主要是砂岩，有独特的红褐色，周围是Uluṟu-Kata Tjuṯa国家公园的干旱景观。完美的测试位置。
![在这里插入图片描述](./three.js-build-terrain_files/158e3fafd60eb2266aa9ca43d6ca2d16.png)

它是谷歌地球上的特色网站之一。
很漂亮，不是吗？几乎就像火星表面一样。我选择这个地方是因为地形有一些突出的特点，这将是有趣的重建过程，地形高度的变化也非常独特。

我们将分两步重建地形：
-   首先，我们将修改我们之前绘制的平面，以便它具有地形的形状。
-   然后，我们将添加纹理，以便它看起来像真实的东西。

对于这两个步骤，我们都需要不同类型的数据，因此我们将在每一步之前获取这些数据。

### 4、绘制地形高度图
在许多情况下，描述一件事情的最简单方法是用图片。就计算机图形而言，图像可以是最有效的编码数据形式之一，其附加优势是允许人类轻松感知这些数据。

我们需要的第一个数据是地形上每个点的高度或高度映射。这样做的一种方法是将地球表面的点映射到图像中的像素，每个像素代表一些有关地表上的点或区域的数据。

人们所能想到的最自然的映射方法是：像素颜色越浅，对应的点在地球上就越高。

![在这里插入图片描述](./three.js-build-terrain_files/b3dad019a4934a11d8c44c0c01e90a85.png)

幸运的是，有几个工具恰好可以实现这个。一个相当流行的例子是terrain.party，Cities:Skylines社区使用它在游戏中生成地形。

但是，我们将使用另一种免费的在线工具，称为Tangrams Heightmapper。

以下是整个澳大利亚的高度图：
![澳大利亚的高度图](./three.js-build-terrain_files/4abe1fcfeb353e677467b20e268fd2a7.png)

我们需要澳大利亚的一个特定部分。因此，放大乌鲁鲁所在坐标：
`tangrams.github.io/heightmapper/#15.19444/-..`

白色部分是乌鲁鲁，要更高一些，而周围几乎是黑色的，是岩层地面。

Tangrams 封装了一些复杂的工作，确保最低位（海拔 500米）为黑色（#000），而乌鲁鲁峰（海拔 800米）为白色（#fff），其余的则线性映射在两者之间。

在将足够范围的地形导出为PNG文件后，我使用GIMP将其缩放并裁剪成 1024x1024
格式。对于下面处理来说，高度和宽度是2的乘方很重要。

以下是最终得到的高度图：
![最终的高度图](./three.js-build-terrain_files/33b9d87a6779a3e301f574be53e14690.png)

现在，我们需要将此添加到Three.js场景，以便我们的平面开始像最终地形转化。

但首先...

### 5、着色器简介

着色器/Shader是一种由若干参数决定像素外观的函数。在 WebGL 中，有两种类型的着色器：
-   顶点着色器
-   片元着色器

让我们在3D对象的上下文中讨论这些。任何 3D对象的表面都可以表示为一堆多边形。通常，我们使用三角形，因为它们简单而且可以保证是平面。

简单的说，顶点着色器决定这些多边形的顶点在 3D空间中的渲染位置，而片元着色器则决定这些顶点之间的空间将是什么样子。
![在这里插入图片描述](./three.js-build-terrain_files/ba0eb4628e7c7375bb77f65192cd5d93.png)

因此，顶点着色器将帮助我们使用高度图来塑造我们的地形，而片元着色器当我们需要应用纹理将是有用的。\
为此，我们需要修改之前的代码，因为之前使用的材料（MeshBasicMaterial）已经不能满足要求了。相反，我们需要一种叫做ShaderMaterial的特殊材料，它允许我们传入手工制作的着色器。

### 6、使用顶点着色器处理高度图

WebGL 着色器采用 GLSL 语言编写，在某些方面类似于C++，但可编译为直接在GPU 上运行。每个着色器都有一个主函数，此函数中的代码将应用于 GPU帧缓冲区中的每个像素。

在Three.js中，这些着色器可以作为字符串传递到ShaderMaterial中。只要字符串是有效的GLSL 程序就可以正常工作。

我们将制作一个顶点着色器，它采用高度图中每个像素的Red通道值（RGBA 中的R），并将其与缩放因子相结合，以决定 X-Z平面上方每个点的高度（我们的地形所在的平面）。

我们也可以使用蓝色和绿色通道，但由于是转换为灰度，这些值将与高度图中的红色组件 相同。

我们还将创建一个基本的偏远着色器，只需较高的绿色阴影上生成点，以便我们能够很容易地看到结果。

下面是顶点着色器代码：

```C#
// Uniforms are data that are shared between shaders
// The contain data that are uniform across the entire frame.
// The heightmap and scaling constant for each point are uniforms in this respect.

// A uniform to contain the heightmap image
uniform sampler2D bumpTexture;
// A uniform to contain the scaling constant
uniform float bumpScale;

// Varyings are variables whose values are decided in the vertext shader
// But whose values are then needed in the fragment shader

// A variable to store the height of the point
varying float vAmount;
// The UV mapping coordinates of a vertex
varying vec2 vUV;

void main()
{
    // The "coordinates" in UV mapping representation
    vUV = uv;

    // The heightmap data at those coordinates
    vec4 bumpData = texture2D(bumpTexture, uv);

    // height map is grayscale, so it doesn't matter if you use r, g, or b.
    vAmount = bumpData.r;

    // move the position along the normal
    vec3 newPosition = position + normal * bumpScale * vAmount;

    // Compute the position of the vertex using a standard formula
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}
```

下面是运行效果：\
![运行效果](./three.js-build-terrain_files/bf8d4719e0a2b205bd834808cc26c0ce.png)

酷！

你可以点击这里查看代码，在shaders.js 中找到两个着色器的代码。

尝试在App.js 中增加bumpScale变量的值，稍微让高度夸张一些。

好了，我们已经使用顶点Shader将地形高度映射到ShaderMaterial，但它看起来还不像地形。

我们现在需要的是纹理。

### 7、获取地形纹理

如果要让地形看起来像真实的东西，我们就需要真正的纹理。
获得逼真纹理的最简单方法之一是获取卫星图像。

我用了一个简单的办法，使用Mapbox获得一堆乌鲁鲁周围地区的截图，并使用GIMP将其合并成一个单一的图像。

![图片描述](./three.js-build-terrain_files/1d6df050f44a2b33440677b70a0966bb.png)

这实际上是相当耗时的，因为我需要确保图像缩放比例正确并且与高度图一致。

由于高度图和纹理来自不同的来源，我需要调整纹理大小以匹配高度图的缩放级别。为了帮助定位，我还需要使用一些小技巧，如在高度图中添加阈值，以便地理特征可以在高度图中脱颖而出，并帮助我定位。

最后的结果还不错。

### 8、映射地形纹理

![图片描述](./three.js-build-terrain_files/c78f23bf365ff98214902b37c28fdd4b.png)

好了，我们使用高度图和顶点着色器将地形高度转换为ShaderMaterial。
我们还获得了一个大小、缩放级别和位置都一致的纹理地图。

现在，我们需要创建一个片元着色器，可以将地形纹理映射为ShaderMaterial 。

在我们的例子中实现这个环节是令人惊讶的简单。我们只需要读取纹理地图图像，并使用偏远着色器设置相应像素的颜色。

以下是片元着色器的代码：

```C#
// A uniform fot the terrain texture image
uniform sampler2D terrainTexture;

// Get the varyings from the vertex shader
varying vec2 vUV;
// vAmount isn't really used, but could be if necessary
varying float vAmount;

void main()
{
    // Get the color of the fragment from the texture map
    // at that coordinate in the UV mapping
    gl_FragColor = texture2D(terrainTexture, vUV);
}
```

下面是最终的运行结果：
![图片描述](./three.js-build-terrain_files/f8a54ed9860af18517d803141afdd435.png)

漂亮！我们做到了！我们已经使用Uluru和Three.js创建了一个虚拟的乌鲁鲁！

点击[这里](https://codesandbox.io/s/three-js-uluru-texturemap-forked-lhimi?from-embed){rel="nofollow"}查看最终完成的代码。

### 9、结论

在本文中，我们尝试建立了一个基本的3D场景，学习了两种类型的材料（MeshBasicMaterial
和ShaderMaterial），学习了如何使用定制的着色器，并使用Three.js和React重现一块真实世界的地形。

结果相当不错。我们还可以做更多的事情，下次再见！

------------------------------------------------------------------------

原文链接：[用WebGL-Shader重建真实地形--BimAnt](http://www.bimant.com/blog/webgl-shader/)