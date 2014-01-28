ShinobiEssentials Paged Carousel (Objective-C)
=====================

This project demonstrates how to build a paged carousel using ShinobiEssentials, and provides a simple helper class (`PagedCarouselHelper`) which is reusable in your own projects.

![Screenshot](screenshot.png?raw=true)

You can reuse `PagedCarouselHelper` in your own projects - see [Using PagedCarouselHelper](#PagedCarouselHelper).

Building the project
------------------

In order to build this project you'll need a copy of ShinobiEssentials. If you don't have it yet, you can download a free trial from the [ShinobiEssentials website](http://www.shinobicontrols.com/ios/shinobiessentials/).

If you've used the installer to install ShinobiEssentials, the project should just work. If you haven't, then once you've downloaded and unzipped ShinobiEssentials, open up the project in Xcode, and drag ShinobiEssentials.framework from the finder into Xcode's 'frameworks' group, and Xcode will sort out all the header and linker paths for you.

If you’re using the trial version you’ll need to add your license key. To do so, open up AppDelegate.m, import <ShinobiEssentials/ShinobiEssentials.h>, and set the license key inside application:didFinishLaunchingWithOptions: as follows:

    #import <ShinobiEssentials/ShinobiEssentials.h>

    @implementation AppDelegate

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        [SEssentials setLicenseKey:@"your license key"];
        …
    }

<a name="PagedCarouselHelper"/>
Using PagedCarouselHelper
------------------
Here's how to use `PagedCarouselHelper` in your own project:

1. Add a carousel to your view. You'll need to use a specific subclass of `SEssentialsCarousel` - see the [`SEssentialsCarousel` overview](http://www.shinobicontrols.com/docs/ShinobiControls/ShinobiEssentials/2.5.1/Standard/Normal/Classes/SEssentialsCarousel.html#overview) for a list of carousel types. 
2. Add a page control to your view.
3. Add the **PagedCarouselHelper.h** and **PagedCarouselHelper.m** files to your project.
4. Create a `PagedCarouselHelper` instance with your carousel and page control.
5. Create the `UIView`s for your carousel and add them to your helper - either one at a time with the `addView:` method, or all at once with `addViews:`.
6. Sit back and be amazed at the awesomeness of your paged carousel.

You might want to tweak your carousel settings to improve the way the carousel and page control interact - see **ViewController.m** for some ideas.

Note that `PagedCarouselHelper` adds itself as the carousel's delegate, so if you want to use any other delegate methods, then add them to `PagedCarouselHelper` (or subclass it).

Contributing
------------

We'd love to see your contributions to this project - please go ahead and fork it and send us a pull request when you're done! Or if you have a new project you think we should include here, email info@shinobicontrols.com to tell us about it.

License
-------

The [Apache License, Version 2.0](license.txt) applies to everything in this repository, and will apply to any user contributions.

