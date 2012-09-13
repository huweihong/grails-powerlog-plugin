package com.si.powerlog

class LogConfig {

    String logger
    String level
    String type
    
    static hasMany = [ appenders: Appender ]
    static constraints = {
        logger(nullable:false,blank:false,unique:true,maxSize:200)
        level(nullable:false,blank:false,inList:['INFO','WARN','ERROR','FATAL','OFF'])
        type(nullable:false,blank:false,inList:['Default','Custom'])
    }
    
    String toString(){
        "${logger} -> ${level} -> ${type}"
    }
    
}
