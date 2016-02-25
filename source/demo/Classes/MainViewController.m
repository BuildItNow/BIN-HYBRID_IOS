//
//  CDVStubViewController.m
//  CordovaLib
//
//  Created by Checker on 16/1/30.
//
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (void) exec:(NSString *)name args:(NSArray*)args proxy:(BINScriptObject*)proxy cb:(DotCDelegatorID)cb
{
    
    [proxy get:@"key" cb:[BIN_DELEGATOR_MANAGER onceDelegator:DOTC_DELEGATOR_BLOCK
    {
        id data = [arguments getArgument:BIN_DELEGATOR_ARGUMENT_DATA];
        
        NSLog(@"%@", data);
        
        DotCDelegatorArguments* retArgs = WEAK_OBJECT(DotCDelegatorArguments, init);
        [retArgs setArgument:@[@{@"a":@"Hello World"}, proxy] for:BIN_DELEGATOR_ARGUMENT_DATA];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:retArgs];

        
        return nil;
    }]];
    
    [proxy set:@"a" data:@[@"Hello World a"]];
    
    [proxy call:@"test" args:@[@"Hello", proxy, @{@"a":@(1)} ] cb:[BIN_DELEGATOR_MANAGER onceDelegator:DOTC_DELEGATOR_BLOCK
                          {
                              id data = [arguments getArgument:BIN_DELEGATOR_ARGUMENT_DATA];
                              
                              NSLog(@"%@", data);
                              
                              DotCDelegatorArguments* retArgs = WEAK_OBJECT(DotCDelegatorArguments, init);
                              [retArgs setArgument:@{@"a":@"Hello World"} for:BIN_DELEGATOR_ARGUMENT_DATA];
                              
                              [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:retArgs];
                              
                              
                              return nil;
                          }]];
}

@end
