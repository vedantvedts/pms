<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIDocumentShortCodes"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" /> 
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<style type="text/css">
.left {
	text-align: left;
}
.center {
	text-align: center;
}
.right {
	text-align: right;
}
	
.customtable{
	border-collapse: collapse;
	width: 100%;
	margin: 1.5rem 0.5rem 0.5rem 0.5rem;
	overflow-y: auto; 
	overflow-x: auto;  
}
.customtable th{
	border: 1px solid #0000002b; 
	padding: 10px;
		background-color: #2883c0;
}
.customtable td{
	border: 1px solid #0000002b; 
	padding: 5px;
}

.customtable thead {
	text-align: center;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
}

.table-wrapper {
    max-height: 600px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}


</style>
</head>
<body>
<%
	String shortCodeType = (String)request.getAttribute("shortCodeType");
	String docId = (String)request.getAttribute("docId");
	String docType = (String)request.getAttribute("docType");
	String documentNo = (String)request.getAttribute("documentNo");

	List<IGIDocumentShortCodes> shortCodesList = (List<IGIDocumentShortCodes>)request.getAttribute("shortCodesList");
	List<IGIDocumentShortCodes> shortCodesListByType = shortCodesList.stream().filter(e -> e.getShortCodeType().equalsIgnoreCase(shortCodeType)).collect(Collectors.toList());
	
	List<Object[]> shortCodesLinkedList = (List<Object[]>)request.getAttribute("shortCodesLinkedList");
	List<Object[]> shortCodesLinkedListByType = shortCodesLinkedList.stream().filter(e -> e[3].toString().equalsIgnoreCase(shortCodeType)).collect(Collectors.toList());
	
	List<Long> shortCodesLinkedListByTypeIds = shortCodesLinkedListByType.stream().map(e -> Long.parseLong(e[0].toString())).collect(Collectors.toList());
	
	List<IGIDocumentShortCodes> shortCodesListFiltered = shortCodesListByType.stream().filter(e -> !shortCodesLinkedListByTypeIds.contains(e.getShortCodeId())).collect(Collectors.toList());

	String shortCodeTypeFullName = shortCodeType.equalsIgnoreCase("A")?"Abbreviation":"Acronym";
