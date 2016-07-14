#import <Foundation/Foundation.h>
#import "JSONResponse.h"
#import "JSONSuccessfulResponse.h"
#import "JSONErrorResponse.h"
#import "Application_Type.h"
#import "Certificate.h"
#import "Certificate_Log.h"
#import "Certificate_Payment.h"
#import "Certificate_Status.h"
#import "City.h"
#import "Contact.h"
#import "Contact_GPS_Log.h"
#import "Credit_Card.h"
#import "Credit_Card_Type.h"
#import "Customer.h"
#import "Customer_Search_Location_Type.h"
#import "Customer_Status.h"
#import "Deal.h"
#import "Deal_Fine_Print_Option.h"
#import "Deal_Log.h"
#import "Deal_Payment.h"
#import "Deal_Status.h"
#import "Deal_Validation.h"
#import "Email_Template.h"
#import "Facebook_Data_Friends.h"
#import "Facebook_Data_Hometown.h"
#import "Facebook_Data_Location.h"
#import "Facebook_Data_Profile.h"
#import "Fine_Print_Option.h"
#import "Industry.h"
#import "Login_Log.h"
#import "Merchant.h"
#import "Merchant_Contact.h"
#import "Merchant_Contact_Status.h"
#import "Merchant_Contact_Validation.h"
#import "Merchant_Rating.h"
#import "Merchant_Status.h"
#import "Neighborhood.h"
#import "Password_Reset.h"
#import "Password_Reset_Status.h"
#import "Payment_Log.h"
#import "Plivo_Phone_Number.h"
#import "Promotion.h"
#import "Promotion_Activity.h"
#import "Promotion_Type.h"
#import "SMS_Template.h"
#import "State.h"
#import "System_Error.h"
#import "System_Settings.h"
#import "System_Successful.h"
#import "System_Users.h"
#import "Time_Zone.h"
#import "Twilio_Phone_Number.h"
#import "Zip_Code.h"

@interface REST_CustomerService : NSObject

@property (nonatomic, strong) NSString *web_service;

-(id) initWithService:(NSString *)str;

-(void) Get_Application_Settings:(Login_Log*)login_log_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_System_Settings:(System_Settings*)system_settings_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Industry_Parent_Level:(Industry*)industry_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Register:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Login:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Forgot_Password:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Login_With_Facebook:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Customer_Profile:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Update_Customer:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Update_Customer_Settings:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Add_Credit_Card:(Credit_Card*)credit_card_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Delete_Credit_Card:(Credit_Card*)credit_card_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Set_Default_Credit_Card:(Credit_Card*)credit_card_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Credit_Cards:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Valid_Promotions:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Deals:(NSNumber*)customer_id latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Deal_Detail:(Certificate*)certificate_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Buy_Certificate:(Certificate_Payment*)certificate_payment_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Customer_Active_Certificates:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Customer_Certificates:(Customer*)customer_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Certificate_Detail:(Certificate*)certificate_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Get_Payment:(Certificate*)certificate_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;
-(void) Apply_Promotion:(Certificate_Payment*)certificate_payment_obj withResponse:(void(^)(JSONResponse *response)) completionBlock;

@end
