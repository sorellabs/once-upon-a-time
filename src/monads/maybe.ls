# # Monad: Maybe[a]

# Commonly represents a value that may, or may not be available.
# (In some languages, the `Maybe` monad is called `Option` or `Optional`).

/** ^
 * Copyright (c) 2013 Quildreen "Sorella" Motta <quildreen@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @module monads/maybe
 * @author Quildreen Motta
 * @exports Maybe
 */


# `Maybe[a]` allows one to model, explicitly, values that may not be
# always present (i.e.: nullable values), without the problems
# associated with using `null` and `undefined`. Furthermore, `Maybe[a]`
# values can be composed in manners that are similar to other monads, by
# using the generic sequencing and composition.

# There is two possibilities in the `Maybe[a]` monad. Either we have a
# value, indicated by the constructor `Just(a)`, or we don't have a
# value, indicated by the constructor `Nothing()`. As such, the
# `Maybe[a]` monad may be used safely to encode any case where it's
# possible to either have a value or not, without the possibility of
# ambiguity.

# Another interesting property of this monad is that, since you need to
# explicitly wrap and unwrap your values, you can't have a
# `NullPointerException` or `TypeError` by using things that don't exist
# (e.g.: a library broke your expectations of the code behaviour, or you
# forgot to check for `null` values). This way, using a `Maybe[a]` monad
# reduces the number of runtime errors.


# ## Dependencies ######################################################
{ derive } = require '../prototypical'


# ## Implementation ####################################################

/** 
 * Base values for the `Nothing` and `Just` cases.
 */
abstract-maybe = do
  /**
   * Tests if the Monad contains a `Nothing`.
   *
   * @type Boolean
   */
  is-nothing : false

  /**
   * Tests if the Monad contains a `Just`.
   *
   * @type Boolean
   */
  is-just    : false

  /**
   * Creates a new `Maybe` with no value.
   *
   * @type Unit -> Maybe(a)
   */
  Nothing: -> Nothing

  /**
   * Creates a new `Maybe` filled with one value.
   *
   * @type a -> Maybe(a)
   */
  Just:    (v) -> @of v



/**
 * The Maybe monad.
 *
 * @type Maybe <: (Applicative, Functor, Monad, Recoverable, Eq, Show)
 */
module.exports = Maybe = derive abstract-maybe, do

  # ### Group: Applicative #############################################
  
  /**
   * Creates a new `Maybe` monad with a value.
   *
   * @type a -> Maybe(a)
   */
  of: (v) -> derive Maybe, value: v, isJust: true

  /**
   * Applies a function from inside of the `Maybe` monad to another 
   * `Applicative` type.
   *
   * @type (@Maybe(a -> b), f:Applicative) => f(a) -> f(b)
   */
  ap: (b) -> b.map @value
  

  # ### Group: Functor #################################################

  /**
   * Transforms the value of the `Maybe` monad using a regular function.
   *
   * @type @Maybe(a) => (a -> b) -> Maybe(b)
   */
  map: (f) -> @of (f @value)


  # ### Group: Monad ###################################################

  /**
   * Transforms the value of the `Maybe` monad using a function to a
   * monad of the same type.
   *
   * @type @Maybe(a) => (a -> Maybe(b)) -> Maybe(b)
   */
  chain: (f) -> f @value

  
  # ### Group: Recoverable #############################################

  /**
   * Applies a function if the `Maybe` monad has no value.
   *
   * @type @Maybe(a) => (Unit -> Maybe(b)) -> Maybe(b)
   */
  or-else: (f) -> this


  # ### Group: Show ####################################################

  /**
   * Returns a textual representation of the `Maybe` monad.
   *
   * @type Unit -> String
   */
  to-string: -> "Maybe.Just(#{@value})"


  # ### Group: Eq ######################################################

  /**
   * Tests if a Maybe monad is equal to another Maybe monad.
   *
   * @type @Maybe(a) => Maybe(a) -> Boolean
   */
  is-equal: (a) ->
    | @is-nothing           => a.is-nothing
    | @is-just && a.is-just => a.value is @value



# } The Nothing case for the Maybe monad.
Nothing = derive Maybe, do
  isNothing : true
  of        : -> Nothing
  map       : (f) -> this
  chain     : (f) -> this
  ap        : (b) -> b
  or-else   : (f) -> f!
  to-string : -> 'Maybe.Nothing'
