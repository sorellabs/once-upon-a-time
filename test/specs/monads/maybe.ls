spec = (require 'hifive')!
{ for-all, data:$ } = require 'claire'
{id, ok, eq} = require '../../utils'
Maybe = require '../../../src/monads/maybe'

module.exports = spec 'Maybe[a]' (_, spec) ->
  Just = -> Maybe.Just it

  spec ':: Functor' (o) ->
    o 'identity: u.map(a -> a) = u' do
      for-all ($.Any) .satisfy (a) ->
        a is (Maybe.Just a).map id .chain id
      .as-test!
 
    o 'composition: u.map(a -> f(g(a))) = u.map(f).map(g)' do
      f = (* 2)
      g = (+ 3)
      for-all ($.Num) .satisfy (a) ->
        v1 = (Just a).map (b) -> f (g b)
        v2 = (Just a).map g .map f
        (v1.chain id) is (v2.chain id)
      .as-test!
 
    o 'map(f) should ignore Nothings.' ->
      Maybe.Nothing!.map (a) -> 1 .chain `eq` Maybe.Nothing!
      ((Just 1).map (+ 1) .chain id) `eq` 2
     

  spec 'Applicative' (o) ->
    

#      o '.of(x) should return a monad with x as value.' do
#        for-all $.
#        (Just 1 .chain id) `eq` 1
# 
#      o '.map(f) should return a monad transformed by f.' ->
#        (Just 1 .map (+ 1) .chain id) `eq` 2
# 
#      o '.chain(f) should apply f to the value.' ->
#        (Just 1 .chain id) `eq` 1
# 
#      o '.ap(b) should apply value to b’s value.' ->
#        (Just id .ap (Just 1) .chain id) `eq` 1
# 
#      o '.orElse(f) should ignore the operation.' ->
#        (Just 1 .or-else (-> 2) .chain id) `eq` 1
# 
#   spec 'Nothing' (o) ->
#      Nothing = Maybe.Nothing!
#      o '.of(x), .map(f), .chain(f) should return Nothing.' ->
#        (Nothing.of 1) `eq` Nothing
#        (Nothing.map (-> 1)) `eq` Nothing
#        (Nothing.chain (-> 1)) `eq` Nothing
# 
#      o '.ap(b) should return b.' ->
#        b = Maybe.of 1
#        (Nothing.ap b) `eq` b
# 
#      o '.orElse(f) should apply f.' ->
#        (Nothing.or-else -> 1) `eq` 1
