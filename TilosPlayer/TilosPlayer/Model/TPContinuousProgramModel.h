//
//  TPContinuousProgramModel.h
//  TilosPlayer
//
//  Created by Daniel Langh on 18/02/14.
//  Copyright (c) 2014 rumori. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPContinuousProgramModel;

FOUNDATION_EXPORT NSString *const TPContinuousProgramModelDidFinishNotification;
FOUNDATION_EXPORT NSString *const TPContinuousProgramModelDidInsertDataNotification;


@protocol TPContinuousProgramModelDelegate <NSObject>

@optional
- (void)continuousProgramModelDidFinish:(TPContinuousProgramModel *)continuousProgramModel;
- (void)continuousProgramModel:(TPContinuousProgramModel *)continuousProgramModel
     didInsertDataAtIndexPaths:(NSArray *)indexPaths
                         atEnd:(BOOL)atEnd;

@end

@interface TPContinuousProgramModel : NSObject

@property (nonatomic, retain) NSMutableArray *episodes;
@property (nonatomic, assign) id<TPContinuousProgramModelDelegate> delegate;

- (NSIndexPath *)indexPathForLiveData;
- (NSIndexPath *)indexPathForData:(id)data;

- (void)loadTail;
- (void)loadHead;
- (void)jumpToDate:(NSDate *)date;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (id)dataForIndexPath:(NSIndexPath *)indexPath;
- (id)dataForRow:(NSInteger)row section:(NSInteger)section;

@end
