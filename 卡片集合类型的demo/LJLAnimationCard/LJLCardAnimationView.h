//
//  LJLCardAnimationView.h
//  LJLAnimationCard
//
//  Created by 1111 on 2017/8/27.
//  Copyright © 2017年 ljl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJLCardViewDataSource <NSObject>
/**
 设置某张卡片视图上的子视图（如果return空，则会加载默认的视图，如果return空数组，则仅加载卡片）
 **/
@optional
-(NSArray*)cardViewSubViewsForCardViewAtIndex:(NSInteger)index;

/**
 默认卡片视图上加载的数据源
 **/
@optional
-(id)cardViewDisplayDataForCardViewAtIndex:(NSInteger)index;

@end



@protocol LJLCardViewDelegate <NSObject>
/**
 某张卡片被点击
 **/
@optional
-(void)cardViewClickCardAtIndex:(NSInteger)index;

@end


@interface LJLCardAnimationView : UIView

@property (nonatomic, weak)id<LJLCardViewDataSource>dataSource;
@property (nonatomic, weak)id<LJLCardViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame andShowCardCount:(NSInteger)showCount andMaxCardCount:(NSInteger)maxCount andDataSource:(id)dataSource;




@end
