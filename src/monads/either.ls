# # Module monads/either
#
# The Either monad.
#
#
# Copyright (c) 2013 Quildreen "Sorella" Motta <quildreen@gmail.com>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# -- Dependencies ------------------------------------------------------
{ derive } = require '../prototypical'


# -- Implementation ----------------------------------------------------
abstract-either = {
  isLeft: false
  isRight: false
  Left:  (v) -> derive Left, value: v
  Right: (v) -> @of v
}

module.exports = Either = derive abstract-either, do
  # :: b → Either a b
  of: (v) -> derive Either, { value: v, isRight: true }

  # :: @Either a b => (a → c) → (b → d) → c | d
  fold: (f, g) -->
    | @isLeft  => f @value
    | @isRight => g @value

  # :: @Either a b => (b → Either a c) → Either a c
  chain: (f) -> @fold do
                      * (l) ~> @Left l
                      * (r) -> f r

  # :: @Either a b => () → Either b a
  swap: -> @fold do
                 * (l) ~> @Right l
                 * (r) ~> @Left r

  # :: @Either a b => (b → c) → Either a c
  map: (f) -> @chain (v) ~> @of (f v)

  # :: @Either a b => (a → c) → (b → d) → Either (a|c) (b|d)
  bimap: (f, g) -> @fold do
                         * (l) ~> @Left (f l)
                         * (r) ~> @Right (g r)

  # :: @Either a (b → c) => F b → F c
  ap: (b) -> @chain (f) -> b.map f

  # :: @Either a b => (a → c) → c
  or-else: (f) -> @fold do
                        * (l) -> f l
                        * (r) ~> @Right r

  # :: () → String
  to-string: -> @fold do
                      * (l) -> "Either.Left(#l)"
                      * (r) -> "Either.Right(#r)"
  
Left = derive Either, do
  isLeft: true
