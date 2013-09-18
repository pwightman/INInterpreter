//
//  INInterpreter.m
//  Interpreter
//
//  Created by Parker Wightman on 9/16/13.
//  Copyright (c) 2013 Alora Studios. All rights reserved.
//

#import "INInterpreter.h"

@interface INInterpreter ()

@property (strong, nonatomic) NSDictionary *program;
@property (strong, nonatomic) NSMutableDictionary *methods;

@end

@implementation INInterpreter

+ (instancetype)interpreter
{
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _methods = [@{} mutableCopy];
    }
    
    return self;
}

- (void)runJSONString:(NSString *)JSONString
{
    NSData *data = [NSData dataWithBytes:[JSONString UTF8String] length:JSONString.length];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    assert(dict);
    
    return [self runJSON:dict];
}

- (void)runJSON:(NSDictionary *)JSON {
    [JSON[@"program"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = [obj allKeys][0];
        if ([key isEqualToString:@"call"]) {
            void (^method)(NSArray *) = _methods[obj[key][@"method"]];
            method(obj[key][@"args"]);
        }
    }];
}

- (void)loadMethod:(NSDictionary *)method {
    [_methods setObject:method[@"block"] forKey:method[@"name"]];
}

@end
