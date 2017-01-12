<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
       xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
       xmlns:xs="http://www.w3.org/TR/2008/REC-xml-20081126#">

       <xsl:strip-space elements="*"/>
       <xsl:output method="xml" indent="yes"/>

       <xsl:param name="BaseURI"><!
       </xsl:param>

       <!-- Begin RDF document -->
       <xsl:template match="/">
              <xsl:element name="rdf:RDF">
                     <rdf:Description>
                            <xsl:attribute name="rdf:about"/>
                            <xsl:apply-templates select="/*|/@*"/>
                     </rdf:Description>
              </xsl:element>
       </xsl:template>

       <!-- Turn XML elements into RDF triples. -->
       <xsl:template match="*">
              <xsl:param name="subjectname"/>

              <!-- Build URI for subjects resources from acestors elements -->
              <xsl:variable name="newsubjectname">
                     <xsl:if test="$subjectname=''">
                            <xsl:value-of select="$BaseURI"/>
                            <xsl:text>#</xsl:text>
                     </xsl:if>
                     <xsl:value-of select="$subjectname"/>
                     <xsl:value-of select="name()"/>
                     <!-- Add an ID to sibling element of identical name -->
                     <xsl:variable name="number">
                            <xsl:number/>
                     </xsl:variable>
                     <xsl:if test="$number > 1">
                            <xsl:text>_</xsl:text>
                            <xsl:number/>
                     </xsl:if>
              </xsl:variable>

              <xsl:element name="{name()}" namespace="{concat(namespace-uri(),'#')}">
                     <rdf:Description>
                            <xsl:attribute name="rdf:about">
                                   <xsl:value-of select="$newsubjectname"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="@*|node()">
                                   <xsl:with-param name="subjectname"
                                          select="concat($newsubjectname,'/')"/>
                            </xsl:apply-templates>
                     </rdf:Description>
              </xsl:element>

             
              <xsl:if test="count(../*) >1">
                     <xsl:element name="{concat('rdf:_',count(preceding-sibling::*)+1)}">
                            <rdf:Description>
                                   <xsl:attribute name="rdf:about">
                                          <xsl:value-of select="$newsubjectname"/>
                                   </xsl:attribute>
                            </rdf:Description>
                     </xsl:element>
              </xsl:if>
       </xsl:template>

   
       <xsl:template match="@*" name="attributes">
              <xsl:variable name="ns">
                     <!-- If attribute doesn't have a namespace use element namespace -->
                     <xsl:choose>
                            <xsl:when test="namespace-uri()=''">
                                   <xsl:value-of select="concat(namespace-uri(..),'#')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                   <xsl:value-of select="concat(namespace-uri(),'#')"/>
                            </xsl:otherwise>
                     </xsl:choose>
              </xsl:variable>
              <xsl:element name="{name()}" namespace="{$ns}">
                     <xsl:value-of select="."/>
              </xsl:element>
       </xsl:template>

       <!-- Enclose text in an rdf:value element -->
       <xsl:template match="text()">
              <xsl:element name="rdf:value">
                     <xsl:value-of select="."/>
              </xsl:element>
       </xsl:template>

       <xsl:template match="comment()">
              <xsl:element name="xs:comment">
                     <xsl:value-of select="."/>
              </xsl:element>
       </xsl:template>

</xsl:stylesheet>
