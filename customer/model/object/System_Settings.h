#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Login_Log;

@interface System_Settings : BaseClass
{

}

@property (nonatomic, strong) NSString *auth_net_api_login_id;
@property (nonatomic, strong) NSString *auth_net_transaction_key;
@property (nonatomic, strong) NSNumber *certificate_cost_mode;
@property (nonatomic, strong) NSDecimalNumber *certificate_customer_amount;
@property (nonatomic, strong) NSNumber *certificate_days_valid_default;
@property (nonatomic, strong) NSNumber *certificate_delay_hours;
@property (nonatomic, strong) NSDecimalNumber *certificate_merchant_amount;
@property (nonatomic, strong) NSNumber *certificate_merchant_percentage;
@property (nonatomic, strong) NSString *certificate_quantity_info;
@property (nonatomic, strong) NSNumber *certificate_quantity_min;
@property (nonatomic, strong) NSNumber *certificate_quantity_max;
@property (nonatomic, strong) NSString *customer_app_android_id;
@property (nonatomic, strong) NSString *customer_app_ios_id;
@property (nonatomic, strong) NSString *customer_app_terms;
@property (nonatomic, strong) NSNumber *customer_deal_range_default;
@property (nonatomic, strong) NSNumber *customer_deal_range_max;
@property (nonatomic, strong) NSNumber *customer_deal_range_min;
@property (nonatomic, strong) NSNumber *customer_description_characters;
@property (nonatomic, strong) NSString *customer_description_default;
@property (nonatomic, strong) NSString *deal_instructions_default;
@property (nonatomic, strong) NSNumber *deal_min_ranking;
@property (nonatomic, strong) NSNumber *deal_max_ranking;
@property (nonatomic, retain) NSNumber *deal_needs_credit_card;
@property (nonatomic, strong) NSString *deal_new_customer_only_info;
@property (nonatomic, retain) NSNumber *deal_new_customer_only;
@property (nonatomic, retain) NSNumber *deal_use_immediately;
@property (nonatomic, strong) NSString *deal_use_immediately_info;
@property (nonatomic, retain) NSNumber *deal_validate;
@property (nonatomic, strong) NSString *dollar_value_info;
@property (nonatomic, strong) NSDecimalNumber *dollar_value_min;
@property (nonatomic, strong) NSDecimalNumber *dollar_value_max;
@property (nonatomic, strong) NSString *email_admin;
@property (nonatomic, retain) NSNumber *email_on;
@property (nonatomic, strong) NSString *email_system;
@property (nonatomic, retain) NSNumber *email_validation;
@property (nonatomic, strong) NSString *expiration_days_info;
@property (nonatomic, strong) NSNumber *expiration_days_max;
@property (nonatomic, strong) NSNumber *expiration_days_min;
@property (nonatomic, strong) NSString *fb_app_id;
@property (nonatomic, strong) NSString *fb_app_secret;
@property (nonatomic, strong) NSString *fb_scope;
@property (nonatomic, strong) NSString *fb_redirect_url;
@property (nonatomic, strong) NSNumber *fine_print_more_characters;
@property (nonatomic, strong) NSString *fine_print_more_default;
@property (nonatomic, strong) NSString *google_api_key;
@property (nonatomic, strong) NSString *gps_accuracy;
@property (nonatomic, strong) NSNumber *gps_timeout;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *image_folder;
@property (nonatomic, strong) NSString *mailgun_domain;
@property (nonatomic, strong) NSString *mailgun_api_private_key;
@property (nonatomic, strong) NSString *mailgun_api_public_key;
@property (nonatomic, strong) NSString *mailgun_url;
@property (nonatomic, strong) NSNumber *merchant_active_deals_max;
@property (nonatomic, strong) NSString *merchant_app_android_id;
@property (nonatomic, strong) NSString *merchant_app_ios_id;
@property (nonatomic, strong) NSString *merchant_app_terms;
@property (nonatomic, retain) NSNumber *merchant_contact_approve;
@property (nonatomic, retain) NSNumber *merchant_contact_validate;
@property (nonatomic, strong) NSNumber *password_reset_days;
@property (nonatomic, strong) NSString *pci_key;
@property (nonatomic, strong) NSNumber *percent_off_default;
@property (nonatomic, strong) NSNumber *percent_off_max;
@property (nonatomic, strong) NSNumber *percent_off_min;
@property (nonatomic, strong) NSString *plivo_auth_id;
@property (nonatomic, strong) NSString *plivo_auth_token;
@property (nonatomic, strong) NSNumber *promotion_referral_days;
@property (nonatomic, strong) NSString *smtp_from_email;
@property (nonatomic, retain) NSNumber *sms_on;
@property (nonatomic, strong) NSString *sms_system;
@property (nonatomic, strong) NSNumber *smtp_port;
@property (nonatomic, strong) NSString *smtp_server;
@property (nonatomic, strong) NSString *twilio_account_sid;
@property (nonatomic, strong) NSString *twilio_auth_token;
@property (nonatomic, strong) NSString *twilio_test_account_sid;
@property (nonatomic, strong) NSString *twilio_test_auth_token;
@property (nonatomic, strong) NSString *report;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) Login_Log *login_log_obj;

@end
