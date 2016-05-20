//
//  LeftSlideloginView.m
//  EatAtHome
//
//  Created by maobo on 15/4/29.
//  Copyright (c) 2015年 hxd. All rights reserved.
//

#import "LeftSlideloginView.h"

@implementation LeftSlideloginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    
    self  = [super initWithFrame:frame];
    if (self) {
        
        //    欢迎您，马上登录
        UILabel * _loginLable = [[UILabel alloc] init];
        _loginLable.textColor = [UIColor whiteColor];
        _loginLable.frame = CGRectMake(0, 0, self.frame.size.width, 23);
        _loginLable.textAlignment = NSTextAlignmentCenter;
        _loginLable.text = @"欢迎您，马上登录";
        _loginLable.font = [UIFont systemFontOfSize:14];
        _loginLable.textColor = [UIColor whiteColor];
        //    _usernameLable.backgroundColor = [UIColor redColor];
        [self addSubview:_loginLable];
        
//        登录
        UIButton *loginBt = [UIButton buttonWithType: UIButtonTypeSystem];
        
        //        边框
        loginBt.layer.borderColor = [UIColor whiteColor].CGColor;
        loginBt.layer.borderWidth = 0.5;
        loginBt.frame = CGRectMake(20, 27, 153/2, 22);
        [loginBt setTitle:@"登陆" forState:UIControlStateNormal];
        [loginBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBt.titleLabel.font  = [UIFont systemFontOfSize:13];
//        [loginBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

//        tag值
        loginBt.tag = 10001;
        [loginBt addTarget:self action:@selector(ButtonClik:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginBt];
        
//        注册
        UIButton *registerBt = [UIButton buttonWithType: UIButtonTypeSystem];
        registerBt.layer.borderColor = [UIColor whiteColor].CGColor;
        registerBt.layer.borderWidth = 0.5;
        registerBt.frame = CGRectMake(148/2 + 50 , 27, 153/2, 22);
        [registerBt setTitle:@"注册" forState:UIControlStateNormal];
         [registerBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        registerBt.titleLabel.font  = [UIFont systemFontOfSize:13];
//        [registerBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        //        tag值
        registerBt.tag = 10002;
        [registerBt addTarget:self action:@selector(ButtonClik:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registerBt];
        
        
    }
    return self;
}

-(void)ButtonClik:(UIButton *)button{
    
    self.btBlock(button);

}

@end
