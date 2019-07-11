//
//  SDPriceStarView.m
//  Evaluation_of_sign_in
//
//  Created by winds on 2019/7/11.
//  Copyright © 2019 winds. All rights reserved.
//




#import "SDPriceStarView.h"
#import "LMJGradeStarsControl.h"
#import "Masonry/Masonry.h"
#import "YLButton.h"
#define mDeviceWidth [UIScreen mainScreen].bounds.size.width
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height


#define mRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define mHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define mHexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define fontHightRedColor mHexRGB(0x01AF66) //字体深红色
#define fontHightColor mHexRGB(0x666666) //字体深色
#define fontNomalColor mHexRGB(0x999999) //字体浅色

#define kSafeAreaBottomHeight 0

#define bjviewheight   413

#define bjviewSuccessheight  368

#define bjviewShareheight  170


@interface SDPriceStarView ()
<UIGestureRecognizerDelegate>



/**
 星级选择数组
 */
@property (nonatomic,strong)NSMutableArray *starSelectArr;
/**
 星级选择
 */
@property (nonatomic,strong)NSString *starSelectStr;

/**
 星级view
 */
@property (nonatomic,strong)UIView *starView;

/**
  背景
 */
@property (nonatomic,strong)UIView *bjView ;

@property (nonatomic,strong)LMJGradeStarsControl * control;

@property (nonatomic,strong)UIButton * subButton;


@property (nonatomic,strong)UILabel * totalSignLabel;
@property (nonatomic,strong)UILabel * itemSignLabel;

@end


@implementation SDPriceStarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSMutableArray *)starArr{
    if (!_starArr) {
        
        NSArray* arr = @[@{@"title":@"不限",@"value":@""},
                         @{@"title":@"二星/经济",@"value":@"1"},
                         @{@"title":@"三星/舒适",@"value":@"2"},
                         @{@"title":@"四星/高档",@"value":@"3"},
                         @{@"title":@"五星/豪华",@"value":@"4"},
                         ];
        _starArr =[[NSMutableArray alloc]initWithArray:arr];
    }
    return _starArr;
}


+(instancetype)sdPriceStarView
{
    SDPriceStarView *starViewaaa =[[SDPriceStarView alloc]init];
    [starViewaaa setUI];
    return starViewaaa;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/**
 星级arr选择
 
 */
-(NSMutableArray *)starSelectArr{
    if (!_starSelectArr){
        _starSelectArr =[NSMutableArray array];
        
    }
    return _starSelectArr;
}

/**
 初始化
 */
-(void)setUI{
    
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    self.frame =CGRectMake(0, 0, mDeviceWidth, mDeviceHeight);
    [self addSubview:self.bjView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bjView.frame=CGRectMake(0, mDeviceHeight -bjviewheight-kSafeAreaBottomHeight,mDeviceWidth, bjviewheight+kSafeAreaBottomHeight);
    }];
    
    //点击手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowView)];
    [_bjView addGestureRecognizer:tap1];

    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}


-(void)ShowView {
    NSLog(@"防止点击了评价视图消失的问题");
}

#pragma mark - 选择星级(多选)
-(void)setupStarBtnWithStarArr:(NSArray *)starArr {
    
    int totalloc =2;
    CGFloat btnVW = (mDeviceWidth-20)/3; //宽
    CGFloat btnVH = 32; //高
    CGFloat margin = 10; //间距
    CGFloat edgeMargin = (mDeviceWidth - btnVW*2)/2;
    int count =(int)starArr.count;
    for (int i=0;i<count;i++){
        int row =i/totalloc;  //行号
        int loc =i%totalloc;  //列号
        CGFloat btnVX = 0;
       
        CGFloat btnVY = 0;
       
        if (i == count -1) {
            btnVX  = edgeMargin;
            btnVY  = (margin +btnVH)*row;
            btnVW  = btnVW*2+10;
        }else {
            btnVX  = edgeMargin+(margin +btnVW)*loc;
            btnVY  = (margin +btnVH)*row;
        }

        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        starBtn.frame = CGRectMake(btnVX, btnVY, btnVW, btnVH);
        [starBtn setTitle:[NSString stringWithFormat:@"%@",starArr[i][@"title"]] forState:UIControlStateNormal];
        [starBtn setTitleColor:fontHightRedColor forState:UIControlStateSelected];
        [starBtn setTitleColor:fontNomalColor forState:UIControlStateNormal];
        starBtn.titleLabel.font =[UIFont systemFontOfSize:12];
        starBtn.tag=i+200;
        starBtn.layer.cornerRadius=5;
        starBtn.layer.borderColor =[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00].CGColor;
        starBtn.layer.borderWidth=0.6;
        [starBtn  addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.starView addSubview: starBtn];
    }
}

