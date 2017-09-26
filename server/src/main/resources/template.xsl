<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:s="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html"
                encoding="UTF-8"
                indent="yes"/>

    <!-- Outer template -->
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="TOREPLACE"/>
                <title>CTS-Renderer</title>
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
    <xsl:template match="s:div4[@type = 'castGroup']">
        <ul>
            <xsl:apply-templates select="@* |node()"/>
        </ul>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'castItem']">
        <li>
            <xsl:apply-templates select="@* |node()"/>
        </li>
    </xsl:template>

    <!-- todo auch list und item als @type von div betrachten -->
    <xsl:template match="s:list">
        <ul>
            <xsl:apply-templates select="@* |node()"/>
        </ul>
    </xsl:template>

    <xsl:template match="s:item">
        <li>
            <xsl:apply-templates select="@* |node()"/>
        </li>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'bold']">
        <b>
            <xsl:apply-templates select="@* |node()"/>
        </b>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'italic']">
        <i>
            <xsl:apply-templates select="@* |node()"/>
        </i>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'ital']">
        <i>
            <xsl:apply-templates select="@* |node()"/>
        </i>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'spaced']">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="@* |node()"/>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="s:head">
        <h1>
            <xsl:apply-templates select="@* |node()"/>
        </h1>
    </xsl:template>

    <xsl:template match="s:p">
        <div class="p">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:l">
        <div class="l">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:lg">
        <div class="lg">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:sp">
        <div class="sp">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:speaker">
        <div class="speaker">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:stage">
        <div class="stage">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:quote">
        <div class="quote">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:q">
        <div class="quote">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:note">
        <div class="note">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:trailer">
        <div class="trailer">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <!-- Regex mit matches funktioniert mit dem Java-XSLT nicht... -->
    <xsl:template match="*[@type = 'h1' or name() = 'h1' or
						   @type = 'h2' or name() = 'h2' or
						   @type = 'h3' or name() = 'h3' or
						   @type = 'h4' or name() = 'h4' or
						   @type = 'h5' or name() = 'h5']">
        <h1>
            <xsl:apply-templates select="@* |node()"/>
        </h1>
    </xsl:template>


    <!-- Kopiert alle übrigen div-Elemente und behält Typ -->
    <xsl:template match="*[starts-with(name(), 'div')]" priority="0">
        <div class="{@type}">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>



    <!-- ignorierte Tags -->
    <xsl:template match="tei:title"/>
    <xsl:template match="s:requestName"/>
    <xsl:template match="s:requestUrn"/>
    <xsl:template match="s:urn"/>
    <xsl:template match="s:license"/>
    <xsl:template match="s:source"/>

    <xsl:template match="s:GetPassage">
        <xsl:apply-templates select="@* |node()"/>
    </xsl:template>
    <xsl:template match="s:passage">
        <xsl:apply-templates select="@* |node()"/>
    </xsl:template>
    <xsl:template match="s:request">
        <xsl:apply-templates select="@* |node()"/>
    </xsl:template>
    <xsl:template match="s:reply">
        <xsl:apply-templates select="@* |node()"/>
    </xsl:template>

</xsl:stylesheet>