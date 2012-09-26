package com.si.powerlog

import org.apache.log4j.Level
import org.apache.log4j.Logger
import org.apache.log4j.PatternLayout
class LogController {

    def cometDService
    def index = { 
        [loggers:LogConfig.list()]
    }
    def showAllLogger={
        log.error  new Date()
        def rootLogger=Logger.rootLogger
        log.info "Logger.rootLogger -> ${rootLogger.level}"
        rootLogger.allAppenders.each{ appender ->
            log.info appender.name
        }
        rootLogger.loggerRepository.currentLoggers.toList().sort { it.name }.each{ logger ->
           if(logger.level){
               log.info "${logger.name} -> ${logger.level}"
               logger.allAppenders.each{ appender ->
                    log.info appender.name
                }
           }
        }
        def map=[:]
        render map
    }
}
