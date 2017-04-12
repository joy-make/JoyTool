//
//  JoyTableBaseView.m
//  Toon
//
//  Created by wangguopeng on 16/4/22.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyTableBaseView.h"
#import "JoyCellBaseModel.h"
#import "JoySectionBaseModel.h"

@implementation JoyTableBaseView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self.dataArrayM[indexPath.section] rowArrayM][indexPath.row] cellH];
}

@end
