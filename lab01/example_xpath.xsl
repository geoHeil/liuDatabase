<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:include href="../resources/util.xsl"/>

    <xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="en">
            <head>
                <meta charset="utf-8"></meta>
                <title>Semistrukturierte Daten - SS14</title>
                <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css"
                      rel="stylesheet"></link>
            </head>
            <body>
                <div class="container">

                    <div class="page-header">
                        <h1>SSD SS14 - XPath</h1>
                    </div>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title" select="'Wie viele Kategorien gibt es?'"/>
                        <xsl:with-param name="query" select="count(//category)"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title" select="'Wie viele User sind männlich?'"/>
                        <xsl:with-param name="query" select="count(//user[@gender = 'male'])"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Geben Sie die IDs aller Question-Elemente aus die eine maxtime von 30 haben.'"/>
                        <xsl:with-param name="query" select="//question[@maxtime = 30]/@id"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Geben Sie die maxtime des zweiten Question-Elementes aus!'"/>
                        <xsl:with-param name="query" select="//question[2]/@maxtime"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title" select="'Hat der User Bart an einem Game teilgenommen?'"/>
                        <xsl:with-param name="query" select="//gamer/@ref='Bart'"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Wie lange hat der User Lisa im Durchschnitt zum Beantworten einer Frage benötigt?'"/>
                        <xsl:with-param name="query" select="avg(//player[@ref='Lisa']/answer/@time)"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Geben Sie die Namen jener User aus, welche nie in einem Game mitgespielt haben.'"/>
                        <xsl:with-param name="query" select="//user/@name[not(.=//gamer/@ref)]"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Geben Sie die maxtime jener Question-Elemente aus die in einem Game vorgekommen sind.'"/>
                        <xsl:with-param name="query" select="//question[@id = //answers/@question]/@maxtime"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Wie viele Antworten hat Lisa abgegeben, bei denen das time Attribute kleiner als 11 ist?'"/>
                        <xsl:with-param name="query" select="count(//player[@ref='Lisa']/answer[@time &lt; 11])"/>
                    </xsl:call-template>

                    <xsl:call-template name="shownodes">
                        <xsl:with-param name="title"
                                        select="'Geben Sie den Text aller Choice-Elemente aus die als korrekt, in der Question mit der ID 2, gekennzeichnet sind.'"/>
                        <xsl:with-param name="query" select="//question[@id=2]/choice[@correct]"/>
                    </xsl:call-template>
                </div>
            </body>
        </html>
    </xsl:template>


</xsl:stylesheet>
