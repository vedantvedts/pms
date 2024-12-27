<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.PfmsApplicableDocs"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

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

	List<PfmsApplicableDocs> applicableDocsList = (List<PfmsApplicableDocs>)request.getAttribute("applicableDocsList");
	List<Object[]> applicableDocsLinkedList = (List<Object[]>)request.getAttribute("applicableDocsLinkedList");
	List<Long> igiApplicableDocIds = applicableDocsLinkedList.stream().map(e -> Long.parseLong(e[1].toString())).collect(Collectors.toList());
	applicableDocsList = applicableDocsList.stream().filter(e -> !igiApplicableDocIds.contains(e.getApplicableDocId())).collect(Collectors.toList());
	List<String> igiApplicableDocNames = applicableDocsList.stream().map(e -> e.getDocumentName().toLowerCase()).collect(Collectors.toList());
	
	Gson gson = new GsonBuilder().create();
	String jsonigiApplicableDocNames = gson.toJson(igiApplicableDocNames);
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
	                      Applicable Document Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
               			<button type="button" class="btn btn-sm submit" data-toggle="modal" data-target="#addNewDocumentsModal">
               				ADD NEW DOCUMENTS
               			</button>
                	</div>
                    <div class="col-md-1" align="right">
                        <a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;"
                        <%if(docType.equalsIgnoreCase("A")) {%>
                        	href="IGIDocumentDetails.htm?igiDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("B")) {%>
                        	href="ICDDocumentDetails.htm?icdDocId=<%=docId %>"
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
      						<table class="table table-bordered table-hover table-striped table-condensed customtable" id="dataTable" style="width: 100%;margin-top: 1.5rem;" >
								<thead class="center" style="background: #055C9D;color: white;">
						      		<tr>
						     	 		<th width="10%">SN</th>
						      			<th width="70%">Document Name</th>
						      			<th width="20%">Action</th>
						      		</tr>
						      	</thead>
		      
		      					<tbody>
		      						<%if(applicableDocsLinkedList!=null && applicableDocsLinkedList.size()>0) {
		      							int slno=0;
		    							for(Object[] obj : applicableDocsLinkedList){
		      						%>
										<tr>
								      		<td class="center"><%=++slno %></td>
								      		<td><%=obj[2].toString() %></td>
								      		<td class="center">
								      			 <form action="IGIApplicableDocumentDelete.htm" method="POST" id="inlineapprform<%=slno%>">
											        <button type="submit" class="editable-clicko" onclick="return confirm('Are you sure to delete?')">
											            <img src="view/images/delete.png" alt="Delete">
											        </button>
											        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											        <input type="hidden" name="igiApplicableDocId" value="<%=obj[0] %>">
											        <input type="hidden" name="docId" value="<%=docId%>"> 
													<input type="hidden" name="docType" value="<%=docType%>"> 
													<input type="hidden" name="documentNo" value="<%=documentNo%>">
											    </form>
								      		</td>
								      	</tr>
		      						<%}}else{ %>
		      						<tr><td colspan="3" style="text-align: center">No Documents Added!</tr>
		      						<%} %>
		      					</tbody>
		      				</table>
		      			</div>	
        			</div>
        			
        			<div class="ml-2 mr-2" style="width: 0.1%; border-left: 1px solid #000;"></div>
        			
        			<div class="ml-2 mr-2" style="width: 66%">
     						<form action="IGIApplicableDocsSubmit.htm" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="docId" value="<%=docId%>"> 
							<input type="hidden" name="docType" value="<%=docType%>"> 
							<input type="hidden" name="documentNo" value="<%=documentNo%>">
							
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
									            <th>Document</th>
									            <th style="border: 0px;background-color: transparent;">&nbsp;</th>
									           
									            <%if(applicableDocsList.size()>1) {%>
										            <th>
										            	<input type="checkbox" class="" id="selectAll2" onclick="selectAllShortCodes('2')">
										            	Select 
										            </th>
										            <th>Document</th>
										            <th style="border: 0px;background-color: transparent;">&nbsp;</th>
									            <%} %>
									            
									            <%if(applicableDocsList.size()>2) {%>
										            <th>
										            	<input type="checkbox" class="" id="selectAll3" onclick="selectAllShortCodes('3')" >
										            	Select 
										            </th>
										            <th>Document</th>
										            <th style="border: 0px;background-color: transparent;">&nbsp;</th>
									            <%} %>
									            
									        </tr>	
					        			</thead>
								        
								        <% int rowcount=1; 
								        	for (int i = 0; i < applicableDocsList.size(); i++) {
								        		++rowcount;	 
								        %>
								        	<!-- Start a new row for the first column -->
									        <%if (i % 3 == 0) { rowcount=1;%> <tr> <%} %>
									        <%PfmsApplicableDocs applicableDoc = applicableDocsList.get(i); %>
									        	<td class="center">
									        		<input type="checkbox" class="shortcode_<%=rowcount %>" name="applicableDocId" value="<%=applicableDoc.getApplicableDocId()%>">
									        	</td>
								            	<td>
								            		<%=applicableDoc.getDocumentName() %>
								            	</td>
								            	<td style="border: 0px;">&nbsp;</td>
								        		<%if ((i + 1) % 3 == 0) { %>
								             		</tr>
								             <%} } %>
								        <% // Close the last row if it is not complete
							                if (applicableDocsList.size() % 3 != 0) {
							                    out.print("</tr>");
							                } %>
								    </table>
								</div>
		      				<%if(applicableDocsList!=null && applicableDocsList.size()>0) {%>
								<div align="center" class="mt-2">
						      		<button type="submit" class="btn btn-sm submit btn-req" onclick="return confirm('Are you Sure to Submit?')" >SUBMIT</button>
						      	</div>
		      				<%} %>
						</form>
     				</div>
      					
        		</div>	
        	</div>
		</div>
	</div>

	<!-- ----------------------------------------------- Add New Applicable Documents Modal --------------------------------------------------------------- -->
	<div class="modal fade bd-example-modal-lg" id="addNewDocumentsModal" tabindex="-1" role="dialog" aria-labelledby="addNewShortCodesModal" aria-hidden="true" style="margin-top: 10%;">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width:80%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">Add New Applicable Documents</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<form action="IGIApplicableDocumentsDetailsSubmit.htm" method="POST" id="myform">
									<table id="applicabledocumentstable" class="table table-bordered applicabledocumentstable" style="width: 100%;" >
										<thead class="center" style="background: #055C9D;color: white;">
											<tr>
												<th width="90%">Document Name</th>
												<td width="10%">
													<button type="button" class=" btn btn_add_applicabledocuments "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
												</td>
											</tr>
										</thead>
										<tbody id="activityTableBody">
											<tr class="tr_clone_applicabledocuments">
												<td>
													<input type="text"class="form-control documentName" name="documentName" id="documentName_1" maxlength="100" placeholder="Enter Maximum of 100 characters" onchange="checkDuplicateApplicableDocs('1')" required="required">
												</td>	
												<td class="center">
													<button type="button" class=" btn btn_rem_applicabledocuments" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
												</td>		
											</tr>	
										</tbody>
									</table>
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


//Initialize all checkboxes and select-all checkboxes as checked
$('.shortcode_1, .shortcode_2, .shortcode_3, .shortcode_4').prop('checked', true);
$('#selectAll1, #selectAll2, #selectAll3, #selectAll4').prop('checked', true);

//Function to handle select-all logic
function selectAllShortCodes(columnCount) {
  var isChecked = $('#selectAll' + columnCount).prop('checked');
  $('.shortcode_' + columnCount).prop('checked', isChecked);
}

//Function to handle individual shortcode click logic
function updateSelectAllStatus(columnCount) {
  var checkedCount = $('.shortcode_' + columnCount + ':checked').length;
  var totalCount = $('.shortcode_' + columnCount).length;
  $('#selectAll' + columnCount).prop('checked', checkedCount === totalCount);
}

//Attach event listeners dynamically
[1, 2, 3, 4].forEach(function(columnCount) {
  $('#selectAll' + columnCount).change(function() {
      selectAllShortCodes(columnCount);
  });

  $('.shortcode_' + columnCount).click(function() {
      updateSelectAllStatus(columnCount);
  });
});


/* Cloning (Adding) the table body rows for Add New Short Codes */
var cloneCount = 1;
$("#applicabledocumentstable").on('click','.btn_add_applicabledocuments' ,function() {
	
	var $tr = $('.tr_clone_applicabledocuments').last('.tr_clone_applicabledocuments');
	var $clone = $tr.clone();
	$tr.after($clone);
	++cloneCount;
	
	$clone.find(".documentName").attr("id", 'documentName_' + cloneCount).attr("onchange", 'checkDuplicateApplicableDocs(\'' + cloneCount + '\')');
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Add New Short Codes */
$("#applicabledocumentstable").on('click','.btn_rem_applicabledocuments' ,function() {
	
	var cl=$('.tr_clone_applicabledocuments').length;
		
	if(cl>1){
	   var $tr = $(this).closest('.tr_clone_applicabledocuments');
	  
	   var $clone = $tr.remove();
	   $tr.after($clone);
	   
	}
 
});

var igiApplicableDocNames = '<%=jsonigiApplicableDocNames%>';

function checkDuplicateApplicableDocs(rowCount) {
	var documentName = $('#documentName_'+rowCount).val().toLowerCase();
	
	// Check if the document name exists in the list
  if (igiApplicableDocNames.includes(documentName)) {
      alert('This document name already exists.');
      $('#documentName_'+rowCount).val('');
  }
}
</script>    	
</body>
</html>