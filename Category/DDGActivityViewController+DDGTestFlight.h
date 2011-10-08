//
//  DDGActivityViewController+DDGTestFlight.h
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/10/08.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

#import "DDGTestFlight.h"
#import "DDGActivityViewController.h"

extern NSString *const kLastCheckpointKey;

@interface DDGActivityViewController (DDGTestFlight) <DDGTestFlight>

@property (nonatomic, retain) NSString *lastCheckpoint;

- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*) key;
- (void) takeOff: (NSString *) teamToken;
- (void) setOptions: (NSDictionary *) options;
- (void) passCheckpoint: (NSString *) checkpointName;
- (void) openFeedbackView;

@end

