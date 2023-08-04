//
//  PenCell.h
//  KMEAGLViewDeveloperDemo
//
//  Created by zhudongyong on 13-4-7.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PenCellDelegate;

@interface PenCell : UITableViewCell {
    UILabel     *_penNameLbl;
    UISwitch    *_usePenSwitch;
    
    id<PenCellDelegate>    _delegate;
}
/**
 * Digital pen name
 */
@property (nonatomic, retain) NSString  *penName;

/**
 * Digital pen connection state
 */
@property (nonatomic, readwrite) BOOL   opened;

@property (nonatomic, assign) id<PenCellDelegate> delegate;

@end


@protocol PenCellDelegate <NSObject>

/**
 * Digital pen connection state change callback
 */
- (void)penCell:(PenCell*)cell didChangeStatus:(BOOL)open;

@end
