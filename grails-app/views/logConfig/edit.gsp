

<%@ page import="com.si.powerlog.LogConfig" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="powerlogMain" />
        <g:javascript library="jquery" />
        <g:set var="entityName" value="${message(code: 'logConfig.label', default: 'LogConfig')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <ul class="main-list">
			<li class="main-header">
				<i class="icon-tasks"></i><g:message code="default.edit.label" args="[entityName]" />
				<span class="viewMore btn-group">
                    <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                    <g:link class="btn btn-primary" action="create"><i class="icon-plus icon-white"></i><g:message code="default.new.label" args="[entityName]" /></g:link>
                </span>
			</li>
			<li class="main-content">
                
                <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${logConfigInstance}">
                <div class="errors">
                    <g:renderErrors bean="${logConfigInstance}" as="list" />
                </div>
                </g:hasErrors>
                <g:form method="post" >
                    <g:hiddenField name="id" value="${logConfigInstance?.id}" />
                    <g:hiddenField name="version" value="${logConfigInstance?.version}" />
                    <div class="dialog">
                        <table class="table">
                            <tbody>
                            
                                <tr class="prop">
                                    <td valign="top" class="name">
                                      <label for="logger"><g:message code="logConfig.logger.label" default="Logger" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: logConfigInstance, field: 'logger', 'errors')}">
                                        <g:textField name="logger" maxlength="200" value="${logConfigInstance?.logger}" style="width:300px" />
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
                                      <label for="appender"><g:message code="logConfig.appenders.label" default="Appenders" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: logConfigInstance, field: 'appenders', 'errors')}">
                                        <g:select name="appenders" from="${appenders}" multiple="yes" optionKey="id" size="5" style="width:150px" value="${logConfigInstance?.appenders*.id}" />
                                    </td>
                                </tr>
                            </tbody> 
                        </table>
                    </div>
                    <div class="buttons">
                        <g:actionSubmit class="btn" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                        <g:if test="${logConfigInstance.type!='Default'}">
                            <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:if>
                    </div>
                </g:form>
            </li>
        </ul>
        <g:javascript>
            $(function(){
                $("#level").change(function(){
                    if($(this).val()=="OFF"){
                        $("#appenders").val("");
                        $("select[name=appenders]  option:selected").each(function(){
                            $(this).attr("selected", true)
                        });
                    }
                });
            })
        </g:javascript>
    </body>
</html>
