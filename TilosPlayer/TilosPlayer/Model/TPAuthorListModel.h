//
//  TPAuthorListModel.h
//  TilosPlayer
//
//  Created by Daniel Langh on 11/12/13.
//  Copyright (c) 2013 rumori. All rights reserved.
//

#import "TPListModel.h"

@interface TPAuthorListModel : TPListModel

@property (nonatomic, retain) NSArray *indexTitles;
@property (nonatomic, retain) AFHTTPRequestOperation *operation;


@end
