//
//  ViewController.m
//  PagedCarousel
//
//  Created by Alison Clarke on 18/12/2013.
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

#import "ViewController.h"
#import "PagedCarouselHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SEssentialsCarouselCylindrical *carousel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation ViewController {
    PagedCarouselHelper *_helper;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Configure carousel
    int numberOfItems = 10;
    
    // Set up some views - they're just UILabels with a number and different colours
    NSMutableArray *carouselViews = [[NSMutableArray alloc] init];
    for (int i=0; i<numberOfItems; i++) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        view.text = [NSString stringWithFormat:@"%i", i+1];
        view.textColor = [UIColor whiteColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont fontWithName:@"Arial" size:100];
        view.backgroundColor = [UIColor colorWithHue:((float)i)/numberOfItems saturation:1.0 brightness:0.5 alpha:1.0];
        [carouselViews addObject:view];
    }
    
    [SEssentialsCarouselCylindrical class];
    // Tweak some values of the carousel
    self.carousel.frontFacing = YES;
    self.carousel.frictionCoefficient = 1.5;
    self.carousel.itemSpacingFactor = 0.8;
    self.carousel.momentumAnimationCurve = [SEssentialsAnimationCurve curveForCurveType:SEssentialsAnimationCurveTypeLinear];
    
    // Create a PagedCarouselHelper, passing it our carousel, pagecontrol and views.
    _helper = [[PagedCarouselHelper alloc] init];
    _helper.carousel = self.carousel;
    _helper.pageControl = self.pageControl;
    _helper.carouselViews = carouselViews;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
