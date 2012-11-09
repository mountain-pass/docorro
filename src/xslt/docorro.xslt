<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xsl xs docorro html wsdl SOAP-ENC"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:docorro="http://windyroad.org/docorro/functions" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" version="2.0">
	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />

	<xsl:variable name="type-catalogue">
		<xsl:copy-of select="//xs:schema" />
	</xsl:variable>

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:choose>
						<xsl:when test="wsdl:definitions">
							<xsl:value-of select="wsdl:definitions/@name" />
							<xsl:text> - WSDL Interface Specification</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>XSD Interface Specification</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</title>
				<style type="text/css">
					<xsl:text><![CDATA[
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
    margin: 0;
    padding: 0;
    border: 0;
    outline: 0;
    font-weight: inherit;
    font-style: inherit;
    font-size: 100%;
    font-family: inherit;
    vertical-align: baseline;
    background: transparent;
}
/* remember to define focus styles! */
:focus {
    outline: 0;
}
body {
    line-height: 1;
    color: black;
    background: white;
}
ol, ul {
    list-style: none;
}
/* tables still need 'cellspacing="0"' in the markup */
table {
    border-collapse: collapse;
    border-spacing: 0;
}
table table {
    margin: 0;
}

caption, th, td {
    text-align: left;
    font-weight: normal;
}

blockquote:before, blockquote:after,
q:before, q:after {
    content: "";
}
blockquote, q {
    quotes: "" "";
}

body { 
    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
    font-size: 0.9em;
    margin: 0px;
    padding: 0px;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: 170% 100%;
}

#container {
    padding: 25px;
    margin: 25px auto;
    background: rgba(244,244,244,0.7);
    width: 80%;
    box-shadow: 0 3px 4px rgba(0, 0, 0, 0.3);
    -moz-box-shadow: 0 3px 4px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0 3px 4px rgba(0, 0, 0, 0.3);
    margin-bottom: 25px;
    -moz-border-radius: 15px;
    -webkit-border-radius: 15px;
    border-radius: 15px;
}

th {
    background: black; color: white; text-align: center;
    padding: 4px;
    font-weight: bold;
    text-align: left;
    border: solid black 1px;
}

td {
    padding: 2px 4px;
    border: solid black 1px;
}

tbody, thead { 
    border: solid black 4px; 
}

table table tbody, table table thead {
    border-right: none;
}

tr.alt { background: rgba(0,0,0,0.06); }


tbody tr th {
    text-align: right;
    background: #222;
}

tbody tr.alt th { background: black; }

div.logo { 
    width: 223px; height: 67px;
    margin: 40px auto -120px;
    border: none;
    box-shadow: 0 3px 4px rgba(0, 0, 0, 0.3);
    -moz-box-shadow: 0 3px 4px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0 3px 4px rgba(0, 0, 0, 0.3);
    -moz-border-radius: 15px;
    -webkit-border-radius: 15px;
    border-radius: 15px;
    padding: 10px 5px 5px 5px;
    background-color: #fff;
    background-position: center;
    background-repeat: no-repeat;
}


div.logo a { 
    display: block;
    width: 223px; height: 67px;
    text-indent: -99999em;
}

h1 {
    font-size: 2em;
    font-weight: bold;
    padding: 20px 0 20px 25px;
    margin: -25px -25px -10px;
    text-shadow: #fff 1px 1px 0;
    background: #FFFF88;
    -moz-border-radius-topright: 15px;
    -webkit-border-top-right-radius: 15px;
    -moz-border-radius-topleft: 15px;
    -webkit-border-top-left-radius: 15px;
    border-bottom: 1px solid #ddd;
}

h2 {
    margin: 40px 0 10px;
    padding-top: 10px;
    font-weight: bold;
    font-size: 1.3em;
}

h3 {
    margin: 30px 0 6px;
    padding-top: 6px;
    font-weight: bold;
    font-size: 1.1em;
}

h5.macrodef {
    font-family: "Lucida Console", "Consolas", "Courier New", "Courier", monospace;
    overflow: auto;
    padding: 5px;
    margin-left: -5px;
    margin-right: -5px;
    background: #FFFF88;
    -moz-border-radius: 0.5em;
    -webkit-border-radius: 0.5em;
    border-raduis: 0.5em;
    -moz-box-shadow: 0px 0.25em 0.5em #ccc;
    -webkit-box-shadow: 0px 0.25em 0.5em #ccc;
    box-shadow: 0px 0.25em 0.5em #ccc;
    border: none;
}

h3.macrodef:target {
    background: #AFF;
}


h4 {
    margin: 20px 0 5px;
    padding-top: 5px;
    font-weight: bold;
    font-size: 1em;
    color: #555;
}

h5 {
    margin: 10px 0 5px;
    padding-top: 5px;
    font-weight: bold;
    font-size: 0.8em;
}

h6 {
    font-weight: bold;
}


pre {
    font-family: "Lucida Console", "Consolas", "Courier New", "Courier", monospace;
    overflow: auto;
    padding: 2.5px;
    margin: 1em;
    margin-left: 5em;
    background: #FFFF88;
    -moz-border-radius: 0.5em;
    -webkit-border-radius: 0.5em;
    border-raduis: 0.5em;
    -moz-box-shadow: 0px 0.25em 0.5em #ccc;
    -webkit-box-shadow: 0px 0.25em 0.5em #ccc;
    box-shadow: 0px 0.25em 0.5em #ccc;
}

code {
    font-family: "Lucida Console", "Consolas", "Courier New", "Courier", monospace;
    background: #FFFFCC;
    border-left: 3px solid #FFFFCC; 
    border-right: 3px solid #FFFFCC; 
    border-top: 1px solid #FFFFCC; 
    border-bottom: 1px solid #FFFFCC; 
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
}

p {
    margin-top: 0.5em;
    margin-bottom: 0.5em;
}

em {
    font-style: italic;
}

strong {
    font-weight: bold;
}

td.attribute-name, td.element-name, td.property-name {
    text-align: right;
    white-space: nowrap;
    font-weight: bold;
}

td.default {
    white-space: nowrap;
}


ul {
    margin: 0 0 0 1em;
    list-style: disc inside none;
}

ol {
    margin: 0 0 0 1em;
    list-style: decimal inside none;
}

img {
    display: block;
    text-align: center;
    margin:auto;
    margin-bottom: 0.5em;
    margin-top: 0.5em;
    border: 2px solid #aaa;
    -moz-box-shadow: 0px 0.5em 0.5em #ccc;
    -webkit-box-shadow: 0px 0.5em 0.5em #ccc;
    box-shadow: 0px 0.5em 0.5em #ccc;
    padding: 1em;
    background: white;
    -webkit-border-radius: 1em;
    -moz-border-radius: 1em;
    border-radius: 1em;
}

