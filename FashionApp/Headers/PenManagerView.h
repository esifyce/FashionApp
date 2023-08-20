//
//  PenManagerView.h
//  KMEAGLViewDeveloperDemo
//
//  Created by zhudongyong on 13-4-7.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenManager.h"

#define kPenManagerViewMinSize  CGSizeMake(300, 300)

@interface PenManagerView : UIView<
UITableViewDataSource,
UITableViewDelegate,
PenManagerConnectDelegate> {
    UITableView     *_pensTV;
}

@end
