//
//  LJLDefaultCardView.m
//  LJLAnimationCard
//
//  Created by 1111 on 2017/8/27.
//  Copyright © 2017年 ljl. All rights reserved.
//

#import "LJLDefaultCardView.h"

@implementation LJLDefaultCardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}
- (IBAction)buttonClicked:(UIButton *)sender {
    
  
            
            NSLog(@"cell中点击按钮的回调%ld",sender.tag);
            [self.delegate defaultCardViewSubViewClikedAtIndex:sender.tag];
    
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDisplayData:(id)data
{
    _VideoImae.image = [UIImage imageNamed:data];
    //这里数据源
    
}
@end
