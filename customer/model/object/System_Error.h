#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface System_Error : BaseClass
{

}

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSString *message;

@end
