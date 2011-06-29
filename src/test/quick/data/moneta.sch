<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"  xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <title>moneta</title>
    <pattern name="Check Headings">
        <rule context="/xhtml:html/xhtml:head/xhtml:title">
            <assert test=". = 'moneta - WSDL Interface Specification'">
                The title is wrong
            </assert>
        </rule>
    </pattern>

    <pattern name="Check Type Expeansion">
        <rule context="/xhtml:html/xhtml:body/xhtml:div[@id='container']/xhtml:table/xhtml:tbody[xhtml:tr/xhtml:td[1] = 'license-content']">
            <assert test="count(xhtml:tr) > 1">
                There should be more than one row to describe the license-content type
            </assert>
        </rule>
    </pattern>
</schema>
