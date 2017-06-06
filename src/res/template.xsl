<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cts="http://chs.harvard.edu/xmlns/cts"
    xmlns:s="http://relaxng.org/ns/structure/1.0"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html"
              encoding="UTF-8"
              indent="yes"/>

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

    <!-- Identity template -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- ignorierte Tags -->
    <xsl:template match="tei:title"/>
    <xsl:template match="s:requestName"/>
    <xsl:template match="s:requestUrn"/>
    <xsl:template match="s:urn"/>
    <xsl:template match="s:license"/>
    <xsl:template match="s:source"/>

</xsl:stylesheet>
