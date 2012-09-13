package com.si.powerlog
import org.apache.log4j.Level
import org.apache.log4j.Logger
class AppenderController {
    
    def logService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [appenderInstanceList: Appender.list(params), appenderInstanceTotal: Appender.count()]
    }

    def create = {
        def appenderInstance = new Appender()
        appenderInstance.properties = params
        return [appenderInstance: appenderInstance]
    }

    def save = {
        def appenderInstance = new Appender(params)
        if (appenderInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'appender.label', default: 'Appender'), appenderInstance.id])}"
            redirect(action: "show", id: appenderInstance.id)
        }
        else {
            render(view: "create", model: [appenderInstance: appenderInstance])
        }
    }

    def show = {
        def appenderInstance = Appender.get(params.id)
        if (!appenderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appender.label', default: 'Appender'), params.id])}"
            redirect(action: "list")
        }
        else {
            [appenderInstance: appenderInstance]
        }
    }

    def edit = {
        def appenderInstance = Appender.get(params.id)
        if (!appenderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appender.label', default: 'Appender'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [appenderInstance: appenderInstance,canChange:logService.getLogConfigs(appenderInstance)?.size()==0]
        }
    }

    def update = {
        def appenderInstance = Appender.get(params.id)
        if (appenderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (appenderInstance.version > version) {
                    
                    appenderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'appender.label', default: 'Appender')] as Object[], "Another user has updated this Appender while you were editing")
                    render(view: "edit", model: [appenderInstance: appenderInstance])
                    return
                }
            }
            appenderInstance.properties = params
            if (!appenderInstance.hasErrors() && appenderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'appender.label', default: 'Appender'), appenderInstance.id])}"
                changeAppender(appenderInstance)
                redirect(action: "list", id: appenderInstance.id)
            }
            else {
                render(view: "edit", model: [appenderInstance: appenderInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appender.label', default: 'Appender'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def appenderInstance = Appender.get(params.id)
        if (appenderInstance) {
            try {
                logService.deleteAppender(appenderInstance)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'appender.label', default: 'Appender'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'appender.label', default: 'Appender'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'appender.label', default: 'Appender'), params.id])}"
            redirect(action: "list")
        }
    }
    private  changeAppender(Appender appender){
        logService.getLogConfigs(appender).each{ logConfig ->
            def logger=logService.getLogger(logConfig)
            logger.removeAppender(appender.name)
            logService.addAppenderForLogger(appender,logger)
        }
    }
}
