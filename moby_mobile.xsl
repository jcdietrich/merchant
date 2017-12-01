<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:es="http://openshakespeare.org/functions"
    >
    <xsl:output method="text" encoding="UTF-8"/>


    <xsl:template match="/">

        <xsl:apply-templates select="//personae/*" />


        <xsl:value-of select="/play//scndescr" />}

        <xsl:apply-templates select="//play//act" />

    </xsl:template>

    <xsl:template match="CUT" />
    <xsl:template match="personae/TITLE" />

    <xsl:template match="pgroup">
        {<xsl:value-of select="grpdescr" />}

        <xsl:apply-templates select="persona" />
        -----
    </xsl:template>

    <xsl:template match="pgroup/persona">
        <xsl:value-of select="." />_

    </xsl:template>

    <xsl:template match="persona">
        <xsl:value-of select="." />_

    </xsl:template>

    <xsl:template match="act">
        ACT <xsl:value-of select="@num"/>
        <xsl:apply-templates select="scene" />
    </xsl:template>

    <xsl:template match="CUT/act" />

<!-- do nothing for act or scene TITLE -->
<xsl:template match="acttitle" />
<xsl:template match="scenetitle" />

<xsl:template match="scene">
    SCENE <xsl:value-of select="@num"/>, 
    <xsl:value-of select="scenelocation" /> <xsl:value-of select="scenepersonae" />
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="scenelocation">

</xsl:template>
<xsl:template match="scenepersonae">

</xsl:template>

<xsl:template match="stagedir">
    [<xsl:value-of select="." />]
</xsl:template>

<xsl:template match="speech/stagedir">
    [<xsl:value-of select="." />]

</xsl:template>



<xsl:template match="line/stagedir"> [<xsl:value-of select="./text()" />] </xsl:template>


<xsl:template match="speech[line[@form='prose']]">
    <xsl:apply-templates />
</xsl:template>
<xsl:template match="speech[line[@form='verse']]">
    <xsl:apply-templates />
</xsl:template>
<xsl:template match="speech[line[@type='lyric']]">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="line">
    <xsl:if test="@offset">   </xsl:if>
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="line/text()" >
<xsl:value-of select="." /></xsl:template>
<!--
<xsl:template match="speech">
\begin{drama*}
  <xsl:apply-templates />
\end{drama*}
</xsl:template>

<xsl:template match="line">
        <xsl:if test="@offset">\hspace{<xsl:value-of select="@offset"/>em}</xsl:if>
        <xsl:if test="@form='prose'">\end{drama*}</xsl:if>
                <xsl:value-of select="." />\\
        <xsl:if test="@form='prose'">\begin{drama*}</xsl:if>
</xsl:template>
-->

<xsl:template match="speaker"><xsl:value-of select="." />
</xsl:template>

<xsl:template match="recite"><xsl:value-of select="." /></xsl:template>

</xsl:stylesheet>
