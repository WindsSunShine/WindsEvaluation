//
//  LMJGradeStarsControl.h
//  Evaluation_of_sign_in
//
//  Created by winds on 2019/7/11.
//  Copyright © 2019 winds. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置star的计数起点（全局影响）:也就是第一颗星星的序号以0还是1或者其他的数字作为起点
#define LMJGradeStarsControlStartIndex 0

@class LMJGradeStarsControl;

@protocol LMJGradeStarsControlDelegate <NSObject>

- (void)gradeStarsControl:(LMJGradeStarsControl *)gradeStarsControl selectedStars:(NSInteger)stars;

@end

@interface LMJGradeStarsControl : UIView

- (id)initWithFrame:(CGRect)frame totalStars:(NSInteger)totalStars starSize:(CGFloat)size;
- (id)initWithFrame:(CGRect)frame defaultSelectedStatIndex:(NSInteger)index totalStars:(NSInteger)totalStars starSize:(CGFloat)size;

- (void)setSelectedStarIndex:(NSUInteger)index; // 手动选择星级，同样会有代理函数的回调

@property (nonatomic,assign) id <LMJGradeStarsControlDelegate> delegate;

@end
