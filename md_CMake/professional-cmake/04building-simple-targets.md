# Ch4. Building Simple Targets

As shown in the previous chapter, it is relatively straightforward to define a simple executable in CMake. The simple example given previously required defining a target name for the executable and listing the source files to be compiled: 【译】如前一章所示，在CMake中定义一个简单的可执行文件相对简单。前面给出的简单示例要求为可执行文件定义一个目标名称，并列出要编译的源文件：

\`\`\`cmake

add_executable(myApp main.cpp)

\`\`\`

This assumes the developer wants a basic console executable to be built, but CMake also allows the developer to define other types of executables, such as app bundles on Apple platforms and Windows GUI applications. This chapter discusses additional options which can be given to add_executable() to specify these details. 【译】这假设开发人员希望构建一个基本的控制台可执行文件，但CMake也允许开发人员定义其他类型的可执行文件。本章讨论了可以为add_executable()提供的其他选项，以指定这些细节。

In addition to executables, developers also frequently need to build and link libraries. CMake supports a few different kinds of libraries, including static, shared, modules and frameworks. CMake also offers very powerful features for managing dependencies between targets and how libraries are linked. This whole area of libraries and how to work with them in CMake forms the bulk of this chapter. The concepts covered here are used extensively throughout the remainder of this book. Some very basic use of variables and properties are also given to provide a flavor for how these CMake features relate to libraries and targets in general. 【译】除了可执行文件，开发人员还经常需要构建和链接库。CMake支持几种不同类型的库，包括静态库、共享库、模块库和框架库。CMake还提供了非常强大的功能来管理目标之间的依赖关系以及库的链接方式。这一整个库领域以及如何在CMake中使用它们构成了本章的大部分内容。本文所涵盖的概念在本书的其余部分中得到了广泛的应用。还提供了一些非常基本的变量和属性用法，以提供这些CMake功能与库和目标的一般关系。

## 4.1. Executables

The more complete form of the basic add_executable() command is as follows: 【译】基本add_executable（）命令的更完整形式如下：

\`\`\`cmake

add_executable(targetName \[WIN32\] \[MACOSX_BUNDLE\]

\[EXCLUDE_FROM_ALL\]

source1 \[source2 ...\]

)

\`\`\`

The only differences to the form shown previously are the new optional keywords. 【译】与之前显示的表单的唯一区别是新的可选关键字。

\#\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

**\#(1)WIN32**

When building the executable on a Windows platform, this option instructs CMake to build the executable as a Windows GUI application. In practice, this means it will be created with a WinMain() entry point instead of just main() and it will be linked with the /SUBSYSTEM:WINDOWS option. On all other platforms, the WIN32 option is ignored. 【译】在Windows平台上构建可执行文件时，此选项指示CMake将可执行文件构建为Windows GUI应用程序。在实践中，这意味着它将使用WinMain()入口点而不是main()创建，并且将与/SUBSYSTEM:WINDOWS选项链接。在所有其他平台上，WIN32选项被忽略。

**\#(2)MACOSX_BUNDLE**

When present, this option directs CMake to build an app bundle when building on an Apple platform. Contrary to what the option name suggests, it applies not just to macOS, but also to other Apple platforms like iOS as well. The exact effects of this option vary somewhat between platforms. For example, on macOS, the app bundle layout has a very specific directory structure, whereas on iOS, the directory structure is flattened. CMake will also generate a basic Info.plist file for bundles. These and other details are covered in more detail in Section 22.2, “Application Bundles”. On non-Apple platforms, the MACOSX_BUNDLE keyword is ignored. 【译】当存在时，此选项指示CMake在Apple平台上构建应用程序包。与选项名称所暗示的相反，它不仅适用于macOS，也适用于iOS等其他苹果平台。此选项的确切效果因平台而异。例如，在macOS上，应用程序包布局具有非常特定的目录结构，而在iOS上，目录结构是扁平的。CMake还将为捆绑包生成一个基本的Info.plist文件。这些和其他细节在第22.2节“应用程序包”中有更详细的介绍。在非苹果平台上，MACOSX_BUNDLE关键字被忽略。

**\#(3)EXCLUDE_FROM_ALL**

Sometimes, a project defines a number of targets, but by default only some of them should be built. When no target is specified at build time, the default ALL target is built (depending on the CMake generator being used, the name may be slightly different, such as ALL_BUILD for Xcode). If an executable is defined with the EXCLUDE_FROM_ALL option, it will not be included in that default ALL target. The executable will then only be built if it is explicitly requested by the build command or if it is a dependency for another target that is part of the default ALL build. A common situation where it can be useful to exclude a target from ALL is where the executable is a developer tool that is only needed occasionally. 【译】有时，一个项目定义了多个目标，但默认情况下只应构建其中的一些。当在构建时没有指定目标时，将构建**默认的ALL目标**（根据所使用的CMake生成器，名称可能略有不同，例如Xcode的ALL_build）。如果使用EXCLUDE_FROM_ALL选项定义了可执行文件，则它将不会包含在默认的ALL目标中。然后，只有当构建命令明确请求可执行文件，或者它是默认ALL构建中另一个目标的依赖项时，才会构建可执行文件。将目标从ALL中排除可能有用的一种常见情况是，可执行文件是偶尔需要的开发人员工具。

\#\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

In addition to the above, there are other forms of the add_executable() command which produce a kind of reference to an existing executable or target rather than defining a new one to be built. These alias executables are covered in detail in “Chapter 16, Target Types”. 【译】除上述之外，还有其他形式的add_executable（）命令，它产生对现有可执行文件或目标的引用，而不是定义要构建的新可执行文件。这些别名可执行文件在“第16章，目标类型”中有详细介绍。

## 4.2. Defining Libraries

Creating simple executables is a fundamental need of any build system. For many larger projects, the ability to create and work with libraries is also essential to keep the project manageable. CMake supports building a variety of different kinds of libraries, taking care of many of the platform differences, but still supporting the native idiosyncrasies of each. Library targets are defined using the add_library() command, of which there are a number of forms. The most basic of these is the following: 【译】创建简单的可执行文件是任何构建系统的基本需求。对于许多大型项目，创建和使用库的能力对于保持项目的可管理性也至关重要。CMake支持构建各种不同类型的库，解决了许多平台差异，但仍然支持每种库的原生特性。库目标是使用add_Library（）命令定义的，该命令有多种形式。其中最基本的如下：

\`\`\`cmake

add_library(targetName \[STATIC \| SHARED \| MODULE\]

> \[EXCLUDE_FROM_ALL\]
>
> source1 \[source2 ...\]

)

\`\`\`

This form is analogous to how add_executable() is used to define a simple executable. The targetName is used within the CMakeLists.txt file to refer to the library, with the name of the built library on the file system being derived from this name by default. The EXCLUDE_FROM_ALL keyword has exactly the same effect as it does for add_executable(), namely to prevent the library from being included in the default ALL target. The type of library to be built is specified by one of the remaining three keywords STATIC, SHARED or MODULE. 【译】这种形式类似于如何使用add_executable()来定义一个简单的可执行文件。targetName在CMakeLists.txt文件中用于引用库，默认情况下，文件系统上构建的库的名称从该名称派生而来。EXCLUDE_FROM_ALL关键字的作用与add_executable()完全相同，即防止库包含在默认的ALL目标中。要构建的库的类型由其余三个关键字STATIC、SHARED或MODULE中的一个指定。

\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

**\#(1)STATIC**

Specifies a static library or archive. On Windows, the default library name would be targetName.lib, while on Unix-like platforms, it would typically be libtargetName.a. 【译】指定静态库或存档。在Windows上，默认库名称为targetName.lib，而在类Unix平台上，它通常为libtargetName.a。

**\#(2)SHARED**

Specifies a shared or dynamically linked library. On Windows, the default library name would be targetName.dll, on Apple platforms it would be libtargetName.dylib and on other Unix-like platforms it would typically be libtargetName.so. On Apple platforms, shared libraries can also be marked as frameworks, a topic covered in Section 22.3, “Frameworks”. 【译】指定共享或动态链接库。在Windows上，默认库名称为targetName.dll，在Apple平台上为libtargetName.dylib，在其他类Unix平台上通常为libtargetName.so。在Apple平台，共享库也可以标记为框架，这是第22.3节“框架”中涵盖的主题。

**\#(3)MODULE**

Specifies a library that is somewhat like a shared library, but is intended to be loaded dynamically at run-time rather than being linked directly to a library or executable. These are typically plugins or optional components the user may choose to be loaded or not. On Windows platforms, no import library is created for the DLL. 【译】指定一个有点像共享库的库，但旨在在运行时动态加载，而不是直接链接到库或可执行文件。这些通常是用户可以选择加载或不加载的插件或可选组件。在Windows平台上，不会为DLL创建导入库。

\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

It is possible to omit the keyword defining what type of library to build. Unless the project specifically requires a particular type of library, the preferred practice is to not specify it and leave the choice up to the developer when building the project. In such cases, the library will be either STATIC or SHARED, with the choice determined by the value of a CMake variable called BUILD_SHARED_LIBS. If BUILD_SHARED_LIBS has been set to true, the library target will be a shared library, otherwise it will be static. Working with variables is covered in detail in “Chapter 5, Variables”, but for now, one way to set this variable is by including a -D option on the cmake command line like so: 【译】可以省略定义要构建哪种类型的库的关键字。除非项目特别需要特定类型的库，否则首选做法是不指定它，并在构建项目时将选择权留给开发人员。在这种情况下，库将是STATIC或SHARED，选择由名为**BUILD_SHARED_LIBS**的CMake变量的值决定。如果BUILD_CHARED_LIBS设置为true，则库目标将是共享库，否则它将是静态的。在“第5章，变量”中详细介绍了如何使用变量，但目前，设置此变量的一种方法是在cmake命令行中包含一个-D选项，如下所示：

\`\`\`cmake

cmake -DBUILD_SHARED_LIBS=YES /path/to/source

\`\`\`

It could be set in the CMakeLists.txt file instead with the following placed before any add_library() commands, but that would then require developers to modify it if they wanted to change it (i.e. it would be less flexible): 【译】它可以在CMakeLists.txt文件中设置，而不是在任何add_library()命令之前放置以下内容，但如果开发人员想要更改它，则需要对其进行修改（即灵活性较低）：

\`\`\`cmake

set(BUILD_SHARED_LIBS YES)

\`\`\`

Just as for executables, library targets can also be defined to refer to some existing binary or target rather than being built by the project. Another type of pseudo-library is also supported for collecting together object files without going as far as creating a static library. These are all discussed in detail in “Chapter 16, Target Types”. 【译】与可执行文件一样，库目标也可以定义为引用一些现有的二进制文件或目标，而不是由项目构建。还支持另一种类型的伪库，用于收集目标文件，而无需创建静态库。这些都在“第16章，目标类型”中进行了详细讨论。

## 4.3. Linking Targets

When considering the targets that make up a project, developers are typically used to thinking in terms of library A needing library B, so A is linked to B. This is the traditional way of looking at library handling, where the idea of one library needing another is very simplistic. In reality, however, there are a few different types of dependency relationships that can exist between libraries: 【译】在考虑组成项目的目标时，开发人员通常习惯于从库a需要库B的角度思考，因此a与B相关联。这是看待库处理的传统方式，其中一个库需要另一个库的想法非常简单。然而，在现实中，库之间可能存在几种不同类型的依赖关系：

\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

**\#(1)PRIVATE**

Private dependencies specify that library A uses library B in its own internal implementation. Anything else that links to library A doesn’t need to know about B because it is an internal implementation detail of A. 【译】私有依赖关系指定库A在其内部实现中使用库B。链接到库A的任何其他内容都不需要知道B，因为它是A的内部实现细节。

**\#(2)PUBLIC**

Public dependencies specify that not only does library A use library B internally, it also uses B in its interface. This means that A cannot be used without B, so anything that uses A will also have a direct dependency on B. An example of this would be a function defined in library A which has at least one parameter of a type defined and implemented in library B, so code cannot call the function from A without providing a parameter whose type comes from B. 【译】公共依赖关系规定，库A不仅在内部使用库B，还在其接口中使用B。这意味着A不能在没有B的情况下使用，因此使用A的任何东西也将直接依赖于B。一个例子是库A中定义的函数，它至少有一个在库B中定义和实现的类型的参数，因此代码不能在不提供类型来自B的参数的情况下从A调用函数。

**\#(3)INTERFACE**

Interface dependencies specify that in order to use library A, parts of library B must also be used. This differs from a public dependency in that library A doesn’t require B internally, it only uses B in its interface. An example of where this is useful is when working with library targets defined using the INTERFACE form of add_library(), such as when using a target to represent a header-only library’s dependencies (see “Chapter 16, Target Types”). 【译】接口依赖关系规定，为了使用库A，还必须使用库B的部分。这与公共依赖不同，因为库a在内部不需要B，它只在接口中使用B。这很有用的一个例子是，当使用add_library（）的INTERFACE形式定义的库目标时，例如当使用目标来表示仅标头库的依赖关系时（请参阅“第16章，目标类型”）。

\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

CMake captures this richer set of dependency relationships with its target_link_libraries() command, not just the simplistic idea of needing to link. The general form of the command is:

【译】CMake通过其target_link_libraies() 命令捕获了这组更丰富的依赖关系，而不仅仅是需要链接的简单想法。命令的一般形式是：

\`\`\`cmake

target_link_libraries(targetName

\<PRIVATE\|PUBLIC\|INTERFACE\> item1 \[item2 ...\]

\[\<PRIVATE\|PUBLIC\|INTERFACE\> item3 \[item4 ...\]\]

...

)

\`\`\`

This allows projects to precisely define how one library depends on others. CMake then takes care of managing the dependencies throughout the chain of libraries linked in this fashion. For example, consider the following: 【译】这允许项目精确地定义一个库如何依赖于其他库。CMake随后负责管理以这种方式链接的库链中的依赖关系。例如，考虑以下情况：

\#------------------------------------\>\>\>\>\>\>

<span class="mark">add_library(collector src1.cpp)</span>

<span class="mark">add_library(algo src2.cpp)</span>

<span class="mark">add_library(engine src3.cpp)</span>

<span class="mark">add_library(ui src4.cpp)</span>

<span class="mark">add_executable(myApp main.cpp)</span>

<span class="mark"></span>

<span class="mark">target_link_libraries(collector</span>

<span class="mark">PUBLIC ui</span>

<span class="mark">PRIVATE algo engine</span>

<span class="mark">)</span>

<span class="mark">target_link_libraries(myApp PRIVATE collector)</span>

\#------------------------------------\<\<\<\<\<\<

In this example, the ui library is linked to the collector library as PUBLIC, so even though myApp only directly links to collector, myApp will also be linked to ui because of that PUBLIC relationship. The algo and engine libraries, on the other hand, are linked to collector as PRIVATE, so myApp will not be directly linked to them. Section 16.2, “Libraries” discusses additional behaviors for static libraries which may result in further linking to satisfy dependency relationships, including cyclic dependencies. 【译】在这个例子中，ui库作为PUBLIC链接到收集器库，因此即使myApp只直接链接到收集器，由于PUBLIC关系，myApp也会链接到ui。另一方面，算法库和引擎库作为PRIVATE链接到收集器，因此myApp不会直接链接到它们。第16.2节“库”讨论了静态库的其他行为，这些行为可能会导致进一步链接以满足依赖关系，包括循环依赖关系。

Later chapters present a few other target\_…() commands which further enhance the dependency information carried between targets. These allow compiler/linker flags and header search paths to also carry through from one target to another when they are connected by target_link_libraries(). These features were added progressively from CMake 2.8.11 through to 3.2 and lead to considerably simpler and more robust CMakeLists.txt files. 【译】后面的章节介绍了其他一些target\_…()命令，这些命令进一步增强了目标之间携带的依赖信息。这些允许编译器/链接器标志和标头搜索路径在通过target_link_libraies()连接时从一个目标传递到另一个目标。从CMake 2.8.11到3.2，这些功能是逐步添加的，从而产生了更简单、更健壮的CMakeLists.txt文件。

Later chapters also discuss the use of more complex source directory hierarchies. In such cases, the targetName used with target_link_libraries() must have been defined by an add_executable() or add_library() command in the same directory from which target_link_libraries() is being called.

【译】后面的章节还讨论了更复杂的源目录层次结构的使用。在这种情况下，与target_link_libraries()一起使用的targetName必须由调用target_link_libraries 的同一目录中的add_executable() 或add_library() 命令定义。

## 4.4. Linking Non-targets

In the preceding section, all the items being linked to were existing CMake targets, but the target_link_libraries() command is more flexible than that. In addition to CMake targets, the following things can also be specified as items in a target_link_libraries() command: 【译】在上一节中，所有链接到的项目都是现有的CMake目标，但target_link_libraries()命令比这更灵活。除了CMake目标，以下内容也可以在 target_link_libraries()命令中指定为项目：

\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

**\#(1)Full path to a library file**

CMake will add the library file to the linker command. If the library file changes, CMake will detect that change and re-link the target. Note that from CMake version 3.3, the linker command always uses the full path specified, but prior to version 3.3, there were some situations where CMake may ask the linker to search for the library instead (e.g. replace /usr/lib/libfoo.so with -lfoo). The reasoning and details of the pre-3.3 behavior are non-trivial and are largely historical, but for the interested reader, the full set of information is available in the CMake documentation under the CMP0060 policy. 【译】CMake会将库文件添加到链接器命令中。如果库文件发生更改，CMake将检测到该更改并重新链接目标。请注意，从CMake 3.3版本开始，链接器命令始终使用指定的完整路径，但在3.3版本之前，在某些情况下，CMake可能会要求链接器搜索库（例如，用-lfo替换/usr/lib/libfoo.so）。3.3之前的行为的推理和细节并不简单，而且很大程度上是历史性的，但对于感兴趣的读者来说，CMP0060策略下的CMake文档中提供了全套信息。

**\#(2)Plain library name**

If just the name of the library is given with no path, the linker command will search for that library (e.g. foo becomes -lfoo or foo.lib, depending on the platform). This would be common for libraries provided by the system. 【译】如果只给出库的名称而没有路径，则链接器命令将搜索该库（例如，foo变为-lfoo或foo.lib，具体取决于平台）。这对于系统提供的图书馆来说很常见。

**\#(3)Link flag**

As a special case, items starting with a hyphen other than -l or -framework will be treated as flags to be added to the linker command. The CMake documentation warns that these should only be used for PRIVATE items, since they would be carried through to other targets if defined as PUBLIC or INTERFACE and this may not always be safe. 【译】作为一种特殊情况，以-l或-framework以外的连字符开头的项将被视为要添加到链接器命令中的标志。CMake文档警告说，这些只能用于PRIVATE项目，因为如果定义为PUBLIC或INTERFACE，它们将被传递到其他目标，这可能并不总是安全的。

\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

In addition to the above, for historical reasons, any item may be preceded by one of the keywords debug, optimized or general. The effect of these keywords is to further refine when the item following it should be included based on whether or not the build is configured as a debug build (see Chapter 13, Build Type). If an item is preceded by the debug keyword, then it will only be added if the build is a debug build. If an item is preceded by the optimized keyword, it will only be added if the build is not a debug build. The general keyword specifies that the item should be added for all build configurations, which is the default behavior anyway if no keyword is used. The debug, optimized and general keywords should be avoided for new projects as there are clearer, more flexible and more robust ways to achieve the same thing with today’s CMake features. 【译】除上述之外，由于历史原因，任何项目前面都可能有一个关键字debug、optimized或general。这些关键字的作用是根据构建是否配置为调试构建（见第13章，构建类型），进一步细化何时应包含其后面的项目。

如果一个项目前面有debug关键字，那么只有当构建是调试构建时，才会添加它。

如果一个项目前面有optimized关键字，则只有在构建不是调试构建时才会添加它。

general关键字指定应为所有构建配置添加该项，如果不使用关键字，这仍然是默认行为。

对于新项目，应避免使用调试、优化和通用关键字，因为有更清晰、更灵活、更强大的方法来实现与当今CMake功能相同的功能。

## 4.5. Old-style CMake

The target_link_libraries() command also has a few other forms, some of which have been part of CMake from well before version 2.8.11. These forms are discussed here for the benefit of understanding older CMake projects, but their use is generally discouraged for new projects. The full form shown previously with PRIVATE, PUBLIC and INTERFACE sections should be preferred, as it expresses the nature of dependencies with more accuracy. 【译】target_link_libraries() 命令还有其他几种形式，其中一些早在2.8.11版本之前就已经是CMake的一部分。这里讨论这些表单是为了更好地理解旧的CMake项目，但通常不建议在新项目中使用它们。应该首选之前用PRIVATE、PUBLIC和INTERFACE部分显示的完整形式，因为它更准确地表达了依赖关系的性质。

\`\`\`cmake

target_link_libraries(targetName item \[item...\])

\`\`\`

The above form is generally equivalent to the items being defined as PUBLIC, but in certain situations, they may instead be treated as PRIVATE. In particular, if a project defines a chain of library dependencies with a mix of both old and new forms of the command, the old-style form will generally be treated as PRIVATE. 【译】上述形式通常相当于被定义为PUBLIC的项，但在某些情况下，它们可能会被视为PRIVATE。特别是，如果一个项目定义了一个包含新旧命令形式的库依赖关系链，则旧式形式通常会被视为PRIVATE。

Another supported but deprecated form is the following: 【译】另一种受支持但已弃用的形式如下：

\`\`\`cmake

target_link_libraries(targetName

LINK_INTERFACE_LIBRARIES item \[item...\]

)

\`\`\`

This is a pre-cursor to the INTERFACE keyword of the newer form covered above, but its use is discouraged by the CMake documentation. Its behavior can affect different target properties, with the policy settings controlling that behavior. This is a potential source of confusion for developers which can be avoided by using the newer INTERFACE form instead. 【译】这是上面介绍的较新形式关键字INTERFACE的前辈，但CMake文档不建议使用它。它的行为会影响不同的目标属性，由策略设置控制该行为。这对开发人员来说是一个潜在的混淆源，可以通过使用较新的INTERFACE形式来避免。

\`\`\`cmake

target_link_libraries(targetName

\<LINK_PRIVATE\|LINK_PUBLIC\> lib \[lib...\]

\[\<LINK_PRIVATE\|LINK_PUBLIC\> lib \[lib...\]\]

)

\`\`\`

Similar to the previous old-style form, this one is a pre-cursor to the PRIVATE and PUBLIC keyword versions of the newer form. Again, the old-style form has the same confusion over which target properties it affects and the PRIVATE/PUBLIC keyword form should be preferred for new projects.

【译】与之前的旧式形式类似，这个是新形式的PRIVATE和PUBLIC关键字版本的前辈。同样，旧式形式在影响哪些目标属性方面也存在同样的混淆，新项目应首选PRIVATE/PUBLIC关键词形式。

## 4.6. Recommended Practices

Target names need not be related to the project name. It is common to see tutorials and examples use a variable for the project name and reuse that variable for the name of an executable target like so: 【译】目标名称不需要与项目名称相关。常见的情况是，教程和示例使用变量作为项目名称，并重用该变量作为可执行目标的名称，如下所示：

\#------------------------------------\>\>\>\>\>\>

\# Poor practice, but very common

set(projectName MyExample)

project(\${projectName})

add_executable(\${projectName} ...)

\#------------------------------------\<\<\<\<\<\<

This only works for the most basic of projects and encourages a number of bad habits. Consider the project name and executable name as being separate, even if initially they start out the same. Set the project name directly rather than via a variable, choose a target name according to what the target does rather than the project it is part of and assume the project will eventually need to define more than one target. This reinforces better habits which will be important when working on more complex multi-target projects. 【译】这只适用于最基本的项目，并鼓励一些坏习惯。将项目名称和可执行文件名称视为独立的，即使它们最初是相同的。直接设置项目名称，而不是通过变量，根据目标的功能而不是它所属的项目选择目标名称，并假设项目最终需要定义多个目标。这强化了更好的习惯，这在处理更复杂的多目标项目时非常重要。

When naming targets for libraries, resist the temptation to start or end the name with lib. On many platforms (i.e. just about all except Windows), a leading lib will be prefixed automatically when constructing the actual library name to make it conform to the platform’s usual convention. If the target name already begins with lib, the resultant library file names end up with the form liblibsomething…., which people often assume to be a mistake. 【译】为库命名目标时，请抵制以lib开头或结尾的诱惑。在许多平台上（即除了Windows之外的几乎所有平台），在构造实际库名称时，会自动为前导库添加前缀，使其符合平台的通常约定。如果目标名称已经以lib开头，则生成的库文件名将以liblibsomething…的形式结束…。，人们通常认为这是一个错误。

Unless there are strong reasons to do so, try to avoid specifying the STATIC or SHARED keyword for a library until it is known to be needed. This allows greater flexibility in choosing between static or dynamic libraries as an overall project-wide strategy. The BUILD_SHARED_LIBS variable can be used to change the default in one place instead of having to modify every call to add_library(). 【译】除非有充分的理由这样做，否则在知道需要之前，尽量避免为库指定STATIC或SHARED关键字。这使得在静态或动态库之间进行选择时具有更大的灵活性，作为整个项目的整体策略。BUILD_SHARED_LIBS变量可用于在一个地方更改默认值，而不必修改对add_library()的每次调用。

Aim to always specify PRIVATE, PUBLIC and/or INTERFACE keywords when calling the target_link_libraries() command rather than following the old-style CMake syntax which assumed everything was PUBLIC. As a project grows in complexity, these three keywords have a stronger impact on how inter-target dependencies are handled. Using them from the beginning of a project also forces developers to think about the dependencies between targets, which can help to highlight structural problems within the project much earlier. 【译】在调用target_link_libraries()命令时，始终指定PRIVATE、PUBLIC和/或INTERFACE关键字，而不是遵循旧式的CMake语法，该语法假设所有内容都是PUBLIC。随着项目复杂性的增加，这三个关键字对如何处理目标间的依赖关系有更大的影响。从项目一开始就使用它们也会迫使开发人员考虑目标之间的依赖关系，这有助于更早地突出项目中的结构问题。
