----Part I: Fundamentals----	6
Ch1.Introduction	8


Ch2. Setting Up A Project	12
2.1. In-source Builds	14
2.2. Out-of-source Builds	14
2.3. Generating Project Files	15
2.4. Running The Build Tool	18
2.5. Recommended Practices	20


Ch3. A Minimal Project	21
3.1. Managing CMake versions	23
3.2. The project() Command	26
3.3. Building A Basic Executable	29
3.4. Commenting	30
3.5. Recommended Practices	31


Ch4. Building Simple Targets	32
4.1. Executables	33
4.2. Defining Libraries	35
4.3. Linking Targets	37
4.4. Linking Non-targets	40
4.5. Old-style CMake	42
4.6. Recommended Practices	44


Ch5. Variables	46
5.1. Variable Basics	46
5.2. Environment Variables	50
5.3. Cache Variables	50
5.4. Manipulating Cache Variables	55
5.4.1. Setting Cache Values On The Command Line	55
5.4.2. CMake GUI Tools	57
5.5. Debugging Variables And Diagnostics	65
5.6. String Handling	68
#5.6.1 string(FIND)	69
#5.6.2string(REPLACE	69
#5.6.3string(REGEX)	70
#5.6.4string(SUBSTRING)	71
#5.6.5string(LENGTH)/string(TOLOWER)/string(STRIP)	71
5.7. Lists	72
#5.7.1 list(LENGTH)/list(GET)	73
#5.7.2 list(APPEND)/list(INSERT)	73
#5.7.3 list(FIND)	74
#5.7.4 list(REMOVE_XXX)	75
#5.7.5 list(REVERSE)/list(SORT)	75
5.8. Math	76
5.9. Recommended Practices	77


Ch6. Flow Control	79
6.1. The if() Command	80
6.1.1. Basic Expressions	81
6.1.2. Logic Operators	84
6.1.3. Comparison Tests	84
6.1.4. File System Tests	87
6.1.5. Existence Tests	88
6.1.6. Common Examples	91
6.2. Looping	93
6.2.1. foreach()	94
6.2.2. while()	96
6.2.3. Interrupting Loops	97
6.3. Recommended Practices	98


Ch7. Using Subdirectories	99
7.1. add_subdirectory()	101
7.1.1. Source And Binary Directory Variables	102
7.1.2. Scope	104
7.2. include()	109
7.4. Recommended Practices	114


Ch8. Functions And Macros	116
8.1. The Basics	116
8.2. Argument Handling Essentials	117
8.3. Keyword Arguments	122
8.4. Scope	126
8.5. Overriding Commands	129
8.6. Recommended Practices	132


Ch9. Properties	134
9.1. General Property Commands	134
9.2. Global Properties	139
9.3. Directory Properties	141
9.4. Target Properties	143
9.5. Source Properties	144
9.6. Cache Variable Properties	146
9.7. Other Property Types	148
9.8. Recommended Practices	149


Ch10. Generator Expressions	151
10.1. Simple Boolean Logic	154
10.2. Target Details	157
10.3. General Information	161
10.3.1 $<CONFIG>	161
10.3.2 $<PLATFORM_ID>	162
10.3.3$<C_COMPILER_VERSION>, <CXX_COMPILER_VERSION>	162
10.3.4$<LOWER_CASE:…>, $<UPPER_CASE:…>	163
10.4. Recommended Practices	163


Ch11. Modules	165
11.1. Useful Development Aids	169
11.2. Endianness	171
11.3. Checking Existence And Support	171
11.4. Other Modules	181
11.5. Recommended Practices	182


Ch12. Policies	185
12.1. Policy Control	185
12.2. Policy Scope	192
12.3. Recommended Practices	194
----Part II: Builds In Depth----	197
Ch13. Build Type	198
13.1. Build Type Basics	198
13.1.1. Single Configuration Generators	200
13.1.2. Multiple Configuration Generators	201
13.2. Common Errors	202
13.3. Custom Build Types	204
13.4. Recommended Practices	212


Ch14. Compiler And Linker Essentials	215
14.1. Target Properties	215
14.1.1. Compiler Flags	216
14.1.2. Linker Flags	219
14.1.3. Target Property Commands	221
14.2. Directory Properties And Commands	226
14.3. Compiler And Linker Variables	233
14.4. Recommended Practices	241


Ch15. Language Requirements	245
15.1. Setting The Language Standard Directly	246
15.2. Setting The Language Standard By Feature Requirements	250
15.2.1. Detection And Use Of Optional Language Features	254
15.3. Recommended Practices	259


Ch16. Target Types	263
16.1. Executables	263
16.2. Libraries	265
16.4. Recommended Practices	279


Ch17. Custom Tasks	283
17.1. Custom Targets	283
17.2. Adding Build Steps To An Existing Target	289
17.3. Commands That Generate Files	291
17.4. Configure Time Tasks	299
17.5. Platform Independent Commands	304
17.6. Combining The Different Approaches	308
17.7. Recommended Practices	310


