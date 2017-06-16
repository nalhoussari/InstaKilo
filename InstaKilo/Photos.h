//
//  Photos.h
//  InstaKilo
//
//  Created by Noor Alhoussari on 2017-06-14.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photos : NSObject

@property (nonatomic) UIImage *photo;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *subject;

- (instancetype)initWithPhoto: (UIImage *)photo andLocation: (NSString *)location andSubject: (NSString *)subject;

@end
