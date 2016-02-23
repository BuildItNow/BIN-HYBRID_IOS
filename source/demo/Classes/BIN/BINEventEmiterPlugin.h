//
//  BINEventEmiterPlugin.h
//  demo
//
//  Created by Checker on 16/2/15.
//
//

#import <Foundation/Foundation.h>
#import "CDVPlugin.h"

@interface BINEventEmiterPlugin : CDVPlugin

- (void)fire:(CDVInvokedUrlCommand*)command;

@end
