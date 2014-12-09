#import "ViewController.h"

@interface ViewController
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
@end


@implementation ViewController{
    CGPoint _previousOffset; // TODO remove need for state using ReactiveCocoa
    BOOL _didCallEndEditingFlag; // prevents [self.view endEditing:YES]; being spammed
}

-(instancetype)init{
    if (self = [super initWithNibName:NSStringFromClass(self.class) bundle:nil]) {
        _previousOffset= CGPointZero;
        _didCallEndEditingFlag= NO;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - UIScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _previousOffset= scrollView.contentOffset;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < _previousOffset.y){
        @synchronized (self) {
            if (!_didCallEndEditingFlag) { // prevents [self.view endEditing:YES]; being called repeatedly
                _didCallEndEditingFlag = YES;
                [self.view endEditing:YES];
            }
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _didCallEndEditingFlag= NO;
}

#pragma mark -
#pragma mark - Keyboard animations

// based on http://spin.atomicobject.com/2014/01/08/animate-around-ios-keyboard/

- (void)keyboardWillShow:(NSNotification*)notification {
    [self animateKeyboardWithUserInfo:[notification userInfo] directionUp:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    [self animateKeyboardWithUserInfo:[notification userInfo] directionUp:NO];
}

// NSDictionary* userInfo = [notification userInfo];
-(void)animateKeyboardWithUserInfo:(NSDictionary*)userInfo directionUp:(BOOL)up{

    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];

    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];

    self.tableViewBottomConstraint.constant= up? keyboardFrame.size.height : 0;

    [UIView
        animateWithDuration:duration delay:0 options:animationCurve << 16
        animations:^{
            [self.view layoutIfNeeded];
        } completion:nil
    ];
}

@end

