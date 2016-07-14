#import "NSString+FormatTextField.h"

@implementation NSString (FormatTextField)


-(NSString*) Format_Phone_Number:(NSString*) current_phone character_added:(NSString*)character_added delete:(BOOL)delete
{
    NSString *cleaned_character_added = [[character_added componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *cleaned_current_phone = [[current_phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *phone_number = [NSString stringWithFormat:@"%@%@", cleaned_current_phone, cleaned_character_added];
    
    if(delete)
    {
        if(cleaned_current_phone.length > 0)
            phone_number = [cleaned_current_phone substringToIndex:cleaned_current_phone.length-1];
    }
    
    if(phone_number.length > 10)
    {
        phone_number = cleaned_current_phone;
    }
    
    if(phone_number.length == 0)
    {
        phone_number = @"";
    }
    else if(phone_number.length <=2)
    {
        phone_number = [NSString stringWithFormat:@"%@%@", @"(", phone_number];
    }
    else if(phone_number.length == 3)
    {
        phone_number = [NSString stringWithFormat:@"%@%@%@", @"(", phone_number, @") "];
    }
    else if(phone_number.length < 6)
    {
        phone_number = [NSString stringWithFormat:@"%@%@%@%@", @"(", [phone_number substringWithRange:NSMakeRange (0, 3)], @") ", [phone_number substringWithRange:NSMakeRange (3, phone_number.length - 3)]] ;
    }
    else if(phone_number.length <= 10)
    {
        phone_number = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"(", [phone_number substringWithRange:NSMakeRange (0, 3)], @") ",
                        [phone_number substringWithRange:NSMakeRange (3, 3)], @"-",
                        [phone_number substringWithRange:NSMakeRange (6, phone_number.length - 6)]];
    }
    
    return phone_number;
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

-(NSString*) Format_Number:(NSString*) current_string character_added:(NSString*)character_added length:(NSUInteger)length delete:(BOOL)delete
{
    NSString *cleaned_character_added = [[character_added componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *cleaned_current_string = [[current_string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *new_string = [NSString stringWithFormat:@"%@%@", cleaned_current_string, cleaned_character_added];
    
    if(delete)
    {
        if(cleaned_current_string.length > 0)
            new_string = [cleaned_current_string substringToIndex:cleaned_current_string.length-1];
    }
    
    if(new_string.length > length)
    {
        new_string = cleaned_current_string;
    }
    
    return new_string;
}


-(NSString*) Format_Uppercase:(NSString*) current_string character_added:(NSString*)character_added length:(NSUInteger)length delete:(BOOL)delete
{
    NSString *new_string = [NSString stringWithFormat:@"%@%@", current_string, character_added];
    
    if(delete)
    {
        if(current_string.length > 0)
            new_string = [current_string substringToIndex:current_string.length-1];
    }
    
    if(new_string.length > length)
    {
        new_string = current_string;
    }
    
    new_string = [new_string uppercaseString];
    
    return new_string;
}
@end

