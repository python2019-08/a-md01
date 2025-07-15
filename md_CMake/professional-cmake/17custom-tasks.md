
# Ch17. Custom Tasks

No build tool can ever hope to implement every feature that will ever be needed by any given project. At some point, developers will need to carry out a task that falls outside the directly supported functionality. For example, a special tool may need to be run to produce source files or to post-process a target after it has been built. Files may need to be copied, verified or a hash value computed. Build artifacts may need to be archived or a notification service contacted. These and other tasks don’t always fit into a predictable pattern that allows them to be easily provided as a general build system capability. 【译】没有一个构建工具能够实现任何给定项目所需的每一个功能。在某些时候，开发人员将需要执行直接支持功能之外的任务。例如，可能需要运行一个特殊的工具来生成源文件，或者在构建目标后对其进行后处理。可能需要复制、验证文件或计算哈希值。构建工件可能需要存档或联系通知服务。这些和其他任务并不总是符合一种可预测的模式，这种模式允许它们作为通用的构建系统功能轻松提供。

CMake supports such tasks through custom commands and custom targets. These allow any command or set of commands to be executed at build time to perform whatever arbitrary tasks a project requires. CMake also supports executing tasks at configure time, enabling various techniques that rely on tasks being completed before the build stage or even before processing later parts of the current CMakeLists.txt file.【译】CMake通过**自定义命令**和**自定义目标**支持此类任务。这些允许在**构建时**执行任何命令或命令集，以执行项目所需的任何任意任务。CMake还支持在**配置时**执行任务，支持各种技术，这些技术依赖于在构建阶段之前甚至在处理当前CMakeLists.txt文件的后续部分之前完成的任务。

## 17.1. Custom Targets

Library and executable targets are not the only kinds of targets CMake supports. Projects can also define their own custom targets that perform arbitrary tasks defined as a sequence of commands to be executed at build time. These custom targets are defined using the add_custom_target() command:

【译】库和可执行目标并不是CMake支持的唯一目标类型。项目还可以定义自己的自定义目标，这些目标执行任意任务，这些任务被定义为在构建时执行的一系列命令。这些自定义目标是使用add_custom_target()命令定义的：

