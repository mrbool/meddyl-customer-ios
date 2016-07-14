#import "REST_CustomerService.h"

@implementation REST_CustomerService

@synthesize web_service;

-(id)initWithService:(NSString *)web_service_config
{
	self = [super init];
	if(self)
	{
		self.web_service = web_service_config;
	}
	return self;
}


-(void)Get_Application_Settings:(Login_Log*)login_log_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"system/application_settings"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"login_log_obj": [login_log_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Application_Type objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_System_Settings:(System_Settings*)system_settings_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"system/system_settings"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"system_settings_obj": [system_settings_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [System_Settings objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Industry_Parent_Level:(Industry*)industry_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"system/industry/parent"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"industry_obj": [industry_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSArray *dictionary_data = [res objectForKey:@"JSONResponse"][@"data_obj"];
					NSMutableArray *industry_obj_array = dictionary_data.count > 0 ? [NSMutableArray new] : nil;
					[dictionary_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
						[industry_obj_array addObject:[Industry objectFromJSON:obj]];
					}];
					response.data_obj = industry_obj_array;

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Register:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/register"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Customer objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Login:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/login"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Customer objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Forgot_Password:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/forgot_password"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Login_With_Facebook:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/login_facebook"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Customer objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Customer_Profile:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/profile"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Customer objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Update_Customer:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/update"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Update_Customer_Settings:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/update_settings"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Add_Credit_Card:(Credit_Card*)credit_card_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/credit_card/add"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"credit_card_obj": [credit_card_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Credit_Card objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Delete_Credit_Card:(Credit_Card*)credit_card_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/credit_card/delete"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"credit_card_obj": [credit_card_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Set_Default_Credit_Card:(Credit_Card*)credit_card_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/credit_card/set_default"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"credit_card_obj": [credit_card_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Credit_Cards:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/credit_card/get_all"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSArray *dictionary_data = [res objectForKey:@"JSONResponse"][@"data_obj"];
					NSMutableArray *credit_card_obj_array = dictionary_data.count > 0 ? [NSMutableArray new] : nil;
					[dictionary_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
						[credit_card_obj_array addObject:[Credit_Card objectFromJSON:obj]];
					}];
					response.data_obj = credit_card_obj_array;

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Valid_Promotions:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"customer/valid_promotions"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSArray *dictionary_data = [res objectForKey:@"JSONResponse"][@"data_obj"];
					NSMutableArray *promotion_activity_obj_array = dictionary_data.count > 0 ? [NSMutableArray new] : nil;
					[dictionary_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
						[promotion_activity_obj_array addObject:[Promotion_Activity objectFromJSON:obj]];
					}];
					response.data_obj = promotion_activity_obj_array;

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Deals:(NSNumber*)customer_id latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/deals/?customer_id=%@&latitude=%@&longitude=%@", customer_id, latitude, longitude];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
	[request setAllHTTPHeaderFields:_headers];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSArray *dictionary_data = [res objectForKey:@"JSONResponse"][@"data_obj"];
					NSMutableArray *deal_obj_array = dictionary_data.count > 0 ? [NSMutableArray new] : nil;
					[dictionary_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
						[deal_obj_array addObject:[Deal objectFromJSON:obj]];
					}];
					response.data_obj = deal_obj_array;

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Deal_Detail:(Certificate*)certificate_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/deal_detail"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"certificate_obj": [certificate_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Deal objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Buy_Certificate:(Certificate_Payment*)certificate_payment_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/certificate/buy"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"certificate_payment_obj": [certificate_payment_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Certificate_Payment objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Customer_Active_Certificates:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/certificates/active"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSArray *dictionary_data = [res objectForKey:@"JSONResponse"][@"data_obj"];
					NSMutableArray *certificate_obj_array = dictionary_data.count > 0 ? [NSMutableArray new] : nil;
					[dictionary_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
						[certificate_obj_array addObject:[Certificate objectFromJSON:obj]];
					}];
					response.data_obj = certificate_obj_array;

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Customer_Certificates:(Customer*)customer_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/certificates"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"customer_obj": [customer_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSArray *dictionary_data = [res objectForKey:@"JSONResponse"][@"data_obj"];
					NSMutableArray *certificate_obj_array = dictionary_data.count > 0 ? [NSMutableArray new] : nil;
					[dictionary_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
						[certificate_obj_array addObject:[Certificate objectFromJSON:obj]];
					}];
					response.data_obj = certificate_obj_array;

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Certificate_Detail:(Certificate*)certificate_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/certificate"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"certificate_obj": [certificate_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Certificate objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Get_Payment:(Certificate*)certificate_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/get_payment"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"certificate_obj": [certificate_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Certificate_Payment objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


-(void)Apply_Promotion:(Certificate_Payment*)certificate_payment_obj withResponse:(void (^)(JSONResponse *))completionBlock
{
	NSString *uri=[NSString stringWithFormat:@"deal/apply_promotion"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", web_service, uri]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	NSString *json_request = [@{@"certificate_payment_obj": [certificate_payment_obj jsonValue]} jsonString];
	NSData *json_data = [json_request dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [json_data length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: json_data];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
	{
		if(data == nil)
		{
			System_Error *system_error_obj = [[System_Error alloc]init];
			system_error_obj.code = @500;
			system_error_obj.message = @"Web service error.  Please check your internet connection";

			JSONErrorResponse *response = [JSONErrorResponse new];
			response.successful = NO;
			response.system_error_obj = system_error_obj;

			completionBlock(response);
		}
		else
		{
			NSError *_errorJson = nil;
			NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
			if (_errorJson != nil)
			{
				System_Error *system_error_obj = [[System_Error alloc]init];
				system_error_obj.code = @500;
				system_error_obj.message = @"Web service error.  Please check your internet connection";

				JSONErrorResponse *response = [JSONErrorResponse new];
				response.successful = NO;
				response.system_error_obj = system_error_obj;

				completionBlock(response);
			}
			else
			{
				NSNumber *successful = res[@"JSONResponse"][@"successful"];
				if (successful.boolValue)
				{
					JSONSuccessfulResponse *response = [JSONSuccessfulResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_success = res[@"JSONResponse"][@"system_successful_obj"];
					response.system_successful_obj = [System_Successful objectFromJSON:dictionary_success];

					NSDictionary *dictionary_data = res[@"JSONResponse"][@"data_obj"];
					response.data_obj = [Certificate_Payment objectFromJSON:dictionary_data];

					completionBlock(response);
				}
				else
				{
					JSONErrorResponse *response = [JSONErrorResponse new];
					response.successful = [successful boolValue];

					NSDictionary *dictionary_error = res[@"JSONResponse"][@"system_error_obj"];
					response.system_error_obj = [System_Error objectFromJSON:dictionary_error];

					completionBlock(response);
				}
			}
		}
	}];
}


@end

