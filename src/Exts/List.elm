module Exts.List where

{-| Extensions to the core List library.

@docs chunk,mergeBy
 -}

import List exposing (take, drop, length)
import Dict

{-| Split a list into chunks of length n.

  Be aware that the last sub-list may be smaller than n-items long.

  For example `chunk 3 [1,2,3,4,5,6,7,8,9,10] => [[1,2,3], [4,5,6], [7,8,9], [10]]`
-}
chunk : Int -> List a -> List (List a)
chunk n xs =
  if | xs == [] -> []
     | (length xs) > n -> (take n xs) :: (chunk n (drop n xs))
     | otherwise -> [xs]

{-| Merge two lists. The first argument is a function which returns
the unique ID of each element. Where an element appears more than
once, the last won wins.
-}
mergeBy : (a -> comparable) -> List a -> List a -> List a
mergeBy f xs ys =
  let reducer v acc = Dict.insert (f v) v acc
  in Dict.values (List.foldl reducer Dict.empty (xs ++ ys))
