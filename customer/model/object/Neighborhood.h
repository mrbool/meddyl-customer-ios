#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Zip_Code;

@interface Neighborhood : BaseClass
{

}

@property (nonatomic, strong) NSNumber *neighborhood_id;
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSString *neighborhood;
@property (nonatomic, strong) Zip_Code *zip_code_obj;

@end
