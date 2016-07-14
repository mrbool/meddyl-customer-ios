
#import "JSONResponse.h"
#import "System_Error.h"

@interface JSONErrorResponse : JSONResponse
{
    
}

@property (nonatomic, strong) System_Error *system_error_obj;

@end
