<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method='text'/>
    <xsl:variable name='newline'><xsl:text>
    </xsl:text></xsl:variable>

    <xsl:key name="chars" match="persona" use="@short"/>

    <xsl:template match="/play/act/scene" >
        <xsl:variable name="thisScene" select="."/>
        <xsl:variable name="scene" select="@scene"/>
        <xsl:variable name="act" select="@act"/>

        <xsl:variable name="linecount" select="count(speech/line)"/>
        <xsl:variable name="unique-list" select="speech/speaker[not(.=../following-sibling::speech/speaker)]" />

        <xsl:value-of select="concat('Act ',../@num,', scene ',@num,'[',$linecount,']: ',scenelocation,$newline)"/>

        <xsl:for-each select="$unique-list">
            <xsl:value-of select="concat('',.,$newline)"/>
        </xsl:for-each>

        <xsl:value-of select="concat($newline,$newline)"/>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>

</xsl:stylesheet> 
