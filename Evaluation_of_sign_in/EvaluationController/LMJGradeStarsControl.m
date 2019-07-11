//
//  LMJGradeStarsControl.m
//  Evaluation_of_sign_in
//
//  Created by winds on 2019/7/11.
//  Copyright © 2019 winds. All rights reserved.
//


#import "LMJGradeStarsControl.h"

@implementation LMJGradeStarsControl
{
    NSInteger _defaultIndex;
    NSInteger _totalStars;
    CGFloat   _size;
    
    NSMutableArray * _starsBtnArr;
}

- (id)initWithFrame:(CGRect)frame totalStars:(NSInteger)totalStars starSize:(CGFloat)size{
    self = [self initWithFrame:frame defaultSelectedStatIndex:(LMJGradeStarsControlStartIndex-1) totalStars:totalStars starSize:size];
    return self;
}

- (id)initWithFrame:(CGRect)frame defaultSelectedStatIndex:(NSInteger)index totalStars:(NSInteger)totalStars starSize:(CGFloat)size{
    self = [super initWithFrame:frame];
    _defaultIndex = index;
    _totalStars   = totalStars;
    _size         = size;
    
    if (self) {
        _starsBtnArr = [NSMutableArray array];
        [self buildStars];
    }
    return self;
}


- (void)buildStars{
    CGFloat starDistance = self.frame.size.width / (_totalStars +1);
    
    int i = 0;
    
    for (int index = LMJGradeStarsControlStartIndex; index < (LMJGradeStarsControlStartIndex +_totalStars); index++) {
        
        UIButton * starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [starBtn setFrame:CGRectMake(0, 0, _size +10, _size +10)];
        [starBtn setCenter:CGPointMake(starDistance * (i+1), self.frame.size.height/2)];
        [starBtn setBackgroundColor:[UIColor clearColor]];
        if (index <= _defaultIndex) {
            [starBtn setImage:[UIImage imageNamed:@"starbucks_ComS"] forState:UIControlStateNormal];
            [starBtn setImage:[UIImage imageNamed:@"starbucks_ComS"] forState:UIControlStateHighlighted];
        }else{
            [starBtn setImage:[UIImage imageNamed:@"starbucks_Com"] forState:UIControlStateNormal];
            [starBtn setImage:[UIImage imageNamed:@"starbucks_Com"] forState:UIControlStateHighlighted];
        }
    
        [starBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [starBtn setTag:index];
        [starBtn setHighlighted:NO];
        [starBtn addTarget:self action:@selector(clickStarBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:starBtn];
        
        [_starsBtnArr addObject:starBtn];
        
        i++;
    }
}


- (void)clickStarBtn:(UIButton *)button{
    [self clickStarBtnActionWithBtnTag:button.tag];
}

- (void)clickStarBtnActionWithBtnTag:(NSInteger)tag{
    for (int i = 0; i < _starsBtnArr.count; i++) {
        UIButton * btn = _starsBtnArr[i];
        
        if (btn.tag <= tag) {
            [btn setImage:[UIImage imageNamed:@"starbucks_ComS"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"starbucks_ComS"] forState:UIControlStateHighlighted];;
        }else{
            [btn setImage:[UIImage imageNamed:@"starbucks_Com"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"starbucks_Com"] forState:UIControlStateHighlighted];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(gradeStarsControl:selectedStars:)]) {
        [self.delegate gradeStarsControl:self selectedStars:(tag)];
    }
}

- (void)setSelectedStarIndex:(NSUInteger)index{
    [self clickStarBtnActionWithBtnTag:index];
}

@end
