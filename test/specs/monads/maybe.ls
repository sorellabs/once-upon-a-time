spec = (require 'hifive')!
{ok, deepEqual} = require 'assert'
Maybe = require '../../../src/monads/maybe'

id = (a) -> a
eq = (a, b) --> a `deepEqual` b

module.exports = spec 'Maybe a' (_, spec) ->

  spec '{} Maybe' (o) ->
     o '.of(x) should return a monad with x as value.' ->
       (Maybe.of 1 .chain id) `eq` 1

     o '.map(f) should return a monad transformed by f.' ->
       (Maybe.of 1 .map (+ 1) .chain id) `eq` 2

     o '.chain(f) should apply f to the value.' ->
       (Maybe.of 1 .chain id) `eq` 1

     o '.ap(b) should apply value to b’s value.' ->
       (Maybe.of id .ap (Maybe.of 1) .chain id) `eq` 1

     o '.orElse(f) should ignore the operation.' ->
       (Maybe.of 1 .or-else (-> 2) .chain id) `eq` 1

  spec '{} Nothing' (o) ->
     Nothing = Maybe.Nothing!
     o '.of(x), .map(f), .chain(f) should return Nothing.' ->
       (Nothing.of 1) `eq` Nothing
       (Nothing.map (-> 1)) `eq` Nothing
       (Nothing.chain (-> 1)) `eq` Nothing

     o '.ap(b) should return b.' ->
       b = Maybe.of 1
       (Nothing.ap b) `eq` b

     o '.orElse(f) should apply f.' ->
       (Nothing.or-else -> 1) `eq` 1
