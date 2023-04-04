module Ari.Events exposing
    ( Events
    , onClick
    , compile
    )

{-| Ereignisse.

Siehe `Ari.Css` für eine Erläuterung.
-}

import Html
import Html.Events


type alias Events msg = List ( Event msg )
type Event msg = Event ( Html.Attribute msg )


{-| Mausklick.
-}
onClick : msg -> Event msg
onClick msg = Event ( Html.Events.onClick msg )


{-| Übersetze ein Ereignis in ein Html-Attribut.
-}
unpack : Event msg -> Html.Attribute msg
unpack ( Event attr ) = attr


{-| Übersetze eine Liste von Ereignissen in eine Liste von Html-Attributen.
-}
compile : List ( Event msg ) -> List ( Html.Attribute msg )
compile events = List.map unpack events
