//
//  US2ValidatorEmail.h
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


#pragma mark - Validator interface

/**
 The email validator checks for email in a string.
 
 *Example:*
 
    US2ValidatorEmail *emailValidator = [US2ValidatorEmail alloc] init];
    
    US2ConditionCollection *collection1 = [emailValidator checkConditions:@"example@ustwo.co.uk"];  // collection1 == nil, thus YES
    US2ConditionCollection *collection2 = [emailValidator checkConditions:@"example@ustwo."];       // collection2.length > 0, thus NO
    US2ConditionCollection *collection3 = [emailValidator checkConditions:@"example"];              // collection3.length > 0, thus NO
    
    BOOL isValid = [emailValidator checkConditions:@"example@ustwo.co.uk"] == nil;                  // isValid == YES
*/
@interface US2ValidatorEmail : US2ValidatorSingleCondition
{
}

@end
