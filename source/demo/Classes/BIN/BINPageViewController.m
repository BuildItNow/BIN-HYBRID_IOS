//
//  BINPageViewController.m
//  demo
//
//  Created by Checker on 16/2/23.
//
//

#import "BINPageViewController.h"

@interface BINPageViewController ()
{
    NSString*                   _name;
    BINNativeObjectReference*   _nativeObjectReference;
    BINScriptObject*            _scriptObject;
}

@end

@implementation BINPageViewController

- (instancetype) init:(NSString*)name scriptObject:(BINScriptObject*)scriptObject;
{
    if(!(self = [super init]))
    {
        return self;
    }
    
    _name = [name copy];
    _nativeObjectReference = [[BIN_GLOBAL_SCRIPT_MANAGER registeNativeObject:self] retain];
    _scriptObject = [scriptObject retain];
    
    return self;
}

- (void)onViewPush:(NSString*)pushFrom pushData:(NSArray*)pushData queryParams:(DotCDictionaryWrapper*)queryParams
{
    _pushFrom = [pushFrom copy];
    _pushData = [pushData retain];
    _queryParams = [queryParams retain];
}

- (BINNativeObjectReference*) nativeObjectReference;
{
    return _nativeObjectReference;
}

- (BINScriptObject*) scriptObject
{
    return _scriptObject;
}

- (NSString*) name
{
    return _name;
}

- (CGRect) naviBarFrame
{
    return _naviBarController.view.frame;
}

- (void) dealloc
{
    [_naviBarController release];
    _naviBarController = nil;
    [_queryParams release];
    _queryParams = nil;
    [_pushData release];
    _pushData = nil;
    
    [_nativeObjectReference release];
    _nativeObjectReference = nil;
    [BIN_GLOBAL_SCRIPT_MANAGER removeNativeObject:self];
    
    [_scriptObject release];
    _scriptObject = nil;
    
    [_name release];
    _name = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup nativigation bar
    _naviBarController = STRONG_OBJECT(BINNaviBarViewController, initWithHolder:self);
    CGRect frame = _naviBarController.view.frame;
    frame.origin.y = self.statusBarFrame.size.height;
    _naviBarController.view.frame = frame;
    [self.view addSubview:_naviBarController.view];
    
    // trigger onload event
    [_scriptObject call:@"onLoad" args:nil cb:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTitle:(NSString *)title
{
    [_naviBarController setTitle:title];
}

- (void) exec:(NSString *)name args:(NSArray*)args proxy:(BINScriptObject *)proxy cb:(DotCDelegatorID)cb
{
    if([name isEqualToString:@"onViewBack"])
    {
        NSString* backFrom = args[0];
        NSArray*  backData = args[1];
        backData = [BIN_GLOBAL_SCRIPT_MANAGER argsFmScript:backData];
        
        [self onViewBack:backFrom backData:backData];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:nil];
        
        return ;
    }
    if([name isEqualToString:@"onShow"])
    {
        [self onShow];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:nil];
        
        return ;
    }
    if([name isEqualToString:@"onHide"])
    {
        [self onHide];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:nil];
        
        return ;
    }
    if([name isEqualToString:@"onRemove"])
    {
        [self onRemove];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:nil];
        
        return ;
    }
    if([name isEqualToString:@"setTitle"])
    {
        NSString* backFrom = args[0];
        [self setTitle:backFrom];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:nil];
        
        return ;
    }
}

- (void)onViewBack:(NSString*)backFrom backData:(NSArray*)backData
{

}

- (void)onShow
{
}

- (void)onHide
{
}

- (void)onRemove
{
    
}

- (void) goBack
{
    [self pop:nil];
}

@end
