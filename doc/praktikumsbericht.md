# Praktikumsbericht

## Motivation

Das CTS-Protokoll ermöglicht die einheitliche Identifikation und die Abfrage von Textpassagen. Der von der Abteilung Automatische Sprachverarbeitung an der Universität Leipzig zur Verfügung gestellte Server liefert Texte im TEI-XML-Format in maschinenlesbarem Format über das CTS-Protokoll.

Das Ziel dieser Arbeit ist, die so verfügbaren Texte automatisiert in ein menschenlesbares Format zu transformieren. Damit erweitert sie die Funktionalität der vorhandenen Anwendung dahingehend, dass interessierte Nutzer Texte einfach und mit der gesamten Stärke von CTS angenehm aufbereitet lesen können.

## Planung

Die Anwendung rendert TEI-XML zu HTML. Der Vorteil hierbei ist, dass Webbrowser als HTML-Reader nutzbar sind und somit automatisches Rendering auf einer Vielzahl von (mobilen) Endgeräten verfügbar ist. Zur Transformation zwischen zwei XML-basierten Sprachen ist XSLT der W3C-Standard.

Der Server, der das gerenderte HTML zur Verfügung stellt, ist mit Spring Boot implementiert. Damit ist die WAR auf einem zur Verfügung gestellten Tomcat ausführbar, außerdem ist das Programm sehr kurz gehalten. Es fragt über einen HTTP-Request den TEI-XML-Text an, transformiert ihn mit dem Stylesheet und sendet das entstandene HTML an den Nutzer.

## Umsetzung

Die größte Herausforderung war die Einarbeitung in XSLT. Anhand von Beispieltexten wurde sukzessive ein Stylesheet ausgearbeitet. Dies gestaltete sich äußerst langwierig, da XSLT über sehr wenige aussagekräftige Fehler- oder Warnungen verfügt. Sehr viele aufgetretene Probleme mussten über ausführliche Tests gelöst werden. Die Vielzahl an verfügbaren XSLT-Tutorials richtet sich dabei leider an Programmieranfänger und behandelt die Grundlagen, während es zu typischen/konkreten Problemen wiederum eher wenig Literatur gibt und auch beispielsweise Stack Overflow wenig Informationen liefert.

Die Entscheidung für Spring Boot als Framework für die Serveranwendung erfolgte hauptsächlich aufgrund voriger Erfahrung damit. Lokal ausgeführt lässt sich die Anwendung sehr einfach testen und debuggen, wodurch die Entwicklungszeit sehr verkürzt wurde. Ein Nachteil hierbei ist die relativ schwergewichtige Datei, die durch Spring angewachsen ist. Durch den Einsatz von Kotlin ist die Implementierung sehr kompakt. Mithilfe einer Properties-Datei ist die Anwendung konfigurierbar, und ist somit sowohl unter Windows und Linux, als auch lokal und in der Zielumgebung ausführbar. Ein ungelöstes Problem liegt darin, dass die Konfiguration aktuell nur bei einem Neustart des Servers neu geladen wird.

## Aufgetretene Probleme

* Die TEI-Tags sind in eine Div-Hierarchie gewrappt (durch divs=true-Konfiguration). Diese divs sind durchnummeriert (div1, div2...). Mithilfe einer startwith-Funktion transformiert das XSL-Stylesheet diese divs zu HTML-divs, und übernimmt dabei den Typ als CSS-Klasse. Diese Lösung nutzt die vorhandene Hierarchie der Dokumente, und lässt bei der Gestltung durch CSS-Stylesheets große Freiheiten, um verschiedene Texte passend zu gestalten. Ein weiterer Vorteil hierbei ist, dass CSS-Kentnisse weiter verbreitet sind als XSLT, wodurch die Anwendung leicht zu erweitern bleibt.
* Die XML-Namensräume in den TEI-Dokumenten sind nicht immer stringent angegeben. Damit war das Matching über die übliche XSLT-Regeln nicht immer möglich. Die finale Lösung besteht darin, Knoten anhand ihres Namens bzw. Type-Attributs zu identifizieren. Das löst auch das folgende Problem
* Nicht alle TEI-Dokumente sind in divs gewrappt verfügbar. Anstatt das Type-Attribut zu matchen, und so den TEI-Tag zu identifizeren, muss auch der Name berücksichtigt werden.
* TEI-Attribute lassen sich relativ flexibel nutzen. Mithilfe des TEI-Standards und einer Vielzahl von Beispieltexten, sowohl aus dem CTS wie auch der TEI-Dokumentation und weiteren Internetquellen wurde ein möglichst flexibler Standard bestimmt, der die meisten Texte abdecken kann. Der Grundgedanke dabei ist, lieber zuviel Informationen zu behalten, und diese bei Bedarf über CSS auszublenden. So sind beispielweise Zeilennummerierungen noch im Text, lassen sich aber durch CSS ausblenden. So kann der gleiche Text auch verschiedenen Anforderungen gerecht werden.
* Das default.css-Stylesheet findet sich auf dem Server im Verzeichnis der Anwendung, da jedoch kein HTML auf dem Standardwerk von Java EE, sondern der gerendete Text als einfache Antwort über eine RESTful-Schnittstelle, kann das Stylesheet nicht einfach genutzt werden. CSS-Stylesheets müssen deshalb manuell im Root-Verzeichnis der Anwendung abgelegt werden.
* Einige Texte enthalten invalides XML. Über den Parameter ```escapepassage=true``` ist es möglich, dieses zu escapen, da invalides XML nicht transformierbar ist. Da sich das XML dann allerdings in den Texten befindet, kann der XSL-Transformator es nicht mehr ohne weiteres matchen. Eine mögliche Lösung ist, eine geeignete Vorverarbeitung durchzuführen, um ein valides XML-Dokument zu erhalten. Das Problem ist noch offen.
