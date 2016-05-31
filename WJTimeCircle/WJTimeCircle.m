//
//  WJTimeCircle.m
//  WJTimeCircleDemo
//
//  Created by wenjie on 16/5/31.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//

#import "WJTimeCircle.h"

@interface WJTimeCircle ()

@property (nonatomic,assign)CGFloat downPercent;

@end

@implementation WJTimeCircle

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _downPercent = 0;
        _second = 0;
        _percent = 0;
        _width = 0;
    }
    return self;
}

- (void)setSecond:(NSTimeInterval)second{
    if (_isStartDisplay) {
        _second = second;
        _downPercent = _second/_totalSecond;
        [self setNeedsDisplay];
    }
}


- (void)setPercent:(float)percent{
    if (_isStartDisplay) {
        _percent = percent;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect{
    
    [self addArcBackColor];
    [self drawArc];
    [self addCenterLabel];
    
}

- (void)addArcBackColor{
    
    UIColor *color = (_arcBackColor == nil) ? [UIColor lightGrayColor] : _arcBackColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    CGFloat radius = viewSize.width / 2;
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapButt;
    processPath.lineWidth = viewSize.width;
    CGFloat startAngle = (float)(0.0f * M_PI);
    CGFloat endAngle = (float)(2.0f * M_PI);
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
    [color set];
    [processPath stroke];
}



- (void)drawArc{
    float width = (_width == 0) ? 5 : _width;
    if (_second <= 0) {
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        UIColor *color = (_arcFinishColor == nil) ? [UIColor greenColor] : _arcFinishColor;
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        CGFloat radius = viewSize.width / 2 - width/2;
        CGFloat startAngle = - M_PI_2;
        CGFloat endAngle = (2 * (float)M_PI - M_PI_2);
        UIBezierPath *processPath = [UIBezierPath bezierPath];
        processPath.lineCapStyle = kCGLineCapButt;
        processPath.lineWidth = width;
        [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
        [color set];
        [processPath stroke];
        return;
    }
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    float endAngle = - M_PI_2;
    UIColor *color = (_arcUnfinishColor == nil) ? [UIColor blueColor] : _arcUnfinishColor;
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);

    CGFloat radius = viewSize.width / 2 - width/2;
    CGFloat startAngle = 2*M_PI - M_PI_2 - 2*M_PI*_downPercent;
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapButt;
    processPath.lineWidth = width;
    
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
    [color set];
    [processPath stroke];
    
    UIColor *baseColor = (_baseColor == nil) ? [UIColor blueColor] : _baseColor;
    UIBezierPath *processPath2 = [UIBezierPath bezierPath];
    processPath2.lineCapStyle = kCGLineCapButt;
    processPath2.lineWidth = width;
    [processPath2 addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:NO];
    CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
    [baseColor set];
    [processPath2 stroke];
    
    
}


-(void)addCenterBack{
    float width = (_width == 0) ? 5 : _width;
    UIColor *color = (_centerColor == nil) ? [UIColor whiteColor] : _centerColor;
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2 - width/2;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = width;
    processBackgroundPath.lineCapStyle = kCGLineCapButt;
    CGFloat startAngle = - ((float)M_PI / 2);
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [color set];
    [processBackgroundPath stroke];
    
}

- (void)addCenterLabel{
    NSString *percent = @"";
    NSString *textPer = @"";
    float fontSize = 10;
    float textFontSize = 18;
    UIColor *arcColor = [UIColor blueColor];
    UIColor *textArcColor = [UIColor blueColor];
    textArcColor = (_arcUnfinishColor == nil) ? [UIColor blueColor] : _arcUnfinishColor;
    arcColor = [UIColor lightGrayColor];
    if (_second <= 0) {
        percent = @"0";
        textPer = @"秒";
    }else if(_second > 0.5){
        fontSize = 10;
        CGFloat tempPercent = _second;
        if (tempPercent >= 60 * 60 * 24) {
            percent = [NSString stringWithFormat:@"%.0f",tempPercent/(60 * 60 * 24)];
            textPer = @"天";
        }else if (tempPercent >= 60 * 60){
            percent = [NSString stringWithFormat:@"%.0f",tempPercent/(60 * 60)];
            textPer = @"小时";
        }else if (tempPercent >= 60 ){
            percent = [NSString stringWithFormat:@"%.0f",tempPercent/60];
            textPer = @"分";
        }else if (tempPercent >0){
            percent = [NSString stringWithFormat:@"%.0f",tempPercent];
            textPer = @"秒";
        }
    }
    
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributesText = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:textFontSize],NSFontAttributeName,textArcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    [percent drawInRect:CGRectMake(5, (viewSize.height/2-textFontSize)/2+5, viewSize.width-10, textFontSize)withAttributes:attributesText];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,arcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    [textPer drawInRect:CGRectMake(5, (viewSize.height/2-fontSize)/2+viewSize.height/2-5, viewSize.width-10, fontSize+5)withAttributes:attributes];
}


@end
