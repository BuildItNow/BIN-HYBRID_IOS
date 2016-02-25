//
//  BINScriptManager.m
//  demo
//
//  Created by Checker on 16/2/14.
//
//

#import "BINScriptManager.h"
#import "DotCEventEmitter.h"

NSString* SCRIPT_EVENT_ARGUMENT = @"SCRIPT_EVENT_ARGUMENT";
NSString* SCRIPT_EVENT_READY = @"SCRIPT_EVENT_READY";

NSString* BIN_DELEGATOR_ARGUMENT_ERROR = @"BIN_DELEGATOR_ARGUMENT_ERROR";
NSString* BIN_DELEGATOR_ARGUMENT_DATA = @"BIN_DELEGATOR_ARGUMENT_DATA";

static NSString* objectToString(id subject)
{
    return [NSString stringWithFormat:@"%p#%s", (void*)subject, object_getClassName(subject)];
}

@implementation BINNativeObjectReference

@synthesize nativeObject = _nativeObject;
@synthesize key = _key;
@synthesize scriptObject = _scriptObject;

- (void) dealloc
{
    [_scriptObject release];
    _scriptObject = nil;
    [_key release];
    _key = nil;
    
    _nativeObject = nil;
    
    [super dealloc];
}

@end

@implementation BINScriptManager
{
    DotCEventEmitter*       _ee;
    NSMutableDictionary*    _key2nativeObjects;
    NSMutableDictionary*    _obj2nativeObjects;
    int                     _nxtKey;
}

- (instancetype) init
{
    if(!(self = [super init]))
    {
        return nil;
    }
    
    _ee = STRONG_OBJECT(DotCEventEmitter, init);
    
    _key2nativeObjects = STRONG_OBJECT(NSMutableDictionary, init);
    _obj2nativeObjects = STRONG_OBJECT(NSMutableDictionary, init);
    
    ++_nxtKey;
    
    return self;
}

- (void) on:(NSString*)event object:(id)object selector:(SEL)selector
{
    [_ee on:event object:object selector:selector];
}

- (void) once:(NSString*)event object:(id)object selector:(SEL)selector
{
    [_ee once:event object:object selector:selector];
}

- (void) remove:(NSString*)event object:(id)object selector:(SEL)selector
{
    [_ee remove:event object:object selector:selector];
}

- (void) fire:(NSString*)event arguments:(DotCDelegatorArguments*)arguments
{
    [_ee fire:event arguments:arguments];
}

- (void) dealloc
{
    [_ee release];
    _ee = nil;
    
    [super dealloc];
}

- (BINNativeObjectReference*) registeNativeObject:(id<BINNativeObjectProtocol>)object
{
    NSString* objStr = objectToString(object);
    BINNativeObjectReference* ref = [_obj2nativeObjects objectForKey:objStr];
    if(ref)
    {
        return ref;
    }
    
    ref = WEAK_OBJECT(BINNativeObjectReference, init);
    ref.key = [NSString stringWithFormat:@"%d", _nxtKey];
    ref.nativeObject = object;
    
    ++_nxtKey;
    
    [_obj2nativeObjects setObject:ref forKey:objStr];
    [_key2nativeObjects setObject:ref forKey:ref.key];
    
    [self evalJs:[NSString stringWithFormat:@"bin.nativeManager.addNativeObject('%@')", ref.key]];
    
    return ref;
}

- (BINNativeObjectReference*) registeNativeObject:(id)object as:(NSString*)name
{
    BINNativeObjectReference* ref = [self registeNativeObject:object];
    
    [self evalJs:[NSString stringWithFormat:@"%@ = bin.nativeManager.getNativeObject('%@')", name, ref.key] ];
    
    return ref;
}

- (BINNativeObjectReference*) getNativeObjectRef:(NativeObjectKey)key
{
    BINNativeObjectReference* ref = [_key2nativeObjects objectForKey:key];
    
    return ref;
}

