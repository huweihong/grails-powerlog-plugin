
import com.si.powerlog.LogConfig
import org.apache.log4j.Logger
import org.apache.log4j.Level
import org.apache.log4j.PatternLayout
import grails.converters.JSON 
class PowerlogBootStrap {
    def init = { servletContext ->
        def rootLogger=Logger.rootLogger
        if(LogConfig.count()==0){
            new LogConfig(logger:"rootLogger",level:"${rootLogger.level}",type:"Default").save()
                
            rootLogger.loggerRepository.currentLoggers.toList().findAll { it.level }.sort { it.name }.each{ logger ->
                new LogConfig(logger:logger.name,level:"${rootLogger.level}",type:"Default").save()
            }
        }else{
            LogConfig.list().each{ logConfig ->
                def logger
                switch(logConfig.logger){
                    case "rootLogger":
                        rootLogger.level= Level."${logConfig.level}"
                        logger=Logger.rootLogger
                        break
                    default:
                        logger=Logger.rootLogger.getLogger(logConfig.logger)
                        logger.level = Level."${logConfig.level}"
                        break
                }
                logger.removeAllAppenders()
                logConfig.appenders?.each{ appender ->
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
        }
    }

    def destroy = {}
}
