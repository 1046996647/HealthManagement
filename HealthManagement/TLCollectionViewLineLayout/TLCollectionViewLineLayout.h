//
//  TLCollectionViewLineLayout.h
//  TLCollectionViewLineLayout-Demo
//
//  Created by andezhou on 15/7/16.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLCollectionViewLineLayout : UICollectionViewFlowLayout

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define ITEM_WIDTH kScreenWidth*0.5
#define ITEM_HEIGHT (kScreenHeight-64)/2-80


@end
