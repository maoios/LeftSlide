//
//  LeftComplieLoginView.m
//  EatAtHome
//
//  Created by maobo on 15/4/29.
//  Copyright (c) 2015年 hxd. All rights reserved.
//

#import "LeftComplieLoginView.h"
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

@implementation LeftComplieLoginView

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
        
        
        //    用户名
//        _usernameLable = [[UILabel alloc] initWithFrame:CGRectMake(224/2 - 158/2 , 0, 128 /2 , 27)];
        CGFloat w = frame.size.width;
        _usernameLable = [[UILabel alloc] initWithFrame:CGRectMake(50 , 10, w-100 , 27)];
        _usernameLable.textAlignment = NSTextAlignmentCenter;
        _usernameLable.textColor = [UIColor blackColor];
        _usernameLable.text = @"用户名";
        //    _usernameLable.backgroundColor = [UIColor redColor];
        [self addSubview:_usernameLable];
        
        //    关注
        
        _gzLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _usernameLable.frame.origin.y + _usernameLable.frame.size.height , 140/2, 25)];
        _gzLabel.text = @"关注：23";
        _gzLabel.textColor = [UIColor whiteColor];
        _gzLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_gzLabel];
        
        //    粉丝
        _fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                               _usernameLable.center.x+10,
                                                               _usernameLable.frame.origin.y + _usernameLable.frame.size.height,140/2 , 25)];
        _fansLabel.text = @"粉丝：54";

        //        颜色
        _fansLabel.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1];

        //        字体
        _fansLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_fansLabel];

    }
    
    return self;
    
}
@end
