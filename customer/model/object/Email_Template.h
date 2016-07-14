#import <Foundation/Foundation.h>
#import "BaseClass.h"


@interface Email_Template : BaseClass
{

}

@property (nonatomic, strong) NSNumber *template_id;
@property (nonatomic, strong) NSString *from_email;
@property (nonatomic, strong) NSString *from_display;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, retain) NSNumber *is_html;

@end
