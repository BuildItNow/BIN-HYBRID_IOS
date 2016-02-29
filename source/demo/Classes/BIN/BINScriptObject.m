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
    NSString* js = [NSString stringWithFormat:@"bin.nativeManager.soGet('%@', '%@', %@)", _key, name, [self cbStr:cb]];
    
    [_scriptManager evalJsS:js];
}

- (void) set:(NSString*)name data:(id)data cb:(DotCDelegatorID)cb
{
    [_wrapper addObject:(data ? [_scriptManager argToScript:data] : [NSNull null])];
    NSString* js = [NSString stringWithFormat:@"bin.nativeManager.soSet('%@', '%@', '%@', %@)", _key, name, [_wrapper JSONString], [self cbStr:cb]];
    [_wrapper removeAllObjects];
    
    [_scriptManager evalJsS:js];
}

- (void) getAt:(int)idx cb:(DotCDelegatorID)cb
{
    [self get:[NSString stringWithFormat:@"%d", idx] cb:cb];
}

- (void) setAt:(int)idx data:(id)data cb:(DotCDelegatorID)cb
{
    [self set:[NSString stringWithFormat:@"%d", idx] data:data cb:cb];
}

- (void) call:(NSString*)name args:(NSArray*)args cb:(DotCDelegatorID)cb
{
    NSString* js = [NSString stringWithFormat:@"bin.nativeManager.soCall('%@', '%@', %@, %@)", _key, name, [self argsStr:args], [self cbStr:cb]];
    
    [_scriptManager evalJsS:js];
}

- (NSString*) cbStr:(DotCDelegatorID)cb
{
    return cb ? [NSString stringWithFormat:@"'%@'", cb] : @"null";
}

- (NSString*) argsStr:(NSArray*)args;
{
    if(!args)
    {
        return @"null";
    }
    
    NSArray*  soArgs = [_scriptManager argsToScript:args];
    return [NSString stringWithFormat:@"'%@'", [soArgs JSONString]];
}

@end
