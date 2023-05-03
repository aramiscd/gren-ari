module Ari.Css exposing
    ( Css
    , AlignItems (..)
    , Display (..)
    , FlexDirection (..)
    , FontSize (..)
    , FontWeight (..)
    , JustifyContent (..)
    , Length (..)
    , Position (..)
    , TextDecorationLine (..)
    , UserSelect (..)
    , css
    , compile
    ) 

{-| Record-basiertes CSS.

Ich bin unzufrieden damit, wie CSS normalerweise in Elm gehandhabt wird. Prinzipiell kann ich das Design gut
nachvollziehen.  Bspw. muss `style : String -> String -> Attribute msg` nicht aktualisiert werden wenn neue
CSS-Attribute hinzukommen.  In der Praxis wird CSS in Elm aber sehr schnell unhandlich und unübersichtlich,
so dass die manuelle Konstruktion von grafischen Benutzerschnittstellen mit elm/html nicht gut skaliert.

Ich probiere hier einen alternativen Ansatz aus: CSS wird als ein großer Elm-Record spezifiziert.  Dadurch kann man
Elms Record-Update-Syntax verwenden um CSS-Attribute zu setzen.  Für die Felder lege ich eigene Datentypen fest,
damit der Compiler noch mehr mithelfen kann, CSS zu schreiben.  Weiterhin möchte ich hier nur die Teilmenge von
CSS abbilden, die ich tatsächlich verwende, denn CSS ist mittlerweile so umfangreich, dass ich mich nach einer
klar definierten, kompakten Teilmenge sehne, die immer noch ausreicht, um moderne GUIs zu konstruieren.

Ein Nachteil bei diesem Ansatz ist, dass der gesamte(!) CSS-Record am Ende als inline Style-Attribut in
jedem(!) Html-Element untergebracht wird.  Das lässt sich prinzipiell optimieren, aber unoptimiert bläht es
das Html-Markup erheblich auf.  Außerdem weiß ich aktuell nicht, wie gut Elm mit großen Records zurechtkommt.
Es ist denkbar, dass hier Engpässe lauern, zumal Elm auch an anderen Stellen die Erwartungshaltung mitbringt,
dass Quantitäten auf der Typ-Ebene einstellig bleiben.
-}

import Html
import Html.Attributes exposing ( style )


type AlignItems = AiStart | AiCenter | AiEnd | AiStretch
type Display = DFlex | DInline
type FlexDirection = FdRow | FdRowReverse | FdColumn | FdColumnReverse
type FontSize = FsInherit | FsXXSmall | FsXSmall | FsSmall | FsMedium | FsLarge | FsXLarge | FsXXLarge | FsXXXLarge
type FontWeight = FwNormal | FwBold
type JustifyContent = JcStart | JcCenter | JcEnd | JcSpaceBetween | JcSpaceAround | JcSpaceEvenly | JcStretch
type Length = LAuto | Px Int | Vh Int | Vw Int | Vmax Int | Vmin Int
type Position = PAbsolute | PRelative | PStatic | PSticky
type TextDecorationLine = TdlNone | TdlUnderline | TdlOverline | TdlLineThrough | TdlBlink
type UserSelect = UsNone | UsAuto | UsText | UsAll | UsContain


{-| Übersetze einen CSS-Record in eine Attributliste.
-}
compile : Css -> List ( Html.Attribute msg )
compile ss =
    [ style "align-items" ( strAlignItems ss.alignItems )
    , style "background-color" ss.bgColor
    , style "border-color" ss.borderColor
    , style "border-width" ( strLength ss.borderWidth )
    , style "color" ss.color
    , style "cursor" ss.cursor
    , style "display" ( strDisplay ss.display )
    , style "flexDirection" ( strFlexDirection ss.flexDirection )
    , style "font-family" ss.fontFamily
    , style "font-size" ( strFontSize ss.fontSize )
    , style "font-weight" ( strFontWeight ss.fontWeight )
    , style "height" ( strLength ss.height )
    , style "justify-content" ( strJustifyContent ss.justifyContent )
    , style "margin-bottom" ( strLength ss.marginBottom )
    , style "margin-left" ( strLength ss.marginLeft )
    , style "margin-right" ( strLength ss.marginRight )
    , style "margin-top" ( strLength ss.marginTop )
    , style "min-height" ( strLength ss.minHeight )
    , style "min-width" ( strLength ss.minWidth )
    , style "padding-bottom" ( strLength ss.paddingBottom )
    , style "padding-left" ( strLength ss.paddingLeft )
    , style "padding-right" ( strLength ss.paddingRight )
    , style "padding-top" ( strLength ss.paddingTop )
    , style "position" ( strPosition ss.position )
    , style "text-decoration-line" ( strTextDecorationLine ss.textDecorationLine )
    , style "user-select" ( strUserSelect ss.userSelect )
    , style "width" ( strLength ss.width )
    --
    , style "border-style" "solid"
    ]


