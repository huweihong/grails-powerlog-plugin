package com.si.powerlog

class Appender {
    String name
    String pattern
    String appenderClass
    String propertyJson
    
    static constraints = {
        name(nullable:false,blank:false,unique:true,maxSize:100)
        pattern(nullable:false,blank:false,maxSize:100)
        appenderClass(nullable:false,blank:false,maxSize:100)
        propertyJson(nullable:true,blank:true,maxSize:1024)
    }
    
    String toString(){
        name
    }
}
