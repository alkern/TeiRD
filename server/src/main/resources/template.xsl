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
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <link rel="stylesheet" type="text/css" href="TOREPLACE"/>
                <title>CTS-Renderer</title>
            </head>
            <body>
                <div class="container">
                    <xsl:apply-templates/>
                </div>
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
            <xsl:apply-templates select="@* |node()"/>
        </h1>
    </xsl:template>

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

    <!-- Gedicht -->
    <xsl:template match="s:div4[@type = 'stage']">
        <xsl:apply-templates select="@* |node()"/>
        <br/>
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

    <xsl:template match="s:div4[@type = 'sp']">
        <br/>
        <div class="sp">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'stage']">
        <xsl:apply-templates select="@* |node()"/>
        <br/>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'speaker']">
        <b>
            <xsl:apply-templates select="@* |node()"/>
        </b>
        <br/>
    </xsl:template>

    <xsl:template match="s:div5[@type = 'l']">
        <xsl:apply-templates select="@* |node()"/>
        <br/>
    </xsl:template>

    <xsl:template match="s:div6[@type = 'l']">
        <xsl:apply-templates select="@* |node()"/>
        <br/>
    </xsl:template>

    <!-- Perseus -->
    <xsl:template match="s:div2[@type = 'intro']">
        <div class="intro">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:div2[@type = 'book']">
        <div class="book">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:div3[@type = 'chapter']">
        <div class="chapter">
            <xsl:apply-templates select="@* |node()"/>
        </div>
        <br/>
    </xsl:template>

    <xsl:template match="s:div4[@type = 'section']">
        <div class="chapter">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="p:head">
        <h1>
            <xsl:apply-templates select="@* |node()"/>
        </h1>
    </xsl:template>

    <xsl:template>
        <h1>
            <xsl:apply-templates select="@* |node()"/>
        </h1>
    </xsl:template>

    <xsl:template match="s:p">
    <div class="p">
        <xsl:apply-templates select="@* |node()"/>
    </div>
    <br/>
    </xsl:template>

    <xsl:template match="s:l">
    <div class="speech">
        <xsl:apply-templates select="@* |node()"/>
    </div>
    </xsl:template>

    <xsl:template match="s:quote">
    <i>
        <xsl:apply-templates select="@* |node()"/>
    </i>
    </xsl:template>

    <!-- Oh Tannenbaum (Lied) -->
    <xsl:template match="s:div2[@type = 'strophe']">
        <div class="strophe">
            <xsl:apply-templates select="@* |node()"/>
        </div>
        <br/>
    </xsl:template>

    <xsl:template match="s:div3[@type = 'line']">
        <xsl:apply-templates select="@* |node()"/>
        <br/>
    </xsl:template>

    <!-- TED-Subtitles -->
    <xsl:template match="s:div1[@type = 'paragraf']">
        <div class="p">
            <xsl:apply-templates select="@* |node()"/>
        </div>
        <br/>
    </xsl:template>

    <xsl:template match="s:div2[@type = 'line']">
        <xsl:apply-templates select="@* |node()"/>
        <br/>
    </xsl:template>

    <!-- Hänsel und Gretel -->
    <xsl:template match="s:div3[@type = 'h4']">
        <h1>
            <xsl:apply-templates select="@* |node()"/>
        </h1>
    </xsl:template>

    <xsl:template match="s:div3[@type = 'p']">
        <div class="p">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:div3[@type = 'lg']">
        <div class="speech">
            <xsl:apply-templates select="@* |node()"/>
        </div>
        <br/>
    </xsl:template>

    <xsl:template match="s:div3[@type = 'l']">
        <div class="speech">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>

    <xsl:template match="s:note">
        <div class="note">
            <xsl:apply-templates select="@* |node()"/>
        </div>
    </xsl:template>


    <!-- Kopiert alle übrigen div-Elemente und behält Typ -->
    <xsl:template match="*[starts-with(name(), 'div')]" priority="0">
        <div type="{@type}">
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
