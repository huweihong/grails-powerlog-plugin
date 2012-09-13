
<%@ page import="com.si.powerlog.Appender" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appender.label', default: 'Appender')}" />
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
                        
                           <g:sortableColumn property="name" title="${message(code: 'appender.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="pattern" title="${message(code: 'appender.pattern.label', default: 'Pattern')}" />
                        
                            <g:sortableColumn property="appenderClass" title="${message(code: 'appender.appenderClass.label', default: 'Appender Class')}" />
                        
                            <g:sortableColumn property="propertyJson" title="${message(code: 'appender.propertyJson.label', default: 'Property Json')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${appenderInstanceList}" status="i" var="appenderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                        
                            <td><g:link action="edit" id="${appenderInstance.id}">${fieldValue(bean: appenderInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: appenderInstance, field: "pattern")}</td>
                        
                            <td>${fieldValue(bean: appenderInstance, field: "appenderClass")}</td>
                        
                            <td>${fieldValue(bean: appenderInstance, field: "propertyJson")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${appenderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
