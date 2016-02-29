//
//  ComDemoViewController.m
//  demo
//
//  Created by Checker on 16/2/29.
//
//

#import "ComDemoViewController.h"

@interface ComDemoViewController ()
@property (retain, nonatomic) IBOutlet UIView *mainView;

@end

@implementation ComDemoViewController

@synthesize mainView = _mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = _mainView.frame;
    frame.origin.y    = self.naviBarFrame.origin.y+self.naviBarFrame.size.height;
    frame.size.height = self.view.frame.size.height-frame.origin.y;
    _mainView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onGet:(UIButton *)sender
{
    [self.scriptObject get:@"_getProperty" cb:[BIN_DELEGATOR_MANAGER onceDelegator:DOTC_DELEGATOR_BLOCK
     {
         NSArray* args = [arguments getArgument:BIN_DELEGATOR_ARGUMENT_DATA];
         [DotCHUDUtil showSuccessWithStatus:args[0]];
         return nil;
     }]];
}

- (IBAction)onSet:(UIButton *)sender
{
    [self.scriptObject set:@"_setProperty" data:@"This is setted by native" cb:[BIN_DELEGATOR_MANAGER onceDelegator:DOTC_DELEGATOR_BLOCK
                                               {
                                                   
                                                   [self.scriptObject get:@"_setProperty" cb:[BIN_DELEGATOR_MANAGER onceDelegator:DOTC_DELEGATOR_BLOCK
                                                                                              {
                                                                                                  NSArray* args = [arguments getArgument:BIN_DELEGATOR_ARGUMENT_DATA];
                                                                                                  [DotCHUDUtil showSuccessWithStatus:args[0]];
                                                                                                  return nil;
                                                                                              }]];
                                                   
                                                   return nil;
                                               }]];
}

- (IBAction)onCall:(UIButton *)sender
{
    [DotCHUDUtil showSuccessWithStatus:@"jsChangeTitle will change title"];
    
    [self.scriptObject call:@"jsChangeTitle" args:nil cb:nil];
}
- (IBAction)onJSCallNative:(UIButton*)sender
{
    [self.scriptObject call:@"jsCallNative" args:nil cb:nil];
}

- (void)exec:(NSString *)name args:(NSArray *)args proxy:(BINScriptObject *)proxy cb:(DotCDelegatorID)cb
{
    if([name isEqualToString:@"testFunc"])
    {
        NSString* data = args[0];
        
        [DotCHUDUtil showSuccessWithStatus:[NSString stringWithFormat:@"js call testFunc with [%@]", data]];
        
        DotCDelegatorArguments* arguments = WEAK_OBJECT(DotCDelegatorArguments, init);
        [arguments setArgument:@[@"I'm from native"] for:BIN_DELEGATOR_ARGUMENT_DATA];
        
        [BIN_DELEGATOR_MANAGER performDelegator:cb arguments:arguments];
        
        return ;
    }
    
    [super exec:name args:args proxy:proxy cb:cb];
}

- (void)dealloc
{
    [_mainView release];
    [super dealloc];
}
@end
