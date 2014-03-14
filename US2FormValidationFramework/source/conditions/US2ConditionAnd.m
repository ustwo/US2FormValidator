//
//  US2ConditionAnd.m
//  US2FormValidator
//
//  Created by Matthew Purland <m.purland@gmail.com>
//  Copyright (C) 2012 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "US2ConditionAnd.h"


@interface US2ConditionAnd ()

@property (nonatomic) NSArray *conditions;

@end


@implementation US2ConditionAnd


#pragma mark - Initialization

- (id)initWithConditions:(NSArray *)conditions
{
    self = [super init];
    if (self)
    {
        self.conditions = [conditions mutableCopy];
    }
    
    return self;
}

- (id)initWithConditionOne:(id<US2ConditionProtocol>)one two:(id<US2ConditionProtocol>)two
{
    self = [self initWithConditions:@[one, two]];
    
    return self;
}

- (BOOL)check:(NSString *)string
{
    BOOL result = YES;
    
    for (id<US2ConditionProtocol> condition in self.conditions)
    {
        result = result && [condition check:string];
    }
    
    return result;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return nil;
}

@end
