//
//  ViewController.m
//  Rainbow rectangles
//
//  Created by Mac on 24.03.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSViewController.h"
#import <AVFoundation/AVFoundation.h>

static NSInteger countTapButton = 0;
static NSInteger tapCount = 0;
static NSInteger touchesCounter = 1;

@interface TSViewController () <AVAudioPlayerDelegate>

@property (weak, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *startTimer;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIButton *rndButton;
@property (strong, nonatomic) UIButton *setButton;
@property (assign, nonatomic) NSInteger resaultCount;

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) IBOutlet UIView *viewSetting;
@property (weak, nonatomic) UIView *home;
@property (weak, nonatomic) UIView *info;

@end

@implementation TSViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setRandomColorButtons];
    tapCount = self.nilCountTap;
    [self homeScreen];
}

- (void) homeScreen {
    
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    UIView *home = [[UIView alloc] initWithFrame:rect];
    self.home = home;
    home.backgroundColor = [UIColor blackColor];
    [self.view addSubview:home];
    UIButton *play = [self button:86 bckgrndImg:@"arrow" color:[self randomColor]];
    UIButton *info = [self button:164 bckgrndImg:@"circle" color:[self randomColor]];
    [play addTarget:self action:@selector(playHendler) forControlEvents:UIControlEventTouchUpInside];
    [info addTarget:self action:@selector(infoHendler) forControlEvents:UIControlEventTouchUpInside];
    [home addSubview:play];
    [home addSubview:info];
}

- (UIButton *) button:(NSInteger) xValue bckgrndImg:(NSString *) bckgrndImg color:(UIColor *) color  {
    
    CGRect rect = CGRectMake(xValue, 248, 70, 70);
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = color;
    UIImage *image = [[UIImage imageNamed:bckgrndImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:image forState:UIControlStateNormal];
    btn.layer.cornerRadius = 10;
    return btn;
}

- (void) playHendler {
    
    if (touchesCounter == 1) {
        [self timer];
        self.startTimer = [NSDate date];
    }
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.home.alpha = 0;
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self.home removeFromSuperview];
                         });
                     }];
}

- (void) infoHendler {
    
    CGRect rectVw = CGRectMake(50, 180, 260, 240);
    UIView *info = [[UIView alloc] initWithFrame:rectVw];
    self.info = info;
    [self.view addSubview:info];
    
    CGRect rectLbl = CGRectMake(0, 0, 260, 200);
    UILabel *lbl = [[UILabel alloc] initWithFrame:rectLbl];
    lbl.backgroundColor = [UIColor blackColor];
    lbl.alpha = 0;
    [lbl setText:@"Коснитесь двух квадратов одинакового цвета. Постарайтесь отыскать как можно больше одинаковых квадратов за максимально быстрое всремя. Устанавливайте рекорды, делитесь ими с друзьями. \nЖелаем успехов!!!"];
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    [lbl sizeToFit];
    [info addSubview:lbl];
    
    CGRect rect = CGRectMake(98, 210, 24, 24);
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.alpha = 0;
    UIImage *image = [[UIImage imageNamed:@"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deletedLbl) forControlEvents:UIControlEventTouchUpInside];
    [info addSubview:btn];
    
    [UIView animateWithDuration:0.6
                     animations:^{
                         lbl.alpha = 0.85;
                         btn.alpha = 0.85;
                     }];
}

- (void) deletedLbl {
    
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.info.alpha = 0;
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self.info removeFromSuperview];
                         });
                     }];
}

#pragma mark - Setting elements

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setShadowView:self.timerLabel cornerRadius:5];
    [self setShadowView:self.countTouchLabel cornerRadius:5];
    [self setRoundness:self.collectionBackgroundView];
    [self setRoundness:self.collectionButtonsForIPhone];
    [self setRoundness:self.collectionButtonTheme];
    [self setRoundness:self.collectionButtonFinish];
    [self cornerRadius:self.viewSetting];
}

- (void) setRoundness:(NSArray *) array {
    
    for (UIButton *btn in array) {
        [self setShadowView:btn cornerRadius:10];
    }
}

- (void) cornerRadius:(UIView *) view {
    
    view.layer.cornerRadius = 10;
}

- (void) setShadowView:(UIView *) view cornerRadius:(NSInteger) radius {
    
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(3, 3);
    view.layer.shadowRadius = 2;
    view.layer.shadowOpacity = 0.65;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
}

#pragma mark - Rotation buttons

-(void)runSpinAnimationOnViewRight:(UIView *)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    
    [UIView animateWithDuration:1
                     animations:^{
                         CABasicAnimation *rotationAnimation;
                         rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                         rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0f * rotations * duration];
                         rotationAnimation.duration = duration;
                         rotationAnimation.cumulative = YES;
                         rotationAnimation.repeatCount = repeat;
                         [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
                     }];
}

#pragma mark - Animation

- (void) viewAnimation:(UIView *) view yValue:(NSInteger) yValue width:(NSInteger) width height:(NSInteger) height {
    
    [UIView animateWithDuration:1.45f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         view.frame = CGRectMake(10, yValue, width, height);
                     }
                     completion:nil];
    [self runSpinAnimationOnViewRight:[self.systemButtons objectAtIndex:0] duration:1.0 rotations:1.0 repeat:0];
}


#pragma mark - Models


