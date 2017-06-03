{-# language Rank2Types #-}
module Planetary.Util
  ( Vector
  , Stack
  , todo
  , assertM
  , assert
  , strictZip
  , withState'
  , (??)
  , (<$$>)
  , over2
  , maybeIf
  , Unifiable(unify)
  ) where

import Control.Monad.State.Strict
import Control.Monad.Except
import Control.Newtype

-- TODO change to Vector
type Vector a = [a]
type Stack a = [a]

todo :: String -> forall a. a
todo = error

assertM :: Bool -> Maybe ()
assertM valid = if valid then pure () else Nothing

assert :: MonadError e m => e -> Bool -> m ()
assert reason valid = if valid then pure () else throwError reason

strictZip :: MonadError e m => e -> [a] -> [b] -> m [(a, b)]
strictZip e as bs =
  if length as == length bs
  then pure (zip as bs)
  else throwError e

-- TODO: this has to be a standard function
withState' :: MonadState s m => (s -> s) -> m a -> m a
withState' update action = do
  s <- get
  put (update s)
  result <- action
  put s
  pure result

infix 0 ??

(??) :: MonadError e m => Maybe a -> e -> m a
(Just a) ?? _  = pure a
Nothing ?? err = throwError err

infixl 4 <$$>

(<$$>) :: (Functor f, Functor g) => (a -> b) -> f (g a) -> f (g b)
(<$$>) = fmap . fmap

-- traverse2
--   :: (Traversable s, Traversable t, Applicative f)
--   => (a -> f b)
--   -> s (t a)
--   -> f (s (t b))
-- traverse2 = traverse . traverse

over2
  :: (Newtype n o, Newtype n' o')
  => (o -> n) -> (o -> o -> o') -> (n -> n -> n')
over2 _newtype f n1 n2 = pack (f (unpack n1) (unpack n2))

maybeIf :: Bool -> Maybe a -> Maybe a
maybeIf False _a = Nothing
maybeIf True   a = a

class Unifiable f where
  -- TODO: we should give a way for solutions to escape this scope
  -- (a (mapping) state monad)
  unify :: Eq a => f a -> f a -> Maybe (f a)
