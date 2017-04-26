<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cts="http://chs.harvard.edu/xmlns/cts"
  xmlns:s="http://relaxng.org/ns/structure/1.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:template match="/">
    <html>
      <head>
        <h1>Short Example</h1>
        <link rel="stylesheet" type="text/css" href="styles/default.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <!--xsl:template match="cts:reply">
    <br/>
  </xsl:template>

  <xsl:template match="license">
    <br/>
  </xsl:template>

  <xsl:template match="source">
    <br/>
  </xsl:template-->

  <xsl:template match="cts:reply">
    <h1>reply</h1>
    <xsl:for-each select="cts:passage">
      <h2>passage</h2>
      <xsl:for-each select="s:div1">
        <h3>div1</h3>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
