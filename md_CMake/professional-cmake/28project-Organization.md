
# Ch28. Project Organization

The factors that contribute to an effective project structure are many and varied. What works for one project may not work for another, but there are typically some things that do tend to be common. Choosing a flexible but predictable directory structure early in the life of a project allows it to evolve with minimal friction and reorganization. 【译】有助于有效项目结构的因素是多种多样的。适用于一个项目的方法可能不适用于另一个项目，但通常有一些方法是常见的。在项目生命周期的早期选择一个灵活但可预测的目录结构，可以使其在最小的摩擦和重组下发展。

One of the most important decisions is whether a project should be structured as a superbuild or as a regular project. The two are fundamentally different and have their own strengths and weaknesses. The decision largely comes down to how the project wants to treat its dependencies and whether there is a desire and opportunity to absorb them directly or keep them isolated in their own sub-builds. For those projects without any dependencies (and importantly without any future prospect of ever having any dependencies), a regular project is the obvious choice. But when there are dependencies, the right project structure can be the difference between fighting against the build and having it work smoothly. 【译】最重要的决定之一是，一个项目应该被构建为超级建筑还是常规项目。两者根本不同，各有优缺点。这个决定在很大程度上取决于项目希望如何处理其依赖关系，以及是否有意愿和机会直接吸收它们，或者将它们隔离在自己的子构建中。对于那些没有任何依赖关系的项目（重要的是，没有任何未来可能有任何依赖关系），常规项目是显而易见的选择。但是，当存在依赖关系时，正确的项目结构可能是对抗构建和使其顺利工作之间的区别。

One of the most common topics that comes up on mailing lists, issue trackers and Q&A sites relates to problems stemming from trying to use one project structure but expecting it to have the capabilities of another. In many cases, this arises because a project is started with a particular structure, but then as dependencies are added, that structure no longer supports what the developer wants the project to be able to do. Those involved have become accustomed to working with the existing structure, so changing it will likely be very disruptive and will often meet with considerable resistance. The older a project is, the harder such a change is likely be. Therefore, decide how dependencies should be handled early in the life of the project, with due consideration for future expectations. 【译】邮件列表、问题跟踪器和问答网站上出现的最常见主题之一与试图使用一种项目结构但期望它具有另一种结构的功能而产生的问题有关。在许多情况下，这是因为一个项目是从一个特定的结构开始的，但随着依赖关系的增加，该结构不再支持开发人员希望项目能够做的事情。相关人员已经习惯了使用现有的结构，因此更改它可能会非常具有破坏性，并且经常会遇到相当大的阻力。项目越老，这种更改就越难。因此，在项目生命周期的早期决定如何处理依赖关系，并适当考虑未来的期望。

## 28.1. Superbuild Structure

Where dependencies do not use CMake as their build system, a superbuild tends to be the preferred structure. This treats each dependency as its own separate build, with the main project directing the overall sequence and the way details are passed from one dependency’s build to another. Each separate build is added to the main build using ExternalProject. Such an arrangement allows CMake to look at what each build produces and automatically detect information that can then be passed on to other dependencies, thereby avoiding having to manually hard code that information in the main build. Even if all the dependencies use CMake, a superbuild may still be preferred for other reasons, such as to avoid target name clashes or problems with projects that assume they are always the top level project. 【译】如果依赖项不使用CMake作为其构建系统，则超级构建往往是首选结构。这将每个依赖关系视为其自己的独立构建，主项目指导整体顺序以及细节从一个依赖关系的构建传递到另一个的方式。使用ExternalProject将每个单独的构建添加到主构建中。这样的安排允许CMake查看每个构建生成的内容，并自动检测可以传递给其他依赖项的信息，从而避免在主构建中手动硬编码这些信息。即使所有依赖项都使用CMake，出于其他原因，超级构建可能仍然是首选，例如避免目标名称冲突或假设它们始终是顶级项目的项目问题。

A superbuild allows precise control over the sequencing of the separate dependency builds. For example, one or more dependencies can be required to fully complete their own build, including their install step, before other dependencies run their own configuration phase. For such an example, the later configuration steps can see the installed artifacts and work out the appropriate file names, locations, etc. automatically. This is not possible in a regular build.

【译】超级构建允许精确控制单独依赖构建的顺序。例如，在其他依赖项运行自己的配置阶段之前，可能需要一个或多个依赖项来完全完成自己的构建，包括安装步骤。对于这样的示例，后续的配置步骤可以查看已安装的工件，并自动计算出相应的文件名、位置等。这在常规构建中是不可能的。

Superbuilds can be implemented with a top level CMakeLists.txt file that follows a fairly predictable pattern. One variation uses a common install area for all dependencies, while another installs each dependency to their own separate install area. While both are similar, using a common install area is slightly simpler to define: 【译】超级构建可以通过遵循相当可预测模式的顶级CMakeLists.txt文件来实现。一种变体为所有依赖项使用一个公共安装区域，而另一种变体将每个依赖项安装到自己的单独安装区域。虽然两者相似，但使用共同的安装区域定义起来稍微简单一些：

\#------------------------------------\>\>\>\>\>\>

cmake_minimum_required(VERSION 3.0)

project(SuperbuildExample)

include(ExternalProject)

set(installDir \${CMAKE_CURRENT_BINARY_DIR}/install)

ExternalProject_Add(someDep1 ①

...

INSTALL_DIR \${installDir}

CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=\<INSTALL_DIR\>

)

ExternalProject_Add(someDep2

...

INSTALL_DIR \${installDir}

CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=\<INSTALL_DIR\>

-DCMAKE_PREFIX_PATH:PATH=\<INSTALL_DIR\> ② )

ExternalProject_Add_StepDependencies(someDep2 configure someDep1) ③

\#------------------------------------\<\<\<\<\<\<

① At least one dependency must require no others.【译】至少有一个依赖关系不需要其他依赖关系。

② For other dependencies that use find_package() to locate their dependencies, setting CMAKE_PREFIX_PATH to the common install directory is typically enough. 【译】对于使用find_package（）定位其依赖关系的其他依赖关系，将CMAKE_PREFIX_PATH设置为通用安装目录通常就足够了。

③ A step dependency is added to ensure the configure step only runs after other required dependencies have been installed.【译】添加了一个步骤依赖关系，以确保配置步骤仅在安装了其他所需的依赖关系后运行。

If each dependency should be installed to its own install area, the only difference to the above is that the CMAKE_PREFIX_PATH given to later dependencies may need to be a list of all previous dependencies’ install directories instead of just a single common install directory.【译】如果每个依赖项都应该安装到自己的安装区域，与上述内容的唯一区别是，提供给后续依赖项的CMAKE_PREFIX_PATH可能需要是所有先前依赖项的安装目录列表，而不仅仅是一个通用安装目录。

If a dependency doesn’t use CMake as its build system, the overall structure doesn’t change, only the way the dependency’s build details are defined. For instance, a dependency that uses a build system like autotools might instead be specified like so:【译】如果依赖项不使用CMake作为其构建系统，则整体结构不会改变，只会改变定义依赖项构建细节的方式。例如，使用像autotools这样的构建系统的依赖关系可能会这样指定：

