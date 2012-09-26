
<%@ page import="com.si.powerlog.LogConfig" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="powerlogMain" />
        <g:set var="entityName" value="${message(code: 'logConfig.label', default: 'LogConfig')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <ul class="main-list">
			<li class="main-header">
				<i class="icon-tasks"></i><g:message code="default.list.label" args="[entityName]" />
				<span class="viewMore btn-group">
                    <g:link class="btn btn-primary" action="create" ><i class="icon-plus icon-white"></i><g:message code="default.new.label" args="[entityName]" /></g:link>
                        
                   
                </span>
			</li>
			<li class="main-content">
                <table class="list">
                    <thead>
                        <tr>
                            <g:sortableColumn property="logger" title="${message(code: 'logConfig.logger.label', default: 'Logger')}" />
                        
                            <g:sortableColumn property="level" title="${message(code: 'logConfig.level.label', default: 'Level')}" />
                            
                            <g:sortableColumn property="type" title="${message(code: 'logConfig.type.label', default: 'Type')}" />
                            
                            <g:sortableColumn property="appenders" title="${message(code: 'logConfig.appenders.label', default: 'Appenders')}" />
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logConfigInstanceList}" status="i" var="logConfigInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="edit" id="${logConfigInstance.id}">${fieldValue(bean: logConfigInstance, field: "logger")}</g:link></td>
                        
                            <td>${fieldValue(bean: logConfigInstance, field: "level")}</td>
                            
                            <td>${fieldValue(bean: logConfigInstance, field: "type")}</td>
                            
                            <td>${logConfigInstance?.appenders}</td>
                            <td>
                                <g:if test="${logConfigInstance.type!='Default'}">
                                    <a id="deleteBtn_${logConfigInstance.id}" dataid="${logConfigInstance.id}" class="btn btn-danger" title="${message(code: 'default.button.delete.label', default: 'Delete')}" ><i class="icon-trash icon-white"></i></a>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                    </tbody> 
                </table>
                <div class="paginateButtons">
                    <g:paginate total="${logConfigInstanceTotal}" />
                </div>
            </li>
           </ul>
        <g:javascript>
            $(function(){
                $("a[id^='deleteBtn_']").click(function(){
                    if(confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')){
                        deleteFunc("${request.contextPath}/logConfig/delete/"+$(this).attr("dataid"));
                    }
             });
            
            
            })
        </g:javascript>
       
    </body>
</html>
