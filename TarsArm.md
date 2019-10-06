# Table of Contents
> * [1.In general](#main-chapter-1)
> * [2.Test Environment](#main-chapter-2)
> * [3.File Update for Arm Compile](#main-chapter-3)
> * [4.Create New File for Arm Compile](#main-chapter-4)
> * [5.Compplie Instruction](#main-chapter-4)

# 1. <a id="main-chapter-1"></a>In general
-  This page is used to distribute the new support for arm platform.
-  We did some midfications to make tars can be compiled and run in Arm platform.

# 2. <a id="main-chapter-2"></a>Test Hardware
Test based on the followiing hardware:
-  CPU	1x 32 core 3.3 GHz  ARMv8 64-bit Processor
-  RAM	8x 16GB DDR4-DIMM
-  Storage	1x 480GB SSD
-  Networking 
-  -  2x 25Gbe SFP+ (connected)
-  -  1x 1Gbe BASE-T (not connected)
-  -  1x IPMI / Lights-out Management


# 3. <a id="main-chapter-2"></a>File Update for Arm Compile
The following files are modified to make tars support tars platform.
-  /TarsCpp/util/include/util/tc_atomic.h
-  /TarsCpp/util/include/util/tc_fcontext.h
-  /TarsCpp/util/include/util/tc_timeprovider.h
-  /TarsCpp/util/src/CMakeLists.txt
-  /TarsCpp/util/src/tc_timeprovider.cpp

# 4. <a id="main-chapter-2"></a>Create New File for Arm Compile
-  /TarsCpp/util/include/util/tc_fcontext_aarch64.h
-  /TarsCpp/util/src/tc_jump_aarch64_sysv_elf_gas.s
-  /TarsCpp/util/src/tc_make_aarch64_sysv_elf_gas.s

# 5. <a id="main-chapter-2"></a> Complie Instruction
Compile the Tars via the following commands:
-  Step1: git clone -b arm https://github.com/qiuxin/Tars.git
-  Step2: git checkout arm
-  Step3: cd tars
-  Step4: git submodule update --init --recursive
-  Step5: cd $Download_Path/Tars/armcompile
-  Step6: ./basic_soft_install.sh
-  Step7: ./install_mysql_57.sh
-  Step8: ./install_nvm.sh
-  Step9: Run the following command:
```
cd $Download_Path/Tars/framework
find . -name 'CMakeLists.txt' | xargs perl -pi -e 's|/usr/local/mysql/include|/usr/include/mysql|g'
find . -name 'CMakeLists.txt' | xargs perl -pi -e 's|/usr/local/mysql/lib|/usr/lib64/mysql|g'
cd $Download_Path/Tars/framework/tarscpp
find . -name 'CMakeLists.txt' | xargs perl -pi -e 's|/usr/local/mysql/include|/usr/include/mysql|g'
find . -name 'CMakeLists.txt' | xargs perl -pi -e 's|/usr/local/mysql/lib|/usr/lib64/mysql|g'
cd $Download_Path/Tars/framework/build
./build.sh all
```


# 6. <a id="main-chapter-2"></a> Solve the Compile errors 
In the process of compiling tars code, you may encounter the following errors:
```
/usr/local/robert/Tars/framework/tarscpp/util/include/util/tc_mysql.h:20:19: fatal error: mysql.h: No such file or directory
 #include "mysql.h"
```


```
make[2]: *** No rule to make target `/usr/lib64/mysql/libmysqlclient.a', needed by `deploy/tarsconfig/bin/tarsconfig'.  Stop.
make[1]: *** [ConfigServer/CMakeFiles/tarsconfig.dir/all] Error 2
make: *** [all] Error 2
```

The way handing is that：

Step1: Find the location of mysql.h and libmysqlclient.a via the following commands
```
find / -name mysql.h
find / -name libmysqlclient.a
```

Step2: Set the path whihc includes mysql.h and libmysqlclient.a to the following “CMakeLists.txt”

Update the path of "/TarsFramework/tarscpp/CMakeLists.txt"
```
#set(MYSQL_DIR_INC "/usr/include/mysql")
set(MYSQL_DIR_INC "/usr/local/mysql/include")

#set(MYSQL_DIR_LIB "/usr/lib64/mysql")
set(MYSQL_DIR_LIB "/usr/local/mysql/lib")
```



/TarsFramework/CMakeLists.txt
```
#set(MYSQL_DIR_INC "/usr/include/mysql")
set(MYSQL_DIR_INC "/usr/local/mysql/include")

#set(MYSQL_DIR_LIB "/usr/lib64/mysql")
set(MYSQL_DIR_LIB "/usr/local/mysql/lib")
```