div.caption {
    text-align: center;
    font-style: italic;
    font-size: 90%
}

table {
    -moz-box-shadow: 0px 0.25em 0.5em #ccc;
    -webkit-box-shadow: 0px 0.25em 0.5em #ccc;
    box-shadow: 0px 0.25em 0.5em #ccc;
    margin-bottom: 0.5em;
    margin-top: 0.5em;
}

tr:target, tr.alt:target {
    background: #AFF;
}

.required {
    font-weight: bold;
}


]]></xsl:text>
				</style>
				<!-- script type="text/javascript"> var _gaq = _gaq || []; _gaq.push(['_setAccount', 
					'UA-808591-8']); _gaq.push(['_setDomainName', 'windyroad.org']); _gaq.push(['_setAllowLinker', 
					true]); _gaq.push(['_trackPageview']); (function() { var ga = document.createElement('script'); 
					ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol 
					? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = 
					document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, 
					s); })(); </script -->
			</head>
			<body
				style="">
				<div id="container">
					<h1>
						<xsl:choose>
							<xsl:when test="wsdl:definitions">
								<xsl:value-of select="wsdl:definitions/@name" />
								<span style="display: block; font-size: 0.5em;  text-shadow: none;">
									<xsl:text>WSDL Interface Specification</xsl:text>
								</span>
								<span
									style="display: block; font-size: 0.4em; font-style: italic; font-weight: normal; text-shadow: none;">
									<xsl:text>tns:</xsl:text>
									<xsl:value-of select="wsdl:definitions/@targetNamespace" />
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span style="display: block; font-size: 0.5em;  text-shadow: none;">
									<xsl:text>XSD Interface Specification</xsl:text>
								</span>
								<span
									style="display: block; font-size: 0.4em; font-style: italic; font-weight: normal; text-shadow: none;">
									<xsl:text>tns:</xsl:text>
									<xsl:choose>
										<xsl:when test="xs:schema/@targetNamespace">
											<xsl:value-of select="xs:schema/@targetNamespace" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>none</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</span>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if
							test="matches((wsdl:definitions/wsdl:documentation | xs:schema/xs:annotation/xs:documentation)[1], '^\s*(Version .*?)($.*)', 'sm')">
							<span
								style="display: block; font-size: 0.4em; font-style: italic; font-weight: normal; text-shadow: none;">
								<xsl:value-of
									select="replace((wsdl:definitions/wsdl:documentation | xs:schema/xs:annotation/xs:documentation)[1], '^\s*(Version .*?)($.*)', '$1', 'sm')" />
							</span>
						</xsl:if>
					</h1>
					<xsl:variable name="content">
						<xsl:call-template name="output-content">
							<xsl:with-param name="content"
								select="replace(wsdl:definitions/wsdl:documentation, '^\s*(Version .*?)($.*)', '$2', 'sm')" />
							<xsl:with-param name="section" select="wsdl:definitions/@name" />
						</xsl:call-template>

						<xsl:if test="wsdl:definitions/wsdl:portType">
							<h2 id="{docorro:convert-to-id('Operation')}">Operations</h2>
							<xsl:for-each select="wsdl:definitions/wsdl:portType/wsdl:operation">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." />
							</xsl:for-each>
						</xsl:if>

						<xsl:if test="wsdl:definitions/wsdl:message">
							<h2 id="{docorro:convert-to-id('Messages')}">Messages</h2>
							<p>
								<xsl:text>The following section details each of the messages defined by </xsl:text>
								<xsl:value-of select="wsdl:definitions/@name" />
							</p>
							<ul>
								<xsl:for-each select="wsdl:definitions/wsdl:message">
									<xsl:sort select="@name" />
									<li>
										<a href="{concat('#', docorro:convert-to-id(@name))}">
											<xsl:value-of select="@name" />
										</a>
									</li>
								</xsl:for-each>
							</ul>
							<xsl:for-each select="wsdl:definitions/wsdl:message">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." />
							</xsl:for-each>
						</xsl:if>

						<xsl:if
							test="false() and wsdl:definitions/wsdl:types/xs:schema/xs:simpleType[exists(.//xs:enumeration)]">
							<h2 id="{docorro:convert-to-id('Enumeration')}">Enumerations</h2>
							<p>
								<xsl:text>The following section details each of the enumerations user by </xsl:text>
								<xsl:value-of select="wsdl:definitions/@name" />
							</p>
							<ul>
								<xsl:for-each
									select="wsdl:definitions/wsdl:types/xs:schema/xs:simpleType[exists(.//xs:enumeration)]">
									<xsl:sort select="@name" />
									<li>
										<a href="{concat('#', docorro:convert-to-id(@name))}">
											<xsl:value-of select="@name" />
										</a>
									</li>
								</xsl:for-each>
							</ul>
							<xsl:for-each
								select="wsdl:definitions/wsdl:types/xs:schema/xs:simpleType[exists(.//xs:enumeration)]">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." />
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="xs:schema/xs:element">
							<h2 id="{docorro:convert-to-id('Elements')}">Elements</h2>
							<p>
								<xsl:text>The following section details each of the elementes defined in this schema </xsl:text>
							</p>
							<ul>
								<xsl:for-each select="xs:schema/xs:element">
									<xsl:sort select="@name" />
									<li>
										<a href="{concat('#', docorro:convert-to-id(@name))}">
											<xsl:value-of select="@name" />
										</a>
									</li>
								</xsl:for-each>
							</ul>
							<xsl:for-each select="xs:schema/xs:element">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." mode="xsd" />
							</xsl:for-each>
						</xsl:if>
					</xsl:variable>
					<h2 id="contents">Contents</h2>
					<ul id="contents-list">
						<xsl:for-each select="$content/html:h2">
							<li>
								<a href="{concat('#',@id)}">
									<xsl:value-of select="." />
								</a>
								<xsl:variable name="next" select="following-sibling::html:h2[1]" />
								<xsl:variable name="next-h3"
									select="$next/following-sibling::html:h3" />
								<xsl:if test="following-sibling::html:h3 except $next-h3">
									<ul>
										<xsl:for-each select="following-sibling::html:h3 except $next-h3">
											<li>
												<a href="{concat('#',@id)}">
													<xsl:value-of select="." />
												</a>
												<xsl:variable name="next"
													select="following-sibling::html:h3[1]" />
												<xsl:variable name="next-h4"
													select="$next/following-sibling::html:h4" />
												<xsl:if test="following-sibling::html:h4[@id] except $next-h4">
													<ul>
														<xsl:for-each select="following-sibling::html:h4 except $next-h4">
															<li>
																<a href="{concat('#',@id)}">
																	<xsl:value-of select="." />
																</a>
															</li>
														</xsl:for-each>
													</ul>
												</xsl:if>
											</li>
										</xsl:for-each>
									</ul>
								</xsl:if>
							</li>
						</xsl:for-each>
					</ul>
					<xsl:copy-of select="$content" />
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="wsdl:operation">
		<xsl:variable name="section" select="../@name" />
		<h3 id="{docorro:convert-to-id(concat($section, ' ', @name))}">
			<xsl:value-of select="@name" />
		</h3>
		<table>
			<tbody>
				<tr>
					<th>Port Type</th>
					<td>
						<xsl:value-of select="../@name" />
					</td>
				</tr>
				<tr>
					<th>Name</th>
					<td>
						<xsl:value-of select="@name" />
					</td>
				</tr>
				<tr>
					<th>Message Exchange Pattern</th>
					<td>
						<xsl:if test="wsdl:fault and not(wsdl:input and wsdl:output)">
							<xsl:text>Robust </xsl:text>
						</xsl:if>
						<xsl:choose>
							<xsl:when
								test="wsdl:input and wsdl:output and local-name(*[1]) = 'input'">
								<xsl:text>In-Out</xsl:text>
							</xsl:when>
							<xsl:when test="wsdl:input and wsdl:output">
								<xsl:text>Out-In</xsl:text>
							</xsl:when>
							<xsl:when test="wsdl:input">
								<xsl:text>In-Only</xsl:text>
							</xsl:when>
							<xsl:when test="wsdl:output">
								<xsl:text>Out-Only</xsl:text>
							</xsl:when>
						</xsl:choose>
					</td>
				</tr>
			</tbody>
		</table>
		<xsl:call-template name="output-content">
			<xsl:with-param name="content" select="wsdl:documentation/(*|text())" />
			<xsl:with-param name="section" select="$section" />
		</xsl:call-template>
		<h4>Messages</h4>
		<table class="detail">
			<thead>
				<tr>
					<th>Kind</th>
					<th>Name</th>
					<th>Type</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="wsdl:input|wsdl:output|wsdl:fault">
					<tr>
						<xsl:variable name="message" select="replace(@message, '^tns:', '')" />
						<xsl:if test="position() mod 2 = 0">
							<xsl:attribute name="class">alt</xsl:attribute>
						</xsl:if>
						<td class="element-name">
							<xsl:value-of select="local-name()" />
						</td>
						<td>
							<xsl:choose>
								<xsl:when test="exists(@name)">
									<xsl:value-of select="@name" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$message" />
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<a href="{concat('#', docorro:convert-to-id($message))}">
								<xsl:value-of select="$message" />
							</a>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="wsdl:message">
		<xsl:variable name="section" select="@name" />
		<h3 id="{docorro:convert-to-id($section)}">
			<xsl:value-of select="$section" />
		</h3>
		<xsl:variable name="references"
			select="../wsdl:portType/wsdl:operation/wsdl:*[@message=concat('tns:',$section)]" />
		<p>
			<xsl:text>Message Type: </xsl:text>
			<xsl:for-each-group select="$references" group-by="local-name()">
				<xsl:value-of select="current-grouping-key()" />
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each-group>
		</p>
		<p>Used in:</p>
		<ul>
			<xsl:for-each select="$references">
				<li>
					<a
						href="{concat('#',docorro:convert-to-id(concat(../../@name,' ',../@name)))}">
						<xsl:value-of select="../../@name" />
						<xsl:text>:</xsl:text>
						<xsl:value-of select="../@name" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
		<xsl:call-template name="output-content">
			<xsl:with-param name="content" select="wsdl:documentation/(*|text())" />
			<xsl:with-param name="section" select="$section" />
		</xsl:call-template>
		<h4>Message Structure</h4>
		<table class="detail">
			<thead>
				<tr>
					<th>Node</th>
					<th>Type</th>
					<th>Cardinality</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<xsl:variable name="rows">
					<xsl:apply-templates select="wsdl:part">
						<xsl:with-param name="section" select="$section" />
					</xsl:apply-templates>
				</xsl:variable>
				<xsl:for-each select="$rows/html:tr">
					<xsl:copy>
						<xsl:if test="exists(@class) or position() mod 2 = 0">
							<xsl:attribute name="class"><xsl:value-of
								select="@class" />
                            <xsl:if test="position() mod 2 = 0">
                                <xsl:text> alt</xsl:text>
                            </xsl:if>
                            </xsl:attribute>
						</xsl:if>
						<xsl:copy-of select="@*[name() != 'class']" />
						<xsl:copy-of select="*|text()|comment()" />
					</xsl:copy>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>



	<xsl:template match="wsdl:part[exists(@element)]">
		<xsl:param name="section" />
		<xsl:variable name="parttype" select="docorro:get-element(@element,.)" />
		<xsl:message>
			<xsl:copy-of select="$parttype" />
		</xsl:message>
		<xsl:apply-templates select="$parttype">
			<xsl:with-param name="indent" select="''" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="minOccurs" select="'1'" />
			<xsl:with-param name="maxOccurs" select="'1'" />
			<xsl:with-param name="expanded-nodes">
				<nodes />
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="wsdl:part[exists(@type)]">
		<xsl:param name="section" />
		<tr>
			<td>
				<xsl:attribute name="class">required</xsl:attribute>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<xsl:value-of select="@type" />
			</td>
			<td>
				<xsl:text>1..1</xsl:text>
			</td>
			<td>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content" select="wsdl:documentation/(*|text())" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
		<xsl:variable name="parttype" select="docorro:get-type(@type,.)" />
		<xsl:message>
			<xsl:copy-of select="$parttype" />
		</xsl:message>
		<xsl:apply-templates select="$parttype">
			<xsl:with-param name="indent" select="'&#160;&#160;&#160;&#160;'" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes">
				<nodes />
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:element" mode="xsd">
		<xsl:variable name="section" select="@name" />
		<h3 id="{docorro:convert-to-id($section)}">
			<xsl:value-of select="$section" />
		</h3>
		<xsl:call-template name="output-content">
			<xsl:with-param name="content"
				select="xs:annotation/xs:documentation/(*|text())" />
			<xsl:with-param name="section" select="$section" />
		</xsl:call-template>
		<h4>Element Structure</h4>
		<table class="detail">
			<thead>
				<tr>
					<th>Node</th>
					<th>Type</th>
					<th>Cardinality</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<xsl:variable name="rows">
					<xsl:apply-templates select=".">
						<xsl:with-param name="indent" select="''" />
						<xsl:with-param name="section" select="$section" />
						<xsl:with-param name="minOccurs" select="'1'" />
						<xsl:with-param name="maxOccurs" select="'1'" />
						<xsl:with-param name="expanded-nodes">
							<nodes />
						</xsl:with-param>
					</xsl:apply-templates>
				</xsl:variable>
				<xsl:for-each select="$rows/html:tr">
					<xsl:copy>
						<xsl:if test="exists(@class) or position() mod 2 = 0">
							<xsl:attribute name="class"><xsl:value-of
								select="@class" />
                            <xsl:if test="position() mod 2 = 0">
                                <xsl:text> alt</xsl:text>
                            </xsl:if>
                            </xsl:attribute>
						</xsl:if>
						<xsl:copy-of select="@*[name() != 'class']" />
						<xsl:copy-of select="*|text()|comment()" />
					</xsl:copy>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>


	<xsl:template match="xs:element[exists(xs:complexType) or exists(@type)]">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="minOccurs" />
		<xsl:param name="maxOccurs" />
		<xsl:param name="expanded-nodes" />
		<xsl:message>
			<xsl:text>Element: </xsl:text>
			<xsl:value-of select="@name" />
		</xsl:message>
		<xsl:message>
			<xsl:text>Visited list: </xsl:text>
			<xsl:copy-of select="$expanded-nodes" />
		</xsl:message>
		<tr>
			<xsl:variable name="cardinality"
				select="docorro:get-cardinality(.,$minOccurs,$maxOccurs)" />
			<td>
				<xsl:if test="not(starts-with($cardinality,'0'))">
					<xsl:attribute name="class">required</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$indent" />
				<xsl:value-of select="@name" />
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="exists(xs:complexType) and empty(xs:complexType/*)">
						<em>Empty</em>
					</xsl:when>
					<xsl:when test="exists(xs:complexType)">
						<xsl:text>xs:complexType</xsl:text>
					</xsl:when>
					<xsl:when
						test="exists(@type) and exists(docorro:get-simple-type(@type,.)/*)">
						<xsl:call-template name="output-simple-type">
							<xsl:with-param name="type">
								<xsl:copy-of select="docorro:get-simple-type(@type,.)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@type" />
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:value-of select="$cardinality" />
			</td>
			<td>
				<xsl:variable name="extra-doc">
					<xsl:if test="@name = $expanded-nodes/html:nodes/html:node">
						<xsl:text>*Note:* This is a nested repeating structure

