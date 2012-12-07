//
//  HDGroupedTodoListDataSource.m
//  HDMobileBusiness
//
//  Created by Plato on 12/5/12.
//  Copyright (c) 2012 hand. All rights reserved.
//

#import "HDGroupedTodoListDataSource.h"

@implementation HDGroupedTodoListDataSource

- (void)dealloc
{
    TT_RELEASE_SAFELY(_listModel);
    TT_RELEASE_SAFELY(_groupedCodeField);
    TT_RELEASE_SAFELY(_groupedValueField);
    [super dealloc];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {
        self.groupedCodeField = @"employee_name";
        self.groupedValueField = @"employee_name";
    }
    return self;
}
-(void)tableViewDidLoadModel:(UITableView *)tableView
{
    self.items = [NSMutableArray array];
    
//    //获取分组的集合    
//    NSMutableSet * groupSet = [NSMutableSet set];
//    for (NSDictionary * record in [self.listModel groupListResult]) {
//        [groupSet addObject:@{@"codeField":[record valueForKeyPath:_groupedCodeField],
//         @"valueField":[record valueForKeyPath:_groupedValueField]}];
//    }

    for (id record in [self.listModel groupResultList]) {
        [self.items addObject:[self createItemWithObject:record]
         ];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
 *生成cell对应的item
 */
-(TTTableItem *) createItemWithObject:(NSDictionary *) object
{
    NSString * text = [object valueForKeyPath:@"valueField"];
    
    TTTableItem * item = [TTTableTextItem itemWithText:text
                                              delegate:self
                                              selector:@selector(openURLForItem:)];
    item.userInfo = [object valueForKeyPath:@"codeField"];
    return item;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)openURLForItem:(TTTableTextItem *)item
{
    /*TODO:这个值要设定到modle里面么？还是设定给下一个的ds？如果配置文件支持简单表达式，那么这里就不用写死，选中值在当前类中维护，而目标控制器对应的属性通过表达式从当前类的对象中获取。。
    eg:self.selectedFiled = item.userInfo
       xml: 
     <bean id="todoListDataSource">
        <property name="groupedField" value="#{groupedTodoListDataSource.selectedField}">
     </bean>
     
     todoListDataSource has a property named selectedField
     */
    
    HDViewGuider  * guider =  [[HDApplicationContext shareContext] objectForIdentifier:@"groupedTodoListViewGuirder"];
    [guider.destinationController setValue:item.userInfo forKeyPath:@"model.groupedCode"];
    [guider.destinationController setValue:self.groupedCodeField forKeyPath:@"model.groupedCodeField"];
    [guider.destinationController setValue:item.userInfo forKeyPath:@"searchViewController.model.groupedCode"];
    [guider.destinationController setValue:self.groupedCodeField forKeyPath:@"searchViewController.model.groupedCodeField"];
    
    
    [guider perform];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
@end
