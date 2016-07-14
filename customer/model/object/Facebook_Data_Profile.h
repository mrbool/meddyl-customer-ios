#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Facebook_Data_Profile : BaseClass
{

}

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *fb_profile_id;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *middle_name;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSString *updated_time;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *verified;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;

@end
