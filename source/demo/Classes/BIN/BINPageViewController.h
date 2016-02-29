//
//  BINPageViewController.h
//  demo
//
//  Created by Checker on 16/2/23.
//
//

#import "BINViewController.h"
#import "BINNaviBarViewController.h"

@interface BINPageViewController : BINViewController<BINNativeObjectProtocol>
{
    NSString*                   _pushFrom;
    NSArray*                    _pushData;
    DotCDictionaryWrapper*      _queryParams;
    BINNaviBarViewController*   _naviBarController;
}

- (instancetype) init:(NSString*)name scriptObject:(BINScriptObject*)scriptObject;

- (void)onViewPush:(NSString*)pushFrom pushData:(NSArray*)pushData queryParams:(DotCDictionaryWrapper*)queryParams;

- (BINNativeObjectReference*) nativeObjectReference;
- (BINScriptObject*) scriptObject;
- (NSString*) name;
- (CGRect) naviBarFrame;

- (void) goBack;

- (void)onViewBack:(NSString*)backFrom backData:(NSArray*)backData;

- (void) setTitle:(NSString *)title;

@end
