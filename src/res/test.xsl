<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <a>
      <xsl:for-each select=".//b/*">
        <xsl:choose>
          <xsl:when test="text()">
            <it>text</it>
          </xsl:when>
          <xsl:otherwise>
            text
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </a>
  </xsl:template>

  <xsl:template match="subtag">
    yolo
  </xsl:template>

</xsl:stylesheet>
