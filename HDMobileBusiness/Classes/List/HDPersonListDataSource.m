//
//  HDPersonPickDataSource.m
//  HDMobileBusiness
//
//  Created by Plato on 9/11/12.
//  Copyright (c) 2012 hand. All rights reserved.
//

#import "HDPersonListDataSource.h"

@implementation HDPersonListDataSource
@synthesize listModel = _listModel;
@synthesize itemDictionary = _itemDictionary;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_itemDictionary)
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        HDPersonListModel * model = [[[HDPersonListModel alloc]init] autorelease];
        self.model = model;
        self.listModel = model;
        self.itemDictionary =
        @{ @"text" : @"text",
        @"subtitle":@"subtitle",
        @"userInfo":@"userInfo"};
    }
    return self;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView
{
    self.items = [NSMutableArray array];
    for (NSDictionary * record in self.listModel.resultList) {
        NSString * text = [[self.itemDictionary valueForKey: @"text"] stringByReplacingSpaceHodlerWithDictionary:record];
        NSString * subtitle = [[self.itemDictionary valueForKey:@"subtitle"] stringByReplacingSpaceHodlerWithDictionary:record];
        NSString * userInfo = [[self.itemDictionary valueForKey:@"userInfo"] stringByReplacingSpaceHodlerWithDictionary:record];
        
        TTTableSubtitleItem * item = [TTTableSubtitleItem itemWithText:text subtitle:subtitle];
        item.userInfo = userInfo;
        [_items addObject:item];
    }
}

-(void)search:(NSString *)text
{
    if ([self.listModel respondsToSelector:@selector(search:)]){
        [self.listModel search:text];
    }
}
@end
