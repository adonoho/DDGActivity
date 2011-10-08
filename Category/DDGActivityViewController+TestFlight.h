//
//  DDGActivityViewController+TestFlight.h
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/10/08.
//  Copyright 2011 Donoho Design Group, L.L.C. All rights reserved.
//

#import "DDGActivityViewController.h"

@interface DDGActivityViewController (TestFlight)

- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*) key;
- (void) takeOff: (NSString *) teamToken;
- (void) setOptions: (NSDictionary *) options;
- (void) passCheckpoint: (NSString *) checkpointName;
- (void) openFeedbackView;

@end

