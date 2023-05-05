module Ari.Events exposing
    ( Events
    , onClick
    , onMouseDown
    , onMouseUp
    , onTouchStart
    , onTouchEnd
    , compile
    )

{-| Ereignisse.

Siehe `Ari.Css` für eine Erläuterung.
-}

import Html
import Html.Events
import Html.Events.Extra.Touch


type alias Events msg = List ( Event msg )
type Event msg = Event ( Html.Attribute msg )


{-| Mausklick.
-}
onClick : msg -> Event msg
onClick msg = Event ( Html.Events.onClick msg )


{-| Maustaste wird gedrückt.
-}
onMouseDown : msg -> Event msg
onMouseDown msg = Event ( Html.Events.onMouseDown msg )


{-| Maustaste wird losgelassen.
-}
onMouseUp : msg -> Event msg
onMouseUp msg = Event ( Html.Events.onMouseUp msg )


{-| Finger berührt den Bildschirm.
-}
onTouchStart : msg -> Event msg
onTouchStart msg = Event ( Html.Events.Extra.Touch.onStart ( \ _ -> msg ) )


{-| Finger verlässt den Bildschirm.
-}
onTouchEnd : msg -> Event msg
onTouchEnd msg = Event ( Html.Events.Extra.Touch.onEnd ( \ _ -> msg ) )


{-| Übersetze ein Ereignis in ein Html-Attribut.
-}
unpack : Event msg -> Html.Attribute msg
unpack ( Event attr ) = attr


{-| Übersetze eine Liste von Ereignissen in eine Liste von Html-Attributen.
-}
compile : List ( Event msg ) -> List ( Html.Attribute msg )
compile events = List.map unpack events
