
<%@ page import="com.si.powerlog.Appender" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="powerlogMain" />
        <g:set var="entityName" value="${message(code: 'appender.label', default: 'Appender')}" />
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
                        
                           <g:sortableColumn property="name" title="${message(code: 'appender.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="pattern" title="${message(code: 'appender.pattern.label', default: 'Pattern')}" />
                        
                            <g:sortableColumn property="appenderClass" title="${message(code: 'appender.appenderClass.label', default: 'Appender Class')}" />
                        
                            <g:sortableColumn property="propertyJson" title="${message(code: 'appender.propertyJson.label', default: 'Property Json')}" />
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${appenderInstanceList}" status="i" var="appenderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                        
                            <td><g:link action="edit" id="${appenderInstance.id}">${fieldValue(bean: appenderInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: appenderInstance, field: "pattern")}</td>
                        
                            <td>${fieldValue(bean: appenderInstance, field: "appenderClass")}</td>
                        
                            <td>${fieldValue(bean: appenderInstance, field: "propertyJson")}</td>
                            <td>
                                <a id="deleteBtn_${appenderInstance.id}" dataid="${appenderInstance.id}" class="btn btn-danger" title="${message(code: 'default.button.delete.label', default: 'Delete')}" ><i class="icon-trash icon-white"></i></a>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="paginateButtons">
                    <g:paginate total="${appenderInstanceTotal}" />
                </div>
            </li>
        </ul>
        <g:javascript>
            $(function(){
                $("a[id^='deleteBtn_']").click(function(){
                    if(confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')){
                        deleteFunc("${request.contextPath}/appender/delete/"+$(this).attr("dataid"));
                    }
             });
            
            
            })
        </g:javascript>
    </body>
</html>
