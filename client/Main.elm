module Main exposing (..)

import Html exposing (..)


-- types


type alias User =
    { id : Int
    , name : String
    , email : String
    }


emptyUser : User
emptyUser =
    { id = 0
    , name = ""
    , email = ""
    }



-- models


type alias Model =
    { users : List User
    , newUser : User
    }



-- messages


type Msg
    = Add
    | Delete



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( model, Cmd.none )

        Delete ->
            ( model, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Elm with GraphQL" ]
        ]



-- unused subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- program


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { users = [], newUser = emptyUser }, Cmd.none )
