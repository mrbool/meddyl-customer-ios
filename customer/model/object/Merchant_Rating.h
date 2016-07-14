#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Merchant_Rating : BaseClass
{

}

@property (nonatomic, strong) NSNumber *rating_id;
@property (nonatomic, strong) NSDecimalNumber *rating;
@property (nonatomic, strong) NSString *image;

@end