\`\`\`cmake

add_custom_target(targetName \[ALL\]

> \[command1 \[args1...\]\]
>
> \[COMMAND command2 \[args2...\]\]
>
> \[DEPENDS depends1...\]
>
> \[BYPRODUCTS \[files...\]\]
>
> \[WORKING_DIRECTORY dir\]
>
> \[COMMENT comment\]
>
> \[VERBATIM\]
>
> \[USES_TERMINAL\]
>
> \[SOURCES source1 \[source2...\]\]

)

\`\`\`

A new target with the specified targetName will be available to the build. The ALL option makes the all target depend on this new custom target (the various generators name the all target slightly differently, but it is generally something like all, ALL or similar). If the ALL option is not provided, then the target is only ever built if it is explicitly requested or if building some other target that depends on it. The custom target is always considered out of date, so bringing any target that depends on it up to date will result in the commands being executed.

【译】具有指定targetName的新目标将可用于构建。ALL选项 使所有目标依赖于这个新的自定义目标（各种生成器对所有目标的命名略有不同，但通常类似于ALL、ALL或类似）。如果未提供ALL选项，则只有在明确请求或构建依赖于它的其他目标时，才会构建目标。自定义目标**始终被视为已过时**，因此使依赖它的任何目标保持最新状态将导致命令被执行。

When the custom target is built, the specified command(s) will be executed in the order given, with each command able to have any number of arguments. For improved readability, arguments can be split across multiple lines. The first command does not need to have the COMMAND keyword preceding it, but for clarity it is recommended to always include the COMMAND keyword even for the first command. This is especially true when specifying multiple commands, since it makes each command use a consistent form.

【译】构建自定义目标后，将按给定的顺序执行指定的命令，每个命令都可以有任意数量的参数。为了提高可读性，可以将参数拆分为多行。第一个命令前不需要有command关键字，但为了清楚起见，建议即使对于第一个命令也始终包含command关键字。在指定多个命令时尤其如此，因为它使每个命令使用一致的形式。

Commands can be defined to do anything that could be performed on the host platform. Typical commands involve running a script or a system-provided executable, but they can also run executable targets created as part of the build. If another executable target name is listed as the command to execute, CMake will automatically substitute the built location of that other target’s executable. This works regardless of the platform or CMake generator being used, thereby freeing the project from having to work out the various platform and generator differences that lead to a range of different output directory structures, file names, etc. If another target needs to be used as an argument to one of the commands, CMake will not automatically perform the same substitution, but it is trivial to obtain an equivalent substitution with the TARGET_FILE generator expression. Projects should take advantage of these features to let CMake provide locations of targets rather than hard-coding paths manually, as this allows the project to robustly support all platforms and generator types with minimal effort. The following example shows how to define a custom target which uses two other targets as part of the command and argument list:

【译】可以定义命令来执行可以在主机平台上执行的任何操作。典型的命令涉及运行脚本或系统提供的可执行文件，但它们也可以运行作为构建的一部分创建的可执行目标。 如果另一个可执行目标名称被列为要执行的命令，CMake将自动替换该另一个目标的可执行文件的构建位置。无论使用哪种平台或CMake生成器，这都是有效的，从而使项目不必计算出导致一系列不同输出目录结构、文件名等的各种平台和生成器差异。如果需要将另一个目标用作其中一个命令的参数，CMake将不会自动执行相同的替换，但使用TARGET_FILE生成器表达式获得等效替换是轻而易举的。项目应该利用这些功能，让CMake提供目标的位置，而不是手动硬编码路径，因为这使项目能够以最小的努力稳健地支持所有平台和生成器类型。以下示例显示了如何定义一个自定义目标，该目标使用另外两个目标作为命令和参数列表的一部分：

\#------------------------------------\>\>\>\>\>\>

add_executable(hasher hasher.cpp)

add_library(myLib api.cpp)

add_custom_target(createHash

COMMAND hasher \$\<TARGET_FILE:myLib\>

)

\#------------------------------------\<\<\<\<\<\<

When a target is used as the command to execute, CMake automatically creates a dependency on that executable target to ensure it is built before the custom target. Similarly, if a target is referred to in a generator expression anywhere in the command or its arguments, a dependency is automatically created on that target too. If a dependency on any other target needs to be specified, the add_dependencies() command can be used to define that relationship. If a dependency exists on a file rather than a target, the DEPENDS keyword can be used to specify that relationship as part of the add_custom_target() call directly. Note that DEPENDS should not be used for target dependencies, only file dependencies. The DEPENDS keyword is especially useful when the file being listed is generated by some other custom command (see Section 17.3, “Commands That Generate Files” further below), where CMake will set up the necessary dependencies to ensure the other custom commands execute before this custom target’s commands. Always use an absolute path for DEPENDS, since relative paths can give unexpected results due to a legacy feature that allows path matching against multiple locations.

【译】当目标用作执行命令时，CMake会自动创建对该可执行目标的依赖关系，以确保它在自定义目标之前构建。同样，如果在命令或其参数的**<u>生成器表达式</u>**中的任何位置引用了目标，则也会自动在该目标上创建依赖关系。

如果需要指定对任何其他目标的依赖关系，可以使用add_dependencies()命令来定义这种关系。

如果依赖关系存在于文件而不是目标上，则可以使用DEPENDS关键字直接在add_custom_target()调用中指定该关系。请注意，DEPENDS不应用于目标依赖关系，**只应用于文件依赖关系**。当列出的文件是由其他自定义命令生成时，DEPENDS关键字特别有用（见下文第17.3节“生成文件的命令”），CMake将设置必要的依赖关系，以确保其他自定义命令在该自定义目标的命令之前执行。始终为DEPENDS使用绝对路径，因为由于允许对多个位置进行路径匹配的传统功能，相对路径可能会产生意想不到的结果。

When multiple commands are provided, each one will be executed in the order listed. A project should not assume any particular shell behavior, however, as each command might run in its own separate shell or without any shell environment at all. Custom commands should be defined as though they were being executed in isolation and without any shell features such as redirection, variable substitution, etc., with only command order being enforced. While some of these features may work on some platforms, they are not universally supported. Also, since no particular shell behavior is guaranteed, escaping within the executable names or their arguments may be handled differently on different platforms. To help reduce these differences, the VERBATIM option can be used to ensure that the only escaping done is that by CMake itself when parsing the CMakeLists.txt file. No further escaping is performed by the platform, so the developer can have confidence in how the command is ultimately constructed for execution. If there is any chance of escaping being relevant, use of the VERBATIM keyword is recommended.

【译】当提供多个命令时，每个命令都将按所列顺序执行。然而，项目不应假设任何特定的shell行为，因为每个命令都可以在自己的单独shell中运行，也可以在没有任何shell环境的情况下运行。**自定义命令应被定义为单独执行**，没有任何shell功能，如重定向、变量替换等，只强制执行命令顺序。虽然其中一些功能可能适用于某些平台，但它们并没有得到普遍支持。此外，由于没有特定的shell行为得到保证，在不同的平台上，可执行文件名或其参数中的转义可能会有不同的处理方式。为了帮助减少这些差异，可以使用**VERBATIM选项来确保在解析CMakeLists.txt文件时，唯一的转义是由CMake本身完成的**。平台不会执行进一步的转义，因此开发人员可以对命令最终如何构造以供执行充满信心。如果有任何机会逃避相关性，建议使用VERBATIM关键字。

The directory in which the commands are executed is the current binary directory by default. This can be changed with the WORKING_DIRECTORY option, which can be an absolute path or a relative path, the latter being relative to the current binary directory. This means that using \${CMAKE_CURRENT_BINARY_DIR} as part of the working directory should not be necessary, since a relative path already implies it.

【译】**默认**情况下，执行命令的目录是当前的二进制目录。这可以通过WORKING_DIRECTORY选项进行更改，该选项可以是绝对路径或相对路径，后者相对于当前二进制目录。这意味着不需要将\${CMAKE_CURRENT_BINARY_DIR}用作工作目录的一部分，因为相对路径已经暗示了这一点。

The BYPRODUCTS option can be used to list other files that are created as part of running the command(s). If the Ninja generator is being used, this option is required if another target depends on any of the files created as a by-product of running this set of custom commands. Files listed as BYPRODUCTS are marked as GENERATED (for all generator types, not just Ninja) which ensures the build tool knows how to correctly handle dependency details related to the by-product files. For cases where a custom target generates files as a by-product, consider whether add_custom_command() would be a more appropriate way to define the commands and the things it outputs (see **Section 17.3, “Commands That Generate Files”**).

【译】BYPRODUCTS选项可用于列出在运行命令时创建的其他文件。如果正在使用Ninja生成器，如果另一个目标依赖于作为运行这组自定义命令的副产品而创建的任何文件，则需要此选项。列为BYPRODUCTS的文件标记为GENERATED（适用于所有生成器类型，而不仅仅是Ninja），这确保了构建工具知道如何正确处理与副产品文件相关的依赖关系细节。对于自定义目标生成文件作为副产品的情况，考虑add_custom_command（）是否是定义命令及其输出的更合适的方法（见第17.3节，“生成文件的命令”）。

If the commands produce no output on the console, it can sometimes be useful to specify a short message with the COMMENT option. The specified message is logged just before running the commands, so if the commands silently fail for some reason, the comment can be a useful marker to indicate where the build failed. Note, however, that for some generators, the comment will not be shown, so this cannot be considered a reliable mechanism, but it may still be useful for those generators that do support it. A universally supported alternative is presented in **Section 17.5, “Platform Independent Commands”** below.

如果命令在控制台上没有输出，有时使用COMMENT选项指定一条短消息可能会很有用。在运行命令之前，会记录指定的消息，因此如果命令因某种原因静默失败，注释可以作为一个有用的标记，指示构建失败的位置。然而，请注意，**对于某些生成器，注释将不会显示**，因此这不能被视为一种可靠的机制，但对于那些支持它的生成器来说，它可能仍然有用。下文第17.5节“平台无关命令”中介绍了一种普遍支持的替代方案。

USES_TERMINAL is another console-related option which instructs CMake to give the command direct access to the terminal, if possible. When using the Ninja generator, this has the effect of placing the command in the console pool. This may lead to better output buffering behavior in some situations, such as helping IDE environments capture and present the build output in a more timely manner. It can also be useful if interactive input is required for non-IDE builds. The USES_TERMINAL option is supported for CMake 3.2 and later.

【译】USES_TERMINAL是另一个与控制台相关的选项，它指示CMake在可能的情况下直接访问终端。使用Ninja生成器时，这会将命令放置在控制台池中。在某些情况下，这可能会导致更好的输出缓冲行为，例如帮助IDE环境更及时地捕获和呈现构建输出。如果非IDE构建需要交互式输入，它也很有用。CMake 3.2及更高版本支持USES_TERMINAL选项。

The SOURCES option allows arbitrary files to be listed which will then be associated with the custom target. These files might be used by the commands or they could just be some additional files which are loosely associated with the target, such as documentation, etc. Listing a file with SOURCES has no effect on the build or the dependency relationships, it is purely for the benefit of associating those files with the target so that IDE projects can show them in an appropriate context. This feature is sometimes exploited by defining a dummy custom target and listing sources with no commands just to make them show up in IDE projects. While this works, it does have the disadvantage of creating a build target with no real meaning. Many projects deem this to be an acceptable tradeoff, while some developers consider this undesirable or even an anti-pattern.

【译】SOURCES选项允许列出任意文件，然后将其与自定义目标相关联。这些文件可能由命令使用，也可能只是与目标松散关联的一些附加文件，如文档等。使用**SOURCES列出文件对构建或依赖关系没有影响**，这纯粹是为了将这些文件与目标相关联，**以便IDE项目可以在适当的上下文中显示它们**。有时通过定义一个虚拟的自定义目标并列出没有命令的源代码来利用此功能，只是为了让它们显示在IDE项目中。虽然这可行，但它确实有一个缺点，即创建一个没有真正意义的构建目标。许多项目认为这是一种可以接受的权衡，而一些开发人员认为这是不可取的，甚至是一种反模式。

## 17.2. Adding Build Steps To An Existing Target

Custom commands sometimes do not require a new target to be defined, they may instead specify additional steps to be performed when building an existing target. This is where add_custom_command() should be used with the TARGET keyword as follows:

自定义命令有时不需要定义新的目标，而是可以指定在构建现有目标时要执行的其他步骤。这就是add_custom_command（）应该与TARGET关键字一起使用的地方，如下所示：

\`\`\`cmake

add_custom_command(TARGET targetName **buildStage**

> COMMAND command1 \[args1...\]
>
> \[COMMAND command2 \[args2...\]\]
>
> \[WORKING_DIRECTORY dir\]
>
> \[BYPRODUCTS files...\]
>
> \[COMMENT comment\]
>
> \[VERBATIM\]
>
> \[USES_TERMINAL\]

)

\`\`\`

Most of the options are very similar to those for add_custom_target(), but instead of defining a new target, the above form attaches the commands to an existing target. That existing target can be an executable or library target, or it can even be a custom target (with some restrictions). The commands will be executed as part of building targetName, with the buildStage argument required to be one of the following:

大多数选项与add_custom_target()的选项非常相似，但上面的表单没有定义新的目标，而是**将命令附加到现有的目标**。现有目标可以是可执行文件或库目标，甚至可以是自定义目标（有一些限制）。这些命令将作为building targetName的一部分执行，**buildStage参数**必须是以下之一：

\#\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

**\#(1)PRE_BUILD**

The commands should be run before any other rules for the specified target. Be aware that only the Visual Studio generator supports this option and only for Visual Studio 7 or later. All other CMake generators will treat this as PRE_LINK instead. Given the limited support for this option, projects should aim for a structure which does not require a PRE_BUILD custom command.

这些命令应在指定目标的任何其他规则之前运行。请注意，只有Visual Studio生成器支持此选项，并且仅适用于Visual Studio 7或更高版本。所有其他CMake生成器都会将其视为PRE_LINK。鉴于对此选项的支持有限，项目应致力于不需要PRE_BUILD自定义命令的结构。

**\#(2)PRE_LINK**

The commands will be run after sources are compiled, but before they are linked. For static library targets, the commands will run before the library archiver tool. For custom targets, PRE_LINK is not supported.

这些命令将在源代码编译后但在链接之前运行。对于静态库目标，命令将在库归档工具之前运行。对于自定义目标，不支持PRE_LINK。

**\#(3)POST_BUILD**

The commands will be run after all other rules for the specified target. All target types and generators support this option, making it the preferred build stage whenever there is a choice.

这些命令将在指定目标的所有其他规则之后运行。所有目标类型和生成器都支持此选项，使其成为首选的构建阶段。

\#\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

POST_BUILD tasks are relatively common, but PRE_LINK and PRE_BUILD are rarely needed since they can usually be avoided by using the OUTPUT form of add_custom_command() instead (see next section).

【译】POST_BUILD任务相对常见，但很少需要PRE_LINK和PRE_BUILD，因为通常可以通过使用add_custom_command()的OUTPUT形式来避免它们（见下一节）。

Multiple calls to add_custom_command() can be made to append multiple sets of custom commands to a particular target. This can be useful, for example, to have some commands run from one working directory and other commands run from somewhere else.

可以多次调用add_custom_command()，将多组自定义命令附加到特定目标。这可能很有用，例如，让一些命令从一个工作目录运行，而其他命令从其他地方运行。

\#------------------------------------\>\>\>\>\>\>

add_executable(myExe main.cpp)

add_custom_command(TARGET myExe POST_BUILD

COMMAND script1 \$\<TARGET_FILE:myExe\>

)

\# Additional command which will run after the above from a different directory

add_custom_command(TARGET myExe POST_BUILD

COMMAND writeHash \$\<TARGET_FILE:myExe\>

BYPRODUCTS \${CMAKE_BINARY_DIR}/verify/myExe.md5

WORKING_DIRECTORY \${CMAKE_BINARY_DIR}/verify

)

\#------------------------------------\<\<\<\<\<\<

## 17.3. Commands That Generate Files

Defining commands as additional build steps for a target covers many common use cases. Sometimes, however, a project needs to create one or more files by running a command or series of commands and the generation of that file doesn’t really belong to any existing target. This is where the OUTPUT form of add_custom_command() can be used. It implements all of the same options as the TARGET form as well as some additional options related to dependency handling and appending to a previous OUTPUT command set.

将命令定义为目标的附加构建步骤涵盖了许多常见用例。然而，有时项目需要通过运行一个或一系列命令来创建一个或多个文件，而该文件的生成并不真正属于任何现有目标。这就是可以使用**add_custom_command()的OUTPUT形式**的地方。它实现了与TARGET表单相同的所有选项，以及与依赖关系处理和附加到之前的OUTPUT命令集相关的一些附加选项。

\`\`\`cmake

add_custom_command(OUTPUT output1 \[output2...\]

> COMMAND command1 \[args1...\]
>
> \[COMMAND command2 \[args2...\]\]
>
> \[WORKING_DIRECTORY dir\]
>
> \[BYPRODUCTS files...\]
>
> \[COMMENT comment\]
>
> \[VERBATIM\]
>
> \[USES_TERMINAL\]
>
> \[APPEND\]
>
> \[DEPENDS \[depends1...\]
>
> \[MAIN_DEPENDENCY depend\]
>
> \[IMPLICIT_DEPENDS \<lang1\> depend1
>
> \[\<lang2\> depend2...\]\]
>
> \[DEPFILE depfile\]

)

\`\`\`

Instead of specifying a target and pre/post build stage, this form requires one or more output file names to be given after the OUTPUT keyword. CMake will then interpret the commands as a recipe for generating the named output files. If the output files are specified with no path or with a relative path, they are relative to the current binary directory.

此形式要求在output关键字后给出一个或多个输出文件名，而不是指定目标和构建前/后阶段。CMake然后将这些命令解释为生成命名输出文件的配方。如果输出文件没有指定路径或指定了相对路径，则它们是相对于当前二进制目录的。

On its own, this form won’t result in the output files being built, since no target is defined. If, however, some other target defined in the same directory scope depends on any of the output files, CMake will automatically create dependency relationships that ensure the output files are generated before the target that needs them. That target can be an ordinary executable, a library target or it can even be a custom target. In fact, it is quite common for a custom target to be defined simply to provide a way for the developer to trigger the custom command. The following variation on the hashing example of the preceding section demonstrates the technique:

就其本身而言，此形式不会导致生成输出文件，因为没有定义目标。但是，如果在同一目录范围内定义的其他目标依赖于任何输出文件，CMake将自动创建依赖关系，以确保输出文件在需要它们的目标之前生成。该目标可以是普通的可执行文件、库目标，甚至可以是自定义目标。事实上，定义自定义目标只是为开发人员提供触发自定义命令的方法是很常见的。上一节哈希示例的以下变体演示了该技术：

\#------------------------------------\>\>\>\>\>\>

add_executable(myExe main.cpp)

\# Output file with relative path, generated in the build directory

add_custom_command(OUTPUT myExe.md5

COMMAND writeHash \$\<TARGET_FILE:myExe\>

)

\# Absolute path needed for DEPENDS, otherwise relative to source directory

add_custom_target(computeHash

DEPENDS \${CMAKE_CURRENT_BINARY_DIR}/myExe.md5

)

\#------------------------------------\<\<\<\<\<\<

When defined this way, building the myExe target will not result in running the hashing step, unlike the earlier example which added the hashing command as a POST_BUILD step of the myExe target. Instead, hashing will only be performed if the developer explicitly requests it as a build target. This allows optional steps to be defined and invoked when needed instead of always being run, which can be quite useful if the additional steps are time consuming or won’t always be relevant.

当以这种方式定义时，构建myExe目标不会导致运行哈希步骤，这与前面的示例不同，前面的示例将哈希命令添加为myExe对象的POST_BUILD步骤。相反，只有当开发人员明确要求将哈希作为构建目标时，才会执行哈希。这允许在需要时定义和调用可选步骤，而不是总是运行，如果额外的步骤很耗时或并不总是相关的，这可能非常有用。

Of course, add_custom_command() can also be used to generate files consumed by existing targets, such as generating source files. In the following example, an executable built by the project is used to generate a source file which is then compiled as part of another executable.

当然，add_custom_command()也可以用于生成现有目标使用的文件，例如生成源文件。在以下示例中，项目构建的可执行文件用于生成源文件，然后将其编译为另一个可执行文件的一部分。

\#------------------------------------\>\>\>\>\>\>

add_executable(generator generator.cpp)

add_custom_command(OUTPUT onTheFly.cpp

COMMAND generator

)

add_executable(myExe \${CMAKE_CURRENT_BINARY_DIR}/onTheFly.cpp)

\#------------------------------------\<\<\<\<\<\<

CMake automatically recognizes that myExe needs the source file generated by the custom command, which in turn requires the generator executable. Asking for the myExe target to be built will result in the generator and the generated source file being built before building myExe. Note, however, that this dependency relationship has limitations. Consider the following scenario:

【译】CMake自动识别myExe需要自定义命令生成的源文件，而自定义命令又需要生成器可执行文件。要求构建myExe目标将导致生成器和生成的源文件在生成myExe之前被构建。但是，请注意，这种依赖关系有局限性。考虑以下情况：

\#\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>\>

• The onTheFly.cpp file initially does not exist.

【译】onTheFly.cpp文件最初不存在。

• Build the myExe target, which results in the following sequence:

【译】构建myExe目标，其结果如下：

◦ The generator target is brought up to date. 【译】目标generator 已更新。

◦ The custom command is executed to create onTheFly.cpp. 【译】执行自定义命令在TheFly.cpp上创建。

◦ The myExe target is built.【译】目标myExe已构建。

• Now modify the generator.cpp file. 【译】现在修改generator.cpp文件。

• Build the myExe target again, which this time results in the following sequence: 【译】再次构建myExe目标，这次将按以下顺序生成：

◦ The generator target is brought up to date. This will cause the generator executable to be rebuilt because its source file was modified. 【译】generator 目标已更新。这将导致生成器可执行文件被重建，因为其源文件已被修改。

◦ The custom command is NOT executed, since onTheFly.cpp already exists. 【译】由于onTheFly.cpp已存在，因此不会执行自定义命令。

◦ The myExe target is NOT rebuilt because its source file remains unchanged.【译】myExe目标未重建，因为其源文件保持不变。

\#\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<\<

One might intuitively expect that if the generator target is rebuilt, then the custom command should also be re-run. The dependency CMake automatically creates does not enforce this, it creates a weaker dependency which does ensure generator is brought up to date but the custom command is only run if the output file is missing altogether. In order to force the custom command to be re-run if the generator target is rebuilt, an explicit dependency has to be specified rather than relying on the dependency CMake automatically creates.

人们可能会直观地认为，如果重建了生成器目标，那么也应该重新运行自定义命令。CMake自动创建的依赖关系并没有强制执行这一点，它创建了一个较弱的依赖关系，这确实确保了生成器是最新的，但只有在输出文件完全缺失的情况下，才会运行自定义命令。为了在重建生成器目标时强制重新运行自定义命令，必须指定显式依赖关系，而不是依赖CMake自动创建的依赖关系。

Dependencies can be manually specified with the DEPENDS option. Items listed with DEPENDS can be CMake targets or files (compare this with the DEPENDS option for add_custom_target() which can only list files). If a target is listed, it will be brought up to date any time the custom command’s output files are required to be brought up to date. Similarly, if a listed file is modified, the custom command will be executed if anything requires any of the custom command’s output files. Furthermore, if any listed file is itself an output file of another custom command in the same directory scope, that other custom command will be executed first. As for add_custom_target(), always use an absolute path if listing a file for DEPENDS to avoid ambiguous legacy behavior.

可以使用DEPENDS选项手动指定依赖关系。使用DEPENDS列出的项目可以是CMake目标或文件（将其与add_custom_target（）的DEPENDS选项进行比较，后者只能列出文件）。如果列出了目标，则只要需要更新自定义命令的输出文件，它就会随时更新。同样，如果修改了列出的文件，如果需要任何自定义命令的输出文件，则将执行自定义命令。此外，如果任何列出的文件本身是同一目录范围内另一个自定义命令的输出文件，则将首先执行该其他自定义命令。至于add_custom_target（），如果为DEPENDS列出文件，请始终使用绝对路径，以避免模糊的遗留行为。

While CMake’s automatic dependencies may seem convenient, in practice the project will still typically need to list out all the required targets and files in a DEPENDS section to ensure that the full dependency relationships are adequately specified. It can be easy to omit the DEPENDS section by mistake, since the first build will run the custom command to create the missing output files and the build will appear to be behaving correctly. Subsequent builds will not re-run the custom command unless the output file is removed, even if any of the automatically detected dependency targets are rebuilt. This can be easy to miss, often going undetected for a long time in complex projects until a developer encounters the situation and tries to work out why something isn’t being rebuilt when it was expected to be. Therefore, developers should expect that a DEPENDS section will typically be needed unless the custom command doesn’t require anything created by the build or any of the project’s source files.

虽然CMake的自动依赖关系看起来很方便，但在实践中，项目通常仍需要在“依赖关系”部分列出所有必需的目标和文件，以确保充分指定完整的依赖关系。很容易错误地省略DEPENDS部分，因为第一个构建将运行自定义命令来创建丢失的输出文件，并且构建将表现正常。除非删除输出文件，否则后续构建将不会重新运行自定义命令，即使重建了任何自动检测到的依赖关系目标。这很容易被忽略，在复杂的项目中，通常在很长一段时间内都不会被发现，直到开发人员遇到这种情况并试图找出为什么某些东西没有在预期的时候被重建。因此，开发人员应该预料到通常需要一个依赖部分，除非自定义命令不需要由构建或项目的任何源文件创建的任何东西。

Another common error is to not create a dependency on a file that is needed by the custom command, but which isn’t listed as part of the command line to be executed. Such files need to appear in a DEPENDS section for the build to be considered robust.

另一个常见错误是不创建对自定义命令所需的文件的依赖关系，但该文件未作为要执行的命令行的一部分列出。此类文件需要出现在“依赖”部分，才能认为构建是稳健的。

There are a few more dependency-related options supported by add_custom_command(). The MAIN_DEPENDENCY option is intended to identify a source file which should be considered the main dependency of the custom command. It has mostly the same effect as DEPENDS for the listed file, but some generators may apply additional logic such as where to place the custom command in an IDE project. An important distinction to note is that if a source file is listed as a MAIN_DEPENDENCY, then the custom command becomes a replacement for how that source file would normally be compiled. This can lead to some unexpected results. Consider the following example:

【译】add_custom_command()还支持一些与依赖关系相关的选项。MAIN_DEPENDENCY选项旨在标识一个源文件，该文件应被视为自定义命令的主要依赖项。它与列出的文件的DEPENDS具有基本相同的效果，但一些生成器可能会应用额外的逻辑，例如在IDE项目中放置自定义命令的位置。需要注意的一个重要区别是，如果源文件被列为MAIN_DEPENDENCY，那么自定义命令将取代该源文件通常的编译方式。这可能会导致一些意想不到的结果。考虑以下示例：

\#------------------------------------\>\>\>\>\>\>

add_custom_command(OUTPUT transformed.cpp

COMMAND transform

\${CMAKE_CURRENT_SOURCE_DIR}/original.cpp

transformed.cpp

MAIN_DEPENDENCY \${CMAKE_CURRENT_SOURCE_DIR}/original.cpp

)

add_executable(original original.cpp)

add_executable(transformed transformed.cpp)

\#------------------------------------\<\<\<\<\<\<

The above would lead to a linker error for the original target because original.cpp would not be compiled to an object file, so there would be no object files at all (and therefore no main() function). Instead, the build tool would treat original.cpp as an input file used to create transformed.cpp. The problem can be fixed by using DEPENDS instead of MAIN_DEPENDENCY, as this would preserve the same dependency relationship, but it would not result in the default compilation rule for the original.cpp source file being replaced.

上述操作将导致原始目标的链接器错误，因为original.cpp不会被编译为目标文件，因此根本没有目标文件（因此也没有main（）函数）。相反，构建工具会将original.cpp视为用于创建transformed.cpp的输入文件。这个问题可以通过使用DEPENDS而不是MAIN_DEPENDENCY来解决，因为这将保留相同的依赖关系，但不会导致原始.cpp源文件的默认编译规则被替换。

The other two dependency-related options, IMPLICIT_DEPENDS and DEPFILE, are not supported by most project generators. IMPLICIT_DEPENDS is ignored for all but Makefile generators, while the use of DEPFILE results in an error if anything other than the Ninja generator is used. IMPLICIT_DEPENDS directs CMake to invoke a C or C++ scanner to determine dependencies of the listed files, while DEPFILE can be used to provide a Ninja-specific .d dependency file. Projects should generally try to avoid these two options due to the severely limited number of project generators that support them.

其他两个与依赖关系相关的选项IMPLICT_DEPENDS和DEPFILE不受大多数项目生成器的支持。除Makefile生成器外，所有生成器都忽略IMPLICT_DEPENDS，而如果使用Ninja生成器以外的任何生成器，则使用DEPFILE会导致错误。IMPLICT_DEPENDS指示CMake调用C或C++扫描程序来确定所列文件的依赖关系，而DEPFILE可用于提供特定于Ninja的.d依赖关系文件。项目通常应尽量避免这两种选择，因为支持它们的项目生成器数量严重有限。

The OUTPUT and TARGET forms also have slightly different behavior when it comes to appending more dependencies or commands to the same output file or target. For the OUTPUT form, the APPEND keyword must be specified and the first OUTPUT file listed must be the same for the first and subsequent calls to add_custom_command(). Only COMMAND and DEPENDS can be used for the second and subsequent calls for the same output file, the other options such as MAIN_DEPENDENCY, WORKING_DIRECTORY and COMMENT are ignored when the APPEND keyword is present. In contrast, for the TARGET form, no APPEND keyword is necessary for second and subsequent calls to add_custom_command() for the same target. The COMMENT and WORKING_DIRECTORY options can also be specified for each call and they will take effect for the commands being added in that call.

在向同一输出文件或目标添加更多依赖项或命令时，OUTPUT和TARGET表单的行为也略有不同。对于OUTPUT表单，必须指定APPEND关键字，并且列出的第一个OUTPUT文件必须与第一个和后续调用add_custom_command（）的文件相同。只有COMMAND和DEPENDS可用于对同一输出文件的第二次和后续调用，当出现APPEND关键字时，其他选项（如MAIN_DEPENDENCY、WORKING_DIRECTORY和COMMENT）将被忽略。相比之下，对于TARGET表单，对于同一目标的add_custom_command（）的第二次和后续调用不需要APPEND关键字。还可以为每个调用指定COMMENT和WORKING_DIRECTORY选项，它们将对该调用中添加的命令生效。

## 17.4. Configure Time Tasks

Both add_custom_target() and add_custom_command() define commands to be executed during the build stage. This is typically when custom commands should be run, but there are some situations where a custom task needs to be performed during the configure stage instead, such as: 【译】add_custom_target()和add_custom_command()都定义了在构建阶段要执行的命令。这通常是应该运行自定义命令的时候，但在某些情况下，需要在配置阶段执行自定义任务，例如：

• Executing external commands to obtain information to be used during configuration. 【译】执行外部命令以获取配置过程中使用的信息。

• Writing or touching files which need to be updated any time CMake is re-run. 【译】写入或触摸需要在重新运行CMake时随时更新的文件。

• Generation of CMakeLists.txt or other files which need to be included or processed as part of the current configure step.【译】生成CMakeLists.txt或其他需要包含或处理的文件，作为当前配置步骤的一部分。

CMake provides the execute_process() command for running tasks like these during the configure stage: 【译】CMake提供execute_process()命令，用于**在配置阶段**运行以下任务：

\`\`\`cmake

execute_process(COMMAND command1 \[args1...\]

> \[COMMAND command2 \[args2...\]\]
>
> \[WORKING_DIRECTORY directory\]
>
> \[RESULT_VARIABLE resultVar\]
>
> \[RESULTS_VARIABLE resultsVar\]
>
> \[OUTPUT_VARIABLE outputVar\]
>
> \[ERROR_VARIABLE errorVar\]
>
> \[OUTPUT_STRIP_TRAILING_WHITESPACE\]
>
> \[ERROR_STRIP_TRAILING_WHITESPACE\]
>
> \[INPUT_FILE inFile\]
>
> \[OUTPUT_FILE outFile\]
>
> \[ERROR_FILE errorFile\]
>
> \[OUTPUT_QUIET\]
>
> \[ERROR_QUIET\]
>
> \[TIMEOUT seconds\]

)

\`\`\`

Similar to add_custom_command() and add_custom_target(), one or more COMMAND sections specify the tasks to be executed and the WORKING_DIRECTORY option can be used to control where those commands are run. The commands are passed to the operating system for execution as is with no intermediate shell environment. Therefore, features like input/output redirection and environment variables are not supported. The commands run immediately.

与add_custom_command()和add_custom_target()类似，一个或多个command部分指定要执行的任务，WORKING_DIRECTORY选项可用于控制这些命令的运行位置。命令被传递给操作系统，以便在没有中间shell环境的情况下按原样执行。因此，**不支持输入/输出重定向和环境变量**等功能。命令立即运行。

If multiple commands are given, they are executed in order, but instead of being fully independent from each other, the standard output from one command is piped to the input of the next. In the absence of any other options, the output of the last command is sent to the output of the CMake process itself but the standard error of every command is sent to the standard error stream of the CMake process.

如果给出了多个命令，它们将按顺序执行，但不是完全相互独立，而是将一个命令的标准输出通过管道传输到下一个命令。在没有任何其他选项的情况下，最后一个命令的输出会被发送到CMake进程本身的输出，但每个命令的标准错误都会被发送给CMake进程的标准错误流。

The standard output and standard error streams can be captured and stored in variables instead of being sent to the default pipes. The output of the last command in the set of commands can be captured by specifying the name of a variable to store it in with the OUTPUT_VARIABLE option. Similarly, the standard error streams of all commands can be stored in the variable named by the ERROR_VARIABLE option. Passing the same variable name to both of these options will result in the standard output and standard error being merged just as they would be if outputting to a terminal, with the merged result being stored in the named variable. If the OUTPUT_STRIP_TRAILING_WHITESPACE option is present, any trailing whitespace will be omitted from the content stored in the output variable, while the ERROR_STRIP_TRAILING_WHITESPACE option does a similar thing for the content stored in the error variable. If using the output or error variables’ contents for any sort of string comparison, a common problem is failing to account for trailing whitespace, so its removal is often desirable.

标准输出和标准错误流可以被捕获并存储在变量中，而不是发送到默认管道。通过使用output_variable选项指定要存储的变量的名称，可以捕获命令集中最后一个命令的输出。同样，所有命令的标准错误流都可以存储在由error_variable选项命名的变量中。将相同的变量名传递给这两个选项将导致标准输出和标准错误被合并，就像输出到终端一样，合并的结果存储在指定的变量中。如果存在OUTPUT_STRIP_TRAILING_WHITESPACE选项，则存储在输出变量中的内容中的任何尾随空格都将被省略，而ERROR_STRIP_TRAILING_WHITESPACE选项对存储在错误变量中的属性执行类似的操作。如果将输出或错误变量的内容用于任何类型的字符串比较，一个常见的问题是无法考虑尾随空格，因此通常需要将其删除。

Instead of capturing the output and error streams in a variable, they can be sent to files. The OUTPUT_FILE and ERROR_FILE options can be used to specify the names of files to send the streams to and just like the variable-focused options, specifying the same file name for both results in a merged stream. In addition, a file can be specified for the input stream to the first command with the INPUT_FILE option. Note, however, that the OUTPUT_STRIP_TRAILING_WHITESPACE and ERROR_STRIP_TRAILING_WHITESPACE options have no effect on content sent to files.

可以将输出和错误流发送到文件，而不是将其捕获在变量中。OUTPUT_FILE和ERROR_FILE选项可用于指定要将流发送到的文件的名称，就像以变量为中心的选项一样，为合并流中的两个结果指定相同的文件名。此外，可以使用input_file选项为第一个命令的输入流指定一个文件。但是请注意，OUTPUT_STRIP_TRAILING_WHITESPACE和ERROR_STRIP_TRAILING_WHITESPACE选项对发送到文件的内容没有影响。

The same stream cannot be captured in a variable and sent to a file at the same time. It is possible, however, to send different streams to different places, such as the output stream to a variable and the error stream to a file or vice versa. It is also possible to silently discard the content of a stream altogether with the OUTPUT_QUIET and ERROR_QUIET options. These options can be useful if just success or failure of a command is of interest.

同一流不能在变量中捕获并同时发送到文件。然而，可以将不同的流发送到不同的位置，例如将输出流发送到变量，将错误流发送到文件，反之亦然。也可以使用OUTPUT_QUIET和ERROR_QUIET选项来静默地丢弃流的内容。如果只关注命令的成功或失败，这些选项可能很有用。

Success or failure of the set of commands can be captured using the RESULT_VARIABLE option. The result of running the commands will be stored in the named variable as either an integer return code of the last command or a string containing some kind of error message. The if() command conveniently treats both non-empty error strings and integer values other than 0 as boolean true (unless a project is unlucky enough to have an error string that satisfies one of the special cases, see Section 6.1.1, “Basic Expressions”). Therefore, checking for the success of a call to execute_process() is generally relatively simple:

可以使用RESULT_VARIABLE选项捕获命令集的成功或失败。运行命令的结果将作为最后一个命令的整数返回码或包含某种错误消息的字符串存储在命名变量中。if（）命令方便地将非空错误字符串和除0以外的整数值视为布尔真（除非项目不幸地有一个满足特殊情况之一的错误字符串，请参阅第6.1.1节“基本表达式”）。因此，检查execute_process（）调用的成功通常相对简单：

\#------------------------------------\>\>\>\>\>\>

execute_process(COMMAND runSomeScript

RESULT_VARIABLE result)

if(result)

message(FATAL_ERROR "runSomeScript failed: \${result})

endif()

\#------------------------------------\<\<\<\<\<\<

From CMake 3.10, if the result of each individual command is required rather than just the last one, the RESULTS_VARIABLE option can be used instead. This option stores the result of each command in the variable named by resultsVar as a list.

从CMake 3.10开始，如果需要每个单独命令的结果而不仅仅是最后一个命令的结果，则可以使用RESULTS_VARIABLE选项。此选项将每个命令的结果以列表形式存储在resultsVar命名的变量中。

The TIMEOUT option can be used to handle commands which may run longer than expected or which might possibly never complete. This ensures the configure step doesn’t block indefinitely and allows an unexpectedly long configure step to be treated as an error. Note, however, that the TIMEOUT option on its own won’t cause CMake to halt and report an error. The result of the command must still be captured using RESULT_VARIABLE and that variable must then be checked, as in the preceding example. If the command runs longer than the timeout threshold, the result variable will hold an error string indicating that the command was terminated due to timeout, which is why printing the result variable is recommended.

【译】TIMEOUT选项可用于处理可能运行时间比预期长或可能永远不会完成的命令。这确保了配置步骤不会无限期阻塞，并允许将意外长的配置步骤视为错误。但是请注意，TIMEOUT选项本身不会导致CMake停止并报告错误。命令的结果仍必须使用result_VARIABLE捕获，然后必须检查该变量，如上例所示。如果命令运行时间超过超时阈值，结果变量将包含一个错误字符串，指示命令因超时而终止，这就是为什么建议打印结果变量。

When CMake executes the commands, the child process largely inherits the same environment as the main process. An important exception to this is that the first time CMake is run on a project, the CC and CXX environment variables of the child process are explicitly set to the C and C++ compilers being used by the main build (if the main project has enabled the C and C++ languages). For subsequent CMake runs, the CC and CXX environment variables are not substituted in this way, which can lead to unexpected results if the commands perform actions that rely on CC and/or CXX having the same values every time execute_process() is called. This undocumented behavior has existed since early versions of CMake, even as far back as the now deprecated exec_program() command which execute_process() replaced. It was added to facilitate child processes being able to configure and run sub-builds with the same compilers as the main project. In some cases, however, the child process might not want the compiler to be preserved, such as when the main build is cross-compiling but the child process should use the default host compilers. In such cases, projects can set a variable named CMAKE_GENERATOR_NO_COMPILER_ENV to a boolean true value and then CMake will not set CC and CXX for any execute_process() call, even the initial invocation.

当CMake执行命令时，子进程在很大程度上继承了与主进程相同的环境。一个重要的例外是，第一次在项目上运行CMake时，子进程的CC和CXX环境变量被显式设置为主构建使用的C和C++编译器（如果主项目启用了C和C++语言）。对于后续的CMake运行，CC和CXX环境变量不会以这种方式替换，如果命令执行的操作依赖于每次调用execute_process（）时CC和/或CXX具有相同值，则可能会导致意外结果。这种未记录的行为自CMake的早期版本以来就存在了，甚至可以追溯到现在已弃用的exec_program（）命令，该命令被execute_process（）替换。添加它是为了方便子进程能够使用与主项目相同的编译器配置和运行子构建。然而，在某些情况下，子进程可能不希望保留编译器，例如当主构建是交叉编译，但子进程应使用默认的宿主编译器时。在这种情况下，项目可以将名为CMAKE_GENERATOR_NO_COMPILER_ENV的变量设置为布尔真值，然后CMAKE将不会为任何execute_process（）调用设置CC和CXX，即使是初始调用。

## 17.5. Platform Independent Commands

The add_custom_command(), add_custom_target() and execute_process() commands provide projects with a great deal of freedom. Any task not already directly supported by CMake can be implemented using commands provided by the host operating system instead. These custom commands are inherently platform specific, which works against one of the main reasons many projects use CMake in the first place, i.e. to abstract away platform differences or to at least support a range of platforms with minimal effort.

【译】add_custom_command（）、add_custom_target（）和execute_process（）命令为项目提供了极大的自由度。CMake尚未直接支持的任何任务都可以使用主机操作系统提供的命令来实现。这些自定义命令本质上是特定于平台的，这与许多项目首先使用CMake的主要原因之一背道而驰，即抽象出平台差异，或者至少以最小的努力支持一系列平台。

A large proportion of custom tasks are related to file system manipulation. Creating, deleting, renaming or moving files and directories form the bulk of these tasks, but the commands to do so vary between operating systems. As a result, projects often end up using if-else conditions to define the different platforms’ versions of the same command, or worse, they only bother to implement the commands for some platforms. Many developers are not aware that the cmake command itself provides a command mode which abstracts away many of these platform specific tasks:

很大一部分自定义任务与文件系统操作有关。创建、删除、重命名或移动文件和目录构成了这些任务的大部分，但执行这些任务的命令因操作系统而异。因此，项目往往最终使用if-else条件来定义同一命令的不同平台版本，或者更糟糕的是，他们只费心为某些平台实现命令。许多开发人员不知道cmake命令本身提供了一种命令模式，该模式抽象了许多特定于平台的任务：

\`\`\`cmake

cmake -E cmd \[args...\]

\`\`\`

The full set of supported commands can be listed using cmake -E help, but some of the more commonly used ones include:【译】可以使用cmake -E help列出支持的全部命令集，但一些更常用的命令包括：

• compare_files

• copy

• copy_directory

• copy_if_different

• echo

• env

• make_directory

• md5sum

• remove

• remove_directory

• rename

• tar

• time

• touch

Consider the example of a custom task to remove a particular directory and all its contents:

考虑删除特定目录及其所有内容的自定义任务示例：

\#------------------------------------\>\>\>\>\>\>

set(discardDir "\${CMAKE_CURRENT_BINARY_DIR}/private")

\# Naive platform specific implementation (not robust)

if(WIN32)

add_custom_target(myCleanup

COMMAND rmdir /S /Q "\${discardDir}"

)

elseif(UNIX)

add_custom_target(myCleanup

COMMAND rm -rf "\${discardDir}"

)

else()

message(FATAL_ERROR "Unsupported platform")

endif()

\# Platform independent equivalent

add_custom_target(myCleanup

COMMAND "\${CMAKE_COMMAND}" -E remove_directory "\${discardDir}"

)

\#------------------------------------\<\<\<\<\<\<

The platform specific implementation shows how projects typically try to implement a scenario such as this, but the if-else conditions are testing the target platform rather than the host platform. In a cross compiling scenario, this may result in the wrong platform’s command being used. The platform independent version, however, has no such weakness. It always selects the right command for the host platform.

特定于平台的实现显示了项目通常如何尝试实现这样的场景，但if-else条件是测试目标平台而不是主机平台。在交叉编译场景中，这可能会导致使用错误的平台命令。然而，独立于平台的版本没有这样的弱点。它总是为主机平台选择正确的命令。

The example also shows how to invoke the cmake command correctly. The CMAKE_COMMAND variable is populated by CMake and it contains the full path to the cmake executable being used in the main build. Using CMAKE_COMMAND in this way ensures that the same version of CMake is also used for the custom command. The cmake executable does not have to be on the current PATH and if multiple versions of CMake are installed, the correct version is always used, regardless of which one might otherwise have been selected based on the user’s PATH. It also ensures the build uses the same CMake version during the build stage as was used in the configure stage, even if the user’s PATH environment variable changes.

该示例还展示了如何正确调用cmake命令。CMAKE_COMMAND变量由CMAKE填充，它包含主构建中使用的CMAKE可执行文件的完整路径。以这种方式使用CMAKE_COMMAND可确保自定义命令也使用相同版本的CMAKE。cmake可执行文件不必在当前的PATH上，如果安装了多个版本的cmake，则始终使用正确的版本，无论根据用户的PATH选择了哪个版本。它还确保在构建阶段使用与配置阶段相同的CMake版本，即使用户的PATH环境变量发生了变化。

Earlier in this chapter, it was noted that the COMMENT option for add_custom_target() and add_custom_command() isn’t always reliable. Instead of using COMMENT, projects can use the -E echo command to intersperse comments anywhere in a sequence of custom commands:

本章前面提到，add_custom_target（）和add_custom_command（）的COMMENT选项并不总是可靠的。项目可以使用-E echo命令在自定义命令序列中的任何位置插入注释，而不是使用COMMENT：

\#------------------------------------\>\>\>\>\>\>

set(discardDir "\${CMAKE_CURRENT_BINARY_DIR}/private")

add_custom_target(myCleanup

COMMAND \${CMAKE_COMMAND} -E echo "Removing \${discardDir}"

COMMAND \${CMAKE_COMMAND} -E remove_directory "\${discardDir}"

COMMAND \${CMAKE_COMMAND} -E echo "Recreating \${discardDir}"

COMMAND \${CMAKE_COMMAND} -E make_directory "\${discardDir}"

)

\#------------------------------------\<\<\<\<\<\<

CMake’s command mode is a very useful way of carrying out a range of common tasks in a platform independent way. Sometimes, however, more complex logic is required and such custom tasks are often implemented using platform specific shell scripts. An alternative is to use CMake itself as a scripting engine, providing a platform independent language in which to express arbitrary logic. The -P option to the cmake command puts CMake into script processing mode:

CMake的命令模式是一种非常有用的方式，可以以独立于平台的方式执行一系列常见任务。然而，有时需要更复杂的逻辑，并且此类自定义任务通常使用特定于平台的shell脚本来实现。另一种方法是使用CMake本身作为脚本引擎，提供一种独立于平台的语言来表达任意逻辑。cmake命令的-P选项将cmake置于脚本处理模式：

\`\`\`cmake

cmake \[options\] -P filename

\`\`\`

The filename argument is the name of the CMake script file to execute. The usual CMakeLists.txt syntax is supported, but there is no configure or generate step and the CMakeCache.txt file is not updated. The script file is essentially processed as just a set of commands rather than as a project, so any commands which relate to build targets or project-level features are not supported. Nonetheless, script mode allows complex logic to be implemented and it comes with the advantage of not requiring any additional shell interpreter to be installed.

【译】filename参数是要执行的CMake脚本文件的名称。支持常用的CMakeLists.txt语法，但没有配置或生成步骤，CMakeCache.txt文件也没有更新。脚本文件基本上是作为一组命令而不是项目处理的，因此不支持与构建目标或项目级功能相关的任何命令。尽管如此，脚本模式允许实现复杂的逻辑，并且它的优点是不需要安装任何额外的shell解释器。

While script mode doesn’t support command line options like ordinary shells or command interpreters, it does support passing in variables with -D options, just like ordinary cmake invocations. Since no CMakeCache.txt file is updated in script mode, -D options can be used freely without affecting the main build’s cache. Such options must be placed before -P.

虽然脚本模式不支持像普通shell或命令解释器那样的命令行选项，但它确实支持使用-D选项传递变量，就像普通的cmake调用一样。由于在脚本模式下没有更新CMakeCache.txt文件，因此可以自由使用-D选项，而不会影响主构建的缓存。这些选项必须放在-P之前。

\`\`\`cmake

cmake -DOPTION_A=1 -DOPTION_B=foo -P myCustomScript.cmake

\`\`\`

## 17.6. Combining The Different Approaches

The following example demonstrates many of the features introduced in this chapter. In particular, it shows how the different ways of specifying custom tasks can be used together to accomplish nontrivial things without having to resort to platform specific commands or functionality.

以下示例演示了本章中介绍的许多功能。特别是，它展示了如何将指定自定义任务的不同方式结合使用，以完成非平凡的事情，而无需诉诸于特定于平台的命令或功能。

\#*CMakeLists.txt*

\#------------------------------------\>\>\>\>\>\>

cmake_minimum_required(VERSION 3.0)

project(Example)

\# Define an executable which generates various files in a

\# directory passed as a command line argument

add_program(generateFiles generateFiles.cpp)

\# Create a custom target which invokes the above executable

\# after creating an empty output directory for it to populate,

\# then invoke a script to archive that directory's contents

\# and print the MD5 checksum of that archive

set(outDir "foo")

add_custom_target(archiver

COMMAND \${CMAKE_COMMAND} -E echo "Archiving generated files"

COMMAND \${CMAKE_COMMAND} -E remove_directory "\${outDir}"

COMMAND \${CMAKE_COMMAND} -E make_directory "\${outDir}"

COMMAND generateFiles "\${outDir}"

COMMAND \${CMAKE_COMMAND} "-DTAR_DIR=\${outDir}"

-P "\${CMAKE_CURRENT_SOURCE_DIR}/archiver.cmake"

)

\#------------------------------------\<\<\<\<\<\<

\#archiver.cmake

\#------------------------------------\>\>\>\>\>\>

cmake_minimum_required(VERSION 3.0)

if(NOT TAR_DIR)

message(FATAL_ERROR "TAR_DIR must be set")

endif()

\# Create an archive of the directory

set(archive archive.tar)

> execute_process(COMMAND \${CMAKE_COMMAND} -E tar cf \${archive} "\${TAR_DIR}"

RESULT_VARIABLE result

)

if(result)

message(FATAL_ERROR "Archiving \${TAR_DIR} failed: \${result}")

endif()

\# Compute MD5 checksum of the archive

execute_process(COMMAND \${CMAKE_COMMAND} -E md5sum \${archive}

OUTPUT_VARIABLE md5output

RESULT_VARIABLE result

)

if(result)

message(FATAL_ERROR "Unable to compute md5 of archive: \${result}")

endif()

\# Extract just the checksum from the output

string(REGEX MATCH "^ \*\[^ \]\*" md5sum "\${md5output}")

message("Archive MD5 checksum: \${md5sum}")

\#------------------------------------\<\<\<\<\<\<

## 17.7. Recommended Practices

When custom tasks need to be executed, it is preferable that they be done during the build stage rather than the configure stage. A fast configure stage is important because it can be invoked automatically when some files are modified (e.g. any CMakeLists.txt file in the project, any file included by a CMakeLists.txt file or any file listed as a source of a configure_file() command as discussed in the next chapter). For this reason, prefer to use add_custom_target() or add_custom_command() instead of execute_process() if there is a choice.

当需要执行自定义任务时，最好在构建阶段而不是配置阶段完成。快速配置阶段很重要，因为它可以在修改某些文件时自动调用（例如，项目中的任何CMakeLists.txt文件、CMakeLists..txt文件包含的任何文件或下一章讨论的列为configure_file（）命令源的任何文件）。因此，如果可以选择的话，最好使用add_custom_target（）或add_custom_command（）而不是execute_process（）。

It is relatively common to see platform specific commands used with add_custom_command(), add_custom_target() and execute_process(). Quite often, however, such commands can instead be expressed in a platform independent manner using CMake’s command mode (-E). Where possible, the use of platform independent commands should be preferred. In addition, CMake can be used as a platform independent scripting language, processing a file as a sequence of CMake commands when invoked with the -P option. The use of CMake scripts instead of a platform specific shell or a separately installed script engine can reduce the complexity of the project and reduce the additional dependencies it requires in order to build. Specifically, consider whether CMake’s script mode would be a better choice than using a Unix shell script or Windows batch file, or even a script for a language like Python, Perl etc. which may not be available by default on all platforms. The next chapter shows how to manipulate files directly with CMake instead of having to resort to such tools and methods.

与add_custom_command（）、add_custom_target（）和execute_process（）一起使用的特定于平台的命令相对常见。然而，通常情况下，这些命令可以使用CMake的命令模式（-E）以独立于平台的方式表示。在可能的情况下，应优先使用独立于平台的命令。此外，CMake可以用作独立于平台的脚本语言，在使用-P选项调用时，将文件作为CMake命令序列进行处理。使用CMake脚本而不是特定于平台的shell或单独安装的脚本引擎可以降低项目的复杂性，并减少构建所需的额外依赖关系。具体来说，考虑CMake的脚本模式是否比使用Unix shell脚本或Windows批处理文件，甚至是Python、Perl等语言的脚本更好，这些脚本可能不是默认情况下在所有平台上都可用。下一章将展示如何使用CMake直接操作文件，而不必求助于这些工具和方法。

When implementing custom tasks, try to avoid those features which do not have universal support across all platforms. 【译】在实现自定义任务时，尽量避免那些在所有平台上都没有通用支持的功能。

• Prefer to use command mode -E echo rather than the COMMENT keyword with add_custom_command() and add_custom_target(). 【译】更喜欢使用命令模式-E echo，而不是带有add_custom_command（）和add_custom_target（）的COMMENT关键字。

• Try to avoid using PRE_BUILD with the TARGET form of add_custom_command(). 【译】尽量避免将PRE_BUILD与add_custom_command（）的TARGET形式一起使用。

• Consider whether using IMPLICIT_DEPENDS or DEPFILE options with add_custom_command() is worth the generator-specific behavior. 【译】考虑在add_custom_command（）中使用IMPLICT_DEPENDS或DEPFILE选项是否值得生成器特定的行为。

• Avoid listing a source file as a MAIN_DEPENDENCY in add_custom_command() unless the intention is to replace the default build rule for that source file.【译】避免在add_custom_command（）中将源文件列为MAIN_DEPENDENCY，除非目的是替换该源文件的默认构建规则。

Pay special attention to dependencies for the inputs and outputs of custom tasks. Ensure that all files created by add_custom_command() are listed as OUTPUT files. When listing build targets as the command or arguments in a call to add_custom_command() or add_custom_target(), prefer to explicitly list them as DEPENDS items rather than relying on CMake’s automatic target dependency handling. The weaker automatic dependencies may not enforce all the relationships that developers may intuitively expect. If listing a file in DEPENDS for either add_custom_target() or add_custom_command(), always use an absolute path to avoid non-robust legacy path matching behavior.

特别注意自定义任务的输入和输出的依赖关系。确保add_custom_command（）创建的所有文件都列为OUTPUT文件。在调用add_custom_command（）或add_custom_target（）时，将构建目标作为命令或参数列出时，最好将它们显式地列为DEPENDS项，而不是依赖CMake的自动目标依赖处理。较弱的自动依赖关系可能无法强制执行开发人员直观期望的所有关系。如果在DEPENDS中为add_custom_target（）或add_custom_command（）列出文件，请始终使用绝对路径，以避免不可靠的传统路径匹配行为。

When calling execute_process(), most of the time the success of the command should be tested by capturing the result using RESULT_VARIABLE and testing it with the if() command. This includes when a TIMEOUT option is being used, since TIMEOUT on its own will not generate an error, it will only ensure the command doesn’t run longer than the nominated timeout period.

调用execute_process()时，大多数时候应该通过使用result_VARIABLE捕获结果并使用if()命令进行测试来测试命令的成功。这包括当使用TIMEOUT选项时，由于TIMEOUT本身不会产生错误，它只会确保命令的运行时间不会超过指定的超时时间。
