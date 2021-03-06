{-----------------------------------------------------------------

A "Tree" represents a binary tree. A "Node" in a binary tree
always has two children. A tree can also be "Empty". Below I have
defined "Tree" and a number of useful functions.

This example also includes some challenge problems :)

-----------------------------------------------------------------}

import Graphics.Element exposing (..)
import Text
import String

type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


empty : Tree a
empty =
    Empty


singleton : a -> Tree a
singleton v =
    Node v Empty Empty


insert : comparable -> Tree comparable -> Tree comparable
insert x tree =
    case tree of
      Empty ->
          singleton x

      Node y left right ->
          if  | x > y -> Node y left (insert x right)
              | x < y -> Node y (insert x left) right
              | otherwise -> tree


fromList : List comparable -> Tree comparable
fromList xs =
    List.foldl insert empty xs


depth : Tree a -> Int
depth tree =
    case tree of
      Empty -> 0
      Node v left right ->
          1 + max (depth left) (depth right)


map : (a -> b) -> Tree a -> Tree b
map f tree =
    case tree of
      Empty -> Empty
      Node v left right ->
          Node (f v) (map f left) (map f right)

map2 : (a -> b) -> (b -> c) -> Tree a -> Tree c
map2 f1 f2 tree =
  case tree of
    Empty -> Empty
    Node v left right ->
      Node (f2 (f1 v)) (map2 f1 f2 left) (map2 f1 f2 right)


sum: Tree number -> number
sum tree =
  case tree of
    Empty -> 0
    Node v left right ->
      sum left + v + sum right

diagram tree =
  case tree of
    Empty -> ""
    Node v left right ->
      diagram left ++ " <- " ++ toString v ++ " -> " ++ diagram right
      --toString v ++ "\n" ++ diagram left ++ " /    \\ " ++ diagram right

flatten tree =
  case tree of
    Empty -> []
    Node v left right ->
      List.append [v] (List.append (flatten left) (flatten right))

isElement : a -> Tree a -> Bool
isElement a tree =
  case tree of
    Empty -> False
    Node v left right ->
      if v == a
        then True
        else isElement a left || isElement a right

fold : (a -> b -> b) -> b -> Tree a -> b
fold f r tree =
  case tree of
    Empty -> r
    Node v left right ->
      -- pre order (left < v < right)
      fold f (f v (fold f r left)) right

concat : String -> String -> String -> String
concat delimiter a b =
  if String.length b > 0
    then a ++ delimiter ++ b
    else a

add n r =
  n + r


t1 = fromList [2,1,3,5]
t2 = fromList [1,2,3,4,5]

--
main : Element
main =
    flow down
        [ display "depth" depth t1
        , display "depth" depth t2
        , display "map ((+)1)" (map ((+)1)) t2
        , display "sum" sum t1
        , display "flatten" flatten t1
        , display "diagram" diagram t1
        , display "fold" (fold (concat " < ") "") (map toString t1)
        , display "foldSum" (fold add 0) t1
        , display "map2" flatten ((map2 ((+)1) ((*)2)) t1)
        ]
-- main =
--   (if isElement 7 t1 then "true" else "false")
--   |> Text.fromString
--   |> Text.monospace
--   |> leftAligned


display : String -> (Tree a -> b) -> Tree a -> Element
display name f value =
    name ++ " (" ++ toString value ++ ") &rArr;\n    " ++ toString (f value) ++ "\n "
        |> Text.fromString
        |> Text.monospace
        |> leftAligned


{-----------------------------------------------------------------

Exercises:

(1) Sum all of the elements of a tree.

       sum : Tree Number -> Number

(2) Flatten a tree into a list.

       flatten : Tree a -> List a

(3) Check to see if an element is in a given tree.

       isElement : a -> Tree a -> Bool

(4) Write a general fold function that acts on trees. The fold
    function does not need to guarantee a particular order of
    traversal.

       fold : (a -> b -> b) -> b -> Tree a -> b

(5) Use "fold" to do exercises 1-3 in one line each. The best
    readable versions I have come up have the following length
    in characters including spaces and function name:
      sum: 16
      flatten: 21
      isElement: 46
    See if you can match or beat me! Don't forget about currying
    and partial application!

(6) Can "fold" be used to implement "map" or "depth"?

(7) Try experimenting with different ways to traverse a
    tree: pre-order, in-order, post-order, depth-first, etc.
    More info at: http://en.wikipedia.org/wiki/Tree_traversal

-----------------------------------------------------------------}
