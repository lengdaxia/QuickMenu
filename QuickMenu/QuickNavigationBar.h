//
//  QuickNavigationBar.h
//  QuickMenu
//
//  Created by Marlon on 16/1/28.
//  Copyright © 2016年 superman. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol QuickNavigationBarDelegate <NSObject>

- (void)didClickButton:(NSInteger )index;

@end
@interface QuickNavigationBar : UIView

@property (nonatomic ,strong) NSMutableArray *menuBtnTitles;

@property (nonatomic,weak) id<QuickNavigationBarDelegate> delegate;


//增加一个层级
- (void)addSubPath:(NSString *)pathTitle;

//回退一级
- (void)rollBack;

//回退到某特定层级
- (void)rollBackInCertainVCWithIndex:(NSInteger)index;

//刷新
- (void)setUpSubview;



@end
