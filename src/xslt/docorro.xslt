<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xsl xs tibant html wsdl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:tibant="http://windyroad.org/tibant/functions" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	version="2.0">
	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />

	<xsl:variable name="macros" select="/wsdl:definitions/macrodef" />
	<xsl:variable name="operations"
		select="/wsdl:definitions/wsdl:portType/wsdl:operation" />

	<xsl:variable name="imports" select="/wsdl:definitions/wsdl:import" />

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="wsdl:definitions/@name" />
					<xsl:text> - WSDL Interface Specification</xsl:text>
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
	border-top: 4px solid #000;
}

h3 {
	margin: 30px 0 6px;
	padding-top: 6px;
	font-weight: bold;
	font-size: 1.1em;
	border-top: 2px solid #000;
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
    border-top: 1px solid #AAA;
}

h5 {
	margin: 10px 0 5px;
	padding-top: 5px;
	font-weight: bold;
	font-size: 0.8em;
    border-top: 1px solid #DDD;
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
				<!--
					script type="text/javascript"> var _gaq = _gaq || [];
					_gaq.push(['_setAccount', 'UA-808591-8']);
					_gaq.push(['_setDomainName', 'windyroad.org']);
					_gaq.push(['_setAllowLinker', true]);
					_gaq.push(['_trackPageview']); (function() { var ga =
					document.createElement('script'); ga.type = 'text/javascript';
					ga.async = true; ga.src = ('https:' == document.location.protocol ?
					'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var
					s = document.getElementsByTagName('script')[0];
					s.parentNode.insertBefore(ga, s); })(); </script
				-->
			</head>
			<body
				style="background-image: url('data:image/png;base64,
iVBORw0KGgoAAAANSUhEUgAABLEAAAJYBAMAAABvCmkXAAAAA3NCSVQICAjb4U/gAAAAKlBMVEX/
///+/v79/f38/Pz7+/v6+vr5+fn4+Pj39/f29vb19fX09PTz8/Py8vKhYjBHAAAACXBIWXMAAAsS
AAALEgHS3X78AAAAHHRFWHRTb2Z0d2FyZQBBZG9iZSBGaXJld29ya3MgQ1M0BrLToAAAIABJREFU
eJztnduPXMW1xmfvHptcpSOBHRKItCVfBURKMjAHJYzUOUh2wkU6gEQCZKQOxo09+EghITyYM9KE
EB6AI0ES+4GkpQkkY9PhSAGCbSxtyeFibEtHyoVgT3fv/+V0z3ju3T21VlXtry7r9zZvX635umrt
VauqRkZwjPWoL7HwF1CN4Ds7umZ6ofmnYhBnmye7Nvs6WqbgD+nYg4ea+UBHraPTfPpOtGLBedJb
668qe2qVu07cj1YuuMu141Nv0k21xEXxltCHdHyKMVWt5Y/oQQiusePxwWk6hXfRAxFc4jb9yWqZ
19CDEVzhtqP/Z8xWXToZekCCC+w8nJu0VY+30GMS4KTf/1/TturyKXpYAphdRy3YqksHPTABSbrf
xnS1iOz1xEvlsNGkfR019PAEENdZWgbFWXGz60W7vhJnxYl9XxVFFT1IoXSuK8FXRQs9SqFsKs+U
4CuplEZHergUXxWX/w09UqFU9uflGOtChh6pUCa7GuX4qnNMZqyYSJ8ox1ft4xl6qEKZ7MlLsdXc
AZmvomK0hC/Cs3OPfRM9TqFkbre5Q1i0m3P1B8RUEZJambBazebx3jHpDD08AYXhDOvsGz0/oQcl
wEnMfRKePSFH7IUlRhtGTNXumgo9FMEl9hhI3VtzB2SmEtaQPKxtq5OPfQM9CsE50pf0XNWee0DK
nsJGtmgdn+jaCj0AwU225xq+OiObNMIA9vJt1fpZhlYvOMtd/OnqUbR2wWEeYdqqMyefgsJgkiNM
X0lrlTAMprHEV8JweMYSXwmbwDPWKdnAEYbDMtaF+9CyBdfhGKv9U7RqwX1+SDfWqQwtWnCfu+kT
lhRGhc25SSYswQbXy4Ql2GArtYH04wwtWfCBSk401m/QigUvSKZpvpKVUFDjHpqx5qtowYIffJlm
rPMZWrDgB6O07F2eiRPUSBokY72O1iv4wh0kYz2Lliv4wjViLMEGaS7GEmxAKjiIsQRVSGuhGEtQ
JaGcspenwwVlbiYY6x20WMEfKDXSj9BiBY+YVDeWvIYjqENI31sZWqzgEf+jbKxODa1V8IjPqE9Z
r6C1Cj6hPmV9iJYq+IT6lDUv2btAQHnKkiRLoKA+Zb2Nlip4xX+pGuuKrIUCgS3KU9Z/oqUKXvE1
VWO9j1YqeEWqumPYlrVQoHCD6pQ1g1Yq+IVqyeEyWqjgF8r5u6TvAolbFI31L7RQwTNymbIEG6g2
ZsmUJdCYkClLsEGiuBjKlCXQUF0MZcoSaCju7FxB6xR8Q/H46stonYJnKJZJZcdQIHKjmrOkyUEg
otjzV0XrFDxDsYFG9qIFIooN8G+hdQq+oVhzyNA6Bd9Qa836FC1T8I1UFkPBClvVnFVF6xR8Q62a
1ULLFLxjUslZ/0TLFLwjV3LWDFqm4BuKCXyG1in4hlqdVNIsgcoXlJwlaZZA5V4lZ/0ZLVPwDrUK
fA0tU/AOtUaHDC1T8A21T8N5tEzBO9T2dmQ7WqDyOSVn/QMtU/AOtaKDfBoKVNTa/mbQMgXvUCtn
yeFogYrauZ0MLVPwjoaSs9AqBf9QOnjfRqsU/CNXcZZ0OghklBZDKZQKZMRZgh3EWYIdlJz1CVql
4B9KznKjozQdG6+v5s6xsbFvoEUJg/DFWdceHlgfudRszvV89nW0RmE1fjgreURJZ7t5sn5QHOYG
SpVSeAZ/RMlYy5x9o37gm2jNseOFs26mGesql07W78zAyiPGB2dtUX3Vsw/tptgLg1KvA7gNfpJv
rEVaJw7K4lg2Ss7C7hsq3g+wCZ036uKuMplQ+rdAJX7eiLPEXSWj1q2cISVOGHNWj/aJA9DRRIPa
CYsqUqLidfUEzj4tU5d11E6F1ZASFV8FotGee0Aee7GK2knWWaREK87q0jlxQMxlj1Glf8LfkBKn
LTmrZ66TYi5bJEr/AWgbjdrBNba5ThxADi5gcpXwQ9/cMVd1GEB77j+Q4wuVaaXYIxUqPr+oRetp
6ZAwzYRS5DOkxIZVUy1xRlIus6gVtGaQEm+w7Kkl2selRdUgancrn0NKTHK7jlrFe5LOG0Ot7PAv
qMavWPbTatrPS8ZlCKXmJ/D5e/MbPMM4IZ+KRlC7XBn7Q67kdr20nouyKBpArdvhZazIrRptpSza
T2XYEQeAWiESfVPp9rKt1U24MvCYfUetEHkFLXN7btdIfegcl2Reh0RtNoAHOZ2ybKR+zMGH7TPT
SjGeRcvs5vGHc6s26sucVE/ZqKXwbtwasvPQnyw7aSOnZN5iolaFd+ZGyWSsPtW0bKZ1yJrIQ/HU
VQ2tcw29i2mmmrbaTTcwl6EH7CVqtVJ03aE/6dhYvX60mds1Vvc78ViGHqqHqCVajl+De+3Yg/Wm
zSSs/Zx02VC5Ri20NbROFXbcWj9qy1+tR9Gj8w3Fitb7aJ3q7Bh/vGmjaH/hPvTIPEOtlcCZr0NF
rh23UKI4laGH5RWKZxh+jNbJYKz+Qm7UWp1fSrqlTkUtqG4US+ns2HfUpLvakm6p01AKaSdD6+Sz
48FXzSVep6vo4XjDLWoRfQutU49bD71pyFqdY7IkqqF2uwP67j8DVPa9YMZbUoFQRHGbxMccfj3J
+FRuwlunM/RIvEBxOcQe4THHbSbM1f4Jehg+oHrCvYoWagwT5rpQRY/CAxpqsfSoDr8pybh2ztV5
Dj0I91E84e5z4aEP6T7dr0WZtjZDsVga1KS1wA7NFmiZtjZD8RhyYJNWj2T8t1rekmlrOJ9VjOPb
aKE22DmlU6DvPIvW7zSqF74EOGn1SL+vOP6+SG1rGIolrfAyrSXGf8e3luxSD0HtuqNgJ60eu17k
e+uU7CQORPUqoWAnrS7XPcO21vx/osU7i9q5w+6kVUUrtQnfW51foLU7i+rpvVB2DwfA95a0Mg9A
+abZEFoehnEdN99qyQmMvijfNHsl+Gx110s8a8mK2B/VwoPvzaUq7Gae7JcVsR+paiU64MrDCvtz
lrXmq2jhLqI8aX2EVloG6WGWtTrSEbgR5Ukr+CR+kVHeZ+If0bodZFI1eK3gk/hFeOnWxxlat3Oo
v8v1AVpqSSQ/4LRBtKQgv54fKgevhpZaFhXOktiRLep1qGdasayHXXbnDG/9Bq3aNZQ/D4sP0VLL
g3VjuHQ/rEV90iqeRGstkW0NurWuZGjVbqE+abUztNYSSR6iW0vy+DUQ3qn8FK21VBjTVvtHaNFO
QXhcN8jjFgPhTFty+GIVidot3gvU0GLLZVtOttYf0JpdQrW5tIgs1eqSPkG21rvyibjCpHrcLscW
tz051VrnM7Rmd6gQNjTeQYstmwq5KVCqDyvcTIjbr9BiS4ecyLfkRaglEsIOf6eGVls65Pdh21LY
WkLxwZTFsMX3i0ypK6JYaxn1noeimM/QasvnYaK1OlIzvUqaE8J2PrYPxBF6/4NYa4kvU8L2Llot
gNEG0VrSHn8V1WseFngdrRYAuWoqOz2LkNbDCGsPXe4Sa7EgrYdxRm0PsUc+yiD1gbQexpmhbsnF
Wgxo62Gc1qoQGkPEWst8iRS0CIvxXdIjtCBF+fvbyD2kqEVaaH5ErEUnaYi1NudbNGvV0HqdYJT2
8ROptfZKkOjcRAparEcKtpN+gBFu4feDlqDGmkbQ+mqkX6tH2iBaK84LDWiFLeky7UFMtWIt2YyS
rkP6NMLukI1cT3RW8Wu0YggVkrWiuDRxU75NtVacd97RrBXdyZS+kDYQe8R5DQvNWlF2h6wnJV+p
GOd1ijRrxfkVvQ5yFl/MR/lhTbJWRyqmI9S96R5x1kxJ1mplaLkuQKzFF7G+gUuyVnRXF/TlbrK1
4vxErOSECEntoQdxm6dHlHk8qRr/GlqtC1Cu1VoiylfZtlI+d6LMRtdDrz1EmmxROh+k76EHKYVY
IsaiKaVfaz7C+GyEelJlMXRVtOzyoXxJSxbfg9bhdpUYj51TvqQli+/BslaM75QSvqSlMX4BWsv3
EvF9I1K+pGO7RngAPGsVx2JLVClf0nG92DAQprUuVNHCS2YLIXGI68WGgTCt1XkOLbxkKLv4NbRY
N2BaK7ppi3BDtaRai3Ct1fllXNkW4QPxPFqrI3CtVcxH9ZFIOVEnVa1F2NYq5jK09hIZzZXjIh2m
V9nNKpn2aMdUkidk8bKBeBVeNX6BC99Biy8Pwok6OSd2Fdb29FXiWRKTafWo1NBiXYF23nwt7adi
mfsJrUdSeliCekfnGlqx3CxCSLU+RGt1hvS/NaxVXLgfrb8cCKnWz9FanSGhP367mtNRpPKEtgdZ
D1egPuMQo7cIJ8ylwXSFvfzqQzTeIjQvy3q4wrZcz1oxeEv9Mh9ZD1eh9Ym4wJnQc3nCayDyfbgK
8nNsG7l4AD0IuxBex/oxWqtTfE/bWkX7Zxl6FDZRXw9bsdSQ1aC+fduPzlzACRdhPZTW5TWMaidb
Pd47EOwPVn09lH6atWgWTZdoH/8GeiSWUF8PL6OluoZuZWuJ9x7L0EOxAaFe+nu0VtfY0jBjrW7G
FWIZQv3AhRS11mOg/LAc3Oe/iR6NaQhP+n2A1uoee3Jj3ipaTweWcm1VH7sk8RsYfcmctYriUlgz
16TywCWJ30jykElrdZfFuQeCqUSk6km87Ez3QXuLegNv1AOZughJfDA/J5MYTORXIn3yYADuSnLl
AUslvi8mNns20mnW78zQQ9PjM+qDzdBa3SR9xoa1erRO1scy9PD4qG+CSTvNAEzWHzbQbj792JiX
mYhUHvSxN20t0W7O1R8YQ4+TyKTy8P6FluouVqetFTrNN+r1MV+msC3qA5tBa3UX+9PWGs5257CD
Y64X7u9RHs8VtFSXsfORuAmt5vMH3c3yCeXSGbRWl0mnLFpoKO036m7mYLcoD0EmraFsa9hzz6Y0
D7q3OMqkZYzvGmoJ5HHJuUZC9UlL9ng2oeRMfj2d4xk6AmsgTFpvobU6z26Nu7YM0HnOqR//hLJw
mbQ2JcEuicWVKjoCqyDUtF5Ga/UAGx0QBNouvas7qSxbPg9V2Ga035RKxyFrSSHeNNB0y6UTouot
DzJpqZHsz+1ZZzNaGXr4y6j3acmkpUr6g9yadTbDoZYn9SDI44fKAL1VQ499mRvURTu0iDtPiloT
3UlaCNVS6dMiMf5biwYazAx63MtMKGuWjngilQfftOegQbgzaRHalt9Ha/WPXS/a89AAaugxL0O4
JV62eOjw30lk8gl6xMsQcvhZtFYPIbx3ZAZ3khZCDu/OGu4N23N7HhqAO1u8k+qipfBA5HZr/hnM
P9GDXoZQh/8HWqtfYJof3FlZCJc8dCSHJ2D+yhq1fxJ63Ct8TV31n9FaPcLA4wQ83Pn5E0paclOb
KmavBiSRoce+Qq6uuorW6gl7gK3L6LGvgrAcSh1eBehRnnn06FdBWA7baK0+UNJFIgNwp+owQloO
a2itzgM+e+jWf2hCXbeUtDYBcoXIKtzq0CQUS2VbeijJw/Y8o/b/qaJDsIaE8CUjL2oOwcxTdRq4
dDJsAfUHxGQ5HAI2dS8cO826wOcJ4tFanSV5xJ5l1DjzdXQMNjBKkF9Di3WUFHpAukvrUXQI+kE4
2ivF0r6A9p+Xee8AOgL9mVAfgks1XndAbucUxSV337P7HGEY7i3meO6yZppNuTR3wOX/SIUwlFm0
WOcw9Hg5meacBw+pEBItOdK6jrJz92bzZL1+py8vD9yrPjCpO6yl0rDmobVxbx6vHxhzeeXrC6Gi
JQct1rAlt2WlZdrNrqXQ4+RCuKRNepZXY7na0HtOIEOPUQvK1qEkWitst1htaM0dcLaYQICwlyqJ
1jLWjNU+4XQtgQKhZVkqWkvstWOsS08H8KT0MpQUfhYt1hGsXAdy9mBgP1xCM7x00ixiwViXQrNV
l5QwfncOeCO53rSt2s+HkLBvJCfEwJPyr1VMJ+9nHG1W0IfQVyo9WqaN1X4+vFVwGcrH4Tm0WDhb
TBqr9VjQiwDl4zD6WqnJLZ33nOwFNQjhaFjRQosFUzH3vM6Z+9GDsQ6lF96l+04ApA3xFQFK2cGh
C+0BJJSPnWFcjMFXI7Syw1/RYpH80Iyv3DxrY4MGISoxp/DfNuKrtlsvP1uFMsdHnMKbKb2fytDj
KJEJSmQytFoUW00UsubvQw+jVL5KiU0NrRZEmuv7qvMcehQl80VKdCLtWE6m9Y11oYoeRdlQTrPG
2khzt7avopuwRojOivP+7i9rGyu+CWuE1vsXZy+8fvZ+LJ5SwypIzorx4zDV3S107+K0cqA5q4aW
Wz5HNI31cYYeAQjKrSExfhzepGmsP6IHAIPmrL+j5ZbNqF6S1fkJegA4aM6KbecwaWgZqxXzZRg0
Z8V2fkdvH/pChtaPhOasyMoOtM+b9ZyKstiwDM1ZcZUd9LYL483dFyE6q4rWWyb36Bjr12j1aEiN
8HE9k3KNjrGeRauHQ0wlZtF6y0NnLeyIsajOOofWWx53aBgr0g2dNVAOHBYx9dFofBeKsXqQumgc
e1XWJgn/aTkx1gKU4/eFa49/WuRmtrEkeV+E1K0cj7NS/n6hGGuRCVrYYjkYNsk21uto6a5ADGEk
zuKn739BS3eGaVrgOmi95cBO38+jlbtDTgwdWm8pfIVrrCtxb0KvJqHGDi24DJKcaaxWhpbuDsRt
wzicxa04dGpo5Q5B3nVFCy4BdsXhFbRylyAWSqNo0LqFaax30MKdgnK38gIB3zN9Fe6UdVmy99WQ
r0jM0Iqtw5yy2uH/5kjk1ACiBVuHO2U9iRbuFqQLcONwFnPK+gCt2zGI3VkROIs5Zc1LkrWWG8VZ
67iBZaxOzEdW+zJJDWHoBw6Z5fe30bqdgxzH0HsdiC22V5HtwvWQ93aCdxaryUHWwg3Qf6GB95Ty
+rJkLdzAhDhrLfdyjNWStXAD9IsSwz67wys5zKBlu8cWehTDPm/IKjnEdqeYCuRGh6L4G1qzVTj5
e0f2CzfCeLFvFq3ZJqz8XdL3jXCyiqDvoiG3FHVpS/q+kc8yAhly5YZVf38LrdpFOJ/YGVq0RTi/
NKm+9yFhLIZBHzfkPBQ9gxbtIpyf6DxatEU4aWdsd02rMclwVsgleEYNRqasfrDqzSEXShmLoUxZ
/WDVm8+hVduDeMn0AjNo0U7C6heZQau2B+OXJlNWP3j9IlW0bHtM06Mxi9bsJBMcYwVcdGAshlJ+
7wevXyTgogPjy1DK7/3gHVH5BC3bHvQvw06G1uwizCMq59C6rUE/0ht0BYYPb8oK+NOQcWYn5M15
Pg2eszK0bmvQd+cvoyU7Cf3Q/QIBH2PNycGYRUt2EubVweF2fNOre1Jy6Adzygo4gaffbyH5ex8S
+mGwRWpo5dag1xxqaMkuwvwwLIpgFwB6zSH0WwhYsG87D3cDlp4e/BUt2UW4VwcHnFrQD+1U0ZId
ZJT9vtoMWro1yN/KAW+g8uGcI1gg3H0y8hMxshj2gVtxCLkHnl7NqqIluwc7fQ/5d/oFaihkMdzI
HWxjBbwDO0kNxftoxe7Bf2tUNg1XUUMrdg529b0I+U42cp004B8ZF421MOBbaMgfNeH+yLh8ScNY
nWC3dujb0bNoxa6R5hrOCrgFfpIaC7nlbx3sGmmPl9Hq7dEghiLc/VMm3NeRFwi40Y1cgQ93/5SH
TpIVdNJKvmF6Bq3YLSq5lrNqaP32IN8jlqEVO0Xa0DJWyI1uX5RY6HBEy1gB7xnSD4QFnBgwuFvP
WEF/Z08TY/FntGCXuEnTWOE20IzQdw1raMEOsVfTWEF/DZF3DcOtv5DZzu5PvkrQO7DUooPUSZfR
NlbYF0VdQwxGwNtcRPSNFW4DfA/qlWzn0IJdQd9YgXdQUstZM2jBjmDAWIHXnCeI0aiiBbvBHgPG
CvcGmgWoHSBovW6gXW7oEe7JigWIp1jl2E6Ph00YK/Api/pKe9BFY0WSJ0wYK/Qpa4QYDmnOGqkw
L/ZbR+hTFrUEfw4tGM723Iixgp+yqG9XzKIFo7ndjK8Cr2WN0M/21tCCsaTPGDJW2OX3HlRnVdGC
oZhaCYvibfRQrEPtVc7QgoEkD5nyVcgndpagPl6B1gtkW8OYsYqfowdjH+KGdLxN8AYnrDiqgsQN
6Wi7s3bnBo3VCb3i0IPorBh+bH2omPokXCT89H2E3OoQZd9f+pCBxoZVtMJP30fIzorwSFiyPzfq
q1hqgkRnxbdtOK5xm19/PkQPqRwmaVH5G1pvyZj3VdHK0IMqB2LjX1TOSvab91UsayHZWREdkE4P
5RZ8VbyDHldZEJ01i9ZbFjuP2rBVUcxH8V3YQ5zVh3Tfm3Z8VXSq6LGVRoMWmVm03hIYtzRd9XgF
PbjyIOaoNbRe2+w8nFux1CKRFBwWEGet4rap3IqhlognyRoRZy1T2feC2T2cjbSr6EGWiTirS3rb
IVsp+2qeRI+zVKJ3Vjp+6E92jLSe19BDLZeYnZWO1V+wUWXvz0fo4ZZMpM7aMV5/tTxT9bgcU/be
IzZn7RirP94sI6laRyz70CtE4qx07Lauo5q2v/4GEtdn4QKhOysde7DeLClFH0ynho5D+QTsrMr4
483cilGodH6EjgWAaVqMami9iiTjU+Um6EN5Fh0OBMRehxparxI7p2AJVT+iNFaIzrruRTsG4RJZ
hXSJ8Jz1PTv+YPM6OiAgiM76MVrvpjxixx9sYjUW9VTYLFrvZnzbij34RGus0JxFvQ7MNnEm7wtM
0CI1i9a7CWYupzVGxMai3hhyDq13OJ+xYxAmnUfR8UBCdJbjJ1mpLxdbpR1j5X0F4s1sbt/rkLhU
IG3HcEnWEIi3Sbp9F41L+fuVkN8eV4H4cKbbN7PdaMckHD7O0MFAQ/yZX0brHQr13TN7vBtbB+lG
RmkRc/sG3NyKSxj8Ah0JB6C+u4PWOwzir8QakX8ULkGMmst5KfWxdUtEn7tfJaeFrYbWOwTqqwl2
OCUp1iINWtxcvprNBWd1Yt7QWQvxe+rvaL1DcMBZrfvQQXCHCVroXH5JFF8oPZWhY+AQX6XFzuUX
yuGbO9HcQaoEceOwcDk/RVdK30IHwCmojSc1tOAhUH8lpol9E3ot1OTE5Y9D+HLY+Qk6BA5BLcI7
3UdzixW/UJAcfgXi79zpFw4d2N9pP4UOgjM0iKFzOYWnPiNkhYtRNymvgvpBVUMLHsYWK16hcuY7
6Dg4wdeIYXM5hXdj0upyWrxF/1R3uQrvyqTVZU46Hqi9J2204OFM2rAJi7kMHQswFWrE3P4xjqJr
Wit0jmXoaGCh/itm0YKHg69prdB+yukvadtQT6y7fTJsJHHosr+iaMVcgqAeLHb7lIULzTRruHg/
OiAwvkCNVYZWvAmu3XR02u3M1B7kazZm0Io344gNf2gQaypP3mxzelO6R+rYZUfdVP6n6JhAyIlh
cnpTegH3rFVciLFDfpoapQyteFOSJyyYQ5MIG2yoO4fuJ1pd9uQWzKFHfA025NNUzidaPdIpG+7Q
42JkSyJ5F9f9RGuBiltPWSwQ2WYi+R+QoRUrku77rQ176NCOqlV+mhqel9GK1Un3Hc3N+0OH01V0
TMqDnMI7vnW4nh37pgDPsA6k8xw6IKXxWWpsXN867MfYvkOOPHcYUSZPbtEqfD2ymYyN11/APfq7
wrFI2mvIjSe+nzMfu7X+OPYR4Pk4pq1JalzcvmNZmXRhCrPgGxWimLbIFyJ0MrRkk6Rj++rN8hsG
Y5i26CdePKo7KDNW+pPmEUxb5IB6VndQp3Jr/VVyNNiEP21NUkPSDvrXVhk/VFZ6H/q0Rb95qoaW
bJtkrF5Kbn+lih6pVeiJlhf9Dtrc+rj9uSvwknxOjYfjR6XNkY5b33g8naEHaZFJcjhqaMklsvOw
3ZpEO+BTifREK47lcJkdh6yaK9yXL+hbh9Esh8vsOJSbt9QS875uxW4K/RdZQ0sGsMtem2on1Kfr
JsihCLZYOpRk3FqbaqCHe8gnpQMvlg6hYmtVDPPVnpQ+zYe4d6jI+IsWjNUlyNIW/WkRt++VtMy1
h3PzxgpzRbyBHIWwWmnIJPtsNNcHuCIybun3vbNUm10WFsUA396k1x08OdFqk8ph82WI4Kqm5LNh
cZa01pP+IDdtrfkqelBmYdzCGNkOzwCSfaY3fkLbR8zJEeiENm9zGf+dYW/9Bj0iozCWQ7efSimT
3Ya9FVT5gbEcSg6/gmFvBZVs5fTx19CaXcKst0JKthjPP3yC1uwWu43m8uEkW4zlMPI6/Eb+PTdo
rXAqWw364KOvw68n+a5Bb10J5ZEC+t5hvL00g0kPm7NWO5BtxJQx9oh7aQYy+owxa3UCuX2S3koj
hYe+7G4Y89Yf0GMxAvn2v0IKDwPYn5uyVhB5fMIIR9QNgEMwdyH9hQw9FgNwXjQN9jyTLtteMmSt
VhU9FH04b8fHeYhHCVNLYvtH6JHoM00ftlRLB5MaeloqgE9E+jH8ongfLdplTG34/Bo9EF04ObxM
WsNIHjJjrXfRA9GFk8PLpDWUbQ0j1vK9+sDJ4WXSGo6hacv36gOjDi+T1maMGnl/eN7vDWr6DQ8y
aW2OmWmr5XXtkJPDy6S1OUayrbbX1rqRMWKZtDbHyLTV8blmyriWRiYtJXbnBqzl8+n8ezkDztCq
fcBISd5ja3EKD8UHaNV+sMfAPRCvowfBh/WJ7HVuWR4m6g/+WotTeJA+LUWSh/Wt5e1OD6vwIM2l
qhhI5L21FuMQj3TEq1PRbwl819NNRFbhoZhBy/YGAyvieU+txel4kLOHBPRXRE+txTl5WBRvo2V7
hP43oqfWmuSMVcqlBBLtqqmf1mJVS4sP0bK94vY4rcVp05LKA43teYzWYlVLpfJAo6KbbHlpLd6g
f4+W7RfayZaP1uJNWu0MrdszdJMtH63FOygnSTwR3cqWh9ZibfFIEk9mi+ZZV/+sxduXLua9Gyia
VHMb0T9rMSctqcRT0c3jz6MHQIU5aXWqaOH+cZeetbxrqmFOWp+idXt6Ha7cAAACC0lEQVTIXr0u
Zt+sxZy0pKjFQLMe/w5aPxFWM013PfT7lDiGLXrW8qw3ntcBKOshi0pDy1qvofXTYE5axSto4T6i
WX3w6xwid9Jqy3rIIDmiZS2/DuZzJy1ZD1k8ouMsv+584E5a8n3IQ6uw5ddNNTczRyn1Uh7f0rKW
T0kIt6ZVXPZuN8sN9upYq5Wh5RNgFuJl/5CLVjn+SoaWrw570pJ+GibbdazlU+MDe9Lyamp2CS1r
fYRWrw5/0vKuu8MVtDYRPdpCZE9aUornorWJ6M8+T8I+uySlBy5a1noSrV4Z3jGeHtK6zEXHWp0a
Wr0y/AOXcpSHi461/KmYbuUPUlItLjrWms/Q6lWZZI/Ro5nZNXSs9akvaQjvapoFpKrFRsdaf0GL
V4XbTVNIVUsDHWv5Untgd9MUsoGowVaNsPtSe+B20/g0RgfR2OjpeNKtxd/j6X4EV9Hq/UXDWr5k
uPxyqT9jdJHr+WH3pUVuWsNaksXz0WgF9KTvQaPy4NUGvHPcxA+7Jx+Id+hY61do9R6j0Rvvx3Ge
NNdwltTiNeAfFvPk4+krGs7yZYxuwj/i6skO4rSOteQDkY/G6Wk/Pp60knhvPoJdJOU3MvmxBaJT
iffl5+MmKf+eXC+2QBK9e4Cl9sBnNOdG3Y8M9xotZ/lSX3ES/u60Hz3j9+hZy69LntziS+yom0pD
/h/aqRvE7KKmBQAAAABJRU5ErkJggg==');">
				<div id="container">
					<h1>
						<xsl:value-of select="wsdl:definitions/@name" />
						<span style="display: block; font-size: 0.5em;  text-shadow: none;">
							<xsl:text>WSDL Interface Specification</xsl:text>
						</span>
						<span
							style="display: block; font-size: 0.4em; font-style: italic; font-weight: normal; text-shadow: none;">
							<xsl:text>tns:</xsl:text>
							<xsl:value-of select="wsdl:definitions/@targetNamespace" />
						</span>
						<xsl:if
							test="matches(wsdl:definitions/wsdl:documentation, '^\s*(Version .*?)($.*)', 'sm')">
							<span
								style="display: block; font-size: 0.4em; font-style: italic; font-weight: normal; text-shadow: none;">
								<xsl:value-of
									select="replace(wsdl:definitions/wsdl:documentation, '^\s*(Version .*?)($.*)', '$1', 'sm')" />
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
							<h2 id="{tibant:convert-to-id('Operation')}">Operations</h2>
							<xsl:for-each select="wsdl:definitions/wsdl:portType/wsdl:operation">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." />
							</xsl:for-each>
						</xsl:if>

						<xsl:if test="wsdl:definitions/wsdl:message">
							<h2 id="{tibant:convert-to-id('Messages')}">Messages</h2>
							<p>
								<xsl:text>The following section details each of the messages defined by </xsl:text>
								<xsl:value-of select="wsdl:definitions/@name" />
							</p>
							<ul>
								<xsl:for-each select="wsdl:definitions/wsdl:message">
									<xsl:sort select="@name" />
									<li>
										<!--a href="{concat('#', tibant:convert-to-id(@name))}"-->
										<xsl:value-of select="@name" />
										<!--/a-->
									</li>
								</xsl:for-each>
							</ul>
							<xsl:for-each select="wsdl:definitions/wsdl:message">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." />
							</xsl:for-each>
						</xsl:if>

						<xsl:if
							test="wsdl:definitions/wsdl:types/xs:schema/xs:simpleType[exists(.//xs:enumeration)]">
							<h2 id="{tibant:convert-to-id('Enumeration')}">Enumerations</h2>
							<p>
								<xsl:text>The following section details each of the enumerations user by </xsl:text>
								<xsl:value-of select="wsdl:definitions/@name" />
							</p>
							<ul>
								<xsl:for-each
									select="wsdl:definitions/wsdl:types/xs:schema/xs:simpleType[exists(.//xs:enumeration)]">
									<xsl:sort select="@name" />
									<li>
										<!--a href="{concat('#', tibant:convert-to-id(@name))}"-->
										<xsl:value-of select="@name" />
										<!--/a-->
									</li>
								</xsl:for-each>
							</ul>
							<xsl:for-each
								select="wsdl:definitions/wsdl:types/xs:schema/xs:simpleType[exists(.//xs:enumeration)]">
								<xsl:sort select="@name" />
								<xsl:apply-templates select="." />
							</xsl:for-each>
						</xsl:if>
					</xsl:variable>
					<h2 id="contents">Contents</h2>
					<ul id="contents-list">
						<xsl:for-each select="$content/html:h2">
							<li>
								<!-- a href="{concat('#',@id)}"-->
								<xsl:value-of select="." />
								<!--/a-->
								<xsl:variable name="next" select="following-sibling::html:h2[1]" />
								<xsl:variable name="next-h3"
									select="$next/following-sibling::html:h3" />
								<xsl:if test="following-sibling::html:h3 except $next-h3">
									<ul>
										<xsl:for-each select="following-sibling::html:h3 except $next-h3">
											<li>
												<!--a href="{concat('#',@id)}"-->
												<xsl:value-of select="." />
												<!--/a-->
												<xsl:variable name="next"
													select="following-sibling::html:h3[1]" />
												<xsl:variable name="next-h4"
													select="$next/following-sibling::html:h4" />
												<xsl:if test="following-sibling::html:h4[@id] except $next-h4">
													<ul>
														<xsl:for-each select="following-sibling::html:h4 except $next-h4">
															<li>
																<!--a href="{concat('#',@id)}"-->
																<xsl:value-of select="." />
																<!--/a-->
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
		<h3 id="{tibant:convert-to-id(concat($section, ' ', @name))}">
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
			<xsl:with-param name="content" select="wsdl:documentation" />
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
							<!--a href="{concat('#', tibant:convert-to-id($message))}"-->
							<xsl:value-of select="$message" />
							<!--/a-->
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="wsdl:message">
		<xsl:variable name="section" select="@name" />
		<h3 id="{tibant:convert-to-id($section)}">
			<xsl:value-of select="$section" />
		</h3>
		<xsl:variable name="references"
			select="../wsdl:portType/wsdl:operation/wsdl:*[@message=concat('tns:',$section)]" />
		<p>
			<xsl:text>Message Type: </xsl:text>
			<xsl:for-each-group select="$references" group-by="local-name()">
				<xsl:value-of select="current-grouping-key()" />
			</xsl:for-each-group>
		</p>
		<p>Used in:</p>
		<ul>
			<xsl:for-each select="$references">
				<li>
					<!--
						a href="{concat('#',tibant:convert-to-id(concat(../../@name,'
						',../@name)))}"
					-->
					<xsl:value-of select="../../@name" />
					<xsl:text>:</xsl:text>
					<xsl:value-of select="../@name" />
					<!--/a-->
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
					<xsl:for-each select="wsdl:part">
						<xsl:variable name="parttype"
							select="tibant:get-type(@element,//wsdl:definitions,//wsdl:definitions/wsdl:types/xs:schema)" />
						<tr>
							<td class="required">
								<xsl:value-of select="@name" />
							</td>
							<td>
								<xsl:value-of select="@element" />
							</td>
							<td>
								<xsl:text>1..1</xsl:text>
							</td>
							<td>
								<xsl:call-template name="output-content">
									<xsl:with-param name="content"
										select="$parttype/xs:annotation/xs:documentation" />
									<xsl:with-param name="section" select="$section" />
								</xsl:call-template>
							</td>
						</tr>
						<xsl:call-template name="output-complex-type">
							<xsl:with-param name="type" select="$parttype" />
							<xsl:with-param name="indent" select="'&#160;&#160;&#160;&#160;'" />
							<xsl:with-param name="doc" select="//wsdl:definitions" />
							<xsl:with-param name="section" select="$section" />
						</xsl:call-template>
					</xsl:for-each>
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

	<xsl:template match="xs:simpleType">
		<xsl:variable name="section" select="@name" />
		<h3 id="{tibant:convert-to-id($section)}">
			<xsl:value-of select="$section" />
		</h3>
		<xsl:call-template name="output-content">
			<xsl:with-param name="content" select="wsdl:documentation" />
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

	<xsl:template name="output-complex-type">
		<xsl:param name="type" />
		<xsl:param name="indent" />
		<xsl:param name="doc" />
		<xsl:param name="section" />
		<xsl:message>
			<xsl:text>Outputting </xsl:text>
			<xsl:value-of select="$type/@name" />
		</xsl:message>
		<xsl:for-each select="$type/xs:complexContent/xs:extension">
			<xsl:message>
				<xsl:text>  </xsl:text>
				<xsl:value-of select="$type/@name" />
				<xsl:text> extends </xsl:text>
				<xsl:value-of select="@base" />
			</xsl:message>
			<xsl:variable name="etype"
				select="tibant:get-type(./@base,$type,$doc/wsdl:types/xs:schema)" />
			<xsl:message>
				<xsl:text>    type name:</xsl:text>
				<xsl:value-of select="name($type)" />
			</xsl:message>
			<xsl:call-template name="output-complex-type">
				<xsl:with-param name="type" select="$etype" />
				<xsl:with-param name="indent" select="$indent" />
				<xsl:with-param name="doc" select="$doc" />
				<xsl:with-param name="section" select="$section" />
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="$type//xs:sequence/xs:element">
			<xsl:choose>
				<xsl:when test="exists(@ref)">
					<xsl:variable name="el"
						select="tibant:get-element(@ref,.,$doc/wsdl:types/xs:schema)" />
					<xsl:message>
						Ref Element:
						<xsl:value-of select="@ref" />
					</xsl:message>
					<xsl:variable name="subtype"
						select="tibant:get-type($el/@type,$el,$doc/wsdl:types/xs:schema)" />
					<tr>
						<xsl:variable name="cardnality">
							<xsl:choose>
								<xsl:when test="exists(@minOccurs)">
									<xsl:value-of select="@minOccurs" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>1</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>..</xsl:text>
							<xsl:choose>
								<xsl:when test="@maxOccurs = 'unbounded'">
									<xsl:text>*</xsl:text>
								</xsl:when>
								<xsl:when test="exists(@maxOccurs)">
									<xsl:value-of select="@maxOccurs" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>1</xsl:text>
								</xsl:otherwise>
							</xsl:choose>

						</xsl:variable>
						<td>
							<xsl:choose>
								<xsl:when test="not(starts-with($cardnality,'0'))">
									<strong>
										<xsl:value-of select="$indent" />
										<xsl:value-of select="$el/@name" />
									</strong>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$indent" />
									<xsl:value-of select="$el/@name" />
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<xsl:value-of select="$subtype/@name" />
						</td>
						<td>
							<xsl:value-of select="$cardnality" />
						</td>
						<td>
							<xsl:call-template name="output-content">
								<xsl:with-param name="content"
									select="xs:annotation/xs:documentation" />
								<xsl:with-param name="section" select="$section" />
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="name($subtype)='xs:complexType'">
						<xsl:call-template name="output-complex-type">
							<xsl:with-param name="type" select="$subtype" />
							<xsl:with-param name="indent"
								select="concat($indent,'&#160;&#160;&#160;&#160;')" />
							<xsl:with-param name="doc" select="$doc" />
							<xsl:with-param name="section" select="$section" />
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="subtype"
						select="tibant:get-type(@type,.,$doc/wsdl:types/xs:schema)" />
					<tr>
						<xsl:variable name="cardnality">
							<xsl:choose>
								<xsl:when test="exists(@minOccurs)">
									<xsl:value-of select="@minOccurs" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>1</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>..</xsl:text>
							<xsl:choose>
								<xsl:when test="@maxOccurs = 'unbounded'">
									<xsl:text>*</xsl:text>
								</xsl:when>
								<xsl:when test="exists(@maxOccurs)">
									<xsl:value-of select="@maxOccurs" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>1</xsl:text>
								</xsl:otherwise>
							</xsl:choose>

						</xsl:variable>
						<td>
							<xsl:choose>
								<xsl:when test="not(starts-with($cardnality,'0'))">
									<strong>
										<xsl:value-of select="$indent" />
										<xsl:value-of select="@name" />
									</strong>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$indent" />
									<xsl:value-of select="@name" />
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<xsl:value-of select="@type" />
						</td>
						<td>
							<xsl:value-of select="$cardnality" />
						</td>
						<td>
							<xsl:call-template name="output-content">
								<xsl:with-param name="content"
									select="xs:annotation/xs:documentation" />
								<xsl:with-param name="section" select="$section" />
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="name($subtype)='xs:complexType'">
						<xsl:call-template name="output-complex-type">
							<xsl:with-param name="type" select="$subtype" />
							<xsl:with-param name="indent"
								select="concat($indent,'&#160;&#160;&#160;&#160;')" />
							<xsl:with-param name="doc" select="$doc" />
							<xsl:with-param name="section" select="$section" />
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="$type//xs:choice/xs:element">
			<xsl:choose>
				<xsl:when test="exists(@ref)">
					<xsl:variable name="el"
						select="tibant:get-element(@ref,.,$doc/wsdl:types/xs:schema)" />
					<xsl:message>
						Ref Element:
						<xsl:value-of select="@ref" />
					</xsl:message>
					<xsl:variable name="subtype"
						select="tibant:get-type($el/@type,$el,$doc/wsdl:types/xs:schema)" />
					<tr>
						<td>
							<xsl:value-of select="$indent" />
							<xsl:value-of select="$el/@name" />
						</td>
						<td>
							<xsl:value-of select="$subtype/@name" />
						</td>
						<td>
							<xsl:text>choice</xsl:text>
						</td>
						<td>
							<xsl:variable name="choice-msg">
								<xsl:choose>
									<xsl:when test="count(../xs:element) > 2">
										<xsl:text>One of the following must be included:
</xsl:text>
										<xsl:for-each select="../xs:element">
											<xsl:text> * </xsl:text>
											<xsl:value-of select="@name" />
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Either </xsl:text>
										<xsl:value-of select="../xs:element[1]/@name" />
										<xsl:text> or </xsl:text>
										<xsl:value-of select="../xs:element[2]/@name" />
										<xsl:text> must be included.
</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text></xsl:text>
							</xsl:variable>
							<xsl:call-template name="output-content">
								<xsl:with-param name="content"
									select="concat($choice-msg, xs:annotation/xs:documentation)" />
								<xsl:with-param name="section" select="$section" />
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="name($subtype)='xs:complexType'">
						<xsl:call-template name="output-complex-type">
							<xsl:with-param name="type" select="$subtype" />
							<xsl:with-param name="indent"
								select="concat($indent,'&#160;&#160;&#160;&#160;')" />
							<xsl:with-param name="doc" select="$doc" />
							<xsl:with-param name="section" select="$section" />
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="subtype"
						select="tibant:get-type(@type,.,$doc/wsdl:types/xs:schema)" />
					<tr>
						<td>
							<xsl:value-of select="$indent" />
							<xsl:value-of select="@name" />
						</td>
						<td>
							<xsl:value-of select="@type" />
						</td>
						<td>
							<xsl:text>choice</xsl:text>
						</td>
						<td>
							<xsl:variable name="choice-msg">
								<xsl:choose>
									<xsl:when test="count(../xs:element) > 2">
										<xsl:text>One of the following must be included:
</xsl:text>
										<xsl:for-each select="../xs:element">
											<xsl:text> * </xsl:text>
											<xsl:value-of select="@name" />
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Either </xsl:text>
										<xsl:value-of select="../xs:element[1]/@name" />
										<xsl:text> or </xsl:text>
										<xsl:value-of select="../xs:element[2]/@name" />
										<xsl:text> must be included.
</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text></xsl:text>
							</xsl:variable>
							<xsl:call-template name="output-content">
								<xsl:with-param name="content"
									select="concat($choice-msg, xs:annotation/xs:documentation)" />
								<xsl:with-param name="section" select="$section" />
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="name($subtype)='xs:complexType'">
						<xsl:call-template name="output-complex-type">
							<xsl:with-param name="type" select="$subtype" />
							<xsl:with-param name="indent"
								select="concat($indent,'&#160;&#160;&#160;&#160;')" />
							<xsl:with-param name="doc" select="$doc" />
							<xsl:with-param name="section" select="$section" />
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--
		xsl:template name="output-element"> <xsl:param name="element" />
		<xsl:param name="indent" /> <xsl:param name="doc" /> <xsl:param
		name="section" /> <xsl:message> <xsl:text>Outputting </xsl:text>
		<xsl:value-of select="$element/@name" /> </xsl:message> <xsl:variable
		name="subtype"
		select="tibant:get-type(@type,.,$doc/wsdl:types/xs:schema)" /> <tr>
		<xsl:variable name="cardnality"> <xsl:choose> <xsl:when
		test="exists(@minOccurs)"> <xsl:value-of select="@minOccurs" />
		</xsl:when> <xsl:otherwise> <xsl:text>1</xsl:text> </xsl:otherwise>
		</xsl:choose> <xsl:text>..</xsl:text> <xsl:choose> <xsl:when
		test="@maxOccurs = 'unbounded'"> <xsl:text>*</xsl:text> </xsl:when>
		<xsl:when test="exists(@maxOccurs)"> <xsl:value-of select="@maxOccurs"
		/> </xsl:when> <xsl:otherwise> <xsl:text>1</xsl:text> </xsl:otherwise>
		</xsl:choose> </xsl:variable> <td> <xsl:choose> <xsl:when
		test="not(starts-with($cardnality,'0'))"> <strong> <xsl:value-of
		select="$indent" /> <xsl:value-of select="@name" /> </strong>
		</xsl:when> <xsl:otherwise> <xsl:value-of select="$indent" />
		<xsl:value-of select="@name" /> </xsl:otherwise> </xsl:choose> </td>
		<td> <xsl:value-of select="@type" /> </td> <td> <xsl:value-of
		select="$cardnality" /> </td> <td> <xsl:call-template
		name="output-content"> <xsl:with-param name="content"
		select="xs:annotation/xs:documentation" /> <xsl:with-param
		name="section" select="$section" /> </xsl:call-template> </td> </tr>
		</xsl:template
	-->

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
				<!--
					a href="{tibant:convert-to-id(concat('#', $section, '_',
					$attribute))}"
				-->
				<xsl:text>@{</xsl:text>
				<xsl:value-of select="$attribute" />
				<xsl:text>}</xsl:text>
				<!--/a-->
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
			<!-- macro name -->
			<xsl:when test="exists($macros[@name=$content])">
				<!--a href="{tibant:convert-to-id(concat('#', $content))}"-->
				<xsl:value-of select="$content" />
				<!--/a-->
			</xsl:when>
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
				<h2 id="{tibant:convert-to-id($heading)}">
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
				<h3 id="{tibant:convert-to-id($heading)}">
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

	<xsl:function name="tibant:convert-to-id">
		<xsl:param name="id" />
		<xsl:value-of select="replace(replace($id, ' ', '_'), '^-', 'a-')" />
	</xsl:function>

	<xsl:function name="tibant:doc-name">
		<xsl:text>Interface Specification</xsl:text>
	</xsl:function>


	<xsl:function name="tibant:namespace">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:variable name="prefix" select="replace($type, ':.*', '')" />
		<xsl:variable name="namespace" select="$doc/namespace::*[name()=$prefix]" />
		<xsl:message>
			<xsl:text>namespace for </xsl:text>
			<xsl:value-of select="$prefix" />
			<xsl:text> is </xsl:text>
			<xsl:value-of select="$doc/namespace::*[name()=$prefix]" />
		</xsl:message>
		<xsl:value-of select="$doc/namespace::*[name()=$prefix]" />
	</xsl:function>

	<xsl:function name="tibant:get-type">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:param name="schemas" />
		<xsl:variable name="namespace" select="tibant:namespace($type,$doc)" />
		<xsl:message>
			<xsl:text>found ns </xsl:text>
			<xsl:value-of select="$namespace" />
		</xsl:message>
		<xsl:copy-of
			select="$schemas[@targetNamespace=$namespace]/xs:complexType[@name=replace($type,'.*:','')]" />
	</xsl:function>

	<xsl:function name="tibant:get-element">
		<xsl:param name="type" />
		<xsl:param name="doc" />
		<xsl:param name="schemas" />
		<xsl:variable name="namespace" select="tibant:namespace($type,$doc)" />
		<xsl:copy-of
			select="$schemas[@targetNamespace=$namespace]/xs:element[@name=replace($type,'.*:','')]" />
	</xsl:function>

</xsl:stylesheet>
