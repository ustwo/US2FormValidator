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
- (void)addCondition:(id <US2ConditionProtocol>)condition;

/**
 Remove all conditions subclassing conditionClass from validation queue.
 
 @param conditionClass Remove all conditions which are kind of _conditionClass_
*/
- (void)removeConditionOfClass:(Class <US2ConditionProtocol>)conditionClass;

/**
 Add condition subclass of US2Condition for validation queue.
 
 @param string String to check for all added conditons
 @return Returns *nil* if no conditon was violated or a condition collection of type US2ConditionCollection for each violated conditon
*/
- (US2ConditionCollection *)checkConditions:(NSString *)string;

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
    
    US2ConditionCollection *conditionCollection1 = [validator checkConditions:@"HelloWorld"];
    US2ConditionCollection *conditionCollection2 = [validator checkConditions:@"Hello World 123"];
    
    BOOL isValid = conditionCollection1 == nil;                                                  // isValid == YES
    isValid = conditionCollection2 == nil;                                                       // isValid == NO
    
    // What went wrong?
    NSLog(@"conditionCollection2: %@", conditionCollection2);
 
*/
@interface US2Validator : NSObject <US2ValidatorProtocol>
{
@protected
    US2ConditionCollection *_conditionCollection;
}

/**
 Set localized violation string for condition at a given index.  This allows overriding a conditions default localized violation string.
 */
- (void) setLocalizedViolationString: (NSString *) localizedViolationString forConditionAtIndex: (NSUInteger) index;

/**
 Add condition conform to US2ConditionProtocol
 
 @param condition Condition conform to US2ConditionProtocol
*/
- (void)addCondition:(id <US2ConditionProtocol>)condition;

/**
 Remove all conditions subclassing conditionClass from validation queue.
 
 @param conditionClass Remove all conditions which are kind of _conditionClass_
*/
- (void)removeConditionOfClass:(Class <US2ConditionProtocol>)conditionClass;

/**
 Add condition subclass of US2Condition for validation queue.
 
 @param string String to check for all added conditons
 @return Returns *nil* if no conditon was violated or a condition collection of type US2ConditionCollection for each violated conditon
*/
- (US2ConditionCollection *)checkConditions:(NSString *)string;


@end

/**
 A US2Validator with a single condition.
 */
@interface US2ValidatorSingleCondition : US2Validator {
    id<US2ConditionProtocol> _condition;
}

@property (retain, nonatomic) id<US2ConditionProtocol> condition;
@property (copy, nonatomic) NSString *localizedViolationString;

/**
 Initialize single validator with a condition.
 */
- (id) initWithCondition: (id<US2ConditionProtocol>) condition;

@end
