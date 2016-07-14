#import "GTPopup.h"


@implementation GTPopup
{
    NSString *text;
    UIView* contentView;
    CGSize size;
}


/* form methods */
- (void)awakeFromNib
{
    [super awakeFromNib];
    //[self Initialize];
}


/* public methods */
-(void)Initialize:(UIImage *) image view_size:(CGSize)view_size input_text:(NSString*)input_text
{
    size = view_size;
    text = input_text;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Max_Dollar_Info)];
    singleTap.numberOfTapsRequired = 1;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
    
    [self setImage:image];
}

/* public methods */
- (void)Max_Dollar_Info
{
    // Generate content view to present
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    //contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4.0;
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCancel.frame = CGRectMake(-10, -10, 40, 40);
    UIImage *imgCancel = [UIImage imageNamed:@"cancel.png"];
    [btnCancel setBackgroundImage:imgCancel forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(PopupCancel_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    GTLabel* lblInfo = [[GTLabel alloc] init];
    //dismissLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [lblInfo setBackgroundColor:[UIColor clearColor]];
    [lblInfo setFont:[UIFont fontWithName:@"Avenir Next" size:22]];
    [lblInfo setTextColor:[UIColor colorWithRed:86.0/255.0 green:90.0/255 blue:92.0/255.0 alpha:1]];
    //dismissLabel.text = @"Maxiumum dollar amount must be a value between 1 and 50 dollars";
    [lblInfo setText:text];
    lblInfo.numberOfLines = 0;
    lblInfo.frame = CGRectMake(12, 50, size.width - 24, [Utilities Get_Height:lblInfo]);
    [lblInfo sizeToFit];
    
    contentView.frame =CGRectMake(0, 0, size.width, [Utilities Get_Height:lblInfo] + 100);
    
    [contentView addSubview:lblInfo];
    [contentView addSubview:btnCancel];
    
    //        NSDictionary* views = NSDictionaryOfVariableBindings(contentView, dismissLabel);
    //
    //        [contentView addConstraints:
    //         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(16)-[dismissLabel]-(24)-|"
    //                                                 options:NSLayoutFormatAlignAllCenterX
    //                                                 metrics:nil
    //                                                   views:views]];
    //
    //        [contentView addConstraints:
    //         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(60)-[dismissLabel]-(60)-|"
    //                                                 options:0
    //                                                 metrics:nil
    //                                                   views:views]];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake((KLCPopupHorizontalLayout) 3,
                                               (KLCPopupVerticalLayout) 3);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:(KLCPopupShowType)@"Fade in"
                                         dismissType:(KLCPopupDismissType)@"Slide to Bottom"
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}

- (void)PopupCancel_Clicked:(id)sender
{
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView*)sender dismissPresentingPopup];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
