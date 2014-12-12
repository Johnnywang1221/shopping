
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//extern NSString * const kRNBlurDidShowNotification;
//extern NSString * const kRNBlurDidHidewNotification;

@interface RNBlurModalView : UIView

@property (assign, readonly) BOOL isVisible;

@property (assign) CGFloat animationDuration;
@property (assign) CGFloat animationDelay;
@property (assign) UIViewAnimationOptions animationOptions;
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) UIButton *_dismissButton;

- (id)initWithViewController:(UIViewController*)viewController view:(UIView*)view;
- (id)initWithViewController:(UIViewController*)viewController title:(NSString*)title message:(NSString*)message;

- (void)show;
- (void)showWithDuration:(CGFloat)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)(void))completion;

- (void)hide;
- (void)hideWithDuration:(CGFloat)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)(void))completion;
- (void)pause;

@end

