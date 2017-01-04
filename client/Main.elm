module Main exposing (..)

import Html exposing (..)


-- MODEL


type alias Model =
    Int



-- Msg


type Msg
    = Hello



-- APP


main : Program Never Int Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    0 ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    model ! []


view : Model -> Html Msg
view model =
    text "hello World in Elm"
