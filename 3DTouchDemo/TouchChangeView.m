//
//  TouchChangeView.m
//  3DTouchDemo
//
//  Created by kisekied on 15/11/19.
//  Copyright © 2015年 kisekied. All rights reserved.
//

#import "TouchChangeView.h"

@implementation TouchChangeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.0f  green:0.0f blue:0.0f alpha:1.0f];
    }
    
    return self;
}

- (BOOL)check3DTouch {
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        return YES;
    } else {
        return NO;
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self check3DTouch]) {
        UITouch *touch = [touches anyObject];
        self.backgroundColor = [UIColor colorWithRed:touch.force / touch.maximumPossibleForce  green:0.0f blue:0.0f alpha:1.0f];
    } else {
        NSLog(@"CAN NOT USE 3D TOUCH!");
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor colorWithRed:0.0f  green:0.0f blue:0.0f alpha:1.0f];
}


@end