</xsl:text>
					</xsl:if>
				</xsl:variable>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content"
						select="concat($extra-doc, xs:annotation/xs:documentation)" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
		<xsl:variable name="definition">
			<xsl:choose>
				<xsl:when test="exists(@type)">
					<xsl:value-of select="@type" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@name" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="not($definition = $expanded-nodes/html:nodes/html:node)">
			<xsl:message>
				<xsl:value-of select="@name" />
				<xsl:text> not in visited list</xsl:text>
			</xsl:message>
			<xsl:if test="exists(@type)">
				<xsl:apply-templates select="docorro:get-type(@type,.)">
					<xsl:with-param name="indent"
						select="concat($indent, '&#160;&#160;&#160;&#160;')" />
					<xsl:with-param name="section" select="$section" />
					<xsl:with-param name="minOccurs" select="@minOccurs" />
					<xsl:with-param name="maxOccurs" select="@maxOccurs" />
					<xsl:with-param name="expanded-nodes">
						<nodes>
							<xsl:copy-of select="$expanded-nodes/html:nodes/html:node" />
							<node>
								<xsl:value-of select="$definition" />
							</node>
						</nodes>
					</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:apply-templates
				select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'annotation')]">
				<xsl:with-param name="indent"
					select="concat($indent, '&#160;&#160;&#160;&#160;')" />
				<xsl:with-param name="section" select="$section" />
				<xsl:with-param name="expanded-nodes">
					<nodes>
						<xsl:copy-of select="$expanded-nodes/html:nodes/html:node" />
						<node>
							<xsl:value-of select="$definition" />
						</node>
					</nodes>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xs:element[exists(xs:simpleType)]">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="minOccurs" />
		<xsl:param name="maxOccurs" />
		<xsl:param name="expanded-nodes" />
		<xsl:message>
			<xsl:text>Element: </xsl:text>
			<xsl:value-of select="@name" />
		</xsl:message>
		<xsl:message>
			<xsl:text>Visited list: </xsl:text>
			<xsl:copy-of select="$expanded-nodes" />
		</xsl:message>
		<tr>
			<xsl:variable name="cardinality"
				select="docorro:get-cardinality(.,$minOccurs,$maxOccurs)" />
			<td>
				<xsl:if test="not(starts-with($cardinality,'0'))">
					<xsl:attribute name="class">required</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$indent" />
				<xsl:value-of select="@name" />
			</td>
			<td>
				<xsl:call-template name="output-simple-type">
					<xsl:with-param name="type">
						<xsl:copy-of select="xs:simpleType" />
					</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<xsl:value-of select="$cardinality" />
			</td>
			<td>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content"
						select="xs:annotation/xs:documentation/text()" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="output-simple-type">
		<xsl:param name="type" />
		<xsl:param name="depth" select="0" />
		<xsl:choose>
			<xsl:when test="$type/xs:simpleType/xs:restriction">
				<xsl:variable name="base"
					select="docorro:get-simple-type($type/xs:simpleType/xs:restriction/@base,.)" />
				<xsl:choose>
					<xsl:when test="exists($base/*)">
						<xsl:call-template name="output-simple-type">
							<xsl:with-param name="type">
								<xsl:copy-of select="$base" />
							</xsl:with-param>
							<xsl:with-param name="depth">
								<xsl:value-of select="$depth + 1" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$type/xs:simpleType/xs:restriction/@base" />
						<xsl:text> { </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="$type/xs:simpleType/xs:restriction" />
				<xsl:if test="$depth = 0">
					<xsl:text> }</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>xs:simpleType</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xs:restriction">
		<xsl:apply-templates
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'enumeration')]" />
		<xsl:if test="xs:enumeration">
			<xsl:text>enum: (</xsl:text>
			<xsl:for-each select="xs:enumeration">
				<xsl:if test="position() != 1">
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:text>'</xsl:text>
				<xsl:value-of select="@value" />
				<xsl:text>'</xsl:text>
			</xsl:for-each>
			<xsl:text>);</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xs:maxLength">
		<xsl:text>max-length:</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:totalDigits">
		<xsl:text>total-digits:</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:minInclusive">
		<xsl:text>min:</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:pattern">
		<xsl:text>pattern:'</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>'; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:maxInclusive">
		<xsl:text>max:</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:fractionDigits">
		<xsl:text>fraction-digits:</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:length">
		<xsl:text>length:</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="xs:element[exists(@ref)]">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="minOccurs" />
		<xsl:param name="maxOccurs" />
		<xsl:param name="expanded-nodes" />
		<xsl:apply-templates select="docorro:get-element(@ref,.)">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="minOccurs"
				select="if( exists(@minOccurs) ) then @minOccurs else $minOccurs" />
			<xsl:with-param name="maxOccurs"
				select="if( exists(@maxOccurs) ) then @maxOccurs else $maxOccurs" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:simpleType">
		<xsl:variable name="section" select="@name" />
		<h3 id="{docorro:convert-to-id($section)}">
			<xsl:value-of select="$section" />
		</h3>
		<xsl:call-template name="output-content">
			<xsl:with-param name="content" select="wsdl:documentation/(*|text())" />
			<xsl:with-param name="section" select="$section" />
		</xsl:call-template>
		<table>
			<thead>
				<tr>
					<th>Value</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select=".//xs:enumeration">
					<tr>
						<td>
							<xsl:value-of select="@value" />
						</td>
						<td>
							<xsl:value-of select="xs:annotation/xs:documentation" />
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="xs:complexType">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="expanded-nodes" />
		<xsl:message>
			<xsl:text>xs:complexType</xsl:text>
		</xsl:message>
		<xsl:apply-templates select="xs:attribute">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
		<xsl:for-each
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'attribute' and local-name() != 'annotation')]">
			<xsl:message>
				<xsl:text>    child: </xsl:text>
				<xsl:value-of select="name()" />
			</xsl:message>
		</xsl:for-each>
		<xsl:apply-templates
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'attribute' and local-name() != 'annotation')]">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:complexContent">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="expanded-nodes" />
		<xsl:apply-templates
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'annotation')]">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:sequence | xs:all">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="expanded-nodes" />
		<xsl:apply-templates
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'annotation')]">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:choice">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="expanded-nodes" />
		<tr>
			<xsl:variable name="cardinality" select="docorro:get-cardinality(.,'','')" />
			<td>
				<xsl:if test="not(starts-with($cardinality,'0'))">
					<xsl:attribute name="class">required</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$indent" />
				<xsl:for-each select="xs:element">
					<xsl:value-of select="@name | @ref" />
					<xsl:if test="position() != last()">
						<xsl:text> | </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
			<td>
				<xsl:text>xs:choice</xsl:text>
			</td>
			<td>
				<xsl:value-of select="$cardinality" />
			</td>
			<td>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content"
						select="xs:annotation/xs:documentation" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
		<xsl:apply-templates
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'annotation')]">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
			<xsl:with-param name="minOccurs" select="'0'" />
			<xsl:with-param name="maxOccurs" select="@maxOccurs" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:extension">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="expanded-nodes" />
		<xsl:apply-templates select="docorro:get-type(@base,.)">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
		<xsl:apply-templates select="xs:attribute">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="*[namespace-uri() != 'http://www.w3.org/2001/XMLSchema' or (local-name() != 'attribute' and local-name() != 'annotation')]">
			<xsl:with-param name="indent" select="$indent" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template
		match="xs:restriction[@base='SOAP-ENC:Array' and exists(xs:attribute/@wsdl:arrayType)]">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<xsl:param name="expanded-nodes" />
		<tr>
			<td>
				<xsl:value-of select="$indent" />
				<em>array</em>
			</td>
			<td>
				<xsl:value-of select="replace(xs:attribute/@wsdl:arrayType, '\[\]', '')" />
			</td>
			<td>0..*</td>
			<td>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content"
						select="xs:annotation/xs:documentation" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
		<xsl:apply-templates
			select="docorro:get-type(replace(xs:attribute/@wsdl:arrayType, '\[\]', ''),.)">
			<xsl:with-param name="indent"
				select="concat($indent, '&#160;&#160;&#160;&#160;')" />
			<xsl:with-param name="section" select="$section" />
			<xsl:with-param name="expanded-nodes" select="$expanded-nodes" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xs:any">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<tr>
			<xsl:variable name="cardinality" select="docorro:get-cardinality(.,'','')" />
			<td>
				<xsl:if test="not(starts-with($cardinality,'0'))">
					<xsl:attribute name="class">required</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$indent" />
				<xsl:text>*</xsl:text>
			</td>
			<td>
				<xsl:text>xs:any</xsl:text>
			</td>
			<td>
				<xsl:value-of select="$cardinality" />
			</td>
			<td>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content"
						select="xs:annotation/xs:documentation" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="*" priority="-1">
		<xsl:message terminate="yes">
			<xsl:text>Unknown element
