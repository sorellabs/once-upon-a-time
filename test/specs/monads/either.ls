spec = (require 'hifive')!
{id, ok, eq} = require '../../utils'
Either = require '../../../src/monads/either'

module.exports = spec 'Either a b' (o, spec) ->

    l = Either.Left 1
    r = Either.Right 2

    o '.of(v) should fulfill the Right value of Either.' ->
      (Either.of 1 .chain id) `eq` 1

    o '.fold(f, g) should apply f to L, g to R.' ->
      (l.fold (+ 1), (+ 1)) `eq` 2
      (r.fold (+ 1), (+ 1)) `eq` 3

    o '.chain(f) should apply f to R, ignore L.' ->
      (l.chain id).value `eq` 1
      (r.chain id) `eq` 2

    o '.swap() should swap both values.' ->
      (l.swap!chain id) `eq` 1
      (r.swap!or-else id) `eq` 2

    o '.map(f) should apply f to the right value.' ->
      (l.map (+ 1) .or-else id) `eq` 1
      (r.map (+ 1) .chain id) `eq` 3

    o '.bimap(f, g) maps both values.' ->
      (l.bimap (+ 1), (+ 2) .or-else id) `eq` 2
      (r.bimap (+ 1), (+ 2) .chain id) `eq` 4

    o '.ap(b) applies Right to b’s value.' ->
      (Either.Left  (+ 1) .ap [1, 2] .or-else id)(1) `eq` 2
      (Either.Right (+ 1) .ap [1, 2]) `eq` [2, 3]
      
    o '.orElse(f) should apply a value to the left side.' ->
      (l.or-else id) `eq` 1
      (r.or-else id .chain id) `eq` 2
