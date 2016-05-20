//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "otherViewController.h"
#import "LeftComplieLoginView.h"
#import "LeftSlideloginView.h"

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) UIImageView *headImgView;

//    登录前的View
@property (retain, nonatomic) LeftSlideloginView *comSlideLoginView;
//  登陆后
@property (retain, nonatomic) LeftComplieLoginView *complieLView ;
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    self.view.backgroundColor = [UIColor blackColor];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-kMainPageDistance, 180)];
    headView.tag = 1111;
    [self.view addSubview:headView];
    [self getHeadView:headView];
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = CGRectMake(0, 0, 0, 0);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.tableview.backgroundColor = [UIColor redColor];
//    self.tableview.scrollEnabled=NO;//根据需要是否需要滑动
}

-(UIView*)getHeadView:(UIView*)view{
    
    int x=kScreenWidth-kMainPageDistance-128/2;
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x/2, 76/2-15, 128/2, 128/2)];
    NSLog(@"rect is %@",NSStringFromCGRect(_headImgView.frame));
    //    设置圆角
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = self.headImgView.bounds.size.width*0.5;
    self.headImgView.layer.borderWidth = 2;
    self.headImgView.tag=1234;
    self.headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImgView.image = [UIImage imageNamed:@"Head"];
    [view addSubview:_headImgView];
    
    self.complieLView = [[LeftComplieLoginView alloc] initWithFrame:CGRectMake(0, _headImgView.frame.origin.y + _headImgView.frame.size.height, x, 85/2)];
    [view addSubview:self.complieLView];
    //    隐藏
    //    登录前的View
    _comSlideLoginView = [[LeftSlideloginView alloc]initWithFrame:CGRectMake(0, _headImgView.frame.origin.y + _headImgView.frame.size.height, kScreenWidth-kMainPageDistance, 108/2)];
    [view addSubview:_comSlideLoginView];
    self.comSlideLoginView.hidden = YES;
    _comSlideLoginView.backgroundColor=[UIColor clearColor];
    //    登录前的按钮点击事件触发
    _comSlideLoginView.btBlock = ^(UIButton *button){
        switch (button.tag) {
                //                登录按钮
            case 10001:
            {
                
                break;
            }
                //                注册按钮
            case 10002:{
                
                
            }
                break;
            default:
                break;
        }
        
    };
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"我的文件";
    }else
    {
        cell.textLabel.text = @"我的文件";;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    otherViewController *vc = [[otherViewController alloc] init];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.scrollEnabled){
        return 0;
    }
    return 170;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 170)];

    
    //    view.backgroundColor = [UIColor redColor];
    return [self getHeadView:view];
}

@end
