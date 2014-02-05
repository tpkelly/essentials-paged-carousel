//
//  PagedCarouselHelper.h
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

#import <Foundation/Foundation.h>
#import <ShinobiEssentials/ShinobiEssentials.h>

@interface PagedCarouselHelper : NSObject<SEssentialsCarouselDataSource, SEssentialsCarouselDelegate>

@property (strong, nonatomic) SEssentialsCarousel *carousel;
@property (strong, nonatomic) UIPageControl *pageControl;

/** The number of views to display on each page. Defaults to 1 */
@property (nonatomic) int itemsPerPage;

/** The padding between the views on a single page, in pixels. Defaults to 5px */
@property (nonatomic) float itemPadding;

/** The orientation of the views within a page. Defaults to SEssentialsCarouselOrientationHorizontal */
@property (nonatomic, assign) SEssentialsCarouselOrientation orientation;

/** The duration in seconds of the animated scroll when the user changes page via the page control. Defaults to 0.5s */
@property (nonatomic) float animationDuration;

-(id) initWithCarousel:(SEssentialsCarousel*)carousel pageControl:(UIPageControl*)pageControl;

/** Add a single view to the carousel */
-(void) addView:(UIView*)view;

/** Add an array of UIViews to the carousel. */
-(void) addViews:(NSArray*)views;

@end
