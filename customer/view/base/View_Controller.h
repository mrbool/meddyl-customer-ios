#import <UIKit/UIKit.h>

#import "Deal_Controller.h"
#import "Customer_Controller.h"
#import "System_Controller.h"

#import "ACPButton.h"
#import "GTAlertView.h"
#import "GTLabel.h"
#import "GTTextField.h"
#import "GTTextFieldDate.h"
#import "GTPickerView_TextField.h"
#import "NSString+FormatTextField.h"
#import "SVProgressHUD.h"
#import "Utilities.h"
#import "KLCPopup.h"
#import "GTPopup.h"
#import "M13Checkbox.h"
#import "GTTextView.h"
#import "SSKeychain.h"
#import "Coding.h"


@interface View_Controller : UIViewController 
{
    BOOL successful;
  
    System_Error *system_error_obj;
    System_Successful *system_successful_obj;
    
    UIScrollView* scrollView;
    UIView* contentView;
    
    UIFont* text_field_font;
    UIFont* label_font_xsmall;
    UIFont* label_font;
    UIFont* label_font_medium;
    UIFont* label_font_large;
    UIFont* button_font;
    UIFont* button_font_small;
    UIFont* link_button_font;
    UIFont* link_button_font_large;
    UIFont* label_font_medium_medium;
}

@property (nonatomic, strong) Deal_Controller *deal_controller;
@property (nonatomic, strong) Customer_Controller *customer_controller;
@property (nonatomic, strong) System_Controller *system_controller;

@property (nonatomic, strong) NSString *screen_type;
@property (nonatomic, copy) NSString *screen_title;
@property (nonatomic, copy) NSString *calling_view;
@property (nonatomic, copy) NSString *left_button;
@property (nonatomic, copy) NSString *right_button;
@property (nonatomic, assign) NSInteger keyboard_y_coordinate;
@property (nonatomic, assign) BOOL cancel;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) BOOL edited;
@property (nonatomic, assign) BOOL loaded;
@property (nonatomic, assign) BOOL keyboardIsShown;
@property (nonatomic, assign) BOOL move_keyboard_up;

@property CGFloat screen_up_y;
@property CGPoint original_center;
@property CGRect screen_bounds;
@property CGSize screen_size;
@property CGFloat screen_width;
@property CGFloat screen_height;
@property CGFloat screen_x;
@property CGFloat screen_y;
@property CGFloat screen_indent_x;
@property CGFloat screen_indent_x_right;
@property CGFloat screen_indent_width;
@property CGFloat screen_indent_width_half;
@property CGFloat text_field_height;
@property CGFloat text_field_font_height;
@property CGFloat button_height;
@property CGFloat button_font_height;
@property CGFloat link_button_font_height;
@property CGFloat label_font_height;
@property CGFloat gap;

-(void)Next_Click;
-(void)Progress_Show: (NSString *)status;
-(void)Progress_Close;
-(void)Progress_Close_No_Keyboard;
-(void)Set_Controller_Properties;
-(CGFloat)Get_Scroll_Height: (CGRect)last_frame scroll_lag:(CGFloat)scroll_lag;
-(void)Add_View: (CGFloat)width height:(CGFloat)height background_color:(UIColor*)background_color;

@end
