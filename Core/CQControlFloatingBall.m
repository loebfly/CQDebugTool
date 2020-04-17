//
//  CQControlFloatingBall.m
//  CQDebugTool
//
//  Created by QuQu-iOS on 2020/4/14.
//

#import "CQControlFloatingBall.h"
#import "CQFPSLabel.h"

@interface CQControlFloatingBall ()

/* FPS */
@property (nonatomic, strong) CQFPSLabel *fpsLabel;

@end

@implementation CQControlFloatingBall

+ (instancetype)shareBall {
    static CQControlFloatingBall *ball;
   #ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ball = [[CQControlFloatingBall alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    #endif
    return ball;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIViewController *rootVC = [[UIViewController alloc] init];
        rootVC.view.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(0, 50, 50, 50);
        self.rootViewController = rootVC;
        self.hidden = NO;
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
                 
               [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    CGFloat centerX = recognizer.view.center.x + translation.x;
    CGFloat centerY = recognizer.view.center.y + translation.y;
    
    if (centerX < self.bounds.size.width/2) {
        centerX = self.bounds.size.width/2;
    } else if (centerX > [UIScreen mainScreen].bounds.size.width - self.bounds.size.width/2) {
        centerX = [UIScreen mainScreen].bounds.size.width - self.bounds.size.width/2;
    }
    
    if (centerY < self.bounds.size.height/2 + [UIApplication sharedApplication].statusBarFrame.size.height) {
        centerY = self.bounds.size.height/2 + [UIApplication sharedApplication].statusBarFrame.size.height;
    } else if (centerY > [UIScreen mainScreen].bounds.size.height - self.bounds.size.width/2) {
        centerY = [UIScreen mainScreen].bounds.size.height - self.bounds.size.height/2;
    }
    
    recognizer.view.center = CGPointMake(centerX,centerY);
    
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}

@end
