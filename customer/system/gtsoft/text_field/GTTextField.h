#import <UIKit/UIKit.h>
#import "NSString+FormatTextField.h"

@interface GTTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, strong) NSNumber *max_length;
@property (nonatomic, strong) NSString *format_type;
@property (nonatomic, assign) BOOL secure_entry;

- (void)Set_Properties;
-(void)Initialize;

@end
