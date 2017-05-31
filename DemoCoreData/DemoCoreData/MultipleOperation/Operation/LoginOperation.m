//
//  LoginOperation.m
//  BusinessApplication
//
//  Created by Shankar on 04/05/17.
//
//

#import "LoginOperation.h"

@implementation LoginOperation
-(id)initWithData:(id)dataDictionary
{
    if (self = [super init])
    {
        //_mainDataDictionary = dataDictionary;
//        _opExecuting = NO;
//        _opFinished = NO;
        [self setValue:@NO forKey:@"opExecuting"];
        [self setValue:@NO forKey:@"opFinished"];
    }
    return self;
}

-(id)init
{
    if (self = [super init])
    {
        //_mainDataDictionary = dataDictionary;
        //        _opExecuting = NO;
        //        _opFinished = NO;
        [self setValue:@NO forKey:@"opExecuting"];
        [self setValue:@NO forKey:@"opFinished"];
    }
    return self;
}


//-(void)start
//{
//    if ([self isCancelled])
//    {
//        // Must move the operation to the finished state if it is canceled.
//        [self willChangeValueForKey:@"isFinished"];
//        finished = YES;
//        [self didChangeValueForKey:@"isFinished"];
//        return;
//    }
//    // If the operation is not canceled, begin executing the task.
//    [self willChangeValueForKey:@"isExecuting"];
//    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
//    executing = YES;
//    [self didChangeValueForKey:@"isExecuting"];
//}

//-(void)main
//{
//    //This is the method that will do the work
//    @try {
//        NSLog(@"Custom Operation - Main Method isMainThread?? ANS = %@",[NSThread isMainThread]? @"YES":@"NO");
//        NSLog(@"Custom Operation - Main Method [NSThread currentThread] %@",[NSThread currentThread]);
//        NSLog(@"Custom Operation - Main Method Try Block - Do Some work here");
//        NSLog(@"Custom Operation - Main Method The data that was passed is %@",_mainDataDictionary);
//        for (int i = 0; i<5; i++)
//        {
//            NSLog(@"i%d",i);
//            sleep(1); //Never put sleep in production code until and unless the situation demands. A sleep is induced here to demonstrate a scenario that takes some time to complete
//        }
//        [self willChangeValueForKey:@"isExecuting"];
//        executing = NO;
//        [self didChangeValueForKey:@"isExecuting"];
//        
//        [self willChangeValueForKey:@"isFinished"];
//        finished = YES;
//        [self didChangeValueForKey:@"isFinished"];
//        
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Catch the exception %@",[exception description]);
//    }
//    @finally {
//        NSLog(@"Custom Operation - Main Method - Finally block");
//    }
//}

-(void)main
{
    if(self.isCancelled)
        return;
    
    [self setValue:@YES forKey:@"opExecuting"];
    
/*    NSMutableString *messageBody = [[NSMutableString alloc] initWithString:[self createLoginObjString]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@/login", [[ServerConstants getConstants] SERVER_URL], [ServerConstants getConstants].SERVICE_PREFIX,[ServerConstants GLOBAL_LOGIN_SERVICE],[[ServerConstants getConstants] SERVICE_VERSION]];
    [StaticVariables sharedSingleton].deviceIPAddress = _login.ipAddress;
    [[NetworkConnectionConstant networkConstant] setSESSION_ID:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"1.0" forHTTPHeaderField:@"HTTP"];
    [request setHTTPMethod:kPost];
    NSData *paramData = [messageBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:paramData];
*/
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://demo.ckan.org/api/3/action/package_list"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode && !error)
        {
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];
            NSString *cookie = [fields valueForKey:@"Set-Cookie"];
            
            //@author Ketan:- only need to reset session on login
/*            if(![POSUtility isNullString:cookie] &&
               [[NetworkConnectionConstant networkConstant] ISREST_SESSION_ID])
            {
                NSLog(@"Shankar : come for create sessionID");
                [[NetworkConnectionConstant networkConstant] setISREST_SESSION_ID:NO];
                [self saveCookieString:cookie];
            }
*/
            NSLog(@"httpResponse.statusCode=>%ld URL:%@",httpResponse.statusCode,response.URL);
            id serviceResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //NSLog(@"Response of login service :%@",serviceResponse);
            //_opFinished = YES;
            NSMutableString *tempString = [[NSMutableString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            _serviceResponse = tempString;
            [self setValue:@YES forKey:@"opFinished"];
        }
    }];
    [datatask resume];
}



-(void)setOpFinished:(BOOL)_source
{
    [self willChangeValueForKey:@"opFinished"];
    _opFinished = _source;
    _opExecuting =  NO;
    [self didChangeValueForKey:@"opFinished"];
}

-(void)setOpExecuting:(BOOL)_source
{
    [self willChangeValueForKey:@"opExecutin"];
    _opExecuting = _source;
    [self didChangeValueForKey:@"opExecutin"];
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"opFinished"])
    {
        return NO;
    }
    else if ([key isEqualToString:@"opExecutin"])
    {
        return NO;
    }
    else{
        return [super automaticallyNotifiesObserversForKey:key];
    }
}
/*
- (void)saveCookieString:(NSString *)cookieString
{
    @try
    {
        NSLog(@"CREATE SESSION FROM STRING:%@",cookieString);
        @autoreleasepool
        {
            NSArray *componentArray = [cookieString componentsSeparatedByString:@","];
            
            NSString *sessionIdString = nil;
            
            NSString *encryptionKeyString = nil;
            
            if(componentArray.count!=0)
                sessionIdString = [componentArray firstObject];
            
            if(componentArray.count>=2)
                encryptionKeyString = [componentArray objectAtIndex:1];
            
            NSArray *sessionComponentArray = [sessionIdString componentsSeparatedByString:@";"];
            
            NSString *sessionStr = nil;
            
            if(sessionComponentArray.count>=2)
            {
                sessionStr = [NSString stringWithFormat:@"%@;%@", [sessionComponentArray firstObject], [sessionComponentArray lastObject]];
            }
            
            if([sessionStr length]!=0&&sessionStr!=nil&&![sessionStr isKindOfClass:[NSNull class]])
            {
                NSLog(@"%s SET SESSION_ID:%@",__PRETTY_FUNCTION__,sessionStr);
                
                //@author Ketan this condition is need to comment to handel one app for all condition
                
                // if([[[NetworkConnectionConstant networkConstant] SESSION_ID] length]==0||[[[NetworkConnectionConstant networkConstant] SESSION_ID] isKindOfClass:[NSNull class]])
                [[NetworkConnectionConstant networkConstant] setSESSION_ID:sessionStr];
            }
        }
    }
    @catch (NSException *exception)
    {
        LOGMACRO1ARGU(logLevelSevere,([self description]),([NSString stringWithFormat:@"%s",__FUNCTION__]),__LINE__,([exception description]),cookieString);
        
    }
}
*/
@end
