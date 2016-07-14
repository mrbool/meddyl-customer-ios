#import <UIKit/UIKit.h>
#import "Base_Controller.h"
#import "JSONResponse.h"
#import "JSONSuccessfulResponse.h"
#import "JSONErrorResponse.h"
#import "REST_CustomerService.h"

@interface System_Controller : Base_Controller

@property (nonatomic, copy) NSMutableArray *application_type_obj_array;
@property (nonatomic, strong) Certificate *certificate_obj;
@property (nonatomic, copy) NSMutableArray *certificate_obj_array;
@property (nonatomic, strong) Certificate_Log *certificate_log_obj;
@property (nonatomic, copy) NSMutableArray *certificate_log_obj_array;
@property (nonatomic, strong) Certificate_Payment *certificate_payment_obj;
@property (nonatomic, copy) NSMutableArray *certificate_payment_obj_array;
@property (nonatomic, strong) Certificate_Status *certificate_status_obj;
@property (nonatomic, copy) NSMutableArray *certificate_status_obj_array;
@property (nonatomic, strong) City *city_obj;
@property (nonatomic, copy) NSMutableArray *city_obj_array;
@property (nonatomic, strong) Contact *contact_obj;
@property (nonatomic, copy) NSMutableArray *contact_obj_array;
@property (nonatomic, strong) Contact_GPS_Log *contact_gps_log_obj;
@property (nonatomic, copy) NSMutableArray *contact_gps_log_obj_array;
@property (nonatomic, strong) Credit_Card *credit_card_obj;
@property (nonatomic, copy) NSMutableArray *credit_card_obj_array;
@property (nonatomic, strong) Credit_Card_Type *credit_card_type_obj;
@property (nonatomic, copy) NSMutableArray *credit_card_type_obj_array;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, copy) NSMutableArray *customer_obj_array;
@property (nonatomic, strong) Customer_Search_Location_Type *customer_search_location_type_obj;
@property (nonatomic, copy) NSMutableArray *customer_search_location_type_obj_array;
@property (nonatomic, strong) Customer_Status *customer_status_obj;
@property (nonatomic, copy) NSMutableArray *customer_status_obj_array;
@property (nonatomic, strong) Deal *deal_obj;
@property (nonatomic, copy) NSMutableArray *deal_obj_array;
@property (nonatomic, strong) Deal_Fine_Print_Option *deal_fine_print_option_obj;
@property (nonatomic, copy) NSMutableArray *deal_fine_print_option_obj_array;
@property (nonatomic, strong) Deal_Log *deal_log_obj;
@property (nonatomic, copy) NSMutableArray *deal_log_obj_array;
@property (nonatomic, strong) Deal_Payment *deal_payment_obj;
@property (nonatomic, copy) NSMutableArray *deal_payment_obj_array;
@property (nonatomic, strong) Deal_Status *deal_status_obj;
@property (nonatomic, copy) NSMutableArray *deal_status_obj_array;
@property (nonatomic, strong) Deal_Validation *deal_validation_obj;
@property (nonatomic, copy) NSMutableArray *deal_validation_obj_array;
@property (nonatomic, strong) Email_Template *email_template_obj;
@property (nonatomic, copy) NSMutableArray *email_template_obj_array;
@property (nonatomic, strong) Facebook_Data_Friends *facebook_data_friends_obj;
@property (nonatomic, copy) NSMutableArray *facebook_data_friends_obj_array;
@property (nonatomic, strong) Facebook_Data_Hometown *facebook_data_hometown_obj;
@property (nonatomic, copy) NSMutableArray *facebook_data_hometown_obj_array;
@property (nonatomic, strong) Facebook_Data_Location *facebook_data_location_obj;
@property (nonatomic, copy) NSMutableArray *facebook_data_location_obj_array;
@property (nonatomic, strong) Facebook_Data_Profile *facebook_data_profile_obj;
@property (nonatomic, copy) NSMutableArray *facebook_data_profile_obj_array;
@property (nonatomic, strong) Fine_Print_Option *fine_print_option_obj;
@property (nonatomic, copy) NSMutableArray *fine_print_option_obj_array;
@property (nonatomic, strong) Industry *industry_obj;
@property (nonatomic, copy) NSMutableArray *industry_obj_array;
@property (nonatomic, copy) NSMutableArray *login_log_obj_array;
@property (nonatomic, strong) Merchant *merchant_obj;
@property (nonatomic, copy) NSMutableArray *merchant_obj_array;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;
@property (nonatomic, copy) NSMutableArray *merchant_contact_obj_array;
@property (nonatomic, strong) Merchant_Contact_Status *merchant_contact_status_obj;
@property (nonatomic, copy) NSMutableArray *merchant_contact_status_obj_array;
@property (nonatomic, strong) Merchant_Contact_Validation *merchant_contact_validation_obj;
@property (nonatomic, copy) NSMutableArray *merchant_contact_validation_obj_array;
@property (nonatomic, strong) Merchant_Rating *merchant_rating_obj;
@property (nonatomic, copy) NSMutableArray *merchant_rating_obj_array;
@property (nonatomic, strong) Merchant_Status *merchant_status_obj;
@property (nonatomic, copy) NSMutableArray *merchant_status_obj_array;
@property (nonatomic, strong) Neighborhood *neighborhood_obj;
@property (nonatomic, copy) NSMutableArray *neighborhood_obj_array;
@property (nonatomic, strong) Password_Reset *password_reset_obj;
@property (nonatomic, copy) NSMutableArray *password_reset_obj_array;
@property (nonatomic, strong) Password_Reset_Status *password_reset_status_obj;
@property (nonatomic, copy) NSMutableArray *password_reset_status_obj_array;
@property (nonatomic, strong) Payment_Log *payment_log_obj;
@property (nonatomic, copy) NSMutableArray *payment_log_obj_array;
@property (nonatomic, strong) Plivo_Phone_Number *plivo_phone_number_obj;
@property (nonatomic, copy) NSMutableArray *plivo_phone_number_obj_array;
@property (nonatomic, strong) Promotion *promotion_obj;
@property (nonatomic, copy) NSMutableArray *promotion_obj_array;
@property (nonatomic, strong) Promotion_Activity *promotion_activity_obj;
@property (nonatomic, copy) NSMutableArray *promotion_activity_obj_array;
@property (nonatomic, strong) Promotion_Type *promotion_type_obj;
@property (nonatomic, copy) NSMutableArray *promotion_type_obj_array;
@property (nonatomic, strong) SMS_Template *sms_template_obj;
@property (nonatomic, copy) NSMutableArray *sms_template_obj_array;
@property (nonatomic, strong) State *state_obj;
@property (nonatomic, copy) NSMutableArray *state_obj_array;
@property (nonatomic, strong) System_Error *system_error_obj;
@property (nonatomic, copy) NSMutableArray *system_error_obj_array;
@property (nonatomic, strong) System_Settings *system_settings_obj;
@property (nonatomic, copy) NSMutableArray *system_settings_obj_array;
@property (nonatomic, strong) System_Successful *system_successful_obj;
@property (nonatomic, copy) NSMutableArray *system_successful_obj_array;
@property (nonatomic, strong) Time_Zone *time_zone_obj;
@property (nonatomic, copy) NSMutableArray *time_zone_obj_array;
@property (nonatomic, strong) Twilio_Phone_Number *twilio_phone_number_obj;
@property (nonatomic, copy) NSMutableArray *twilio_phone_number_obj_array;
@property (nonatomic, strong) Zip_Code *zip_code_obj;
@property (nonatomic, copy) NSMutableArray *zip_code_obj_array;


- (void)Get_Application_Settings:(void(^)(void))completionBlock;
- (void)Get_System_Settings:(void(^)(void))completionBlock;
- (void)Get_Industry_Parent_Level:(void(^)(void))completionBlock;

@end
