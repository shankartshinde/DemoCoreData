//
//  NirvanaOperation.h
//  BusinessApplication
//
//  Created by Shankar on 08/05/17.
//
//

#import <Foundation/Foundation.h>

/*
 { "cdoDescription" : "Object for locations",
 "cdoName" : "locations",
 "created" : 1363678740000,
 "createdBy" : 124,
 "id" : 1,
 "isLocationSpecific" : 0,
 "updated" : 1493982364000,
 "updatedBy" : 124,
 "versionNumber" : 1440
 }
 */

@interface NirvanaOperation : NSOperation
//@property (strong, nonatomic) NSString *cdoDescription;
//@property (strong, nonatomic) NSString *cdoName;
//@property (strong, nonatomic) NSNumber *created;
//@property (strong, nonatomic) NSNumber *createdBy;
//@property (strong, nonatomic) NSNumber *id;
//@property (strong, nonatomic) "isLocationSpecific" : 0,
//@property (strong, nonatomic) "updated" : 1493982364000,
//@property (strong, nonatomic) "updatedBy" : 124,
//@property (strong, nonatomic) "versionNumber" : 1440

@property (nonatomic, strong) NSNumber * cdoId;
@property (nonatomic, strong) NSString * created;
@property (nonatomic, strong) NSNumber * createdBy;
@property (nonatomic, strong) NSString * updatedTime;
@property (nonatomic, strong) NSNumber * updatedBy;
@property (nonatomic, strong) NSString * cdoName;
@property (nonatomic, strong) NSNumber * versionNumber;
@property (nonatomic, strong) NSString * cdoDescription;
@property (nonatomic, strong) NSString * schemaName;
@property (nonatomic, strong) NSNumber * isLocationSpecific;

@end
