# Ch3. A Minimal Project

All CMake projects start with a file called CMakeLists.txt and it is expected to be placed at the top of the source tree. Think of it as the CMake project file, defining everything about the build from sources and targets through to testing, packaging and other custom tasks. It can be as simple as a few lines or it can be quite complex and pull in more files from other directories. CMakeLists.txt is just an ordinary text file and is usually edited directly, just like any other source file in the project. 【译】所有CMake项目都从一个名为CMakeLists.txt的文件开始，该文件预计将放置在源代码树的顶部。将其视为CMake项目文件，定义了从源代码和目标到测试、打包和其他自定义任务的所有构建内容。它可以简单到几行，也可以非常复杂，从其他目录中提取更多文件。CMakeLists.txt只是一个普通的文本文件，通常可以直接编辑，就像项目中的任何其他源文件一样。

Continuing the analogy with sources, CMake defines its own language which has many things a programmer would be familiar with, such as variables, functions, macros, conditional logic, looping, code comments and so on. These various concepts and features are covered in the next few chapters, but for now, the goal is just to get a simple build working as a starting point. The following is a minimal, well-formed CMakeLists.txt file producing a basic executable. 【译】继续与源代码进行类比，CMake定义了自己的语言，其中有许多程序员熟悉的东西，如变量、函数、宏、条件逻辑、循环、代码注释等。这些不同的概念和功能将在接下来的几章中介绍，但目前的目标只是让一个简单的构建作为起点。以下是一个最小的、格式良好的CMakeLists.txt文件，用于生成基本的可执行文件。

\#------------------------------------\>\>\>\>\>\>

<span class="mark">cmake_minimum_required(VERSION 3.2)</span>

<span class="mark">project(MyApp)</span>

<span class="mark">add_executable(myExe main.cpp)</span>

\#------------------------------------\<\<\<\<\<\<

Each line in the above example executes a built-in CMake command. In CMake, commands are similar to other languages’ function calls, except that while they support arguments, they do not return values directly (but a later chapter shows how to pass values back to the caller in other ways). Arguments are separated from each other by spaces and may be split across multiple lines: 【译】上述示例中的每一行都执行一个内置的CMake命令。在CMake中，命令类似于其他语言的函数调用，除了虽然它们支持参数，但它们不直接返回值（但后面的章节将展示如何以其他方式将值传递回调用者）。参数之间用空格分隔，可以拆分为多行：

