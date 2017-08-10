# TEI2HTML-Renderer

XSL-Transformationen bieten die Möglichkeit, XML-basierte Dokumente nach definierten Regeln in ein anderes XML-basiertes Format umzuwandeln. Das Projekt nutzt XSLT um vom CTS ausgelieferte TEI-Dokumente automatisch zu menschenlesbarem HTML zu formatieren.

## Nötige Vorkenntnisse

* HTML-Tags
* CSS-Stylesheets
* Struktur der Eingabedatei

## Skript

Das Skript nutzt das __Identity Template__ um Knoten umzuwandeln, und dabei die ursprüngliche Hierarchie des Dokuments zu bewahren.

## Outer Template

Das äußere Template umschließt die Zieldatei mit nötigen HTML-Tags. Hier wird das CSS geladen, sowie typische Informationen wie der Titel festgelegt. Außerdem befindet sich der gesamte Inhalt in einem Bootstrap-Container, um responsiven Verhalten zu erhalten.

## Knoten ersetzen

Um einen Knoten durch einen HTML-Knoten zu ersetzten, benötigt das XSL-Stylesheet eine Regel. Dazu benötigt der template-Tag den zu ersetzenden Knoten als match-Argument. TEI-Knoten haben den _tei_-Namensraum, Strukturelemente stammen aus dem Namensraum _s_-Namensraum. Der Inhalt der Regel ersetzt den gefundenen Knoten, über das Anwenden des __Identity Templates__ transformiert das Stylesheet weitere Kindsknoten.

```xml
    <xsl:template match="s:div4[@type = 'section']"> <!-- ersetze alle div4 des Typs 'section' -->
        <div class="chapter"> <!-- div4 werden durch HTML-divs der 'chapter'-Klasse ersetzt -->
            <xsl:apply-templates select="@* |node()"/> <!-- matche alle Kindsknoten -->
        </div>
    </xsl:template>
```

## Styles

Neben Bootstrap für responsives Design umfasst das Projekt ein CSS-Stylesheet. In diesem lassen sich Regeln zur Darstellung bestimmter Elemente nutzen. Die Elemente lassen sich zum Beispiel über das **class**-Attribut feststellen. Damit bietet der Renderer die gesamte Mächtigkeit von CSS, und lässt sich bei Bedarf auch mit SASS oder ähnlichem erweitern.

## Weitere Eigenschaften

* Divs, für die keine spezielle Regel definiert ist, wandelt das Skript zu HTML-Divs um und nutzt das _type_-Attribut als Klasse
* Knoten, die im Zieldokument nicht benötigt werden, lassen sich durch _template_-Tags mit leerem Körper löschen