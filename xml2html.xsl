<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
                        <ul>
                            <li>Година на основаване: <xsl:value-of select='../winery_year'/></li>
                            <li>Площ: <xsl:value-of select='../area'/></li>
                            <li>Продукция: <xsl:value-of select='../production'/></li>
                            <li>Собственик: <xsl:value-of select='../owner'/></li>
                        </ul>
                        <xsl:variable name="wine_ids" select='../@wine_id'/>
                          <h4><small>Вина:</small></h4>
                          <ul>
                          <xsl:for-each select="../../../wine">
                            <xsl:choose>
                              <xsl:when test="contains($wine_ids, @id)">
                                <li><xsl:value-of select='./type'/>
                                    <ul>
                                      <li>Произход: <xsl:value-of select='./origin'/></li>
                                      <li>Цвят: <xsl:value-of select='./color'/></li>
                                      <li>Почва: <xsl:value-of select='./soil'/></li>
                                      <li>Добив: <xsl:value-of select='./yield'/></li>
                                      <li style='max-width: 50%;'>Характеристики: <xsl:value-of select='./characteristics'/></li>
                                    </ul>
                                    <br/>
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
