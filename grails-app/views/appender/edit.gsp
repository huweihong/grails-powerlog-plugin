

<%@ page import="com.si.powerlog.Appender" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="powerlogMain" />
        <g:set var="entityName" value="${message(code: 'appender.label', default: 'Appender')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <ul class="main-list">
			<li class="main-header">
				<i class="icon-tasks"></i><g:message code="default.edit.label" args="[entityName]" />
				
			</li>
			<li class="main-content">
                <div class="body">
                    <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${appenderInstance}">
                    <div class="errors">
                        <g:renderErrors bean="${appenderInstance}" as="list" />
                    </div>
                    </g:hasErrors>
                    <g:form method="post" >
                        <g:hiddenField name="id" value="${appenderInstance?.id}" />
                        <g:hiddenField name="version" value="${appenderInstance?.version}" />
                        <div class="dialog">
                            <table class="table">
                                <tbody>
                                
                                    <tr class="prop">
                                        <td valign="top" class="name">
                                          <label for="name"><g:message code="appender.name.label" default="Name" /></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: appenderInstance, field: 'name', 'errors')}">
                                            <g:if test="${canChange}">
                                                <g:textField name="name" maxlength="100" value="${appenderInstance?.name}" />
                                            </g:if>
                                            <g:else>
                                                <g:textField name="name" maxlength="100" value="${appenderInstance?.name}" readonly="readonly"/>
                                            </g:else>
                                        </td>
                                    </tr>
                                
                                    <tr class="prop">
                                        <td valign="top" class="name">
                                          <label for="pattern"><g:message code="appender.pattern.label" default="Pattern" /></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: appenderInstance, field: 'pattern', 'errors')}">
                                            <g:textField name="pattern" maxlength="100" value="${appenderInstance?.pattern}" style="width:300px"/>
                                        </td>
                                    </tr>
                                
                                    <tr class="prop">
                                        <td valign="top" class="name">
                                          <label for="appenderClass"><g:message code="appender.appenderClass.label" default="Appender Class" /></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: appenderInstance, field: 'appenderClass', 'errors')}">
                                            <g:textField name="appenderClass" maxlength="100" value="${appenderInstance?.appenderClass}" style="width:300px"/>
                                        </td>
                                    </tr>
                                    <g:hiddenField name="propertyJson" value="${appenderInstance?.propertyJson}" />
                                    <tr class="prop">
                                        <td valign="top" class="name">
                                            <label for="template">${message(code: 'appender.propertyJson.label', default: '∆‰À˚ Ù–‘')}</label>
                                        </td>
                                        <td valign="top" class="value">
                                            <g:render template="properties" model="['appenderInstance':appenderInstance]" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="buttons">
                            <span class="button"><g:actionSubmit class="btn" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                            <span class="button"><g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </div>
                    </g:form>
                </div>
            </li>
         </ul>
    </body>
</html>
