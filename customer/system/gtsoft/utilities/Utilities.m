#import "Utilities.h"

@implementation Utilities

+(BOOL) IsNumeric:(NSString *) string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([string isEqualToString:@""])
    {
        return false;
    }
    else
    {
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}

+(BOOL) IsDate:(NSString *) string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([string isEqualToString:@""])
    {
        return false;
    }
    else
    {
        return true;
    }
}

+(BOOL) IsValidEmail:(NSString *) email
{
    BOOL stricterFilter = NO;
    
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+(NSString*) Format_Credit_Card:(NSString *) card_number
{
    NSString* formatted;
    
    if(card_number.length == 16)
    {
        formatted = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", [card_number substringWithRange:NSMakeRange (0, 4)], @" ",
                     [card_number substringWithRange:NSMakeRange (4, 4)], @" ",
                     [card_number substringWithRange:NSMakeRange (8, 4)], @" ",
                     [card_number substringWithRange:NSMakeRange (12, 4)]];
    }
    else if (card_number.length == 15)
    {
        formatted = [NSString stringWithFormat:@"%@%@%@%@%@", [card_number substringWithRange:NSMakeRange (0, 4)], @" ",
                     [card_number substringWithRange:NSMakeRange (4, 6)], @" ",
                     [card_number substringWithRange:NSMakeRange (10, 5)]];
    }
    else
    {
        formatted = card_number;
    }
    
    return formatted;
}

+(NSString*) Format_Credit_Card_Expiration:(NSString *) expiration
{
    NSString* formatted;
    
    if(expiration.length == 4)
    {
        formatted = [NSString stringWithFormat:@"%@%@%@",
                     [expiration substringWithRange:NSMakeRange (0, 2)], @"/",
                     [expiration substringWithRange:NSMakeRange (2, 2)]];
    }
    else
    {
        formatted = expiration;
    }
    
    return formatted;
}

+(CGFloat) Get_Height:(UILabel *) label
{
    // set paragraph style
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    // make dictionary of attributes with paragraph style
    NSDictionary *sizeAttributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName: style};
    
    // get the CGSize
    CGSize adjustedSize = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    
    // alternatively you can also get a CGRect to determine height
    CGRect rect = [label.text boundingRectWithSize:adjustedSize
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:sizeAttributes
                                                  context:nil];
    
    CGFloat x = rect.size.height;
    
    if(x==0)
        x=1;
    
    return x;
}

+(CGFloat) Get_Label_Width:(UILabel *) label
{
    /* for some reason if there is a blank, the width will not be recorded; also string must be a certain width .. weird xcode */
    NSString* hold = [label.text stringByReplacingOccurrencesOfString:@" " withString:@"i"];
    
    CGFloat widthIs =
    [hold
     boundingRectWithSize:label.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:label.font }
     context:nil]
    .size.width;
    
    return widthIs;
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+(void) Clear_NSDefaults
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

+(NSString *)Get_Cents_From_DecimalNumber:(NSDecimalNumber*)input
{
    double value = [input doubleValue];
    unsigned dollars = (unsigned)value;
    unsigned cents = (value * 100) - (dollars * 100);
    
    return [NSString stringWithFormat:@"%02u", cents];
}


+(NSString *)Get_Dollars_From_DecimalNumber:(NSDecimalNumber*)input
{
    double value = [input doubleValue];
    unsigned dollars = (unsigned)value;
    
    return [NSString stringWithFormat:@"%u", dollars];
}

+(NSString *)DecimalNumber_To_String:(NSDecimalNumber*)input;
{
    NSString* output;
    
    if(input == nil)
    {
        output = @"$0.00";
    }
    else
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        output = [numberFormatter stringFromNumber:input];
    }
    
    return output;
}

@end
