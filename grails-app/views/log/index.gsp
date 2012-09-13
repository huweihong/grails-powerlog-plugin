<html>
    <head>
        <title>Welcome to Powerlog</title>
        <meta name="layout" content="main" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'plugin.css')}" />
        <g:javascript library="jquery" />
        <g:javascript library="application" />
        <script>cometdServerUrl = "${request.contextPath}/cometd"; </script>
    </head>
    <body > 
        <div class="navigation">
            <botton class="btn" id="setUp">设置</botton>
            <botton class="btn" id="clearAll">清空日志</botton>
            <botton class="btn" id="viewAll">查看所有有效Logger</botton>
        </div>
        <div class="logTable"> 
            <textarea name="result" id="result" readonly="true" wrap="off" rows="30"
                    style="background-color:#000000;cursor:default;" class="inputStyle" ></textarea>
               
        </div> 
        <g:javascript>
            $(function(){
                $("#result").val("");
                $("#clearAll").click(function(){
                    $("#result").val("");
                });
                $("#result").css("height",pageHeight()*0.75+"px");
                $("#viewAll").click(function(){
                    $.ajax({
                        url:"${request.contextPath}/log/showAllLogger",
                        type: "GET"
                    });
                });
                $("#setUp").click(function(){
                    window.location="${request.contextPath}/logConfig/list";
                })
            });
        </g:javascript>
        <g:javascript library="org/cometd" />
        <g:javascript library="jquery.cometd" />
        <g:javascript library="cometd-subscriptions" />
        <g:javascript library="cometDInit" />
        <g:javascript library="loggerInit" />
    </body> 
</html>