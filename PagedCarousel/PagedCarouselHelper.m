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
    BOOL _inPageChange;
    float _previousOffset;
}

// Initialize a PagedCarouselHelper with a carousel and a pageControl
-(id) initWithCarousel:(SEssentialsCarousel *)carousel pageControl:(UIPageControl *)pageControl
{
    self = [super init];
    if (self)
    {
        _itemsPerPage = 1;
        _inPageChange = NO;
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
    
    // Fix the focus point so it's on the leftmost item
    _carousel.focusPointNormalized = CGPointMake(0.5/(float)self.itemsPerPage, 0.5);
    
    // Tweaks to momentum and friction for less bumpy scrolls
    self.carousel.momentumAnimationCurve = [SEssentialsAnimationCurve curveForCurveType:SEssentialsAnimationCurveTypeLinear];
    self.carousel.frictionCoefficient = 1.5;
}

// Set the PagedCarouselHelper's pageControl
-(void)setPageControl:(UIPageControl *)pageControl
{
    _pageControl = pageControl;
    
    // Set up the number of pages and the current page
    [self updatePageControl];
    
    // Set a target so that when the page value changes we update the carousel
    [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)setItemsPerPage:(int)itemsPerPage
{
    _itemsPerPage = itemsPerPage;
    // Fix the focus point of the carousel so it's in the middle of the leftmost item on the page
    _carousel.focusPointNormalized = CGPointMake(0.5/(float)self.itemsPerPage, 0.5);
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

// Update the page control to reflect the new number of views
-(void)updatePageControl
{
    self.pageControl.numberOfPages = ([_carouselViews count] + self.itemsPerPage - 1) / self.itemsPerPage;
    _pageControl.currentPage = self.carousel.contentOffset/self.itemsPerPage;
}

// Update the page control and carousel to reflect the updated views
-(void)updateViews
{
    [self updatePageControl];
    [self.carousel reloadData];
}

// Scroll the carousel when the page control value is changed
-(void)pageChange:(id)sender
{
    _inPageChange = YES;
    [self.carousel setContentOffset:self.pageControl.currentPage*self.itemsPerPage animated:YES withDuration:0.5];
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

-(void)carouselWillScroll:(SEssentialsCarousel *)carousel
{
    // Keep track of the offset at the start of the scroll, so we can work out which direction we're scrolling in
    _previousOffset = carousel.contentOffset;
}

-(void)carousel:(SEssentialsCarousel *)carousel didFinishScrollingAtOffset:(CGFloat)offset
{
    if (_inPageChange) {
        // The scroll was one that we started, so don't do any more work
        _inPageChange = NO;
    } else {
        _inPageChange = YES;
        // Work out which page we should be on - the nearest to the current carousel offset
        float newPage = self.carousel.contentOffset/(float)self.itemsPerPage;
        if (carousel.contentOffset > _previousOffset)
        {
            self.pageControl.currentPage = ceilf(newPage);
        } else {
            self.pageControl.currentPage = floorf(newPage);
        }
        
        // Scroll the carousel so that the first item on the current page is the one in focus
        [self.carousel setContentOffset:self.pageControl.currentPage*self.itemsPerPage animated:YES withDuration:0.5];
    }
}

@end
