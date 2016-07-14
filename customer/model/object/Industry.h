#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Industry;

@interface Industry : BaseClass
{

}

@property (nonatomic, strong) NSNumber *industry_id;
@property (nonatomic, strong) NSNumber *parent_industry_id;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *order_id;
@property (nonatomic, strong) Industry *industry_obj;
@property (nonatomic, strong) NSNumber *active;

@end
