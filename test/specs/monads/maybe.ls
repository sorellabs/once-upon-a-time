spec = (require 'hifive')!
{id, ok, eq} = require '../../utils'
Maybe = require '../../../src/monads/maybe'

module.exports = spec 'Maybe a' (_, spec) ->

  spec 'Just a' (o) ->
     Just = (v) -> Maybe.Just v

     o '.of(x) should return a monad with x as value.' ->
       (Just 1 .chain id) `eq` 1

     o '.map(f) should return a monad transformed by f.' ->
       (Just 1 .map (+ 1) .chain id) `eq` 2

     o '.chain(f) should apply f to the value.' ->
       (Just 1 .chain id) `eq` 1

     o '.ap(b) should apply value to b’s value.' ->
       (Just id .ap (Just 1) .chain id) `eq` 1

     o '.orElse(f) should ignore the operation.' ->
       (Just 1 .or-else (-> 2) .chain id) `eq` 1

  spec 'Nothing' (o) ->
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
