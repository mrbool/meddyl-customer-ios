#import <Foundation/Foundation.h>

@interface NSString (FormatTextField)

-(NSString*) Format_Phone_Number:(NSString*) current_phone character_added:(NSString*)character_added delete:(BOOL)delete;
-(NSString*) Format_Card_Expiration:(NSString*) current_string character_added:(NSString*)character_added delete:(BOOL)delete;
-(NSString*) Format_Number:(NSString*) current_string character_added:(NSString*)character_added length:(NSUInteger)length delete:(BOOL)delete;
-(NSString*) Format_Card_Number:(NSString*) current_string character_added:(NSString*)character_added delete:(BOOL)delete;
-(NSString*) Format_Uppercase:(NSString*) current_string character_added:(NSString*)character_added length:(NSUInteger)length delete:(BOOL)delete;

@end