//
//  US2ConditionEmpty.m
//  US2FormValidator
//
//  Created by Matthew Purland <m.purland@gmail.com>
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

#import "US2ConditionEmpty.h"

@implementation US2ConditionEmpty

- (id) init
{
    self = [super init];
    if (self)
    {
        self.allowsNull = YES;
    }
    
    return self;
}

- (BOOL)check:(NSString *)string
{
    if (nil == string && self.allowsNull)
        return NO;
    
    if (![string isEqualToString: @""]) {
        return YES;
    }
    
    return NO;
}


#pragma mark - Allow violation

- (BOOL)shouldAllowViolation
{
    return YES;
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    NSString *key = @"US2KeyConditionViolationEmpty";
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource: @"Localization" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    if (bundle)
    {
        return [bundle localizedStringForKey:key value:key table:nil];
    }
    
    return nil;
}

@end
