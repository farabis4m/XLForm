//
//  XLFormSegmentedCell.m
//  XLForm ( https://github.com/xmartlabs/XLForm )
//
//  Copyright (c) 2015 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "XLFormSegmentedCell.h"

#import "UIView+XLFormAdditions.h"

@interface XLFormSegmentedCell()

@end

@implementation XLFormSegmentedCell

#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.segmentedControl addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)update
{
    [super update];
    self.titleLabel.text = self.rowDescriptor.title;
    [self updateSegmentedControl];
    self.segmentedControl.selectedSegmentIndex = [self selectedIndex];
    self.segmentedControl.enabled = !self.rowDescriptor.isDisabled;
}

#pragma mark - Action

-(void)valueChanged
{
    self.rowDescriptor.value = [self.rowDescriptor.selectorOptions objectAtIndex:self.segmentedControl.selectedSegmentIndex];
}

#pragma mark - Helper

-(NSArray *)getItems
{
    NSMutableArray * result = [[NSMutableArray alloc] init];
    for (id option in self.rowDescriptor.selectorOptions) {
        [result addObject:[self.rowDescriptor formatValue:option]];
    }
    return result;
}

-(void)updateSegmentedControl {
    [self.segmentedControl removeAllSegments];
    [[self getItems] enumerateObjectsUsingBlock:^(id object, NSUInteger idex, __unused BOOL *stop){
        [self.segmentedControl insertSegmentWithTitle:object atIndex:idex animated:NO];
    }];
}

-(NSInteger)selectedIndex {
    NSInteger index = [self.rowDescriptor.selectorOptions indexOfObject:self.rowDescriptor.value];
    if(index != NSNotFound) {
        return index;
    }
    return UISegmentedControlNoSegment;
}

@end
