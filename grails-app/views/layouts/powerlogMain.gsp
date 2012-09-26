<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'plugin.css',plugin:"powerlog")}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.min.css',plugin:"powerlog")}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'table.css',plugin:"powerlog")}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico',plugin:"powerlog")}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="jquery" />
        <g:javascript library="jquery.dataTables.min" />
        <g:javascript library="application" />
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="pull-left" href="http://www.grails.org"><img src="${resource(dir:'images',file:'grails_logo.png',plugin:'powerlog')}" height="35px" ></a>
                    
                        <div class="nav-collapse collapse">
                            <ul class="nav pull-right">
                                
                                    <li id="home">
                                        <g:link controller="log">
                                            在线日志
                                        </g:link>
                                    </li>
                                    <li id="appender"><g:link controller="appender" action="list">Appender配置</g:link></li>
                                    <li id="logconfig"><g:link controller="logConfig" action="list">日志配置</g:link></li>
                            </ul>
                        </div>
                    
                </div>
            </div>
        </div>
        <div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
                    <g:layoutBody />
                </div>
            </div>
        </div>
    </body>
</html>