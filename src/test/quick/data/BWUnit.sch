<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"  xmlns:x="http://www.w3.org/1999/xhtml">
    <title>BWUnit</title>
    <pattern name="Check Headings">
        <rule context="/x:html/x:head/x:title">
            <assert test=". = 'BWUnit - WSDL Interface Specification'">
                The title is wrong
            </assert>
        </rule>
    </pattern>

    <pattern name="Check Type Expeansion">
        <rule context="/x:html/x:body/x:div[@id='container']/x:table/x:tbody[x:tr/x:td[1] = 'license-content']">
            <assert test="count(x:tr) > 1">
                There should be more than one row to describe the license-content type
            </assert>
        </rule>
    </pattern>
</schema>