- (IBAction)actionButtonsForIPhone:(UIButton *)sender {

    if (sender.tag == self.rndButton.tag) {
        self.rndButton.userInteractionEnabled = NO;
    } else if (sender.tag == self.setButton.tag) {
        self.setButton.userInteractionEnabled = NO;
    }
    if (sender.tag == self.rndButton.tag || sender.tag == self.setButton.tag) {
        NSInteger resaultCount = ++countTapButton;
        self.resaultCount = resaultCount;
        if (_resaultCount == 2) {
            if (sender.tag == self.setButton.tag) {
                [self setRandomColorButtons];
                self.countTouchLabel.text = [NSString stringWithFormat:@"%ld", (long)++tapCount];
                [self performSelector:@selector(soundAudioFileFinish) withObject:nil afterDelay:0.0];
            }
            if (sender.tag == self.rndButton.tag) {
                [self setRandomColorButtons];
                self.countTouchLabel.text = [NSString stringWithFormat:@"%ld", (long)++tapCount];
                [self performSelector:@selector(soundAudioFileFinish) withObject:nil afterDelay:0.0];
            }
            self.rndButton.userInteractionEnabled = YES;
            self.setButton.userInteractionEnabled = YES;
        }
    }
    if (_resaultCount >= 2) {
        countTapButton = 0;
    }
    touchesCounter++;
}

-(void) setRandomColorButtons {
    
    [self setRandomColorAllButton];
    [self createRndButton];
    [self createSetButton];
    if (self.rndButton.tag == self.setButton.tag) {
        [self createSetButton];
        self.rndButton.backgroundColor = self.setButton.backgroundColor;
        if (self.rndButton.tag == self.setButton.tag) {
            [self createSetButton];
            self.rndButton.backgroundColor = self.setButton.backgroundColor;
        }
    } else {
        self.rndButton.backgroundColor = self.setButton.backgroundColor;
    }
}

-(void) createRndButton {
    
    NSInteger rndTag = arc4random() % 24;
    UIButton *rndButton = self.collectionButtonsForIPhone[rndTag];
    self.rndButton = rndButton;
    NSLog(@"rndButton tag = %ld", (long)rndButton.tag);
}

-(void) createSetButton {
    
    NSInteger setRndTag = arc4random() % 23;
    UIButton *setButton = self.collectionButtonsForIPhone[setRndTag];
    self.setButton = setButton;
    NSLog(@"setButton tag = %ld", (long)setButton.tag);
}

-(void) setRandomColorAllButton {
    
    for (UIButton *button in self.collectionButtonsForIPhone) {
        button.backgroundColor = [self randomColor];
    }
}


-(UIColor *) randomColor {
    
    CGFloat r = arc4random() % 255 / 256.0;
    CGFloat g = arc4random() % 255 / 256.0;
    CGFloat b = arc4random() % 255 / 256.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


#pragma mark - Actions


- (IBAction)actionSystemButton:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self restartGame];
        if (touchesCounter == 1) {
            [self timer];
            self.startTimer = [NSDate date];
        }
    } else if (sender.tag == 2) {
        [_timer invalidate];
        if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                [self viewAnimation:self.viewSetting yValue:10 width:300 height:548];
            }
        } else {
            if ([[UIScreen mainScreen] bounds].size.height == 1024) {
                [self viewAnimation:self.viewSetting yValue:10 width:748 height:1004];
            }
        }
    } else if (sender.tag == 3) {
        [_timer fire];
        if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                [self viewAnimation:self.viewSetting yValue:568 width:300 height:548];
            }
        } else {
            if ([[UIScreen mainScreen] bounds].size.height == 1024) {
                [self viewAnimation:self.viewSetting yValue:1024 width:748 height:1004];
            }
        }
    }
}


- (void) restartGame {
    
    [self setRandomColorButtons];
    self.timerLabel.text = @"00";
    self.countTouchLabel.text = @"0";
    [_timer invalidate];
    touchesCounter = 1;
    [self runSpinAnimationOnViewRight:[self.systemButtons objectAtIndex:1] duration:1.0 rotations:1.0 repeat:0];
}

- (IBAction)actionTheme:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self colorTheme:65 green:56 blue:89];
        [self returnToGameForIphone];
    } else if (sender.tag == 2) {
        [self colorTheme:96 green:98 blue:179];
        [self returnToGameForIphone];
    } else if (sender.tag == 3) {
        [self colorTheme:85 green:85 blue:85];
        [self returnToGameForIphone];
    } 
}
- (IBAction)actionButtonFinish:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self viewAnimation:self.viewSetting yValue:548 width:300 height:548];
        touchesCounter = 1;
    }
}


- (void) returnToGameForIphone {
    
    [self viewAnimation:self.viewSetting yValue:568 width:300 height:548];
}


- (void) returnToGameForIpad {
    
    [self viewAnimation:self.viewSetting yValue:1024 width:748 height:1004];
}

- (void) colorTheme:(NSInteger) red green:(NSInteger) green blue:(NSInteger) blue {
    
    self.view.backgroundColor = [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:1];
}


#pragma mark - Timer

-(NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(updateTimer:)
                                                userInfo:nil
                                                 repeats:YES];
    }
    return _timer;
}


-(void) updateTimer:(NSTimer*)timer {
    
    NSDate *curentdata = [NSDate date];
    NSTimeInterval timeInterval = [curentdata timeIntervalSinceDate:self.startTimer];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timerString = [dateFormatter stringFromDate:timerDate];
    self.timerLabel.text = timerString;
    if ([timerString isEqualToString:@"59"]) {
        [_timer invalidate];
        touchesCounter = 1;
        self.timerLabel.text = @"00";
        self.countTouchLabel.text = @"0";
        [self viewAnimation:self.viewSetting yValue:10 width:300 height:548];
    }
}

#pragma mark - Player


- (void) soundAudioFileFinish {
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jingle_bells" ofType:@"mov"];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
        self.player = [[AVPlayer alloc] initWithPlayerItem:item];
        [self.player play];
}

@end
