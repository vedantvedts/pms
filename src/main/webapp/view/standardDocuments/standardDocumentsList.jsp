<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Standard Document List</title>
<spring:url value="/resources/css/standardDocument/standardDocumentsList.css" var="holidayAddEdit" />     
<link href="${holidayAddEdit}" rel="stylesheet" />
</head>
<body>
<%
List<Object[]> stnadardDocumentsList=(List<Object[]>)request.getAttribute("stnadardDocumentsList");
%>
<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>

<div class="container-fluid">		
  <div class="col-md-12">
 	<div class="card shadow-nohover" >
	  	<div class="card-header">
	  	   <div class="row">
			  <div class="col-md-12"><h4><b>Standard Documents List</b></h4></div>
		   </div>
	    </div>
		<div class="card-body"> 
		   <form action="#" method="POST" name="frm1">
			<div class="table-responsive">
			   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
				    <thead class="theadalign">
						   <tr>
							  <th>Select</th>
							  <th>Name</th>
							  <th>Description</th>
							  <th>Download</th>
						   </tr>
					    </thead>
				         <tbody>
				         <% if(stnadardDocumentsList!=null && stnadardDocumentsList.size()>0){
				         for(Object[] obj:stnadardDocumentsList){ %>
	        				 <tr>
					             <td align="center"><input type="radio" name="DocumentId" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):""%>  <%if(obj[4]!=null && Long.parseLong(obj[4].toString())==0){ %>disabled="disabled"<%} %>></td> 
					             <td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):""%></td> 
					             <td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"" %></td>
					             <td align="center">
					             <%-- <button type="submit" class="btn btn-sm icon-btn" name="StandardDocumentviewId"  id=<%="StandardDocumentviewId"+obj[0]%> value="<%=obj[0] %>" formaction="DakReceivedView.htm" formtarget="_blank" formmethod="post"
									     data-toggle="tooltip" data-placement="top" title="view"> 
										<img alt="mark" src="view/images/preview3.png">
 							     </button> --%>
					             <button type="submit" class="btn btn-sm icon-btn" name="StandardDocumentId" id=<%="StandardDocumentId"+obj[0]%> value="<%=obj[0]%>"  formaction="StandardDocumentsDownload.htm" formmethod="post" formtarget="_blank"
									 data-toggle="tooltip" data-placement="top" title="Download"> 
											<i class="fa fa-download downloadbtn"  aria-hidden="true"></i>
 								 </button>
					             </td>
	     					 </tr>
	   					<%}} %>
					    </tbody>
				   </table>
			</div>
		 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div align="center">
		 		<button type="button" class="btn btn-primary btn-sm add" onclick="OpenDocumentsAdd()" value="add">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<button type="button" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit()"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		 		<button type="button" class="btn btn-danger btn-sm delete" name="sub" value="delete"  onclick="Delete()">InActive</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		 	</div>
		 </form>
		 
		  <!-- ------------------------------------------------------------------------------------------ Standard Documents Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalStandardDocuments"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump modal1" role="document">
 	    <div class="modal-content modal-content1">
 	      <div class="modal-header modal-header1">
 	      <div class="center-div" align="center"><h5 class="modal-title modal-title1" id="exampleModalLongTitle"></h5></div>
  	        <button type="button" class="close modal-close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body">
  	      	<form action="StandardDocumentsAddSubmit.htm" method="post" id="StandardDocumentSubmitForm" enctype="multipart/form-data">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label">Name <span class="mandatory mandatory-1" >*</span></label>
								<input type="text" class="form-control form-control alphanum-no-leading-space" name="DocumentName DocumentName-1" id="DocumentName" required="required">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label control-label1">Attachment<span class="mandatory Attachmentmandatory-1" id="Mandatory"></span></label>&nbsp;&nbsp;&nbsp;&nbsp;<span class="SelectedDocument1" id="SelectedDocument"></span>
								<input type="file" class="form-control form-control Attachmentfile-1" name="Attachment" id="Attachment" required="required">
							</div>
						</div>
						</div>
						<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label">Description<span class="mandatory Description-1">*</span></label>
								<textarea class="form-control form-control description-input" rows="3" cols="50" id="Description" name="Description" required="required" maxlength="2000"></textarea>
								<!-- <input type="text" class="form-control form-control" type="text" id="Description" name="Description" style="font-size: 15px;" required="required" /> -->
							</div>
						</div>
				  </div><br><br>
  	      		  <div class="col-md-12"  align="center">
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" onclick="return StandardDocumentsSubmit()"> 
  	      		  </div>
  	      		  <input type="hidden" name="SelectedStandardDocumentId" id="SelectedStandardDocumentId" value="">
  	      		  <input type="hidden" name="DocumentFrom" id="DocumentFrom">
  	      	</form>
  	      	<form action="StandardDocumentDelete.htm" method="post" id="DeleteForm">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	<input type="hidden" name="SelStandardDocumentId" id="SelStandardDocumentId">
  	      	</form>
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  
  
  
  <!-- ------------------------------------------------------------------------------------------------- Standard Documents Modal End  ---------------------------------------------------------------------------->
		</div>
	  </div>
   </div>
</div>	
</body>
<script type="text/javascript">
$(document).ready(function() {
	$("#myTable").DataTable({
			'aoColumnDefs': [{
			'bSortable': false,
		     
			'aTargets': [-1] /* 1st one, start by the right */
		}],
		 "lengthMenu": [50, 100, 150, 200, 250], // Set page length options
	        "pageLength": 50 // Set the initial page length to 50
	});
});

