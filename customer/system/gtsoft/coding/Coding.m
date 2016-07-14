#import "Coding.h"

@implementation Coding

+(ACPButton *)Create_Button:(NSString *) text font:(UIFont*)font style:(ACPButtonType)style text_color:(UIColor*)text_color width:(CGFloat)width height:(CGFloat)height
{
    ACPButton* button = [[ACPButton alloc]init];
    [button setStyleType:style];
    [button setLabelTextColor:text_color highlightedColor:text_color disableColor:nil];
    [button setTitle:text forState:UIControlStateNormal];
    [button setLabelFont:font];
    button.frame = CGRectMake(0, 0, width, height);
    
    return button;
}

+(UIButton *)Create_Link_Button:(NSString *) text font:(UIFont*)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    if(font==nil)
        font =[UIFont fontWithName:@"Avenir Next" size:18];
        
    [button.titleLabel setFont:font];

    CGSize text_size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    button.frame = CGRectMake(0, 0, text_size.width, text_size.height);
    
    return button;
}

+(GTLabel *)Create_Label:(NSString *) text width:(CGFloat)width font:(UIFont*)font mult:(BOOL)multi
{
    GTLabel *label = [[GTLabel alloc] init];
    
    [label Initialize];
    
    if(font!=nil)
        [label setFont:font];
    
    label.backgroundColor = [UIColor clearColor];
    
    [label setText:text];
    
    if(multi)
    {
        [label setNumberOfLines:0];
        [label sizeToFit];
    }
    else
    {
        [label setNumberOfLines:1];
        label.adjustsFontSizeToFitWidth=YES;
    }
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    // Values are fractional -- you should take the ceilf to get equivalent values
    CGSize adjustedSize = CGSizeMake(width, ceilf(size.height));
    
    label.frame = CGRectMake(0, 0, adjustedSize.width, adjustedSize.height);
    
    return label;
}

+(GTTextField *)Create_Text_Field:(NSString *)placeholder format_type:(NSString*)format_type characters:(NSNumber*)characters width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font
{
    GTTextField *text_field = [[GTTextField alloc]init];
    [text_field Initialize];
    text_field.max_length = characters;
    text_field.format_type = format_type;
    [text_field setFont:font];
    [text_field setPlaceholder:placeholder];
    text_field.frame = CGRectMake(0, 0, width, height);
    [text_field Set_Properties];

    return text_field;
}

+(GTTextFieldDate *)Create_Date_Field:(NSString *)placeholder width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font
{
    GTTextFieldDate *text_field = [[GTTextFieldDate alloc]init];
    [text_field Initialize];
    [text_field setFont:font];
    [text_field setPlaceholder:placeholder];
    text_field.frame = CGRectMake(0, 0, width, height);
    [text_field Set_Properties];
    
    return text_field;
}


+(GTTextView *)Create_Text_View:(NSString *)placeholder characters:(NSNumber*)characters width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font
{
    GTTextView *text_view = [[GTTextView alloc]init];
    [text_view setFont:font];
    [text_view setPlaceholder:placeholder];
    text_view.frame = CGRectMake(0, 0, width, height);
    
    return text_view;
}

+(GTPickerView_TextField *)Create_Picker:(NSString *)placeholder format_type:(NSString*)format_type characters:(NSNumber*)characters width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font
{
    GTPickerView_TextField *picker = [[GTPickerView_TextField alloc]init];
    picker.frame = CGRectMake(0, 0, width, height);
    picker.placeholder = placeholder;
    [picker Initialize];
    [picker setFont:font];
    
    return picker;
}

+(M13Checkbox *)Create_Checkbox:(NSInteger)tag selected:(BOOL)selected width:(CGFloat)width
{
    M13Checkbox *checkbox = [[M13Checkbox alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    [checkbox setTag:tag];
    [checkbox setCheckState:selected];

    return checkbox;
}

+(UIView*)Create_Straight_Line:(CGFloat)screen_width
{
    CGFloat width = screen_width * .9;
    CGFloat x = (screen_width * .1)/2;
    UIView *vwLine0 = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, 1)];
    vwLine0.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];

    return vwLine0;
}

+(void)Add_View:(UIView*)inContentView view:(UIView *)view x:(CGFloat)x height:(CGFloat)height prev_frame:(CGRect)prev_frame gap:(CGFloat)gap
{
    CGFloat width;
    CGFloat y;
    
    width = view.frame.size.width;
    
    if(CGRectIsEmpty(prev_frame))
        y= gap;
    else
        y = prev_frame.origin.y + prev_frame.size.height + gap;
    
    [view setFrame:CGRectMake(x, y, width, height)];
    
    [inContentView addSubview:view];
}


@end
