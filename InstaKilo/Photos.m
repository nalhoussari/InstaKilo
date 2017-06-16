//
//  Photos.m
//  InstaKilo
//
//  Created by Noor Alhoussari on 2017-06-14.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import "Photos.h"

@implementation Photos

- (instancetype)initWithPhoto: (UIImage *)photo andLocation: (NSString *)location andSubject: (NSString *)subject
{
    self = [super init];
    if (self) {
        _photo = photo;
        _location = location;
        _subject = subject;
    }
    return self;
}

@end