%>
	
	<% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
            </div>
        </div>
    <% } %>
    
    
    <div class="container-fluid">
       
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-9" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      <%=shortCodeTypeFullName %> Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
               			<button type="button" class="btn btn-sm submit" data-toggle="modal" data-target="#addNewShortCodesModal">
               				ADD NEW <%=shortCodeTypeFullName %>S
               			</button>
                	</div>
                    <div class="col-md-1" align="right">
                        <a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;"
                        <%if(docType.equalsIgnoreCase("A")) {%>
                        	href="IGIDocumentDetails.htm?igiDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("B")) {%>
                        	href="ICDDocumentDetails.htm?icdDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("C")) {%>
                        	href="IRSDocumentDetails.htm?irsDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("D")) {%>
                        	href="IDDDocumentDetails.htm?iddDocId=<%=docId %>"
                        <%} %>
                         >Back</a>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        		<div class="row">
        			<div class="ml-2 mr-2" style="width: 30%;">
        				<div class="table-responsive table-wrapper">
        					<input type="text" id="searchBar" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
        					<br>
        					<table class="customtable" id="dataTable">
	        					<thead class="center">
		        					<tr>
		        						<th>SN</th>	
		        						<th><%=shortCodeTypeFullName %></th>	
		        						<th>Action</th>	
		        					</tr>
	        					</thead>
	        					<tbody>
	        						<%if(shortCodesLinkedListByType!=null && shortCodesLinkedListByType.size()>0) {
	        							int slno = 0;
	        							for(Object[] obj : shortCodesLinkedListByType) {
	        						%>
	        							<tr>
	        								<td class="center"><%=++slno %></td>
	        								<td><%=obj[2]+" ("+obj[1]+")" %></td>
	        								<td class="center">
	        									<form action="IGIShortCodesLinkedDelete.htm" method="POST" id="inlineapprform<%=slno%>">
											        <button type="submit" class="btn btn-sm" onclick="return confirm('Are you sure to delete?')">
											            <img src="view/images/delete.png" alt="Delete">
											        </button>
											        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											        <input type="hidden" name="shortCodeLinkedId" value="<%=obj[5] %>">
											        <input type="hidden" name="igiDocId" value="<%=docId%>">	
													<input type="hidden" name="docId" value="<%=docId%>">	 
													<input type="hidden" name="docType" value="<%=docType%>">
													<input type="hidden" name="documentNo" value="<%=documentNo%>">
													<input type="hidden" name="shortCodeType" value="<%=shortCodeType%>">
											    </form>
	        								</td>
	        							</tr>
	        						<%} } else {%>
	        							<tr>
	        								<td colspan="3" class="center">No Data Available</td>
	        							</tr>
	        						<%} %>
	        					</tbody>
        					</table>
        				</div>
        			</div>
        			<div class="ml-2 mr-2" style="width: 0.1%; border-left: 1px solid #000;"></div>
        			
        			<div class="ml-2 mr-2" style="width: 67%;">
		        		<%if (shortCodesListByType != null && shortCodesListByType.size()>0) { %>
		        			<%if(shortCodesListFiltered.size()>0) {%>
			        			<form action="IGIShortCodesDetailsSubmit.htm" method="post">
					        		<div class="table-wrapper">
										
						        		<input type="text" id="searchBar2" class="search-bar2 form-control" placeholder="Search..." style="float: right;width: auto;" />
		        						<br>
										
						        		<table class="customtable" id="dataTable2">
						        			<thead class="center">
							        			<tr>
										            <th>
										            	<input type="checkbox" class="" id="selectAll1" onclick="selectAllShortCodes('1')" >
										            	Select 
										            </th>
										            <th><%=shortCodeTypeFullName %></th>
										            <th style="border: 0px;background-color: transparent;">&nbsp;</th>
										           
										            <%if(shortCodesListFiltered.size()>1) {%>
											            <th>
											            	<input type="checkbox" class="" id="selectAll2" onclick="selectAllShortCodes('2')">
											            	Select 
											            </th>
											            <th><%=shortCodeTypeFullName %></th>
											            <th style="border: 0px;background-color: transparent;">&nbsp;</th>
										            <%} %>
										            
										            <%if(shortCodesListFiltered.size()>2) {%>
											            <th>
											            	<input type="checkbox" class="" id="selectAll3" onclick="selectAllShortCodes('3')" >
											            	Select 
											            </th>
											            <th><%=shortCodeTypeFullName %></th>
											            <th style="border: 0px;background-color: transparent;">&nbsp;</th>
										            <%} %>
										            
										            <%-- <%if(shortCodesListFiltered.size()>3) {%>
											            <th>
											            	<input type="checkbox" class="" id="selectAll4" onclick="selectAllShortCodes('4')" >
											            	Select 
											            </th>
											            <th><%=shortCodeTypeFullName %></th>
										            <%} %> --%>
										        </tr>	
						        			</thead>
									        
									        <% int rowcount=1; 
									        	for (int i = 0; i < shortCodesListFiltered.size(); i++) {
									        		++rowcount;	 
									        %>
									        	<!-- Start a new row for the first column -->
										        <%if (i % 3 == 0) { rowcount=1;%> <tr> <%} %>
										        <%IGIDocumentShortCodes shortCodes = shortCodesListFiltered.get(i); %>
										        	<td class="center">
										        		<input type="checkbox" class="shortcode_<%=rowcount %>" name="shortCodeId" value="<%=shortCodes.getShortCodeId()%>">
										        	</td>
									            	<td>
									            		<%=shortCodes.getFullName()+" ("+shortCodes.getShortCode()+")" %>
									            	</td>
									            	<td style="border: 0px;">&nbsp;</td>
									        		<%if ((i + 1) % 3 == 0) { %>
									             		</tr>
									             <%} } %>
									        <% // Close the last row if it is not complete
								                if (shortCodesListFiltered.size() % 3 != 0) {
								                    out.print("</tr>");
								                } %>
									    </table>
									</div>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" class="shortCodeType" name="shortCodeType" value="<%=shortCodeType%>" >
									<input type="hidden" name="igiDocId" value="<%=docId%>">	
									<input type="hidden" name="docId" value="<%=docId%>">	 
									<input type="hidden" name="docType" value="<%=docType%>">	
									<input type="hidden" name="documentNo" value="<%=documentNo%>">			
									<div align="center" class="mt-2">
										<button type="submit" class="btn btn-sm submit"  onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
									</div>
								</form>	
							<%} else {%>
								
							<%} %>	 
						<% }  else { %>
							<div id="excelformdiv">
			        			<form action ="IGIDocShortCodesExcelUpload.htm" method="post" id="excelForm" enctype="multipart/form-data">
			      					<div class="row">
										<div class="col-md-3">
											<input class="form-control" type="file" id="excel_file" name="filename" required="required"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">						
										</div>
										<div class="col-md-4">
											<span class="text-primary">Download format</span>
											<button class="btn btn-sm" type="submit" formaction="IGIDocShortCodesExcelDownload.htm" formmethod="post" formnovalidate="formnovalidate" ><i class="fa fa-file-excel-o" aria-hidden="true" style="color: green;"></i></button>
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-12">
											<div style="overflow-y:auto" id="myDiv">
												<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1" style="overflow: scroll;"> </table>
											</div>
										</div>
									</div>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
									<input type="hidden" class="shortCodeType" name="shortCodeType" value="<%=shortCodeType%>" >
									<input type="hidden" name="igiDocId" value="<%=docId%>">	
									<input type="hidden" name="docId" value="<%=docId%>">	 
									<input type="hidden" name="docType" value="<%=docType%>">	
									<input type="hidden" name="documentNo" value="<%=documentNo%>">			
									<div align="center" class="mt-2" id="uploadDiv" style="display:none;">
										<button type="submit" class="btn btn-sm btn-info btn-req"  onclick="return confirm('Are you sure to submit?')">Upload</button>
									</div>
								</form>
							</div>
						<% } %>
					</div>
				</div>
        	</div>
        </div>
	</div>

	<!-- ----------------------------------------------- Add New Short Codes Modal --------------------------------------------------------------- -->
	<div class="modal fade bd-example-modal-lg" id="addNewShortCodesModal" tabindex="-1" role="dialog" aria-labelledby="addNewShortCodesModal" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width:100%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">Add New <%=shortCodeTypeFullName %>s</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<form action="IGINewShortCodesDetailsSubmit.htm" method="POST" id="myform">
									<table id="shortcodestable" class="table table-bordered shortcodestable" style="width: 100%;" >
										<thead class="center" style="background: #055C9D;color: white;">
											<tr>
												<th width="20%"><%=shortCodeTypeFullName %></th>
												<th width="70%">Full form</th>
												<td width="10%">
													<button type="button" class=" btn btn_add_shortcodes "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
												</td>
											</tr>
										</thead>
										<tbody id="activityTableBody">
											<tr class="tr_clone_shortcodes">
												<td>
													<input type="text"class="form-control shortCode" name="shortCode" id="shortCode_1" maxlength="50" onchange="checkDuplicateShortCode('1')" required="required">
												</td>	
												<td>
													<input type="text"class="form-control" name="fullName" placeholder="Enter Maximum 100 characters" maxlength="100" required="required">
												</td>	
												<td class="center">
													<button type="button" class=" btn btn_rem_shortcodes" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
												</td>		
											</tr>	
										</tbody>
									</table>
									<input type="hidden" class="shortCodeType" name="shortCodeType" id="shortCodeType" value="<%=shortCodeType%>" >
									<input type="hidden" name="igiDocId" value="<%=docId%>">	
									<input type="hidden" name="docId" value="<%=docId%>">	 
									<input type="hidden" name="docType" value="<%=docType%>">
									<input type="hidden" name="documentNo" value="<%=documentNo%>">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									
									<div class="center mt-2">
										<button type="submit"class="btn btn-sm submit" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
									</div>
								</form>
							</div>
						</div>
     				</div>
     			</div>
     		</div>
		</div>
	</div>				
	<!-- ----------------------------------------------- Add New Short Codes Modal End-------------------------------------------------------- -->	
