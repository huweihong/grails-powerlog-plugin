grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {
        mavenCentral()
    }
    dependencies {
        def cometdVer = '2.3.1'
        compile(group: 'org.cometd.java', name: 'cometd-java-server', version: cometdVer) {
            excludes 'servlet-api'
        }
        compile group: 'org.cometd.java', name: 'bayeux-api', version: cometdVer
           test group: 'org.cometd.java', name: 'cometd-java-client', version: cometdVer
    }
}
