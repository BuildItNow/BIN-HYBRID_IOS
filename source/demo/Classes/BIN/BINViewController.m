//
//  BINViewController.m
//  demo
//
//  Created by Checker on 16/2/17.
//
//

#import "BINViewController.h"

@interface BINViewController ()

@end

@implementation BINViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [BIN_GLOBAL_SCRIPT_MANAGER onViewControllerAttach:self];
    
    [self onSetupWebView:BIN_GLOBAL_SCRIPT_MANAGER.webView];
}

- (void) onSetupWebView:(UIWebView*) webView
{
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    webView.frame = frame;
    webView.hidden = false;
    [self.view addSubview:webView];
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
