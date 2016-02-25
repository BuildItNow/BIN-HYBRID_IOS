//
//  BINPageViewController.h
//  demo
//
//  Created by Checker on 16/2/23.
//
//

#import "BINViewController.h"

@interface BINPageViewController : BINViewController<BINNativeObjectProtocol>

- (instancetype) init:(NSString*)name scriptObject:(BINScriptObject*)scriptObject pushData:(NSArray*)pushData queryParams:(DotCDictionaryWrapper*)queryParams;

- (BINNativeObjectReference*) nativeObjectReference;
- (BINScriptObject*) scriptObject;
- (NSString*) name;

@end
