module Ari.Html exposing
    ( div
    , text
    , nothing
    )

{-| Html-Elemente basierend auf meinem `Css`-Datentyp und meinem `Events`-Datentyp.

Siehe `Ari.Css` für eine Erläuterung.
-}

import Ari.Css as Css exposing ( Css )
import Ari.Events as Events exposing ( Events )
import Html exposing ( Html )


div : Css -> Events msg -> List ( Html msg ) -> Html msg
div css events content = Html.div ( attrs css events ) content


text : String -> Html msg
text = Html.text


nothing : Html msg
nothing = Html.text ""


attrs : Css -> Events msg -> List ( Html.Attribute msg )
attrs css events = Css.compile css ++ Events.compile events
