#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Application_Type : BaseClass
{

}

@property (nonatomic, strong) NSNumber *application_type_id;
@property (nonatomic, strong) NSString *application_type;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, retain) NSNumber *is_down;
@property (nonatomic, strong) NSString *down_message;

@end
