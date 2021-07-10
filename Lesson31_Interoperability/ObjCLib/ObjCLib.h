//
//  ObjCLib.h
//  ObjCLib
//
//  Created by Petr Blinov on 11.07.2021.
//

#import <Foundation/Foundation.h>
#import "ObjCSubLib.h"

@interface ObjCLib : NSObject

@property (strong, nonatomic, readonly) NSString *stringFromObjCLib;
@property (strong, nonatomic, readonly) ObjCSubLib *objCSubLib;

@end
