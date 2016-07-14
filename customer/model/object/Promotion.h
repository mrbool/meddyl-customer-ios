#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Customer;
@class Promotion_Type;
@class Application_Type;

@interface Promotion : BaseClass
{

}

@property (nonatomic, strong) NSNumber *promotion_id;
@property (nonatomic, strong) NSNumber *promotion_type_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSString *promotion_code;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *expiration_date;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Promotion_Type *promotion_type_obj;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) Application_Type *application_type_obj;

@end
