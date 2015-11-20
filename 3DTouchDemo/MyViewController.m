//
//  MyViewController.m
//  3DTouchDemo
//
//  Created by kisekied on 15/11/18.
//  Copyright © 2015年 kisekied. All rights reserved.
//

#import "MyViewController.h"

@implementation MyViewController
{
    UIImageView *_drawBoard;
    CGPoint _touchPoint;
    CGFloat _lineWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lineWidth = 10.0f;
    _drawBoard = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _drawBoard.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_drawBoard];
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:_drawBoard];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_drawBoard];
    
    UIGraphicsBeginImageContext(_drawBoard.frame.size);
    [_drawBoard.image drawInRect:_drawBoard.frame];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    float lineWidth = 10.0f;
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        lineWidth *= touch.force;
    }
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _touchPoint.x, _touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _drawBoard.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _touchPoint = currentPoint;
}

#pragma mark PreviewAction Items

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Default" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Selected" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Destructive" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    NSArray *actions = @[action1, action2, action3];
    
    UIPreviewActionGroup *group = [UIPreviewActionGroup actionGroupWithTitle:@"Actions Group" style:UIPreviewActionStyleDefault actions:actions];
    
    UIPreviewAction *action4 = [UIPreviewAction actionWithTitle:@"Single Action" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];

    NSArray *array = @[group, action4];

    return array;
}

@end
