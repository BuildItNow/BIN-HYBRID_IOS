//
//  BINScriptManager.h
//  demo
//
//  Created by Checker on 16/2/14.
//
//

#import <Foundation/Foundation.h>

#import "CDVScriptManager.h"
#import "DotCDelegate.h"
#import "BINNativeObjectProtocol.h"
#import "BINScriptObject.h"

extern NSString* SCRIPT_EVENT_READY;
extern NSString* SCRIPT_EVENT_ARGUMENT;

typedef NSString* NativeObjectKey;

@interface BINNativeObjectReference : NSObject

@property (assign, nonatomic) id<BINNativeObjectProtocol> nativeObject;
@property (copy, nonatomic)   NativeObjectKey               key;
@property (retain, nonatomic) BINScriptObject*            scriptObject;

@end

@interface BINScriptManager : CDVScriptManager

- (void) on:(NSString*)event object:(id)object selector:(SEL)selector;
- (void) once:(NSString*)event object:(id)object selector:(SEL)selector;
- (void) remove:(NSString*)event object:(id)object selector:(SEL)selector;
- (void) fire:(NSString*)event arguments:(DotCDelegatorArguments*)arguments;

- (BINNativeObjectReference*) registeNativeObject:(id)object;
- (BINNativeObjectReference*) registeNativeObject:(id)object as:(NSString*)name;
- (BINNativeObjectReference*) getNativeObjectRef:(NativeObjectKey)key;
- (id<BINNativeObjectProtocol>) getNativeObject:(NativeObjectKey)key;

- (void) removeNativeObjectByKey:(NativeObjectKey)key;
- (void) removeNativeObject:(id)object;

- (NSArray*) argsToScript:(NSArray*)args;
- (NSArray*) argsFmScript:(NSArray*)args;
- (id) argToScript:(id)arg;
- (id) argFmScript:(id)arg;

+ (instancetype) instance;
+ (DotCDelegatorManager*) delegatorManager;

@end

#define BIN_GLOBAL_SCRIPT_MANAGER [BINScriptManager instance]

#define BIN_DELEGATOR_MANAGER [BINScriptManager delegatorManager]

extern NSString* BIN_DELEGATOR_ARGUMENT_ERROR ;
extern NSString* BIN_DELEGATOR_ARGUMENT_DATA ;

