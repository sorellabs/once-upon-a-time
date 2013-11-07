-- * Common monadic operations
--
-- Since a monad may have an asynchronous value, operations that work generically across monads
-- always return a Promise. Such functions also support a `strict-*` alternative.

maybe :: b -> (a -> b) -> Maybe a -> b
either :: (a -> c) -> (b -> c) -> Either a b -> c
map :: Functor f => (a -> b) -> f a -> f b
flatMap :: Monad m => (a -> m b) -> m a -> m b
point :: Monad m => m -> a -> m a
sequence :: Monad m => m -> (a -> m b) -> [m a] -> Promise (m [b])

-- * Strict monadic operations
strictSequence :: Monad m => m -> (a -> m b) -> [m a] -> m [b]


-- * Base functional operators
id :: a -> a
constant :: a -> b -> a
compose :: (b -> c) -> (a -> b) -> a -> c
flip :: (a -> b -> c) -> b -> a -> c
curry :: ((a, b) -> c) -> a -> b -> c
uncurry :: (a -> b -> c) -> (a, b) -> c
partial :: (a -> b -> c) -> a -> (b -> c)
partialRight :: (a -> b -> c) -> c -> (a -> b)
uncurryBind :: (a -> b -> c) -> This -> (a, b) -> c

until :: (a -> Bool) -> (a -> b) -> a -> Maybe b
when :: (a -> Bool) -> (a -> b) -> a -> Maybe b
limit :: Int -> (a -> b) -> a -> Maybe b
once :: (a -> b) -> a -> Maybe b

-- * List operations
cons :: a -> [a] -> [a]
concatenate :: [a] -> [a] -> [a]
filter :: (a -> Bool) -> [a] -> [a]
head :: [a] -> Maybe a
last :: [a] -> Maybe a
initial :: [a] -> [a]
rest :: [a] -> [a]
isEmpty :: [a] -> Bool
at :: Int -> [a] -> Maybe a
reverse :: [a] -> [a]

-- * Folds
foldLeft :: (a -> b -> a) -> a -> [b] -> a
foldRight :: (a -> b -> b) -> b -> [a] -> b
