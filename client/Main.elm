module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- import Http
-- import HttpBuilder exposing (..)
-- import Json.Decode as Decode
-- import Json.Encode as Encode
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
    = AddUser
    | DeleteUser
    | InputUserName String
    | InputUserEmail String



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddUser ->
            ( model, Cmd.none )

        DeleteUser ->
            ( model, Cmd.none )

        InputUserName name ->
            ( { model | newUser = { id = model.newUser.id, name = name, email = model.newUser.email } }, Cmd.none )

        InputUserEmail email ->
            ( { model | newUser = { id = model.newUser.id, name = model.newUser.name, email = email } }, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Elm with GraphQL" ]
        , input [ type_ "text", placeholder "Name Here", onInput InputUserName ] []
        , input [ type_ "text", placeholder "Email Here", onInput InputUserEmail ] []
        , button
            [ onClick AddUser ]
            [ text "Add User" ]
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
    let
        _ =
            Debug.log "Debug" "init"
    in
        ( { users = [], newUser = emptyUser }, Cmd.none )