\`\`\`cmake

ExternalProject_Add(someDep3

INSTALL_DIR \${installDir}

CONFIGURE_COMMAND \<SOURCE_DIR\>/configure --prefix \<INSTALL_DIR\>

...

)

\`\`\`

Other options might also need to be passed to such a configure script to tell it in more specific ways where to find its dependencies. This will obviously vary based on the dependency’s configuration capabilities.【译】其他选项也可能需要传递给这样的配置脚本，以更具体的方式告诉它在哪里找到依赖关系。这显然会根据依赖关系的配置能力而有所不同。

Packaging is a little less straightforward in superbuilds. In some respects, each dependency is really in control of its own packaging, so the top level project is ultimately unlikely to be packaging anything. Instead, one or more of the ExternalProject_Add() calls is likely to be given a custom packaging step, if indeed packaging needs to be supported at all. The previous chapter demonstrated how to implement this with ExternalProject_Add_Step() function like so (a similar approach can be used for non-CMake sub-projects):【译】在超级建筑中，包装有点不那么简单。在某些方面，每个依赖项都真正控制着自己的打包，因此顶级项目最终不太可能打包任何东西。相反，如果确实需要支持打包，则可能会给一个或多个ExternalProject_Add（）调用一个自定义打包步骤。上一章演示了如何使用ExternalProject_Add_Step（）函数实现这一点（类似的方法可用于非CMake子项目）：

\#------------------------------------\>\>\>\>\>\>

ExternalProject_Add_Step(myProj package

COMMAND \${CMAKE_COMMAND} --build \<BINARY_DIR\> --target package

DEPENDEES build

ALWAYS YES

EXCLUDE_FROM_MAIN YES

)

ExternalProject_Add_StepTargets(myProj package)

\#------------------------------------\<\<\<\<\<\<

In general, the key thing to keep in mind is that superbuilds work well when all they do is bring together other external projects. They usually rely on all the external projects having well defined install rules and each of the projects should ideally be able to find their own dependencies if made aware of the location of the other external projects. If any of these things are not true, then the top level project will inevitably end up having to hard code platform specific details about one or more of the projects, at which point the benefits of a superbuild start decreasing.

【译】一般来说，要记住的关键是，当超级建筑所做的只是将其他外部项目整合在一起时，它们的工作效果很好。它们通常依赖于所有具有明确安装规则的外部项目，如果知道其他外部项目的位置，每个项目理想情况下都应该能够找到自己的依赖关系。如果这些事情中的任何一件都不是真的，那么顶级项目最终将不可避免地不得不对一个或多个项目的特定平台细节进行硬编码，此时超级构建的好处开始减少。

## 28.2. Non-superbuild Structure

If a project has no dependencies or if dependencies are being brought into the main build using FetchContent or a mechanism like git submodules, then some forward planning will help avoid difficulties later. A practice which really helps a project to remain easy to understand and work with is to think of its top level CMakeLists.txt as more like a table of contents. The structure can be divided up into the following sections:【译】如果一个项目没有依赖关系，或者使用FetchContent或git子模块等机制将依赖关系引入主构建中，那么一些前瞻性规划将有助于避免以后的困难。一种真正有助于项目保持易于理解和使用的做法是，将其顶级CMakeLists.txt视为更像一个目录。该结构可分为以下部分：

\#\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

**\#(1)Preamble**

This includes the most basic setup, such as the calls to cmake_minimum_required() and project(). It may also include some use of the FetchContent module to bring in things like toolchain files and CMake helper repositories. This section should typically be quite short.【译】这包括最基本的设置，例如调用cmake_minimum_required（）和project（）。它还可能包括对FetchContent模块的一些使用，以引入工具链文件和CMake辅助存储库等。这一节通常应该很短。

**\#(2)Project wide setup**

This high level section would do things like set some global properties and default variables, perhaps define some build options in the CMake cache and may include a small amount of logic to work out some things needed by the whole build. Setting default language standards, build types and various search paths is common in this section.【译】这个高级部分将做一些事情，比如设置一些全局属性和默认变量，也许在CMake缓存中定义一些构建选项，并可能包含少量逻辑来解决整个构建所需的一些问题。设置默认语言标准、构建类型和各种搜索路径在本节中很常见。

**\#(3)Dependencies**

Bring in external dependencies so that they are available to the rest of the project. Rather than defining these in the top level CMakeLists.txt file, putting them in a dedicated directory is cleaner and has robustness advantages.【译】引入外部依赖项，以便它们可用于项目的其他部分。与其在顶级CMakeLists.txt文件中定义这些，不如将它们放在专用目录中更清晰，并且具有健壮性优势。

**\#(4)Main build targets**

This section should ideally just be one or more add_subdirectory() calls.【译】理想情况下，此部分应该只是一个或多个add_subdirectory（）调用。

**\#(5)Tests**

While unit tests may be embedded within the same directory structure as the main sources, integration tests may sit outside of this in their own separate area. These would be added after the main build targets.【译】虽然单元测试可能嵌入到与主源代码相同的目录结构中，但集成测试可能位于其单独的区域之外。这些将在主要构建目标之后添加。

**\#(6)Packaging**

This should generally be the last thing the project defines, again ideally in its own subdirectory to help keep the top level uncluttered.【译】这通常应该是项目定义的最后一件事，最好是在它自己的子目录中，以帮助保持顶层整洁。

\#\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

The recurring pattern in the above is that apart from the preamble and project wide setup, most things are best defined in subdirectories added via add_subdirectory(). Not only does this make the top level CMakeLists.txt file easy to read and understand, it allows each subdirectory to focus on a particular area. This helps make things easier to find and it also means directory scopes can be used to minimize exposing variables from unrelated areas to things that don’t need know about them. An example of a simple top level CMakeLists.txt that follows the above guidelines might look like this:【译】上面反复出现的模式是，除了前导码和项目范围内的设置外，大多数东西最好在通过add_subdirectory（）添加的子目录中定义。这不仅使顶级CMakeLists.txt文件易于阅读和理解，还允许每个子目录专注于特定区域。这有助于使事情更容易找到，也意味着目录作用域可用于最大限度地减少将无关区域的变量暴露给不需要了解它们的东西。遵循上述准则的简单顶级CMakeLists.txt示例可能如下：

\#------------------------------------\>\>\>\>\>\>

\# Preamble

cmake_minimum_required(VERSION 3.1)

project(MyProj)

enable_testing()

\# Project wide setup

list(APPEND CMAKE_MODULE_PATH \${CMAKE_CURRENT_LIST_DIR}/cmake)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_CXX_STANDARD_REQUIRED YES)

set(CMAKE_CXX_EXTENSIONS NO)

\# Externally provided content

add_subdirectory(dependencies)

\# Main targets built by this project

add_subdirectory(src)

\# Things typically only needed if we are the top level project

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

add_subdirectory(tests)

add_subdirectory(packaging)

endif()

\#------------------------------------\<\<\<\<\<\<

In practice, the project wide setup will likely contain more than shown above and there may be other directories for things built by the project (e.g. for documentation, adding other installable content such as scripts, images and so on).【译】在实践中，项目范围内的设置可能会包含比上面显示的更多的内容，并且可能还有其他目录用于项目构建的内容（例如，用于文档、添加其他可安装内容，如脚本、图像等）。

If following the above advice about defining most things in subdirectories, the top directory of the project’s source tree will typically contain mostly just administrative files. These might include a readme file of some kind, license details, contribution instructions and so on. Continuous integration systems also frequently look for a particular file name in the top level directory. Keeping source files out of this top level directory ensures that it remains focused on the high level description of the project.【译】如果遵循上述关于在子目录中定义大多数内容的建议，项目源代码树的顶部目录通常只包含管理文件。这些可能包括某种自述文件、许可证详细信息、贡献说明等。持续集成系统也经常在顶级目录中查找特定的文件名。将源文件放在这个顶级目录之外，可以确保它仍然专注于项目的高级描述。

Delegating the dependency handling to its own subdirectory achieves a couple of important things. Firstly, it ensures that no dependency can ever see CMAKE_SOURCE_DIR and CMAKE_CURRENT_SOURCE_DIR as being equal, so they can rely on comparing these two variables to detect if they are being incorporated into a larger project structure or they are being built standalone. The simple example above shows how this is frequently used to avoid defining tests and packaging details when the project is not the top level project. Placing all dependency handling in its own subdirectory also ensures that no non-cache variables used to set up the dependencies can bleed out to other parts of the build accidentally. A beneficial consequence of this is that it also tends to encourage the use of CMake targets rather than variables as the means by which the rest of the project makes use of dependencies.【译】将依赖关系处理委托给它自己的子目录可以实现几个重要的事情。首先，它确保没有依赖关系可以看到CMAKE_SOURCE_DIR和CMAKE_CURRENT_SOURCE_DIR是相等的，因此它们可以依靠比较这两个变量来检测它们是被合并到更大的项目结构中还是被独立构建。上面的简单示例显示了当项目不是顶级项目时，如何经常使用它来避免定义测试和打包细节。将所有依赖关系处理放在自己的子目录中还可以确保用于设置依赖关系的非缓存变量不会意外泄露到构建的其他部分。这样做的一个有益结果是，它还倾向于鼓励使用CMake目标而不是变量作为项目其余部分使用依赖关系的手段。

An example using the FetchContent module to incorporate the project’s dependencies into the build might look like this:【译】使用FetchContent模块将项目的依赖关系合并到构建中的示例可能如下：

\#--------#*dependencies/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

include(FetchContent)

\# Declare all the dependency details first in case any dependency wants

\# to pull in some of the same ones (this keeps us in control)

FetchContent_Declare(jerry ...)

FetchContent_Declare(foo ...)

FetchContent_Declare(bar ...)

\# Add each dependency if not already part of the build

FetchContent_GetProperties(foo)

if(NOT foo_POPULATED)

FetchContent_Populate(foo)

add_subdirectory(\${foo_SOURCE_DIR} \${foo_BINARY_DIR})

endif()

FetchContent_GetProperties(bar)

if(NOT bar_POPULATED)

FetchContent_Populate(bar)

add_subdirectory(\${bar_SOURCE_DIR} \${bar_BINARY_DIR})

endif()

\#------------------------------------\<\<\<\<\<\<

Sometimes, a dependency may require setting certain variables before calling add_subdirectory(). Ideally, this would be done in its own scope so that it can’t affect other dependencies added later in the same scope. It can therefore be useful to put each dependency population in its own subdirectory too, which would leave the above example looking like this:【译】有时，依赖关系可能需要在调用add_subdirectory（）之前设置某些变量。理想情况下，这将在它自己的范围内完成，这样它就不会影响后来在同一范围内添加的其他依赖关系。因此，将每个依赖群体放在自己的子目录中也是有用的，这将使上述示例看起来像这样：

\#-----# *dependencies/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

include(FetchContent)

FetchContent_Declare(jerry ...)

FetchContent_Declare(foo ...)

FetchContent_Declare(bar ...)

add_subdirectory(foo)

add_subdirectory(bar)

\#------------------------------------\<\<\<\<\<\<

The subdirectories would then look something like this:【译】子目录看起来像这样：

\#------# *dependencies/foo/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

FetchContent_GetProperties(foo)

if(NOT foo_POPULATED)

FetchContent_Populate(foo)

\# Add any customizations needed before actually pulling in the dependency.

\# For example, build static libs by default and only build those targets

\# that another target depends on.

set(BUILD_SHARED_LIBS NO)

set_directory_properties(PROPERTIES EXCLUDE_FROM_ALL YES)

\# Now add the dependency

add_subdirectory(\${foo_SOURCE_DIR} \${foo_BINARY_DIR})

endif()

\#------------------------------------\<\<\<\<\<\<

The bar subdirectory would be similar in structure. The above can even be extended to handle either a pre-built binary package or a source package:【译】bar子目录的结构类似。上述内容甚至可以扩展到处理预构建的二进制包或源代码包：

\#------------------------------------\>\>\>\>\>\>

FetchContent_GetProperties(foo)

if(NOT foo_POPULATED)

FetchContent_Populate(foo)

> if(EXISTS \${foo_SOURCE_DIR}/CMakeLists.txt)
>
> \# Probably source, but could still be a binary package that
>
> \# provides itself through a top level CMakeLists.txt file
>
> add_subdirectory(\${foo_SOURCE_DIR} \${foo_BINARY_DIR})
>
> else()
>
> \# Must be a binary package, assume it provides a config file in a
>
> \# standard location within its directory layout
>
> find_package(foo REQUIRED
>
> NO_DEFAULT_PATH
>
> PATHS \${foo_SOURCE_DIR}
>
> )
>
> \# For this to be useful, imported targets must be promoted to global
>
> \# so that other parts of the project can access them
>
> set_target_properties(foo::foo PROPERTIES IMPORTED_GLOBAL TRUE)
>
> endif()

endif()

\#------------------------------------\<\<\<\<\<\<

The FetchContent module and the IMPORTED_GLOBAL target property are only available from CMake 3.11 onward. Adding dependencies without these features is much harder and requires compromising on some of the recommended principles or foregoing the possibility of adding prebuilt binary packages. Without being able to promote local targets to global, alternative methods generally rely on passing details back to the main build via variables or global targets have to be defined to act as proxies for local imported ones. A less desirable approach adds dependencies directly from the top level CMakeLists.txt file, but that makes the project hard to incorporate into a larger project hierarchy. If pre-built binary packages do not need to be supported, then the IMPORTED_GLOBAL target property isn’t needed and these alternative methods can usually be avoided. For supporting CMake versions before 3.11, techniques like git submodules or file(DOWNLOAD) might be alternatives to the FetchContent module.【译】FetchContent模块和IMPORTED_GLOBAL目标属性仅在CMake 3.11之后可用。添加没有这些功能的依赖项要困难得多，需要在一些推荐的原则上做出妥协，或者放弃添加预构建二进制包的可能性。由于无法将本地目标提升为全局目标，替代方法通常依赖于通过变量将细节传递回主构建，或者必须定义全局目标作为本地导入目标的代理。一种不太理想的方法是直接从顶级CMakeLists.txt文件添加依赖项，但这使得项目难以整合到更大的项目层次结构中。如果不需要支持预构建的二进制包，则不需要IMPORTED_GLOBAL目标属性，通常可以避免这些替代方法。为了支持3.11之前的CMake版本，git子模块或文件（下载）等技术可能是FetchContent模块的替代方案。

Of the other main project’s top level subdirectories, adding tests and packaging doesn’t require anything special, they should just follow the recommended practices already covered in the preceding chapters. The contents and structure of the tests subdirectory will be specific to the project, while packaging typically only needs a CMakeLists.txt file and maybe a few other files to be configured into the build directory for use by cpack. It may also contain resources uses by some of the package generators. The structure of the src directory is a larger topic covered in its own section in Section 28.5, “Defining Targets” further below.【译】在其他主项目的顶级子目录中，添加测试和打包不需要任何特殊的东西，它们应该遵循前面章节中已经介绍过的推荐做法。tests子目录的内容和结构将特定于项目，而打包通常只需要一个CMakeLists.txt文件，可能还需要一些其他文件配置到构建目录中供cpack使用。它还可能包含一些包生成器使用的资源。src目录的结构是一个更大的主题，将在下面第28.5节“定义目标”中单独讨论。

## 28.3. Common Top Level Subdirectories

The previous section already mentioned some directory names commonly found as subdirectories immediately below the top of the source tree. Expanding that list to cover other frequently used directories gives the following: 【译】上一节已经提到了一些目录名，这些目录名通常位于源代码树顶部下方的子目录中。将该列表扩展到其他常用目录，可以得到以下结果：

• cmake

• dependencies

• doc

• src

• tests

• packaging

In the absence of any other existing conventions, projects are encouraged to use these same directory names. Collecting CMake helper scripts in a cmake subdirectory makes them easy to find, allowing developers to browse through the contents of that directory and discover useful utilities they may otherwise not have known about. A single list(APPEND CMAKE_MODULE_PATH …) call in the project wide setup section of the top level CMakeLists.txt also makes them available to the entire project. The doc subdirectory can be a convenient place to collect documentation, which can be useful if using formats like Markdown or Asciidoc and files contain relative links to each other.【译】在没有任何其他现有约定的情况下，鼓励项目使用这些相同的目录名。在CMake子目录中收集CMake辅助脚本使其易于查找，允许开发人员浏览该目录的内容，并发现他们可能不知道的有用实用程序。顶层CMakeLists.txt的项目范围设置部分中的单个列表（APPEND CMAKE_MODULE_PATH…）调用也使它们可用于整个项目。doc子目录是一个收集文档的方便地方，如果使用Markdown或Asciidoc等格式，并且文件包含相互之间的相对链接，这可能会很有用。

There are a few subdirectory names that projects should avoid. By default, calling add_subdirectory() with just a single argument will result in a corresponding directory of the same name in the build directory. The project should avoid using a source directory name that may result in a clash with one of the pre-defined directories created in the build area. Names to avoid include the following: 【译】项目应该避免使用一些子目录名称。默认情况下，仅使用一个参数调用add_subdirectory（）将在构建目录中产生一个同名的相应目录。项目应避免使用可能导致与构建区域中创建的预定义目录之一冲突的源目录名称。应避免的名称包括以下内容：

• Testing

• CMakeFiles

• CMakeScripts

• Any of the default build types (i.e. any of the values of CMAKE_CONFIGURATION_TYPES).

• Any directory name starting with an underscore.

Since some file systems may be case insensitive, all of the above names should not be used in any upper/lowercase combination. Other common directory names used as install destinations may also appear in the build directory depending on the strategy used for built binary locations (discussed further below in Section 28.5.2, “Target Outputs”). Therefore, it would also be wise to avoid source directory names like bin, lib, share, man and so on.【译】由于某些文件系统可能不区分大小写，因此不应以任何大小写组合使用上述所有名称。根据用于构建二进制位置的策略，用作安装目标的其他常见目录名也可能出现在构建目录中（下文第28.5.2节“目标输出”将进一步讨论）。因此，避免使用bin、lib、share、man等源目录名称也是明智之举。

A few projects choose to define a top level include directory and collect public headers there rather than keeping them next to their associated implementation files. Be aware that some IDE tools may be unable to find headers automatically if they are split out like this, so such an arrangement may be less convenient for some developers. It also tends to make changes for a particular feature or bug fix less localized. On the other hand, a dedicated include directory clearly communicates which headers are intended to be public and they can have the same directory structure as they would when installed. Both approaches have their merits, but keeping headers with their associated implementation files is perhaps a little simpler for new developers.

【译】一些项目选择定义一个顶级包含目录并在那里收集公共标头，而不是将它们放在相关的实现文件旁边。请注意，如果像这样拆分，一些IDE工具可能无法自动找到头文件，因此这种安排对一些开发人员来说可能不太方便。它还倾向于使特定功能或错误修复的更改不那么本地化。另一方面，专用的include目录清楚地传达了哪些标头是公共的，它们可以具有与安装时相同的目录结构。这两种方法都有其优点，但对于新开发人员来说，将头文件与其相关的实现文件一起保存可能会简单一些。

## 28.4. IDE Projects

When using project generators such as Xcode or Visual Studio, a project or solution file is created at the top of the build directory. This can be opened in the IDE just like any other project file for that application, but it is still under the control of CMake. Importantly, these project files are generated as part of the build, so they should not be checked into a version control system. Also note that changes made to the project from within the IDE will be lost the next time CMake runs.

【译】使用Xcode或Visual Studio等项目生成器时，会在构建目录的顶部创建项目或解决方案文件。这可以在IDE中打开，就像该应用程序的任何其他项目文件一样，但它仍然在CMake的控制之下。重要的是，这些项目文件是作为构建的一部分生成的，因此不应将其签入版本控制系统。另请注意，下次运行CMake时，从IDE中对项目所做的更改将丢失。

Because the Xcode or Visual Studio project files are generated by CMake, this means the way the project’s targets and files are presented in the project hierarchy or file tree are also under the CMake project’s control. CMake provides a number of properties that can influence how targets and files are grouped and labelled in some IDE environments. The first level of grouping is for targets, which can be enabled by setting the USE_FOLDERS global property to true. The location of each target can then be specified using the FOLDER target property, which holds a case sensitive name under which to place that target. To create a tree-like hierarchy, forward slashes can be used to separate the nesting levels. If the FOLDER property is empty or not set, the target is left ungrouped at the top level of the project. Both the Xcode and the Visual Studio generators honor the FOLDER target property.【译】因为Xcode或Visual Studio项目文件是由CMake生成的，这意味着项目的目标和文件在项目层次结构或文件树中的呈现方式也受CMake项目的控制。CMake提供了许多属性，这些属性可以影响目标和文件在某些IDE环境中的分组和标记方式。第一级分组是针对目标的，可以通过将USE_FOLDERS全局属性设置为true来启用。然后，可以使用FOLDER target属性指定每个目标的位置，该属性包含一个区分大小写的名称，用于放置该目标。要创建树状层次结构，可以使用正斜杠来分隔嵌套级别。如果FOLDER属性为空或未设置，则目标在项目的顶层将保持未分组状态。Xcode和Visual Studio生成器都尊重FOLDER目标属性。

\#------------------------------------\>\>\>\>\>\>

set_property(GLOBAL PROPERTY USE_FOLDERS YES)

add_executable(foo ...)

add_executable(bar ...)

add_executable(test_foo ...)

add_executable(test_bar ...)

set_target_properties(foo bar PROPERTIES FOLDER "Main apps")

set_target_properties(test_foo test_bar PROPERTIES FOLDER "Main apps/Tests")

\#------------------------------------\<\<\<\<\<\<

Up to CMake 3.11, the FOLDER target propert is empty by default, whereas from CMake 3.12, it is initialized from the value of the CMAKE_FOLDER variable.【译】在CMake 3.11之前，默认情况下FOLDER目标属性为空，而从CMake 3.12开始，它是从CMake_FOLDER变量的值初始化的。

The name displayed for the target itself within the IDE defaults to the same target name that CMake uses. Visual Studio generators allow this display name to be overridden by setting the PROJECT_LABEL target property, but the Xcode generator does not honor this setting.【译】IDE中为目标本身显示的名称默认为CMake使用的相同目标名称。Visual Studio生成器允许通过设置PROJECT_LABEL目标属性来覆盖此显示名称，但Xcode生成器不接受此设置。

\`\`\`cmake

set_target_properties(foo PROPERTIES PROJECT_LABEL "Foo Tastic")

\`\`\`

Some targets are created by CMake itself, such as for installing, packaging, running tests and so on.For Xcode, most of these are not shown in the file/target tree, but for Visual Studio they are grouped under a folder called CMakePredefinedTargets by default. This can be overridden with the PREDEFINED_TARGETS_FOLDER global property, but there is usually little reason to do so.

【译】一些目标是由CMake本身创建的，例如用于安装、打包、运行测试等。对于Xcode，这些目标大多不显示在文件/目标树中，但对于Visual Studio，默认情况下它们被分组在一个名为CMakePrefinedTargets的文件夹下。这可以用PREDEFINED_TARGETS_FOLDER全局属性覆盖，但通常没有什么理由这样做。

The grouping of individual files under each target can also be controlled by the CMake project. This is done using the source_group() command and is independent of the target folder grouping (i.e. it is always supported, even if the USE_FOLDERS global property is false or unset). The command has two forms, the first of which is used to define a single group: 【译】每个目标下单个文件的分组也可以由CMake项目控制。这是使用source_group（）命令完成的，并且独立于目标文件夹分组（即，即使USE_FOLDERS全局属性为false或未设置，也始终支持它）。该命令有两种形式，第一种用于定义单个组：

\`\`\`cmake

source_group(group

\[FILES src...\]

\[REGULAR_EXPRESSION regex\]

)

\`\`\`

The group can be a simple name under which to group the relevant files, or it can specify a hierarchy similar to that for targets. Be aware, however, that for historical reasons, nesting levels are defined by back slashes rather than forward slashes. To get through CMake’s parsing correctly, back slashes must be escaped, so a group foo with a nested bar underneathe it would be specified like so: 【译】该组可以是一个简单的名称，用于对相关文件进行分组，也可以指定一个类似于目标的层次结构。然而，请注意，由于历史原因，嵌套级别是由反斜杠而不是正斜杠定义的。为了正确完成CMake的解析，必须转义反斜杠，因此下面带有嵌套条的组foo将按如下方式指定：

\`\`\`cmake

source_group(foo\\bar ...)

\`\`\`

Individual files can be specified with the FILES argument, with relative paths assumed to be relative to CMAKE_CURRENT_SOURCE_DIR. Because the command is not specific to a target, this option is the way to ensure only specific files are affected by the grouping. If the project wants to define a grouping structure that should be applied more generally, the REGULAR_EXPRESSION option is more appropriate. It can be used to effectively set up grouping rules that will be applied to all targets in the project. Where a particular file could match more than one grouping, a FILES entry takes precedence over a REGULAR_EXPRESSION and REGULAR_EXPRESSION groups defined later take precedence over those defined earlier where a file matches multiple regular expressions. 【译】可以使用files参数指定单个文件，并假设相对路径相对于CMAKE_CURRENT_SOURCE_DIR。由于该命令不特定于目标，因此此选项是确保只有特定文件受分组影响的方法。如果项目想要定义一个更通用的分组结构，那么REGULAR_EXPRESSION选项更合适。它可用于有效地设置将应用于项目中所有目标的分组规则。如果特定文件可以匹配多个分组，则FILES条目优先于REGULAR_EXPRESSION，稍后定义的REGULAR_REPRESSION组优先于之前定义的文件匹配多个正则表达式的组。

The following example sets up general rules for all targets such that files with commonly used source and header file extensions will be grouped under Sources. Test sources and headers will override that grouping and be placed under a Tests group instead, while the special case special.cxx will be put in its own dedicated subgroup below Sources. 【译】以下示例为所有目标设置了通用规则，以便将具有常用源文件和头文件扩展名的文件分组到“源”下。测试源和标头将覆盖该分组，并放置在Tests组下，而特殊情况special.cxx将放置在sources下方的专用子组中。

\#------------------------------------\>\>\>\>\>\>

source_group(Sources REGULAR_EXPRESSION "\\.(c(xx\|pp)?\|hh?)\$")

source_group(Tests REGULAR_EXPRESSION "test.\*") \# Overrides the above

source_group(Sources\\Special FILES special.cxx) \# Overrides both of the above

\#------------------------------------\<\<\<\<\<\<

CMake provides default groups Source Files for sources and Header Files for headers, but these are easily overridden, as the above example demonstrates. Other default groups such as Resources and Object Files are also defined. 【译】CMake为源代码提供了默认组“源文件”，为标头提供了“头文件”，但这些组很容易被覆盖，如上例所示。还定义了其他默认组，如资源和对象文件。

The second form of the source_group() command allows the group hierarchy to follow the directory structure for specific files. It is available with CMake 3.8 or later. 【译】source_group（）命令的第二种形式允许组层次结构遵循特定文件的目录结构。它可在CMake 3.8或更高版本中使用。

\`\`\`cmake

source_group(TREE root

\[PREFIX prefix\]

\[FILES src...\]

)

\`\`\`

The TREE option directs the command to group the specified files according to their own directory structure below root. The PREFIX option can be used to place that grouping structure under the prefix parent group or group hierarchy. This can be used very effectively in conjunction with the SOURCES target property to reproduce the directory structure of all sources that make up a target, but only if all of those sources are below a common point (e.g. no generated sources from the build directory). Many targets satisfy these conditions, so the following example pattern can often be used to quickly and easily give some structure to the way a target is presented in an IDE. 【译】TREE选项指示命令根据根目录下的目录结构对指定文件进行分组。PREFIX选项可用于将该分组结构放置在前缀父组或组层次结构下。这可以非常有效地与SOURCES target属性结合使用，以再现构成目标的所有源的目录结构，但前提是所有这些源都低于一个公共点（例如，构建目录中没有生成的源）。许多目标满足这些条件，因此以下示例模式通常可用于快速轻松地为IDE中呈现目标的方式提供一些结构。

\#------------------------------------\>\>\>\>\>\>

\# Only suitable if SOURCES does not contain generated files in this example

get_target_property(sources someTarget SOURCES)

source_group(TREE \${CMAKE_CURRENT_SOURCE_DIR}

PREFIX "Magic\\Sources"

FILES \${sources}

)

\#------------------------------------\<\<\<\<\<\<

IDEs generally only show files that are explicitly added as sources of a target. If a target is defined with only its implementation files added as sources, its headers won’t usually appear in the IDE file lists. Therefore, it is common practice to explicitly list headers as well, even though they won’t actually be compiled. CMake will effectively just ignore them other than to add them to IDE source file lists. This extends to more than just header files, it can also be used to add other non-compiled files as well, such as images, scripts and other resources. Some features such as those associated with the MACOSX_PACKAGE_LOCATION source property require a file to be listed as a source file to have any effect. 【译】IDE通常只显示明确添加为目标源的文件。如果一个目标被定义为仅将其实现文件添加为源，则其标头通常不会出现在IDE文件列表中。因此，通常的做法是显式列出标头，即使它们实际上不会被编译。CMake将有效地忽略它们，而不是将它们添加到IDE源文件列表中。这不仅扩展到头文件，还可以用于添加其他未编译的文件，如图像、脚本和其他资源。某些功能（如与MACOSX_PACKAGE_LOCATION源属性关联的功能）需要将文件列为源文件才能生效。

In certain situations, it may be desirable for a source file to appear in IDE file lists but not be compiled. Platform-specific files that should only be compiled and linked on other target platforms are an example of this. To prevent CMake from trying to compile a particular file, that source file’s HEADER_FILE_ONLY source property can be set to true (do not be confused by the property name, it can be used for more than just headers). 【译】在某些情况下，可能希望源文件出现在IDE文件列表中，但不进行编译。仅应在其他目标平台上编译和链接的特定于平台的文件就是一个例子。为了防止CMake尝试编译特定文件，可以将源文件的HEADER_file_ONLY源属性设置为true（不要被属性名混淆，它不仅可以用于头文件）。

\#------------------------------------\>\>\>\>\>\>

add_executable(myApp main.cpp net.cpp net_win.cpp)

if(NOT WIN32)

\# Don't need to compile this file for non-Windows platforms

set_source_files_properties(net_win.cpp PROPERTIES

HEADER_FILE_ONLY YES

)

endif()

\#------------------------------------\<\<\<\<\<\<

## 28.5. Defining Targets

The preceding chapters have presented a range of CMake features that allow a target to be defined in detail. This includes the sources and other files that a target is built up from, how a target should be built and how a target interacts with other targets. The focus of this section is to demonstrate how to use these techniques in a way that makes the project easy to understand, produces a robust build, provides flexibility and promotes maintainability. 【译】前面的章节介绍了一系列CMake特性，这些特性允许详细定义目标。这包括构建目标的源和其他文件、如何构建目标以及目标如何与其他目标交互。本节的重点是演示如何使用这些技术，使项目易于理解，生成健壮的构建，提供灵活性并提高可维护性。

For simple projects, the number of source files and targets is likely to be small, in which case it is relatively manageable for all of the relevant details to be given in a single CMakeLists.txt file. If following the project directory structure recommended earlier in this chapter, this would mean the src subdirectory would have no further subdirectories and its CMakeLists.txt file would define all that was needed. Initially, it may look as simple as something like this: 【译】对于简单的项目，源文件和目标的数量可能很小，在这种情况下，在一个CMakeLists.txt文件中给出所有相关细节是相对可控的。如果遵循本章前面推荐的项目目录结构，这意味着src子目录将没有其他子目录，其CMakeLists.txt文件将定义所需的所有内容。起初，它可能看起来像这样简单：

\#------# *src/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

add_executable(planter main.cpp soy.cpp coffee.cpp)

target_compile_definitions(planter PUBLIC COFFEE_FAMILY=Robusta)

add_test(NAME NoArgs COMMAND planter)

add_test(NAME WithArgs COMMAND planter beanType=soy)

\#------------------------------------\<\<\<\<\<\<

This makes a number of assumptions about how the project will be used, but perhaps the biggest ones are that the project won’t be installed or packaged and that it won’t be absorbed into a larger project hierarchy by some other project. These are limitations that can and should be avoided. The specific weaknesses of the simple case above include: 【译】这对项目的使用方式做出了许多假设，但也许最大的假设是项目不会被安装或打包，也不会被其他项目吸收到更大的项目层次结构中。这些是可以而且应该避免的限制。上述简单案例的具体弱点包括：

• The target name is not specific to the project, so if this project was later incorporated into a larger parent project, the target name may clash with targets defined elsewhere. Using a project-specific prefix on the target name is an easy way to address this weakness. 【译】目标名称不是特定于项目的，因此如果此项目后来合并到更大的父项目中，目标名称可能会与其他地方定义的目标冲突。在目标名称上使用特定于项目的前缀是解决这一弱点的一种简单方法。

• There are no install rules, so the target cannot easily be installed or be included in a package. 【译】没有安装规则，因此目标无法轻松安装或包含在包中。

• No namespaced alias target is defined, so even if an install() command was later added and packaging was implemented, other projects would have to use different target names for prebuilt binary versus source inclusion. 【译】没有定义命名空间别名目标，因此即使后来添加了install（）命令并实现了打包，其他项目也必须为预构建的二进制文件和源代码包含使用不同的目标名称。

• The test names are not project specific, so again they may clash with test names of other projects if this one is absorbed into a larger project hierarchy. Again, incorporating the project name or some other equally unique string into the test names would address this. 【译】测试名称不是特定于项目的，因此如果这个项目被吸收到更大的项目层次结构中，它们可能会与其他项目的测试名称发生冲突。同样，将项目名称或其他一些同样唯一的字符串合并到测试名称中可以解决这个问题。

• The tests are always added, even if this is not the top level project. For large projects with many tests, this can noticably and unnecessarily increase build times. 【译】测试总是被添加的，即使这不是顶级项目。对于具有许多测试的大型项目，这可能会明显和不必要地增加构建时间。

• Headers are not listed as sources, so they won’t show up in some IDEs. 【译】头没有作为源列出，因此它们不会出现在某些IDE中。

Addressing the above points and following the recommended practices of the previous chapters, the example expands out to something more like this:【译】针对上述几点，并遵循前几章的建议做法，该示例扩展到更像这样的内容：

\#-------# *src/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

\#=============================

\# Define targets

\#=============================

add_executable(BagOfBeans_planter main.cpp soy.cpp soy.h coffee.cpp coffee.h)

add_executable(BagOfBeans::BagOfBeans_planter ALIAS BagOfBeans_planter)

set_target_properties(BagOfBeans_planter PROPERTIES OUTPUT_NAME planter)

target_compile_definitions(BagOfBeans_planter PUBLIC COFFEE_FAMILY=Robusta)

\#=============================

\# Testing

\#=============================

add_test(NAME BagOfBeans.planter.NoArgs COMMAND BagOfBeans_planter)

add_test(NAME BagOfBeans.planter.WithArgs COMMAND BagOfBeans_planter beanType=soy)

\#=============================

\# Packaging

\#=============================

include(GNUInstallDirs)

install(TARGETS BagOfBeans_planter

> EXPORT BagOfBeans_apps
>
> DESTINATION \${CMAKE_INSTALL_BINDIR}
>
> COMPONENT BagOfBeans_apps

)

\#------------------------------------\<\<\<\<\<\<

That may be a surprising amount of detail for a fairly simple executable, but it highlights that for real world projects, there’s more to consider than just building a binary in isolation. The added complexity is mostly for longer names to reduce the likelihood of clashes. The addition of packaging logic also tends to add a fair amount of detail that an inexperienced developer probably hasn’t had much exposure to. Adding clear sections to the file as shown above can help make it easier to understand for newer developers and also keep it organized as the project evolves. 【译】对于一个相当简单的可执行文件来说，这可能是一个令人惊讶的细节，但它强调了对于现实世界的项目来说，除了单独构建二进制文件外，还有更多需要考虑的因素。增加的复杂性主要是使用较长的名称来减少冲突的可能性。添加打包逻辑也往往会添加大量细节，而缺乏经验的开发人员可能没有太多接触过这些细节。如上所示，在文件中添加清晰的部分可以帮助新开发人员更容易理解，并随着项目的发展保持其组织性。

### 28.5.1. Target Sources

When the number of source files increases, having them all in the one directory can make them more difficult to work with. This is generally addressed by placing them under subdirectories grouped by functionality, which brings a few other benefits too. Not only does it help keep things from becoming too cluttered, it also makes it easy to turn certain features on and off based on CMake cache options or other configure time logic. For example: 【译】当源文件的数量增加时，将它们全部放在一个目录中会使它们更难使用。这通常是通过将它们放置在按功能分组的子目录下来解决的，这也带来了一些其他好处。它不仅有助于防止事情变得过于混乱，还可以根据CMake缓存选项或其他配置时间逻辑轻松打开和关闭某些功能。例如：

\#------------------------------------\>\>\>\>\>\>

add_executable(BagOfBeans_planter main.cpp)

option(BAGOFBEANS_SOY "Support planting soy beans" ON)

option(BAGOFBEANS_COFFEE "Support planting coffee beans" ON)

if(BAGOFBEANS_SOY)

add_subdirectory(soy)

endif()

if(BAGOFBEANS_COFFEE)

add_subdirectory(coffee)

endif()

\#------------------------------------\<\<\<\<\<\<

In all of the preceding chapters, executables and libraries were always defined in the one directory, so the full list of files could be supplied directly to the add_executable() or add_library() call. In the above arrangement, the subdirectories add sources to the target after it has been defined using the target_sources() command, which is available with CMake 3.1 or later. This command works just like the other target\_…() commands and has a very similar form: 【译】在前面的所有章节中，可执行文件和库始终在一个目录中定义，因此可以直接向add_executable（）或add_library（）调用提供完整的文件列表。在上述安排中，子目录在使用target_source（）命令定义目标后将源添加到目标中，该命令在CMake 3.1或更高版本中可用。此命令的工作方式与其他target\_…（）命令一样，形式非常相似：

\`\`\`cmake

target_sources(targetName

\<PRIVATE\|PUBLIC\|INTERFACE\> src...

\# Repeat with more sections as needed

...

)

\`\`\`

One or more PRIVATE, PUBLIC or INTERFACE sections is provided, each of which lists source files to be added to the relevant target. PRIVATE sources are added to the SOURCES property of targetName, while INTERFACE sources are added to the INTERFACE_SOURCES property. A PUBLIC source is added to both properties. The more practical way of thinking of this is that PRIVATE sources are compiled into targetName, INTERFACE sources are added to anything that links to targetName and PUBLIC sources are added to both. 【译】提供了一个或多个PRIVATE、PUBLIC或INTERFACE部分，每个部分都列出了要添加到相关目标中的源文件。私有源被添加到targetName的sources属性中，而INTERFACE_sources属性中添加了INTERFACE源。PUBLIC源将添加到这两个属性中。更实际的想法是，PRIVATE源代码被编译成targetName，INTERFACE源代码被添加到任何链接到targetName的东西中，PUBLIC源代码被同时添加到两者中。

In practice, anything other than PRIVATE would be unusual, since adding a source file to all targets linking against targetName would have limited usefulness. One could use it to add resources that need to be part of the same translation unit to work, or to embed something that should not be exposed through any inter-library interface, but these situations would be uncommon. 【译】在实践中，除了PRIVATE之外的任何东西都是不寻常的，因为向所有链接到targetName的目标添加源文件的用处有限。人们可以用它来添加需要成为同一翻译单元一部分才能工作的资源，或者嵌入不应该通过任何库间接口公开的东西，但这些情况并不常见。

A peculiarity of the target_sources() command is that if a source is specified with a relative path, that path is assumed to be relative to the source directory of the target it is being added to. This creates a number of problems. The first is that if it were added as an INTERFACE source, then the path would be treated as relative to that other target, not targetName. Clearly this could create incorrect paths, so any non-PRIVATE source must be specified with an absolute path. The second problem is that relative paths behave unintuitively when target_sources() is called from a directory other than the one in which targetName was defined. Consider how the CMakeLists.txt file for one of the directories of the earlier example might be specified: 【译】target_sources（）命令的一个特点是，如果用相对路径指定了一个源，则该路径被假定为相对于它所添加到的目标的源目录。这会产生许多问题。首先，如果将其添加为INTERFACE源，则路径将被视为相对于其他目标，而不是targetName。显然，这可能会创建不正确的路径，因此必须使用绝对路径指定任何非PRIVATE源。第二个问题是，当从定义targetName的目录以外的目录调用target_sources（）时，相对路径的行为不直观。考虑如何指定前面示例中某个目录的CMakeLists.txt文件：

\#-------# *src/coffee/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

target_sources(BagOfBeans_planter

PRIVATE

> \# WARNING: These will be wrong
>
> coffee.cpp
>
> coffee.h

)

...

\#------------------------------------\<\<\<\<\<\<

The above is intended to add the sources from the same directory, but they will be interpreted as being relative to src rather than src/coffee. The most robust way to address this is to prefix them with CMAKE_CURRENT_SOURCE_DIR or CMAKE_CURRENT_LIST_DIR to ensure they always use the correct path. 【译】上述内容旨在添加来自同一目录的源代码，但它们将被解释为相对于src而不是src/coffee。解决此问题的最可靠方法是在它们前面加上CMAKE_CURRENT_SOURCE_DIR或CMAKE_CCURRENT_LIST_DIR，以确保它们始终使用正确的路径。

\#----# *src/coffee/CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

target_sources(BagOfBeans_planter

PRIVATE

\${CMAKE_CURRENT_LIST_DIR}/coffee.cpp

\${CMAKE_CURRENT_LIST_DIR}/coffee.h

)

target_compile_definitions(BagOfBeans_planter

PUBLIC COFFEE_FAMILY=Robusta

)

target_include_directories(BagOfBeans_planter

PUBLIC \$\<BUILD_INTERFACE:\${CMAKE_CURRENT_LIST_DIR}\>

)

\#------------------------------------\<\<\<\<\<\<

Having to prefix each source file with \${CMAKE_CURRENT_LIST_DIR} or \${CMAKE_CURRENT_LIST_DIR} in use cases such as this is inconvenient and not particularly intuitive. Improvement in this area is likely in an upcoming release (the necessary changes have already been made). 【译】在这样的用例中，必须在每个源文件前加上\${CMAKE_CURRENT_LIST_DIR}或\${CMAKE_CURRENT_LIST_DIR}是不方便的，也不是特别直观。这方面的改进可能会在即将发布的版本中进行（已经进行了必要的更改）。

The above also demonstrates how other target\_…() commands can be moved into the subdirectories too, not just target_sources(). This helps keep things local to the code they relate to.For example, compile definitions, compiler flags and header search paths that are specific to a particular feature can be added only if that feature is enabled. If the directory structure needed to be reorganized and this directory moved elsewhere, nothing in this file would need to change and other sources in the target that had \#include "coffee.h" would continue to work unmodified.

【译】上面还演示了如何将其他target\_…（）命令也移动到子目录中，而不仅仅是target_sources（）。这有助于将内容保持在它们所关联的代码的本地。例如，只有启用了特定功能，才能添加特定于该功能的编译定义、编译器标志和标头搜索路径。如果需要重新组织目录结构并将此目录移动到其他位置，则此文件中的任何内容都不需要更改，目标中包含#include“coffee.h”的其他源将继续工作而不进行修改。

The one exception to this localization of details is target_link_libraries(), which can only be used on a target defined in the same directory. This means if a subdirectory needed to make the target link to something, it couldn’t do it from within that subdirectory. The call to target_link_libraries() would have to be made in the same directory as where add_executable() or add_library() was called. If, for example, the BagOfBeans_planter target needed to link against a library called weather, it would have to add the call in src/CMakeLists.txt rather than src/coffee/CMakeLists.txt. This would result in something like the following: 【译】这种细节本地化的一个例外是target_link_libraies（），它只能在同一目录中定义的目标上使用。这意味着，如果一个子目录需要将目标链接到某个内容，则无法从该子目录中完成。对target_link_librarys（）的调用必须在调用add_executable（）或add_library（）的同一目录中进行。例如，如果BagOfBeans_planter目标需要链接到一个名为weather的库，则必须在src/coffee/CMakeLists.txt而不是src/coffee/CMakeLists..txt中添加该调用。这将导致以下结果：

\#------------------------------------\>\>\>\>\>\>

option(BAGOFBEANS_COFFEE "Support planting coffee beans" ON)

if(BAGOFBEANS_COFFEE)

add_subdirectory(coffee)

target_link_libraries(BagOfBeans_planter PRIVATE weather)

endif()

\#------------------------------------\<\<\<\<\<\<

This restriction is under active discussion among the CMake developers and may be removed or at least significantly relaxed in a future CMake version. For CMake versions from 3.1 to 3.12, subdirectories can be fully self contained apart from adding libraries that a target should link to. Before CMake 3.1, a completely different approach was needed which relied on building up lists of sources in a variable and only creating the target once all subdirectories had been added. Such an arrangement might look like this: 【译】CMake开发人员正在积极讨论这一限制，在未来的CMake版本中，这一限制可能会被删除或至少大幅放宽。对于从3.1到3.12的CMake版本，除了添加目标应该链接到的库外，子目录可以完全自给自足。在CMake 3.1之前，需要一种完全不同的方法，即在变量中建立源列表，并在添加所有子目录后才创建目标。这样的安排可能看起来像这样：

\#------------------------------------\>\>\>\>\>\>

\# Pre-CMake 3.1 method, avoid using this approach

unset(planterSources)

unset(planterDefines)

unset(planterOptions)

unset(planterLinkLibs)

\# Subdirs are expected to add to the above variables using PARENT_SCOPE

option(BAGOFBEANS_SOY "Support planting soy beans" ON)

option(BAGOFBEANS_COFFEE "Support planting coffee beans" ON)

if(BAGOFBEANS_SOY)

add_subdirectory(soy)

endif()

if(BAGOFBEANS_COFFEE)

add_subdirectory(coffee)

endif()

\# Lastly define the target and its other details. All variables

\# are assumed to name PRIVATE items.

add_executable(BagOfBeans_planter \${planterSources})

target_compile_definitions(BagOfBeans_planter PRIVATE \${planterDefines})

target_compile_options(BagOfBeans_planter PRIVATE \${planterOptions})

target_link_libraries(BagOfBeans_planter PRIVATE \${planterLinkLibs})

\#------------------------------------\<\<\<\<\<\<

The above would get even more complicated if some items needed to be anything other than PRIVATE. The use of variables like this is fragile, as it relies on nothing in subdirectories using the same variables for a different target and typos in variable names would not be caught as an error by CMake. It also enforces a stronger coupling between parent and child directories, since each child subdirectory would have to pass all relevant variables back up to its parent using set(… PARENT_SCOPE). For deeply nested directories, this quickly gets tedious and is error-prone.

【译】如果某些项目需要除PRIVATE之外的任何其他项目，上述内容将变得更加复杂。使用这样的变量是脆弱的，因为它不依赖于子目录中的任何内容，将相同的变量用于不同的目标，并且变量名中的拼写错误不会被CMake捕获为错误。它还加强了父目录和子目录之间的耦合，因为每个子目录都必须使用set（…parent_SCOPE）将所有相关变量传递回其父目录。对于深度嵌套的目录，这很快就会变得乏味，并且容易出错。

### 28.5.2. Target Outputs

When a library or executable is built, its default location will be either CMAKE_CURRENT_BINARY_DIR or a configuration-specific subdirectory below it depending on the type of project generator being used. For projects with many subdirectories or deeply nested hierarchies, this can be inconvenient for a developer to work with. For such cases, CMake provides a number of target properties that give the project a degree of control over the output location of each target’s built binary: 【译】构建库或可执行文件时，其默认位置将是CMAKE_CURRENT_BINARY_DIR或其下方的特定于配置的子目录，具体取决于所使用的项目生成器的类型。对于具有许多子目录或深度嵌套层次结构的项目，这可能会给开发人员带来不便。对于这种情况，CMake提供了许多目标属性，使项目能够在一定程度上控制每个目标构建二进制文件的输出位置：

\#\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

\#(1)RUNTIME_OUTPUT_DIRECTORY

Used for executables on all platforms and for DLLs on Windows. 【译】用于所有平台上的可执行文件和Windows上的DLL。

\#(2)LIBRARY_OUTPUT_DIRECTORY

Used for shared libraries on non-Windows platforms.【译】用于非Windows平台上的共享库。

\#(3)ARCHIVE_OUTPUT_DIRECTORY

Used for static libraries on all platforms and for import libraries associated with DLL libraries on Windows.【译】用于所有平台上的静态库和Windows上与DLL库关联的导入库。

\#\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

For all three of the above, multi configuration generators like Visual Studio and Xcode will automatically append a configuration specific subdirectory to each value unless it contains a generator expression. Associated per configuration properties with \_\<CONFIG\> appended are also supported for historical reasons, but those should be avoided in favor of using generator expressions where configuration specific behavior is needed.【译】对于上述三种情况，Visual Studio和Xcode等多配置生成器会自动为每个值附加一个特定于配置的子目录，除非它包含生成器表达式。出于历史原因，也支持将每个配置属性与附加的\_\<CONFIG\>相关联，但应避免使用这些属性，而应在需要配置特定行为的情况下使用生成器表达式。

A common use of these target properties is to collect libraries and executables together in a similar directory structure as they would have when installed. This is helpful if applications expect various resources to be located at a particular location relative to the executable’s binary. On Windows, it can also simplify debugging, since executables and DLLs can be collected into the same directory, allowing the executables to find their DLL dependencies automatically (this isn’t needed on other platforms, since RPATH support embeds the necessary locations in the binaries themselves).【译】这些目标属性的一个常见用途是将库和可执行文件收集在一个与安装时类似的目录结构中。如果应用程序希望各种资源位于相对于可执行文件二进制文件的特定位置，这将很有帮助。在Windows上，它还可以简化调试，因为可执行文件和DLL可以收集到同一目录中，允许可执行文件自动查找其DLL依赖关系（在其他平台上不需要，因为RPATH支持将必要的位置嵌入二进制文件本身）。

Following the usual pattern, these target properties are each initialized by a CMake variable of the same name with CMAKE\_ prepended. When all targets should use the same consistent output locations, these variables can be set at the top of the project so that the properties don’t have to be set for every target individually. To allow the project to be incorporated into a larger project hierarchy, these variables should only be set if they are not already set so that parent projects can override the output locations. They should also use a location relative to CMAKE_CURRENT_BINARY_DIR rather than CMAKE_BINARY_DIR. The following example shows how to safely collect binaries under a stage subdirectory of the current binary directory unless a parent project overrides this.【译】按照通常的模式，这些目标属性都由一个同名的CMake变量初始化，前缀为CMake\_。当所有目标都应该使用相同的一致输出位置时，可以在项目的顶部设置这些变量，这样就不必为每个目标单独设置属性。为了允许项目合并到更大的项目层次结构中，只有在尚未设置这些变量的情况下才应设置这些变量，以便父项目可以覆盖输出位置。它们还应该使用相对于CMAKE_CURRENT_BINARY_DIR而不是CMAKE_BINARY-DIR的位置。以下示例显示了如何在当前二进制目录的stage子目录下安全地收集二进制文件，除非父项目覆盖了此位置。

\#------------------------------------\>\>\>\>\>\>

include(GNUInstallDirs)

if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY

\${CMAKE_CURRENT_BINARY_DIR}/stage/\${CMAKE_INSTALL_BINDIR})

endif()

if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY

> \${CMAKE_CURRENT_BINARY_DIR}/stage/\${CMAKE_INSTALL_LIBDIR})

endif()

if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY

> \${CMAKE_CURRENT_BINARY_DIR}/stage/\${CMAKE_INSTALL_LIBDIR})

endif()

\#------------------------------------\<\<\<\<\<\<

Avoid creating CMAKE\_…\_OUTPUT_DIRECTORY as cache variables, as they should not be under the control of the developer. They should be controlled by the project because various parts of the project may make assumptions about the relative layout of the binaries. More importantly, leaving them as ordinary variables also means they can be unset within subdirectories where test executables are defined, allowing them to avoid being collected with the other main binaries and cluttering up that area.【译】避免将CMAKE\_…\_OUTPUT_DIRECTORY创建为缓存变量，因为它们不应受开发人员的控制。它们应该由项目控制，因为项目的各个部分可能会对二进制文件的相对布局做出假设。更重要的是，将它们保留为普通变量也意味着它们可以在定义测试可执行文件的子目录中取消设置，从而避免与其他主要二进制文件一起收集并弄乱该区域。

The name of the built binary can also be controlled by the project. By default, the base name of the binary will be the same as the target name. When target names are following the convention of incorporating the project name (to help keep them unique when part of a larger project hierarchy), the target name may not be appropriate as the binary base name, so this default may need to be overridden. The OUTPUT_NAME target property can be set to the base name to use for the binary, or for less typical situations, the more specific RUNTIME_OUTPUT_NAME, LIBRARY_OUTPUT_NAME and ARCHIVE_OUTPUT_NAME properties can be set. In most cases, OUTPUT_NAME is both sufficient and preferred.【译】构建的二进制文件的名称也可以由项目控制。默认情况下，二进制文件的基名称将与目标名称相同。当目标名称遵循合并项目名称的约定（以帮助在作为更大项目层次结构的一部分时保持其唯一性）时，目标名称可能不适合作为二进制基名称，因此可能需要覆盖此默认值。OUTPUT_NAME目标属性可以设置为用于二进制文件的基名称，或者对于不太常见的情况，可以设置更具体的RUNTIME_OUTPUT_NAME、LIBRARY_OUTPUT_NAME和ARCHIVE_OUTPUT_NAME属性。在大多数情况下，OUTPUT_NAME是足够的，也是首选的。

\#------------------------------------\>\>\>\>\>\>

add_executable(BagOfBeans_planter ...)

set_target_properties(BagOfBeans_planter PROPERTIES OUTPUT_NAME planter)

\#------------------------------------\<\<\<\<\<\<

Configuration specific variants such as OUTPUT_NAME\_\<CONFIG\> are also supported for historical reasons, but projects should prefer to use generator expressions instead.【译】出于历史原因，也支持特定于配置的变体，如OUTPUT_NAME\_\<CONFIG\>，但项目应更倾向于使用生成器表达式。

Older projects sometimes try to read the LOCATION target property to determine the output location and name of a binary and use it in places like custom target commands or other similar logic. As already highlighted back in Section 13.4, “Recommended Practices”, this is problematic for multi configuration generators, since the location depends on the configuration, but this is not accounted for by the LOCATION target property. CMake 3.0 and later will warn if a project tries to set this target property. Projects should use generator expressions like \$\<TARGET_FILE:…\> instead.【译】旧项目有时会尝试读取LOCATION目标属性以确定二进制文件的输出位置和名称，并在自定义目标命令或其他类似逻辑中使用它。正如第13.4节“推荐做法”中已经强调的那样，这对多配置发电机来说是有问题的，因为位置取决于配置，但这并没有被location目标属性所考虑。如果项目试图设置此目标属性，CMake 3.0及更高版本将发出警告。项目应该使用类似\$\<TARGET_FILE:…\>的生成器表达式。

### 28.5.3. Windows Specific Issues

Windows’ lack of support for RPATH causes a number of problems for developers. When running an executable during development, any DLLs the executable requires must be either in the same directory or be located in one of the directories listed in the PATH environment variable. For the project’s main binaries, the various …\_OUTPUT_PATH properties can be used to place executables and libraries in the same location, but this technique is less convenient for test executables since there could be many of them and having them all in the one output directory can be more difficult to work with.【译】Windows缺乏对RPATH的支持给开发人员带来了许多问题。在开发过程中运行可执行文件时，可执行文件所需的任何DLL必须位于同一目录中，或者位于PATH环境变量中列出的目录之一中。对于项目的主要二进制文件，可以使用各种…\_OUTPUT_PATH属性将可执行文件和库放置在同一位置，但这种技术对于测试可执行文件来说不太方便，因为它们可能有很多，而且将它们全部放在一个输出目录中可能更难使用。

For tests executed through ctest, the ENVIRONMENT test property can be used to add the required DLL directories to the PATH like so: 【译】对于通过ctest执行的测试，可以使用ENVIRONG test属性将所需的DLL目录添加到PATH中，如下所示：

\#------------------------------------\>\>\>\>\>\>

add_executable(fooTest ...)

target_link_libraries(fooTest PRIVATE algo)

add_test(NAME fooWithAlgo COMMAND fooTest)

if(WIN32)

set_tests_properties(fooWithAlgo PROPERTIES ENVIRONMENT

"PATH=\$\<SHELL_PATH:\$\<TARGET_FILE_DIR:algo\>\>\$\<SEMICOLON\>\$ENV{PATH}"

)

endif()

\#------------------------------------\<\<\<\<\<\<

This won’t help with allowing the test executable to run within the Visual Studio IDE under the debugger. For that, more elaborate measures are needed. CMake 3.8 added support for the VS_USER_PROPS target property which can be used to override the location of the user properties file on a per target basis. A custom properties file can be created with its LocalDebuggerEnvironment entry set to the additional PATH entries to be merged with the default PATH. If all the DLLs any tests need will be collected together in a small number of locations, then one user properties file can be generated and re-used for each test (but it is still possible to generate and use a custom user properties file for each target if required). The configure_file() command can be used to fill in the output directory automatically. 【译】这无助于允许测试可执行文件在调试器下的Visual Studio IDE中运行。为此，需要采取更详细的措施。CMake 3.8增加了对VS_USER_PROPS目标属性的支持，该属性可用于在每个目标的基础上覆盖用户属性文件的位置。可以创建自定义属性文件，将其LocalDebuggerEnvironment条目设置为要与默认PATH合并的其他PATH条目。如果任何测试所需的所有DLL都将收集在少数位置，那么可以为每个测试生成一个用户属性文件并重新使用（但如果需要，仍然可以为每个目标生成和使用自定义用户属性文件）。configure_file（）命令可用于自动填充输出目录。

\#------------------------------------\>\>\>\>\>\>

file(TO_NATIVE_PATH \${CMAKE_RUNTIME_OUTPUT_DIRECTORY} baseDir)

configure_file(user.props.in user.props @ONLY)

\#------------------------------------\<\<\<\<\<\<

User property files can be a little complex, but an example of a fairly basic one that can be used with the above might look like this:

【译】用户属性文件可能有点复杂，但可以与上述内容一起使用的一个相当基本的文件示例可能如下：

\#----------# *user.props.in*

\#------------------------------------\>\>\>\>\>\>

\<?xml version="1.0" encoding="utf-8"?\>

\<Project DefaultTargets="Build" ToolsVersion="15.0"

xmlns="http://schemas.microsoft.com/developer/msbuild/2003"\>

\<PropertyGroup Condition="'\$(Configuration)\|\$(Platform)'=='Debug\|Win32'"\>

\<LocalDebuggerEnvironment\>PATH=@baseDir@\Debug\</LocalDebuggerEnvironment\>

\</PropertyGroup\>

\<PropertyGroup Condition="'\$(Configuration)\|\$(Platform)'=='Release\|Win32'"\>

\<LocalDebuggerEnvironment\>PATH=@baseDir@\Release\</LocalDebuggerEnvironment\>

\</PropertyGroup\>

\</Project\>

\#------------------------------------\<\<\<\<\<\<

User property files can be used to set more than just the debugger environment, but the above at least provides a starting point for those wishing to explore this technique further.【译】用户属性文件可用于设置的不仅仅是调试器环境，但上述内容至少为那些希望进一步探索此技术的人提供了一个起点。

For Windows executables and DLLs, it is typical for a PDB (program database) file to be generated so that debugging information is available during development. There are two kinds of PDB files and CMake provides features for both. For shared libraries and executables, the PDB_NAME and configuration specific PDB_NAME\_\<CONFIG\> target properties can be used to override the base name of the PDB file. The default name is normally the most appropriate though, since it matches the DLL or executable name except it has a .pdb suffix instead of .dll or .exe. The PDB file is placed in the same directory as the DLL or executable by default, but this can be overridden with the PDB_OUTPUT_DIRECTORY and configuration specific PDB_OUTPUT_DIRECTORY\_\<CONFIG\> target properties. Note that unlike the other …\_OUTPUT_DIRECTORY properties, PDB_OUTPUT_DIRECTORY does not support generator expressions with CMake 3.11 or earlier. 【译】对于Windows可执行文件和DLL，通常会生成PDB（程序数据库）文件，以便在开发过程中提供调试信息。PDB文件有两种，CMake为这两种文件提供了功能。对于共享库和可执行文件，PDB_NAME和特定于配置的PDB_NAME\_\<CONFIG\>目标属性可用于覆盖PDB文件的基本名称。默认名称通常是最合适的，因为它与DLL或可执行文件名称匹配，除了它有.pdb后缀而不是.DLL或.exe。默认情况下，PDB文件与DLL或可执行文件放置在同一目录中，但这可以用PDB_OUTPUT_directory和特定于配置的PDB_OUTPUT_directory\_\<CONFIG\>目标属性覆盖。请注意，与其他…\_OUTPUT_DIRECTORY属性不同，PDB_OUTPUT_DIRECTORY不支持CMake 3.11或更早版本的生成器表达式。

A second kind of PDB file is also created which holds information for the individual object files being built for a target. This PDB file is less useful during development, except perhaps for static libraries. For C++, this latter PDB file has a default name VCxx.pdb where xx represents the version of Visual C++ being used (e.g. VC14.pdb). Because the default name is not target-specific, it is easy to make mistakes and mix up the PDBs for different targets in some situations. CMake allows the name of each target’s object PDB file to be controlled with the COMPILE_PDB and configuration specific COMPILE_PDB\_\<CONFIG\> target properties. The location of these object PDB files can also be overridden with the COMPILE_PDB_OUTPUT_DIRECTORY and COMPILE_PDB_OUTPUT_DIRECTORY\_\<CONFIG\> target properties. Note that these object PDB files are of little use for DLL and executable targets, since the main PDB already contains all the debugging information required. 【译】还创建了第二种PDB文件，其中包含为目标构建的各个对象文件的信息。这个PDB文件在开发过程中用处不大，除了静态库。对于C++，后一个PDB文件有一个默认名称VCxx.PDB，其中xx表示正在使用的Visual C++版本（例如VC14.PDB）。由于默认名称不是特定于目标的，因此在某些情况下很容易出错并混淆不同目标的PDB。CMake允许使用COMPILE_PDB和特定于配置的COMPILE_PDB\_\<CONFIG\>目标属性来控制每个目标的对象PDB文件的名称。这些对象PDB文件的位置也可以用COMPILE_PDB_OUTPUT_DIRECTORY和COMPILE_PDB_OUTPUT-DIRECTORY\_\<CONFIG\>目标属性覆盖。请注意，这些对象PDB文件对DLL和可执行目标用处不大，因为主PDB已经包含了所需的所有调试信息。

## 28.6. Miscellaneous Project Features

Project generators usually provide some kind of clean target that can be used to remove all the generated files, build outputs, etc. This is sometimes used by IDE tools to provide a basic rebuild feature as a clean followed by a build, or by developers to simply remove build outputs to force rebuilding everything on the next build attempt. Sometimes a project defines a custom rule in such a way that it creates files that CMake doesn’t know about, so they are not included in the clean step and have the potential to still affect the next build. Projects can tell CMake about these files by adding them to the ADDITIONAL_MAKE_CLEAN_FILES directory property, which holds a list of files for that directory scope which should be part of a clean target. This is only supported by the Makefile family of generators. The Ninja generator does not support that property, but it does provide a more robust alternative through the BYPRODUCTS option given to commands like add_custom_command() and add_custom_target(). By listing such files as byproducts, Ninja knows to remove them when the clean target is built. The other project generators have no equivalent functionality. 【译】项目生成器通常提供某种干净的目标，可用于删除所有生成的文件、构建输出等。IDE工具有时会使用它来提供基本的重建功能，即先进行清理后进行构建，或者开发人员可以简单地删除构建输出，以便在下次构建尝试时强制重建所有内容。有时，项目定义自定义规则的方式会创建CMake不知道的文件，因此它们不会包含在清理步骤中，并且仍有可能影响下一个构建。项目可以通过将这些文件添加到ADDITIONAL_MAKE_CLEAN_files目录属性来告诉CMake这些文件，该属性包含该目录范围的文件列表，这些文件应该是干净目标的一部分。这仅由Makefile生成器系列支持。Ninja生成器不支持该属性，但它确实通过为add_custom_command（）和add_custom_target（）等命令提供的BYPRODUCTS选项提供了一种更强大的替代方案。通过将这些文件列为副产品，Ninja知道在构建干净的目标时将其删除。其他项目生成器没有等效的功能。

Certain more advanced techniques may require CMake to be re-run if a particular file changes. Normally, CMake does a good job of automatically tracking dependencies for things it controls, such as copying files with the configure_file() command, but custom commands and other tasks may rely on files for which CMake isn’t aware of the dependency. Such files can be added to the CMAKE_CONFIGURE_DEPENDS directory property and if any of the listed files change, CMake will be rerun before the next build. If a file is specified with a relative path, it will be taken to be relative to the source directory associated with the directory property. Most projects won’t typically need to make use of the CMAKE_CONFIGURE_DEPENDS directory property, but it can and should be used where CMake doesn’t have the opportunity to know about files which act as input to the configure or generation steps. Most file dependencies are build time dependencies, not configure or generation time, so before using this property, check whether the project really does need to re-run CMake rather than simply recompiling a source file or target as part of the regular build. 【译】如果特定文件发生更改，某些更高级的技术可能需要重新运行CMake。通常，CMake可以很好地自动跟踪其控制对象的依赖关系，例如使用configure_file（）命令复制文件，但自定义命令和其他任务可能依赖于CMake不知道依赖关系的文件。这些文件可以添加到CMAKE_CONFIGURE_DEPENDS目录属性中，如果列出的任何文件发生更改，CMAKE将在下一次构建之前重新运行。如果文件指定了相对路径，则将其视为相对于与目录属性关联的源目录。大多数项目通常不需要使用CMAKE_CONFIGURE_DEPENDS目录属性，但在CMAKE没有机会知道作为配置或生成步骤输入的文件的情况下，可以而且应该使用它。大多数文件依赖关系是构建时依赖关系，而不是配置或生成时依赖关系。因此，在使用此属性之前，请检查项目是否真的需要重新运行CMake，而不是简单地在常规构建中重新编译源文件或目标。

There will inevitably come a time where a project from some external source needs to be added to a build, but it has some problem that prevents it from working properly. Some common examples include not setting variables or properties that should have been set. This is especially common when working with projects that support very old CMake versions and have not been updated to handle newer CMake features and checks. For some of these issues, it is possible to inject CMake code without having to actually modify the external project and work around the problem. The project() command has a feature whereby it will check for a variable with the name CMAKE_PROJECT\_\<PROJNAME\>\_INCLUDE where \<PROJNAME\> is the project name as given to the project() command. If that variable is defined, it is assumed to hold the name of a file that CMake should include as the last thing the project() command does before returning. In effect, the project() command works like this: 【译】不可避免地，将来需要将来自外部源的项目添加到构建中，但它存在一些问题，无法正常工作。一些常见的例子包括不设置本应设置的变量或属性。当处理支持非常旧的CMake版本并且尚未更新以处理较新的CMake功能和检查的项目时，这尤其常见。对于其中一些问题，可以注入CMake代码，而无需实际修改外部项目并解决问题。project（）命令有一个功能，它将检查名为CMAKE_project\_\<PROJNAME\>\_INCLUDE的变量，其中\<PROJNNAME\>是给定给project（）的项目名称。如果定义了该变量，则假定它包含CMake应包含的文件名，作为project（）命令返回前的最后一项操作。实际上，project（）命令的工作原理如下：

\#------------------------------------\>\>\>\>\>\>

project(SomeProj)

if(CMAKE_PROJECT_SomeProj_INCLUDE)

include(\${CMAKE_PROJECT_SomeProj_INCLUDE})

endif()

\#------------------------------------\<\<\<\<\<\<

Because this behavior is supported for every project() call, each project() call therefore becomes a potential point of CMake code injection. It can be used to change the defaults for target properties within the project, or it can do things like add additional compiler or linker flags and so on. Another particularly handy use of this feature is to safely set options for continuous integration builds without having to save them in the CMake cache. This means incremental builds are less likely to be affected by old CMake cache options that are removed or no longer set after subsequent changes to the project. 【译】由于每个project（）调用都支持这种行为，因此每个project（”）调用都成为CMake代码注入的潜在点。它可用于更改项目中目标属性的默认值，也可以执行添加其他编译器或链接器标志等操作。此功能的另一个特别方便的用途是安全地设置持续集成构建的选项，而无需将其保存在CMake缓存中。这意味着增量构建不太可能受到旧CMake缓存选项的影响，这些选项在项目后续更改后被删除或不再设置。

For example, consider a developer working on an integration branch where extra checks should be enabled temporarily. A naive approach would be to explicitly set variables like CMAKE_C_FLAGS or CMAKE_CXX_FLAGS, but since the CI scripts shouldn’t change the project itself, the only choice would be to set them as cache options. When the branch is merged, those cache options will continue to be present for incremental builds, but they should no longer be getting applied. The only course of action then is to clear the cache which would likely force a complete rebuild. A better alternative is to use CMAKE_PROJECT\_\<PROJNAME\>\_INCLUDE to process a CI-specific file at the end of the top most project() call. This file would be under source control just like the rest of the project. Before the branch is merged, that file would be restored to its normal contents and the build would not retain the temporary flags. 【译】例如，考虑一个开发人员在集成分支上工作，在那里应该临时启用额外的检查。一种简单的方法是显式设置CMAKE_C_FLAGS或CMAKE_CXX_FLAGS等变量，但由于CI脚本不应更改项目本身，因此唯一的选择是将它们设置为缓存选项。当分支合并时，这些缓存选项将继续存在于增量构建中，但不应再应用它们。然后，唯一的行动方案是清除缓存，这可能会迫使完全重建。更好的替代方法是在最顶层的PROJECT（）调用结束时使用CMAKE_PROJECT\_\<PROJNAME\>\_INCLUDE处理特定于CI的文件。此文件将与项目的其他部分一样受源代码管理。在合并分支之前，该文件将恢复到其正常内容，并且构建将不会保留临时标志。

\#----# *CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

cmake_minimum_required(VERSION 3.0)

project(MyProj)

...

\#------------------------------------\<\<\<\<\<\<

CMake would be invoked like so by the CI system: 【译】CMake将由CI系统按如下方式调用：

\`\`\`sh

cmake -D CMAKE_PROJECT_MyProj_INCLUDE:FILEPATH=path/to/ciOptions.cmake ...

\`\`\`

Ordinarily, the file ciOptions.cmake might be empty or just contain a few common settings such as turning on optional features. For the branch, it might contain things like this: 【译】通常，ciOptions.cake文件可能为空，或者只包含一些常见设置，如打开可选功能。对于分支，它可能包含以下内容：

\#---------# *ciOptions.cmake*

\#------------------------------------\>\>\>\>\>\>

compile_definitions(DO_EXTRA_CI_CHECKS=1)

set(ENABLE_SANITIZERS YES)

\#------------------------------------\<\<\<\<\<\<

Injecting files into project() commands like this should not be part of the normal development of a project. It has specific uses for overcoming deficiencies in older projects and for very controlled situations such as in continuous integration builds, but outside of those cases, developers should generally prefer to add or modify the project’s CMakeLists.txt files directly. 【译】 像这样将文件注入到project（）命令中不应该是项目正常开发的一部分。它有特定的用途来克服旧项目中的缺陷，以及在持续集成构建等非常可控的情况下，但除此之外，开发人员通常更喜欢直接添加或修改项目的CMakeLists.txt文件。

## 28.7. Recommended Practices

The way projects are structured and used can vary considerably. Some things that used to be commonplace are now considered poor practice, as new features and lessons learnt allow older methods to be replaced by newer ones that are more robust, more flexible and allow things that were not possible previously. Tools are upgraded, languages evolve, dependencies change - all of these things mean that projects will also need to adapt over time. For CMake projects in particular, those that continue to target older CMake versions before 3.0 will increasingly face a bumpy path. There is a strong move toward a target-centric model and much of CMake’s development is geared in that direction. Therefore, prefer to set a minimum CMake version that allows the project to make use of those features. Anything less than CMake 3.1 is likely to be too restrictive, so consider at least CMake 3.7 where possible due to the updated language support and new features. If working with newer tools like CUDA or a very recent language standard, the latest CMake release is strongly advised. New releases of Visual Studio or Xcode also tend to require recent CMake versions in order to pick up fixes and additions for changes in those toolchains. 【译】项目的结构和使用方式可能会有很大差异。一些曾经司空见惯的事情现在被认为是糟糕的做法，因为新的功能和经验教训允许用更强大、更灵活的新方法取代旧方法，并允许以前不可能的事情。工具升级、语言发展、依赖关系变化——所有这些都意味着项目也需要随着时间的推移而适应。特别是对于CMake项目，那些继续以3.0之前的旧CMake版本为目标的项目将越来越面临坎坷的道路。有一种强烈的趋势是朝着以目标为中心的模型发展，CMake的大部分开发都是朝着这个方向发展的。因此，最好设置一个允许项目使用这些功能的最低CMake版本。任何低于CMake 3.1的版本都可能过于严格，因此由于更新的语言支持和新功能，在可能的情况下至少考虑CMake 3.7。如果使用CUDA等较新的工具或最新的语言标准，强烈建议使用最新的CMake版本。Visual Studio或Xcode的新版本也往往需要最新的CMake版本，以便为这些工具链中的更改进行修复和添加。

A fundamental choice that every project needs to make is whether to structure itself as a superbuild or as a regular build. If the project can set a minimum CMake version of 3.11, the nonsuperbuild arrangement has more powerful features available to it for dependency management which may make the need for a superbuild unnecessary. Consider whether the FetchContent module and the promotion of local imported targets to global scope offer more flexibility and a better experience for developers. Where all dependencies of a project are relatively mature and have well defined install rules, a superbuild may still be a suitable alternative and comes with the advantage that it can be used with much older CMake versions. Both methods have their place, but the earlier in a project’s life that the decision can be made on whether or not to use a superbuild, the more likely the project can avoid large scale disruptive restructuring later on. 【译】每个项目都需要做出的一个基本选择是将自己构建为超级建筑还是常规建筑。如果项目可以将CMake的最低版本设置为3.11，那么非超级构建安排就有更强大的功能可用于依赖性管理，这可能会使对超级构建的需求变得不必要。考虑FetchContent模块和将本地导入目标推广到全局范围是否为开发人员提供了更大的灵活性和更好的体验。如果一个项目的所有依赖关系都相对成熟，并且有明确的安装规则，超级构建可能仍然是一个合适的替代方案，并且具有可以与旧得多的CMake版本一起使用的优点。这两种方法都有自己的位置，但在项目生命周期的早期，就可以决定是否使用超级建筑，项目就越有可能避免以后的大规模破坏性重组。

Irrespective of whether a project is a superbuild or not, aim to keep the top level of the project focused on the higher level details. Think of the top level CMakeLists.txt file as being more like a table of contents for the project. The top level directory should mostly just contain administrative files and a set of subdirectories each focused on a particular area. Avoid subdirectory names that may cause clashes with those created in the build directory automatically. Prefer instead to use fairly standard names unless there is an existing convention that must be followed. 【译】无论一个项目是否是超级建筑，都要让项目的顶层专注于更高层次的细节。将顶级CMakeLists.txt文件视为项目的目录。顶级目录应该主要包含管理文件和一组子目录，每个子目录都专注于特定区域。避免使用可能与生成目录中自动创建的子目录名称冲突的子目录名。除非有必须遵循的现有约定，否则更倾向于使用相当标准的名称。

For regular projects, aim to make the top level CMakeLists.txt file follow the common section pattern of: 【译】对于常规项目，目标是使顶级CMakeLists.txt文件遵循以下常见部分模式：

• Preamble

• Project wide setup

• Dependencies

• Main build targets

• Tests

• Packaging

Clearly delineating each section with comment blocks will help encourage developers working on the project to maintain that structure. Establishing this pattern across projects will help reinforce the focus on keeping the top level CMakeLists.txt file streamlined and acting as a high level overview. 【译】用注释块清晰地划分每个部分将有助于鼓励参与该项目的开发人员保持这种结构。在项目中建立这种模式将有助于加强对保持顶级CMakeLists.txt文件精简和作为高级概述的关注。

When defining build targets that have sources spread across directories, prefer to create the target first, then have each subdirectory add sources to it using target_sources(). Where appropriate, group the subdirectories by functionality or feature so that they can be easily moved around or enabled/disabled as a unit. In many cases, the other target-focused commands (i.e. target_compile_definitions(), target_compile_options() and target_include_directories()) can then also be used locally within the subdirectory that they relate to. This helps keep information close to the location where it is relevant rather than spreading it across directories. Avoid using variables to build up lists of sources to be passed back up through directory hierarchies and eventually used to create a target, define compiler flags, etc. The use of variables instead of operating on targets directly is much more fragile, more verbose and less likely to result in CMake catching typos or other errors. 【译】在定义源代码分布在不同目录中的构建目标时，最好先创建目标，然后让每个子目录使用target_sources（）向其添加源代码。在适当的情况下，按功能或特性对子目录进行分组，以便它们可以作为一个单元轻松移动或启用/禁用。在许多情况下，其他以目标为中心的命令（即target_compile-definition（）、target_compire_options（）和target_include_directories（））也可以在它们相关的子目录中本地使用。这有助于将信息保持在相关位置附近，而不是在目录之间传播。避免使用变量来构建源列表，这些源列表将通过目录层次结构传递，并最终用于创建目标、定义编译器标志等。使用变量而不是直接对目标进行操作要脆弱得多，更冗长，也不太可能导致CMake捕获拼写错误或其他错误。

Following on from the above and reiterating one of the recommendations from “Chapter 4, Building Simple Targets”, avoid the all too common practice of unnecessarily using a variable to hold the name of a target or project. The following pattern in particular should be avoided:

【译】根据上述内容，并重申“第4章，构建简单目标”中的一项建议，避免不必要地使用变量来保存目标或项目名称的常见做法。应特别避免以下模式：

\#------------------------------------\>\>\>\>\>\>

set(projectName ...)

project(\${projectName})

add_executable(\${projectName} ...)

\#------------------------------------\<\<\<\<\<\<

The above example ties together things that should not be so strongly related. The project name should rarely change. Specify the name of the project directly in the project() command and use the standard variables CMake provides if it needs to be referred to elsewhere in the project. For targets, the target name is used so widely that trying to carry it around in a variable is both cumbersome and error prone. Give the target a name and use that name consistently throughout the project. Even if there is only one target in the whole project, it doesn’t necessarily have to be the same as the project name and the two should be considered separate rather than being tied together. 【译】上面的例子将不应该如此紧密相关的事情联系在一起。项目名称应该很少更改。直接在project（）命令中指定项目的名称，如果需要在项目的其他地方引用，请使用CMake提供的标准变量。对于目标，目标名称的使用非常广泛，试图在变量中携带它既麻烦又容易出错。为目标命名，并在整个项目中始终如一地使用该名称。即使整个项目中只有一个目标，它也不一定与项目名称相同，两者应该被视为独立的，而不是捆绑在一起。

When adding tests, consider keeping the test code close to the code being tested. This helps keep logically related code together and encourages developers to keep tests up to date. Tests that are distributed to other parts of the source directory hierarchy can easily be forgotten. For tests that draw on multiple areas such as integration tests, the locality principle is not as strong, so collecting these higher level tests in a common place may be appropriate. The top level tests subdirectory is intended for situations such as this. 【译】添加测试时，考虑将测试代码与被测试的代码保持在一起。这有助于将逻辑上相关的代码放在一起，并鼓励开发人员保持测试的最新状态。分发到源目录层次结构的其他部分的测试很容易被遗忘。对于利用多个领域的测试，如集成测试，局部性原则并不那么强，因此将这些更高级别的测试收集在一个共同的地方可能是合适的。顶级tests子目录适用于此类情况。

For larger projects, consider whether it is worth organizing the way the project is presented in IDE tools. If there are many targets, it can be difficult to work with the project unless some structure is added using the FOLDER target property. For those targets with many sources, they too can be organized using the source_group() command, which can be used to define group hierarchies around whatever concepts or features make sense. 【译】对于较大的项目，考虑是否值得在IDE工具中组织项目的呈现方式。如果有很多目标，除非使用FOLDER目标属性添加一些结构，否则可能很难处理项目。对于那些有很多源的目标，也可以使用source_group（）命令来组织它们，该命令可用于围绕任何有意义的概念或特征定义组层次结构。

Special consideration should be given to projects that are anticipated to be built on Windows, especially where developers may use the Visual Studio IDE. The lack of RPATH support means executables rely on being able to find their DLL dependencies in either the same directory or via the PATH environment variable. This impacts both test programs run through ctest and the developer’s ability to run executables from within the Visual Studio IDE. Forcing all executables and DLLs into the same output directory is one solution to this problem, made possible by the various …OUTPUT_DIRECTORY target properties and their associated CMAKE\_…OUTPUT_DIRECTORY variables. These are frequently used to create a directory layout that mirrors that used when the project is installed. Avoid copying DLLs in post build rules or custom tasks to put them in multiple locations so that other executables can find them. This is fragile and can easily result in stale DLLs mistakenly being used. 【译】应特别考虑预期在Windows上构建的项目，特别是开发人员可能使用Visual Studio IDE的项目。缺乏RPATH支持意味着可执行文件依赖于能够在同一目录中或通过PATH环境变量找到它们的DLL依赖关系。这既会影响通过ctest运行的测试程序，也会影响开发人员从Visual Studio IDE中运行可执行文件的能力。将所有可执行文件和DLL强制放入同一输出目录是解决此问题的一种方法，这可以通过各种…output_directory目标属性及其关联的CMAKE\_…output\_ DIRECTORYs变量来实现。这些常用于创建目录布局，以反映安装项目时使用的布局。避免在构建后规则或自定义任务中复制DLL，将其放在多个位置，以便其他可执行文件可以找到它们。这很脆弱，很容易导致错误使用过时的DLL。

Test programs would ideally not be collected to the same place as the main programs and DLLs. Some test code may need to find other files relative to their own location, so keeping them separate may even be a requirement. Use the ENVIRONMENT test property to specify an appropriate PATH to ensure tests can find their DLLs when run through ctest. Also consider using CMake 3.8 or later and defining a user properties file which test targets can then be made aware of using the VS_USER_PROPS target property. This can be used to augment the debugger environment so that the tests can be run directly from within the Visual Studio IDE. 【译】理想情况下，测试程序不会被收集到与主程序和DLL相同的位置。一些测试代码可能需要找到与其自身位置相关的其他文件，因此将它们分开甚至可能是一项要求。使用环境测试属性指定适当的PATH，以确保测试在通过ctest运行时可以找到它们的DLL。还可以考虑使用CMake 3.8或更高版本，并定义一个用户属性文件，然后让测试目标知道使用VS_user_PROPS目标属性。这可用于增强调试器环境，以便可以直接从Visual Studio IDE中运行测试。

When using the Visual Studio generator, prefer to leave the PDB settings at their defaults. This typically results in the PDB file appearing in the location developers expect and with a name that matches the executable or library they correspond to. Trying to change the output directory of PDB files has implementation complexities when generator expressions are used and it can be difficult to get the PDB files into the desired directory in some cases. 【译】使用Visual Studio生成器时，最好将PDB设置保留为默认值。这通常会导致PDB文件出现在开发人员期望的位置，并且其名称与它们对应的可执行文件或库相匹配。当使用生成器表达式时，试图更改PDB文件的输出目录具有实现复杂性，在某些情况下很难将PDB文件放入所需的目录。
