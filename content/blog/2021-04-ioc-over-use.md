Do you remember being a kid at Christmas and receiving that shiny new toy that you played with over
and over, perhaps even using the toy in ways that it was not intended to only to have it break?

I have had a similar experience with "Inversion of Control" over-use. For example, when I worked at
Distelli, I found the need to represent a byte array as an object. I wanted a byte array to be immutable
and for it to be treated in much the same way as a String in Java. When I wrote this abstraction I
defined a `Binary` interface and a `BinaryFactory` interface with separate implementations and then a
Guice module to map the interfaces into implementations. Consumers of this code could then `@Inject`
the `BinaryFactory` to create instances of `Binary`.

At first I thought I was pretty clever since I could swap out my implementation of `BinaryFactory`...
however I soon realized several painful facts:

* Why the heck would anyone swap out the implementation?
* How do I create an instance of `Binary` in a static initializer?
* Now all users of this code need this Guice module to be used in "all the places".

