/*============================================================================
 PROJECT: visopa_merchant
 FILE:    NSObject+JSON.h
 AUTHOR:  Tai Ho
 DATE:    8/21/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import <Foundation/Foundation.h>

/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/
@protocol JSONSerializableObject <NSObject>
+ (NSDictionary*)specificationProperties;
@end
/*============================================================================
 Interface:   NSObject_JSON
 =============================================================================*/
FOUNDATION_EXPORT  NSString *const kPropertyName;
FOUNDATION_EXPORT  NSString *const kPropertyType;
FOUNDATION_EXPORT  NSString *const kPropertyInstanceType;

@interface NSObject (JSON)

- (id)jsonValue;
- (NSString*)jsonString;
+ (instancetype)objectFromJSON:(id)json;
@end
