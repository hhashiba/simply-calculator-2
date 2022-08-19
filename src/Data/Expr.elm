module Data.Expr exposing (..)


type alias Expr =
    { lhs : Maybe Int
    , operator : Maybe Op
    , rhs : Maybe Int
    }


type Op
    = Add
    | Sub
    | Mul
    | Div
    | Mod
    | Eq


initialize : Expr
initialize =
    { lhs = Nothing
    , operator = Nothing
    , rhs = Nothing
    }


pushDigit : Expr -> Int -> Expr
pushDigit expr digit =
    case expr.operator of
        Just op ->
            case op of
                Eq ->
                    expr

                _ ->
                    { expr | rhs = setDigitInExpr digit expr.rhs }

        Nothing ->
            { expr | lhs = setDigitInExpr digit expr.lhs }


setDigitInExpr : Int -> Maybe Int -> Maybe Int
setDigitInExpr digit hs =
    case hs of
        Just i ->
            Just (i * 10 + digit)

        Nothing ->
            Just digit


pushOperator : Expr -> Op -> Expr
pushOperator expr op =
    case expr.operator of
        Nothing ->
            case expr.lhs of
                Just _ ->
                    { expr | operator = Just op }

                Nothing ->
                    expr

        _ ->
            case expr.rhs of
                Just _ ->
                    { expr
                        | lhs = calcExcute expr
                        , operator = Just op
                        , rhs = Nothing
                    }

                Nothing ->
                    { expr | operator = Just op }


pushEqual : Expr -> Expr
pushEqual expr =
    case expr.rhs of
        Just _ ->
            { expr
                | lhs = calcExcute expr
                , operator = Just Eq
                , rhs = Nothing
            }

        Nothing ->
            expr


calcExcute : Expr -> Maybe Int
calcExcute expr =
    Maybe.map3 calculator expr.lhs expr.rhs expr.operator


calculator : Int -> Int -> Op -> Int
calculator lhs rhs op =
    case op of
        Add ->
            lhs + rhs

        Sub ->
            lhs - rhs

        Mul ->
            lhs * rhs

        Div ->
            lhs // rhs

        Mod ->
            remainderBy rhs lhs

        _ ->
            lhs


showExpr : Expr -> String
showExpr expr =
    case expr.rhs of
        Nothing ->
            case expr.lhs of
                Nothing ->
                    ""

                Just _ ->
                    (expr.lhs |> unwrapMaybeInt |> String.fromInt)
                        ++ (expr.operator |> stringFromOp)

        Just _ ->
            case expr.lhs of
                Nothing ->
                    ""

                Just _ ->
                    (expr.lhs |> unwrapMaybeInt |> String.fromInt)
                        ++ (expr.operator |> stringFromOp)
                        ++ (expr.rhs |> unwrapMaybeInt |> String.fromInt)


unwrapMaybeInt : Maybe Int -> Int
unwrapMaybeInt maybe =
    case maybe of
        Just item ->
            item

        Nothing ->
            0


stringFromOp : Maybe Op -> String
stringFromOp op =
    case op of
        Just Add ->
            "+"

        Just Sub ->
            "-"

        Just Mul ->
            "*"

        Just Div ->
            "/"

        Just Mod ->
            "%"

        _ ->
            ""
