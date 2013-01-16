//
//  US2ConditionCollection.h
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

#import <Foundation/Foundation.h>
#import "US2Condition.h"


#pragma mark - Condition collection protocol

@class US2ConditionCollection;

/**
 A _condition collection_ must conform to US2ConditionCollection protocol methods.
*/
@protocol US2ConditionCollectionProtocol <NSObject>

@required

/**
 Add a condition to collection.
 
 @param condition US2Condition instance to add
*/
- (void)addCondition:(id <US2ConditionProtocol>)condition;

/**
 Remove a condition from collection.
 
 @param condition US2Condition instance to remove
*/
- (void)removeCondition:(id <US2ConditionProtocol>)condition;

/**
 Remove a condition from collection at index.
 
 @param index US2Condition instance to remove at index
*/
- (void)removeConditionAtIndex:(NSUInteger)index;

/**
 Returns a condition of collection at index.
 
 @param index Index of condition
 @return Return US2Condition instance at index
*/
- (US2Condition *)conditionAtIndex:(NSUInteger)index;

/**
 Remove all conditions from collection.
 */
- (void)removeAllConditions;

@end


#pragma mark - Condition collection interface

/**
 The US2ConditionCollection is internally an array which contains conditions
 of type US2Condition. Use US2ConditionCollection like an array, but in a 
 typecasted manner.
 
 *Example:*
 
    US2ConditionCollection *conditionCollection = [[US2ConditionCollection alloc] init];
 
    US2Condition *condition1 = [[US2Condition alloc] init];
    [conditionCollection addCondition:condition1];
    [condition1 release];
 
    US2Condition *condition2 = [conditionCollection conditionAtIndex:0];
    [conditionCollection removeCondition:condition2];
 
    BOOL isEmpty = conditionCollection.count == 0;                                          // isEmpty == YES
*/
@interface US2ConditionCollection : NSObject <US2ConditionCollectionProtocol,
                                              NSFastEnumeration>
{
    NSMutableArray *_array;
}

/**
 Add a condition to collection.
 
 @param condition US2Condition instance to add
*/
- (void)addCondition:(id <US2ConditionProtocol>)condition;

/**
 Remove a condition from collection.
 
 @param condition US2Condition instance to remove
*/
- (void)removeCondition:(id <US2ConditionProtocol>)condition;

/**
 Remove a condition from collection at index.
 
 @param index US2Condition instance to remove at index
*/
- (void)removeConditionAtIndex:(NSUInteger)index;

/**
 Returns a condition of collection at index.
 
 @param index Index of condition
 @return Return US2Condition instance at index
*/
- (US2Condition *)conditionAtIndex:(NSUInteger)index;

/**
 Remove all conditions from collection.
 */
- (void) removeAllConditions;

/**
 Number of conditions in collection.
*/
@property (nonatomic, assign, readonly) NSUInteger count;


@end
