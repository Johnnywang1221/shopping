//
//  MJRefreshBaseView.m
//  weibo
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJRefreshBaseView.h"

#define kBundleName @"MJRefresh.bundle"
#define kSrcName(file) [kBundleName stringByAppendingPathComponent:file]

@interface  MJRefreshBaseView()
// 合理的Y值
- (CGFloat)validY;
// view的类型
- (int)viewType;
@end

@implementation MJRefreshBaseView
@synthesize activityView;

#pragma mark - 初始化方法
- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        self.scrollView = scrollView;
    }
    return self;
}

#pragma mark 初始化
- (void)initial
{
    // 1.自己的属性
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.45];
    
    // 2.时间标签
    self.lastUpdateTimeLabel = [self labelWithFontSize:11];
    [self addSubview:self.lastUpdateTimeLabel];
    self.lastUpdateTimeLabel.textAlignment = NSTextAlignmentCenter;
    // 3.状态标签
    self.statusLabel = [self labelWithFontSize:13];
    [self addSubview:self.statusLabel];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    // 4.箭头图片
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.contentMode = UIViewContentModeScaleAspectFit;
    arrowImage.image = [UIImage imageNamed:kSrcName(@"arrow.png")];
    [self addSubview:_arrowImage = arrowImage];
    
    // 5.指示器
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.hidden = YES;
    [self addSubview:_activityView = activityView];
    
    // 6.设置默认状态
    [self setState:RefreshStateNormal];
    
}

- (void)awakeFromNib
{
    [self initial];
}

#pragma mark 构造方法
- (id)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}

#pragma mark 创建一个UILabel
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:size];
    CGFloat color = 178/255.0;
    label.textColor = [UIColor colorWithRed:color green:color blue:color alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


#pragma mark 设置frame
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat statusY = 5;
    
    if (frame.size.width == 0 || _statusLabel.frame.origin.y == statusY) return;
    
    // 3.箭头
    CGFloat arrowX = 20;
    _arrowImage.frame = CGRectMake(arrowX, statusY, 20.0f, 35.0f);
    
    // 4.指示器
    activityView.frame = CGRectMake(20, 10, 20.0f, 20.0f);
}

#pragma mark - UIScrollView相关
#pragma mark 设置UIScrollView
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 移除之前的监听器
    [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    // 设置scrollView
    _scrollView = scrollView;
    [_scrollView addSubview:self];
    // 监听contentOffset
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)free
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

#pragma mark 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"contentOffset" isEqualToString:keyPath]) {
        CGFloat offsetY = _scrollView.contentOffset.y * self.viewType;
        CGFloat validY = self.validY;
        if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
            || _state == RefreshStateRefreshing
            || offsetY <= validY) return;
        
        // 即将刷新 && 手松开
        if (_scrollView.isDragging) {
            CGFloat validOffsetY = validY + kViewHeight;
            if (_state == RefreshStatePulling && offsetY <= validOffsetY) {
                // 转为普通状态
#ifdef NeedAudio
                AudioServicesPlaySystemSound(_normalId);
#endif
                [self setState:RefreshStateNormal];
            } else if (_state == RefreshStateNormal && offsetY > validOffsetY) {
                // 转为即将刷新状态
#ifdef NeedAudio
                AudioServicesPlaySystemSound(_pullId);
#endif
                [self setState:RefreshStatePulling];
            }
        } else {
            if (_state == RefreshStatePulling) {
                // 开始刷新
#ifdef NeedAudio
                AudioServicesPlaySystemSound(_refreshingId);
#endif
                [self setState:RefreshStateRefreshing];
            }
        }
    }
}

#pragma mark 设置状态
- (void)setState:(RefreshState)state
{
    switch (state) {
		case RefreshStateNormal:
            _arrowImage.hidden = NO;
			[_activityView stopAnimating];
			break;
            
        case RefreshStatePulling:
            break;
            
		case RefreshStateRefreshing:
			[_activityView startAnimating];
			_arrowImage.hidden = YES;
            _arrowImage.transform = CGAffineTransformIdentity;
            
            // 通知代理
            if ([_delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]) {
                [_delegate refreshViewBeginRefreshing:self];
            }
            
            // 回调
            if (_beginRefreshingBlock) {
                _beginRefreshingBlock(self);
            }
			break;
	}
}

#pragma mark - 状态相关
#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    return RefreshStateRefreshing == _state;
}
#pragma mark 开始刷新
- (void)beginRefreshing
{
    [self setState:RefreshStateRefreshing];
}
#pragma mark 结束刷新
- (void)endRefreshing
{
    [self setState:RefreshStateNormal];
}
@end