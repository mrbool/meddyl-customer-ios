#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Time_Zone : BaseClass
{

}

@property (nonatomic, strong) NSNumber *time_zone_id;
@property (nonatomic, strong) NSString *time_zone;
@property (nonatomic, strong) NSString *abbreviation;
@property (nonatomic, strong) NSNumber *offset;

@end
