#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Credit_Card;
@class Deal;
@class Promotion_Activity;
@class Application_Type;

@interface Deal_Payment : BaseClass
{

}

@property (nonatomic, strong) NSNumber *payment_id;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSNumber *credit_card_id;
@property (nonatomic, strong) NSNumber *promotion_activity_id;
@property (nonatomic, strong) NSString *card_holder_name;
@property (nonatomic, strong) NSString *card_number;
@property (nonatomic, strong) NSString *card_expiration_date;
@property (nonatomic, strong) NSDecimalNumber *payment_amount;
@property (nonatomic, strong) NSDate *payment_date_utc_stamp;
@property (nonatomic, strong) Credit_Card *credit_card_obj;
@property (nonatomic, strong) Deal *deal_obj;
@property (nonatomic, strong) Promotion_Activity *promotion_activity_obj;
@property (nonatomic, strong) Application_Type *application_type_obj;

@end
