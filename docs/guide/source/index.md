# Once Upon A Time

Once Upon A Time is a library for functional programming in
LiveScript/JavaScript.

It provides an [fantasy-land][] compliant standard library of algebraic and
purely functional data structures that amounts to an expressive foundation to
programming in LiveScript with generalised functions.

In other words, Once Upon A Time allows you to express more things in less
constructs, to reuse the same functions to different data structures sharing
the same interfaces, and to compose the base functionality to create complex
applications without complicating your code-base.

> This document concerns the Once Upon A Time version 1.0, for a different
> version, check out the branch of that version for the related documentation.


## Installing

The easiest way to install Once Upon A Time is to grab it from the NPM
repository. This assumes you have Node.js installed on your system, and are
using either Node, or a tool that uses NPM to manage your modules, like
[Browserify][].

From inside your project, run the `npm install` command to download the library
and all its dependencies, which will be stored on your `node_modules` folder.

    $ npm install once-upon-a-time

If you're not using NPM, it's possible to
[download the release tarball][download], which includes a compiled version of
the library (`once-upon-a-time.umd.js`) that will work for any module system,
or even if you're not using a module system.


## Platform support

Once Upon A Time assumes that the environment you'll be executing your programs
implements the ECMAScript 5 specification. This specification prescribes
several additions to the language, such as primitives for cloning prototypes,
and functional operations for sequence-like data structures.

When working in an ECMAScript 3 platform (like old Internet Explorer's JScript
engines), you can use the [es5-shim][] library to fill in the parts that your
platform are lacking.



