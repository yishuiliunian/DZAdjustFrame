//
//  DZAdjustTableView.h
//  Pods
//
//  Created by stonedong on 15/9/7.
//
//

#import <UIKit/UIKit.h>

@interface DZAdjustTableView : UITableView
@property (nonatomic, assign) BOOL firstDataReady;
@property (nonatomic, strong) UIView* placeHolderView;
@end
