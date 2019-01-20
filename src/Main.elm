module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = 0, update = update, view = view }


type VisibilityFilter
    = ShowAll
    | ShowActive
    | ShowCompleted


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view model =
    div []
        [ addTodo
        , todoList
        , footer
        ]


addTodo =
    div []
        [ input [] []
        , button [ type_ "submit" ] [ text "Add Todo" ]
        ]


todoList =
    ul []
        [ todo
        ]


todo =
    li [ style "text-decoration" "line-through" ] [ text "My todo" ]


footer =
    div []
        [ span [] [ text "Show:" ]
        , filterLink ShowAll "All"
        , filterLink ShowActive "Active"
        , filterLink ShowCompleted "Completed"
        ]


filterLink filter linkText =
    button [ style "margin-left" "4px", disabled True ] [ text linkText ]
