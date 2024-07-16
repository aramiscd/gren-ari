# gren-ari

**Work in progress!**

- HTML-Elemete (aktuell nur für DIVs und Textknoten)
- CSS (ebenfalls unvollständig)
- Events (aktuell nur für die Maus)

Die Idee ist, so etwas wie eine minimale, aber stetig wachsende
API zu definieren, die nur das enthält, was ich tatsächlich für
bestimmte Anwendungen verwende.  Es ist keine Übung in Minimalisums
per se, sondern ein Versuch, die Untermenge von HTML+CSS+Events,
die ich in diesen Anwendungen tatsächlich verwende, an einer
Stelle zu bündeln.  Das Projekt folgt keiner wohldefinierten
Agenda, aber ein paar (Selbst-)Beobachtungen sind erwähnenswert:

Beim HTML entferne ich mich hier vollständig vom *semantic
markup*.  Aktuell werden nur DIVs und Textknoten unterstützt.
Vermutlich wird noch mehr dazukommen, aber nicht sehr viel.

Beim CSS spiele ich hier mit der Idee,
von Elms [`style : String -> String -> Attribute
msg`](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#style)
wegzugehen und CSS stattdessen als einen großen Record zu
darzustellen, der mit Standardwerten gefüllt ist, die man via
Record Updates überschreiben kann.
