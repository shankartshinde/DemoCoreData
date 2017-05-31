//
//  CDOOperation.m
//  BusinessApplication
//
//  Created by Shankar on 04/05/17.
//
//

#import "DLCDOServiceOperation.h"
//#import "CDORepository.h"

@interface DLCDOServiceOperation()
@end

@implementation DLCDOServiceOperation
//-(id)initWithData:(id)dataDictionary
//{
//    if (self = [super init])
//    {
//        [self setValue:@NO forKey:@"opExecuting"];
//        [self setValue:@NO forKey:@"opFinished"];
//    }
//    return self;
//}

-(id)init
{
    if (self = [super init])
    {
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
    @try {
    if(self.isCancelled)
        return;
    
    [self setValue:@YES forKey:@"opExecuting"];
    /*
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@/%d", [ServerConstants getConstants].SERVER_URL, [CDOServerConstants getConstants].LOOK_UP_SERVICE, @"/getAllCdoMgmtByUpdatedDateLocationSpecific/", [CDORepository lastUpdatedDate],[StaticVariables sharedSingleton].isLocationSpecificCDO];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    if([[NetworkConnectionConstant networkConstant] SESSION_ID]!=nil&&[[[NetworkConnectionConstant networkConstant] SESSION_ID] length]!=0)
        [request addValue:[[NetworkConnectionConstant networkConstant] SESSION_ID] forHTTPHeaderField:@"Cookie"];
    [request addValue:@"1.0" forHTTPHeaderField:@"HTTP"];
    [request setHTTPMethod:kGet];
    
    NSLog(@"HEADER FIELD :%@",request.allHTTPHeaderFields);
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    if([[NetworkConnectionConstant networkConstant] SESSION_ID]==nil)
    {
        for(NSHTTPCookie *cookie in [defaultConfiguration.HTTPCookieStorage cookies])
        {
            [defaultConfiguration.HTTPCookieStorage deleteCookie:cookie];
        }
    }
    
    */
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://demo.ckan.org/api/3/action/package_list"]];
        NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"httpResponse.statusCode=>%d",httpResponse.statusCode);
        if (error)
        {
            _serviceResponse = data;
            [self setValue:@YES forKey:@"opFinished"];
        }
        else if (httpResponse.statusCode)
        {
            _serviceResponse = data;
            [self setValue:@YES forKey:@"opFinished"];
        }
        else
        {
            _serviceResponse = data;
            [self setValue:@YES forKey:@"opFinished"];
        }
    }];
    [datatask resume];
} @catch (NSException *exception) {
    NSLog(@"Exception:%@ %@",exception.description,exception.callStackSymbols);
}

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

@end
