#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class City;
@class Time_Zone;

@interface Zip_Code : BaseClass
{

}

@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSNumber *city_id;
@property (nonatomic, strong) NSNumber *time_zone_id;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) City *city_obj;
@property (nonatomic, strong) Time_Zone *time_zone_obj;
@property (nonatomic, copy) NSMutableArray *neighborhood_obj_array;

@end
