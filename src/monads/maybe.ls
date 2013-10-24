# # Module monads/maybe
#
# The Maybe monad.
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
abstractMaybe = {
  isNothing : false
  isJust    : false
  Nothing: -> Nothing
  Just:    (v) -> @of v
}

module.exports = Maybe = derive abstractMaybe, do
  # :: a → Maybe a
  of: (v) -> derive this, value: v

  # :: @Maybe a => (a → b) → Maybe b
  map: (f) -> @of (f @value)

  # :: @Maybe a => (a → Maybe b) → Maybe b
  chain: (f) -> f @value

  # :: @Maybe (a → b) => F a → F b
  ap: (b) -> b.map @value

  # :: @Maybe a => (() → b) → b
  or-else: (f) -> this


Nothing = derive Maybe, do
  of      : -> Nothing
  map     : (f) -> this
  chain   : (f) -> this
  ap      : (b) -> b
  or-else : (f) -> f!

