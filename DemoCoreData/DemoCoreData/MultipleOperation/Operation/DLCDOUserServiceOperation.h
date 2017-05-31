//
//  DLCDOUserServiceOperation.h
//  BusinessApplication
//
//  Created by Shankar on 24/05/17.
//
//

#import <Foundation/Foundation.h>

@interface DLCDOUserServiceOperation : NSOperation
@property(nonatomic,strong) NSData *serviceResponse;
@property  (nonatomic,assign) BOOL opExecuting;
@property  (nonatomic,assign) BOOL opFinished;
@property(nonatomic,strong) NSString *updatedTime;
@end
