module SPA exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Navigation exposing (..)

main : Program Never Model Msg
main =
    Navigation.program locFor
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- ROUTING


locFor : Location -> Msg
locFor location =
    case location.hash of
        "#home" ->
            GoTo Home

        "#login" ->
            GoTo Login

        "#about" ->
            GoTo About

        _ ->
            GoTo Home



-- MODEL


type Page
    = Home
    | Login
    | About


type alias Model =
    { currentPage : Page
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        page =
            case location.hash of
                "#home" ->
                    Home

                "#login" ->
                    Login

                "#about" ->
                    About

                _ ->
                    Home
    in
        ( Model page, Cmd.none )



-- UPDATE


type Msg
    = GoTo Page
    | LinkTo String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoTo page ->
            ( { model | currentPage = page }, Cmd.none )

        LinkTo path ->
            ( model, newUrl path )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "SPA application" ]
        , render_menu model
        , render_page model
        ]


render_menu : Model -> Html Msg
render_menu model =
    div []
        [ button [ onClick (LinkTo "#home") ] [ text "Home" ]
        , button [ onClick (LinkTo "#login") ] [ text "Login" ]
        , button [ onClick (LinkTo "#about") ] [ text "About" ]
        ]


render_page : Model -> Html Msg
render_page model =
    let
        page_content =
            case model.currentPage of
                Home ->
                    text "Home"

                Login ->
                    text "Login"

                About ->
                    text "About"
    in
        div [] [ page_content ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none