/**
 星级btn点击

 */
-(void)starBtnClick:(UIButton *)starBtn{
    starBtn.selected = !starBtn.selected;
    if (starBtn.selected) {
        [self.starSelectArr addObject:self.starArr[starBtn.tag - 200][@"value"]];
        starBtn.layer.borderColor=fontHightRedColor.CGColor;
        starBtn.backgroundColor  = [UIColor colorWithRed:0.004 green:0.686 blue:0.400 alpha:0.1] ;
    }else {
        starBtn.layer.borderColor=[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00].CGColor;
        [self.starSelectArr removeObject:self.starArr[starBtn.tag - 200][@"value"]];
        starBtn.backgroundColor  = [UIColor whiteColor];
    }
    [self.control setSelectedStarIndex:self.starSelectArr.count-1];
    if (self.starSelectArr.count) {
        [self.subButton setBackgroundColor:mHexRGB(0x3D3935)];
        self.subButton.enabled = YES;
    }else {
        [self.subButton setBackgroundColor:mHexRGB(0xCCCCCC)];
        self.subButton.enabled = NO;
    }
    self.starSelectStr  =[self.starSelectArr componentsJoinedByString:@","];
    if (self.sdStarBlock) {
        self.sdStarBlock (self.starSelectStr);
    }
    
}


/**
 取消/确定按钮
 */
-(void)sureBtnClicked:(UIButton *)sender{
    [self removeView];
    if (sender.tag ==199){ //取消
        
    }else if (sender.tag==299){ //确定
        if (self.sdSureBlock){
            self.sdSureBlock();
        }
        
    }
}

/**
 移除view
 */
-(void)removeView{
    [UIView animateWithDuration:0.25 animations:^{
         self.bjView.frame = CGRectMake(0, mDeviceHeight, mDeviceWidth, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


/**
 背景view
 */
-(UIView *)bjView{
    if (!_bjView) {
        _bjView =[[UIView alloc]init];
        _bjView.userInteractionEnabled = YES;
        _bjView.frame=CGRectMake(0, mDeviceHeight,mDeviceWidth, 0);
        _bjView.backgroundColor=[UIColor whiteColor];
        [self addTitleLabel];
        [self addStarImageView];
        [self addSTarTitleView];
        [self addSubButtonView];
    }
    
    return _bjView;
}

-(void)addTitleLabel {
    UILabel * titleLabel = [[UILabel alloc] init];
    [_bjView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView.mas_top);
        make.left.equalTo(self.bjView.mas_left);
        make.right.equalTo(self.bjView.mas_right);
        make.height.mas_equalTo(60);
    }];
    titleLabel.text      = NSLocalizedString(@"评价并签到", @"");
    titleLabel.textColor = mHexRGB(0x333333);
    titleLabel.font      = [UIFont systemFontOfSize:17 weight:(UIFontWeightMedium)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    UILabel * lineLabel = [[UILabel alloc] init];
    [_bjView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(-0.5);
        make.left.equalTo(self.bjView.mas_left);
        make.right.equalTo(self.bjView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    lineLabel.backgroundColor = mHexRGB(0xE7E7E7);
}

-(void)addStarImageView {
//CGRectMake((mDeviceWidth-200)/2, 92, 200, 30)
    self.control = [[LMJGradeStarsControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30) totalStars:5 starSize:20];
    self.control.userInteractionEnabled  = NO;
    self.control.backgroundColor = [UIColor whiteColor];
    [_bjView addSubview:self.control];
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bjView.mas_top).offset(92);
        make.left.equalTo(_bjView.mas_left).offset((mDeviceWidth-200)/2);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    UILabel * tipLabel = [[UILabel alloc] init];
    [_bjView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.control.mas_bottom).offset(21);
        make.left.equalTo(_bjView.mas_left);
        make.width.mas_equalTo(mDeviceWidth);
        make.height.mas_equalTo(17);
    }];
    tipLabel.text      = NSLocalizedString(@"您的评价会让我们做的更好", @"");
    tipLabel.textColor = mHexRGB(0xB0B0B0);
    tipLabel.font      = [UIFont systemFontOfSize:12];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)addSTarTitleView {
    self.starView =[[UIView alloc]init];
    self.starView.backgroundColor=[UIColor whiteColor];
    [_bjView addSubview:self.starView];
    _starView.frame=CGRectMake(0, bjviewheight-100-116,mDeviceWidth, 116);
    [self.starView setUserInteractionEnabled:YES];
    [self setupStarBtnWithStarArr:self.starArr];
}


-(void)addSubButtonView {
    self.subButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.subButton setTitle:NSLocalizedString(@"评价并签到", @"") forState:(UIControlStateNormal)];
    self.subButton.frame = CGRectMake((mDeviceWidth - ((mDeviceWidth-20)/3)*2)/2, bjviewheight-23-50, ((mDeviceWidth-20)/3) * 2 +10, 50);
    [self.subButton setBackgroundColor:mHexRGB(0xCCCCCC)];
    self.subButton.enabled = NO;
    [self.subButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_bjView addSubview:self.subButton];
    [self.subButton addTarget:self action:@selector(subDataFoSever) forControlEvents:(UIControlEventTouchUpInside)];
    self.subButton.layer.cornerRadius = 5;
    self.subButton.layer.masksToBounds= YES;
}

-(void)subDataFoSever {
    
    [self.subButton setBackgroundColor:mHexRGB(0xCCCCCC)];
    self.subButton.enabled = NO;
    [self.subButton setTitle:NSLocalizedString(@"签到中...", @"") forState:(UIControlStateNormal)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 调整位置
           self.bjView.frame=CGRectMake(0, mDeviceHeight -bjviewSuccessheight-kSafeAreaBottomHeight,mDeviceWidth, bjviewSuccessheight+kSafeAreaBottomHeight);
        } completion:^(BOOL finished) {
            [self.bjView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self addSuccessNewView];
        }];
    });
}


