//
//  DDGActivityViewController+TestFlight.m
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/10/08.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

#import "DDGActivityViewController+TestFlight.h"

#ifdef DEBUG

#import "TestFlight.h"

@implementation DDGActivityViewController (TestFlight)

- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*)key {
    
    [TestFlight addCustomEnvironmentInformation: information forKey: key];
    
} // -addCustomEnvironmentInformation:forKey:


- (void) takeOff: (NSString *) teamToken {
    
    [TestFlight takeOff: teamToken];
    
} // -takeOff:


- (void) setOptions: (NSDictionary*) options {
    
    [TestFlight setOptions: options];
    
} // -setOptions:


- (void) passCheckpoint: (NSString *) checkpointName {
    
    [TestFlight passCheckpoint: checkpointName];
    
} // -passCheckpoint:


- (void) openFeedbackView {
    
    [TestFlight openFeedbackView];
    
} // -openFeedbackView

#else

@implementation DDGActivityViewController (TestFlight)

- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*)key {
} // -addCustomEnvironmentInformation:forKey:


- (void) takeOff: (NSString *) teamToken {
} // -takeOff:


- (void) setOptions: (NSDictionary*) options {
} // -setOptions:


- (void) passCheckpoint: (NSString *) checkpointName {
} // -passCheckpoint:


- (void) openFeedbackView {
} // -openFeedbackView
#endif

@end
