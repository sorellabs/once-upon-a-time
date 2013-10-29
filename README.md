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
    
If you don't want to use NPM and/or Browserify, you have two options (these
will work with barebones JS — no modules, — AMD, or CommonJS modules):

  - [Download the latest release][download], which includes
    `once-upon-a-time.umd.js`, and load the file in your platform.
    
  - Compile the library from source to get the most recent
    `once-upon-a-time.umd.js`.

    You'll need [Git][], [Make][] and [Node.js][], and run the following
    commands:
    
        $ git clone git://github.com/killdream/once-upon-a-time.git
        $ cd once-upon-a-time
        $ npm install
        $ make bundle
    
Once you got `once-upon-a-time.umd.js` loaded in your platform, all of the
functionality will be accessible from the `onceUponATime` global object if
you're using no module system, or your local binding of the module object
otherwise.
    
[download]: http://github.com/killdream/once-upon-a-time
[Browserify]: http://browserify.org/
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/


## Documentation

( ... )


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

