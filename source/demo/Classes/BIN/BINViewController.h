//
//  BINViewController.h
//  demo
//
//  Created by Checker on 16/2/17.
//
//

#import "DotCViewController.h"
#import "BINScriptManager.h"

@interface BINViewController : DotCViewController


- (CGRect) statusBarFrame;

- (void) push:(NSString*)name data:(NSArray*)data;
- (void) pop:(NSArray*)data;
- (void) popTo:(NSString*)name data:(NSArray*)data;
- (void) pop:(int)count data:(NSArray*)data;

+ (void) push:(NSString*)name data:(NSArray*)data;
+ (void) pop:(NSArray*)data;
+ (void) popTo:(NSString*)name data:(NSArray*)data;
+ (void) pop:(int)count data:(NSArray*)data;

@end
