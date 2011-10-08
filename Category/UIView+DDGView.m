//
//  UIView+DDG.m
//  DDGActivityView
//
//  Created by Andrew Donoho on 2011/09/25.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

/*
 
 The below license is the new BSD license with the OSI recommended 
 personalizations.
 <http://www.opensource.org/licenses/bsd-license.php>
 
 Copyright (C) 2010-2011 Donoho Design Group, LLC. All Rights Reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Andrew W. Donoho nor Donoho Design Group, L.L.C.
 may be used to endorse or promote products derived from this software
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY DONOHO DESIGN GROUP, L.L.C. "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import <objc/runtime.h>

#import "UIView+DDG.h"

// Associated Reference keys.
static const char *kActivityIndicatorARKey =  "ddgActivityIndicatorARKey";
NSString *const    kActivityIndicatorKey   =    @"activityIndicator";

@implementation UIView (DDG)

@dynamic activityIndicator;

- (UIActivityIndicatorView *) activityIndicator {
    
    return objc_getAssociatedObject(self, kActivityIndicatorARKey);
    
} // -activityIndicator


- (void) setActivityIndicator: (UIActivityIndicatorView *) activityIndicator {
    
    objc_setAssociatedObject(self, 
                             kActivityIndicatorARKey, activityIndicator, 
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
} // -setActivityIndicator:


- (void) centerIndicator {
    
    self.activityIndicator.center = [self convertPoint: self.center 
                                              fromView: self.superview];
    
} // -centerIndicator

@end