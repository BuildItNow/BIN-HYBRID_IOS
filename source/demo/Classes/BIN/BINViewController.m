//
//  BINViewController.m
//  demo
//
//  Created by Checker on 16/2/17.
//
//

#import "BINViewController.h"
#import "DotCSystemUtil.h"
#import "CDVJSON.h"

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

- (CGRect) statusBarFrame
{
    return _statusBarFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) push:(NSString*)name data:(NSArray*)data
{
    [BINViewController push:name data:data];
}

- (void) pop:(NSArray*)data
{
    [BINViewController pop:data];
}

- (void) popTo:(NSString*)name data:(NSArray*)data
{
    [BINViewController popTo:name data:data];
}

- (void) pop:(int)count data:(NSArray*)data
{
    [BINViewController pop:count data:data];
}

+ (void) push:(NSString*)name data:(NSArray*)data
{
    NSString* js = nil;
    if(data)
    {
        data = [BIN_GLOBAL_SCRIPT_MANAGER argsToScript:data];
        js = [NSString stringWithFormat:@"bin.nativeManager.push('%@', '%@')", name, [data JSONString]];
    }
    else
    {
        js = [NSString stringWithFormat:@"bin.nativeManager.push('%@')", name];
    }
    
    [BIN_GLOBAL_SCRIPT_MANAGER evalJs:js];
}

+ (void) pop:(NSArray*)data
{
    [self pop:1 data:data];
}

+ (void) popTo:(NSString*)name data:(NSArray*)data
{
    NSString* js = nil;
    if(data)
    {
        data = [BIN_GLOBAL_SCRIPT_MANAGER argsToScript:data];
        js = [NSString stringWithFormat:@"bin.nativeManager.popTo('%@', '%@')", name, [data JSONString]];
    }
    else
    {
        js = [NSString stringWithFormat:@"bin.nativeManager.popTo('%@')", name];
    }
    [BIN_GLOBAL_SCRIPT_MANAGER evalJs:js];
}

+ (void) pop:(int)count data:(NSArray*)data
{
    NSString* js = nil;
    if(data)
    {
        data = [BIN_GLOBAL_SCRIPT_MANAGER argsToScript:data];
        js = [NSString stringWithFormat:@"bin.nativeManager.pop('%d', '%@')", count, [data JSONString]];
    }
    else
    {
        js = [NSString stringWithFormat:@"bin.nativeManager.pop('%d')", count];
    }
    
    [BIN_GLOBAL_SCRIPT_MANAGER evalJs:js];
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
