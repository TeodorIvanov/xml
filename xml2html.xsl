<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:key name="wineList" match="wine" use="wineID"/>
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Каталог на винарски изби</title>
            </head>
            <body>
                <h2>Каталог на винарски изби</h2>
                <xsl:apply-templates select="catalog"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="catalog">
        <table>
            <xsl:for-each select="./regions/region">
                <tr>
                  <h3><xsl:value-of select="."/></h3>
                </tr>
                <xsl:for-each select="winery">
                    <tr>
                        <h4><xsl:value-of select='winery_name'/></h4>
                          <!-- TODO: put winery attributes here -->
                        <xsl:for-each select="wine">
                            <b><xsl:value-of select="key('wineList',wineIDREF)/amenityType"/></b>
                            <!-- TODO: Wine name? -->
                            <ul>
                                <xsl:text>   </xsl:text>
                                <!-- TODO: Put wine attributes here as list items-->
                                <xsl:value-of select="amenityOpenHour"/> -
                                <xsl:value-of select="amenityCloseHour"/>
                            </ul>
                        </xsl:for-each>
                    </tr>
                </xsl:for-each>
                <hr/>
            </xsl:for-each>
        </table>
    </xsl:template>

</xsl:stylesheet>
