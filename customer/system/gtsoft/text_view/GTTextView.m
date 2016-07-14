#import "GTTextView.h"

@implementation GTTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    //[self addInputAccessoryView];
    
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    
    UIBarButtonItem* btnClear = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Clear", nil)
                                                                 style:UIBarButtonItemStyleDone target:self
                                                                action:@selector(Clear_Text)];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(Close_Keyboard)];
    
    [toolbar setItems:[NSArray arrayWithObjects:btnClear, flexibleSpaceLeft, doneButton, nil]];
    self.inputAccessoryView = toolbar;
}


- (id) init
{
    self = [super init];

    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    
    UIBarButtonItem* btnClear = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Clear", nil)
                                                                 style:UIBarButtonItemStyleDone target:self
                                                                action:@selector(Clear_Text)];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(Close_Keyboard)];
    
    [toolbar setItems:[NSArray arrayWithObjects:btnClear, flexibleSpaceLeft, doneButton, nil]];
    self.inputAccessoryView = toolbar;
    
    return self;
}

#pragma mark - Input Accessory View Selectors

- (void)Clear_Text {
    self.text = @"";
}

- (void)Close_Keyboard {
    [self resignFirstResponder];
}


@end
