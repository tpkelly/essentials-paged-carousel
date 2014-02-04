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
    NSMutableArray *_wrapperViews;
    float _wrapperHeight;
    float _wrapperWidth;
}

// Initialize a PagedCarouselHelper with a carousel and a pageControl
-(id) initWithCarousel:(SEssentialsCarousel *)carousel pageControl:(UIPageControl *)pageControl
{
    self = [super init];
    if (self)
    {
        self.itemsPerPage = 1;
        self.itemPadding = 5;
        self.orientation = SEssentialsCarouselOrientationHorizontal;
        self.carousel = carousel;
        self.pageControl = pageControl;
        _carouselViews = [[NSMutableArray alloc] init];
        _wrapperViews = [[NSMutableArray alloc] init];
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

-(void)setItemsPerPage:(int)itemsPerPage
{
    _itemsPerPage = itemsPerPage;    [self resetWrappers];
}

-(void)setItemPadding:(float)itemPadding
{
    _itemPadding = itemPadding;
    [self resetWrappers];
}

// Add a UIView to the carousel
-(void)addView:(UIView *)view
{
    [_carouselViews addObject:view];
    [self addViewToWrapper:view viewIndex:[_carouselViews count]-1];
    [self updateViews];
}

// Add an array of UIViews to the carousel
-(void)addViews:(NSArray *)views
{
    for (UIView *view in views) {
        [_carouselViews addObject:view];
        [self addViewToWrapper:view viewIndex:[_carouselViews count]-1];
    }
    [self updateViews];
}

// Add the given view to a wrapper view. viewIndex should be the index of the view in _carouselViews
-(void)addViewToWrapper:(UIView *)view viewIndex:(int)index
{
    // Calculate the height and width of the wrapper, based on itemsPerPage and itemPadding
    if (!_wrapperHeight) {
        if (self.orientation == SEssentialsCarouselOrientationHorizontal) {
            _wrapperHeight = view.frame.size.height;
            _wrapperWidth = (view.frame.size.width + self.itemPadding)*self.itemsPerPage - self.itemPadding;
        } else {
            _wrapperHeight = (view.frame.size.height + self.itemPadding)*self.itemsPerPage - self.itemPadding;
            _wrapperWidth = view.frame.size.width;
        }
    }
    
    // Check whether we need to create a new wrapper view
    if (index + 1 > [_wrapperViews count]*self.itemsPerPage) {
        [_wrapperViews addObject:[[UIView alloc] initWithFrame:CGRectMake(0, 0, _wrapperWidth, _wrapperHeight)]];
    }
    
    // Work out where the view should be positioned in the wrapper
    int indexInWrapper = index % self.itemsPerPage;
    if (self.orientation == SEssentialsCarouselOrientationHorizontal) {
        view.center = CGPointMake((view.frame.size.width + self.itemPadding)*indexInWrapper + view.frame.size.width*0.5,
                                  view.frame.size.height*0.5);
    } else {
        view.center = CGPointMake(view.frame.size.width*0.5,
                                  (view.frame.size.height + self.itemPadding)*indexInWrapper + view.frame.size.width*0.5);
    }
    
    // Add the view to the last wrapperView in our array
    [[_wrapperViews lastObject] addSubview:view];
}

// Recreate the wrapper views (e.g. if itemsPerPage or itemPadding has changed)
-(void)resetWrappers
{
    _wrapperHeight = 0;
    _wrapperWidth = 0;
    
    [_wrapperViews removeAllObjects];
    int count = 0;
    for (UIView *view in _carouselViews) {
        [self addViewToWrapper:view viewIndex:count++];
    }
    [self updateViews];
}

// Update the page control and carousel to reflect the updated views
-(void)updateViews
{
    self.pageControl.numberOfPages = [_wrapperViews count];
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
    return [_wrapperViews count];
}

-(UIView *)carousel:(SEssentialsCarousel *)carousel itemAtIndex:(int)index
{
    return _wrapperViews[index];
}

#pragma mark - SEssentialsCarouselDelegate methods

-(void)carousel:(SEssentialsCarousel *)carousel didFinishScrollingAtOffset:(CGFloat)offset
{
    self.pageControl.currentPage = offset;
}

@end
