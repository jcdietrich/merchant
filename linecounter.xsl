<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="persona[@short]" >
        <xsl:variable name="charShort" select="@short"/>
        <xsl:copy>
            <xsl:attribute name="linecount">
                <xsl:value-of select="count(/play/act/scene/speech/line[preceding-sibling::speaker=$charShort])"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="scene" >
        <xsl:copy>
            <xsl:attribute name="act">
                <xsl:value-of select="../@act"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet> 
