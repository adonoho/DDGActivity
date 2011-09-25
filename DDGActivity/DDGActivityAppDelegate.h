//
//  DDGActivityAppDelegate.h
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/09/25.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDGActivityViewController;

@interface DDGActivityAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DDGActivityViewController *viewController;

@end
