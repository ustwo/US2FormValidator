//
//  US2ConditionCollection.m
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

#import "US2ConditionCollection.h"


@implementation US2ConditionCollection


@dynamic count;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _array  = [[NSMutableArray array] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_array release];
    
    [super dealloc];
}


#pragma mark - Manipulation

- (void)addCondition:(id <US2ConditionProtocol>)condition
{
    [_array addObject:condition];
}

- (void)removeCondition:(id <US2ConditionProtocol>)condition
{
    [_array removeObject:condition];
}

- (void)removeConditionAtIndex:(NSUInteger)index
{
    [_array removeObjectAtIndex:index];
}

- (US2Condition *)conditionAtIndex:(NSUInteger)index
{
    return [_array objectAtIndex:index];
}

- (void) removeAllConditions {
    [_array removeAllObjects];
}

#pragma mark - Fast enumeration

//- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}


#pragma mark - Information

- (NSUInteger)count
{
    return _array.count;
}


#pragma mark - Description

/**
 Returns the description
 
 @return Description string
*/
- (NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    for (US2Condition *condition in _array)
    {
        [description appendString:condition.description];
    }
    
    return description;
}


@end
