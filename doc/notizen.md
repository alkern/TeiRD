# Aufgabe

HTML-Renderer für TEI/XML-Dokumente, die der CTS-Server bereitstellt

* XML: http://cts.informatik.uni-leipzig.de/textgrid/cts/  
* Plain: http://cts.informatik.uni-leipzig.de/textgrid/plain/  
* Ziel gerendertes HTML: z.B. http://cts.informatik.uni-leipzig.de/textgrid/view/

# URN-Schema:
* urn:cts:[NAMESPACE]:[WORK]:[PASSAGE]
* urn:cts:pbc:bible.parallel.eng:

**Steht der Namespace für die Textgattung und gibt somit Format der divs vor?**
Falls ja, verschiedene XSL-Transformationen für jede Gattung, Bestimmung durch URN,
ansonsten spezielle XSL-Dateien in den Ordnern der einzelnen Dokumente dazu.
Diese dann bei Bedarf dazu laden und transformieren.
Je nach Textgattung können über vordefinierte CSS-Dateien spezielle Designs
genutzt werden.

# Implementierung

## Vorgehen
* Standardmäßig mit divs laden, um bereits vorhandene Strukturen zu nutzen
* JS zur Transformation
* XSL-Vorlagen zu verschiedenen Textstrukturen
* Design über CSS (neben einfacher Gestaltung auch fancy Extras möglich)

## Aufgetretene Probleme:
* XML-Request nur auf Server möglich:
    * sollte kein Problem sein, da das ganze auf CTS-Server laufen soll
    * Alternative: Transformation per PHP serverseitig (Performanz besser?)
* XSLT erkennt unbenannten XMLNS nicht
    * diesen Namespace doppelt in XSL angeben, einmal mit Name

# Sonstiges

* xsl:choose benötigt xsl:otherwise
* for $t in doc('')//.[@n = "1"] return $t == suche in allen Tags nach Attributwert unabhängig von Elementtyp
* <xsl:for-each select="./descendant::node()"> alle Kinder
