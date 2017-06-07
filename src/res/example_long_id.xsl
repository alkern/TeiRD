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
        <link rel="stylesheet" type="text/css" href="styles/default.css"/>
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

    <!-- Personenverzeichnis -->
    <xsl:template match="s:div4[@type = 'h4']">
        <h1>
            <xsl:apply-templates select="@* |node()" />
        </h1>
    </xsl:template>

    <xsl:template match="s:div4[@type = 'castGroup']">
        <ul>
            <xsl:apply-templates select="@* |node()" />
        </ul>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'castItem']">
        <li>
            <xsl:apply-templates select="@* |node()" />
        </li>
    </xsl:template>

    <!-- Text -->
    <xsl:template match="s:div4[@type = 'stage']">
        <xsl:apply-templates select="@* |node()" />
        <br/>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'italic']">
        <i>
            <xsl:apply-templates select="@* |node()" />
        </i>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'spaced']">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="@* |node()" />
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="s:div4[@type = 'sp']">
        <br/>
        <div class="sp">
            <xsl:apply-templates select="@* |node()" />
        </div>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'stage']">
        <xsl:apply-templates select="@* |node()" />
        <br/>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'speaker']">
        <b>
			<xsl:apply-templates select="@* |node()" />
		</b>
        <br/>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'l']">
        <xsl:apply-templates select="@* |node()" />
        <br/>
    </xsl:template>

    <xsl:template match="s:div6[@type = 'l']">
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
