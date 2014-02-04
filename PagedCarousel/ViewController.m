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
@property (weak, nonatomic) IBOutlet SEssentialsCarouselLinear2D *carousel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation ViewController {
    PagedCarouselHelper *_helper;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Configure carousel
    self.carousel.frictionCoefficient = 1.5;
    self.carousel.momentumAnimationCurve = [SEssentialsAnimationCurve curveForCurveType:SEssentialsAnimationCurveTypeLinear];
    
    // Create a PagedCarouselHelper, passing it our carousel and pagecontrol
    _helper = [[PagedCarouselHelper alloc] initWithCarousel:self.carousel pageControl:self.pageControl];
    _helper.itemsPerPage = 3;
    
    int numberOfItems = 10;
    
    // Set up some views and add them to the carousel
    for (int i=0; i<numberOfItems; i++) {
        // Create a UILabel with a number and coloured background
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        view.text = [NSString stringWithFormat:@"%i", i+1];
        view.textColor = [UIColor whiteColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont fontWithName:@"Arial" size:100];
        view.backgroundColor = [UIColor colorWithHue:((float)i)/numberOfItems saturation:1.0 brightness:0.5 alpha:1.0];
        
        // Add the UILabel to the PagedCarouselHelper
        [_helper addView:view];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.carousel reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
