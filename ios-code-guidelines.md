# iOS Code Guidelines

Some personal guidelines for writing iOS Objective-C code. They result from my development experience in past years[1], where I've always tried to dig up robust solutions to everyday situations, and write them down as small building blocks for later lookup. Although Swift is the future, I currently still use Objective-C.

The practices are usually in the format "do X *because of* Y". Everything should be challenged over time. Not too much significant and new seems to have been adopted in recent years (i.e. IB, storyboards, asset catalogs, PDF assets, size classes, trait collections, auto layout, etc. can still be ignored in many cases).[2] Exceptions with no trade-offs are modern language features (i.e. [nullability annotations](https://developer.apple.com/swift/blog/?id=25) and [lightweight generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID35) e.g. for typed collections).

## 1. [Writing good, clear code](http://www.quora.com/Computer-Programming/What-are-some-of-your-personal-guidelines-for-writing-good-clear-code/answer/Raphael-Schaad)

## 2. Best practices for implementation details
### Designated Initializers
- Don't create initializers in your class if the superclass' initializers are sufficient.
- If you create an initializer in your class, you must override the superclass' designated initializer to call through to your designated initializer.
- If you create convenience initializers, only the designated initializer initializes the variables, and all other initializers eventually call through to the designated initializer.
- The designated initializer of your class must call its superclass' designated initializer.
- Decorate the designated initializer for semantic compiler warnings about violation of these rules:

```
    - (instancetype)init NS_DESIGNATED_INITIALIZER;
```

- If your class must, must, must have an argument supplied, add a runtime assertion at the beginning of your designated initializer:

```
    NSAssert(households != nil, @"Has to be initialized with a list of households.");
```

From Aaron Hillegass, Cocoa Programming for OS X, Creating Your Own Classes, Conventions for Creating Initializers; Apple, Adopting Modern Objective-C, Object Initialization; and own notes.

### BOOL
- Don't compare explicitly to `YES` because a "loaded `BOOL`" (non-one lower byte address object) could result in false, when true was intended:

```
    if ([kitteh haz:cheezburger]) { // good

    if ([kitteh haz:cheezburger] == YES) { // bad
```

- Use a logical expression when assigning a `BOOL` because otherwise you can create such a "loaded `BOOL`":

```
    return obj != nil; // good logical expression

    return (BOOL)obj; // bad cast

    BOOL isX = [self isX];
    isX = isX && isY; // good logical expression

    BOOL isX = [self isX];
    isX &= isY; // bad bitwise operation
```

There is unfortunately no logical and assignment operator in C for a convenient syntax.

More info from [Big Nerd Ranch](http://blog.bignerdranch.com/564-bools-sharp-corners/) and [Mike Ash](https://www.mikeash.com/pyblog/friday-qa-2012-12-14-objective-c-pitfalls.html). Note that ARM 64-bit seems to have fix this, where `BOOL` is an actual 1-bit boolean type and everything that is non-zero is `YES`.

### Variable declaration
When declaring a pointer variable, the asterisk goes with the variable name: `UIColor *myColor`. This makes sense because if you declared multiple variables on a single line, each one gets an asterisk: `UIColor *firstColor, *secondColor`. If declared like this `UIColor* firstColor, secondColor`, only `firstColor` is actually a pointer.

### Constants
When declaring a "container" to store a value, it's generally a good idea to default to a constant and only switching to a variable when the value actually needs to change during runtime. This strategy leads to a surprising high constants over variables ratio, which is a good thing. With Swift constants (`let keyword`), it's possible to defer assigning the value from compile-time to runtime (exactly once), making them even more useful.

A constant that is scoped to the entire file (not a method), but only used within that file, should be made `static` to limit its scope, because otherwise it can clash with other constants in the global namespace (e.g. from 3rd party code):

    static const NSUInteger kSize = 12;

This is also true for objects. (To indicate the constant in the example above, it's prefixed with "k" after the Hungarian notation. Cocoa frameworks use that naming convention. However, better compiler warnings seem to reduce the need to include that information in the name.

If the constant is used in other files it should still be defined in the implementation file, but declared with the `extern` keyword in the header:

    extern const NSUInteger kProjectClassSize; // in .h file

    const NSUInteger kProjectClassSize = 12; // in .m file

In this case, add the class name as prefix to create a name space.

The benefit of `extern`ing in the header is that the build will break if the definition gets removed from the .m file. Without the `extern`, the build will not break and the constant will implicitly be `0`.

For objects, the syntax should be a constant pointer, so it can't be reassigned:

    NSString * const kSizeKey = @"size";
    \________/ \___/ \______/ = \_____/;
       type   keyword  name      value

`const NSString *` or `NSString const *` would both be a normal pointer to a constant `NSString`, which is nonsensical because `NSString`s are already immutable and other classes' mutability can't be enforced this way.

It's consequent to have spaces around the '*' because there's a space between class name and pointer operator (together making up the type, see Variable declaration) and a space between the type and the keyword.

In general, constants should be defined in the smallest scope possible (block over method, method over file, file over global).

### @property declaration modifiers
- Modifier order: `@property (<class, >atomicity, storage<, mutation><, nullability><, getter = isAwesome>) BOOL awesome`;
- Be explicit about atomicity modifier `nonatomic`/`atomic`, because `atomic` is rarely intended but the default.
- Be explicit about storage modifier `assign`/`weak`/`strong`/`copy`, even when it's `readonly`, because when overriding `readwrite` internally the signatures match. Use `assign` only for primitive data types and structs. In the rare case a class doesn't support `weak` references or unretained is intended, use `unsafe_unretained`.
- Don't be explicit about mutation modifier `readwrite` because it's usually intended and the default. When using `readonly` in the header, optionally override in the implementation file to `readwrite`.
- Change the default nullability behavior from `null_unspecified` to `nonnull` (with [a few exceptions](https://developer.apple.com/swift/blog/?id=25)) by enclosing the interface and implementation in both .h and .m with `NS_ASSUME_NONNULL_BEGIN/END`. Then only be explicit when using `nullable`. Note that for method declarations these non-underscored forms come immediately after an open parenthesis before the type.
- Use spaces around '=' for custom getter name to follow general convention. There should never be the necessity to use a custom setter name.

### Variable declaration qualifiers
When decorating an object variable with a qualifier, put the keyword where `const` would go:

    ClassName * qualifier variableName;

Possible qualifiers are: `__strong`, `__weak`, `__unsafe_unretained`, `__autoreleasing`, `__block`, `_Nullable`, `_Nonnull`

According to Apple's [Transitioning to ARC Release Notes](https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html) "Other variants are technically incorrect but are 'forgiven' by the compiler."

[Nullability annotations](https://developer.apple.com/swift/blog/?id=25): It is especially important to keep order in the case of multi-level pointers like `**values` where the outer pointer can be nullable but the inner pointer has to be nonnull. The double-underscored variants `__nullable` and `__nonnull` are deprecated.

Note that the [`__kindof` type specifier](https://developer.apple.com/library/prerelease/content/releasenotes/AppKit/RN-AppKitOlderNotes/) (indicating that subclasses of the specified type are also valid) must precede the type:

    __kindof ClassName *variableName;

    NSArray<__kindof NSString*> *names;

### `#import` and `#include`
Use `#import` for own C/Objective-C headers because it avoids double inclusion. Also use `#import` for C headers from the Cocoa framework or extensions to stay consistent.

    #import <Foundation/Foundation.h>

Use #include for standard C/C++ headers because traditionally it only includes parts of other include files.

    #import <sys/time.h> // includes only a part of <time.h> by using #defines
    #import <time.h> // Bad. Even though only part of <time.h> was already included, as far as #import is concerned, that file is now already completely included.

When creating C headers, add an include guard like this:

    #ifndef AAREMACROS_h
    #define AAREMACROS_h
    ...
    #endif

Use `#import/include <header>` for system headers and `#import/include "header"` for user headers because that ensures the correct order of directories to look for the header.

### `#import`ing system frameworks
Always #import the top most level frameworks that a class needs to allow omitting prefix header and enabling its usage as Swift module.

Note that UIKit already imports Foundation, though it's a bit indirect: its umbrella header imports e.g. UIAccelerometer.h which in turn imports Foundation. So when importing UIKit, there's no need to explicitly import Foundation too.

### Prefix Header
Not needed anymore. Can still be added in build settings, e.g. for project-wide macros.

### Type-generic math functions [tgmath.h](http://en.wikipedia.org/wiki/Tgmath.h#tgmath.h)
Don't bother anymore. Originally I used this to replace e.g. `ceil` over `ceilf` for better readability.

### Sign testing with signbit(float)
Use this math function to test a float for its sign (positive or negative):

    BOOL directionsMatch = signbit(velocity.x) == signbit(translation.x);

### Prefixes
According to Apple's [Coding Guidelines for Cocoa](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingBasics.html#//apple_ref/doc/uid/20001281-1002226-BBCJECED) "Use prefixes when naming classes, protocols, functions, constants, and typedef structures. Do not use prefixes when naming methods; methods exist in a name space created by the class that defines them." When *extending* other objects functionality by either adding a category or subclassing, however, a prefix can be a nice reminder:

    [NSObject rs_doSomething] // "ah, my method!"

    [NSObject doSomething] // "Apple's foundation classes are so buggy!"

### Unsigned integers
Use `NSUInteger` instead of `NSInteger` for counts and zero-based indexes to avoid bad surprises with negative numbers.

### Robust string format specifiers for 32- and 64-bit
- `NSInteger`: cast to `long`, use format specifier `%ld`
- `NSUInteger`: cast to `unsigned long`, use format specifier `%lu`

Apple String Programming Guide, [String Format Specifiers](https://developer.apple.com/library/ios/documentation/cocoa/conceptual/Strings/Articles/formatSpecifiers.html)

### [How Do I Declare A Block in Objective-C?](http://fuckingblocksyntax.com)

### Randomness

    (Double(arc4random_uniform(314)) / 100) // random value up to PI

Generally use the `arc4random()`-family for ints and the `rand48()`-family for floats. [NSHipster has snippets](http://nshipster.com/random/) them including picking random elements from arrays, randomly shuffling arrays, etc.

### Object description method
`NSObject`'s `-description` returns the class name and object address (e.g. `<FLItem: 0x60800002a320>`). `(lldb) po` uses `-debugDescription`. According to Apple's Mac [OS X Debugging Magic](https://developer.apple.com/library/content/technotes/tn2124/_index.html#//apple_ref/doc/uid/DTS10003391-CH1-SECCOCOA), `NSObject`'s `-debugDescription` calls through to `-description`.

Overriding `-description` such that the result can be used cleanly in UI doesn't make sense, because we want that default class name and object address at least in our `-debugDescription`, and if we override `-debugDescription` to call super and append additional internal state relevant to debugging, super will call through to our `-description` implementation and use the "clean UI value" instead of the class name and object address. So the simplest approach seems to just mirror that behavior and override `-description` to append the most relevant variable(s) to `super`'s implementation, and override `-debugDescription` to append some additional state to `self`'s `description` (don't go crazy here, otherwise logs become unreadable).

    #pragma mark NSObject Method Overrides

    - (NSString *)description
    {
        NSString *description = [super description];

        description = [description stringByAppendingFormat:@" controlPoint1 = %@;", NSStringFromCGPoint(self.controlPoint1)];
        description = [description stringByAppendingFormat:@" controlPoint2 = %@;", NSStringFromCGPoint(self.controlPoint2)];
        description = [description stringByAppendingFormat:@" duration = %f;", self.duration];

        return description;
    }

    - (NSString *)debugDescription
    {
        NSString *debugDescription = [self description];

        debugDescription = [debugDescription stringByAppendingFormat:@" ax = %f;", ax];
        debugDescription = [debugDescription stringByAppendingFormat:@" bx = %f;", bx];
        debugDescription = [debugDescription stringByAppendingFormat:@" cx = %f;", cx];

        debugDescription = [debugDescription stringByAppendingFormat:@" ay = %f;", ay];
        debugDescription = [debugDescription stringByAppendingFormat:@" by = %f;", by];
        debugDescription = [debugDescription stringByAppendingFormat:@" cy = %f;", cy];

        return debugDescription;
    }

To represent an object in UI it makes more sense to add lazy properties like `.displayText` (and in there either do the right thing for localization, or happily ignore it).

### Changing the status bar style

    #pragma mark UIViewController Method Overrides

    - (UIStatusBarStyle)preferredStatusBarStyle
    {
        return UIStatusBarStyleLightContent;
    }

### Always use `instancetype` over `id` for return types
That way the compiler checks that the returned object is of the expected sub(class) type. `instancetype` is already inferred for [instance methods that begin with "init" or "copy"](http://clang.llvm.org/docs/LanguageExtensions.html#objective-c-features), but it's clearer to be explicit and  consistent. Apple's [Adopting Modern Objective-C](https://developer.apple.com/library/ios/releasenotes/ObjectiveC/ModernizationObjC/AdoptingModernObjective-C/AdoptingModernObjective-C.html) clarifies that it's for return values only "Unlike id, the instancetype keyword can be used only as the result type in a method declaration."

### Returning immutable copies
When possible, avoid returning pointers to mutable objects. If two different callers request it and one changes it the other one will be surprised.

    @property (nonatomic, strong, readonly) NSMutableArray<NSString *> *names; // names are not really "readonly"

    @property (nonatomic, copy, readonly) NSArray<NSString *> *names; // usually safer

### weakSelf and strongSelf
When getting a reference to self to capture it explicitly weak or strong, call it `weakSelf` or `weakStrong` respectively (instead of e.g. `weakClassName`/`strongClassName`). This way it's clear that it's still the object itself we're referencing. Example:

    ClassName * __weak weakSelf = self;
    ClassName * __strong strongSelf = self;

### Dot-syntax
Call an API the way the header declares it because that makes it easier to search call-sites across the codebase.

This is not as relevant anymore because by now all headers are cleaned up and all variables are exposed by properties (e.g. `UIColor.orangeColor`), but in the transitional years after the @property and dot-syntax got introduced, many frameworks still exposed property-like ivars through setters/getters (e.g. `-[NSArray count]`).

### Expose class variables as @property
Declare them as static and implement getter/setter because class properties are not synthesized:

    @property (class, nonatomic, copy) NSUUID *identifier;

    + (NSUUID *)identifier {
        static NSUUID *_identifier = nil;
        if (!_identifier) {
            static dispatch_once_t onceToken = 0;
            dispatch_once(&onceToken, ^{
                _identifier = [[NSUUID alloc] init];
            });
        }
        return _identifier;
    }

    + (void)setIdentifier:(NSUUID *)identifier {
        if (![_identifier isEqual:identifier]) {
            _identifier = [identifier copy];
        }
    }

### Initializing a static variable once (e.g. for singleton)
Wrap all `dispatch_once` calls to initialize a static variable once into a nil-check to avoid potential deadlocking: `dispatch_once` waits synchronously until the block has completed and assures to only execute once. The first call is blocking, holding a normal lock on the block (not a recursive lock/reentrant mutex), waiting for it to return. When we happen to call the same method recursively in the block, e.g. indirectly as a side effect in more complex codebases, the second call waits to get into the block when trying to acquire the same lock a second time, resulting in a deadlock. We can avoid that by returning the second call when the static variable already has a value. Note: This does not prevent from deadlocking on recursive calling before or during the static variable was initialized (race condition).

Initialize `onceToken`s explicitly with 0 (that's what they need to be) even though static (long) variables get initialized with 0 by default; for consistency to always default initialize everything but ivars.

    static ExamplePreferences *_sharedPreferences = nil;
    if (!_sharedPreferences) {
        static dispatch_once_t onceToken = 0;
        dispatch_once(&onceToken, ^{
            _sharedPreferences = [[ExamplePreferences alloc] init];
        });
    }

### Class method vs. instance method
Declare publicly exposed methods that don't require state as class methods. Generally declare private methods as instance methods, even if they don't require state. Since you always have an instance in this case anyway, it's more convenient, and when the method starts to require state, the signature doesn't change.

### `-isEqualToString:` vs. `-isEqual:`
Never use `-isEqualToString:` because when a stray non-`NSString` object makes it through we'd rather return NO instead of crash. A nice addition to the debug build tooling could be to have a bear trap to crash and log on such occurrences.

Also never use vanilla `-isEqual:` but rather a safer custom function* that *returns YES when both objects are nil*:

    // obj1         obj2         IsEqual?
    // ------------------------------------
    // something    something    YES if same object, if not it depends on `isEqual:`.
    // something    nil          NO  (because of pointer eq. and `isEqual:`)
    // nil          something    NO  (because of pointer eq. and `isEqual:`)
    // nil          nil          YES (because of pointer eq.; `isEqual:` would be NO)
    BOOL IsEqual(id obj1, id obj2)
    {
        BOOL isEqual = (obj1 == obj2 || [obj1 isEqual:obj2]);
        return isEqual;
    }

*) The implementation of this has to be a macro or a function and can't be a category method e.g. on `NSObject`.

### Overriding `-isEqual:` or `-hash`
- Avoid overriding `-isEqual:` or `-hash` in a subclass of a class which already implements custom equality and hashing because predictable comparing becomes very difficult.
- When overriding `-isEqual:` always override `-hash` too, so that equal objects also have the same hash value. Example:

```
    #pragma mark NSObject Method Overrides

    - (BOOL)isEqual:(id)object
    {
        // Short circuit if super is already not the same.
        if (![super isEqual:object]) {
            return NO;
        }

        // Short-circuit if they're not of the same class or a subclass of it.
        if (![object isKindOfClass:[self class]]) {
	        // We know it's already equal to super, so trust that.
	        return YES;
        }

        // Now test all relevant properties of this class for equality.
        Person *otherPerson = (Person *)object;

        BOOL isEqual = [otherPerson.firstName isEqual:self.firstName];
        isEqual = isEqual && [otherPerson.lastName isEqual:self.lastName];
        isEqual = isEqual && otherPerson.age == self.age;
        return isEqual;
    }

    - (NSUInteger)hash
    {
        // Create a combined hash from all properties relevant to equality.
        // Primitive data types can be converted to a foundation object to get a hash.
        // Combining the hashes by XORing them is not optimal but sufficient.
        NSUInteger hash = [self.firstName hash];
        hash ^= [self.lastName hash];
        hash ^= [@(self.age) hash];
        return hash;
    }
```

Mike Ash has a great [Friday Q&A 2010-06-18: Implementing Equality and Hashing](https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html)

### Copying an object
When copying a Foundation collection, consider the depth and mutability of the copy:

    // Immutable copy regardless of original; deeper levels have the original mutability (shallow)
    NSArray *personsCopy = [persons copy];
    NSArray *personsCopy = [[NSArray alloc] initWithArray:persons copyItems:NO];

    // Mutable copy regardless of original; deeper levels have the original mutability (shallow)
    NSMutableArray *personsCopyMutable = [persons mutableCopy];
    NSMutableArray *personsCopyMutable = [[NSMutableArray alloc] initWithArray:persons copyItems:NO];

    // Immutable copy regardless of original; next level is immutable regardless of original (deep); deeper levels have original mutability again (shallow)
    NSArray *personsCopy = [[NSArray alloc] initWithArray:persons copyItems:YES];

    // Mutable copy regardless of original; next level is immutable regardless of original (deep); deeper levels have original mutability again (shallow)
    NSMutableArray *personsCopyMutable = [[NSMutableArray alloc] initWithArray:persons copyItems:YES];

Support copying in own object by implementing follow:

    @implementation
    #pragma mark NSCopying
    - (instancetype)copyWithZone:(NSZone *)zone { ... }
    @end

Note that we need to override `-copyWithZone:` and not `-copy`, even though the `zone` parameter is legacy and unused.

Conform to the protocol in the header so subclasses know:

    @interface Sub : Super <NSCopying>
    @end

The implementation has three possibilities:
- A) For a subclass of a class that doesn't already conform to the NSCopying protocol (e.g. `NSObject`), initialize the object first:

```
    Person *copy = [[[self class] alloc] init];
```

Note the use of `[self class]` to return the right object if we get subclassed. Also note that we keep it simple by using `+alloc` instead of `+allocWithZone:` since the `zone` parameter is legacy and unused.

- B) For a subclass of a class that already conform to the `NSCopying` protocol, call super first:

```
    Person *copy = [super copyWithZone:zone];
```

- C) For a subclass that is immutable (e.g. has exclusively readonly properties), just return self (Foundation does the same):

    return self;

Note that it still might make sense to conform to `NSCopying`, e.g. in case the object is used in an `NSDictionary` as a key.

For (A) and (B), the exact nature of how to copy the ivars, is determined by the class. Here some guidelines:
- Judge whether to copy member objects or just assign the pointer (could make sense for an immutable object).
- When copying member objects, keep it simple by using `-copy` instead of `-copyWithZone:` since the `zone` parameter is legacy and unused. Sometimes you'll have to use a CF function to copy the member object.
- Follow the Foundation collections pattern of performing a shallow copy unless you provide an additional method with a deep copy flag as illustrated at the beginning.
- For (A), judge whether it makes sense to use the designated initializer to create the copy.
- Judge whether it makes sense to set the ivars on the copy directly like so: `copy->object` in case the setter triggers undesired logic.
- If your class has a clear immutable and mutable variant, also conform to the `NSMutableCopying` protocol and implement `-mutableCopyWithZone:` in the same fashion.

### Protocols
Formal @protocols should be used over informal class category ones because they are semantically richer and can provide compile-time warnings.

For delegate methods, every call should be wrapped in a `-[NSObject respondsToSelector:]` because when methods are marked `@optional` (`@required` is the default), the compiler doesn't warn us if the methods are not implemented; calling it will crash at runtime. The extra runtime work seems negligible and the extra code an OK trade-off for increased safety of a changing codebase.

When inheriting from a class that declares a delegate protocol and the subclass needs to add its own, the right way to do it is:

    // Super.h:
    @protocol SuperDelegate;

    @interface Super : NSObject
    @property (nonatomic, weak) id<SuperDelegate> delegate;
    @end

    @protocol SuperDelegate <NSObject>
    // delegate methods
    @end


    // Sub.h
    @protocol SubDelegate;

    @interface Sub : Super
    @property (nonatomic, weak) id<SuperDelegate, SubDelegate> delegate;
    @end

    @protocol SubDelegate <NSObject, SuperDelegate>
    // delegate methods (includes all methods of the NSObject and SuperDelegate protocols as well)
    @end

### Safe error handling
Initialize the NSError variable to nil, check against the returned "successful value" (some frameworks write to error even on success), and reset the error to nil on success (so it can safely be reused) for safe error handling:

    NSError * __autoreleasing error = nil;
    BOOL successful = [data writeToURL:fileURL options:0 error:&error];
    if (successful) {
        // ...
        error = nil;
    } else {
        NSLog(@"Error while writing data to file URL %@: %@", fileURL, error);
    }

### Using SDK-based development
When using [weakly linked classes, methods, functions, or symbols](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Using/using.html), always add a comment in the format "... iOS <version number> ..." so when dropping support for a version, those code paths can easily be identified and cleaned up.

    // If we have the Social Framework available (iOS 6 and newer), use it to determine whether we can tweet or not.
    // Otherwise, try to use the Twitter Framework (iOS 5, deprecated in iOS 6).
    if ([SLComposeViewController class]) {
        canTweet = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
    } else if ([TWTweetComposeViewController class]) {
        canTweet = [TWTweetComposeViewController canSendTweet];
    }

## 3. Format the code conventionally, consistently, and don't worry about it too much
- Tabs vs. spaces? Press the tab key by any means, but probably just go with spaces under the hood, like most modern editors default to. In any case, stay consistent with what's already there. (Pro-tab arguments: [Coding Horror](https://blog.codinghorror.com/death-to-the-space-infidels/), [Jarrod Overson](http://jarrodoverson.com/blog/spaces-vs-tabs/), [Jamie Zawinski](https://www.jwz.org/doc/tabs-vs-spaces.html) Pro-spaces: [Lea Verou](http://lea.verou.me/2012/01/why-tabs-are-clearly-superior/))
- Definitely indent code, but don't obsessively [horizontally align code in other ways](http://www.cocoawithlove.com/blog/2016/04/01/neither-tabs-nor-spaces.html)
- Generally don't commit commented-out code because it clutters up the codebase and feels like a pre-Git practice. If there's a good reason to do it, use `//` at the very beginning of the line (no indentation) to not confuse it with an actual comment explaining something with a code snippet.
- Don't expect to ever address that `// TODO:`. If you have to push a checkpoint of clearly unfinished code, add something stronger like a `#warning` that can be configured to break a production build.
- To group entire sections of a file, use something like `#pragma mark -` that stands out more than a comment.
- At a glance, the [NYTimes Objective-C Style Guide](https://github.com/NYTimes/objective-c-style-guide) elaborates on a reasonable style.

## 4. Debugging
Not guidelines per se, but code snippets that are useful for iOS development:
- Print view hierarchy: `(lldb) po [someView recursiveDescription]`
- Print method name using implicit method selector parameter: `NSLog(@"%@", NSStringFromSelector(_cmd));`

—

- [1]: I wrote my first app in 2009, a year after the initial release of the "iPhone OS" SDK, built the original iA Writer in 2010, and worked at Flipboard from 2011-2015. During these years, I was fortunate to learn from some of the best, to open source the widely used animated GIF library FLAnimatedImage, and to attend WWDC 2011-2014.
- [2]: Although I've worked mostly on product design since 2014 and am currently in academia at MIT, I try to keep up with the iOS dev community and in touch with friends in leading iOS engineering positions at top tech companies.
