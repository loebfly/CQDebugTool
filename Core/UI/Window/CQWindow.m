//
//  CQWindow.m
//  BlocksKit
//
//  Created by QuQu-iOS on 2020/4/17.
//

#import "CQWindow.h"

@implementation CQWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIViewController *rootVC = [[UIViewController alloc] init];
        rootVC.view.backgroundColor = [UIColor redColor];
        self.rootViewController = rootVC;
        self.hidden = NO;
    }
    return self;
}

@end
