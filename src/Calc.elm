module Calc exposing (Model, main)

import Browser
import Css exposing (..)
import Data.Expr as Expr exposing (Expr, Op(..))
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



--model


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { expr : Expr }


type Msg
    = InputDigit Int
    | InputOperator Op
    | InputEqual
    | InputAllClear



--init


init : Model
init =
    { expr = Expr.initialize }



--update


update : Msg -> Model -> Model
update msg model =
    case msg of
        InputDigit i ->
            { model | expr = Expr.pushDigit model.expr i }

        InputOperator op ->
            { model | expr = Expr.pushOperator model.expr op }

        InputEqual ->
            { model | expr = Expr.pushEqual model.expr }

        InputAllClear ->
            init



--view


view : Model -> Html Msg
view model =
    div
        [ class "calculator" ]
        [ div
            [ class "display" ]
            [ text (Expr.showExpr model.expr) ]
        , div [ class "button" ]
            [ button [ onClick InputAllClear ] [ text "AC" ]
            , button [ onClick (InputOperator Mod) ] [ text "%" ]
            ]
        , div [ class "button" ]
            [ button [ onClick (InputDigit 7) ] [ text "7" ]
            , button [ onClick (InputDigit 8) ] [ text "8" ]
            , button [ onClick (InputDigit 9) ] [ text "9" ]
            , button [ onClick (InputOperator Add) ] [ text "+" ]
            , button [ onClick (InputOperator Sub) ] [ text "-" ]
            ]
        , div [ class "button" ]
            [ button [ onClick (InputDigit 4) ] [ text "4" ]
            , button [ onClick (InputDigit 5) ] [ text "5" ]
            , button [ onClick (InputDigit 6) ] [ text "6" ]
            , button [ onClick (InputOperator Mul) ] [ text "*" ]
            , button [ onClick (InputOperator Div) ] [ text "/" ]
            ]
        , div [ class "button" ]
            [ button [ onClick (InputDigit 0) ] [ text "0" ]
            , button [ onClick (InputDigit 1) ] [ text "1" ]
            , button [ onClick (InputDigit 2) ] [ text "2" ]
            , button [ onClick (InputDigit 3) ] [ text "3" ]
            , button [ onClick InputEqual ] [ text "=" ]
            ]
        ]
