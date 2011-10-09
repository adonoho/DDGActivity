//
//  ModalViewController.m
//  DDGActivity
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

#import "ModalViewController.h"

#import "DDGTestFlight.h"
#import "DDGView.h"

@implementation ModalViewController

- (IBAction) dismissAction: (UIButton *) sender {
    
    if ([self.parentViewController conformsToProtocol: @protocol(DDGTestFlight)]) {
        
        // Note: the modal view only needs to check if it implements the @protocol.
        
        [(id<DDGTestFlight>)self.parentViewController 
         passCheckpoint: [NSString stringWithFormat: @"%s", __PRETTY_FUNCTION__]];
    }
    [self dismissModalViewControllerAnimated: YES];
    
} // -dismissAction:


#pragma mark - View lifecycle


- (void) viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Check whether the @protocol is implemented.
    if ([self.view conformsToProtocol: @protocol(DDGView)]) {
        
        UIView<DDGView> *view = (UIView<DDGView> *)self.view;
        
        view.activityIndicator = [[[UIActivityIndicatorView alloc] 
                                   initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray] 
                                  autorelease];
        [view addSubview: view.activityIndicator];
        [view centerIndicator];
        
        [view.activityIndicator startAnimating];
    }
    
} // -viewDidLoad

@end
