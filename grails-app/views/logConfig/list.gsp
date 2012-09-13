
<%@ page import="com.si.powerlog.LogConfig" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'logConfig.label', default: 'LogConfig')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="logger" title="${message(code: 'logConfig.logger.label', default: 'Logger')}" />
                        
                            <g:sortableColumn property="level" title="${message(code: 'logConfig.level.label', default: 'Level')}" />
                            
                            <g:sortableColumn property="type" title="${message(code: 'logConfig.type.label', default: 'Type')}" />
                            
                            <g:sortableColumn property="appenders" title="${message(code: 'logConfig.appenders.label', default: 'Appenders')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logConfigInstanceList}" status="i" var="logConfigInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="edit" id="${logConfigInstance.id}">${fieldValue(bean: logConfigInstance, field: "logger")}</g:link></td>
                        
                            <td>${fieldValue(bean: logConfigInstance, field: "level")}</td>
                            
                            <td>${fieldValue(bean: logConfigInstance, field: "type")}</td>
                            
                            <td>${logConfigInstance?.appenders}</td>
                        
                        </tr>
                    </g:each>
                    </tbody> 
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${logConfigInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
