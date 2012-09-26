<%@ page import="grails.converters.JSON" %>
<div>
    <fieldset>
        <p><button id="newProperty" href="" class="btn btn-warning" >${message(code: 'default.button.createConfig.label', default: '新增属性')}</button></p>
        <table id="properties" class="list">
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
                            <td><a class="edit btn" href="">${message(code: 'default.property.button.edit.label', default: 'Edit Property')}</a></td>
                            <td><a class="delete btn btn-danger" href="">${message(code: 'default.property.button.delete.label', default: 'Delete Property')}</a></td>
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
                        "bFilter": false,
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
                editRow( oTable, nRow ,"${message(code: 'default.property.button.save.label', default: 'Save Property')}");
                nEditing = nRow;
            }
            else if ( nEditing == nRow && this.innerHTML == "${message(code: 'default.property.button.save.label', default: 'Save Property')}" ) {
                /* This row is being edited and should be saved */
                nEditing=saveRow( oTable, nEditing ,"${message(code: 'default.property.button.edit.label', default: 'Edit Property')}" );
                
            }
            else {
                /* No row currently being edited */
                editRow( oTable, nRow ,"${message(code: 'default.property.button.save.label', default: 'Save Property')}");
                nEditing = nRow;
            }
        } );
        
        $('#newProperty').click( function (e) {
            e.preventDefault();
             
            var aiNew = oTable.fnAddData( [ '', '',"<a class='btn' href=''>${message(code: 'default.property.button.edit.label', default: 'Edit Property')}</a>", "<a class='btn btn-danger' href=''>${message(code: 'default.property.button.delete.label', default: 'Delete Property')}</a>" ] );
            var nRow = oTable.fnGetNodes( aiNew[0] );
            editRow( oTable, nRow ,"${message(code: 'default.property.button.save.label', default: 'Save Property')}");
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