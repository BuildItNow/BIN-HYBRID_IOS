//
//  NaviBarViewController.h
//  demo
//
//  Created by Checker on 16/2/28.
//
//

#import <UIKit/UIKit.h>

@class BINPageViewController;


@interface BINNaviBarViewController : UIViewController

- (instancetype) initWithHolder:(BINPageViewController*)holder;

- (void)setTitle:(NSString *)title;

@end
