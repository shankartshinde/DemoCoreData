//
//  DLCDOUserServiceOperation.m
//  BusinessApplication
//
//  Created by Shankar on 24/05/17.
//
//

#import "DLCDOUserServiceOperation.h"

@implementation DLCDOUserServiceOperation
-(id)init
{
    if (self = [super init])
    {
        [self setValue:@NO forKey:@"opExecuting"];
        [self setValue:@NO forKey:@"opFinished"];
    }
    return self;
}

-(void)main
{
    @try
    {
    if(self.isCancelled)
        return;
    
    [self setValue:@YES forKey:@"opExecuting"];
    /*
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@%@%@/%d/%d/%d", [[ServerConstants getConstants] SERVER_URL],[CDOServerConstants getConstants].LOOK_UP_SERVICE,[CDOServerConstants getConstants].SYNC_CDO_BYCDONAME_AND_UPDATEDDATE_ISLOCATIONSPECIFIC,[CDOServerConstants getConstants].USERS_CDO, _updatedTime,[StaticVariables sharedSingleton].isCDOLoadingFirstTime,[StaticVariables sharedSingleton].isLocationSpecificCDO,[[StaticVariables sharedSingleton].locationId intValue]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    if([[NetworkConnectionConstant networkConstant] SESSION_ID]!=nil&&[[[NetworkConnectionConstant networkConstant] SESSION_ID] length]!=0)
        [request addValue:[[NetworkConnectionConstant networkConstant] SESSION_ID] forHTTPHeaderField:@"Cookie"];
    [request addValue:@"1.0" forHTTPHeaderField:@"HTTP"];
    [request setHTTPMethod:kGet];
    
    //    NSData *paramData = [messageBody dataUsingEncoding:NSUTF8StringEncoding];
    //    [request setHTTPBody:paramData];
    */
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://demo.ckan.org/api/3/action/package_list"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"httpResponse.statusCode=>%d URL:%@",httpResponse.statusCode,response.URL);
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
