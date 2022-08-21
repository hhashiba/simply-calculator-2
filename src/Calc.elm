module Calc exposing (Model, main)

import Browser
import Data.Expr as Expr exposing (Expr, Op(..))
import Element exposing (Element, centerX, centerY, column, el, explain, fill, height, layout, paddingXY, px, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Font as Font
import Element.Input exposing (button)
import Html exposing (Html)



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
    let
        cButton : Msg -> String -> Element Msg
        cButton msg name =
            el
                [ width (px 50)
                , height (px 50)
                , Background.color (rgb255 195 224 244)
                ]
                (button [ paddingXY 15 10, centerX, centerY ]
                    { label = text name, onPress = Just msg }
                )
    in
    layout [ width fill, height fill ] <|
        el
            [ Font.size 25
            , Font.family [ Font.typeface "Helvetica", Font.sansSerif ]
            , Font.bold
            ]
            (column [ spacing 3 ]
                [ el
                    [ width fill
                    , height (px 50)
                    , paddingXY 0 5
                    , Font.letterSpacing 2
                    , Font.alignRight
                    ]
                    (text (Expr.showExpr model.expr))
                , row [ spacing 3 ]
                    [ cButton InputAllClear "AC"
                    , cButton (InputOperator Mod) "%"
                    , cButton (InputOperator Div) "/"
                    , cButton (InputOperator Mul) "*"
                    ]
                , row [ spacing 3 ]
                    [ cButton (InputDigit 7) "7"
                    , cButton (InputDigit 8) "8"
                    , cButton (InputDigit 9) "9"
                    , cButton (InputOperator Add) "+"
                    ]
                , row [ spacing 3 ]
                    [ cButton (InputDigit 4) "4"
                    , cButton (InputDigit 5) "5"
                    , cButton (InputDigit 6) "6"
                    , cButton (InputOperator Sub) "-"
                    ]
                , row [ spacing 3 ]
                    [ cButton (InputDigit 0) "0"
                    , cButton (InputDigit 1) "1"
                    , cButton (InputDigit 2) "2"
                    , cButton (InputDigit 3) "3"
                    , cButton InputEqual "="
                    ]
                ]
            )



-- div
--     [ class "calculator" ]
--     [ div
--         []
--         [ text (Expr.showExpr model.expr) ]
--     , div [ class "button" ]
--         [ button [ onClick InputAllClear ] [ text "AC" ]
--         , button [ onClick (InputOperator Mod) ] [ text "%" ]
--         ]
--     , div [ class "button" ]
--         [ button [ onClick (InputDigit 7) ] [ text "7" ]
--         , button [ onClick (InputDigit 8) ] [ text "8" ]
--         , button [ onClick (InputDigit 9) ] [ text "9" ]
--         , button [ onClick (InputOperator Add) ] [ text "+" ]
--         , button [ onClick (InputOperator Sub) ] [ text "-" ]
--         ]
--     , div [ class "button" ]
--         [ button [ onClick (InputDigit 4) ] [ text "4" ]
--         , button [ onClick (InputDigit 5) ] [ text "5" ]
--         , button [ onClick (InputDigit 6) ] [ text "6" ]
--         , button [ onClick (InputOperator Mul) ] [ text "*" ]
--         , button [ onClick (InputOperator Div) ] [ text "/" ]
--         ]
--     , div [ class "button" ]
--         [ button [ onClick (InputDigit 0) ] [ text "0" ]
--         , button [ onClick (InputDigit 1) ] [ text "1" ]
--         , button [ onClick (InputDigit 2) ] [ text "2" ]
--         , button [ onClick (InputDigit 3) ] [ text "3" ]
--         , button [ onClick InputEqual ] [ text "=" ]
--         ]
--     ]
