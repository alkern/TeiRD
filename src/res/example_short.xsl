<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:cts="http://chs.harvard.edu/xmlns/cts"
              xmlns:s="http://relaxng.org/ns/structure/1.0"
              xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
              xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:output method="html" version="5.0"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Short Example</title>
        <link rel="stylesheet" type="text/css" href="styles/default.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="cts:reply">
    <xsl:for-each select="cts:passage/s:div1/s:div2">
      <xsl:for-each select="s:div3">
        <div><xsl:value-of select="."/></div>
      </xsl:for-each>
      <br/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="cts:request"/>

</xsl:stylesheet>
