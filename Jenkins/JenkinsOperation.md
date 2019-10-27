
# Table of contents(Arm Platform)  
> * [Note Well](#chapter-1)  
> * [Environments](#chapter-2)  
> * [Download and Install Jenkins ](#chapter-3)  
> * [Install Mysql](#chapter-4)  
> * [Install NVM](#chapter-5)  
> * [Download and Compile TarsFramework](#chapter-6)
> * [Install TarsFramework](#chapter-7) 
> * [Initialize Database](#chapter-8)  
> * [Start TarsFramework Services](#chapter-9)  
> * [Install Tarsweb](#chapter-10)  
> * [Compile TarsFramework NoneCore Service](#chapter-11)  
> * [Visit web](#chapter-12)  

## 1. <a id="chapter-1"></a> Note Well
This document describes the process of Jenkins CI.

## 2. <a id="chapter-2"></a> Environments   
System : CentOS 7  
Hardware requirements: aarch64 Arm Server  
  
## 3. <a id="chapter-3"></a> Download and Install Jenkins 
Download Jenkins
```  
wget http://mirror.serverion.com/jenkins/war-stable/2.190.1/jenkins.war
```  
Install Java
```
sudo yum install -y java-1.8.0-openjdk-devel
```

Start Jenkins
```  
java -jar jenkins.war --httpPort=8080 &
```  

Open the website in your PC:
```  
http://localhost:8080.
``` 
Install the jenkins step by step via the website gudience.

## 4. <a id="chapter-3"></a> Connect Jenkins to Github
https://wordpress.com/post/qiuxincsu.wordpress.com/685