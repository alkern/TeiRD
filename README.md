# TEI2HTML-Renderer

XSL-Transformationen bieten die Möglichkeit, XML-basierte Dokumente nach definierten Regeln in ein anderes XML-basiertes Format umzuwandeln. Das Projekt nutzt XSLT um vom CTS ausgelieferte TEI-Dokumente automatisch zu menschenlesbarem HTML zu formatieren.

## Server-Anwendung

### Server auf Tomcat deployen

* WAR mithilfe von ```gradle build``` bauen. Das Archiv findet sich im [lib-Verzeichnis](./server/build/libs)
* WAR als renderer.war ins webapps-Verzeichnis des Tomcat kopieren und Tomcat starten
* CSS-Stylesheets lassen sich im renderer-Ordner unter Webapps ablegen

### Server nutzen

Die Serveranwendung lässt sich über folgende URL aufrufen: ```<server>:8080/renderer/<ctsname>/<urn><?style=...>```

ctsname entspricht dem Namen des konkreten CTS, zum Beispiel demo, textgrid, ...

Die URN entspricht dabei der URN wie sie auch das normale CTS nutzt

Über den optionalen Query-Parameter _style_ lässt sich ein bestimmtes CSS-Stylesheet mit dem übergebenen Namen aufrufen. Ohne Parameter nutzt die Anwendung _default.css_

## Renderer

### Nötige Vorkenntnisse

* HTML-Tags
* CSS-Stylesheets
* Struktur der Eingabedatei

### Skript

Das Skript nutzt das __Identity Template__ um Knoten umzuwandeln, und dabei die ursprüngliche Hierarchie des Dokuments zu bewahren. Es befindet sich im Ordner ``renderer/WEB_INF/classes`` und kann jederzeit verändert werden.

### Outer Template

Das äußere Template umschließt die Zieldatei mit nötigen HTML-Tags. Hier wird das CSS geladen, sowie typische Informationen wie der Titel festgelegt. Außerdem befindet sich der gesamte Inhalt in einem Bootstrap-Container, um responsiven Verhalten zu erhalten.

### Knoten ersetzen

Um einen Knoten durch einen HTML-Knoten zu ersetzten, benötigt das XSL-Stylesheet eine Regel. Dazu benötigt der template-Tag den zu ersetzenden Knoten als match-Argument. TEI-Knoten haben den _tei_-Namensraum, Strukturelemente stammen aus dem Namensraum _s_-Namensraum. Der Inhalt der Regel ersetzt den gefundenen Knoten, über das Anwenden des __Identity Templates__ transformiert das Stylesheet weitere Kindsknoten.

Knoten, die nicht in divs gewrappt sind müssen über Regeln der Form

```xml
<xsl:template match="*[name() = 'trailer']"> <!-- matche trailer-Knoten, divs mit Attribut trailer werden automatisch umgewandelt-->
    <div class="trailer"> <!-- Node zu div ändern -->
        <xsl:apply-templates select="@* |node()"/> <!-- nachfolgende Knoten matchen -->
    </div>
</xsl:template>
```

gemacht werden. divs im Tei-Text werden automatisch zu HTML-Divs gerendert, der bisherige Typ wird dabei zur Klasse.

### Styles

Die Anwendung unterstützt CSS-Stylesheets, in denen die Anzeigelogik liegt. Über die URL können verschiedene Styles aufgerufen werden. Alle verfügbaren Stylesheets sind unter /renderer/styles aufgelistet.

Die Elemente im gerenderten HTML lassen sich über das **class**-Attribut feststellen. Damit bietet der Renderer die gesamte Mächtigkeit von CSS, und lässt sich bei Bedarf auch mit SASS oder ähnlichem erweitern.

Eine CSS-Regel sieht wie folgt aus:

```css
  div.stage { /* Divs mit der Stage-Klasse matchen, entspricht sowohl <stage> als auch <div4 type="stage"> im TEI-XML */
    font-style: italic; /* Szenenbeschreibungen kursiv darstellen */
  }
```

### Weitere Eigenschaften

* Divs, für die keine spezielle Regel definiert ist, wandelt das Skript zu HTML-Divs um und nutzt das _type_-Attribut als Klasse
* Knoten, die im Zieldokument nicht benötigt werden, lassen sich durch _template_-Tags mit leerem Körper löschen

## Vorgehen und Implementierung

