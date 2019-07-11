//
//  SDPriceStarView.h
//  Evaluation_of_sign_in
//
//  Created by winds on 2019/7/11.
//  Copyright © 2019 winds. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SDPriceStarView : UIView

+(instancetype)sdPriceStarView;

@property (nonatomic,copy) void (^sdPriceBlock)(NSString *priceID);

@property (nonatomic,copy) void (^sdStarBlock)(NSString *starID);

@property (nonatomic,copy) void (^sdSureBlock)();

/**
 星级arr
 */
@property (nonatomic,strong) NSMutableArray *starArr;

@end
