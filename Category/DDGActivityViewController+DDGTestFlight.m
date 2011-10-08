//
//  DDGActivityViewController+DDGTestFlight.m
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/10/08.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

#import <objc/runtime.h>

#import "DDGActivityViewController+DDGTestFlight.h"

// Associated Reference keys.
static const char *kLastCheckpointARKey =  "ddgLastCheckpointARKey";
NSString *const    kLastCheckpointKey   =    @"lastCheckpoint";

NSString *const kTestFlightTeamToken = @"8acf99279583d14642f6d297ae838cea_MzM1MDYyMDExLTEwLTA4IDE2OjE0OjI1LjU1MTA2Ng";

#ifdef DEBUG

#import "TestFlight.h"

@implementation DDGActivityViewController (DDGTestFlight)

@dynamic lastCheckpoint;

- (NSString *) lastCheckpoint {
    
    return objc_getAssociatedObject(self, kLastCheckpointARKey);
    
} // -lastCheckpoint


- (void) setLastCheckpoint: (NSString *) lastCheckpoint {
    
    objc_setAssociatedObject(self, 
                             kLastCheckpointARKey, lastCheckpoint, 
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
} // -setLastCheckpoint:


- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*) key {
    
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
    
    self.lastCheckpoint = checkpointName;
    
} // -passCheckpoint:


- (void) openFeedbackView {
    
    [TestFlight openFeedbackView];
    
} // -openFeedbackView

#else

@implementation DDGActivityViewController (DDGTestFlight)

@dynamic lastCheckpoint;

- (NSString *) lastCheckpoint {
    
    return nil;
    
} // -lastCheckpoint


- (void) setLastCheckpoint: (NSString *) lastCheckpoint {
} // -setLastCheckpoint:


- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*) key {
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