\`\`\`cmake

add_executable(myExe

main.cpp

src1.cpp

src2.cpp

)

\`\`\`

Command names are also case insensitive, so the following are all equivalent: 【译】命令名也不区分大小写，因此以下内容都是等效的：

\#------------------------------------\>\>\>\>\>\>

add_executable(myExe main.cpp)

ADD_EXECUTABLE(myExe main.cpp)

Add_Executable(myExe main.cpp)

\#------------------------------------\<\<\<\<\<\<

Typical style varies, but the more common convention these days is to use all lowercase for command names (this is also the convention followed by the CMake documentation for built-in commands). 【译】典型的样式各不相同，但如今更常见的约定是命令名全部小写（这也是CMake文档中内置命令遵循的约定）

## 3.1. Managing CMake versions

CMake is continually updated and extended to add support for new tools, platforms and features. The developers behind CMake are very careful to maintain backwards compatibility with each new release, so when users update to a newer version of CMake, projects should continue to build as they did before. Sometimes, a particular CMake behavior needs to change or more stringent checks and warnings may be introduced in newer versions. Rather than requiring all projects to immediately deal with this, CMake provides policy mechanisms which allow the project to say “Behave like CMake version X.Y.Z”. This allows CMake to fix bugs internally and introduce new features, but still maintain the expected behavior of any particular past release.

【译】CMake不断更新和扩展，以添加对新工具、平台和功能的支持。CMake背后的开发人员非常小心地保持与每个新版本的向后兼容性，因此当用户更新到较新版本的CMake时，项目应该继续像以前一样构建。有时，需要更改特定的CMake行为，或者在较新版本中引入更严格的检查和警告。CMake没有要求所有项目立即处理这个问题，而是提供了策略机制，允许项目说“行为像CMake X.Y.Z版本”。这允许CMake在内部修复错误并引入新功能，但仍然保持任何特定过去版本的预期行为。

The primary way a project specifies details about its expected CMake version behavior is with the cmake_minimum_required() command. This should be the first line of the CMakeLists.txt file so that the project’s requirements are checked and established before anything else. This command does two things: 【译】项目指定其预期CMake版本行为细节的主要方式是使用CMake_minimum_required() 命令。这应该是CMakeLists.txt文件的第一行，以便在其他任何事情之前检查和确定项目的需求。此命令执行两项操作：

• It specifies the minimum version of CMake the project needs. If the CMakeLists.txt file is processed with a CMake version older than the one specified, it will halt immediately with an error. This ensures that a particular minimum set of CMake functionality is available before proceeding. 【译】它指定了项目所需的CMake的最低版本。如果使用比指定版本旧的CMake版本处理CMakeLists.txt文件，它将立即停止并显示错误。这确保了在继续之前，有一组特定的最低CMake功能可用。

• It enforces policy settings to match CMake behavior to the specified version. 【译】它强制执行策略设置，使CMake行为与指定版本相匹配。

Using this command is so important that CMake will issue a warning if the CMakeLists.txt file does not call cmake_minimum_required() before any other command. It needs to know how to set up the policy behavior for all subsequent processing. For most projects, it is enough to treat cmake_minimum_required() as simply specifying the minimum required CMake version, as its name suggests. The fact that it also implies CMake should behave the same as that particular version can be considered a useful side benefit. Chapter 12, Policies discusses policy settings in more detail and explains how to tailor this behavior as needed. 【译】使用此命令非常重要，如果CMakeLists.txt文件在任何其他命令之前没有调用CMake_minimum_required() ，CMake将发出警告。它需要知道如何为所有后续处理设置策略行为。对于大多数项目来说，正如其名称所暗示的那样，将cmake_minimum_required()视为简单地指定所需的最低cmake版本就足够了。这也意味着CMake的行为应该与特定版本相同，这可以被认为是一个有用的附带好处。第12章“策略”更详细地讨论了策略设置，并解释了如何根据需要定制此行为。

The typical form of the cmake_minimum_required() command is straightforward: 【译】cmake_minimum_required()命令的典型形式很简单：

\`\`\`cmake

cmake_minimum_required(VERSION major.minor\[.patch\[.tweak\]\])

\`\`\`

The VERSION keyword must always be present and the version details provided must have at least the major.minor part. In most projects, specifying the patch and tweak parts is not necessary, since new features typically only appear in minor version updates (this is the official CMake behavior from version 3.0 onwards). Only if a specific bug fix is needed should a project specify a patch part. Furthermore, since no CMake release in the 3.x series has used a tweak number, projects should not need to specify one either. 【译】VERSION关键字必须始终存在，提供的版本详细信息必须至少包含major.minor部分。在大多数项目中，指定补丁和调整部分是不必要的，因为新功能通常只出现在次要版本更新中（这是从3.0版本开始的CMake官方行为）。只有当需要特定的bug修复时，项目才应该指定补丁部分。此外，由于3.x系列中没有CMake版本使用调整编号，因此项目也不需要指定一个。

Developers should think carefully about what minimum CMake version their project should require. Version 3.2 is perhaps the oldest any new project should consider, since it provides a reasonably complete feature set for modern CMake techniques. Version 2.8.12 has a reduced feature coverage, lacking a number of useful features but it may be workable for older projects. Versions before that lack substantial features that would make using many modern CMake techniques impossible. If working with fast-moving platforms such as iOS, quite recent versions of CMake may be needed in order to support the latest OS releases, etc. 【译】开发人员应该仔细考虑他们的项目应该需要的最低CMake版本。**3.2版本**可能是任何新项目都应该考虑的最古老的版本，因为它为现代CMake技术提供了相当完整的功能集。2.8.12版本的功能覆盖率较低，缺少许多有用的功能，但它可能适用于旧项目。在此之前的版本缺乏实质性的功能，这使得使用许多现代CMake技术变得不可能。如果使用iOS等快速发展的平台，可能需要相当新版本的CMake来支持最新的操作系统版本等。

As a general rule of thumb, choose the most recent CMake version that won’t present significant problems for those building the project. The greatest difficulty is typically experienced by projects that need to support older platforms where the system-provided version of CMake may be quite old. For such cases, if at all possible, developers should consider installing a more recent release rather than restricting themselves to very old CMake versions. On the other hand, if the project will itself be a dependency for other projects, then choosing a more recent CMake version may present a hurdle for adoption. In such cases, it may be beneficial to instead require the oldest CMake version that still provides the minimum CMake features needed, but make use of features from later CMake versions if available (“Chapter 12, Policies” presents techniques for achieving this). This will prevent other projects from being forced to require a more recent version than their target environment typically allows or provides. Dependent projects can always require a more recent version if they so wish, but they cannot require an older one. The main disadvantage of using the oldest workable version is that it may result in more deprecation warnings, since newer CMake versions will warn about older behaviors to encourage projects to update themselves. 【译】一般来说，选择最新的CMake版本不会给构建项目的人带来重大问题。需要支持旧平台的项目通常会遇到最大的困难，因为系统提供的CMake版本可能很旧。对于这种情况，如果可能的话，开发人员应该考虑安装更新的版本，而不是将自己限制在非常旧的CMake版本上。另一方面，如果项目本身是其他项目的依赖项，那么选择较新的CMake版本可能会给采用带来障碍。在这种情况下，要求最旧的CMake版本可能是有益的，该版本仍然提供所需的最低CMake功能，但如果可用，可以使用更高版本的CMake功能（“第12章，政策”介绍了实现这一目标的技术）。这将防止其他项目被迫要求比其目标环境通常允许或提供的版本更新。如果他们愿意，依赖项目总是需要一个更新的版本，但他们不能需要一个旧的版本。使用最旧的可用版本的主要缺点是，它可能会导致更多的弃用警告，因为较新的CMake版本会警告旧的行为，以鼓励项目自我更新。

## 3.2. The project() Command

Every CMake project should contain a project() command and it should appear after cmake_minimum_required() has been called. The command with its most common options has the following form: 【译】每个CMake项目都应该包含一个project()命令，并且应该在调用cmake_minimum_required()后出现。命令及其最常见的选项具有以下形式：

\`\`\`cmake

project(projectName

\[VERSION major\[.minor\[.patch\[.tweak\]\]\]\]

\[LANGUAGES languageName ...\]

)

\`\`\`

The projectName is required and may only contain letters, numbers, underscores (\_) and hyphens (-), although typically only letters and perhaps underscores are used in practice. Since spaces are not permitted, the project name does not have to be surrounded by quotes. This name is used for the top level of a project with some project generators (eg Xcode and Visual Studio) and it is also used in various other parts of the project, such as to act as defaults for packaging and documentation metadata, to provide project-specific variables and so on. The name is the only mandatory argument for the project() command. 【译】projectName是必需的，并且只能包含字母、数字、下划线（\_）和连字符（-），尽管在实践中通常只使用字母和下划线。由于不允许使用空格，因此项目名称不必用引号括起来。此名称用于具有某些项目生成器（如Xcode和Visual Studio）的项目的顶层，也用于项目的其他各个部分，例如作为打包和文档元数据的默认值，提供特定于项目的变量等。该名称是project() 命令的唯一强制参数。

The optional VERSION details are only supported in CMake 3.0 and later. Like the projectName, the version details are used by CMake to populate some variables and as default package metadata, but other than that, the version details don’t have any other significance. Nonetheless, a good habit to establish is to define the project’s version here so that other parts of the project can refer to it. “Chapter 19, Specifying Version Details” covers this in depth and explains how to refer to this version information later in the CMakeLists.txt file. 【译】可选的版本详细信息仅在CMake 3.0及更高版本中受支持。与projectName一样，CMake使用版本详细信息来填充一些变量并作为默认包元数据，但除此之外，版本详细信息没有任何其他意义。尽管如此，一个好习惯是在这里定义项目的版本，以便项目的其他部分可以引用它。“第19章，指定版本详细信息”对此进行了深入的介绍，并解释了如何在后面的CMakeLists.txt文件中引用此版本信息。

The optional LANGUAGES argument defines the programming languages that should be enabled for the project. Supported values include C, CXX, Fortran, ASM, Java and others. If specifying multiple languages, separate each with a space. In some special situations, projects may want to indicate that no languages are used, which can be done using LANGUAGES NONE. Techniques introduced in later chapters take advantage of this particular form. If no LANGUAGES option is provided, CMake will default to C and CXX. CMake versions prior to 3.0 do not support the LANGUAGES keyword, but languages can still be specified after the project name using the older form of the command like so: 【译】可选的LANGUAGES参数定义了应为项目启用的编程语言。支持的值包括C、CXX、Fortran、ASM、Java等。如果指定多种语言，请用空格分隔每种语言。在某些特殊情况下，项目可能希望表明没有使用任何语言，这可以使用LANGUAGE NONE来完成。后面章节中介绍的技术利用了这种特殊的形式。如果没有提供LANGUAGES选项，CMake将默认为C和CXX。CMake 3.0之前的版本不支持LANGUAGES关键字，但仍然可以使用旧形式的命令在项目名称后指定语言，如下所示：

\`\`\`cmake

project(myProj C CXX)

\`\`\`

New projects are encouraged to specify a minimum CMake version of at least 3.0 and use the new form with the LANGUAGES keyword instead. 【译】鼓励新项目指定至少3.0的最低CMake版本，并使用带有LANGUAGES关键字的新表单。

The project() command does much more than just populate a few variables. One of its important responsibilities is to check the compilers for each enabled language and ensure they are able to compile and link successfully. Problems with the compiler and linker setup are then caught very early. Once these checks have passed, CMake sets up a number of variables and properties which control the build for the enabled languages. If the CMakeLists.txt file does not call project() or does not call it early enough, CMake will implicitly call it internally for the default languages C and CXX to ensure compilers and linkers are properly set up for other commands which rely on them. Later chapters give further details on setting up the toolchain and demonstrate how to query and modify things like compiler flags, compiler locations, etc. 【译】project()命令的作用远不止填充几个变量。其重要职责之一是检查每种启用语言的编译器，并确保它们能够成功编译和链接。编译器和链接器设置的问题很早就被发现了。一旦这些检查通过，CMake就会设置许多变量和属性来控制所启用语言的构建。如果CMakeLists.txt文件没有调用project()或没有足够早地调用它，CMake将在默认语言C和CXX的内部隐式调用它，以确保为依赖它们的其他命令正确设置编译器和链接器。后面的章节将详细介绍如何设置工具链，并演示如何查询和修改编译器标志、编译器位置等。

When the compiler and linker checks performed by CMake are successful, their results are cached so that they do not have to be repeated in subsequent CMake runs. These cached details are stored in the build directory in the CMakeCache.txt file. Additional details about the checks can be found in subdirectories within the build area, but developers would typically only need to look there if working with a new or unusual compiler or when setting up toolchain files for cross-compiling. 【译】当CMake执行的编译器和链接器检查成功时，它们的结果会被缓存，这样在后续的CMake运行中就不必重复。这些缓存的详细信息存储在CMakeCache.txt文件的构建目录中。有关检查的其他详细信息可以在构建区域内的子目录中找到，但开发人员通常只需要在使用新的或不寻常的编译器或设置交叉编译的工具链文件时查看那里。

## 3.3. Building A Basic Executable

To complete our minimal example, the add_executable() command tells CMake to create an executable from a set of source files. The basic form of this command is:

\`\`\`cmake

add_executable(targetName source1 \[source2 ...\])

\`\`\`

This creates an executable which can be referred to within the CMake project as targetName. This name may contain letters, numbers, underscores and hyphens. When the project is built, an executable will be created in the build directory with a platform-dependent name, the default name being based on the target name. Consider the following simple example command:

【译】这将创建一个可执行文件，在CMake项目中可以将其称为targetName。此名称可以包含字母、数字、下划线和连字符。构建项目时，将在构建目录中创建一个具有平台相关名称的可执行文件，默认名称基于目标名称。考虑以下简单的示例命令：

\`\`\`cmake

add_executable(myApp main.cpp)

\`\`\`

By default, the name of the executable would be myApp.exe on Windows and myApp on Unix-based platforms like macOS, Linux, etc. The executable name can be customized with target properties, a CMake feature introduced in “Chapter 9, Properties”. Multiple executables can also be defined within the one CMakeLists.txt file by calling add_executable() multiple times with different target names. If the same target name is used in more than one add_executable() command, CMake will fail and highlight the error. 【译】默认情况下，可执行文件的名称在Windows上为myApp.exe，在macOS、Linux等基于Unix的平台上为myApp。可执行文件名可以使用目标属性进行自定义，这是“第9章，属性”中介绍的CMake功能。通过使用不同的目标名称多次调用add_executable()，也可以在一个CMakeLists.txt文件中定义多个可执行文件。如果在多个add_executable()命令中使用了相同的目标名称，CMake将失败并突出显示错误。

## 3.4. Commenting

Before leaving this chapter, it will be useful to demonstrate how to add comments to a CMakeLists.txt file. Comments are used extensively throughout this book and developers are encouraged to also get into the habit of commenting their projects just as they would for ordinary source code. CMake follows similar commenting conventions as Unix shell scripts. Any line beginning with a \# character is treated as a comment. Except within a quoted string, anything after a \# on a line within a CMakeLists.txt file is also treated as a comment. The following shows a few comment examples and brings together the concepts introduced in this chapter: 【译】在离开本章之前，演示如何向CMakeLists.txt文件添加注释将很有用。本书中广泛使用了注释，鼓励开发人员养成像注释普通源代码一样注释项目的习惯。CMake遵循与Unix shell脚本类似的注释约定。任何以#字符开头的行都被视为注释。除了引号内的字符串外，CMakeLists.txt文件中一行#之后的任何内容也被视为注释。下面显示了一些评论示例，并汇集了本章介绍的概念：

\#------------------------------------\>\>\>\>\>\>

<span class="mark">cmake_minimum_required(VERSION 3.2)</span>

<span class="mark"></span>

<span class="mark">\# We don't use the C++ compiler, so don't let project()</span>

<span class="mark">\# test for it in case the platform doesn't have one</span>

<span class="mark">project(MyApp VERSION 4.7.2 LANGUAGES C)</span>

<span class="mark"></span>

<span class="mark">\# Primary tool for this project</span>

<span class="mark">add_executable(mainTool</span>

<span class="mark"> main.c</span>

<span class="mark"> debug.c \# Optimized away for release builds</span>

<span class="mark">)</span>

<span class="mark"></span>

<span class="mark">\# Helpful diagnostic tool for development and testing</span>

<span class="mark">add_executable(testTool testTool.c)</span>

\#------------------------------------\<\<\<\<\<\<

## 3.5. Recommended Practices

Ensure every CMake project has a cmake_minimum_required() command as the first line of its top level CMakeLists.txt file. When deciding the minimum required version number to specify, keep in mind that the later the version, the more CMake features the project will be able to use. It will also mean the project is likely to be better placed to adapt to new platform or operating system releases, which inevitably introduce new things for build systems to deal with. Conversely, if creating a project intended to be built and distributed as part of the operating system itself (common for Linux), the minimum CMake version is likely to be dictated by the version of CMake provided by that same distribution. 【译】确保每个CMake项目都有一个CMake_minimum_required()命令作为其顶级CMakeLists.txt文件的第一行。在决定要指定的最低版本号时，请记住，版本越晚，项目能够使用的CMake功能就越多。这也意味着该项目可能会更好地适应新的平台或操作系统版本，这些版本不可避免地会为构建系统带来新的东西。 相反，如果创建的项目旨在作为操作系统本身的一部分进行构建和分发（Linux常见），则最低CMake版本可能由同一发行版提供的CMake版本决定。

If the project can require CMake 3.0 or later, it is also good to force thinking about project version numbers early and start incorporating version numbering into the project() command as soon as possible. It can be very hard to overcome the inertia of existing processes and change how version numbers are handled later in the life of a project. Consider popular practices such as “Semantic Versioning” when deciding on a versioning strategy. 【译】如果项目需要CMake 3.0或更高版本，最好尽早考虑项目版本号，并尽快将版本号合并到project()命令中。在项目生命周期的后期，很难克服现有流程的惯性并改变版本号的处理方式。在决定版本控制策略时，考虑“语义版本控制”等流行做法

