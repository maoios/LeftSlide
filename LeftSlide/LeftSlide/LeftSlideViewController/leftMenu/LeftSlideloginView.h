//
//  LeftSlideloginView.h
//  EatAtHome
//
//  Created by maobo on 15/4/29.
//  Copyright (c) 2015年 hxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonBlock)(id);

@interface LeftSlideloginView : UIView

@property (copy, nonatomic) buttonBlock btBlock;
@end
