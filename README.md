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
