<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"  xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <title>oai_dc</title>
    <pattern name="Check Headings">
        <rule context="/xhtml:html/xhtml:head/xhtml:title">
            <assert test=". = 'XSD Interface Specification'">
                The title is wrong
            </assert>
        </rule>
    </pattern>

    <pattern name="Check Type Expansion">
        <rule context="/xhtml:html/xhtml:body/xhtml:div[@id='container']/xhtml:table[@class='detail']/xhtml:tbody">
            <assert test="count(xhtml:tr) > 1">
                There should be more than one row to describe the Element type
            </assert>
        </rule>
    </pattern>
</schema>
