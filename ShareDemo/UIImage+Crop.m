//
//  UIImage+Crop.m
//  ShareDemo
//
//  Created by Naitong Yu on 15/8/1.
//  Copyright (c) 2015年 Naitong Yu. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

- (UIImage *)crop:(CGRect)rect
{
    rect = CGRectMake(rect.origin.x * self.scale,
                      rect.origin.y * self.scale,
                      rect.size.width * self.scale,
                      rect.size.height * self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

- (UIImage *)squareImage
{
    if (self.size.width > self.size.height) {
        CGFloat length = self.size.height;
        CGRect square = CGRectMake((self.size.width - length) / 2, 0, length, length);
        return [self crop:square];
    } else {
        CGFloat length = self.size.width;
        CGRect square = CGRectMake(0, (self.size.height - length) / 2, length, length);
        return [self crop:square];
    }
}

@end
