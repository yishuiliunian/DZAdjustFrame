//
//  DZAdjustTableView.m
//  Pods
//
//  Created by stonedong on 15/9/7.
//
//

#import "DZAdjustTableView.h"
#import "AdjustFrame.h"
@interface DZAdjustTableView ()
{
    int  _reloadCount ;
    BOOL _firstReload;
}
@property (nonatomic,assign) BOOL notifyAjudstFrame;
@end

@implementation DZAdjustTableView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _notifyAjudstFrame = NO;
    _reloadCount = 0;
    _firstDataReady = NO;
    _firstReload = YES;
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (!self) {
        return self;
    }
    _notifyAjudstFrame = NO;
    return self;
}

- (BOOL) hintAdjustSupreView
{
    return NO;
}

- (void) handleAdjustFrame
{
    UIView* header = self.tableHeaderView;
    header.frame = CGRectMake(0, 0, CGRectGetWidth(header.frame), header.adjustHeight);
    self.tableHeaderView = header;
    
    UIView* footer = self.tableFooterView;
    if (footer) {
        footer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), footer.adjustHeight);
    }
    self.tableFooterView = footer;
    [self setNeedsLayout];
    
    if (!_notifyAjudstFrame) {
        _notifyAjudstFrame = YES;
        if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController* vc = (UIViewController*)self.nextResponder;
            if ([vc respondsToSelector:@selector(handleAdjustFrame)]) {
                [vc handleAdjustFrame];
            }
        }
        _notifyAjudstFrame = NO;
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.bounds;
    rect.origin.y = 0;
    rect.size.height = CGRectGetHeight(self.bounds) - self.contentInset.bottom;
    self.placeHolderView.frame = rect;
}

- (void) showPlaceHolderIfNeed
{
        if (!self.placeHolderView) {
            return;
        }

    if (_firstReload) {
        return;
    }
        if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            NSInteger sectionCount = [self.dataSource numberOfSectionsInTableView:self];
            NSInteger sum = 0;
            for (int i = 0; i < sectionCount; i++) {
                sum += [self.dataSource tableView:self numberOfRowsInSection:i];
            }
            
            if (sum > 0) {
                self.placeHolderView.hidden = YES;
            } else {
                self.placeHolderView.hidden = NO;
            }
            [self setNeedsLayout];
        }
}

- (void) setPlaceHolderView:(UIView *)placeHolderView
{
    if (placeHolderView != _placeHolderView) {
        [_placeHolderView removeFromSuperview];
        _placeHolderView = placeHolderView;
        if (_placeHolderView) {
            [self insertSubview:_placeHolderView atIndex:0];
        }
        _placeHolderView.hidden = YES;
        [self setNeedsLayout];
        [self showPlaceHolderIfNeed];
    }
}
- (void) reloadData
{
    [super reloadData];
    _reloadCount++;
    [self showPlaceHolderIfNeed];
        _firstReload = NO;
}

- (void) scrollRectToVisible:(CGRect)rect animated:(BOOL)animated
{
    [super scrollRectToVisible:rect animated:animated];
}

- (void) setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
{
    [super setContentOffset:contentOffset animated:animated];
}
- (void) insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceHolderIfNeed];
    
}

- (void) insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [super insertSections:sections withRowAnimation:animation];
    [self showPlaceHolderIfNeed];
    
}

- (void) deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceHolderIfNeed];
    
}

- (void) deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [super deleteSections:sections withRowAnimation:animation];
    [self showPlaceHolderIfNeed];
    
}

@end


