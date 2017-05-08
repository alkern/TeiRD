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
        <title>Long Example</title>
        <link rel="stylesheet" type="text/css" href="../styles/default.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <!-- Personenverzeichnis -->
  <xsl:template match="s:div3[@type='Dramatis_Personae']">
    <h1><xsl:value-of select="string(./s:div4)"/></h1>
    <ul>
      <xsl:for-each select=".//s:div5">
        <li><xsl:value-of select="."/></li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- Akte -->
  <xsl:template match="s:div3[@type='h4']">
    <h1><xsl:value-of select="string(./s:div4)"/></h1>
    <xsl:for-each select=".//s:div5">
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:template>

  <!-- Akte -->
  <xsl:template match="s:div3[@type='h4']">
    <xsl:for-each select=".//s:div4">
      <xsl:choose>
        <xsl:when test="@type[.='h4']">
          <h1><xsl:value-of select="."/></h1>
        </xsl:when>
        <xsl:when test="@type[.='stage']">
          <em><xsl:value-of select="."/></em>
        </xsl:when>
        <xsl:when test="@type[.='sp']">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- ignorierte Tags -->
  <xsl:template match="tei:title"/>

</xsl:stylesheet>
