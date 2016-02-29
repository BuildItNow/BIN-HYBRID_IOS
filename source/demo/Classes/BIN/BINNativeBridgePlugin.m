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
#import "BINStubViewController.h"

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

- (void)pushStubView:(CDVInvokedUrlCommand*)command
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       UINavigationController* nvc = DOTC_UI_MANAGER.mainNavigationController;
                       UIViewController* vc = nvc.topViewController;
                       if([vc isKindOfClass:[BINStubViewController class]])
                       {
                           [self success:WEAK_OBJECT(CDVPluginResult, initWithStatus:CDVCommandStatus_OK message:nil) callbackId:command.callbackId];
                           
                           return ;
                       }
                       
                       vc = WEAK_OBJECT(BINStubViewController, init);
                       [nvc pushViewController:vc animated:true];
                       
                       [self success:WEAK_OBJECT(CDVPluginResult, initWithStatus:CDVCommandStatus_OK message:nil) callbackId:command.callbackId];
                   });
}

- (void)popNativePageView:(CDVInvokedUrlCommand*)command
{
    if(command.arguments.count < 2)
    {
        return ;
    }
    int  n = ((NSNumber*)command.arguments[0]).intValue;;
    bool a = ((NSNumber*)command.arguments[1]).boolValue;;
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        UINavigationController* nvc = DOTC_UI_MANAGER.mainNavigationController;
        if( n == 1)
        {
            [nvc popViewControllerAnimated:a];
        }
        else
        {
            NSArray* vcs = nvc.viewControllers;
            int i = ((int)vcs.count)-1-n;
            i = MAX(0, i);
            
            [nvc popToViewController:vcs[i] animated:a];
        }
        
        [self success:WEAK_OBJECT(CDVPluginResult, initWithStatus:CDVCommandStatus_OK message:nil) callbackId:command.callbackId];
    });
}

- (void)pushNativePageView:(CDVInvokedUrlCommand*)command
{
    if(command.arguments.count < 6)
    {
        NSLog(@"Error : pushNativePageView fail");
        
        return ;
    }
    
    NSString* name = command.arguments[0];
    NSString* className = command.arguments[1];
    BINScriptObject* scriptObject = [self.binScriptManager argFmScript:command.arguments[2]];
    NSString* pushFrom = command.arguments[3];
    NSArray* pushData = [self.binScriptManager argsFmScript:command.arguments[4]];
    DotCDictionaryWrapper* queryParams = [DotCDictionaryWrapper wrapperFromDictionary:command.arguments[5]];
    
    Class cls = NSClassFromString(className);
    if(!cls)
    {
        NSLog(@"Error : pushNativePageView fail, class[%@] not exist", className);
        
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        UINavigationController* nvc = DOTC_UI_MANAGER.mainNavigationController;
        BINPageViewController* vc = WEAK_OBJECT(cls, init:name scriptObject:scriptObject);
        [vc onViewPush:pushFrom pushData:pushData queryParams:queryParams];
        [nvc pushViewController:vc animated:true];
        
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
