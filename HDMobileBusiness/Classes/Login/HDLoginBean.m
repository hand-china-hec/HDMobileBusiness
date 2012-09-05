//
//  HDLoginBean.m
//  hrms
//
//  Created by Rocky Lee on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDLoginBean.h"

@implementation HDLoginBean
@synthesize username = _username;
@synthesize password = _password;
@synthesize language = _language;
@synthesize deviceType = _deviceType;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_language);
    TT_RELEASE_SAFELY(_deviceType);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _deviceType = TTIsPad()? @"iPad":@"iPhone";
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\n%@,\n%@,\n%@,\n%@",self.username,self
            .password,self.language,self.deviceType];
}
@end
