描述
用于java的单元测试的框架
引入
junit.jar

hamcrest.jar
流程
定义测试类和测试单元
public class JunitTest{

@Test

public void test1(){

//...

}

@Test

public void test2(){

//...

}

}
定义测试单元的增强
public class JunitTest{

@Before

public void testBefore(){

//...

}

@After

public void testAfte(){

//...

}

}

