//
//  BINViewController.m
//  demo
//
//  Created by Checker on 16/2/17.
//
//

#import "BINViewController.h"
#import "DotCSystemUtil.h"

@interface BINViewController ()
{
    CGRect                  _statusBarFrame;
}

@end

@implementation BINViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = true;
    _statusBarFrame = [DOTC_APPLICATION statusBarFrame];
    
    if([DotCSystemUtil aboveIOS7_0])
    {
        UIView* statusBar = WEAK_OBJECT(UIView, initWithFrame:_statusBarFrame);
        statusBar.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:248.0f/255.0f alpha:1.0];
        [self.view addSubview:statusBar];
        [self.view sendSubviewToBack:statusBar];
    }
    else
    {
        _statusBarFrame.size.height = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [BIN_GLOBAL_SCRIPT_MANAGER onViewControllerAttach:self];
    
    [self onSetupWebView:BIN_GLOBAL_SCRIPT_MANAGER.webView];
}

- (void) onSetupWebView:(UIWebView*) webView
{
    [self.view addSubview:webView];
    webView.hidden = false;
    
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    frame.origin.y = _statusBarFrame.size.height;
    frame.size.height -= _statusBarFrame.size.height;
    webView.frame = frame;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [BIN_GLOBAL_SCRIPT_MANAGER onViewControllerDettach:self];
    
    [super viewWillDisappear:animated];
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
