#import "System_Controller.h"


@interface System_Controller()

@end


@implementation System_Controller

@synthesize application_type_obj_array;
@synthesize certificate_obj;
@synthesize certificate_obj_array;
@synthesize certificate_log_obj;
@synthesize certificate_log_obj_array;
@synthesize certificate_payment_obj;
@synthesize certificate_payment_obj_array;
@synthesize certificate_status_obj;
@synthesize certificate_status_obj_array;
@synthesize city_obj;
@synthesize city_obj_array;
@synthesize contact_obj;
@synthesize contact_obj_array;
@synthesize contact_gps_log_obj;
@synthesize contact_gps_log_obj_array;
@synthesize credit_card_obj;
@synthesize credit_card_obj_array;
@synthesize credit_card_type_obj;
@synthesize credit_card_type_obj_array;
@synthesize customer_obj;
@synthesize customer_obj_array;
@synthesize customer_search_location_type_obj;
@synthesize customer_search_location_type_obj_array;
@synthesize customer_status_obj;
@synthesize customer_status_obj_array;
@synthesize deal_obj;
@synthesize deal_obj_array;
@synthesize deal_fine_print_option_obj;
@synthesize deal_fine_print_option_obj_array;
@synthesize deal_log_obj;
@synthesize deal_log_obj_array;
@synthesize deal_payment_obj;
@synthesize deal_payment_obj_array;
@synthesize deal_status_obj;
@synthesize deal_status_obj_array;
@synthesize deal_validation_obj;
@synthesize deal_validation_obj_array;
@synthesize email_template_obj;
@synthesize email_template_obj_array;
@synthesize facebook_data_friends_obj;
@synthesize facebook_data_friends_obj_array;
@synthesize facebook_data_hometown_obj;
@synthesize facebook_data_hometown_obj_array;
@synthesize facebook_data_location_obj;
@synthesize facebook_data_location_obj_array;
@synthesize facebook_data_profile_obj;
@synthesize facebook_data_profile_obj_array;
@synthesize fine_print_option_obj;
@synthesize fine_print_option_obj_array;
@synthesize industry_obj;
@synthesize industry_obj_array;
@synthesize login_log_obj_array;
@synthesize merchant_obj;
@synthesize merchant_obj_array;
@synthesize merchant_contact_obj;
@synthesize merchant_contact_obj_array;
@synthesize merchant_contact_status_obj;
@synthesize merchant_contact_status_obj_array;
@synthesize merchant_contact_validation_obj;
@synthesize merchant_contact_validation_obj_array;
@synthesize merchant_status_obj;
@synthesize merchant_status_obj_array;
@synthesize neighborhood_obj;
@synthesize neighborhood_obj_array;
@synthesize password_reset_obj;
@synthesize password_reset_obj_array;
@synthesize password_reset_status_obj;
@synthesize password_reset_status_obj_array;
@synthesize payment_log_obj;
@synthesize payment_log_obj_array;
@synthesize plivo_phone_number_obj;
@synthesize plivo_phone_number_obj_array;
@synthesize promotion_obj;
@synthesize promotion_obj_array;
@synthesize promotion_activity_obj;
@synthesize promotion_activity_obj_array;
@synthesize promotion_type_obj;
@synthesize promotion_type_obj_array;
@synthesize sms_template_obj;
@synthesize sms_template_obj_array;
@synthesize state_obj;
@synthesize state_obj_array;
@synthesize system_error_obj;
@synthesize system_error_obj_array;
@synthesize system_settings_obj;
@synthesize system_settings_obj_array;
@synthesize system_successful_obj;
@synthesize system_successful_obj_array;
@synthesize time_zone_obj;
@synthesize time_zone_obj_array;
@synthesize twilio_phone_number_obj;
@synthesize twilio_phone_number_obj_array;
@synthesize zip_code_obj;
@synthesize zip_code_obj_array;



- (void)Get_Application_Settings:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	self.login_log_obj = [[Login_Log alloc]init];

	self.login_log_obj.application_type_obj = self.application_type_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Get_Application_Settings: self.login_log_obj withResponse:^(JSONResponse *response)
	{
		self.successful = response.successful;

		if (!self.successful)
		{
			system_error_obj = [[System_Error alloc] init];
			system_error_obj = ((JSONErrorResponse *)response).system_error_obj;
		}
		else
		{
			system_successful_obj = [[System_Successful alloc] init];
			system_successful_obj = ((JSONSuccessfulResponse *)response).system_successful_obj;

			self.application_type_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Get_System_Settings:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	system_settings_obj = [[System_Settings alloc]init];

	system_settings_obj.login_log_obj = self.login_log_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Get_System_Settings: system_settings_obj withResponse:^(JSONResponse *response)
	{
		self.successful = response.successful;

		if (!self.successful)
		{
			system_error_obj = [[System_Error alloc] init];
			system_error_obj = ((JSONErrorResponse *)response).system_error_obj;
		}
		else
		{
			system_successful_obj = [[System_Successful alloc] init];
			system_successful_obj = ((JSONSuccessfulResponse *)response).system_successful_obj;

			system_settings_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Get_Industry_Parent_Level:(void(^)(void))completionBlock
{
    system_error_obj = nil;
    system_successful_obj = nil;
    
    industry_obj = [[Industry alloc]init];
    
    //industry_obj.parent_industry_id = parent_industry_id;
    
    REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
    [i_rest Get_Industry_Parent_Level: industry_obj withResponse:^(JSONResponse *response)
     {
         self.successful = response.successful;
         
         if (!self.successful)
         {
             system_error_obj = [[System_Error alloc] init];
             system_error_obj = ((JSONErrorResponse *)response).system_error_obj;
         }
         else
         {
             system_successful_obj = [[System_Successful alloc] init];
             system_successful_obj = ((JSONSuccessfulResponse *)response).system_successful_obj;
             
             industry_obj_array = ((JSONSuccessfulResponse *)response).data_obj;
         }
         
         completionBlock();
     }];
}

@end
