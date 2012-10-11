//
//  US2Condition.h
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


#pragma mark - Condition protocol

/**
 A _condition_ must conform to US2Condition protocol methods.
*/
@protocol US2ConditionProtocol <NSObject>

@required

/**
 Check the custom condition.
 
 @param string String to check
 @return Return whether condition check failed or not
*/
- (BOOL)check:(NSString *)string;

/**
 Returns a localized string which describes the kind of violation.
 
 @return Localized violation string
*/
- (NSString *)localizedViolationString;


@end


#pragma mark - Condition interface

/**
 A _condition_ is the smallest sub element of the validation framework.
 It tells how a string must be structured or wat is has to contain or not.
 Validators (see US2Validator) are storing those conditions and checking
 for violations of every condition.
 Conditions are recommended working with regular expressions but can also contain
 their custom checking code for detecting violations in the string to check.
 
 By returning a localized string in method localizedViolationString the
 user can be informed in a convenient way what went wrong.
*/
@interface US2Condition : NSObject <US2ConditionProtocol>
{
@private
    NSString *_localizedViolationString;
    BOOL _shouldAllowViolation;
}

@property (copy, nonatomic) NSString *localizedViolationString;

/**
 If set to *NO* the user is not able to enter characters which would break the condition.
*/
@property (nonatomic, assign) BOOL shouldAllowViolation;

/**
 Initialize condition with a custom localized violation string.
 */
- (id) initWithLocalizedViolationString: (NSString *) localizedViolationString;

@end
