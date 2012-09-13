package com.si.powerlog

import org.apache.log4j.Level
import org.apache.log4j.Logger
import org.apache.log4j.PatternLayout
import grails.converters.JSON

class LogService {

    static transactional = true

    def deleteAppender(Appender appender) {
        getLogConfigs(appender).each{ logConfig ->
            logConfig.removeFromAppenders(appender)
        }
        appender.delete(flush: true)
    }
    
    def getLogConfigs(Appender appender){
        return LogConfig.executeQuery('select distinct(log) from LogConfig log join log.appenders appender where appender.id=:id'
						,[id:appender.id])
    }
    
    def getLogger(LogConfig logConfig){
        def logger
        switch(logConfig.logger){
            case "rootLogger":
                logger=Logger.rootLogger
                break
            default:
                logger=Logger.rootLogger.getLogger(logConfig.logger)
                break
        }
        return logger
    }
    
    def addAppenderForLogger(Appender appender,Logger logger){
        def appenderInstance=getClass().classLoader.loadClass(appender.appenderClass.trim())?.newInstance()
        appenderInstance.name=appender.name
        appenderInstance.layout=new PatternLayout(appender.pattern)
        if(appender.propertyJson){
            JSON.parse(appender.propertyJson).each{ property ->
               appenderInstance."${property.key}"=property.value
            }
        }
        appenderInstance.activateOptions()
        logger.addAppender(appenderInstance)
    }
}
