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
        <link rel="stylesheet" type="text/css" href="../styles/default.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="s:div1">
    <xsl:for-each select="./descendant::node()">
      <xsl:choose>
        <!--  -->
        <xsl:when test="@type[.='chapter']">
          <div><xsl:value-of select="."/></div><br/>
        </xsl:when>

        <xsl:when test="@type[.='section']">
          <p><xsl:value-of select="."/></p><br/>
        </xsl:when>

        <xsl:otherwise/>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- ignorierte Tags -->
  <xsl:template match="tei:title"/>
  <xsl:template match="s:requestName"/>
  <xsl:template match="s:requestUrn"/>
  <xsl:template match="s:urn"/>
  <xsl:template match="s:license"/>
  <xsl:template match="s:source"/>

</xsl:stylesheet>
