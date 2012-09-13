

<%@ page import="com.si.powerlog.LogConfig" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'logConfig.label', default: 'LogConfig')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${logConfigInstance}">
            <div class="errors">
                <g:renderErrors bean="${logConfigInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="logger"><g:message code="logConfig.logger.label" default="Logger" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: logConfigInstance, field: 'logger', 'errors')}">
                                    <g:textField name="logger" maxlength="200" value="${logConfigInstance?.logger}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="level"><g:message code="logConfig.level.label" default="Level" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: logConfigInstance, field: 'level', 'errors')}">
                                    <g:select name="level" from="${logConfigInstance.constraints.level.inList}" value="${logConfigInstance?.level}" valueMessagePrefix="logConfig.level"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="appenders"><g:message code="logConfig.appenders.label" default="Appenders" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: logConfigInstance, field: 'appenders', 'errors')}">
                                    <g:select name="appenders" from="${appenders}" multiple="yes" optionKey="id" size="5" style="width:150px" value="${logConfigInstance?.appenders*.id}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
