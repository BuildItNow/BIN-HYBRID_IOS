//
//  AppDelegate+BINSetup.h
//  demo
//
//  Created by Checker on 16/2/14.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AppDelegate (BINSetup)

- (void) BINSetup;
- (void) evalJs:(NSString*) js;
- (void) evalJsS:(NSString*) js;
@end
