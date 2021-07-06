//
//  PizzaIngridients.h
//  Lesson29Homework_ObjC
//
//  Created by Petr Blinov on 06.07.2021.
//

#import <Foundation/Foundation.h>
#import "DelegateProtocol.h"

@interface PizzaIngridients: NSObject
@property (nonatomic, weak) id<DelegateProtocol> current;
- (void)getIngridients;
@end
