//
//  LJLCardAnimationView.m
//  LJLAnimationCard
//
//  Created by 1111 on 2017/8/27.
//  Copyright © 2017年 ljl. All rights reserved.
//

#import "LJLCardAnimationView.h"
#import "LJLDefaultCardView.h"


@interface LJLCardAnimationView ()<LJLDefaultCardDelegate>

@property (strong, nonatomic) UIView*frontView;//当前第一个view

@property (nonatomic, strong) UIView*queryView;//队列中的view


@property (nonatomic, strong) NSMutableArray*showViews;//所有在视图中的view

@property (nonatomic, assign) NSInteger currentCount;//当被推出的视图数量

@property (nonatomic, assign) NSInteger maxCount;//最大可被推出的视图量

@property (nonatomic, assign) NSInteger showCount;//视图中显示的视图数量

@property (nonatomic, assign) CGPoint tagetCenter;//当前第一个view的center

@property (nonatomic, assign) CGPoint queryViewCenter;//队列中view的center


@property (nonatomic, assign) CGPoint preferCenter;//本视图的中心点

@end

static CGFloat viewGaps = 15.0;

static CGFloat viewScale = 0.04;


@implementation LJLCardAnimationView



-(id)initWithFrame:(CGRect)frame andShowCardCount:(NSInteger)showCount andMaxCardCount:(NSInteger)maxCount andDataSource:(id)dataSource{
    
    
    if (self=[super initWithFrame:frame]) {
        
        self.preferCenter = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        
        self.currentCount = 0;
        
        self.maxCount = maxCount;
        
        self.showCount = showCount;
        
        
        self.dataSource = dataSource;
        for (int i = 0; i<showCount+1; i++) {
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _preferCenter.x*2, _preferCenter.y*2)];
            
            view.center = CGPointMake(_preferCenter.x, _preferCenter.y + i*viewGaps);
            
            
            view.transform = CGAffineTransformMakeScale(1-i*viewScale, 1-i*viewScale);
            
            view.backgroundColor = [UIColor whiteColor];
            
            view.layer.borderColor = [UIColor colorWithRed:223.0/255 green:224.0/255 blue:225.0/255 alpha:1].CGColor;
            
            view.layer.borderWidth = 1;
            //影印颜色
            view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            //阴影透明度，默认0
            view.layer.shadowOpacity = 0.6;
            //四周影印面积
            view.layer.shadowOffset = CGSizeMake(0, 1);
            
            
            
            if (i<showCount) {
                
                for (LJLDefaultCardView*defaultView in [self defaultCardViewSubViews]) {
                    
                    
                    [defaultView setDisplayData:[self.dataSource cardViewDisplayDataForCardViewAtIndex:i]];
                    
                    
                    defaultView.tag = 1990;//设置一个tag值，方便找到它
                    [view addSubview:defaultView];
                    
                }
                
            }else{
                
                for (LJLDefaultCardView*defaultView in [self defaultCardViewSubViews]) {
                    
                    defaultView.tag = 1990;//设置一个tag值，方便找到它
                    
                    [view addSubview:defaultView];
                    
                }
                
            }
            
            
            
            
            if (i<showCount) {
                
                [self.showViews addObject:view];
                
                [self addSubview:view];
                
                [self sendSubviewToBack:view];
                
            }else{
                
                self.queryView = view;
                
            }
            
        }
        self.frontView = self.showViews[0];
        self.tagetCenter = self.frontView.center;
        
    }
    return self;
    
}
#pragma ------------LJLDefaultCardView代理
-(void)defaultCardViewSubViewClikedAtIndex:(NSInteger)index{
    
    
    [self.delegate cardViewClickCardAtIndex:(self.currentCount+self.showCount)%self.maxCount];
    
    CGPoint center = self.frontView.center;
    
    center.x = -CGRectGetWidth(self.frontView.frame)/2-CGRectGetWidth(self.frame)/2;
    
    __weak __typeof (self)weakSelf = self;
    
    //这边是将花出去的view中心点-320，然后将其他四个view的cent.y迁移，
    [UIView animateWithDuration:0.7 animations:^{
        
        weakSelf.frontView.center = center;
        
        for (NSInteger i = 1; i<self.showViews.count; i++) {
            
            UIView*view = self.showViews[i];
            
            if (view != weakSelf.frontView) {
                
                CGPoint center = view.center;
                
                center.y -= viewGaps;
                
                view.center = center;
                
                view.transform = CGAffineTransformMakeScale(1.0-(i-1)*viewScale,1.0-(i-1)*viewScale);
                
            }
            
        }
        
        
    }completion:^(BOOL finished) {
        //动画结束的逻辑（将第一个view从数组中去掉，删除第一个view中的控件，将队列view添加到数组中）
        [weakSelf.frontView removeFromSuperview];
        
        [weakSelf.showViews removeObjectAtIndex:0];
        
        
        
        [weakSelf.showViews addObject:weakSelf.quryView];
        
        
        //更新即将进入页面的上一张卡片的展示数据
        LJLDefaultCardView*defaultView = nil;
        
        for (UIView*subView in [self.queryView subviews]) {
            
            if (subView.tag == 1990) {
                
                defaultView = (LJLDefaultCardView*)subView;
                
                break;
                
            }
            
        }
        
        [defaultView setDisplayData:[self.dataSource cardViewDisplayDataForCardViewAtIndex:(self.currentCount+self.showCount)%self.maxCount]];
        
        
        //更换队列中的卡片视图
        [weakSelf addSubview:weakSelf.quryView];
        
        [weakSelf sendSubviewToBack:weakSelf.quryView];
        
        weakSelf.queryView = weakSelf.frontView;
        
        weakSelf.frontView = weakSelf.showViews[0];
        
        weakSelf.tagetCenter = weakSelf.frontView.center;
        
        weakSelf.currentCount ++;
        
    }];
    
    
    
}

#pragma -----------懒加载
-(NSArray*)defaultCardViewSubViews
{
    
    LJLDefaultCardView*defaultView = [[[NSBundle mainBundle] loadNibNamed:@"LJLDefaultCardView" owner:nil options:nil] firstObject];
    
    defaultView.frame = CGRectMake(0, 0, self.preferCenter.x*2, self.preferCenter.y*2);
    
    defaultView.delegate = self;
    
    return @[defaultView];
    
}


-(UIView*)quryView
{
    
    if (_queryView) {
        
        
    _queryView.center = CGPointMake(_preferCenter.x, _preferCenter.y + (self.showCount-1)*viewGaps);
        
        _queryView.transform = CGAffineTransformMakeScale(1-(self.showCount-1)*viewScale, 1-(self.showCount-1)*viewScale);
        
        
    }
    
    return _queryView;
    
}
-(NSMutableArray*)showViews
{
    
    if (!_showViews) {
        
        _showViews = [NSMutableArray new];
        
    }
    
    return _showViews;
    
}


@end
