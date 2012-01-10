//
//  US2Validator.m
//  US2FormValidator
//
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

#import "US2Validator.h"
#import "US2Condition.h"
#import "US2ConditionCollection.h"


@implementation US2Validator


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _conditionCollection = [[US2ConditionCollection alloc] init];
    }
    
    return self;
}


#pragma mark - Deinitialization

- (void)dealloc
{
    [_conditionCollection release];
    
    [super dealloc];
}


#pragma mark - Condition

/**
 Add condition for validation queue.
*/
- (void)addCondition:(id <US2ConditionProtocol>)condition
{
    if ([condition isKindOfClass:[US2Condition class]])
        [_conditionCollection addCondition:condition];
    else
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible condition <%@> to validator.", [condition class]], nil];
}

/**
 Remove all conditions which are kind of specific class.
*/
- (void)removeConditionOfClass:(id <US2ConditionProtocol>)conditionClass
{
    for (US2Condition *condition in _conditionCollection)
    {
        if ([condition isKindOfClass:(id)conditionClass])
            [_conditionCollection removeCondition:condition];
    }
}


#pragma mark - Condition check

/**
 Returns all violated condition in a US2ConditionCollection
*/
- (US2ConditionCollection *)checkConditions:(NSString *)string
{
    US2ConditionCollection *violatedConditions = nil;
    for (US2Condition *condition in _conditionCollection)
    {
        if (NO == [condition check:string])
        {
            if (nil == violatedConditions)
                violatedConditions = [[US2ConditionCollection alloc] init];
            
            [violatedConditions addCondition:condition];
        }
    }
    
    return [violatedConditions autorelease];
}


@end
