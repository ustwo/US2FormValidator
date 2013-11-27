//
//  US2Validator.h
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
#import "US2ConditionCollection.h"


typedef NS_ENUM(NSUInteger, US2ConditionPriority)
{
    US2ConditionPriorityLowest = 0,
    US2ConditionPriorityHighest = NSUIntegerMax
};


#pragma mark - Validator protocol

@protocol US2Condition;
@protocol US2ConditionCollection;

/**
 A _validator_ must conform to US2ValidatorProtocol protocol methods.
*/
@protocol US2ValidatorProtocol <NSObject>

/**
 Add condition conform to US2ConditionProtocol
 
 @param condition Condition conform to US2ConditionProtocol
*/
- (void)addCondition:(id<US2ConditionProtocol>)condition;

/**
 Remove all conditions subclassing conditionClass from validation queue.
 
 @param conditionClass Remove all conditions which are kind of _conditionClass_
*/
- (void)removeConditionOfClass:(Class<US2ConditionProtocol>)conditionClass;

/**
 Add condition subclass of US2Condition for validation queue.
 
 @param string String to check for all added conditons
 @return Returns *nil* if no conditon was violated or a condition collection of type US2ConditionCollection for each violated conditon
*/
- (US2ConditionCollection *)violatedConditionsUsingString:(NSString *)string;

@end


#pragma mark - Validator interface

@class US2ConditionCollection;

/**
 US2Validator is a holder for conditions of type US2Condition in a US2ConditionCollection.
 The validator checks for violation of each condition. Returned will be a collection of 
 violated conditions or nil if the string to check is correct or no condition was added.
 
 *Example:*
 
    US2Validator *validator = [[US2Validator alloc] init];
    
    US2ConditionAlphabetic *condition = [[US2ConditionAlphabetic alloc] init];
    [validator addCondition:condition];
    [condition release];
    
    US2ConditionCollection *conditionCollection1 = [validator violatedConditionsUsingString:@"HelloWorld"];
    US2ConditionCollection *conditionCollection2 = [validator violatedConditionsUsingString:@"Hello World 123"];
    
    BOOL isValid = conditionCollection1 == nil;   // isValid == YES
    isValid = conditionCollection2 == nil;        // isValid == NO
    
    // What went wrong?
    NSLog(@"conditionCollection2: %@", conditionCollection2);
 
*/
@interface US2Validator : NSObject <US2ValidatorProtocol>

/**
 Static shorthand for creating a validator.
 */
+ (instancetype)validator;

/**
 Initialize with a condition or variable-argument number of conditions.
 */
- (instancetype)initWithCondition:(id<US2ConditionProtocol>)condition;

/**
 Initialize with an array of conditions.
 */
- (instancetype)initWithConditions:(NSArray *)conditions;

/**
 Add condition conform to US2ConditionProtocol
 
 @param condition Condition conform to US2ConditionProtocol
*/
- (void)addCondition:(id<US2ConditionProtocol>)condition;

/**
 @methodName addCondition:withPriority:
 @abstract   Add a condition with a priority.
 @discussion Add a condition with a priority, the lower the priority number the lower the priority. Use US2ConditionPriority for convenience.
 
 @param condition The condition
 @param priority The priority
 */
- (void)addCondition:(id<US2ConditionProtocol>)condition withPriority:(NSUInteger)priority;

/**
 Remove all conditions subclassing conditionClass from validation queue.
 
 @param conditionClass Remove all conditions which are kind of _conditionClass_
*/
- (void)removeConditionOfClass:(Class<US2ConditionProtocol>)conditionClass;

/**
 Add condition subclass of US2Condition for validation queue.
 
 @param string String to check for all added conditons
 @return Returns *nil* if no conditon was violated or a condition collection of type US2ConditionCollection for each violated conditon
*/
- (US2ConditionCollection *)violatedConditionsUsingString:(NSString *)string;

@end
