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
        ball = [[CQControlFloatingBall alloc] init];
    });
    #endif
    return ball;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 100, 50, 50);
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        self.layer.cornerRadius = 25;
        self.layer.masksToBounds = YES;
        self.windowLevel = UIWindowLevelStatusBar + 2;
        self.hidden = NO;
        
        self.fpsLabel = [[CQFPSLabel alloc] initWithFrame:CGRectMake(0, 20, 50, 20)];
        [self addSubview:self.fpsLabel];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
          
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:[UIApplication sharedApplication].delegate.window];
    
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
    
    [recognizer setTranslation:CGPointZero inView:[UIApplication sharedApplication].delegate.window];
}

@end
