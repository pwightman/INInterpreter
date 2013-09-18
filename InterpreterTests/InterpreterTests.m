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
}

- (void)testPrint
{
    __block BOOL didRun = NO;
    
    NSDictionary *method = @{
        @"name":  @"print",
        @"block": ^(NSArray *args) {
            NSLog(@"%@", args[0]);
            didRun = YES;
            XCTAssertEqualObjects(@"Hello World!", args[0], @"");
        }
    };
    
    [_interpreter loadMethod:method];
    
    NSDictionary *program = @{
        @"call": @{
            @"method": @"print",
            @"args": @[ @"Hello World!" ]
        }
    };
    
    [_interpreter runJSON:program];
    
    XCTAssertEqual(YES, didRun, @"");
}

- (void)testIf
{
    __block BOOL didRun = NO;
    NSNumber *value = @NO;
    
    NSDictionary *method = @{
        @"name":  @"print",
        @"block": ^(NSArray *args) {
            NSLog(@"%@", args[0]);
            didRun = YES;
            XCTAssertEqualObjects(@"Hello World!", args[0], @"");
        }
    };
    
    [_interpreter loadMethod:method];
    
    NSDictionary *program = @{
        @"if": @{
            @"test": value,
            @"true": @[
                @{
                    @"call": @{
                        @"method": @"print",
                        @"args": @[ @"Hello World!" ]
                    }
                }
            ]
        }
    };
    
    [_interpreter runJSON:program];
    
    XCTAssertEqual(NO, didRun, @"");
    
    value = @YES;
    
    program = @{
        @"if": @{
            @"test": value,
            @"true": @[
                @{
                    @"call": @{
                        @"method": @"print",
                        @"args": @[ @"Hello World!" ]
                    }
                }
            ]
        }
    };
    
    [_interpreter runJSON:program];
    
    XCTAssertEqual(YES, didRun, @"");
}

@end
