<a href="https://github.com/pufuwozu/fantasy-land"><img src="https://raw.github.com/pufuwozu/fantasy-land/master/logo.png" align="right" width="100px" height="100px" alt="Fantasy Land logo" /></a>

Once upon a time...
===================

[![Build Status](https://secure.travis-ci.org/killdream/once-upon-a-time.png?branch=master)](https://travis-ci.org/killdream/once-upon-a-time)
[![NPM version](https://badge.fury.io/js/once-upon-a-time.png)](http://badge.fury.io/js/once-upon-a-time)
[![Dependencies Status](https://david-dm.org/killdream/once-upon-a-time.png)](https://david-dm.org/killdream/once-upon-a-time)
[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)

An algebraic prelude for LiveScript (and JavaScript). Compatible with fantasy-land.


## Example

( ... )


## Installing

The easiest way is to grab it from NPM (if you're in the Browser, use [Browserify][]):

    $ npm install once-upon-a-time
    
    
### But I use AMD! (or CommonJS without NPM)

If you use AMD, or some implementation of CommonJS that doesn't rely on NPM,
you can [Download the latest release][download], which includes the
`once-upon-a-time.umd.js` file, configure your tool appropriately to load the
file, then:

```js
require(["once-upon-a-time"], function(onceUponATime) {
  ...
})
```


### But I don't use modules!

If you don't use modules, you can [Download the latest release][download],
which includes the `once-upon-a-time.umd.js` file, and just load the file as
you would any other library. `onceUponATime` will be a global that you can use:

```html
<script src="/path/to/once-upon-a-time.umd.js"></script>
```

### Compiling from source
    
If you want to compile the library from the source, You'll need [Git][],
[Make][] and [Node.js][], and run the following commands:
    
    $ git clone git://github.com/killdream/once-upon-a-time.git
    $ cd once-upon-a-time
    $ npm install
    $ make bundle
    
This will generate the `dist/once-upon-a-time.umd.js` file, which you can
include anywhere.

[download]: http://github.com/killdream/once-upon-a-time
[Browserify]: http://browserify.org/
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/


## Documentation

You can either [read it online][online], or generate it yourself:

    $ make documentation
    $ open docs/literate/index.html

[online]: http://killdream.github.io/once-upon-a-time


## Tests

    $ npm install
    $ make test


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :)

[es5-shim]: https://github.com/kriskowal/es5-shim


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/killdream/once-upon-a-time/blob/master/LICENCE).

