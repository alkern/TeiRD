<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="div3">
        DIV3
    </xsl:template>

    <xsl:template match="*[starts-with(name(), 'div')]">
        <div type="{@type}"><xsl:value-of select="name()"/></div>
    </xsl:template>

</xsl:stylesheet>
