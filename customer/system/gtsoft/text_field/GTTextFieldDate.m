#import "GTTextFieldDate.h"


@implementation GTTextFieldDate
{
    UIDatePicker *datePickerView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTextAlignment:NSTextAlignmentRight];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self Initialize];
}

-(void)Initialize
{
    [super Initialize];
    
    [self setTextAlignment:NSTextAlignmentRight];
    
    datePickerView = [UIDatePicker new];
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.backgroundColor = [UIColor whiteColor];
    [datePickerView addTarget:self action:@selector(Date_Changed) forControlEvents:UIControlEventValueChanged];
    
    //[self Date_Changed];
    
    self.inputView = datePickerView;
}


- (void)Date_Changed
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"M/d/yyyy";
    self.text = [formatter stringFromDate:datePickerView.date];
    [self setTextAlignment:NSTextAlignmentRight];
}


@end
