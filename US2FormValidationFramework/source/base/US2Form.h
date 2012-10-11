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
#import "US2Validator.h"
#import "US2Validatable.h"

/**
    A form entry for US2Form.
 */
@interface US2FormEntry : NSObject

@property (nonatomic, retain) id<US2Validatable> validatable;
@property (nonatomic, retain) id<US2ValidatorProtocol> validator;

@end

/**
    A form to assist in validating a validatable objects current state.
 */
@interface US2Form : NSObject {
@private
    NSMutableArray *_entries;
}

/**
    Add a validatable to be validated with the given validator. 
 */
- (void) addValidatable: (id<US2Validatable>) validatable validator: (id<US2ValidatorProtocol>) validator;

/**
    Check conditions for all validatables.
 */
- (US2ConditionCollection *) checkConditions;

@end
