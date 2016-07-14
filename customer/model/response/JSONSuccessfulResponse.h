
#import "JSONResponse.h"
#import "System_Successful.h"

@interface JSONSuccessfulResponse : JSONResponse

@property (nonatomic, strong) System_Successful *system_successful_obj;
@property (nonatomic, strong) id data_obj;

@end
