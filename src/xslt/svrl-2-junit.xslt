<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	version="2.0">
	<xsl:output omit-xml-declaration="no" indent="yes" />

	<xsl:template match="/svrl:schematron-output">
		<testsuite name="{@title}" timestamp="xs:datetime()"
			hostname="localhost" tests="{count(svrl:failed-assert |svrl:successful-report)}"
			failures="{count(svrl:failed-assert)}" errors="0" time="0">
			<properties />
			<xsl:for-each select="svrl:fired-rule">
				<testcase name="{@context}" classname="{preceding-sibling::svrl:active-pattern[1]/@document}" time="0">
					<xsl:if test="name(following-sibling::*[1]) = ('svrl:failed-assert','svrl:successful-report')">
						<error type="{name(following-sibling::*[1])}" message="{following-sibling::*[1]/@location}"><xsl:value-of select="following-sibling::*[1]/svrl:text" /></error>
					</xsl:if>
				</testcase>
			</xsl:for-each>
			<system-out><xsl:value-of select="svrl:text" /></system-out>
			<system-err />
		</testsuite>
	</xsl:template>
</xsl:stylesheet>
