//
//  ViewController.m
//  WJTimeCircleDemo
//
//  Created by 吴计强 on 16/5/31.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//

#import "ViewController.h"
#import "WJTimeCircle.h"

@interface ViewController ()

@property (nonatomic,strong)WJTimeCircle *timeCircle;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger second;

@end

@implementation ViewController


- (WJTimeCircle *)timeCircle{
    if (_timeCircle == nil) {
        _timeCircle = [[WJTimeCircle alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 185 + 17.5, 100+17.5, 50, 50)];
        _timeCircle.arcFinishColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        _timeCircle.arcUnfinishColor = [UIColor greenColor];
        _timeCircle.arcBackColor = [UIColor whiteColor];
        _timeCircle.baseColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        _timeCircle.width = 3;
        _timeCircle.totalSecond = 2 * 60;
        _timeCircle.isStartDisplay = YES;
        [self.view addSubview:_timeCircle];
    }
    return _timeCircle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.second = 2 * 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAnim) userInfo:nil repeats:YES];
    
}

- (void)timeAnim{
    self.second --;
    self.timeCircle.second = self.second;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
