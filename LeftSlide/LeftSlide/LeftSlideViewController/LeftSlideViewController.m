//
//  LeftSlideViewController.m
//  LeftSlideViewController
//
//  Created by huangzhenyu on 15/06/18.
//  Copyright (c) 2015年 huangzhenyu. All rights reserved.

#import "LeftSlideViewController.h"
#import "LeftComplieLoginView.h"
#import "LeftSlideloginView.h"


@interface LeftSlideViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat _scalef;  //实时横向位移
    CGFloat tableHeight;
    CGFloat removeHeight;
    CGFloat headHeightCenter;
    CGFloat headHeight;
    
}

@property (nonatomic,strong) UITableView *leftTableview;
@property (nonatomic,assign) CGFloat leftTableviewW;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIImageView* headImgView;//头像和登陆前或登录后的view分开的下面屏蔽的代码，自己需要可以试试
@property (nonatomic,strong) UIView* headView;//顶部一整个的view

//    登录前的View
@property (retain, nonatomic) LeftSlideloginView *comSlideLoginView;
//  登陆后
@property (retain, nonatomic) LeftComplieLoginView *complieLView ;
@end


@implementation LeftSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 @brief 初始化侧滑控制器
 @param leftVC 左视图控制器
 mainVC 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC
{
    if(self = [super init]){
        self.speedf = vSpeedFloat;
        
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        //滑动手势
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self.mainVC.view addGestureRecognizer:self.pan];
        
        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
        
        self.leftVC.view.hidden = YES;
        
        [self.view addSubview:self.leftVC.view];
        
        //蒙版
        UIView *view = [[UIView alloc] init];
        view.frame = self.leftVC.view.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        self.contentView = view;
        [self.leftVC.view addSubview:view];
        
        //获取左侧tableview
        for (UIView *obj in self.leftVC.view.subviews) {
            if ([obj isKindOfClass:[UITableView class]]) {
                self.leftTableview = (UITableView *)obj;
            }
            if ([obj isKindOfClass:[LeftSlideloginView class]]) {
                self.comSlideLoginView = (LeftSlideloginView *)obj;
            }
            if ([obj isKindOfClass:[LeftComplieLoginView class]]) {
                self.complieLView = (LeftComplieLoginView *)obj;
            }
            if ([obj isKindOfClass:[UIImageView class]]) {
                self.headImgView = (UIImageView *)[obj viewWithTag:1234];
            }
            if ([obj isKindOfClass:[UIView class]]) {
                if (self.headView == nil) {
                    self.headView = [obj viewWithTag:1111];
                }
                
            }
        }
     

        self.leftTableview.backgroundColor = [UIColor clearColor];
        tableHeight = kScreenHeight - BottomHeight - TopHeight;//tableview 的高度
        removeHeight = (kScreenHeight - BottomHeight - tableHeight) + tableHeight/2.0;
        
        self.leftTableview.frame = CGRectMake(0, 0, kScreenWidth - kMainPageDistance, tableHeight);
        //self.leftTableview.frame = CGRectMake(0, 0, 200, 260);
        //设置左侧tableview的初始位置和缩放系数
        self.leftTableview.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        self.leftTableview.center = CGPointMake(kLeftCenterX, removeHeight);
        int x=kScreenWidth - kMainPageDistance;
        
        
        
        //增加顶部的侧滑效果 上下2个代码只能打开一个
        headHeightCenter = _headView.frame.size.height/2.0 + _headView.frame.origin.y;
        headHeight = _headView.frame.size.height;
        _headView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
       // _headView.backgroundColor = [UIColor redColor];
        CGFloat center = headHeightCenter + (1-kLeftScale)*tableHeight/2.0;
        _headView.center = CGPointMake(kLeftCenterX, center);
        
        //增加顶部的侧滑效果
        /*
        NSLog(@"CGRectGetMaxY(_headImgView.frame)=%f",_headImgView.frame.origin.y + _headImgView.frame.size.height);
        headHeightCenter = _headImgView.frame.size.height/2.0 + _headImgView.frame.origin.y;
        headHeight = _headImgView.frame.size.height;
        _headImgView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        CGFloat center = headHeightCenter + (1-kLeftScale)*tableHeight/2.0;
        
        _headImgView.center = CGPointMake(kLeftCenterX, center);
        
        _complieLView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        _complieLView.center = CGPointMake(_complieLView.centerX, _headImgView.height+_headImgView.y+_complieLView.height/2);
        
        _comSlideLoginView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        _comSlideLoginView.center = CGPointMake(_comSlideLoginView.centerX, _headImgView.height+_headImgView.y+_comSlideLoginView.height/2);
         */
        

        
        [self.view addSubview:self.mainVC.view];
        self.closed = YES;//初始时侧滑窗关闭
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftVC.view.hidden = NO;
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    _scalef = (point.x * self.speedf + _scalef);

    BOOL needMoveWithTap = YES;  //是否还需要跟随手指移动
    if (((self.mainVC.view.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.x >= (kScreenWidth - kMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (rec.view.frame.origin.x >= 0) && (rec.view.frame.origin.x <= (kScreenWidth - kMainPageDistance)))
    {
        CGFloat recCenterX = rec.view.center.x + point.x * self.speedf;
        if (recCenterX < kScreenWidth * 0.5 - 2) {
            recCenterX = kScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = rec.view.center.y;
        
        rec.view.center = CGPointMake(recCenterX,recCenterY);

        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - kMainPageScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
    
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));

        NSLog(@"%f",leftTabCenterX);
        
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        self.leftTableview.center = CGPointMake(leftTabCenterX, removeHeight);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        
        CGFloat centerY = headHeightCenter +(1-leftScale)*tableHeight/2.0 +(1-leftScale)*headHeight/2.0;
        _headView.center = CGPointMake(leftTabCenterX, centerY);
        self.headView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        /*
        //self.headImgView.center = CGPointMake(leftTabCenterX, _headImgView.height/2+_headImgView.y);
        NSLog(@"self.leftTableViewHeith = %f",self.leftTableview.frame.size.height);
        CGFloat centerY = headHeightCenter +(1-leftScale)*tableHeight/2.0 + (1-leftScale)*headHeight;
        _headImgView.center = CGPointMake(leftTabCenterX, centerY);
        self.headImgView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        self.complieLView.center = CGPointMake(leftTabCenterX, _headImgView.height+_headImgView.y+_complieLView.height/2);
        self.complieLView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        self.comSlideLoginView.center = CGPointMake(leftTabCenterX,_headImgView.height+_headImgView.y+_comSlideLoginView.height/2);
        self.comSlideLoginView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
         */


        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.contentView.alpha = tempAlpha;

    }
    else
    {
        //超出范围，
        if (self.mainVC.view.x < 0)
        {
            [self closeLeftView];
            _scalef = 0;
        }
        else if (self.mainVC.view.x > (kScreenWidth - kMainPageDistance))
        {
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.closed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self.closed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        self.closed = YES;
        
        self.leftTableview.center = CGPointMake(kLeftCenterX, removeHeight);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        
        CGFloat centerY = headHeightCenter +(1-kLeftScale)*tableHeight/2.0;
        _headView.center = CGPointMake(kLeftCenterX, centerY);
        self.headView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        
        /*
        //self.headImgView.center = CGPointMake(kLeftCenterX, _headImgView.height/2+_headImgView.y);
        CGFloat centerY = headHeightCenter +(1-kLeftScale)*tableHeight/2.0;
        _headImgView.center = CGPointMake(kLeftCenterX, centerY);
        self.headImgView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        self.complieLView.center = CGPointMake(kLeftCenterX,  _headImgView.height+_headImgView.y+_complieLView.height/2);
        self.complieLView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);;
        self.comSlideLoginView.center = CGPointMake(kLeftCenterX, _headImgView.height+_headImgView.y+_comSlideLoginView.height/2);
        self.comSlideLoginView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
         */

        self.contentView.alpha = kLeftAlpha;
        
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVC.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self.closed = YES;
    
    self.leftTableview.center = CGPointMake(kLeftCenterX, removeHeight);
    self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
    
    CGFloat centerY = headHeightCenter +(1-kLeftScale)*tableHeight/2.0;
    _headView.center = CGPointMake(kLeftCenterX, centerY);
    self.headView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
    /*
    //self.headImgView.center = CGPointMake(kLeftCenterX, _headImgView.height/2+_headImgView.y);
    CGFloat centerY = headHeightCenter +(1-kLeftScale)*tableHeight/2.0;
    _headImgView.center = CGPointMake(kLeftCenterX, centerY);
    self.headImgView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
    self.complieLView.center = CGPointMake(kLeftCenterX, _headImgView.height+_headImgView.y+_complieLView.height/2);
    self.complieLView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);;
    self.comSlideLoginView.center = CGPointMake(kLeftCenterX, _headImgView.height+_headImgView.y+_comSlideLoginView.height/2);
    self.comSlideLoginView.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
     */

    self.contentView.alpha = kLeftAlpha;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,kMainPageScale,kMainPageScale);
    self.mainVC.view.center = kMainPageCenter;
    self.closed = NO;
    
    self.leftTableview.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, removeHeight);
    self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    CGFloat centerY = headHeightCenter +(1-1)*tableHeight/2.0;
    _headView.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, centerY);
    self.headView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);

    /*
    //self.headImgView.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, _headImgView.height/2+_headImgView.y);
    CGFloat centerY = headHeightCenter +(1-1)*tableHeight/2.0;
    _headImgView.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, centerY);
    self.headImgView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.complieLView.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5,  _headImgView.height+_headImgView.y+_complieLView.height/2);
    self.complieLView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.comSlideLoginView.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5,  _headImgView.height+_headImgView.y+_comSlideLoginView.height/2);
    self.comSlideLoginView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
     */
    
    

    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}

#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [_mainVC.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.mainVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */

- (void)setPanEnabled: (BOOL) enabled
{
    [self.pan setEnabled:enabled];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(touch.view.tag == vDeckCanNotPanViewTag)
    {
//        NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
//        NSLog(@"响应侧滑");
        return YES;
    }
}

@end
