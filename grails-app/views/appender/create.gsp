
<%@ page import="grails.converters.JSON" %>
<%@ page import="com.si.powerlog.Appender" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:javascript library="jquery" />
        <g:javascript library="jquery.dataTables.min" />
        <g:javascript library="application" />
        <g:set var="entityName" value="${message(code: 'appender.label', default: 'Appender')}" />
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
            <g:hasErrors bean="${appenderInstance}">
            <div class="errors">
                <g:renderErrors bean="${appenderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="appender.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appenderInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${appenderInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pattern"><g:message code="appender.pattern.label" default="Pattern" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appenderInstance, field: 'pattern', 'errors')}">
                                    <g:textField name="pattern" maxlength="100" value="${appenderInstance?.pattern}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="appenderClass"><g:message code="appender.appenderClass.label" default="Appender Class" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appenderInstance, field: 'appenderClass', 'errors')}">
                                    <g:textField name="appenderClass" maxlength="100" value="${appenderInstance?.appenderClass}" />
                                </td>
                            </tr>
                            <g:hiddenField name="propertyJson" value="${appenderInstance?.propertyJson}" />
                        </tbody>
                    </table>
                    <g:render template="properties" model="['appenderInstance':appenderInstance]" />
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
        
    </body>
</html>
