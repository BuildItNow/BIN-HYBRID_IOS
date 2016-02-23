//
//  BINNativeObjectProxy.h
//  demo
//
//  Created by Checker on 16/2/19.
//
//

#import <Foundation/Foundation.h>

#import "BINScriptObject.h"

@protocol BINNativeObjectProtocol

@required
- (void) exec:(NSString*)name args:(NSArray*)args proxy:(BINScriptObject*)proxy cb:(DotCDelegatorID)cb;

@end
