#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>


@interface Utilities : NSObject


+(BOOL) IsNumeric:(NSString *) string;
+(BOOL) IsDate:(NSString *) string;
+(BOOL) IsValidEmail:(NSString *) string;
+(NSString*) Format_Credit_Card:(NSString *) card_number;
+(NSString*) Format_Credit_Card_Expiration:(NSString *) expiration;
+(CGFloat) Get_Height:(UILabel *) label;
+(CGFloat) Get_Label_Width:(UILabel *) label;
+(UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(NSInteger) daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+(NSString *) getIPAddress;
+(void) Clear_NSDefaults;
+(NSString *)Get_Dollars_From_DecimalNumber:(NSDecimalNumber*)input;
+(NSString *)Get_Cents_From_DecimalNumber:(NSDecimalNumber*)input;
+(NSString *)DecimalNumber_To_String:(NSDecimalNumber*)input;

@end
