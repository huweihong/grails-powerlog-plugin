package com.si.powerlog

import org.apache.log4j.Level
import org.apache.log4j.Logger
class LogConfigController {
    def logService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [logConfigInstanceList: LogConfig.list(params), logConfigInstanceTotal: LogConfig.count()]
    }

    def create = {
        def logConfigInstance = new LogConfig()
        logConfigInstance.properties = params
        logConfigInstance.level="ERROR"
        return [logConfigInstance: logConfigInstance,appenders:Appender.list()]
    }

    def save = {
        def logConfigInstance = new LogConfig(params)
        logConfigInstance.type="Custom"
        if (logConfigInstance.save(flush: true)) {
            addLogLevel(logConfigInstance)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), logConfigInstance.id])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [logConfigInstance: logConfigInstance])
        }
    }

    def show = {
        def logConfigInstance = LogConfig.get(params.id)
        if (!logConfigInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), params.id])}"
            redirect(action: "list")
        }
        else {
            [logConfigInstance: logConfigInstance]
        }
    }

    def edit = {
        def logConfigInstance = LogConfig.get(params.id)
        if (!logConfigInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [logConfigInstance: logConfigInstance,appenders:Appender.list()]
        }
    }

    def update = {
        def logConfigInstance = LogConfig.get(params.id)
        if (logConfigInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (logConfigInstance.version > version) {
                    
                    logConfigInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'logConfig.label', default: 'LogConfig')] as Object[], "Another user has updated this LogConfig while you were editing")
                    render(view: "edit", model: [logConfigInstance: logConfigInstance])
                    return
                }
            }
            logConfigInstance.properties = params
            if(params.level=="OFF"){
                logConfigInstance?.appenders?.clear()
            }
            if (!logConfigInstance.hasErrors() && logConfigInstance.save(flush: true)) {
                
                changeLogLevel(logConfigInstance)
                changeAppender(logConfigInstance)
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), logConfigInstance.id])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [logConfigInstance: logConfigInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def logConfigInstance = LogConfig.get(params.id)
        if (logConfigInstance) {
            try {
                def logger=logConfigInstance.logger
                def level=logConfigInstance.level
                logConfigInstance.delete(flush: true)
                deletLogLevel(logger,level)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'logConfig.label', default: 'LogConfig'), params.id])}"
            redirect(action: "list")
        }
    }
    
    private changeLogLevel(LogConfig logConfig){
        def logger =logService.getLogger(logConfig)
        logger.level=Level."${logConfig.level}"
        log.info "${message(code: 'default.changeLogLevel.message',args:[logConfig.logger,logConfig.level])}"
               
    }
    
    private deletLogLevel(String logger,String level){
        Logger.rootLogger.getLogger(logger).level = null
        log.info "${message(code: 'default.deletLogLevel.message',args:[logger])}"
    }
    
    
    private addLogLevel(LogConfig logConfig){
        Logger.rootLogger.getLogger(logConfig.logger).level = Level."${logConfig.level}"
        log.info "${message(code: 'default.addLogLevel.message',args:[logConfig.logger,logConfig.level])}"
    }
    
    private changeAppender(LogConfig logConfig){
        def logger =logService.getLogger(logConfig)
        logger.removeAllAppenders()
        logConfig.appenders?.each{ appender ->
            logService.addAppenderForLogger(appender,logger)
        }
        log.info "${message(code: 'default.addAppender.message',args:[logConfig.logger,logConfig.appenders])}"
    }
}
