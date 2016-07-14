#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Twilio_Phone_Number : BaseClass
{

}

@property (nonatomic, strong) NSNumber *phone_id;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, retain) NSNumber *is_active;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;

@end
