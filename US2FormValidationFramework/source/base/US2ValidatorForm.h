//
//  US2Form.h
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

@protocol US2Validatable;
@class US2ConditionCollection;


/**
 A form to assist in validating a validatable objects current state.
 */
@interface US2ValidatorForm : NSObject

/**
 Determines the current validation state of the form.
 */
@property (nonatomic, readonly, getter = isValid) BOOL valid;

/**
 Calls the block as soon as the state of the form changed. Initially the state change from valid to invalid is taken into account.
 */
@property (nonatomic, copy) void(^didChangeValidState)(BOOL isValid);

/**
 Initialize the form by adding initial validatables.
 */
- (instancetype)initWithValidatables:(NSSet *)validatables;

/**
 Add a validatable to be validated with the given validator.
 */
- (void)addValidatable:(id<US2Validatable>)validatable;

/**
 Returns a validatable at a given index.
 */
- (id<US2Validatable>)validatableAtIndex:(NSInteger)index;

/**
 Returns the count of contained validatables.
 */
- (NSUInteger)count;

/**
 Returns all violated conditions for all validatables.
 */
- (US2ConditionCollection *)violatedConditions;

@end
