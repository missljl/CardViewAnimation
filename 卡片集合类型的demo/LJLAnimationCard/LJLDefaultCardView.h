//
//  LJLDefaultCardView.h
//  LJLAnimationCard
//
//  Created by 1111 on 2017/8/27.
//  Copyright © 2017年 ljl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LJLDefaultCardDelegate <NSObject>

-(void)defaultCardViewSubViewClikedAtIndex:(NSInteger)index;

@end
@interface LJLDefaultCardView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameLable;
@property (weak, nonatomic) IBOutlet UIButton *CollectionButton;
@property (weak, nonatomic) IBOutlet UIImageView *VideoImae;


@property (nonatomic, weak) id<LJLDefaultCardDelegate>delegate;

-(void)setDisplayData:(id)data;


@end
