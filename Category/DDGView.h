//
//  DDGView.h
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/10/08.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kActivityIndicatorKey;

@protocol DDGView <NSObject>

@required

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (void) centerIndicator;

@end
