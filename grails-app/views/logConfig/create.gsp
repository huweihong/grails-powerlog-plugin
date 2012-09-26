

<%@ page import="com.si.powerlog.LogConfig" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="powerlogMain" />
        <g:set var="entityName" value="${message(code: 'logConfig.label', default: 'LogConfig')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <ul class="main-list">
			<li class="main-header">
				<i class="icon-tasks"></i><g:message code="default.create.label" args="[entityName]" />
				
			</li>
			<li class="main-content">
        
                <div class="body">
                  
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
                            <table class="table">
                                <tbody>
                                
                                    <tr class="prop">
                                        <td valign="top" class="name">
                                            <label for="logger"><g:message code="logConfig.logger.label" default="Logger" /></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: logConfigInstance, field: 'logger', 'errors')}">
                                            <g:textField name="logger" maxlength="200" value="${logConfigInstance?.logger}" style="width:300px"/>
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
                            <g:submitButton name="create" class="btn" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                            <g:link class="btn" controller="logConfig" >${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
                        </div>
                    </g:form>
                </div>
           </li>
       </ul>
    </body>
</html>
