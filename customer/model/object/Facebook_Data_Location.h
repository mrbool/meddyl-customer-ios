#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Facebook_Data_Location : BaseClass
{

}

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *fb_profile_id;
@property (nonatomic, strong) NSNumber *fb_location_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;

@end
