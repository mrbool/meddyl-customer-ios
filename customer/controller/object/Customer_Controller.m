#import "Customer_Controller.h"


@interface Customer_Controller()

@end


@implementation Customer_Controller

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



- (void)Register:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

    zip_code_obj.latitude = contact_gps_log_obj.latitude;
    zip_code_obj.longitude = contact_gps_log_obj.longitude;
    
    contact_obj.zip_code_obj = zip_code_obj;

	customer_obj = [[Customer alloc]init];
	customer_obj.login_log_obj = self.login_log_obj;
	customer_obj.contact_obj = contact_obj;
    //customer_obj.customer_search_location_type_obj = customer_search_location_type_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Register: customer_obj withResponse:^(JSONResponse *response)
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

			customer_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Login:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;
    
    zip_code_obj = [[Zip_Code alloc]init];
    zip_code_obj.latitude = contact_gps_log_obj.latitude;
    zip_code_obj.longitude = contact_gps_log_obj.longitude;
    
    contact_obj.zip_code_obj = zip_code_obj;

	customer_obj = [[Customer alloc]init];
	customer_obj.login_log_obj = self.login_log_obj;
	customer_obj.contact_obj = contact_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Login: customer_obj withResponse:^(JSONResponse *response)
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

			customer_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Login_With_Facebook:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;
    
    if(zip_code_obj == nil)
        zip_code_obj = [[Zip_Code alloc]init];
    zip_code_obj.latitude = contact_gps_log_obj.latitude;
    zip_code_obj.longitude = contact_gps_log_obj.longitude;

    contact_obj = [[Contact alloc]init];
    contact_obj.zip_code_obj = zip_code_obj;
    
	customer_obj = [[Customer alloc]init];
	customer_obj.login_log_obj = self.login_log_obj;
	customer_obj.contact_obj = contact_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Login_With_Facebook: customer_obj withResponse:^(JSONResponse *response)
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

			customer_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Forgot_Password:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	customer_obj = [[Customer alloc]init];

	customer_obj.login_log_obj = self.login_log_obj;
	customer_obj.contact_obj = contact_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Forgot_Password: customer_obj withResponse:^(JSONResponse *response)
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
		}

		completionBlock();
	}];
}

- (void)Get_Customer_Profile:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	customer_obj.login_log_obj = self.login_log_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Get_Customer_Profile: customer_obj withResponse:^(JSONResponse *response)
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

			customer_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Update_Customer:(void(^)(void))completionBlock
{
    system_error_obj = nil;
    system_successful_obj = nil;
    
    customer_obj.login_log_obj = self.login_log_obj;
    customer_obj.contact_obj = contact_obj;
    
    REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
    [i_rest Update_Customer: customer_obj withResponse:^(JSONResponse *response)
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
         }
         
         completionBlock();
     }];
}

- (void)Update_Customer_Settings:(void(^)(void))completionBlock
{
    system_error_obj = nil;
    system_successful_obj = nil;
        
    customer_obj.login_log_obj = self.login_log_obj;
    customer_obj.zip_code_obj = zip_code_obj;
    customer_obj.customer_search_location_type_obj = customer_search_location_type_obj;
    
    REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
    [i_rest Update_Customer_Settings: customer_obj withResponse:^(JSONResponse *response)
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
         }
         
         completionBlock();
     }];
}

- (void)Add_Credit_Card:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	credit_card_obj.login_log_obj = self.login_log_obj;
	credit_card_obj.customer_obj = customer_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Add_Credit_Card: credit_card_obj withResponse:^(JSONResponse *response)
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

			credit_card_obj = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Delete_Credit_Card:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	credit_card_obj.login_log_obj = self.login_log_obj;
	credit_card_obj.customer_obj = customer_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Delete_Credit_Card: credit_card_obj withResponse:^(JSONResponse *response)
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
		}

		completionBlock();
	}];
}

- (void)Get_Credit_Cards:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	customer_obj.login_log_obj = self.login_log_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Get_Credit_Cards: customer_obj withResponse:^(JSONResponse *response)
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

			credit_card_obj_array = ((JSONSuccessfulResponse *)response).data_obj;
		}

		completionBlock();
	}];
}

- (void)Set_Default_Credit_Card:(void(^)(void))completionBlock
{
	system_error_obj = nil;
	system_successful_obj = nil;

	credit_card_obj.login_log_obj = self.login_log_obj;
	credit_card_obj.customer_obj = customer_obj;

	REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
	[i_rest Set_Default_Credit_Card: credit_card_obj withResponse:^(JSONResponse *response)
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
		}

		completionBlock();
	}];
}

- (void)Get_Valid_Promotions:(void(^)(void))completionBlock
{
    system_error_obj = nil;
    system_successful_obj = nil;
    
    customer_obj.login_log_obj = self.login_log_obj;
    
    REST_CustomerService *i_rest = [[REST_CustomerService alloc] initWithService:customer_service];
    [i_rest Get_Valid_Promotions: customer_obj withResponse:^(JSONResponse *response)
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
             
             promotion_activity_obj_array = ((JSONSuccessfulResponse *)response).data_obj;
         }
         
         completionBlock();
     }];
}

@end