</xsl:text>
			<xsl:copy-of select="." />
		</xsl:message>
	</xsl:template>


	<xsl:template match="xs:attribute">
		<xsl:param name="indent" />
		<xsl:param name="section" />
		<tr>
			<xsl:variable name="cardinality">
			</xsl:variable>
			<td>
				<xsl:if test="not(starts-with($cardinality,'0'))">
					<xsl:attribute name="class">required</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$indent" />
				<xsl:text>@</xsl:text>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<xsl:value-of select="@type" />
			</td>
			<td>
				<xsl:value-of select="$cardinality" />
			</td>
			<td>
				<xsl:call-template name="output-content">
					<xsl:with-param name="content"
						select="xs:annotation/xs:documentation" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="output-content">
		<xsl:param name="content" />
		<xsl:param name="section" />
		<xsl:variable name="blocks"
			select="tokenize($content, '[\n\\]\s*[\n\\]')" />
		<xsl:choose>
			<xsl:when test="count($blocks) > 1">
				<xsl:for-each select="$blocks">
					<xsl:message>
						<xsl:text>DOUBLE NEW LINE</xsl:text>
					</xsl:message>
					<xsl:call-template name="block">
						<xsl:with-param name="content" select="." />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="inline">
					<xsl:with-param name="content" select="$content" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="ul">
		<xsl:param name="content" />
		<xsl:param name="section" />
		<xsl:message>
			<xsl:text>UL CONTENT:
