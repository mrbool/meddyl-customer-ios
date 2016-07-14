#import "GTLabel.h"

@implementation GTLabel

/* form methods */
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self Initialize];
}


/* public methods */
-(void)Initialize
{
    //[self setFont:[UIFont fontWithName:@"Brown-Regular" size:20]];
    [self setFont:[UIFont fontWithName:@"Avenir Next" size:18]];
    self.textColor = [UIColor colorWithRed:86.0/255.0 green:90.0/255 blue:92.0/255.0 alpha:1];
    
}



@end
