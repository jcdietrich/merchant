<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:es="http://openshakespeare.org/functions"
    >
    <xsl:output method="text" encoding="UTF-8"/>


    <xsl:template match="/">
        \documentclass[11pt,oneside]{book}
        \usepackage[usenames,dvipsnames]{xcolor}
        \usepackage{datetime}
        \usepackage{tocloft}
        \usepackage{verse}
        \usepackage[lnps]{dramatist}
        \usepackage{setspace}
        \usepackage{fancyhdr}
        \usepackage{graphicx}
        \usepackage{setspace}
        \usepackage[normalem]{ulem}
        \usepackage{color}
        \usepackage{lmodern}
        \usepackage{fontspec}
        \usepackage{tgbonum}
        \setmainfont[Numbers={OldStyle},Ligatures={Historic, Discretionary, Contextual}]{Linux Libertine}
        \usepackage[perpage]{footmisc}
        \usepackage[hidelinks]{hyperref}
        \usepackage[top=.5in,left=1.5in,total={6in,9.25in},centering]{geometry}
        \usepackage{footmisc}
        \renewcommand*{\footnotelayout}{\scriptsize\sffamily}
        %\setlength{\marginparwidth}{0pt}

        \poemlines{2}

        %custom titlepage
        \newcommand*{\titleMAC}{\begingroup
        \raggedleft
        \vspace*{\baselineskip}
        {\Large William Shakespeare}\\[0.167\textheight]
        %{\bfseries Production of}\\[\baselineskip]
        {\textcolor{BrickRed}{\Huge \bf Merchant of Venice}}\\[\baselineskip]
        {\small directed by Jonathan C. Dietrich}\par
        \date{\today}\par
        \vfill
        \includegraphics[scale=1]{LadyJustice.pdf}
        \endgroup}

        \definecolor{cut}{gray}{0.4}

        \begin{document}

        %changes the speaker name's size to smaller
        \renewcommand{\speaksfont}{\scriptsize\ \scshape}

        \setlength{\vindent}{0pt}


        % do the title page
        \pagestyle{empty}
        \titleMAC
        \newpage

        \tableofcontents

        % setup the footer
        \pagestyle{fancyplain}
        \fancyhf{}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0.2pt}
        \lfoot{\fancyplain{}{The Merchant of Venice}}
        \rfoot{\fancyplain{}{\thepage}}
        \cfoot{\fancyplain{}{\MakeUppercase{\theact} -- \thescene}}

        % setup stagedir
        %\StageDirConf{\fontfamily{lmtt}\selectfont}

        <xsl:apply-templates select="//personae/*" />

        \DramPer

        \vspace{5 em}

        {\large <xsl:value-of select="/play//scndescr" />}

        <xsl:apply-templates select="//play//act" />

        \end{document}
    </xsl:template>

    <xsl:template match="CUT" />
    <xsl:template match="personae/TITLE" />

    <xsl:template match="pgroup">
        \begin{CharacterGroup}{<xsl:value-of select="grpdescr" />}
        <xsl:apply-templates select="persona" />\end{CharacterGroup}

    </xsl:template>

    <xsl:template match="pgroup/persona">  \GCharacter{<xsl:value-of select="current()" />}{<xsl:value-of select="current()" />}{<xsl:value-of select="." />}
    </xsl:template>

    <xsl:template match="persona">  \Character[<xsl:value-of select="current()" />]{<xsl:value-of select="current()" />}{<xsl:value-of select="." />}
    </xsl:template>

    <xsl:template match="act">
        \act
        <xsl:apply-templates select="scene" />
    </xsl:template>

    <xsl:template match="CUT/act" />

<!-- do nothing for act or scene TITLE -->
<xsl:template match="acttitle" />
<xsl:template match="scenetitle" />

<xsl:template match="scene">
    <xsl:if test="@num!=1">\clearpage</xsl:if>
<!-- 
\scene{<xsl:value-of select="TITLE" />}
-->
\scene

<xsl:value-of select="scenelocation" /> <xsl:value-of select="scenepersonae" />
<xsl:apply-templates />
</xsl:template>

<xsl:template match="scenelocation">

</xsl:template>
<xsl:template match="scenepersonae">

</xsl:template>

<xsl:template match="stagedir">
    \StageDir{\{<xsl:value-of select="." />\}}
</xsl:template>

<xsl:template match="speech/stagedir">
    \begin{onehalfspacing}\direct{<xsl:value-of select="." />}
    \end{onehalfspacing}
</xsl:template>



<xsl:template match="line/stagedir">\direct*{<xsl:value-of select="./text()" />}</xsl:template>


<xsl:template match="speech[line[@form='prose']]">
    \begin{drama*}
    <xsl:apply-templates />
    \end{drama*}
</xsl:template>
<xsl:template match="speech[line[@form='verse']]">
    \begin{drama*}
    <xsl:apply-templates />
    \end{drama*}
</xsl:template>
<xsl:template match="speech[line[@type='lyric']]">
    \begin{drama*}{\em
    <xsl:apply-templates />
    }
    \end{drama*}
</xsl:template>

<xsl:template match="line">
    <xsl:if test="@offset">\hspace{<xsl:value-of select="@offset"/>em}</xsl:if>
    <xsl:apply-templates />\\
</xsl:template>

<xsl:template match="line/text()" ><xsl:value-of select="." /></xsl:template>
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

<xsl:template match="speaker">
<!-- \<xsl:value-of select="es:norm_name(string(SPEAKER))" />speaks -->
\speaker{<xsl:value-of select="." />}
</xsl:template>

<xsl:template match="recite">\hspace{4em}{\em <xsl:value-of select="." />}</xsl:template>
<xsl:template match="french">{\em <xsl:value-of select="." />}</xsl:template>

<xsl:template match="note">\footnote{<xsl:value-of select="." />}</xsl:template>
</xsl:stylesheet>
