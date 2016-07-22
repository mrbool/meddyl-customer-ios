#import "System_Settings.h"
#import "Login_Log.h"

@implementation System_Settings

@synthesize auth_net_api_login_id;
@synthesize auth_net_transaction_key;
@synthesize certificate_cost_mode;
@synthesize certificate_customer_amount;
@synthesize certificate_days_valid_default;
@synthesize certificate_delay_hours;
@synthesize certificate_merchant_amount;
@synthesize certificate_merchant_percentage;
@synthesize certificate_quantity_info;
@synthesize certificate_quantity_min;
@synthesize certificate_quantity_max;
@synthesize customer_app_android_id;
@synthesize customer_app_ios_id;
@synthesize customer_app_terms;
@synthesize customer_deal_range_default;
@synthesize customer_deal_range_max;
@synthesize customer_deal_range_min;
@synthesize deal_fine_print;
@synthesize deal_instructions_default;
@synthesize deal_min_ranking;
@synthesize deal_max_ranking;
@synthesize deal_needs_credit_card;
@synthesize deal_new_customer_only_info;
@synthesize deal_new_customer_only;
@synthesize deal_use_immediately;
@synthesize deal_use_immediately_info;
@synthesize deal_validate;
@synthesize dollar_value_info;
@synthesize dollar_value_min;
@synthesize dollar_value_max;
@synthesize email_admin;
@synthesize email_on;
@synthesize email_system;
@synthesize email_validation;
@synthesize expiration_days_info;
@synthesize expiration_days_max;
@synthesize expiration_days_min;
@synthesize fb_app_id;
@synthesize fb_app_secret;
@synthesize fb_scope;
@synthesize fb_redirect_url;
@synthesize fine_print_more_characters;
@synthesize fine_print_more_default;
@synthesize google_api_key;
@synthesize gps_accuracy;
@synthesize gps_timeout;
@synthesize image_url;
@synthesize image_folder;
@synthesize mailgun_domain;
@synthesize mailgun_api_private_key;
@synthesize mailgun_api_public_key;
@synthesize mailgun_url;
@synthesize merchant_active_deals_max;
@synthesize merchant_app_android_id;
@synthesize merchant_app_ios_id;
@synthesize merchant_app_terms;
@synthesize merchant_contact_approve;
@synthesize merchant_contact_validate;
@synthesize merchant_description_characters;
@synthesize merchant_description_default;
@synthesize password_reset_days;
@synthesize pci_key;
@synthesize percent_off_default;
@synthesize percent_off_max;
@synthesize percent_off_min;
@synthesize plivo_auth_id;
@synthesize plivo_auth_token;
@synthesize promotion_referral_days;
@synthesize smtp_from_email;
@synthesize sms_on;
@synthesize sms_system;
@synthesize smtp_port;
@synthesize smtp_server;
@synthesize twilio_account_sid;
@synthesize twilio_auth_token;
@synthesize twilio_test_account_sid;
@synthesize twilio_test_auth_token;
@synthesize report;
@synthesize quantity;
@synthesize login_log_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"login_log_obj" : [Login_Log class]
		};
}

@end
