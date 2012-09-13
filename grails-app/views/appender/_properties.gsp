<%@ page import="grails.converters.JSON" %>
<g:javascript library="jquery" />
<g:javascript library="jquery.dataTables.min" />
<g:javascript library="application" />
<div>
    <fieldset>
        <legend>${message(code: 'appender.propertyJson.label', default: '其他属性')}</legend>
        <p><button id="newProperty" href="" class="btn" >${message(code: 'default.button.createConfig.label', default: '新增属性')}</button></p>
        <table id="properties">
            <thead>
                <tr>
                    <th>名称</th>
                    <th>值</th>
                    <th>${message(code: 'default.button.edit.label', default: '配置项')}</th>
                    <th>${message(code: 'default.button.delete.label', default: '配置项')}</th>
                </tr>
            <thead>
            <tbody>
                <g:if test="${appenderInstance.propertyJson}">
                    <g:each in="${JSON.parse(appenderInstance.propertyJson).sort({it.key})}" status="j" var="json">
                        <tr>												
                            <td>${json.key}</td>
                            <td>${json.value}</td>
                            <td><a class="edit" href="">Edit</a></td>
                            <td><a class="delete" href="">Delete</a></td>
                        </tr>
                    </g:each>
                </g:if>
            </tbody>
        </table>
    </fieldset>
</div>
<g:javascript>
    $(function(){
        var oTable = $('#properties').dataTable({
                        "bPaginate": false,
                        "bLengthChange": false,
                        "bFilter": true,
                        "bSort": false,
                        "bInfo": false,
                        "bAutoWidth": false,
                        "oLanguage": {
                            "sEmptyTable":"请添加配置项！",
                            
                         }
                        
                    } );
        createJsonStr(oTable);
        var nEditing = null;

        $('#properties a.edit').live('click', function (e) {
            e.preventDefault();
             
            /* Get the row as a parent of the link that was clicked on */
            var nRow = $(this).parents('tr')[0];
            
            if ( nEditing !== null && nEditing != nRow ) {
                /* A different row is being edited - the edit should be cancelled and this row edited */
                restoreRow( oTable, nEditing );
                editRow( oTable, nRow );
                nEditing = nRow;
            }
            else if ( nEditing == nRow && this.innerHTML == "Save" ) {
                /* This row is being edited and should be saved */
                nEditing=saveRow( oTable, nEditing );
                
            }
            else {
                /* No row currently being edited */
                editRow( oTable, nRow );
                nEditing = nRow;
            }
        } );
        
        $('#newProperty').click( function (e) {
            e.preventDefault();
             
            var aiNew = oTable.fnAddData( [ '', '','<a class="edit" href="">Edit</a>', '<a class="delete" href="">Delete</a>' ] );
            var nRow = oTable.fnGetNodes( aiNew[0] );
            editRow( oTable, nRow );
            nEditing = nRow;
        } );
    
        
        $('#properties a.delete').live('click', function (e) {
            if(confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')){
                e.preventDefault();
                 
                var nRow = $(this).parents('tr')[0];
                var nRow = $(this).parents('tr')[0];
                oTable.fnDeleteRow( nRow );
                createJsonStr( oTable )
            }
        } );
    });
</g:javascript>