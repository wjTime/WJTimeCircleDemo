//
//  WJTimeCircle.h
//  WJTimeCircleDemo
//
//  Created by wenjie on 16/5/31.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJTimeCircle : UIView

/** ----中心颜色----  */
@property (strong, nonatomic)UIColor *centerColor;

/** ----圆环背景色--- */
@property (strong, nonatomic)UIColor *arcBackColor;

/** ----完成时圆环色---- */
@property (strong, nonatomic)UIColor *arcFinishColor;

/** ----未完成圆环色---- */
@property (strong, nonatomic)UIColor *arcUnfinishColor;

/** ----圆环最初的颜色---- */
@property (strong, nonatomic)UIColor *baseColor;

/** ----开始刷新---- */
@property (nonatomic,assign)BOOL isStartDisplay;

/** ----百分比数值（0-1）---- */
@property (assign, nonatomic)float percent;

/** ----秒数----- */
@property (assign, nonatomic)NSTimeInterval second;

/** ----总秒数----- */
@property (assign, nonatomic)NSTimeInterval totalSecond;

/** ----圆环宽度---- */
@property (assign, nonatomic)float width;


@end
