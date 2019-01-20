module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Todo =
    { id : Int, name : String, completed : Bool }


type VisibilityFilter
    = ShowAll
    | ShowActive
    | ShowCompleted


type Msg
    = AddTodo String
    | UpdateText String
    | ToggleTodo Int


init =
    { todos = [], text = "", lastId = 0 }


update msg model =
    case msg of
        AddTodo text ->
            let
                newId =
                    model.lastId + 1

                newTodo =
                    { id = newId, text = text, complete = False }
            in
            { model | todos = newTodo :: model.todos, lastId = newId }

        UpdateText text ->
            { model | text = text }

        ToggleTodo id ->
            { model
                | todos =
                    List.map
                        (\t ->
                            if t.id == id then
                                { t | complete = not t.complete }

                            else
                                t
                        )
                        model.todos
            }


view model =
    div []
        [ addTodo model.text
        , todoList model.todos
        , footer
        ]


addTodo textValue =
    div []
        [ input [ onInput UpdateText, value textValue ] []
        , button [ onClick <| AddTodo textValue ] [ text "Add Todo" ]
        ]


todoList todos =
    ul []
        (List.map
            todo
            todos
        )


todo model =
    li
        [ style "text-decoration"
            (if model.complete then
                "line-through"

             else
                "none"
            )
        , onClick <| ToggleTodo model.id
        ]
        [ text model.text ]


footer =
    div []
        [ span [] [ text "Show:" ]
        , filterLink ShowAll "All" True
        , filterLink ShowActive "Active" False
        , filterLink ShowCompleted "Completed" False
        ]


filterLink filter linkText active =
    button [ style "margin-left" "4px", disabled <| not active ] [ text linkText ]
