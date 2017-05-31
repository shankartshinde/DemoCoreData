//
//  LoginOperation.h
//  BusinessApplication
//
//  Created by Shankar on 04/05/17.
//
//

#import <Foundation/Foundation.h>

@interface LoginOperation : NSOperation
{
}

@property  (strong) NSDictionary *mainDataDictionary;
//@property  (nonatomic,strong) Login *login;
@property  (nonatomic,assign) BOOL opExecuting;
@property  (nonatomic,assign) BOOL opFinished;
@property(nonatomic,strong) NSMutableString *serviceResponse;

-(id)initWithData:(id)dataDictionary;
@end
