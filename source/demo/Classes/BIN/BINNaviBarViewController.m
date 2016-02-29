//
//  NaviBarViewController.m
//  demo
//
//  Created by Checker on 16/2/28.
//
//

#import "BINNaviBarViewController.h"
#import "BINPageViewController.h"

@interface BINNaviBarViewController ()
{
    BINPageViewController*       _holder;
}
@property (retain, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation BINNaviBarViewController

@synthesize titleView = _titleView;

- (instancetype) initWithHolder:(BINPageViewController*)holder
{
    if(!(self = [super init]))
    {
        return self;
    }
    
    _holder = holder;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBack:(UIButton *)sender
{
    [_holder goBack];
}

- (void)setTitle:(NSString *)title
{
    _titleView.text = title;
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
    [_titleView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleView:nil];
    [super viewDidUnload];
}
@end
