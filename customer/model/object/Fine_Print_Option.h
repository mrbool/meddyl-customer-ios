#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Fine_Print_Option : BaseClass
{

}

@property (nonatomic, strong) NSNumber *option_id;
@property (nonatomic, strong) NSString *display;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, retain) NSNumber *is_selected;
@property (nonatomic, retain) NSNumber *is_active;
@property (nonatomic, strong) NSNumber *order_id;

@end
