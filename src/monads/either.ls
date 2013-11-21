# # Monad: Either[a, b]
#
# A disjunction with a right-bias (projections will take the Right value)

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
 * @module monads/either
 * @author Quildreen Motta
 * @exports Either
 */


# ## Dependencies ######################################################
{ derive } = require '../prototypical'


# ## Implementation ####################################################

/**
 * Base value for the `Left` and `Right` cases.
 */
abstract-either = do
  /**
   * Tests if the Monad contains a `Left`.
   *
   * @type Boolean
   */
  isLeft: false

  /**
   * Tests if the Monad contains a `Right`.
   *
   * @type Boolean
   */
  isRight: false

  /**
   * Creates a new `Either` monad containing a `Left` value.
   *
   * @type a -> Either(a, b)
   */
  Left: (v) -> derive Left, value: v

  /**
   * Creates a new `Either` monad containing a `Right` value.
   *
   * @type b -> Either(a, b)
   */
  Right: (v) -> @of v


/**
 * The Either monad.
 *
 * @type Either <: (Applicative, Functor, Monad, Recoverable, Eq, Show)
 */
module.exports = Either = derive abstract-either, do

  # ### Group: Applicative #############################################

  /**
   * Creates a new `Either` monad with a `Right` value.
   *
   * @type b -> Either(a, b)
   */
  of: (v) -> derive Either, { value: v, isRight: true }


  /**
   * Applies a function from inside of the `Either` monad to another
   * `Applicative` type.
   *
   * @type @Either(a, b -> c), f:Applicative => f(b) -> f(c)
   */
  ap: (b) -> @chain (f) -> b.map f


  # ### Group: Functor #################################################
  
  /**
   * Transforms the value of the `Either` monad using a regular function.
   *
   * @type @Either(a, b) -> (b -> c) -> Either(a, c)
   */
  map: (f) -> @chain (v) ~> @of (f v)


  # ### Group: Monad ###################################################

  /**
   * Transforms the value of the `Either` monad using a function to a
   * monad of the same type.
   *
   * @type @Either(a, b) => (b -> Either(a, c)) -> Either(a, c)
   */
  chain: (f) -> @fold do
                      * (l) ~> @Left l
                      * (r) -> f r

  
  # ### Group: Recoverable #############################################

  /**
   * Applies a function to the `Left` side of the `Either` monad.
   *
   * @type @Either(a, b) => (a -> Either(c, b)) -> Either(c, b)
   */
  or-else: (f) -> @fold do
                        * (l) -> f l
                        * (r) ~> @Right r


  # ### Group: Show ####################################################

  /**
   * Returns a textual representation of the `Either` monad.
   *
   * @type Unit -> String
   */
  to-string: -> @fold do
                      * (l) -> "Either.Left(#l)"
                      * (r) -> "Either.Right(#r)"
   

  # ### Group: Eq ######################################################

  /**
   * Tests if an Either monad is equal to another Either monad.
   *
   * @type @Either(a) => Either(a) -> Boolean
   */
   is-equal: (a) -> @is-left  is a.is-left   and \
                    @is-right is a.is-right  and \
                    @value    is a.value



  # ### Ungrouped ######################################################
                      
  /**
   * Catamorphism for the disjunction.
   *
   * @type @Either(a, b) => (a -> c) -> (b -> c) -> c
   */
  fold: (f, g) -->
    | @isLeft  => f @value
    | @isRight => g @value


  /**
   * Swaps the disjunction values.
   *
   * @type @Either(a, b) => Unit -> Either(b, a)
   */
  swap: -> @fold do
                 * (l) ~> @Right l
                 * (r) ~> @Left r


  /**
   * Maps both sides of the disjunction.
   *
   * @type @Either(a, b) => (a -> c) -> (b -> d) -> Either(c, d)
   */
  bimap: (f, g) -> @fold do
                         * (l) ~> @Left (f l)
                         * (r) ~> @Right (g r)


# } The Left case of the ADT.
Left = derive Either, do
  isLeft: true
