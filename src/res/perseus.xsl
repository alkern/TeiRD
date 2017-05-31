<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cts="http://chs.harvard.edu/xmlns/cts"
  xmlns:s="http://relaxng.org/ns/structure/1.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>

  <!-- Identity template -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/">
    <html>
      <head>
        <link href="styles/default.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <xsl:apply-templates select="@* | node()" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tei:head">
    <b>
      <xsl:apply-templates select="@* |node()" />
    </b>
  </xsl:template>

  <xsl:template match="tei:p">
    <div>
      <xsl:apply-templates select="@* |node()" />
    </div>
  </xsl:template>

  <xsl:template match="tei:hi">
    <i>
      <xsl:apply-templates select="@* |node()" />
    </i>
  </xsl:template>

  <xsl:template match="s:div3">
    <xsl:apply-templates select="@* |node()" />
    <br/>
  </xsl:template>

  <!-- ignorierte Tags -->
  <xsl:template match="tei:title"/>
  <xsl:template match="s:requestName"/>
  <xsl:template match="s:requestUrn"/>
  <xsl:template match="s:urn"/>
  <xsl:template match="s:license"/>
  <xsl:template match="s:source"/>

</xsl:stylesheet>