Ch18. Working With Files	312
18.1. Manipulating Paths	314
18.2. Copying Files	318
18.3. Reading And Writing Files Directly	330
18.4. File System Manipulation	337
18.5. Downloading And Uploading	342
18.6. Recommended Practices	345


Ch19. Specifying Version Details	349
19.1. Project Version	349
19.2. Source Code Access To Version Details	353
19.3. Source Control Commits	358
19.4. Recommended Practices	362


Ch20. Libraries	365
20.1. Build Basics	366
20.2. Linking Static Libraries	368
20.3. Shared Library Versioning	369
20.4. Interface Compatibility	373
20.5. Symbol Visibility	381
20.5.1. Specifying Default Visibility	384
20.5.2. Specifying Individual Symbol Visibilities	386
20.6. Mixing Static And Shared Libraries	395
20.7. Recommended Practices	401


Ch21. Toolchains And Cross Compiling	405
21.1. Toolchain Files	407
21.2. Defining The Target System	410
21.3. Tool Selection	413
21.4. System Roots	418
21.5. Compiler Checks	419
21.6. Examples	422
21.6.1. Raspberry Pi	422
21.6.2. GCC With 32-bit Target On 64-bit Host	423
21.6.3. Android	424
21.7. Recommended Practices	435


Ch22. Apple Features	438
22.1. CMake Generator Selection	439
22.2. Application Bundles	442
22.3. Frameworks	451
22.4. Loadable Bundles	457
22.5. Build Settings	458
22.6. Code Signing	463
22.7. Creating And Exporting Archives	468
22.8. Limitations	471
22.9. Recommended Practices	474

----Part III: The Bigger Picture----	479
Ch23. Finding Things	482
23.1. Finding Files and Paths	483
23.1.1. Apple-specific Behavior	491
23.1.2. Cross-compilation Controls	492
23.2. Finding Paths	495
23.3. Finding Programs	495
23.4. Finding Libraries	498
23.5. Finding Packages	503
23.5.1. Package Registries	518
23.5.2. FindPkgConfig	521
23.6. Recommended Practices	527


Ch24. Testing	534
24.1. Defining And Executing A Simple Test	534
24.2. Pass / Fail Criteria And Other Result Types	542
24.3. Test Grouping And Selection	548
24.4. Parallel Execution	554
24.5. Test Dependencies	558
24.6. Cross-compiling And Emulators	563
24.7. Build And Test Mode	565
24.8. CDash Integration	570
24.8.1. Key CDash Concepts	571
24.8.2. Executing Pipelines And Actions	573
24.8.3. CTest Configuration	577
24.8.4. Test Measurements And Results	584
24.9. GoogleTest	587
24.10. Recommended Practices	595


Ch25. Installing	602
25.1. Directory Layout	604
25.1.1. Relative Layout	605
25.1.2. Base Install Location	608
25.2.1. Interface Properties	619
25.2.2. RPATH	621
25.2.3. Apple-specific Targets	629
25.3. Installing Exports	635
25.4. Installing Files And Directories	641
25.5. Custom Install Logic	646
25.6. Installing Dependencies	647
25.7. Writing A Config Package File	650
25.7.1. Config Files For CMake Projects	652
25.7.2. Config Files For Non-CMake Projects	665
25.8. Recommended Practices	667

Ch26. Packaging	671
26.1. Packaging Basics	673
26.2. Components	678
26.3. Multi Configuration Packages	684
26.4. Package Generators	686
26.4.1. Simple Archives	687
26.4.2. Qt Installer Framework (IFW)	689
26.4.3. WIX	695
26.4.4. NSIS	699
26.4.5. DragNDrop	702
26.4.6. productbuild	705
26.4.7. RPM	709
26.4.8. DEB	718
26.4.9. FreeBSD	721
26.4.10. Cygwin	721
26.4.11. NuGet	722
26.5. Recommended Practices	722


Ch27. External Content	727
27.1. ExternalProject	729
    27.1.1. Tour Of Main Features	731
    27.1.2. Step Management	743
    27.1.3. Miscellaneous Features	749
    27.1.4. Common Issues	752
27.2. FetchContent	756
    27.2.1. Developer Overrides	763
    27.2.2. Other Uses For FetchContent	766
    27.2.3. Restrictions	768
27.3. ExternalData	770
27.4. Recommended Practices	772


Ch28. Project Organization	776
28.1. Superbuild Structure	777
28.2. Non-superbuild Structure	781
28.3. Common Top Level Subdirectories	788
28.4. IDE Projects	790
28.5. Defining Targets	795
28.5.1. Target Sources	798
28.5.2. Target Outputs	804
28.5.3. Windows Specific Issues	808
28.6. Miscellaneous Project Features	811
28.7. Recommended Practices	815
