import Html exposing (text)

main =
  text (toString (fib 10))

fib n =
  if | n == 0 -> 0
     | n == 1 -> 1e
     | otherwise -> fib (n - 1) + fib (n - 2)
