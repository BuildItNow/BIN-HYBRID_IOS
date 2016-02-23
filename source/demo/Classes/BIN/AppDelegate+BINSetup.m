//
//  AppDelegate+BINSetup.m
//  demo
//
//  Created by Checker on 16/2/14.
//
//

#import "AppDelegate+BINSetup.h"
#import "BINScriptManager.h"
#import "BINSplashViewController.h"
#import "MainViewController.h"

@implementation AppDelegate (BINSetup)

- (void) BINSetup
{
    /** If you need to do any extra app-specific initialization, you can do it here
     *  -jm
     **/
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    int cacheSizeMemory = 8 * 1024 * 1024; // 8MB
    int cacheSizeDisk = 32 * 1024 * 1024; // 32MB
#if __has_feature(objc_arc)
    NSURLCache* sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
#else
    NSURLCache* sharedCache = [[[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"] autorelease];
#endif
    [NSURLCache setSharedURLCache:sharedCache];
    
    BIN_GLOBAL_SCRIPT_MANAGER;
    
    [BIN_GLOBAL_SCRIPT_MANAGER once:SCRIPT_EVENT_READY object:self selector:@selector(onScriptManagerReady:)];
    
    [BIN_GLOBAL_SCRIPT_MANAGER loadFromURL:nil];
    
    [DOTC_UI_MANAGER startWithClass:[BINSplashViewController class] animated:false];
}

- (void) evalJs:(NSString*) js
{
    [BIN_GLOBAL_SCRIPT_MANAGER evalJs:js];
}

- (void) evalJsS:(NSString*) js
{
    [BIN_GLOBAL_SCRIPT_MANAGER evalJsS:js];
}

- (void) onScriptManagerReady:(DotCDelegatorArguments*) args
{
    [DOTC_UI_MANAGER startWithClass:[MainViewController class] animated:false];
}

@end
