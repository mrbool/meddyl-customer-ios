#import "GTTextField.h"


@implementation GTTextField

@synthesize format_type;
@synthesize max_length;
@synthesize secure_entry;


/* form methods */
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self Initialize];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return [self Mask_Entry:textField];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self Type_In_Text:textField range:range string:string];
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self setTextAlignment:NSTextAlignmentLeft];
    
    return YES;
}

/* public methods */
-(void)Initialize
{
    self.delegate = self;
    
    max_length = @-1;
    secure_entry = NO;
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.backgroundColor = [UIColor whiteColor];
    [self setFont:[UIFont fontWithName:@"Avenir Next" size:18]];
    
    // set left padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    // set right padding
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeUnlessEditing;
    
    [self.layer setCornerRadius:3.0f];
    
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(resignFirstResponder)];
    
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    self.inputAccessoryView = toolbar;
}

-(BOOL)Mask_Entry:(UITextField *)textField
{
    textField.secureTextEntry = secure_entry;
    
    return YES;
}

-(BOOL)Type_In_Text:(UITextField *)textField range:(NSRange)range string:(NSString *)string
{
    if([format_type isEqualToString:@"number"])
    {
        [self setTextAlignment:NSTextAlignmentRight];
    }
    
    if([format_type isEqualToString:@"phone"])
    {
        BOOL delete;
        
        if(range.length == 1)
            delete = YES;
        else
            delete = NO;
        
        self.text =[@""  Format_Phone_Number:textField.text character_added:string delete:delete];
        
        return NO;
    }
    else if([format_type isEqualToString:@"credit_card"])
    {
        BOOL delete;
        
        if(range.length == 1)
            delete = YES;
        else
            delete = NO;
        
        self.text =[@""  Format_Card_Number:textField.text character_added:string delete:delete];
        
        return NO;
    }
    else if([format_type isEqualToString:@"credit_card_expiration"])
    {
        BOOL delete;
        
        if(range.length == 1)
            delete = YES;
        else
            delete = NO;

        self.text =[@""  Format_Card_Expiration:textField.text character_added:string delete:delete];
        
        return NO;
    }
    else if (![max_length  isEqual: @-1])
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;

        return (newLength > [self.max_length longLongValue]) ? NO : YES;
    }
    else
    {
        return YES;
    }
}

- (void)Set_Properties
{
    if([format_type isEqualToString:@"number"])
    {
        [self setTextAlignment:NSTextAlignmentRight];
    }
    
    if([format_type isEqualToString: @"email"])
    {
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }
    else if ([format_type isEqualToString:@"name"])
    {
        self.keyboardType = UIKeyboardTypeDefault;
        self.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }
    else if ([format_type isEqualToString:@"number"])
    {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if ([format_type isEqualToString:@"credit_card"])
    {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if ([format_type isEqualToString:@"credit_card_expiration"])
    {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if ([format_type isEqualToString:@"credit_card_security"])
    {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if ([format_type isEqualToString:@"phone"])
    {
        self.keyboardType = UIKeyboardTypePhonePad;
    }
    else if ([format_type isEqualToString:@"website"])
    {
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }
    else if([format_type isEqualToString:@"zipcode"])
    {
        max_length = @5;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    else
    {
        self.keyboardType = UIKeyboardAppearanceDefault;
    }
}

-(NSString*) Format_Card_Number:(NSString*) current_string character_added:(NSString*)character_added delete:(BOOL)delete
{
    NSString *cleaned_character_added = [[character_added componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *cleaned_current_string = [[current_string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *new_string = [NSString stringWithFormat:@"%@%@", cleaned_current_string, cleaned_character_added];
    
    if(delete)
    {
        if(cleaned_current_string.length > 0)
            new_string = [cleaned_current_string substringToIndex:cleaned_current_string.length-1];
    }
    
    if(new_string.length > 16)
    {
        new_string = cleaned_current_string;
    }
    
    if(new_string.length <= 3)
    {
        new_string = new_string;
    }
    else if(new_string.length <= 7)
    {
        new_string = [NSString stringWithFormat:@"%@%@%@",
                      [new_string substringWithRange:NSMakeRange (0, 4)], @" ",
                      [new_string substringWithRange:NSMakeRange (4, new_string.length - 4)]] ;
    }
    else if(new_string.length <= 11)
    {
        new_string = [NSString stringWithFormat:@"%@%@%@%@%@",
                      [new_string substringWithRange:NSMakeRange (0, 4)], @" ",
                      [new_string substringWithRange:NSMakeRange (4, 4)], @" ",
                      [new_string substringWithRange:NSMakeRange (8, new_string.length - 8)]];
        
    }
    else if(new_string.length <= 16)
    {
        new_string = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                      [new_string substringWithRange:NSMakeRange (0, 4)], @" ",
                      [new_string substringWithRange:NSMakeRange (4, 4)], @" ",
                      [new_string substringWithRange:NSMakeRange (8, 4)], @" ",
                      [new_string substringWithRange:NSMakeRange (12, new_string.length - 12)]];
        
    }
    
    return new_string;
}

-(NSString*) Format_Card_Expiration:(NSString*) current_string character_added:(NSString*)character_added delete:(BOOL)delete
{
    NSString *cleaned_character_added = [[character_added componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *cleaned_current_string = [[current_string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *new_string = [NSString stringWithFormat:@"%@%@", cleaned_current_string, cleaned_character_added];
    
    if(delete)
    {
        if(cleaned_current_string.length > 0)
            new_string = [cleaned_current_string substringToIndex:cleaned_current_string.length-1];
    }
    
    if(new_string.length > 4)
    {
        new_string = cleaned_current_string;
    }
    
    if(new_string.length <= 1)
    {
        new_string = new_string;
    }
    else if(new_string.length == 2)
    {
        new_string = [NSString stringWithFormat:@"%@%@", [new_string substringWithRange:NSMakeRange (0, 2)], @"/"];
    }
    else if(new_string.length <= 4)
    {
        new_string = [NSString stringWithFormat:@"%@%@%@", [new_string substringWithRange:NSMakeRange (0, 2)], @"/",
                      [new_string substringWithRange:NSMakeRange (2, new_string.length - 2)]];
    }
    
    return new_string;
}

- (void)Clear_Text
{
    self.text = @"";
}

@end
