package com.si.powerlog

import grails.test.*

class LogConfigTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        mockDomain LogConfig
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testNullableConstraint() {
        def logConfig = new LogConfig() 
        assertFalse logConfig.validate()
        assertEquals "nullable", logConfig.errors["logger"] 
        assertEquals "nullable", logConfig.errors["level"]
        assertEquals "nullable", logConfig.errors["type"]
    }
    
    void testBlankConstraint() {
        def logConfig = new LogConfig(logger:"",level:"",type:"") 
        assertFalse logConfig.validate()
        assertEquals "blank", logConfig.errors["logger"] 
        assertEquals "blank", logConfig.errors["level"]
        assertEquals "blank", logConfig.errors["type"]
    }
    
    void testUnique() {
        def logConfig1 = new LogConfig(logger:"test",level:"WARN",type:"Custom").save()
        def logConfig2 = new LogConfig(logger:"test",level:"WARN",type:"Custom")
        
        assertTrue logConfig1.validate()
        assertFalse logConfig2.validate()
    }
    
    void testMaxSizeConstraint() {
        def logConfig = new LogConfig(logger:new String(new byte[201])) 
        assertFalse logConfig.validate()
        assertEquals "maxSize", logConfig.errors["logger"] 
    }
    
    void testLevelInList() {
        def logConfig = new LogConfig(level:"test") 
        assertFalse logConfig.validate()
        assertEquals "inList", logConfig.errors["level"]
    }
    
    void testTypeInList() {
        def logConfig = new LogConfig(type:"test") 
        assertFalse logConfig.validate()
        assertEquals "inList", logConfig.errors["type"]
    }
    
    void testValidate() {
        def logConfig = new LogConfig(logger:"rootLogger",level:"WARN",type:"Default") 
        assertTrue logConfig.validate()
    }
    
    void testToString() {
        def logConfig = new LogConfig(logger:"rootLogger",level:"WARN",type:"Default") 
        
        assertEquals "rootLogger -> WARN -> Default", logConfig.toString()
    }
}