function OpenDocumentsAdd() {
$('#exampleModalStandardDocuments').modal('show');	
$('#exampleModalLongTitle').html('Standard Documents Add');
$('#DocumentFrom').val('Add');
$('#DocumentName').val('');      // Clear the document name input field
$('#Description').val('');       // Clear the description input field
$('#Attachment').val(''); 
$('#SelectedDocument').empty();
$('#sub').val('Submit');
$('#Mandatory').html('*');
}


function StandardDocumentsSubmit() {
    var DocumentName = $('#DocumentName').val().trim(); 
    var Description = $('#Description').val().trim();  
    var Attachment = $('#Attachment').val();
    var DocumentFrom=$('#DocumentFrom').val();
    
    if(DocumentFrom!=null && DocumentFrom==='Add'){
    // Validation checks
    if (DocumentName === "" || DocumentName === null) {
        alert('Please enter a valid document name (no spaces or empty input).');
        $('#DocumentName').focus();
        return false; // Prevent form submission
    } else if (Description === "" || Description === null) {
        alert('Please enter a valid description (no spaces or empty input).');
        $('#Description').focus();
        return false; // Prevent form submission
    } else if (Attachment === "" || Attachment === null) {
        alert('Please select a file to upload.');
        $('#Attachment').focus();
        return false; // Prevent form submission
    } 
    }else if(DocumentFrom!=null && DocumentFrom==='Add'){
    	if (DocumentName === "" || DocumentName === null) {
            alert('Please enter a valid document name (no spaces or empty input).');
            $('#DocumentName').focus();
            return false; // Prevent form submission
        } else if (Description === "" || Description === null) {
            alert('Please enter a valid description (no spaces or empty input).');
            $('#Description').focus();
            return false; // Prevent form submission
        }
    }
    // Confirmation prompt
    var confirmSubmission = confirm("Are you sure you want to add this document?");
    
    if (confirmSubmission) {
        $('#StandardDocumentSubmitForm').submit();
    } else {
        return false;
    }
}
function Edit() {
    var fields = $("input[name='DocumentId']:checked").serializeArray();
    if (fields.length === 0) {
        alert("Please Select A Record");
        event.preventDefault();
        return false;
    } else {
    	
        var selectedDocumentId = fields[0].value; 
        $('#DocumentName').val('');      // Clear the document name input field
        $('#Description').val('');       // Clear the description input field
        $('#SelectedDocument').empty();  // Clear any previously appended content (e.g., buttons or forms)
        $('#DocumentFrom').val('');  // Clear any previously appended content (e.g., buttons or forms)
        $('#SelectedStandardDocumentId').val('');
        $('#exampleModalStandardDocuments').modal('show');
        $('#exampleModalLongTitle').html('Standard Documents Edit');
        $('#SelectedStandardDocumentId').val(selectedDocumentId);
        $('#DocumentFrom').val('Edit');
        $('#sub').val('Update');
        $('#Mandatory').html('');
        $.ajax({
    		type : "GET",
    		url : "GetSelectedDocumentDetails.htm",
    		data : {
    			selectedDocumentId : selectedDocumentId
    		},
    		datatype : 'json',
    		success : function(result) {
    			var result = JSON.parse(result);
    			
    			$('#DocumentName').val(result[0]);
    			$('#Description').val(result[2]);
    			// Create the form dynamically
    	        var form = document.createElement('form');
    	        form.method = 'post';
    	        form.action = 'StandardDocumentsDownload.htm';
    	        form.target = '_blank';

    	        // Create the CSRF token hidden input
    	        var csrfInput = document.createElement('input');
    	        csrfInput.type = 'hidden';
    	        csrfInput.name = "${_csrf.parameterName}";  // Use the correct name for your CSRF token
    	        csrfInput.value = "${_csrf.token}";  // Use the correct token value

    	        // Create the download button dynamically
    	        var downloadButton = document.createElement('button');
    	        downloadButton.type = 'submit';
    	        downloadButton.className = 'btn btn-sm icon-btn';
    	        downloadButton.name = 'StandardDocumentId';
    	        downloadButton.id = 'StandardDocumentId' + selectedDocumentId;
    	        downloadButton.value = selectedDocumentId;
    	        downloadButton.setAttribute('data-toggle', 'tooltip');
    	        downloadButton.setAttribute('data-placement', 'top');
    	        downloadButton.setAttribute('title', 'Download');

    	        // Create icon element for the button
    	        var icon = document.createElement('i');
    	        icon.className = 'fa fa-download';
    	        icon.style.color = 'green';
    	        icon.setAttribute('aria-hidden', 'true');

    	        // Append the icon inside the button
    	        downloadButton.appendChild(icon);

    	        // Append the CSRF input and button inside the form
    	        form.appendChild(csrfInput);
    	        form.appendChild(downloadButton);

    	        // Append the form dynamically into the #SelectedDocument span
    	        document.getElementById('SelectedDocument').appendChild(form);
    			}
    	});
    }
}
function Delete() {
    var fields = $("input[name='DocumentId']:checked").serializeArray();
    if (fields.length === 0) {
        alert("Please Select A Record");
        event.preventDefault();
        return false;
    } else {
    	 var selectedDocumentId = fields[0].value;
    	  $('#SelStandardDocumentId').val(selectedDocumentId);
    	  var confirmation = confirm("Are you sure you want to InActive this document?");
          if (confirmation) {
              document.getElementById('DeleteForm').submit();
          } else {
              return false;
          }
    }
}
</script>
</html>