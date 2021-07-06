//
//  ViewController.m
//  Lesson29Homework_ObjC
//
//  Created by Petr Blinov on 05.07.2021.
//

#import "ViewController.h"
#import "DelegateProtocol.h"
#import "PizzaIngridients.h"


@interface ViewController () <DelegateProtocol>
@property (nonatomic, strong) PizzaIngridients *pizzaIngridients;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pizzaIngridients = [PizzaIngridients new];
    self.pizzaIngridients.current = self;
    [self.pizzaIngridients getIngridients];
}

- (void)array:(NSArray *)array {
    NSArray *sortedArray = [array sortedArrayUsingComparator:
        ^NSComparisonResult(id  _Nonnull firstElement, id  _Nonnull secondElement) {
            NSUInteger *countFirst = [[firstElement componentsSeparatedByString:@"p"] count];
            NSUInteger *countSecond = [[secondElement componentsSeparatedByString:@"p"] count];
            if (countFirst > countSecond) {
                return NSOrderedAscending;
            } else if (countFirst < countSecond) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
    }];
    NSLog(@"%@", sortedArray);
}
@end
