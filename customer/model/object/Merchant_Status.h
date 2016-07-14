#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Merchant_Status : BaseClass
{

}

@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSNumber *order_id;

@end
