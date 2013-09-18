//
//  InterpreterTests.m
//  InterpreterTests
//
//  Created by Parker Wightman on 9/16/13.
//  Copyright (c) 2013 Alora Studios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INInterpreter.h"

@interface InterpreterTests : XCTestCase

@property (strong, nonatomic) INInterpreter *interpreter;

@end

@implementation InterpreterTests

- (void)setUp
{
    [super setUp];
    _interpreter = [[INInterpreter alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPrint
{
    __block BOOL didRun = NO;
    
    NSDictionary *method = @{
                             @"name": @"print",
                             @"block": ^(NSArray *args) {
                                 NSLog(@"%@", args[0]);
                                 didRun = YES;
                                 XCTAssertEqualObjects(@"Hello World!", args[0], @"");
                             }
                         };
    
    [_interpreter loadMethod:method];
    
    NSDictionary *program = @{
                              @"program": @[
                                      @{
                                          @"call": @{
                                                  @"method": @"print",
                                                  @"args": @[ @"Hello World!" ]
                                                  }
                                          }
                                      ]
                              };
    
    [_interpreter runJSON:program];
    
    XCTAssertEqual(YES, didRun, @"");
}

@end