-(void)addSuccessNewView {

    UIImageView * footprintView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"starbucks_footPrint"]];
    [self.bjView addSubview:footprintView];
    [footprintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView.mas_top).offset(42);
        make.centerX.equalTo(self.bjView.mas_centerX);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(100);
    }];
    UILabel * successTipLabel = [[UILabel alloc] init];
    successTipLabel.text      = NSLocalizedString(@"签到成功", @"");
    successTipLabel.textColor = mHexRGB(0x333333);
    successTipLabel.font      = [UIFont systemFontOfSize:18 weight:(UIFontWeightSemibold)];
    successTipLabel.textAlignment = NSTextAlignmentCenter;
    [self.bjView addSubview:successTipLabel];
    [successTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footprintView.mas_bottom).offset(29);
        make.centerX.equalTo(self.bjView.mas_centerX);
        make.height.mas_equalTo(25);
    }];
    
    self.totalSignLabel = [[UILabel alloc] init];
    self.totalSignLabel.text      = NSLocalizedString(@"恭喜您成为第 208 位签到者", @"");
    self.totalSignLabel.textColor = mHexRGB(0x666666);
    self.totalSignLabel.font      = [UIFont systemFontOfSize:14];
    self.totalSignLabel.textAlignment = NSTextAlignmentCenter;
    [self.bjView addSubview:self.totalSignLabel];
    [self.totalSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successTipLabel.mas_bottom).offset(19);
        make.centerX.equalTo(self.bjView.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    
    self.itemSignLabel = [[UILabel alloc] init];
    self.itemSignLabel.text      = NSLocalizedString(@"您已成功签到 5 家门店", @"");
    self.itemSignLabel.textColor = mHexRGB(0x666666);
    self.itemSignLabel.font      = [UIFont systemFontOfSize:14];
    self.itemSignLabel.textAlignment = NSTextAlignmentCenter;
    [self.bjView addSubview:self.itemSignLabel];
    [self.itemSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalSignLabel.mas_bottom).offset(4);
        make.centerX.equalTo(self.bjView.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    
    UIButton * signBtnRank = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bjView addSubview:signBtnRank];
    [signBtnRank addTarget:self action:@selector(signBtnRankPushView) forControlEvents:(UIControlEventTouchUpInside)];
    [signBtnRank setTitle:NSLocalizedString(@"查看签到排名", @"") forState:(UIControlStateNormal)];
    [signBtnRank setTitleColor:mHexRGB(0x00A862) forState:(UIControlStateNormal)];
    signBtnRank.titleLabel.font = [UIFont systemFontOfSize:16];
    signBtnRank.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signBtnRank.frame = CGRectMake(0, bjviewSuccessheight-60-kSafeAreaBottomHeight, mDeviceWidth, 20);
//    [signBtnRank mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bjView.mas_bottom).offset(-60);
//        make.centerX.equalTo(self.bjView.mas_centerX);
//        make.height.mas_equalTo(20);
//    }];
    
    
    UIButton * shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bjView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnPushView) forControlEvents:(UIControlEventTouchUpInside)];
    [shareBtn setImage:[UIImage imageNamed:@"starbucks_signShare"] forState:(UIControlStateNormal)];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView.mas_top).offset(20);
        make.right.equalTo(self.bjView.mas_right).offset(-21);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(21);
    }];

    
    
}


