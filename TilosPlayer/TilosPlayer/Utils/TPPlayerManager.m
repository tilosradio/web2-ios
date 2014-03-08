//
//  TPPlayerManager.m
//  TilosPlayer
//
//  Created by Daniel Langh on 13/12/13.
//  Copyright (c) 2013 rumori. All rights reserved.
//

#import "TPPlayerManager.h"

#import "SynthesizeSingleton.h"
#import "TPAudioPlayer.h"
#import "TPEpisodeData.h"

@implementation TPPlayerManager

SYNTHESIZE_SINGLETON_FOR_CLASS(Manager, TPPlayerManager);


- (id)init
{
    self = [super init];
    if (self) {
        self.cachedDays = [NSMutableDictionary dictionary];
        self.playerLoading = NO;
        
        [[TPAudioPlayer sharedPlayer] addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentTime"])
    {
//        NSLog(@"time %@", change);
        NSDate *date = self.currentEpisode.plannedFrom;
        date = [date dateByAddingTimeInterval:[TPAudioPlayer sharedPlayer].currentTime];
        self.globalTime = [date timeIntervalSince1970];
    }
}

- (void)cueEpisode:(TPEpisodeData *)episode
{
    self.currentEpisode = episode;
    if(_playing)
    {
        [self playEpisode:self.currentEpisode];
    }
}

- (void)playEpisode:(TPEpisodeData *)episode
{
    [self playEpisode:episode atSeconds:0];
}
- (void)playEpisode:(TPEpisodeData *)episode atSeconds:(NSTimeInterval)seconds
{
    // TODO: handle seconds
    
    NSDate *startDate = episode.plannedFrom;
    //NSDate *dayDate = [startDate dayDate];
    //NSDate *segmentDate = [startDate archiveSegmentStartDate];
    
    self.currentEpisode = episode;
    
    NSString *url = [self urlForArchiveSegmentAtDate:startDate];
    
    [[TPAudioPlayer sharedPlayer] cueUrl:url atPosition:0];
    
    self.playing = YES;
}

#pragma mark -

- (void)togglePlay
{
    if(_playing)
    {
        self.playing = NO;
        [[TPAudioPlayer sharedPlayer] pause];
    }
    else
    {
        if(self.currentEpisode)
        {
            self.playing = YES;
            [self playEpisode:self.currentEpisode];
        }
    }
}

#pragma mark -

- (NSString *)urlForArchiveSegmentAtDate:(NSDate *)date
{
    // http://archive.tilos.hu/online/2013/12/11/tilosradio-20131211-0000.mp3
    
    NSDate *segmentStartDate = [date archiveSegmentStartDate];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:segmentStartDate];
    NSInteger year = components.year;
    NSInteger month = components.month;
    NSInteger day = components.day;
    NSInteger hour = components.hour;
    NSInteger minutes = components.minute;
    NSString *url = [NSString stringWithFormat:@"http://archive.tilos.hu/online/%04d/%02d/%02d/tilosradio-%04d%02d%02d-%02d%02d.mp3", year, month, day, year, month, day, hour, minutes];
    
    return url;
}

@end
