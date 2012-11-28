//
//  HDBeanFactory.m
//  Three20Lab
//
//  Created by Plato on 11/16/12.
//  Copyright (c) 2012 hand. All rights reserved.
//

#import "HDObjectPattern.h"

@implementation HDObjectPattern
@synthesize url = _url;
@synthesize values = _values;
@synthesize beans = _beans;
@synthesize objectMode = _objectMode;


- (void)dealloc
{
    [_url release];
    [_values release];
    [_beans release];
    [super dealloc];
}

+(id)patternWithURL:(NSString *)url propertyValues:(NSDictionary *)values propertyRefBeans:(NSDictionary *)beans objectMode:(NSInteger)mode
{
    return [[self alloc]initWithURL:url propertyValues:values propertyRefBeans:beans objectMode:mode];
}

-(id)initWithURL:(NSString *) url propertyValues:(NSDictionary *)values propertyRefBeans:(NSDictionary *)beans objectMode:(NSInteger)mode{
    if (self = [self init]) {
        _url = [url copy];
        _values = [values retain];
        _beans = [beans retain];
        _objectMode = mode;
    }
    return self;
}

@end