</xsl:text>
			<xsl:value-of select="$content" />
			<xsl:text>
UL CONTENT;</xsl:text>
		</xsl:message>
		<xsl:variable name="bullet-start"
			select="replace($content, '^(\s+?)\*\s.*', '$1', 's')" />
		<xsl:variable name="pattern" select="concat('^', $bullet-start,'\* ')" />
		<ul>
			<xsl:for-each
				select="tokenize($content, $pattern, 'm')[string-length(.) > 0]">
				<xsl:message>
					<xsl:text>LI CONTENT:
</xsl:text>
					<xsl:value-of select="." />
					<xsl:text>
LI CONTENT;</xsl:text>
				</xsl:message>
				<li>
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="." />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>


	<xsl:template name="ol">
		<xsl:param name="content" />
		<xsl:param name="section" />
		<xsl:message>
			<xsl:text>OL CONTENT:
</xsl:text>
			<xsl:value-of select="$content" />
			<xsl:text>
OL CONTENT;</xsl:text>
		</xsl:message>
		<xsl:variable name="num-start"
			select="replace($content, '^(\s+?)\d\.\s.*', '$1', 's')" />
		<xsl:variable name="pattern" select="concat('^', $num-start,'\d\. ')" />
		<ol>
			<xsl:for-each
				select="tokenize($content, $pattern, 'm')[string-length(.) > 0]">
				<xsl:message>
					<xsl:text>LI CONTENT:
