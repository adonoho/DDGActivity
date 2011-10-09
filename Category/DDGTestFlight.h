//
//  DDGTestFlight.h
//  DDGActivity
//
//  Created by Andrew Donoho on 2011/10/08.
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

#import <Foundation/Foundation.h>

extern NSString *const kTestFlightTeamToken;

extern NSString *const kLastCheckpointKey;

@protocol DDGTestFlight <NSObject>

@required

@property (nonatomic, retain) NSString *lastCheckpoint;

/**
 Add custom environment information
 If you want to track a user name from your application you can add it here
 */
- (void) addCustomEnvironmentInformation: (NSString *) information forKey: (NSString*) key;

/**
 Starts a TestFlight session
 */
- (void) takeOff: (NSString *) teamToken;

/**
 Sets custom options
 Option                      Accepted Values                 Description
 reinstallCrashHandlers      [NSNumber numberWithBool:YES]   Reinstalls crash handlers, to be used if a third party 
 library installs crash handlers overtop of the TestFlight Crash Handlers
 */
- (void) setOptions: (NSDictionary *) options;

/**
 Track when a user has passed a checkpoint after the flight has taken off. Eg. passed level 1, posted high score
 */
- (void) passCheckpoint: (NSString *) checkpointName;

/**
 Opens a feeback window that is not attached to a checkpoint
 */
- (void) openFeedbackView;

@end
