import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.cometd.server.BayeuxServerImpl
import org.cometd.server.CometdServlet
import org.cometd.bayeux.server.BayeuxServer
class PowerlogGrailsPlugin {
    // the plugin version
    def version = "0.1"
    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "1.3.7 > *"
    // the other plugins this plugin depends on
    def dependsOn = [:]
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
            "grails-app/views/error.gsp"
    ]

    // TODO Fill in these fields
    def author = "Your name"
    def authorEmail = ""
    def title = "Plugin summary/headline"
    def description = '''\\
                    Brief description of the plugin.
                    '''

    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/powerlog"

    def doWithWebDescriptor = { xml ->
        def conf = ConfigurationHolder.config.plugins.cometd
        if (!conf.continuationFilter.disable) {
            def filters = xml.'filter'
            filters[filters.size() - 1] + {
                filter {
                    'filter-name'('continuation')
                    'filter-class'('org.eclipse.jetty.continuation.ContinuationFilter')
                }
            }
            
            def filterMappings = xml.'filter-mapping'
            filterMappings[filterMappings.size() - 1] + {
                'filter-mapping' {
                    'filter-name'('continuation')
                    'servlet-name'('cometd')
                }
            }
        }
        
        def servlets = xml.'servlet'
        servlets[servlets.size() - 1] + {
            servlet {
                'servlet-name'('cometd')
                'servlet-class'(CometdServlet.class.name)
            }
        }

        def mappings = xml.'servlet-mapping'
        mappings[mappings.size() - 1] + {
            'servlet-mapping' {
                'servlet-name'('cometd')
                'url-pattern'('/cometd/*')
            }
        } 
    }

    def doWithSpring = {
        bayeux(org.cometd.server.BayeuxServerImpl) { bean ->
            bean.initMethod = 'start'
            bean.destroyMethod = 'stop'
        }

        bayeuxAttributeExporter(org.springframework.web.context.support.ServletContextAttributeExporter) {
            attributes = [(org.cometd.bayeux.server.BayeuxServer.ATTRIBUTE): ref('bayeux')]
        }
    }
    
    def doWithApplicationContext = { applicationContext ->
        
    }
}
