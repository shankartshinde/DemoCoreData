//
//  NirvanaSharedOperationQueue.h
//  BusinessApplication
//
//  Created by Shankar on 17/05/17.
//
//

#import <Foundation/Foundation.h>

@interface NirvanaSharedOperationQueue : NSObject
+ (instancetype) sharedInstance;
- (NSOperationQueue*) operationQueue;
@end
