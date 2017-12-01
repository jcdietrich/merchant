<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method='text'/>
    <xsl:variable name='newline'><xsl:text>
    </xsl:text></xsl:variable>

    <xsl:template match="persona[@short]" >
        <xsl:variable name="charShort" select="@short"/>

        <xsl:value-of select="concat('(',$charShort,') ',.,' [',@linecount,']',$newline)"/>
        <xsl:for-each select="/play/act/scene[speech/speaker=$charShort]">
            <xsl:variable name="linecount" select="count(speech/line[preceding-sibling::speaker=$charShort])"/>
            <xsl:value-of select="concat('Act ',../@num,', scene ',@num,' [',$linecount,']: ',scenelocation,$newline)"/>

        </xsl:for-each>
        <xsl:value-of select="concat($newline,$newline)"/>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>

</xsl:stylesheet> 
