//
//  BINScriptObject.m
//  demo
//
//  Created by Checker on 16/2/19.
//
//

#import "BINScriptObject.h"
#import "BINScriptManager.h"
#import "CDVJSON.h"

@interface BINScriptObject()
{
    BINScriptManager*       _scriptManager;
    ScriptObjectKey         _key;
    
    NSMutableArray*         _wrapper;
}

@end

@implementation BINScriptObject

- (instancetype) init:(BINScriptManager*) scriptManager key:(ScriptObjectKey)key
{
    if(!(self = [super init]))
    {
        return self;
    }
    
    _scriptManager = scriptManager;
    _key           = [key copy];
    _wrapper       = STRONG_OBJECT(NSMutableArray, initWithCapacity:10);
    
    [_scriptManager evalJs:[NSString stringWithFormat:@"bin.nativeManager.refScriptObject('%@')", _key]];
    
    return self;
}

- (ScriptObjectKey) key
{
    return _key;
}

- (void) dealloc
{
    [_scriptManager evalJs:[NSString stringWithFormat:@"bin.nativeManager.derefScriptObject('%@')", _key]];
    
    [_key release];
    _key = nil;
    
    _scriptManager = nil;
    
    [super dealloc];
}

- (void) get:(NSString*)name cb:(DotCDelegatorID)cb
{
    NSString* js = [NSString stringWithFormat:@"bin.nativeManager.soGet('%@', '%@', '%@')", _key, name, cb];
    
    [_scriptManager evalJsS:js];
}

- (void) set:(NSString*)name data:(id)data
{
    [_wrapper addObject:[_scriptManager argToScript:data]];
    NSString* js = [NSString stringWithFormat:@"bin.nativeManager.soSet('%@', '%@', '%@')", _key, name, [_wrapper JSONString]];
    [_wrapper removeAllObjects];
    
    [_scriptManager evalJsS:js];
}

- (void) getAt:(int)idx cb:(DotCDelegatorID)cb
{
    [self get:[NSString stringWithFormat:@"%d", idx] cb:cb];
}

- (void) setAt:(int)idx data:(id)data
{
    [self set:[NSString stringWithFormat:@"%d", idx] data:data];
}

- (void) call:(NSString*)name args:(NSArray*)args cb:(DotCDelegatorID)cb
{
    NSArray*  soArgs = [_scriptManager argsToScript:args];
    NSString* json   = [soArgs JSONString];
    
    NSString* js = [NSString stringWithFormat:@"bin.nativeManager.soCall('%@', '%@', '%@', '%@')", _key, name, json, cb];
    
    [_scriptManager evalJsS:js];
}

@end
