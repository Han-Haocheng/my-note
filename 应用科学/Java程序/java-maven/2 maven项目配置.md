# 根元素project
描述：配置的根元素，用于表示此配置文件为maven项目配置，提供maven配置命名空间

属性
- xml命名空间：`xmlns="http://maven.apache.org/POM/4.0.0"`
- 引入命名标准的实例：`xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"`
- 引入maven命名标准：`xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/maven-v4_0_0.xsd"`

# 包引入环境元素dependencises
描述：创建用于引入包的环境

## 引入包dependency
描述：引入包

# 继承环境parent
## 子元素
- `<groupId>`：工程组id
- `<artifactId>`：项目id
- `<version>`：项目版本

# 引入管理
描述：用于子项目自主引入调用包管理

# 示例
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/maven-v4_0_0.xsd">
  <!--继承父项目配置-->
  <parent>
    <groupId>org.myspringboot</groupId>  
    <artifactId>my-spring-boot</artifactId>  
    <version>1.0-SNAPSHOT</version>  
    <relativePath>../pom.xml</relativePath>
  </parent>

  <!--项目配置-->
  <artifactId>untitled</artifactId>
  <packaging>war</packaging>  
  <name>untitled Maven Webapp</name>  
  <url>https://maven.apache.org</url>

  <!--包引入-->
  <dependencies>  
    <dependency>        
        <groupId>junit</groupId>  
        <artifactId>junit</artifactId>  
        <version>3.8.1</version>  
        <scope>test</scope>  
    </dependency>
  </dependencies>

  
</project>
```