</xsl:text>
					<xsl:value-of select="." />
					<xsl:text>
LI CONTENT;</xsl:text>
				</xsl:message>
				<li>
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="." />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>

	<xsl:template name="inline">
		<xsl:param name="content" />
		<xsl:param name="section" />
		<xsl:message>
			<xsl:text>INLINE CONTENT:
</xsl:text>
			<xsl:value-of select="$content" />
			<xsl:text>
INLINE CONTENT;</xsl:text>
		</xsl:message>
		<xsl:choose>
			<!-- bullet points -->
			<xsl:when test="matches($content, '^(.+?)^(\s+\*\s.*)', 'sm')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '^(.+?)^(\s+\*\s.*)', '$1', 'sm')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:call-template name="ul">
					<xsl:with-param name="content"
						select="replace($content, '^(.+?)^(\s+\*\s.*)', '$2', 'sm')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- code -->
			<xsl:when test="matches($content, '^(.+?)^(    .*)', 'sm')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '^(.+?)^(    .*)', '$1', 'sm')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:variable name="code"
					select="replace($content, '^(.+?)^(    .*)', '$2', 'sm')" />
				<xsl:if test="string-length(normalize-space($code)) > 0">
					<pre>
						<xsl:for-each
							select="tokenize($code, '^(    )', 'm')[string-length(.) > 0]">
							<xsl:value-of select="." disable-output-escaping="no" />
						</xsl:for-each>
					</pre>
				</xsl:if>
			</xsl:when>
			<!-- links -->
			<xsl:when
				test="matches($content, '(.*)(http(s?)://[^\s]*[^\s\)\.,:])(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)(http(s?)://[^\s]*[^\s\)\.,:])(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:variable name="url"
					select="replace($content, '(.*)(http(s?)://[^\s]*[^\s\)\.,:])(.*)', '$2', 's')" />
				<xsl:message>
					<xsl:text>A CONTENT:
</xsl:text>
					<xsl:value-of select="$url" />
					<xsl:text>
A CONTENT;</xsl:text>
				</xsl:message>
				<a href="{$url}">
					<xsl:value-of select="$url" />
				</a>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)(http(s?)://[^\s]*[^\s\)\.,:])(.*)', '$4', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- `content` -->
			<xsl:when test="matches($content, '(.*)`(.*?)`(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)`(.*?)`(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<code>
					<xsl:call-template name="inline">
						<xsl:with-param name="content"
							select="replace($content, '(.*)`(.*?)`(.*)', '$2', 's')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</code>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)`(.*?)`(.*)', '$3', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- *content* -->
			<xsl:when test="matches($content, '(.*)\*(.+?)\*(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\*(.+?)\*(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<strong>
					<xsl:call-template name="inline">
						<xsl:with-param name="content"
							select="replace($content, '(.*)\*(.+?)\*(.*)', '$2', 's')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</strong>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\*(.+?)\*(.*)', '$3', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- _content_ -->
			<xsl:when test="matches($content, '^_(.+?)_$', 's')">
				<em>
					<xsl:call-template name="inline">
						<xsl:with-param name="content"
							select="replace($content, '^_(.+?)_$', '$1', 's')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</em>
			</xsl:when>
			<!-- _content_ content -->
			<xsl:when test="matches($content, '^_(.+?)_([\s,\.]+.*)$', 's')">
				<em>
					<xsl:call-template name="inline">
						<xsl:with-param name="content"
							select="replace($content, '^_(.+?)_([\s,\.]+.*)$', '$1', 's')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</em>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '^_(.+?)_([\s,\.]+.*)$', '$2', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- content _content_ -->
			<xsl:when test="matches($content, '^(.*\s+)_(.+?)_$', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '^(.*\s+)_(.+?)_$', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<em>
					<xsl:call-template name="inline">
						<xsl:with-param name="content"
							select="replace($content, '^(.*\s+)_(.+?)_$', '$2', 's')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</em>
			</xsl:when>
			<!-- content _content_ content -->
			<xsl:when test="matches($content, '^(.*\s+)_(.+?)_([\s,\.]+.*)$', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '^(.*\s+)_(.+?)_([\s,\.]+.*)$', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<em>
					<xsl:call-template name="inline">
						<xsl:with-param name="content"
							select="replace($content, '^(.*\s+)_(.+?)_([\s,\.]+.*)$', '$2', 's')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</em>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '^(.*\s+)_(.+?)_([\s,\.]+.*)$', '$3', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- (c) -->
			<xsl:when test="matches($content, '(.*)\(c\)(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\(c\)(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:text>©</xsl:text>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\(c\)(.*)', '$2', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- (r) -->
			<xsl:when test="matches($content, '(.*)\(r\)(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\(r\)(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:text>®</xsl:text>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\(r\)(.*)', '$2', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- (tm) -->
			<!-- macro attribute -->
			<xsl:when test="matches($content, '(.*)@\{(.+?)\}(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)@\{(.+?)\}(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:variable name="attribute"
					select="replace($content, '(.*)@\{(.+?)\}(.*)', '$2', 's')" />
				<a
					href="{docorro:convert-to-id(concat('#', $section, '_',
                    $attribute))}">
					<xsl:text>@{</xsl:text>
					<xsl:value-of select="$attribute" />
					<xsl:text>}</xsl:text>
				</a>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)(@\{.+?\})(.*)', '$3', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="matches($content, '(.*)\(tm\)(.*)', 's')">
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\(tm\)(.*)', '$1', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:text>™</xsl:text>
				<xsl:call-template name="inline">
					<xsl:with-param name="content"
						select="replace($content, '(.*)\(tm\)(.*)', '$2', 's')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- macro name keeping this around because we will want to do similar 
				stuff with type names -->
			<!-- xsl:when test="exists($macros[@name=$content])"> <a href="{docorro:convert-to-id(concat('#', 
				$content))}"> <xsl:value-of select="$content" /> </a> </xsl:when -->
			<xsl:otherwise>
				<xsl:copy-of select="$content" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="block">
		<xsl:param name="content" />
		<xsl:param name="section" />
		<xsl:message>
			<xsl:text>BLOCK CONTENT:
</xsl:text>
			<xsl:value-of select="$content" />
			<xsl:text>
