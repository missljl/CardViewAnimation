//
//  ViewController.m
//  LJLAnimationCard
//
//  Created by 1111 on 2017/8/27.
//  Copyright © 2017年 ljl. All rights reserved.
//

#import "ViewController.h"
#import "LJLCardAnimationView.h"
#import "FullViewController.h"
#import "FMGVideoPlayView.h"


@interface ViewController ()<LJLCardViewDataSource,LJLCardViewDelegate,UITableViewDelegate,UITableViewDataSource>

//播放器
@property (nonatomic, strong) FMGVideoPlayView * fmVideoPlayer;

@property (nonatomic, strong) UITableView *tableView;
//折叠视图
@property(nonatomic,strong)LJLCardAnimationView*cardView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ConforUItableView];
    
}


-(void)ConforUItableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}
-(LJLCardAnimationView *)cardView{
    if (!_cardView) {
        
        _cardView = [[LJLCardAnimationView alloc] initWithFrame:CGRectMake(5, 10, self.view.frame.size.width-10, 290) andShowCardCount:3 andMaxCardCount:100 andDataSource:self];
        _cardView.delegate =self;
    }
    
    return _cardView;
    
}
-(FMGVideoPlayView *)fmVideoPlayer{
    if (!_fmVideoPlayer) {
        
        self.fmVideoPlayer = [FMGVideoPlayView videoPlayView];// 创建播放器
        _fmVideoPlayer.frame = CGRectMake(0, 0, _cardView.frame.size.width, 260);
       
        _fmVideoPlayer.contrainerViewController = self;
        [_fmVideoPlayer setUrlString:@"http://flv1.bn.netease.com/videolib3/1708/28/NGgwe0251/SD/NGgwe0251-mobile.mp4"];
        
        if ([[UIDevice currentDevice]systemVersion].intValue>=10) {
            
            _fmVideoPlayer.player.automaticallyWaitsToMinimizeStalling=NO;
            
        }
        
      [_fmVideoPlayer.player play];
        [_fmVideoPlayer showToolView:YES];
        
    }
    
    return _fmVideoPlayer;
    
}

#pragma +++++_tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==5) {
        return 330;
        
    }else{
        
        return 200;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==5) {
        
        static  NSString *cellid =@"cell1";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell==nil) {
            
            
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        }
        //公司项目千万别像我这么写，
         [_fmVideoPlayer.player play];
        
        [cell addSubview:self.cardView];
        [self.cardView addSubview:self.fmVideoPlayer];
        
        return cell;
        
        
    }else{
        
        static  NSString *cellid =@"cell";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell==nil) {
            
            
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%d",arc4random() % 100];
        
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        
        
        return cell;
    }
    
    
    
}

//// 根据Cell位置隐藏并暂停播放(这个代理方法是消失的cell)
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 5){
        NSLog(@"播放器相关操作");
        [_fmVideoPlayer.player pause];
        
    }
    
}


#pragma ++++ LJLCardAnimationView  DataSource and Delegate

-(id)cardViewDisplayDataForCardViewAtIndex:(NSInteger)index
{
    
    NSArray *ar = @[@"9-160Q0161036-50.jpg",@"20120412123906588.jpg",@"20160810015.jpg",@"14434332_1350283583994.jpg",@"5458842fb3455.jpg",@"7875011481266122.jpg",@"51V58PICcYI_1024.jpg",@"61758PICWZY_1024.jpg",@"9-160Q0161036-50.jpg",@"20120412123906588.jpg",@"20160810015.jpg",@"14434332_1350283583994.jpg",@"5458842fb3455.jpg",@"7875011481266122.jpg",@"51V58PICcYI_1024.jpg",@"61758PICWZY_1024.jpg"];
    
    
    return ar[index];
    
    
}
-(void)cardViewClickCardAtIndex:(NSInteger)index{
    
    
    NSArray *videoar =@[@"http://flv1.bn.netease.com/videolib3/1708/28/NGgwe0251/SD/NGgwe0251-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/mBqGs1060/SD/mBqGs1060-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/WYKjx0420/SD/WYKjx0420-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/GsypJ1051/SD/GsypJ1051-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/cASrf0536/SD/cASrf0536-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/rFmiV0790/SD/rFmiV0790-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/EnTFb0693/SD/EnTFb0693-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/kLimd0512/SD/kLimd0512-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/SZVPy0306/SD/SZVPy0306-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/NGgwe0251/SD/NGgwe0251-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/mBqGs1060/SD/mBqGs1060-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/WYKjx0420/SD/WYKjx0420-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/GsypJ1051/SD/GsypJ1051-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/cASrf0536/SD/cASrf0536-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/rFmiV0790/SD/rFmiV0790-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/EnTFb0693/SD/EnTFb0693-mobile.mp4",@"http://flv3.bn.netease.com/videolib3/1708/28/kLimd0512/SD/kLimd0512-mobile.mp4",@"http://flv1.bn.netease.com/videolib3/1708/28/SZVPy0306/SD/SZVPy0306-mobile.mp4"];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _fmVideoPlayer.alpha = 0;
    }completion:^(BOOL finished) {
        _fmVideoPlayer.alpha=1;
    [_fmVideoPlayer setUrlString:videoar[index-2]];
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