{-| CSS-Record-Datentyp.
-}
type alias Css =
    { alignItems : AlignItems
    , bgColor : String
    , borderColor : String
    , borderWidth : Length
    , color : String
    , cursor : String
    , display : Display
    , flexDirection : FlexDirection
    , fontFamily : String
    , fontSize : FontSize
    , fontWeight : FontWeight
    , height : Length
    , justifyContent : JustifyContent
    , marginBottom : Length
    , marginLeft : Length
    , marginRight : Length
    , marginTop : Length
    , minHeight : Length
    , minWidth : Length
    , paddingBottom : Length
    , paddingLeft : Length
    , paddingRight : Length
    , paddingTop : Length
    , position : Position
    , textDecorationLine : TextDecorationLine
    , userSelect : UserSelect
    , width : Length
    }


{-| CSS-Record.
-}
css : Css
css =
    { alignItems = AiStart
    , bgColor = "transparent"
    , borderColor = "inherit"
    , borderWidth = Px 0
    , color = "inherit"
    , cursor = "auto"
    , display = DFlex
    , flexDirection = FdRow
    , fontFamily = "inherit"
    , fontSize = FsInherit
    , fontWeight = FwNormal
    , height = LAuto
    , justifyContent = JcStart
    , marginBottom = Px 0
    , marginLeft = Px 0
    , marginRight = Px 0
    , marginTop = Px 0
    , minHeight = LAuto
    , minWidth = LAuto
    , paddingBottom = Px 0
    , paddingLeft = Px 0
    , paddingRight = Px 0
    , paddingTop = Px 0
    , position = PStatic
    , textDecorationLine = TdlNone
    , userSelect = UsAuto
    , width = LAuto
    }


{-| Übersetze `Length` in einen String.
-}
strLength : Length -> String
strLength v = case v of
    LAuto -> "auto"
    Px n -> String.fromInt n ++ "px"
    Vh n -> String.fromInt n ++ "vh"
    Vw n -> String.fromInt n ++ "vw"
    Vmax n -> String.fromInt n ++ "vmax"
    Vmin n -> String.fromInt n ++ "vmin"


{-| Übersetze `AlignItems` in einen String.
-}
strAlignItems : AlignItems -> String
strAlignItems v = case v of
    AiStart -> "start"
    AiCenter -> "center"
    AiEnd -> "end"
    AiStretch -> "stretch"


{-| Übersetze `Display` in einen String.
-}
strDisplay : Display -> String
strDisplay v = case v of
    DFlex -> "flex"
    DInline -> "Inline"


{-| Übersetze `FlexDirection` in einen String.
-}
strFlexDirection : FlexDirection -> String
strFlexDirection v = case v of
    FdRow -> "row"
    FdRowReverse -> "row-reverse"
    FdColumn -> "column"
    FdColumnReverse -> "column-reverse"


{-| Übersetze `JustifyContent` in einen String.
-}
strJustifyContent : JustifyContent -> String
strJustifyContent v = case v of
    JcStart -> "start"
    JcCenter -> "center"
    JcEnd -> "end"
    JcSpaceBetween -> "space-between"
    JcSpaceAround -> "space-around"
    JcSpaceEvenly -> "space-evenly"
    JcStretch -> "stretch"


{-| Überetze `FontSize` in einen String.
-}
strFontSize : FontSize -> String
strFontSize v = case v of
    FsInherit -> "inherit"
    FsXXSmall -> "xx-small"
    FsXSmall -> "x-small"
    FsSmall -> "small"
    FsMedium -> "medium"
    FsLarge -> "large"
    FsXLarge -> "x-large"
    FsXXLarge -> "xx-large"
    FsXXXLarge -> "xx-large"


{-| Übersetze `UserSelect` in einen String.
-}
strUserSelect : UserSelect -> String
strUserSelect v = case v of
    UsNone -> "none"
    UsAuto -> "auto"
    UsText -> "text"
    UsAll -> "all"
    UsContain -> "contain"


{-| Überetze `TextDecorationLine` in einen String.
-}
strTextDecorationLine : TextDecorationLine -> String
strTextDecorationLine v = case v of
    TdlNone -> "none"
    TdlUnderline -> "underline"
    TdlOverline -> "overline"
    TdlLineThrough -> "line-through"
    TdlBlink -> "blink"


{-| Übersetze `FontWeight` in einen String.
-}
strFontWeight : FontWeight -> String
strFontWeight v = case v of
    FwNormal -> "normal"
    FwBold -> "bold"


{-| Übersetze `Position` in einen CSS-Wert.
-}
strPosition : Position -> String
strPosition v = case v of
    PAbsolute -> "absolute"
    PRelative -> "relative"
    PStatic -> "static"
    PSticky -> "sticky"