BLOCK CONTENT;</xsl:text>
		</xsl:message>
		<xsl:choose>
			<!-- table -->
			<xsl:when test="matches($content, '^\[.*\]')">
				<xsl:message>
					<xsl:text>TABLE</xsl:text>
				</xsl:message>
				<xsl:call-template name="table">
					<xsl:with-param name="content" select="$content" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- img -->
			<xsl:when test="matches($content, 'img:(.*?):(.*)')">
				<xsl:message>
					<xsl:text>IMG</xsl:text>
				</xsl:message>
				<div class="img">
					<xsl:variable name="caption"
						select="replace($content, 'img:(.*?):(.*)', '$1')" />
					<img alt="{$caption}">
						<xsl:attribute name="src">
                              <xsl:text>data:image/png;base64,</xsl:text>
                              <xsl:value-of
							select="replace($content, 'img:(.*?):(.*)', '$2')" />
                          </xsl:attribute>
					</img>
					<div class="caption">
						<xsl:value-of select="$caption" />
					</div>
				</div>
			</xsl:when>
			<!-- h2 -->
			<xsl:when test="matches($content, '^== .* ==$')">
				<xsl:message>
					<xsl:text>H2</xsl:text>
				</xsl:message>
				<xsl:variable name="heading"
					select="replace($content, '^== (.*) ==$', '$1')" />
				<h2 id="{docorro:convert-to-id($heading)}">
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="$heading" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</h2>
			</xsl:when>
			<!-- h3 -->
			<xsl:when test="matches($content, '^=== .* ===$')">
				<xsl:message>
					<xsl:text>H3</xsl:text>
				</xsl:message>
				<xsl:variable name="heading"
					select="replace($content, '^=== (.*) ===$', '$1')" />
				<h3 id="{docorro:convert-to-id($heading)}">
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="$heading" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</h3>
			</xsl:when>
			<!-- h4 -->
			<xsl:when test="matches($content, '^==== .* ====$')">
				<xsl:message>
					<xsl:text>H4</xsl:text>
				</xsl:message>
				<xsl:variable name="heading"
					select="replace($content, '^==== (.*) ====$', '$1')" />
				<h4>
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="$heading" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</h4>
			</xsl:when>
			<!-- h5 -->
			<xsl:when test="matches($content, '^===== .* =====$')">
				<xsl:message>
					<xsl:text>H5</xsl:text>
				</xsl:message>
				<xsl:variable name="heading"
					select="replace($content, '^===== (.*) =====$', '$1')" />
				<h5>
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="$heading" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</h5>
			</xsl:when>
			<!-- h6 -->
			<xsl:when test="matches($content, '^====== .* ======$')">
				<xsl:message>
					<xsl:text>H6</xsl:text>
				</xsl:message>
				<xsl:variable name="heading"
					select="replace($content, '^====== (.*) ======$', '$1')" />
				<h6>
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="$heading" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</h6>
			</xsl:when>
			<!-- numbered points -->
			<xsl:when test="matches($content, '^(\s+?)\d\.\s.*')">
				<xsl:message>
					<xsl:text>OL</xsl:text>
				</xsl:message>
				<xsl:call-template name="ol">
					<xsl:with-param name="content" select="." />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- content then bullet points -->
			<xsl:when test="matches($content, '^(.+?)^(\s+\*\s.*)', 'sm')">
				<xsl:message>
					<xsl:text>P,UL</xsl:text>
				</xsl:message>
				<xsl:call-template name="block">
					<xsl:with-param name="content"
						select="replace($content, '^(.+?)^(\s+\*\s.*)', '$1', 'sm')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:call-template name="ul">
					<xsl:with-param name="content"
						select="replace($content, '^(.+?)^(\s+\*\s.*)', '$2', 'sm')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- bullet points -->
			<xsl:when test="matches($content, '^(\s+?)\*\s.*')">
				<xsl:message>
					<xsl:text>UL</xsl:text>
				</xsl:message>
				<xsl:call-template name="ul">
					<xsl:with-param name="content" select="$content" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
			</xsl:when>
			<!-- code -->
			<xsl:when test="matches($content, '^(    ).*')">
				<xsl:message>
					<xsl:text>CODE</xsl:text>
				</xsl:message>
				<xsl:if test="string-length(normalize-space($content)) > 0">
					<pre>
						<xsl:for-each select="tokenize($content, '^(    )', 'm')">
							<xsl:value-of select="." disable-output-escaping="no" />
						</xsl:for-each>
					</pre>
				</xsl:if>
			</xsl:when>
			<!-- content then code -->
			<xsl:when test="matches($content, '(.*?)^(    .*)', 'sm')">
				<xsl:message>
					<xsl:text>P,CODE</xsl:text>
				</xsl:message>
				<xsl:call-template name="block">
					<xsl:with-param name="content"
						select="replace($content, '^(.*?)^(    .*)', '$1', 'sm')" />
					<xsl:with-param name="section" select="$section" />
				</xsl:call-template>
				<xsl:variable name="code"
					select="replace($content, '^(.*?)^(    .*)', '$2', 'sm')" />
				<xsl:if test="string-length(normalize-space($code)) > 0">
					<pre>
						<xsl:for-each select="tokenize($code, '^(    )', 'm')">
							<xsl:value-of select="." disable-output-escaping="no" />
						</xsl:for-each>
					</pre>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>
					<xsl:text>P</xsl:text>
				</xsl:message>
				<p>
					<xsl:call-template name="inline">
						<xsl:with-param name="content" select="$content" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="thead">
		<xsl:param name="head" />
		<xsl:param name="section" />
		<thead>
			<xsl:for-each
				select="tokenize($head, '(^\[\[)|(\]\].+?\[\[)|(\]\]$)', 's')[string-length(.)>0]">
				<tr>
					<xsl:for-each select="tokenize(., '\|')">
						<th>
							<xsl:call-template name="inline">
								<xsl:with-param name="content" select="." />
								<xsl:with-param name="section" select="$section" />
							</xsl:call-template>
						</th>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</thead>
	</xsl:template>

	<xsl:template name="tbody">
		<xsl:param name="body" />
		<xsl:param name="section" />
		<tbody>
			<xsl:for-each
				select="tokenize($body, '(^\[)|(\s\].+?\[\s)|(\]$)','s')[string-length(.)>0]">
				<tr>
					<xsl:if test="position() mod 2 = 0">
						<xsl:attribute name="class">alt</xsl:attribute>
					</xsl:if>
					<xsl:for-each select="tokenize(., '\s\|\s')">
						<xsl:choose>
							<xsl:when test="matches(., '^\[\s')">
								<th>
									<xsl:call-template name="inline">
										<xsl:with-param name="content" select="replace(., '^\[\s', '')" />
										<xsl:with-param name="section" select="$section" />
									</xsl:call-template>
								</th>
							</xsl:when>
							<xsl:otherwise>
								<td>
									<xsl:call-template name="inline">
										<xsl:with-param name="content" select="." />
										<xsl:with-param name="section" select="$section" />
									</xsl:call-template>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</tbody>
	</xsl:template>

	<xsl:template name="table">
		<xsl:param name="content" />
		<xsl:param name="section" />
		<table>
			<xsl:choose>
				<xsl:when test="matches($content, '\[\[.*?\]\]', 'sm')">
					<xsl:call-template name="thead">
						<xsl:with-param name="head"
							select="replace($content, '(\[\[.*?\]\])[\n\\](.*)', '$1', 'sm')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
					<xsl:call-template name="tbody">
						<xsl:with-param name="body"
							select="replace($content, '(\[\[.*?\]\])[\n\\](.*)', '$2', 'sm')" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="tbody">
						<xsl:with-param name="body" select="$content" />
						<xsl:with-param name="section" select="$section" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</table>
	</xsl:template>

	<xsl:function name="docorro:convert-to-id">
		<xsl:param name="id" />
		<xsl:value-of select="replace(replace($id, ' ', '_'), '^-', 'a-')" />
	</xsl:function>

	<xsl:function name="docorro:doc-name">
		<xsl:text>Interface Specification</xsl:text>
	</xsl:function>


	<xsl:function name="docorro:namespace">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:variable name="prefix" select="replace($type, ':.*', '')" />
		<xsl:variable name="namespace" select="$doc/namespace::*[name()=$prefix]" />
		<!-- xsl:message> <xsl:text>namespace for </xsl:text> <xsl:value-of select="$prefix" 
			/> <xsl:text> is </xsl:text> <xsl:value-of select="$doc/namespace::*[name()=$prefix]" 
			/> </xsl:message -->
		<xsl:value-of select="$doc/namespace::*[name()=$prefix]" />
	</xsl:function>

	<xsl:function name="docorro:get-type">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:message>
			<xsl:text>Getting type </xsl:text>
			<xsl:value-of select="$type" />
		</xsl:message>
		<xsl:variable name="namespace" select="docorro:namespace($type,$doc)" />
		<xsl:message>
			<xsl:text>    </xsl:text>
			<xsl:value-of select="$type" />
			<xsl:text> has a ns of '</xsl:text>
			<xsl:value-of select="$namespace" />
			<xsl:text>'</xsl:text>
		</xsl:message>
		<xsl:choose>
			<xsl:when test="$namespace != ''">
				<xsl:message>
					<xsl:copy-of
						select="$type-catalogue/xs:schema[@targetNamespace=$namespace]/xs:complexType[@name=replace($type,'.*:','')]" />
				</xsl:message>
				<xsl:copy-of
					select="$type-catalogue/xs:schema[@targetNamespace=$namespace]/xs:complexType[@name=replace($type,'.*:','')]" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>
					<xsl:copy-of
						select="$type-catalogue/xs:schema[empty(@targetNamespace)]/xs:complexType[@name=$type]" />
				</xsl:message>
				<xsl:copy-of
					select="$type-catalogue/xs:schema[empty(@targetNamespace)]/xs:complexType[@name=$type]" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="docorro:get-simple-type">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:message>
			<xsl:text>Getting simple type </xsl:text>
			<xsl:value-of select="$type" />
		</xsl:message>
		<xsl:variable name="namespace" select="docorro:namespace($type,$doc)" />
		<xsl:message>
			<xsl:text>    </xsl:text>
			<xsl:value-of select="$type" />
			<xsl:text> has a ns of '</xsl:text>
			<xsl:value-of select="$namespace" />
			<xsl:text>'</xsl:text>
		</xsl:message>
		<xsl:choose>
			<xsl:when test="$namespace != ''">
				<xsl:message>
					<xsl:copy-of
						select="$type-catalogue/xs:schema[@targetNamespace=$namespace]/xs:simpleType[@name=replace($type,'.*:','')]" />
				</xsl:message>
				<xsl:copy-of
					select="$type-catalogue/xs:schema[@targetNamespace=$namespace]/xs:simpleType[@name=replace($type,'.*:','')]" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>
					<xsl:copy-of
						select="$type-catalogue/xs:schema[empty(@targetNamespace)]/xs:simpleType[@name=$type]" />
				</xsl:message>
				<xsl:copy-of
					select="$type-catalogue/xs:schema[empty(@targetNamespace)]/xs:simpleType[@name=$type]" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="docorro:get-element">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:variable name="namespace" select="docorro:namespace($type,$doc)" />
		<xsl:message>
			<xsl:text>Getting element </xsl:text>
			<xsl:value-of select="$type" />
		</xsl:message>
		<xsl:variable name="namespace" select="docorro:namespace($type,$doc)" />
		<xsl:message>
			<xsl:text>    </xsl:text>
			<xsl:value-of select="$type" />
			<xsl:text> has a ns of </xsl:text>
			<xsl:value-of select="$namespace" />
		</xsl:message>
		<xsl:message>
			<xsl:copy-of
				select="$type-catalogue/xs:schema[@targetNamespace=$namespace]/xs:element[@name=replace($type,'.*:','')]" />
		</xsl:message>
		<xsl:copy-of
			select="$type-catalogue/xs:schema[@targetNamespace=$namespace]/xs:element[@name=replace($type,'.*:','')]" />
	</xsl:function>

	<xsl:function name="docorro:get-cardinality">
		<xsl:param name="element" />
		<xsl:param name="minOccurs" />
		<xsl:param name="maxOccurs" />
		<xsl:message>
			<xsl:text>passed in cardinality: '</xsl:text>
			<xsl:value-of select="$minOccurs" />
			<xsl:text>,</xsl:text>
			<xsl:value-of select="$maxOccurs" />
			<xsl:text>'</xsl:text>
		</xsl:message>
		<xsl:variable name="cardinality">
			<xsl:choose>
				<xsl:when test="$minOccurs != ''">
					<xsl:value-of select="$minOccurs" />
				</xsl:when>
				<xsl:when test="exists($element/@minOccurs)">
					<xsl:value-of select="$element/@minOccurs" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>1</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>..</xsl:text>
			<xsl:choose>
				<xsl:when test="$maxOccurs = 'unbounded'">
					<xsl:text>*</xsl:text>
				</xsl:when>
				<xsl:when test="$maxOccurs != ''">
					<xsl:value-of select="$maxOccurs" />
				</xsl:when>
				<xsl:when test="$element/@maxOccurs = 'unbounded'">
					<xsl:text>*</xsl:text>
				</xsl:when>
				<xsl:when test="exists($element/@maxOccurs)">
					<xsl:value-of select="$element/@maxOccurs" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>1</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$cardinality" />
		<xsl:message>
			<xsl:text>calculated cardinality: </xsl:text>
			<xsl:value-of select="$cardinality" />
		</xsl:message>
	</xsl:function>

</xsl:stylesheet>
