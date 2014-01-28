//
//  PagedCarouselHelper.m
//  PagedCarousel
//
//  Created by Alison Clarke on 07/01/2014.
//
//  Copyright 2014 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "PagedCarouselHelper.h"

@implementation PagedCarouselHelper {
    NSMutableArray *_carouselViews;
}

// Initialize a PagedCarouselHelper with a carousel and a pageControl
-(id) initWithCarousel:(SEssentialsCarousel *)carousel pageControl:(UIPageControl *)pageControl
{
    self = [super init];
    if (self)
    {
        self.carousel = carousel;
        self.pageControl = pageControl;
        _carouselViews = [[NSMutableArray alloc] init];
    }
    return self;
}

// Set the PagedCarouselHelper's carousel
-(void)setCarousel:(SEssentialsCarousel *)carousel
{
    _carousel = carousel;
    
    // Set ourself as the carousel's delegate and data source
    _carousel.delegate = self;
    _carousel.dataSource = self;
}

// Set the PagedCarouselHelper's pageControl
-(void)setPageControl:(UIPageControl *)pageControl
{
    _pageControl = pageControl;
    
    // Set up the number of pages and the current page
    _pageControl.numberOfPages = [_carouselViews count];
    _pageControl.currentPage = self.carousel.contentOffset;
    
    // Set a target so that when the page value changes we update the carousel
    [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
}

// Add a UIView to the carousel
-(void)addView:(UIView *)view
{
    [_carouselViews addObject:view];
    [self updateViews];
}

// Add an array of UIViews to the carousel
-(void)addViews:(NSArray *)views
{
    [_carouselViews addObjectsFromArray:views];
    [self updateViews];
}

// Update the page control and carousel to reflect the updated views
-(void)updateViews
{
    self.pageControl.numberOfPages = [_carouselViews count];
    [self.carousel reloadData];
}

// Update the carousel value when the page control value is changed
-(void)pageChange:(id)sender
{
    [self.carousel setContentOffset:self.pageControl.currentPage animated:YES withDuration:0.5];
}

#pragma mark - SEssentialsCarouselDataSource methods

-(NSUInteger)numberOfItemsInCarousel:(SEssentialsCarousel *)carousel
{
    return [_carouselViews count];
}

-(UIView *)carousel:(SEssentialsCarousel *)carousel itemAtIndex:(int)index
{
    return _carouselViews[index];
}

#pragma mark - SEssentialsCarouselDelegate methods

-(void)carousel:(SEssentialsCarousel *)carousel didFinishScrollingAtOffset:(CGFloat)offset
{
    self.pageControl.currentPage = offset;
}

@end
