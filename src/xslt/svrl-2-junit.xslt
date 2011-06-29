<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
	version="2.0">
	<xsl:output omit-xml-declaration="no" indent="yes" />

	<xsl:template match="/svrl:schematron-output">
		<testsuite name="{@title}" timestamp="xs:datetime()"
			hostname="localhost" tests="{count(svrl:failed-assert |svrl:successful-report)}"
			failures="{count(svrl:failed-assert)}" errors="0" time="0">
			<properties />
			<xsl:for-each select="svrl:failed-assert | svrl:successful-report">
				<testcase name="{@test}" classname="{@location}" time="0">
					<xsl:if test="name() = 'svrl:failed-assert'">
						<error type="{name()}"><xsl:value-of select="svrl:text" /></error>
					</xsl:if>
				</testcase>
			</xsl:for-each>
			<system-out><xsl:value-of select="svrl:text" /></system-out>
			<system-err />
		</testsuite>
	</xsl:template>
</xsl:stylesheet>
