Object oriented languages have always allowed a programmer to add both methods and ivars to any class. Apple recommends you should not over-ride some Cocoa/Cocoa Touch classes. Hence, you cannot use inheritance to add ivars and methods to those classes. Of course, Objective-C has always offered the category mechanism as a way to add arbitrary methods to any class. But historically, categories cannot add ivars. Apple has addressed this in the modern Objective-C runtime with a mechanism called associatied references. I have tested this code on iOS v4+.

The example app shows you how use an associated reference to add a `UIActivityIndicatorView` to every `UIView`, just as if it was any other ivar.

### `UIView (DDG)` category

This category adds an `@property` and a method, `-centerIndicator` to a `UIView`. Here is the header:

    #import <UIKit/UIKit.h>
    
    extern NSString *const kActivityIndicatorKey;
    
    @interface UIView (DDG)
    
    @property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
    
    - (void) centerIndicator;
    
    @end

As we are using an `@property`, I also add a constant string key to support key-value coding. (I do this to allow the Xcode's function completion to suggest the right key. This, of course, ensures that you don't inadvertently add a typo to your key.)

### How Do You Use It? 

Here I create an `activityIndicator` and add it to a `UIViewController`'s `UIView`.

    self.view.activityIndicator = [[[UIActivityIndicatorView alloc] 
                                    initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray] 
                                   autorelease];
    [self.view addSubview: self.view.activityIndicator];
    [self.view centerIndicator];
    
    [self.view.activityIndicator startAnimating];

Here I release the activity indicator:

    [self.view.activityIndicator removeFromSuperview];
    self.view.activityIndicator = nil;

That is straightforward and is used no differently from any other ivar that contains a `UIActivityIndicatorView`.

### A Pleasant Surprise.

One downside of the category mechanism is that it cannot over-ride any arbitrary method. This is a problem. To preclude a memory leak, all instances need to be released. But you cannot override `-dealloc` with a category. How do we solve this problem? We don't have to; the Objective-C runtime handles this for us. This is another example of Objective-C evolving into a modern object oriented language that manages its own memory. 

The example application allows you to create a modal view. When you dismiss the modal view, the `activityIndicator` is automatically released by the runtime and not by a `-dealloc` method. Please run the example app under Instruments' memory leak tool. You will see this to be true.

### How Does It Work?

The `activityIndicator` is an `@dynamic @property`. Hence, we need to implement both the setter and getter. All of this code is in `UIView+DDG.h/.m` files.

Here is the getter:

    - (UIActivityIndicatorView *) activityIndicator {
        
        return objc_getAssociatedObject(self, kActivityIndicatorARKey);
        
    } // -activityIndicator

Here is the setter:

    - (void) setActivityIndicator: (UIActivityIndicatorView *) activityIndicator {
        
        objc_setAssociatedObject(self, 
                                 kActivityIndicatorARKey, activityIndicator, 
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    } // -setActivityIndicator:

As you can see, the runtime provides a simple C-function to implement both accessors. The runtime identifies the associated reference by this C-string key:

    static const char *kActivityIndicatorARKey =  "ddgActivityIndicatorARKey";

This string could be anything. I chose to namespace it with a DDG prefix and role suffix, `"ARKey"`. Both of these together insure that this symbol will not collide with an Apple name. (As I prefer readability in my code, I chose NOT to namespace the ivar `activityIndicator` itself. This namespace collision  is a risk I'm willing to take.) As these accessors apply to the instance, `self` is the appropriate object to pass to the function. Finally, the memory management policy is defined by a family of self descriptive constants:     `OBJC_ASSOCIATION_ASSIGN`, `OBJC_ASSOCIATION_RETAIN_NONATOMIC`, `OBJC_ASSOCIATION_COPY_NONATOMIC`, `OBJC_ASSOCIATION_RETAIN`, `OBJC_ASSOCIATION_COPY`. In the example, I've chosen `OBJC_ASSOCIATION_RETAIN_NONATOMIC` to match the `@property (nonatomic, retain)` declaration.

### `DDGActivity` Example Application.

The example application is based upon Apple's single view application template. For clarity and simplicity, most of the template code has been removed. The root view controller, `DDGActivityViewController`, has just 3 button action methods: `-turnOnAction:`, `-turnOffAction:` and `-modalViewAction:`. The first two toggle the state of the activity indicator and the third, somewhat obviously, shows the modal view. 

The modal view exists to show you automatic memory reaping of associated references by the runtime. It does this by not actively releasing the `activityIndicator` when the modal view is dismissed. All of the memory is automatically reclaimed. No leaks are created. Please verify this by running the app under Instruments' memory leak tool. The `ModalViewController` just has two methods: `-viewDidLoad` and `-dismissAction:`. They are simple. `-viewDidLoad`'s body was copied from `-turnOnAction:`. `-dismissAction:` just dismisses itself.

### Licensing

Even though there is little likelihood that you will copy and past this code directly into your app, it is covered by an attribution required BSD license. If you use this technique, please consider giving me credit in your licenses or credits view. I write these posts to help grow my development consulting business and would appreciate your help.

### Where to get it?

This code lives up on GitHub at: <http://bit.ly/DDGActivityGH>. The announcement post to my blog is at: <http://bit.ly/DDGActivity>.