package com.si.powerlog

import grails.test.*

class AppenderTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        mockDomain Appender
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testNullableConstraint() {
        def appender = new Appender() 
        assertFalse appender.validate()
        assertEquals "nullable", appender.errors["name"] 
        assertEquals "nullable", appender.errors["pattern"]
        assertEquals "nullable", appender.errors["appenderClass"]
    }
    
    void testBlankConstraint() {
        def appender = new Appender(name:"",pattern:"",appenderClass:"") 
        assertFalse appender.validate()
        assertEquals "blank", appender.errors["name"] 
        assertEquals "blank", appender.errors["pattern"]
        assertEquals "blank", appender.errors["appenderClass"]
    }
    
    void testUnique() {
        def appender1 = new Appender(name:"test",pattern:"test",appenderClass:"Custom").save()
        def appender2 = new Appender(name:"test",pattern:"test",appenderClass:"Custom")
        
        assertTrue appender1.validate()
        assertFalse appender2.validate()
    }
    
    void testMaxSizeConstraint() {
        def appender = new Appender(name:new String(new byte[101])
                                    ,pattern:new String(new byte[101])
                                    ,appenderClass:new String(new byte[101])
                                    ,propertyJson:new String(new byte[1025])) 
        assertFalse appender.validate()
        assertEquals "maxSize", appender.errors["name"] 
        assertEquals "maxSize", appender.errors["pattern"] 
        assertEquals "maxSize", appender.errors["appenderClass"] 
        assertEquals "maxSize", appender.errors["propertyJson"] 
    }
    
    void testValidate() {
        def appender = new Appender(name:"appender",pattern:"test",appenderClass:"com.si.powerlog.WebLogAppender") 
        assertTrue appender.validate()
    }
    
    void testToString() {
        def appender = new Appender(name:"appender",pattern:"test",appenderClass:"com.si.powerlog.WebLogAppender") 
        
        assertEquals "appender", appender.toString()
    }
}
