//
//  BINEventEmiterPlugin.m
//  demo
//
//  Created by Checker on 16/2/15.
//
//

#import "BINEventEmiterPlugin.h"
#import "BINScriptManager.h"

@implementation BINEventEmiterPlugin

- (void)fire:(CDVInvokedUrlCommand*)command;
{
    if(command.arguments.count < 1)
    {
        return ;
    }
    
    NSString* event = command.arguments[0];
    DotCDelegatorArguments* args = WEAK_OBJECT(DotCDelegatorArguments, init);
    
    if(command.arguments.count >= 2)
    {
       [args setArgument:command.arguments[1] for:SCRIPT_EVENT_ARGUMENT];
    }
    
    [((BINScriptManager*)self.scriptManager) fire:event arguments:args];
}

@end
