# # Module monads/streams
#
# The lazy stream monad.
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

{ derive } = require '../prototypical'
Promise    = require './promise'

# -- Implementation ----------------------------------------------------
module.exports = Stream = do

  # :: a -> (Stream a -> ()) -> Stream a
  cons: (a, b) --> derive Stream, do
                                  head: Promise.of a
                                  tail: Promise.defer (resolve) -> b resolve

  # :: () -> Stream a
  empty: -> Nil

  # :: Stream a -> Stream a
  concat: (as) ->
    | as is Nil   => this
    | this is Nil => as
    | otherwise   => @tail.chain (v) ~> derive this, switch
                                          | v is Nil => { tail: Promise.of as }
                                          | _        => { tail: v.concat as   }

  # :: (a -> b) -> Stream b
  map: (f) ->
    @head.chain (a) ~> @tail.chain (b) ~> derive this, do
                                                       head: Promise.of (f a)
                                                       tail: Promise.of (b.map f)
      
  # :: (a -> stream a) -> Promise (stream a)
  chain: (f) -> @head.chain (a) -> Promise.of (f a)

  # :: a -> Sream a
  of: (a) -> Stream.cons a, (resolve) -> resolve Nil

  # :: (Promise a, Promise b -> Promise b) -> b -> Promise b
  reduce-right: (f, initial) ->
    | this is Nil => Promise.of initial
    | otherwise   => @tail.chain (b) ~> @head.chain (a) ~>
                       | v is Nil => f a, Promise.of initial
                       | _        => f a, (b.reduce-right f, initial)

  # :: () -> String
  to-string: -> "Stream(#{@head}, #{@tail})"



Nil           = derive Stream
Nil.head      := Promise.of Nil
Nil.tail      := Promise.of Nil
Nil.to-string := -> 'Stream.Nothing'
