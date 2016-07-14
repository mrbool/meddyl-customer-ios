#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Contact;

@interface Contact_GPS_Log : BaseClass
{

}

@property (nonatomic, strong) NSNumber *log_id;
@property (nonatomic, strong) NSNumber *contact_id;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Contact *contact_obj;

@end
