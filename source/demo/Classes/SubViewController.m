//
//  SubViewController.m
//  demo
//
//  Created by Checker on 16/2/26.
//
//

#import "SubViewController.h"

@interface SubViewController ()
@property (retain, nonatomic) IBOutlet UIView *mainView;

@end

@implementation SubViewController

@synthesize mainView = _mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(_pushData)
    {
        [DotCHUDUtil showSuccessWithStatus:[NSString stringWithFormat:@"Push Data : %@", _pushData]];
    }
    
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

- (IBAction)onBack:(UIButton *)sender
{
    [self pop:1 data:nil];
}

- (void) onViewBack:(NSString *)backFrom backData:(NSArray *)backData
{
    if(backData)
    {
        [DotCHUDUtil showSuccessWithStatus:[NSString stringWithFormat:@"Push Data : %@", backData]];
    }
}

- (IBAction)onPush:(UIButton *)sender
{
    [self push:@"hybridDemo/index" data:nil];
}

- (IBAction)onPushH5SubViewWithData:(UIButton *)sender
{
    [self push:@"hybridDemo/h5SubView" data:@[@"This is from native data"]];
}

- (IBAction)onPushH5SubView:(UIButton *)sender
{
    [self push:@"hybridDemo/h5SubView" data: nil];
}

- (IBAction)onPushSubView:(UIButton *)sender
{
    [self push:@"hybridDemo/subView" data: nil];
}

- (IBAction)onPop2:(UIButton *)sender
{
    [self pop:2 data:nil];
}

- (IBAction)onPop3:(UIButton *)sender
{
    [self pop:3 data:nil];
}

- (IBAction)onBackHybridDemoIndex:(UIButton *)sender
{
    [self popTo:@"hybridDemo/index" data:nil];
}

- (IBAction)onBackWelcomeIndex:(UIButton *)sender
{
    [self popTo:@"welcome/index" data:nil];
}

- (IBAction)onBackH5SubViewWithData:(id)sender
{
    [self popTo:@"hybridDemo/h5SubView" data:@[@"This is from native data"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_mainView release];
    [super dealloc];
}
@end
