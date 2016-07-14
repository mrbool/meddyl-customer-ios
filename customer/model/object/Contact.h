#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Zip_Code;

@interface Contact : BaseClass
{

}

@property (nonatomic, strong) NSNumber *contact_id;
@property (nonatomic, strong) NSNumber *facebook_id;
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Zip_Code *zip_code_obj;

@end
