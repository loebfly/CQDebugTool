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
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1) {
        UITouch *touch = touches.anyObject;
        CGPoint locationPoint = [touch locationInView:[UIApplication sharedApplication].delegate.window];
        self.center = locationPoint;
    }
}

@end