Die Anwendung rendert TEI-XML zu HTML. Der Vorteil hierbei ist, dass Webbrowser als HTML-Reader nutzbar sind und somit automatisches Rendering auf einer Vielzahl von (mobilen) Endgeräten verfügbar ist. Zur Transformation zwischen zwei XML-basierten Sprachen ist XSLT der W3C-Standard.

Der Server, der das gerenderte HTML zur Verfügung stellt, ist mit Spring Boot implementiert. Damit ist die WAR auf einem zur Verfügung gestellten Tomcat ausführbar, außerdem ist das Programm sehr kurz gehalten. Es fragt über einen HTTP-Request den TEI-XML-Text an, transformiert ihn mit dem Stylesheet und sendet das entstandene HTML an den Nutzer.

### Umsetzung

Die größte Herausforderung war die Einarbeitung in XSLT. Anhand von Beispieltexten wurde sukzessive ein Stylesheet ausgearbeitet. Dies gestaltete sich äußerst langwierig, da XSLT über sehr wenige aussagekräftige Fehler- oder Warnungen verfügt. Sehr viele aufgetretene Probleme mussten über ausführliche Tests gelöst werden. Die Vielzahl an verfügbaren XSLT-Tutorials richtet sich dabei leider an Programmieranfänger und behandelt die Grundlagen, während es zu typischen/konkreten Problemen wiederum eher wenig Literatur gibt und auch beispielsweise Stack Overflow wenig Informationen liefert.

Die Entscheidung für Spring Boot als Framework für die Serveranwendung erfolgte hauptsächlich aufgrund voriger Erfahrung damit. Durch den Einsatz von Kotlin ist die Implementierung sehr kompakt. Mithilfe einer Properties-Datei ist die Anwendung konfigurierbar, und ist somit sowohl unter Windows und Linux, als auch lokal und in der Zielumgebung ausführbar.

### Aufgetretene Problem

* Die TEI-Tags sind in eine Div-Hierarchie gewrappt (durch divs=true-Konfiguration). Diese divs sind durchnummeriert (div1, div2...). Mithilfe einer startwith-Funktion transformiert das XSL-Stylesheet diese divs zu HTML-divs, und übernimmt dabei den Typ als CSS-Klasse. Diese Lösung nutzt die vorhandene Hierarchie der Dokumente, und lässt bei der Gestltung durch CSS-Stylesheets große Freiheiten, um verschiedene Texte passend zu gestalten. Ein weiterer Vorteil hierbei ist, dass CSS-Kentnisse weiter verbreitet sind als XSLT, wodurch die Anwendung leicht zu erweitern bleibt.
* Die XML-Namensräume in den TEI-Dokumenten sind nicht immer stringent angegeben. Damit war das Matching über die übliche XSLT-Regeln nicht immer möglich. Die finale Lösung besteht darin, Knoten anhand ihres Namens bzw. Type-Attributs zu identifizieren. Das löst auch das folgende Problem
* Nicht alle TEI-Dokumente sind in divs gewrappt verfügbar. Anstatt das Type-Attribut zu matchen, und so den TEI-Tag zu identifizeren, muss auch der Name berücksichtigt werden.
* TEI-Attribute lassen sich relativ flexibel nutzen. Mithilfe des TEI-Standards und einer Vielzahl von Beispieltexten, sowohl aus dem CTS wie auch der TEI-Dokumentation und weiteren Internetquellen wurde ein möglichst flexibler Standard bestimmt, der die meisten Texte abdecken kann. Der Grundgedanke dabei ist, lieber zuviel Informationen zu behalten, und diese bei Bedarf über CSS auszublenden. So sind beispielweise Zeilennummerierungen noch im Text, lassen sich aber durch CSS ausblenden. So kann der gleiche Text auch verschiedenen Anforderungen gerecht werden.
* Das default.css-Stylesheet findet sich auf dem Server im Verzeichnis der Anwendung, da jedoch kein HTML auf dem Standardwerk von Java EE, sondern der gerendete Text als einfache Antwort über eine RESTful-Schnittstelle, kann das Stylesheet nicht einfach genutzt werden. CSS-Stylesheets müssen deshalb manuell im Root-Verzeichnis der Anwendung abgelegt werden.
* Einige Texte enthalten invalides XML. Über den Parameter ```escapepassage=true``` ist es möglich, dieses zu escapen, da invalides XML nicht transformierbar ist. Da sich das XML dann allerdings in den Texten befindet, kann der XSL-Transformator es nicht mehr ohne weiteres matchen. Eine mögliche Lösung ist, eine geeignete Vorverarbeitung durchzuführen, um ein valides XML-Dokument zu erhalten. Das Problem ist noch offen.
