//
//  AlertTool.h
//  Ayibang
//
//  Created by 周际航 on 15/9/24.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertTool : NSObject
// alert方式提示
+ (void)alert:(NSString *)message cancelName:(NSString *)cancel delegate:(id<UIAlertViewDelegate>)delegate;
+ (void)alert:(NSString *)message cancelName:(NSString *)cancel sureName:(NSString *)sure delegate:(id<UIAlertViewDelegate>)delegate;

// 吐司方式提示
+ (void)tips:(NSString *)message;

@end
