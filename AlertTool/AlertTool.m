//
//  AlertTool.m
//  Ayibang
//
//  Created by 周际航 on 15/9/24.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "AlertTool.h"
#import "AlertTipWindow.h"
#import <Masonry/Masonry.h>
@implementation AlertTool
+ (void)alert:(NSString *)message cancelName:(NSString *)cancel delegate:(id<UIAlertViewDelegate>)delegate{
    
    NSString *title = @"提示";
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    [alertView show];
}
+ (void)alert:(NSString *)message cancelName:(NSString *)cancel sureName:(NSString *)sure delegate:(id<UIAlertViewDelegate>)delegate{
    
    NSString *title = @"确定";
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancel otherButtonTitles:sure, nil];
    [alertView show];
    
}

#pragma mark － 弹出轻提示语
+ (void)tips:(NSString *)message{
    if (!message || [message isEqualToString:@""]) {return;}
    
    message = [message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    UIView *tipsView = [self createTipsViewWithMessage:message];
    [self showTipsView:tipsView];
}
+ (UIView *)createTipsViewWithMessage:(NSString *)message{
    CGFloat minWidth = 180;         // 视图最小宽度
    CGFloat maxWidth = 260;         // 视图最大宽度
    CGFloat padding = 10;           // 文字到视图左右上下的最小距离
    
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize messageSize = [self sizeWithString:message boundingSize:CGSizeMake(maxWidth-2*padding, 1000) font:font];

    // label视图宽高确定
    CGRect labelFrame = CGRectMake(0, 0, messageSize.width, messageSize.height);
    // tips视图的宽高确定
    CGRect viewFrame = CGRectMake(0, 0, MAX(minWidth, messageSize.width+2*padding), messageSize.height+2*padding);
    
    // 创建视图
    UIView *tipsView = [[UIView alloc]init];
    tipsView.userInteractionEnabled = NO;
    tipsView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    tipsView.layer.cornerRadius = 8;
    tipsView.layer.masksToBounds = YES;
    tipsView.frame = viewFrame;
    CGPoint viewCenterPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-100);
    tipsView.center = viewCenterPoint;
    
    // 创建label
    UILabel *tipsLabel = [[UILabel alloc]init];
    [tipsView addSubview:tipsLabel];
    tipsLabel.userInteractionEnabled = NO;
    tipsLabel.text = message;
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = font;
    tipsLabel.preferredMaxLayoutWidth = messageSize.width;
    tipsLabel.numberOfLines = 0;
    tipsLabel.frame = labelFrame;
    CGPoint labelCenterPoint = CGPointMake(tipsView.bounds.size.width/2, tipsView.bounds.size.height/2);
    tipsLabel.center = labelCenterPoint;
    
    return tipsView;
}

+ (void)showTipsView:(UIView *)tipsView{

    static AlertTipWindow *alertTipWindow;
    if (!alertTipWindow) {
        alertTipWindow = [[AlertTipWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        alertTipWindow.userInteractionEnabled = NO;
        alertTipWindow.windowLevel = UIWindowLevelAlert+100;
        alertTipWindow.backgroundColor = [UIColor clearColor];
        alertTipWindow.hidden = NO;
    }
    
    if (alertTipWindow.subviews.count > 0) return;
    
    [alertTipWindow addSubview:tipsView];
    [alertTipWindow bringSubviewToFront:tipsView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 消失
        [UIView animateWithDuration:0.5 animations:^{
            // 消失
            tipsView.alpha = 0;
        } completion:^(BOOL finished) {
            [tipsView removeFromSuperview];
        }];
    });
}

#pragma mark - 计算文本占据位置的大小（CGSize）
+ (CGSize)sizeWithString:(NSString *)string boundingSize:(CGSize)boundingSize font:(UIFont *)font{
    CGRect labelRect = [string boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return labelRect.size;
}

@end