<script type="text/javascript">

$(document).ready(function () {
    $('#searchBar').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        $('#dataTable tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
        });
    });
    $('#searchBar2').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        $('#dataTable2 tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
        });
    });
});


/* Cloning (Adding) the table body rows for Add New Short Codes */
 
var cloneCount = 1;
$("#shortcodestable").on('click','.btn_add_shortcodes' ,function() {
	
	var $tr = $('.tr_clone_shortcodes').last('.tr_clone_shortcodes');
	var $clone = $tr.clone();
	$tr.after($clone);
	++cloneCount;
	$clone.find(".shortCode").attr("id", 'shortCode_' + cloneCount).attr("onchange", 'checkDuplicateShortCode(\'' + cloneCount + '\')');
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Add New Short Codes */
$("#shortcodestable").on('click','.btn_rem_shortcodes' ,function() {
	
var cl=$('.tr_clone_shortcodes').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_shortcodes');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});

//Check Duplicate
function checkDuplicateShortCode(rowCount) {
	var shortCode = $('#shortCode_'+rowCount).val();
	var shortCodeType = $('#shortCodeType').val();
	
	$.ajax({
		type : "GET",
		url : "DuplicateShortCodeCheck.htm",	
		datatype : 'json',
		data : {
			shortCode : shortCode,				
			shortCodeType : shortCodeType.trim(),				
		},
		success : function(result) {
			var ajaxresult = JSON.parse(result);
			
			if(ajaxresult>0){
				alert('Short Code Already Exists');
				$('#shortCode_'+rowCount).val('');
				event.preventDefault();
				return false;
			}
			
		}
	});
}

//Initialize all checkboxes and select-all checkboxes as checked
$('.shortcode_1, .shortcode_2, .shortcode_3, .shortcode_4').prop('checked', true);
$('#selectAll1, #selectAll2, #selectAll3, #selectAll4').prop('checked', true);

// Function to handle select-all logic
function selectAllShortCodes(columnCount) {
    var isChecked = $('#selectAll' + columnCount).prop('checked');
    $('.shortcode_' + columnCount).prop('checked', isChecked);
}

// Function to handle individual shortcode click logic
function updateSelectAllStatus(columnCount) {
    var checkedCount = $('.shortcode_' + columnCount + ':checked').length;
    var totalCount = $('.shortcode_' + columnCount).length;
    $('#selectAll' + columnCount).prop('checked', checkedCount === totalCount);
}

// Attach event listeners dynamically
[1, 2, 3, 4].forEach(function(columnCount) {
    $('#selectAll' + columnCount).change(function() {
        selectAllShortCodes(columnCount);
    });

    $('.shortcode_' + columnCount).click(function() {
        updateSelectAllStatus(columnCount);
    });
});


const excel_file = document.getElementById('excel_file');

 if(excel_file!=null && excel_file!="") {
	excel_file.addEventListener('change', (event) => {
	   
		var shortCodeTypeFull = '<%=shortCodeTypeFullName%>';
		
		console.log('shortCodeTypeFull: ', shortCodeTypeFull);
		$('#ExistingAbb').hide();	
		var reader = new FileReader();
	    reader.readAsArrayBuffer(event.target.files[0]);
	
	    reader.onload = function (event){
	    
	    	var data = new Uint8Array(reader.result);
	    	
	    	var work_book = XLSX.read(data, {type:'array'});
	    	
	    	 var sheet_name = work_book.SheetNames;
	    	
	    	var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]],{header:1});
	    	
	    	const code = [];
	    	const gname = [];
	    	const abbreviationname1 = [];
	    	var checkExcel = 0;
	    	
	    	if(sheet_data.length > 0){
	    		var table_output = '<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1" style="overflow: scroll;" > '
	    		
	    		table_output +='<thead><tr><th style=" text-align: center;width:10%;">SN</th><th style="text-align:center;width:30%;">'+shortCodeTypeFull+'</th><th style="text-align:center;">Full form</th></tr>'
	    		
		    		for(var row = 0; row < sheet_data.length ; row ++){
	    			table_output += '<tbody><tr>'
	    			
	    			if(row>0){
	    				table_output += '<td class="center">'+row+'</td>';}
	    				for(var cell = 0; cell <3;cell++)
	    				{
	    					
	    					if(row==0){
	    						if(cell==1 && shortCodeTypeFull != sheet_data[row][cell]){  checkExcel++;}
	            				if(cell==2 && "Full form" != sheet_data[row][cell]){  checkExcel++;}
	            				console.log(sheet_data[row][cell]+cell)
	            				
	            			}	
	    				
	    				if(row>0 && cell == 2){
	    			
	    					table_output+='<td>'+sheet_data[row][cell]+'</td>';
	    					var abbreviationnames = ""+sheet_data[row][cell]+"";
	    					
	    					if(abbreviationnames.trim().length>250){
	    						gname.push(row);
	    					}
	    					if(abbreviationnames.trim()=='' || abbreviationnames.trim()=='undefined'){abbreviationname1.push(row);}	
	    					
	    				}
	    				if(row>0 && cell == 1){
	    					table_output += '<td class="center">'+sheet_data[row][cell]+'</td>' 
	    					var x = ""+sheet_data[row][cell]+"";
	    					
	    					if(x=='' ){
	    						code.push(row)
	    					}
	    				}
	    				
	    				}
	    		
	    			
	    		}  
	    		 table_output += '</tr> <tbody></table>';
	    		 
	    		 
	    		 
	    		if(checkExcel>0){
	    			$('#uploadDiv').hide();
	    			console.log(shortCodesList+"---")
	    			alert("Please Upload  Abbreviation Excel ");
	     			excel_file.value = '';
	     			document.getElementById('myTable1').innerHTML = "";
	    		}
	    		else{
	    			var shortCodesList = [<%int i=0; for (Object[] obj: shortCodesLinkedListByType) {%> "<%=obj[1] %>"<%= i+1 < shortCodesLinkedListByType.size() ? ",":""%><%}%>];	
	    		
			
			var AbbreDetails = [];
			
			for(var i in sheet_data){
				AbbreDetails.push(sheet_data[i][1]+"");
			}
			const duplicates = AbbreDetails.filter((item,index) => index !== AbbreDetails.indexOf(item));
			const indexval = []             
	        for(var i in duplicates){
	         indexval.push(AbbreDetails.indexOf(duplicates[i]))
	         }
			 var dbDuplicate = [];
			 shortCodesList.forEach(function (item){ 
				 var isPresent = AbbreDetails.indexOf(item);
	        	  if(isPresent !== -1){
	        		  dbDuplicate.push(isPresent); 
	        	  }
			 });
				var msg=""
				 if(indexval.length>0){
		       	 msg+="Duplicate Abbreviation Existed in Excel file at Serial No :"+ indexval+"\n";
		 		$('#uploadDiv').hide();
				console.log(shortCodesList+"---")
				alert(msg);
	 			excel_file.value = '';
	 			document.getElementById('myTable1').innerHTML = "";
				 }
				 else if(dbDuplicate.length>0){
			       	 msg+=" Abbreviation already Existed in Excel file at Serial No :"+ dbDuplicate+"\n";
		    	 		$('#uploadDiv').hide();
		    			console.log(shortCodesList+"---")
		    			alert(msg);
		     			excel_file.value = '';
		     			document.getElementById('myTable1').innerHTML = "";  
				 }
				 
				 else{
					 if(sheet_data.length>20){
			    		 var myDiv = document.getElementById("myDiv");
			    		  myDiv.style.height = "400px";
			    }
				$('#uploadDiv').show();		    			
	    		document.getElementById('myTable1').innerHTML = table_output;
		         }
	    		}
	    	}
	    }
	});
 }
</script>	 	
</body>
</html>