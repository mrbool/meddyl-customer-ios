#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ACPButton.h"
#import "GTLabel.h"
#import "GTTextField.h"
#import "GTTextView.h"
#import "GTPickerView_TextField.h"
#import "GTTextFieldDate.h"
#import "M13Checkbox.h"
#import "Utilities.h"

@interface Coding : NSObject

+(ACPButton *)Create_Button:(NSString *) text font:(UIFont*)font style:(ACPButtonType)style text_color:(UIColor*)text_color width:(CGFloat)width height:(CGFloat)height;
+(GTTextFieldDate *)Create_Date_Field:(NSString *)placeholder width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font;
+(UIButton *)Create_Link_Button:(NSString *) text font:(UIFont*)font;
+(GTLabel *)Create_Label:(NSString *) text width:(CGFloat)width font:(UIFont*)font mult:(BOOL)multi;
+(GTTextField *)Create_Text_Field:(NSString *)placeholder format_type:(NSString*)format_type characters:(NSNumber*)characters width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font;
+(GTTextView *)Create_Text_View:(NSString *)placeholder characters:(NSNumber*)characters width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font;
+(GTPickerView_TextField *)Create_Picker:(NSString *)placeholder format_type:(NSString*)format_type characters:(NSNumber*)characters width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font;
+(M13Checkbox *)Create_Checkbox:(NSInteger)tag selected:(BOOL)selected width:(CGFloat)width;
+(void)Add_View:(UIView*)inContentView view:(UIView *)view x:(CGFloat)x height:(CGFloat)height prev_frame:(CGRect)prev_frame gap:(CGFloat)gap;
+(UIView*)Create_Straight_Line:(CGFloat)screen_width;

@end