- (id<BINNativeObjectProtocol>) getNativeObject:(NativeObjectKey)key
{
    BINNativeObjectReference* ref = [_key2nativeObjects objectForKey:key];
    
    return ref ? ref.nativeObject : nil;
}



- (void) removeNativeObjectByKey:(NativeObjectKey)key
{
    BINNativeObjectReference* ref = (BINNativeObjectReference*)[_key2nativeObjects objectForKey:key];
    if(!ref)
    {
        return ;
    }
    
    [self evalJs:[NSString stringWithFormat:@"bin.nativeManager.remNativeObject('%@')", ref.key]];
    
    [_key2nativeObjects removeObjectForKey:key];
    [_obj2nativeObjects removeObjectForKey:objectToString(ref.nativeObject)];
}

- (void) removeNativeObject:(id)object
{
    NSString* objStr = objectToString(object);
    BINNativeObjectReference* ref = (BINNativeObjectReference*)[_obj2nativeObjects objectForKey:objStr];
    if(!ref)
    {
        return ;
    }
    
    [self evalJs:[NSString stringWithFormat:@"bin.nativeManager.remNativeObject('%@')", ref.key]];
    
    [_key2nativeObjects removeObjectForKey:ref.key];
    [_obj2nativeObjects removeObjectForKey:objStr];
}

- (NSArray*) argsToScript:(NSArray*)args
{
    if(args == nil || args == [NSNull null])
    {
        return nil;
    }
    
    NSMutableArray* ret = [NSMutableArray arrayWithCapacity:args.count];
    for(int i=0,i_sz=args.count; i<i_sz; ++i)
    {
        [ret addObject:[self argToScript:args[i]]];
    }
    
    return ret;
}

- (NSArray*) argsFmScript:(NSArray*)args
{
    if(args == nil || args == [NSNull null])
    {
        return nil;
    }
    
    NSMutableArray* ret = [NSMutableArray arrayWithCapacity:args.count];
    for(int i=0,i_sz=args.count; i<i_sz; ++i)
    {
        [ret addObject:[self argFmScript:args[i]]];
    }
    
    return ret;
}

- (id) argToScript:(id)arg
{
    if(arg == nil || arg == [NSNull null])
    {
        return nil;
    }
    
    if([arg isKindOfClass:[BINScriptObject class]])
    {
        return [NSString stringWithFormat:@"bin#so=%@", ((BINScriptObject*)arg).key];
    }
    
    if([arg isKindOfClass:[BINNativeObjectReference class]])
    {
        return [NSString stringWithFormat:@"bin#no=%@", ((BINNativeObjectReference*)arg).key];
    }
    
    return arg;
}

- (id) argFmScript:(id)arg
{
    if(arg == nil|| arg == [NSNull null])
    {
        return nil;
    }
    
    if(![arg isKindOfClass:[NSString class]])
    {
        return arg;
    }
    
    NSString* strArg = (NSString*)arg;
    if(![strArg hasPrefix:@"bin#"])
    {
        return arg;
    }
    
    NSRange rg = [strArg rangeOfString:@"="];
    NSRange kRg = {4, 0};
    kRg.length  = rg.location-kRg.location;
    NSString* key = [strArg substringWithRange:kRg];
    NSString* val = [strArg substringFromIndex:rg.location+1];
    
    if([key isEqual:@"no"])
    {
        return [self getNativeObject:val];
    }
    
    if([key isEqual:@"so"])
    {
        return WEAK_OBJECT(BINScriptObject, init:self key:val);
    }

    // Unkown
    return nil;
}

+ (instancetype) instance
{
    static BINScriptManager* s_instance = nil;
    if(!s_instance)
    {
        s_instance = STRONG_OBJECT(BINScriptManager, init);
    }
    
    return s_instance;
}

+ (DotCDelegatorManager*) delegatorManager
{
    static DotCDelegatorManager*    s_instance = nil;
    if(!s_instance)
    {
        s_instance = STRONG_OBJECT(DotCDelegatorManager, init);
    }
    
    return s_instance;
}

@end
