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
    NSArray*                    _pushData;
    DotCDictionaryWrapper*      _queryParams;
}

@end

@implementation BINPageViewController

- (instancetype) init:(NSString*)name scriptObject:(BINScriptObject*)scriptObject pushData:(NSArray*)pushData queryParams:(DotCDictionaryWrapper*)queryParams
{
    if(!(self = [super init]))
    {
        return self;
    }
    
    _name = [name copy];
    _nativeObjectReference = [[BIN_GLOBAL_SCRIPT_MANAGER registeNativeObject:self] retain];
    _scriptObject = [scriptObject retain];
    _pushData = [pushData retain];
    _queryParams = [_queryParams retain];
    
    return self;
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

- (void) dealloc
{
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onSetupWebView:(UIWebView*) webView
{
    [super onSetupWebView:webView];
    
    //webView.hidden = true;
}

- (void) exec:(NSString *)name args:(NSArray *)args proxy:(BINScriptObject *)proxy cb:(DotCDelegatorID)cb
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
