//
//  BINStubViewController.m
//  demo
//
//  Created by Checker on 16/2/25.
//
//

#import "BINStubViewController.h"

@interface BINStubViewController ()

@end

@implementation BINStubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    frame.origin.y = self.statusBarFrame.size.height;
    frame.size.height -= self.statusBarFrame.size.height;
    webView.frame = frame;
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
