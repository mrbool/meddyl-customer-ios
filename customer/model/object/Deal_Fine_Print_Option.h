#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Deal;
@class Fine_Print_Option;

@interface Deal_Fine_Print_Option : BaseClass
{

}

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSNumber *option_id;
@property (nonatomic, strong) Deal *deal_obj;
@property (nonatomic, strong) Fine_Print_Option *fine_print_option_obj;

@end
