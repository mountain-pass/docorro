<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"  xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <title>moneta</title>
    <pattern name="Check Headings">
        <rule context="/xhtml:html/xhtml:head/xhtml:title">
            <assert test=". = 'moneta - WSDL Interface Specification'">
                The title is wrong
            </assert>
            <report test=". = 'moneta - WSDL Interface Specification'">
                The title is right
            </report>
        </rule>
    </pattern>
</schema>
