#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface SMS_Template : BaseClass
{

}

@property (nonatomic, strong) NSNumber *template_id;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *body;

@end
