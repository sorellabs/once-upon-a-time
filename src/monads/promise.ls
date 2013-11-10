# # Module monads/promise
#
# Holds time-dependent values as time-independent.
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
Either     = require './either'


# -- Implementation ----------------------------------------------------
module.exports = Promise = do
  defer: (f) ->
    p = derive Promise, do
                        _value   : Nothing
                        _pending : []
    f ((a) -> fulfill p, a), ((b) -> reject p, b)
    return p
  
  of: (v) -> @defer (resolve) -> resolve v

  chain: (f) -> add-bindings this, f, (k this)

  or-else: (f) -> add-bindings this, (k this), f

  map: (f) -> @chain (a) -> Promise.of (f a)

  fold: (f, g) --> add-bindings this, f, g

  bimap: (f, g) --> @fold do
                          * (s) -> Promise.of (f s)
                          * (n) -> Promise.of (g n)

  to-string: ->
    | promise._value is Nothing => "Promise.Pending"
    | otherwise                 => @fold do
                                         * (s) -> "Promise.Fulfilled(#s)"
                                         * (f) -> "Promise.Rejected(#s)"

# -- Private helpers ---------------------------------------------------
Nothing = {}

k = (a) -> (b) -> a

fulfill = (promise, a) -> transition promise, Either.Right a
reject  = (promise, b) -> transition promise, Either.Left b

add-bindings = (promise, on-success, on-failure) ->
  | promise._value is Nothing => queue promise, on-success, on-failure
  | otherwise                 => promise._value.fold on-failure, on-success

queue = (promise, on-success, on-failure) ->
  Promise.defer (resolve, reject) ->
    promise._pending.push [
      (a) -> (on-success a).fold resolve, reject
      (b) -> (on-failure b).fold resolve, reject
    ]

transition = (promise, value) ->
  if promise._value isnt Nothing => throw new Error 'Promise already fulfilled.'
  promise._value := value
  invoke-pending-callbacks promise

invoke-pending-callbacks = (promise) ->
  value = promise._value
  for [success, failure] in promise._pending => value.fold failure, success
  promise._pending := []
