

<%@ page import="com.si.powerlog.LogConfig" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:javascript library="jquery" />
        <g:set var="entityName" value="${message(code: 'logConfig.label', default: 'LogConfig')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${logConfigInstance.type!='Default'}">
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:if>
                </div>
            </g:form>
        </div>
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
