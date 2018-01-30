//
//  YS_iOS_OtherTests.m
//  YS_iOS_OtherTests
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface YS_iOS_OtherTests : XCTestCase

{
@private
    float f1;
    float f2;
}

- (void)testAddition;

@end

@implementation YS_iOS_OtherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    f1 = 2.0;
    f2 = 3.0;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - 测试用例

/**
 *  test- 会自动被识别为测试用例
 *  关于测试函数执行的顺序：以函数名中 test 后面的字符大小有关，比如 -(void)test001XXX 会先于 -(void)test002XXX 执行；
 */
- (void)testAddition
{
    XCTAssertTrue(f1 + f2 == 5.0, @"%f + %f should equal 5.0", f1, f2);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
