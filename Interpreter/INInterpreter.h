//
//  INInterpreter.h
//  Interpreter
//
//  Created by Parker Wightman on 9/16/13.
//  Copyright (c) 2013 Alora Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INInterpreter : NSObject

- (void)runJSON:(NSDictionary *)JSON;
- (void)runJSONString:(NSString *)JSONString;

+ (instancetype)interpreter;
- (void)loadMethod:(NSDictionary *)method;

@end
