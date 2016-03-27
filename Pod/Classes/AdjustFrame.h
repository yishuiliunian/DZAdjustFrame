//
//  AdjustFrame.h
//  LuTu
//
//  Created by stonedong on 15/5/25.
//  Copyright (c) 2015年 Road.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DZViewControllerAdjustProtocol <NSObject>
@optional
- (void) handleAdjustFrame;
@end


@interface UIViewController (AdjustFrame)<DZViewControllerAdjustProtocol>
@end

@interface UIView (AdjustFrame)
@property (nonatomic, assign) CGFloat adjustHeight;
- (BOOL) hintAdjustSupreView;
- (void) handleAdjustFrame;
@end
