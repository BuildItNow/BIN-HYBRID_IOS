//
//  BINScriptObject.h
//  demo
//
//  Created by Checker on 16/2/19.
//
//

#import <Foundation/Foundation.h>
@class BINScriptManager;

typedef NSString* ScriptObjectKey;

@interface BINScriptObject : NSObject

- (ScriptObjectKey) key;

- (instancetype) init:(BINScriptManager*) scriptManager key:(ScriptObjectKey)key;

- (void) get:(NSString*)name cb:(DotCDelegatorID)cb;
- (void) set:(NSString*)name data:(id)data;
- (void) getAt:(int)idx cb:(DotCDelegatorID)cb;
- (void) setAt:(int)idx data:(id)data;
- (void) call:(NSString*)name args:(NSArray*)args cb:(DotCDelegatorID)cb;

@end
