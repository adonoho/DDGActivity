The missing piece for creating a full fledged mix-in, or multiple inheritance, language out of Objective-C was the addition of associated references. My earlier post on creating a category that uses associated references is an example of the basic framework to do so. All it was missing was a formal way for the compiler to enforce the types of the mix-in. A protocol provides this mechanism. This post will show how to create and use this convention.

##Use Cases

There are, at least, two use cases for a mix-in. First, it is an organizational mechanism for building libraries that can be added to any proprietary class. This has been a common use for categories since they were invented and implemented in Obective-C. Unfortunately, it was always restricted to only adding methods and not ivars to a class. Obviously, using associated references addresses this limitation. Second, it can be used to add functionality to existing classes in a precompiled framework, as in my `DDGActivity` example adding an indicator to a `UIView`.

##Modifications to `DDGActivityViewController`

The changes are quite simple. You convert your category into an `@protocol`. I will show two examples. First, I'll add a mix-in to support TestFlight's SDK. TestFlight is an excellent service to support a wide area Ad Hoc app testing program. You can learn about their SDK at <http://TestFlightApp.com>. There are other companies/open source software projects that provide similar services, such as QuicyKit, <http://QuincyKit.net>, and HockeyKit, <http://HockeyKit.net>.

The example's goal is to use TestFlight during Ad Hoc testing and to compile the code out of the app for deployment. There is some question whether Apple allows apps into the App Store with the crash reporting functionality provided by TestFlight. Hence, I wanted a mechanism that made it trivial to remove TestFlight without placing conditional compilation statements throughout my application. I also added an ivar, `lastCheckpoint`, to contain the last string saved by the `-passCheckpoint:` method.  This ivar is a proper `@property`. Hence, you can observe the ivar and do things like collect a history of the checkpoints. I've implemented simple logging in the view controller this way.

All of the type information is contained in two files. The first file contains a traditional declaration of a protocol. In this case, it is `DDGTestFlight.h`. It is namespaced because I wrote it. It more appropriately belongs in the `TestFlight.h` file in the TestFlight SDK. The second file is a simple modification of the category file in the previous version of this project. It is a very simple change. You import the header and then apply the protocol to the category. As in:

    @interface DDGActivityViewController (DDGTestFlight) <DDGTestFlight>

As with any protocol, this allows you to precisely control both the type and which methods are required to be implemented. While the category and the protocol do not need to have the exact same name, that seems like it is a good convention to adopt.

##Modifications to `DDGView`

The category on `UIView` is similarly simple augmented. A protocol file, `DDGView.h`, is written and it is included and applied to the category. As in: 

    @interface UIView (DDGView) <DDGView>

I implement the same naming convention as in DDGTestFlight.

##Code Encapsulation Improvements Appear in `ModalViewController`

A very nice side effect of using protocols instead of categories is the information encapsulation now possible. In `ModalViewController`, we are able to just test for the protocol and not the class of the mixed-in instance. Your code is now more loosely coupled as a result. Traditionally, this means it is more robust against changes in other parts of your program. This is a good thing.

##Summary

Moving to a protocol driven technique of adding both associative references and methods improves the encapsulation of your classes while also partitioning type information in a useful fashion. As it is a pretty simple addition to what you need to do to add associative references anyway, I recommend that you do it. As before, you can get the source code up at GitHub, <http://bit.ly/DDGActivityGH>.

##Postscript to our Friends at TestFlight

As you can see from the above, it is pretty straightforward to add an effective form of conditional compilation to your system. I would raise two issues. First, the team token for `DDGActivity` in my account is hard compiled into the code. I'm OK with this if you are. Second, more importantly, I want to encourage you to embrace this method of adding a TestFlight mix-in. In your case, I recommend that you create and maintain the TestFlight protocol. Furthermore, as Apple is standardizing on the class name AppDelegate in their Xcode 4 templates, it is almost trivial to change my category implementation to apply to `AppDelegate` instead of `DDGActivityViewController`. Unlike the rest of your library, I want to encourage you to keep the source code for this category visible to your licensees.
