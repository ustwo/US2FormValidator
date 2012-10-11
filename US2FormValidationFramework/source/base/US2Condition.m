//
//  US2Condition.m
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

#import "US2Condition.h"


@implementation US2Condition

@synthesize shouldAllowViolation = _shouldAllowViolation;
@synthesize localizedViolationString = _localizedViolationString;

#pragma mark - Init

+ (US2Condition *) condition {
    return [[[self class] alloc] init];
}

- (id) initWithLocalizedViolationString: (NSString *) localizedViolationString {
    if (self = [super init]) {
        self.localizedViolationString = localizedViolationString;
    }
    
    return self;
}

- (id) withLocalizedViolationString: (NSString *) localizedViolationString {
    self.localizedViolationString = localizedViolationString;
    return self;
}

#pragma mark - Check

/**
 Check the custom condition.
 *
 @return Return whether condition check failed or not
*/
- (BOOL)check:(NSString *)string
{
    return YES;
}


#pragma mark - Localization

/**
 Create a localized violation string.
 */
- (NSString *) createLocalizedViolationString {
    return nil;
}

/**
 Returns a localized violation string.
 *
 @return Localized violation string
*/
- (NSString *)localizedViolationString
{
    if (!_localizedViolationString) {
        return [self createLocalizedViolationString];
    }
    
    return _localizedViolationString;
}


#pragma mark - Description

/**
 Returns the description
 *
 @return Description string
*/
- (NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    [description appendString:@"<"];
    [description appendString:[super description]];
    [description appendString:[NSString stringWithFormat:@"\n <localizedViolationString: %@>", [self localizedViolationString]]];
    [description appendString:[NSString stringWithFormat:@"\n <shouldAllowViolation: %@>", _shouldAllowViolation == 0 ? @"YES" : @"NO"]];
    [description appendString:@">"];
    
    return description;
}


@end
