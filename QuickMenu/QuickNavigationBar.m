//
//  QuickNavigationBar.m
//  QuickMenu
//
//  Created by Marlon on 16/1/28.
//  Copyright © 2016年 superman. All rights reserved.
//

/*
 这个类是一个快速导航菜单栏，用来显示进入的层级和路径深度
 
 封装这个类需要知道导航按钮的个数，按钮的标题
 
 */


#import <UIKit/UIKit.h>
#import "QuickNavigationBar.h"

#define QUICK_NAVIGATIONBAR_HEIGHT 30
#define QUICK_NAVIGATIONBAR_WEIGHT 300

@interface QuickNavigationBar()
//@property(nonatomic,strong)

{

    UIScrollView * menuScrollView;
    
//    NSMutableArray *menuBtnTitles;//标题按钮
    
}
@end

@implementation QuickNavigationBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.menuBtnTitles = [NSMutableArray arrayWithObjects:@"联系人", nil];
        
        menuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        menuScrollView.backgroundColor = [UIColor colorWithRed:0.9989 green:0.99 blue:0.9753 alpha:1.0];
        menuScrollView.showsVerticalScrollIndicator = NO;
        menuScrollView.showsHorizontalScrollIndicator = NO;
        menuScrollView.alwaysBounceVertical = NO;
        
        
        
        [self addSubview:menuScrollView];

        
        
        [self setUpSubview];

    }
    return self;
}

- (void)setUpSubview{
    
    CGFloat btnOffsetX = 0;
    
    for (int i = 0; i<self.menuBtnTitles.count; i++) {
        
        NSString *btnTitle = self.menuBtnTitles[i]; //按钮字体
        
        CGFloat btnWidth = [self getTitleWidthWith:btnTitle andFond:[UIFont systemFontOfSize:15]] + 30;//字体宽度
        
    //创建小标题按钮
        UIButton *btn       = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame           = CGRectMake(btnOffsetX, 0, btnWidth, 30);
        btn.tag             = 101 + i;
        
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        //设置图片箭头的偏移量
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, btnWidth-5, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        btn.backgroundColor = [UIColor colorWithRed:0.9768 green:1.0 blue:0.6564 alpha:1.0];
        [btn setTitleColor:[UIColor colorWithRed:0.2658 green:0.6492 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];

        btnOffsetX         += btnWidth;//加上新增按钮的长度
        [menuScrollView setContentSize:CGSizeMake(btnOffsetX, 30)];
        [menuScrollView addSubview:btn];
        
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == self.menuBtnTitles.count - 1) {
            
            [btn setEnabled:NO]; //最后一级标题设为不可点击
            [btn setTitleColor: [UIColor grayColor] forState:UIControlStateDisabled];

//            btn.imageView.image = nil;
            [btn setImage:nil forState:UIControlStateNormal];
        }
    }
    
    //设置偏移量到当前层级
    CGFloat deviceW = [UIScreen mainScreen].bounds.size.width;
    
    if (btnOffsetX > deviceW) {
        
        menuScrollView.contentOffset = CGPointMake(btnOffsetX - deviceW , 0);
    }
}

- (void)btnPressed:(UIButton *)button{

    
    if ([self.delegate respondsToSelector:@selector(didClickButton:)] && self.delegate ) {
        
        [self.delegate didClickButton:button.tag-100];
        
    }
    
}

//增加一个层级
- (void)addSubPath:(NSString *)pathTitle{
    
    [self.menuBtnTitles addObject:pathTitle];
    
    [self setUpSubview];

}

//回退一级
- (void)rollBack{
    
    [self.menuBtnTitles removeLastObject];//删除最后一个标题
    
    [self setUpSubview];
}

//回退到某特定层级
- (void)rollBackInCertainVCWithIndex:(NSInteger)index{

    NSInteger Sum = self.menuBtnTitles.count;
    
    [self.menuBtnTitles removeObjectsInRange:NSMakeRange(1, 2)];
    
}



//新方法计算文字宽度

- (CGFloat)getTitleWidthWith:(NSString *)title andFond:(UIFont *)fond{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:fond forKey:NSFontAttributeName];
    
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.width;
    
}
//老方法计算文字宽度
- (CGFloat)getTitleLengthWith:(NSString*)title andFond:(UIFont *)fond{
    
    
    CGSize size = [title sizeWithFont:fond constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
    return size.width;
    
}
//****************辅助方法*******************



//
//CGSize sizeName = [strText sizeWithFont:theFont
//                      constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
//                          lineBreakMode:NSLineBreakByWordWrapping];
//
//
//2.计算文本的高度
//
//CGSize sizeName = [strText sizeWithFont:theFont
//                      constrainedToSize:CGSizeMake(100.0, MAXFLOAT)
//                          lineBreakMode:NSLineBreakByWordWrapping];


@end
