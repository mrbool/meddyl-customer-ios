#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class State;

@interface City : BaseClass
{

}

@property (nonatomic, strong) NSNumber *city_id;
@property (nonatomic, strong) NSNumber *state_id;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) State *state_obj;

@end
