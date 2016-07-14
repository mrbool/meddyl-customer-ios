#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Merchant_Contact_Validation : BaseClass
{

}

@property (nonatomic, strong) NSNumber *validation_id;
@property (nonatomic, strong) NSString *validation_code;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *ip_address;
@property (nonatomic, retain) NSNumber *is_validated;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;

@end
