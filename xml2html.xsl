<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:key name="wineList" match="winery" use="wine_id"/>
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Каталог на винарски изби</title>
            </head>
            <body>
                <h1>Каталог на винарски изби</h1>
                <xsl:apply-templates select="catalog"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="catalog">
        <table>
            <xsl:for-each select="./regions/region">
                <xsl:variable name="region_id" select="@id"/>
                <tr>
                  <h2><xsl:value-of select="."/></h2>
                </tr>
                <xsl:for-each select="../../wineries/winery/region[@region_id=$region_id]">
                    <tr>
                        <h4><xsl:value-of select='../winery_name'/></h4>
                        <xsl:value-of select='..'/>
                        <xsl:variable name="wine_ids" select='../@wine_id'/>

                        <!-- TODO: put winery attributes here -->
                          <br/>
                          <h4><small>Вина:</small></h4>
                          <ul>
                          <xsl:for-each select="../../../wine">
                            <xsl:choose>
                              <xsl:when test="contains($wine_ids, @id)">
                                <li>
                                <xsl:value-of select='.'/>
                                <!-- TODO: Wine name? -->
                                <!-- TODO: Put wine attributes here as list items-->
                                </li>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:for-each>
                        </ul>
                    </tr>
                </xsl:for-each>
                <hr/>
            </xsl:for-each>
        </table>
    </xsl:template>


</xsl:stylesheet>
