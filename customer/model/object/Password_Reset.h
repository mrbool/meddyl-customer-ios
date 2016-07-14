#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Contact;
@class Password_Reset_Status;

@interface Password_Reset : BaseClass
{

}

@property (nonatomic, strong) NSString *reset_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSNumber *contact_id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) NSDate *expiration_date;
@property (nonatomic, strong) Contact *contact_obj;
@property (nonatomic, strong) Password_Reset_Status *password_reset_status_obj;

@end
