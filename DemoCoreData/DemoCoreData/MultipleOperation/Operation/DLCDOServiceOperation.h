//
//  CDOOperation.h
//  BusinessApplication
//
//  Created by Shankar on 04/05/17.
//
//

#import <Foundation/Foundation.h>

@interface DLCDOServiceOperation : NSOperation
//@property(nonatomic,strong) void (^handler)(NSData *serviceResponse,BOOL success, NSError *connectionError);
@property(nonatomic,strong) NSData *serviceResponse;
@property  (nonatomic,assign) BOOL opExecuting;
@property  (nonatomic,assign) BOOL opFinished;

@end
