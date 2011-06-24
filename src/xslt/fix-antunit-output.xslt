<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:output omit-xml-declaration="no" indent="yes" />

	<xsl:template match="*|@*">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/testsuite">
		<xsl:copy>
			<xsl:attribute name="tests">
                <xsl:value-of select="count(testcase)" />
            </xsl:attribute>
			<xsl:attribute name="time">
                <xsl:value-of select="sum(testcase/time)" />
            </xsl:attribute>
			<xsl:attribute name="failures">
                <xsl:value-of select="failures" />
            </xsl:attribute>
			<xsl:attribute name="errors">
                <xsl:value-of select="errors" />
            </xsl:attribute>
			<xsl:apply-templates select="@*[name() != 'buildFile']" />
			<xsl:apply-templates select="properties|testcase|system-out" />
			<system-err>
				<xsl:value-of select="error" />
			</system-err>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="testcase">
		<xsl:copy>
			<xsl:attribute name="time">
                <xsl:value-of select="time" />
            </xsl:attribute>
			<xsl:attribute name="classname">
                <xsl:value-of select="@name" />
            </xsl:attribute>
			<xsl:apply-templates select="@*" />
			<xsl:apply-templates select="*[name() != 'time']|text()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="error">
		<xsl:copy>
			<xsl:apply-templates select="@message" />
			<xsl:apply-templates select="@type" />
			<xsl:apply-templates select="*|text()" />
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
