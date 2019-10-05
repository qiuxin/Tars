# 目录
> * [1.In general](#main-chapter-1)
> * [2.Test Environment](#main-chapter-2)
> * [3.File Updates](#main-chapter-3)
> * [4.Compilation](#main-chapter-4)

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


# 3. <a id="main-chapter-2"></a>File Update
The following files are modified to make tars support tars platform.


# 4. <a id="main-chapter-2"></a> Compilation
Compile the Tars via the following commands:
-  Step1: git clone -b arm https://github.com/qiuxin/Tars.git
-  Step2: git checkout arm
-  Step3: cd $Download_Path/Tars/armcompile
-  Step4: ./basic_soft_install.sh
-  Step5: ./install_mysql_57.sh
-  Step6: ./install_nvm.sh
-  Step7: Run the following command:
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

