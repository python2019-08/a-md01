# 1. osg data download url

osg data download url:
https://openscenegraph.github.io/OpenSceneGraphDotComBackup/OpenSceneGraph/www.openscenegraph.com/index.php/download-section/data.html

===========================================
# 2.如何在osgEarth中使用Cesium Native？

在osgEarth中使用Cesium Native，需要先构建Cesium Native库，再配置osgEarth使其找到该库，最后通过相关配置加载数据，具体步骤如下：
1. **构建Cesium Native**：
    - 使用Git克隆Cesium Native仓库，命令为`git clone --branch v0.37.0 git@github.com:cesiumgs/cesium-native.git --recurse-submodules`。
    - 进入克隆后的仓库目录，使用CMake进行配置，例如`cmake -b build -s. -G "Visual Studio 17 2022" -a x64 -DCMAKE_INSTALL_PREFIX=install -DCESIUM_TESTS_ENABLED=off -DCMAKE_POSITION_INDEPENDENT_CODE=on`，这里根据实际情况选择编译器和相关参数。
    - 构建并安装Cesium Native，命令为`cmake --build build --config relwithdebinfo`和`cmake --install build --config relwithdebinfo`。构建完成后，Cesium Native的库和头文件会位于`cesium-native/install`目录下。
2. **构建osgEarth并配置Cesium Native**：
    - 按照osgEarth的正常构建流程进行操作，但在使用CMake配置时，需要传入参数`-DCESIUM_NATIVE_DIR=/path/to/cesium-native/install`指定Cesium Native的安装目录，同时传入`-DOSGEARTH_BUILD_CESIUM_NODEKIT=on`，让osgEarth知道如何找到Cesium Native的库和头文件。
3. **设置访问密钥（可选）**：
    - 如果要从Cesium Ion加载数据，需要设置`osgearth_cesiumion_key`环境变量，将其设置为你的Cesium Ion访问密钥。在Windows系统中使用`set osgearth_cesiumion_key=your_key`，在Linux或macOS系统中使用`export osgearth_cesiumion_key=your_key`。
4. **加载数据**：
    - Cesium Native通过`cesiumnative3dtiles`图层在earth文件中提供3D Tiles数据的流式传输功能。可以在earth文件中配置相关节点来加载3D Tiles数据集。如果是加载非Cesium Ion托管的数据集，直接设置`url`为根瓦片集的地址；如果是从Cesium Ion加载资产，则设置相应的`asset id`。
    - 例如，要加载带有Bing影像覆盖的Cesium世界地形，可以在earth文件中添加相应配置。另外，Cesium Native有一个信用系统，若要启用，需在场景中添加一个Cesium信用节点。