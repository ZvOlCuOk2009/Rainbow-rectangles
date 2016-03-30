//
//  ViewController.h
//  Rainbow rectangles
//
//  Created by Mac on 24.03.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *collectionButtonsForIPhone;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *collectionButtonTheme;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *systemButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *collectionButtonFinish;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *collectionBackgroundView;


@property (weak, nonatomic) IBOutlet UILabel *countTouchLabel;
@property (assign, nonatomic) NSInteger nilCountTap;

- (IBAction)actionButtonsForIPhone:(UIButton *)sender;


@end

