//
//  US2ConditionShorthandURL.h
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

/**
 The US2ConditionShorthandURL checks a string for a valid URL like:
 http://www.example.com
 https://www.example.com
 www.example.com
 example.com
 subdomain.example.com
 
 No scheme (protocol) is needed for a valid URL. If you want a check for more strict URLs see US2ConditionURL.
 
 *Example:*
 
 NSString *string = @"example.com";
 
 US2ConditionURL *shorthandUrlCondition = [[[US2ConditionShorthandURL alloc] init] autorelease];
 
 US2Validator *shorthandUrlValidator = [[US2Validator alloc] init];
 [shorthandUrlValidator addCondition:shorthandUrlCondition];
 
 BOOL isValid = [shorthandUrlValidator checkConditions:string] == nil;                     // isValid == YES
 */

@interface US2ConditionShorthandURL : US2Condition

@end