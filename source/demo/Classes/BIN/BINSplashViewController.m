//
//  BINSplashViewController.m
//  demo
//
//  Created by Checker on 16/2/17.
//
//

#import "BINSplashViewController.h"

@interface BINSplashViewController ()

@end

@implementation BINSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onSetupWebView:(UIWebView*) webView
{
    [super onSetupWebView:webView];
    
    webView.hidden = true;
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
