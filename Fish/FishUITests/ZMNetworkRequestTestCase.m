//
//  ZMNetworkRequestTestCase.m
//  FishUITests
//
//  Created by zhaoming on 24/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZMTestModel.h"

@interface ZMNetworkRequestTestCase : XCTestCase

@end

@implementation ZMNetworkRequestTestCase

- (void)functionName:(NSObject*)string, ...{
            va_list args;
    
            va_start(args, string);
    
            if(string){
        
                           NSString *otherString;
        
                           while((otherString = va_arg(args, NSString *))){
                            NSLog(@"---%@",otherString);
                                        //依次取得所有参数
            
                               }
        
                }
    
            va_end(args);
    
}

- (void)setUp {
    [super setUp];
    
//    [self randomModels];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)add:(NSArray *)array array1:(NSArray *)array1 {
    
}

- (void)testModelConvert {
    
    NSString * json = @"{\"name\":\"SindriLin\",\"age\":22,\"flags\":987654321}";
    NSMutableDictionary * dict = [[NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding: NSUTF8StringEncoding] options: kNilOptions error: nil] mutableCopy];
    ZMTestModel * model = [[ZMTestModel alloc] initWithDictionary: dict];
    XCTAssertNotNil(model);
    XCTAssertTrue([model.name isEqualToString: @"SindriLin"]);
    XCTAssertTrue([model.age isEqual: @(22)]);
    XCTAssertEqual(model.flags, 987654321);
    XCTAssertTrue([model isKindOfClass: [ZMTestModel class]]);
    model = [[ZMTestModel new] initWithName: @"Tessie" age: dict[@"age"] flags: 562525];
    XCTAssertNotNil(model);
    XCTAssertTrue([model.name isEqualToString: @"Tessie"]);
    XCTAssertTrue([model.age isEqual: dict[@"age"]]);
    XCTAssertEqual(model.flags, 562525);
    NSDictionary * modelJSON = [model modelToDictionary];
    XCTAssertTrue([modelJSON isEqual: dict] == NO);
    dict[@"name"] = @"Tessie";
    dict[@"flags"] = @(562525);
    XCTAssertTrue([modelJSON isEqual: dict]);
}

- (NSArray<ZMTestModel *> *)randomModels
{
    NSMutableArray * models = @[].mutableCopy;
    NSArray * names = @[
                        @"SindriLin", @"Bison", @"XiongZengHui", @"ZengChengChun", @"Tessie"
                        ];
    NSArray * ages = @[
                       @15, @20, @25, @30, @35
                       ];
    NSArray * flags = @[
                        @123, @456, @789, @012, @234
                        ];
    for (NSUInteger idx = 0; idx < 100000; idx++) {
        ZMTestModel * model = [[ZMTestModel new] initWithName: names[arc4random() % names.count] age: ages[arc4random() % ages.count] flags:1231];
        [models addObject: model];
//        [NSThread sleepForTimeInterval: 0.01];
    }
    return models;
}
- (void)testParams:(NSString *)title addMoreParams:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION {
    
    NSLog(@"传多个参数的第一个参数 %@",string);//是other1
    
    //1.定义一个指向个数可变的参数列表指针；
    va_list args;
    
    //2.va_start(args, str);string为第一个参数，也就是最右边的已知参数,这里就是获取第一个可选参数的地址.使参数列表指针指向函数参数列表中的第一个可选参数，函数参数列表中参数在内存中的顺序与函数声明时的顺序是一致的。
    va_start(args, string);
    
    if (string)
    {
        //依次取得除第一个参数以外的参数
        //4.va_arg(args,NSString)：返回参数列表中指针所指的参数，返回类型为NSString，并使参数指针指向参数列表中下一个参数。
        while (va_arg(args, NSString *))
        {
            NSString *otherString = va_arg(args, NSString *);
            NSLog(@"otherString %@",otherString);
        }
    }
    //5.清空参数列表，并置参数指针args无效。
    va_end(args);
    
}

- (void)testAsynExample {
    [self testParams:@"title" addMoreParams:@"other1",@"other2", @"other3",nil];;
    [self functionName:@"123",@"xx",@"aaa",@"ss",nil];
    return;
    
    NSLog(@"line is --%ld, --%s, ---%s",__LINE__, __TIME__,__DATE__);
    XCTestExpectation *exp = [self expectationWithDescription:@"这里可以是操作出错的原因描述。。。"];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        //模拟这个异步操作需要2秒后才能获取结果，比如一个异步网络请求
        sleep(2);
        //模拟获取的异步操作后，获取结果，判断异步方法的结果是否正确
        XCTAssertEqual(@"a", @"a");
        //如果断言没问题，就调用fulfill宣布测试满足
        [exp fulfill];
    }];
    
    //设置延迟多少秒后，如果没有满足测试条件就报错
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

//- (void)testThatBackgroundImageChanges {
//
//    XCTAssertNil([self.button backgroundImageForState:UIControlStateNormal]);
//    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(UIButton  * _Nonnull button, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [button backgroundImageForState:UIControlStateNormal] != nil;
//    }];
//
//    [self expectationForPredicate:predicate
//              evaluatedWithObject:self.button
//                          handler:nil];
//    [self waitForExpectationsWithTimeout:20 handler:nil];
//}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        NSLog(@"---%@",[self randomModels]);
        // Put the code you want to measure the time of here.
    }];
}

@end
