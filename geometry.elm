import Signal exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)
import Color exposing (..)


worldW =
  700
worldH =
  700

-- main : Element
main =
  world (worldW, worldH)
  [
    diamond blue 100
    ,square 40 |> filled red |> move (0, 0)
    ,circle 25 |> filled yellow |> move (40, -100)
  ]
  --show "Hellow world"

world (w, h) =
  collage w h

diamond color size =
  square size
  |> filled color
  |> rotate (degrees 45)


-- circle color size =
--   circle size
--   |> filled color


show value =
  value
  |> Text.fromString
  |> Text.monospace
  |> leftAligned
