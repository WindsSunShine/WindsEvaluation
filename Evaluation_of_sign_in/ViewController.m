//
//  ViewController.m
//  Evaluation_of_sign_in
//
//  Created by winds on 2019/7/11.
//  Copyright © 2019 winds. All rights reserved.
//

#import "ViewController.h"
#import "SDPriceStarView.h"
#define mDeviceWidth [UIScreen mainScreen].bounds.size.width
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 50);
    [btn setTitle:@"点击评价" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =[UIColor redColor];
    [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
}


-(void)btnClick:(UIButton *)sender{
    //    __weak __typeof__(self) weakSelf = self;
    SDPriceStarView *priceStarView =[SDPriceStarView sdPriceStarView];
    
    priceStarView.sdPriceBlock=^(NSString *priceID){
        
        NSLog(@"价格ID:%@",priceID);
        
    };
    
    priceStarView.sdStarBlock=^(NSString *starID){
        
        NSLog(@"星级ID:%@",starID);
        
    };
    
    priceStarView.sdSureBlock=^(){
        //刷新数据
        //        [weakSelf Refreshing];
    };
    
    [self.view addSubview:priceStarView];
    
}

@end
