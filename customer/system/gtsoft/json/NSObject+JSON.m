/*============================================================================
 PROJECT: visopa_merchant
 FILE:    NSObject+JSON.m
 AUTHOR:  Tai Ho
 DATE:    8/21/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "NSObject+JSON.h"
#import <objc/runtime.h>
#import "JSONKit.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
NSString *const kPropertyName = @"kPropertyName";
NSString *const kPropertyType = @"kPropertyType";
NSString *const kPropertyInstanceType = @"kPropertyInstanceType";

@implementation NSObject (JSON)

- (id)jsonValue
{
    if ([self conformsToProtocol:@protocol(JSONSerializableObject)])
    {
        /* get all properties of object */
        unsigned count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        NSMutableDictionary *result = count > 0 ? [NSMutableDictionary new] : nil;
        
        /* loop all properties, and and create dictionary */
        unsigned i;
        for (i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            id value = [self valueForKey:name];
            if (value)
            {
                if ([value conformsToProtocol:@protocol(JSONSerializableObject)])
                {
                    result[name] = [value jsonValue];
                }
                else if ([value isKindOfClass:[NSArray class]])
                {
                    if (((NSArray*)value).count > 0)
                    {
                        NSMutableArray *arr = [NSMutableArray new];
                        [((NSArray*)value) enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                         {
                             [arr addObject:[obj jsonValue]];
                         }];
                        result[name] = arr;
                    }
                }
                else
                {
                    /* built-in type */
                    const char * type = property_getAttributes(property);
                    NSString * typeString = [NSString stringWithUTF8String:type];
                    NSArray * attributes = [typeString componentsSeparatedByString:@","];
                    NSString * typeAttribute = [attributes objectAtIndex:0];
                    NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];  //turns @"NSDate" into NSDate
                    
                    if([typeClassName isEqual: @"NSDate"])
                    {
                        NSDate *date_value = [NSString Date_To_DotNet:value];
                        result[name] = date_value;
                    }
                    else
                    {
                        result[name] = value;
                    }
                }
            }
        }
        
        free(properties);
        
        return result;
    }
    else if ([self isKindOfClass:[NSArray class]])
    {
        NSMutableArray *arr = [NSMutableArray new];
        if (((NSArray*)self).count > 0)
        {
            [((NSArray*)self) enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
             {
                 [arr addObject:[obj jsonValue]];
             }];
        }
        
        return arr;
    }
    else if ([self isKindOfClass:[NSDictionary class]])
    {
        return self;
    }
    else
    {
        return self;
    }
}

- (NSString *)jsonString{
    return [[self jsonValue] JSONString];;
}


+ (instancetype)objectFromJSON:(id)json
{
    if (!json)
    {
        return nil;
    }
    
    /* get specification to know what custom type of every property */
    NSDictionary *specification = [self conformsToProtocol:@protocol(JSONSerializableObject)] ? [[self class] specificationProperties] : nil;
    
    if ([json isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = json;
        /* create temp dictionary with all keys were lower string */
        NSArray *allKeys = dict.allKeys;
        NSMutableDictionary *tempDict = [NSMutableDictionary new];
        [allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
         {
             tempDict[[key lowercaseString]] = dict[key];
         }];
        
        /* get all properties and assign values for them */
        id result = [[[self class] alloc] init];
        unsigned count;
        objc_property_t *properties = class_copyPropertyList([result class], &count);
        unsigned i;
        for (i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            id value = tempDict[[name lowercaseString]];
            
            /* if it is our custom object */
            if ([specification[name] conformsToProtocol:@protocol(JSONSerializableObject)])
            {
                Class instanceClass = specification[name];
                [result setValue:[instanceClass objectFromJSON:value] forKey:name];
            }
            else if ([specification[name] isKindOfClass:[NSDictionary class]] && specification[name][kPropertyInstanceType] && [value isKindOfClass:[NSArray class]])
            {
                NSMutableArray *arr = [NSMutableArray new];
                Class classType = specification[name][kPropertyInstanceType];
                [((NSArray*)value) enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                 {
                     [arr addObject:[classType objectFromJSON:obj]];
                 }];
                
                [result setValue:arr forKey:name];
                
                return result;
            }
            else
            {
                /* built-in type */
                const char * type = property_getAttributes(property);
                NSString * typeString = [NSString stringWithUTF8String:type];
                NSArray * attributes = [typeString componentsSeparatedByString:@","];
                NSString * typeAttribute = [attributes objectAtIndex:0];
                NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];  //turns @"NSDate" into NSDate
                
                if([typeClassName isEqual: @"NSDate"])
                {
                    NSDate *date_value = [NSDate Date_From_DotNet:value];
                    [result setValue:date_value forKey:name];
                }
                else
                {
                    [result setValue:value forKey:name];
                }
            }
        }
        
        free(properties);
        
        return result;
    }
    else if ([json isKindOfClass:[NSArray class]])
    {
        NSMutableArray *arr = [NSMutableArray new];
        
        [((NSArray*)json) enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             [arr addObject:[[obj class] objectFromJSON:obj]];
         }];
        
        return arr;
    }
    else
    {
        return json;;
    }
    
    return nil;
}


+(NSDate*) Date_From_DotNet:(NSString*)stringDate
{
    NSDate *returnValue;
    
    if([stringDate isEqualToString:@"/Date(0+0000)/"])
    {
        returnValue=nil;
    }
    else if ([stringDate isMemberOfClass:[NSNull class]])
    {
        returnValue=nil;
    }
    else
    {
        NSString *clean_string = [stringDate substringWithRange:NSMakeRange(6, 10)];
        
        returnValue= [NSDate dateWithTimeIntervalSince1970:[clean_string intValue]];
    }
    
    return returnValue;
}

-(NSString*) Date_To_DotNet:(NSDate *) date
{
    double milliseconds = [date timeIntervalSince1970];
    NSString *dotNetDate=[NSString stringWithFormat:@"/Date(%.0f%@)/", milliseconds, @"000+0000"];
    return  dotNetDate;
}


@end
