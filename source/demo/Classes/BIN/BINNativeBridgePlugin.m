//
//  BINNativeBridgePlugin.m
//  demo
//
//  Created by Checker on 16/2/19.
//
//

#import "BINNativeBridgePlugin.h"
#import "BINScriptManager.h"
#import "BINPageViewController.h"

@implementation BINNativeBridgePlugin

- (BINScriptManager*) binScriptManager
{
    return (BINScriptManager*)self.scriptManager;
}

- (void)exec:(CDVInvokedUrlCommand*)command;
{
    if(command.arguments.count < 2)
    {
        return ;
    }
    
    NSString* key  = command.arguments[0];
    NSString* name = command.arguments[1];
    NSArray*  args = nil;
    if(command.arguments.count > 2)
    {
        args = command.arguments[2];
    }
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        BINNativeObjectReference* ref = [self.binScriptManager getNativeObjectRef:key];
        if(!ref)
        {
            NSLog(@"Error : Native object[%@] not exist", key);
            
            return ;
        }
        
        [ref.nativeObject exec:name
                          args:[self.binScriptManager argsFmScript:args]
                         proxy:ref.scriptObject
                            cb:[BIN_DELEGATOR_MANAGER onceDelegator:self block:DOTC_DELEGATOR_BLOCK
                                {
                                    [subject onExecDone:command args:arguments];
                
                                    return nil;
                                }]
         ];
    });
}

- (void)doCB:(CDVInvokedUrlCommand*)command;
{
    if(command.arguments.count < 1)
    {
        return ;
    }
    
    NSString* cb  = command.arguments[0];
    id args = nil;
    if(command.arguments.count > 1)
    {
        args = command.arguments[1];
    }
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [BIN_DELEGATOR_MANAGER performDelegator:cb
                                      arguments: args ? [DotCDelegatorArguments argumentsFrom:BIN_DELEGATOR_ARGUMENT_DATA arg:[self.binScriptManager argsFmScript:args]] : nil];
    });
}

- (void) linkNativeWithScript:(CDVInvokedUrlCommand*) command
{
    if(command.arguments.count < 2)
    {
        NSLog(@"Error : Link native with script fail");
        
        return ;
    }
    
    NSString* nKey = command.arguments[0];
    NSString* sKey = command.arguments[1];
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       BINNativeObjectReference* ref = [self.binScriptManager getNativeObjectRef:nKey];
                       if(!ref)
                       {
                           NSLog(@"Error : link native[%@] with script [%@] fail, native not existed", nKey, sKey);
                           return ;
                       }
                       
                       assert(ref.scriptObject == nil);
                       
                       ref.scriptObject = WEAK_OBJECT(BINScriptObject, init:self.binScriptManager key:sKey);
                   });
}

- (void)popNativePageView:(CDVInvokedUrlCommand*)command
{
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [self.binScriptManager.viewController.navigationController popViewControllerAnimated:true];
        
        [self success:nil callbackId:command.callbackId];
    });
}

- (void)pushNativePageView:(CDVInvokedUrlCommand*)command
{
    if(command.arguments.count < 5)
    {
        NSLog(@"Error : pushNativePageView fail");
        
        return ;
    }
    
    NSString* name = command.arguments[0];
    NSString* className = command.arguments[1];
    BINScriptObject* scriptObject = [self.binScriptManager argFmScript:command.arguments[2]];
    NSArray* pushData = [self.binScriptManager argsFmScript:command.arguments[3]];
    DotCDictionaryWrapper* queryParams = [DotCDictionaryWrapper wrapperFromDictionary:command.arguments[4]];
    
    Class cls = NSClassFromString(className);
    if(!cls)
    {
        NSLog(@"Error : pushNativePageView fail, class[%@] not exist", className);
        
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        BINPageViewController* vc = WEAK_OBJECT(cls, init:name scriptObject:scriptObject pushData:pushData queryParams:queryParams);
        [self.binScriptManager.viewController.navigationController pushViewController:vc animated:true];
        
        [self success:WEAK_OBJECT(CDVPluginResult, initWithStatus:CDVCommandStatus_OK message:[self.binScriptManager argToScript:vc.nativeObjectReference]) callbackId:command.callbackId];
    });
}

- (void) onExecDone:(CDVInvokedUrlCommand*) command args:(DotCDelegatorArguments*)args
{
    NSError* error = [args getArgument:BIN_DELEGATOR_ARGUMENT_ERROR];
    if(error)
    {
        [self error:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription] callbackId:command.callbackId];
        
        return ;
    }
    
    id data = [args getArgument:BIN_DELEGATOR_ARGUMENT_DATA];
    if(data)
    {
        if(![data isKindOfClass:[NSArray class]])
        {
            data = @[data];
        }
        data = [self.binScriptManager argsToScript:data];
        
        [self success:WEAK_OBJECT(CDVPluginResult, initWithStatus:CDVCommandStatus_OK message:data) callbackId:command.callbackId];
        
        return ;
    }
}

@end