-(void)signBtnRankPushView {

}


-(void)shareBtnPushView {
    NSLog(@"分享按钮");
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 调整位置
        self.bjView.frame=CGRectMake(0, mDeviceHeight -bjviewShareheight-kSafeAreaBottomHeight,mDeviceWidth, bjviewShareheight+kSafeAreaBottomHeight);
    } completion:^(BOOL finished) {
        [self.bjView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self addShareNewView];
    }];
}

-(void)addShareNewView {
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.text      = NSLocalizedString(@"Share the data to partners via", @"");
    titleLable.textColor = mHexRGB(0x999999);
    titleLable.font      = [UIFont systemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.bjView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bjView.mas_top).offset(21);
        make.centerX.equalTo(self.bjView.mas_centerX);
    }];
    
    YLButton * Snsbutton = [YLButton buttonWithType:(UIButtonTypeCustom)];
    [Snsbutton setImage:[UIImage imageNamed:@"starbucks_shareSns"] forState:(UIControlStateNormal)];
    [Snsbutton setTitle:@"Feeds" forState:(UIControlStateNormal)];
    Snsbutton.titleRect = CGRectMake(0, 24+18, mDeviceWidth/2, 17);
    Snsbutton.imageRect = CGRectMake((mDeviceWidth/2)/2-15, 0, 29, 24);
    Snsbutton.frame     = CGRectMake(0, bjviewShareheight-98, mDeviceWidth/2, 59);
    [Snsbutton addTarget:self action:@selector(snsSharePushView) forControlEvents:(UIControlEventTouchUpInside)];
    Snsbutton.titleLabel.font = [UIFont systemFontOfSize:12];
    Snsbutton.titleLabel.textAlignment =  NSTextAlignmentCenter;
    [Snsbutton setTitleColor:mHexRGB(0x666666) forState:(UIControlStateNormal)];
    
    [self.bjView addSubview:Snsbutton];
//    [Snsbutton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bjView.mas_left);
//        make.bottom.equalTo(self.bjView.mas_bottom).offset(-39);
//        make.width.mas_equalTo(mDeviceWidth/2);
//        make.height.mas_equalTo(59);
//    }];
    
    YLButton * chatbutton = [YLButton buttonWithType:(UIButtonTypeCustom)];
    [chatbutton setImage:[UIImage imageNamed:@"starbucks_shareChat"] forState:(UIControlStateNormal)];
    [chatbutton addTarget:self action:@selector(chatSharePushView) forControlEvents:(UIControlEventTouchUpInside)];
    [chatbutton setTitle:@"Chats" forState:(UIControlStateNormal)];
    chatbutton.titleLabel.font = [UIFont systemFontOfSize:12];
    chatbutton.titleRect = CGRectMake(0, 26+17, mDeviceWidth/2, 15);
    chatbutton.imageRect = CGRectMake((mDeviceWidth/2)/2-13, 0, 26, 26);
    chatbutton.frame      = CGRectMake(mDeviceWidth/2, bjviewShareheight-98, mDeviceWidth/2, 59);
    [chatbutton setTitleColor:mHexRGB(0x666666) forState:(UIControlStateNormal)];
    chatbutton.titleLabel.textAlignment =  NSTextAlignmentCenter;
    chatbutton.titleLabel.textAlignment =  NSTextAlignmentCenter;
    [self.bjView addSubview:chatbutton];
//    [chatbutton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.bjView.mas_right);
//        make.bottom.equalTo(self.bjView.mas_bottom).offset(-39);
//        make.width.mas_equalTo(mDeviceWidth/2);
//        make.height.mas_equalTo(59);
//    }];
}

// 分享信息流
-(void)snsSharePushView {
    NSLog(@"信息流");
}

// 分享悦信
-(void)chatSharePushView {
    NSLog(@"悦信");
}



@end
