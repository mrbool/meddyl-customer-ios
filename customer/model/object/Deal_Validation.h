#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Deal;

@interface Deal_Validation : BaseClass
{

}

@property (nonatomic, strong) NSNumber *validation_id;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSString *validation_code;
@property (nonatomic, retain) NSNumber *is_validated;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Deal *deal_obj;

@end
