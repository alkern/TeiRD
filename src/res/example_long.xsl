<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cts="http://chs.harvard.edu/xmlns/cts">

  <xsl:template match="/">
    <html>
      <head>
        <title>Text</title>
        <link rel="stylesheet" type="text/css" href="../styles/default.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="cts:GetPassage">
    <h1>Example</h1>
    <xsl:for-each select="cts:reply">
      <p><xsl:value-of select="cts:passage"/></p>
      <br/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
