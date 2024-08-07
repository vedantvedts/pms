<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>RFA Upload</title>
<style type="text/css">

body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}

p {
	text-align: justify;
	text-justify: inter-word;
}

th {
	border: 1px solid black;
	text-align: center;
	padding: 5px;
}

td {
	text-align: left;
	padding: 5px;
}

}
.textcenter {
	text-align: center;
}

.border {
	border: 1px solid black;
}

.textleft {
	text-align: left;
}

.nav-link {
	color: black;
	font-size: 18px;
}

.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
.input-group-text {
		font-weight: bold;
	}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

hr {
	margin-top: -2px;
	margin-bottom: 12px;
}

.card b {
	font-size: 20px;
}
.error-message {
    color: #dc3545;
    font-size: 1rem;
    margin-top: 0.25rem;
}

</style>
</head>
<body>

<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();

SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM-dd");

List<Object[]> oldRfaUploadList=(List<Object[]>) request.getAttribute("oldRfaUploadList"); %>

	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</center>
	<%} %>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
                 
                 <div class="card-header ">  

					<div class="row">
						<h5 class="col-md-2">OLD RFA List</h5>  
							
		   				</div>	   							

					</div>
                 
					<form action="#" method="post" id="myFrom" >
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<div class="card-body">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
									<thead>
										<tr>
											<th style="width:2%;">SN</th>
											<th>RFA No</th>
											<th>RFA Date</th>
											<th>RFA File</th>
											<th>Closure File</th>
											<th style="width: 14%">Action</th>
										</tr>
									</thead>
									<tbody>
									   <%if(oldRfaUploadList!=null){
										int i=0;
										for(Object[] obj:oldRfaUploadList) { %>
								        <tr>
								           <td style="text-align: center;"><%=++i %> <input type="hidden" name="fileUploadId" value="<%= obj[0]%>"> </td>
										   <td style="text-align: center;"><%=obj[1] %></td>
										   <td style="text-align: center;"><%=sdf.format(obj[2])%></td>
										   <td style="text-align: center;"><%if(obj[3]!=null){%>
										   <a href="OldRfaFileDownload.htm?id=<%=obj[0]%>&rfano=<%=obj[1] %>&file1=<%=obj[3]%>" target="_blank"><%=obj[3]%></a><%}else{ %>--<%} %>
										   </td>
										   <td style="text-align: center;"><%if(obj[4]!=null){%>
										   <a href="OldRfaFileDownload.htm?id=<%=obj[0]%>&rfano=<%=obj[1] %>&file2=<%=obj[4]%>" target="_blank"><%=obj[4]%></a><%}else{ %>--<%} %>
										   </td>
										   <td style="text-align: center;">
										       <button class="btn bg-transparent"
													type="button" name="uploadid" value="edit"
													onclick="rfaEditModal('<%=obj[0] %>','<%=obj[1] %>','<%=sdf.format(obj[2])%>','<%=obj[3]%>','<%=obj[4]%>')" data-toggle="tooltip" data-placement="top"
													data-original-data="" title="" data-original-title="EDIT">
													<i class="fa fa-lg fa-pencil-square-o" style="color: orange" aria-hidden="true"></i>
											  </button>
										   </td>
								        </tr>
								        <%}} %>
									</tbody>
								</table>
							</div>
						</div>
						<div align="center" style="margin-bottom: 20px">

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<button class="btn add" type="button" onclick="rfaAddModal()">ADD</button>
							<a class="btn btn-info shadow-nohover back" href="MainDashBoard.htm">BACK</a>
						</div>
						<input type="hidden" name="sub" value="add">
					</form>
				</div>
			</div>
		</div>
	</div>
	
<div class="modal fade bd-example-modal-lg" id ="olarfauploadModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-jump">
    <div class="modal-content" style="margin-top: 20%; width: 110%; margin-left: -5%;">
				<div class="modal-header">
					<h5 class="modal-title"  id="modal-title" style="font-size: x-large; font-weight: 700;margin-inline-start: auto; color: #AD1457"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				 <form id="modalForm" method="post" enctype="multipart/form-data">
                   <div class="row">
		                    <div class="col-md-2">
		                      <label class="control-label">RFA No.</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-6">
			                    <input  class="form-control"  name="oldrfano" id="oldrfano"  required="required"  placeholder="Enter RFA Number"  onchange="checkDuplicateNumber()">
		                        <div id="duplicatemessage" style="color:red; display:none;">RFA Number already exists.</div>
		                    </div>
		                        <div class="col-md-2">
		                      <label class="control-label">RFA Date</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-2" style="margin-left: -3rem">
			                     <input  class="form-control date"  data-date-format="dd-mm-yyyy" id="rfadate" name="rfadate" style="width: 10rem">
		                    </div>
		             </div>
		             <br>
		             <div class="row">
		                 <div class="col-md-2">
		                      <label class="control-label">RFA File</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-6">
			                    <input type="file" class="form-control" required="required" name="rfafile" id="rfafile" accept="application/pdf"  onchange="validateFile('rfafile','errorFile1')">		
		                        <div id="errorFile1" class="error-message"></div>
		                   </div>
		                    <div class="col-md-4">
		                     <div id="rfafileName" style="color: blue;"></div>
		                   </div>
		             </div>
		              <br>
		             <div class="row">
		                 <div class="col-md-2">
		                      <label class="control-label">Closure File</label>
		                   </div>
		                    <div class="col-md-6">
			                    <input type="file" class="form-control" name="closurefile" id="closurefile" accept="application/pdf"  onchange="validateFile('closurefile','errorFile2')">
			                    <div id="errorFile2" class="error-message"></div>
		                   </div>
		                   <div class="col-md-4">
		                     <div id="closurefileName" style="color: blue;"></div>
		                   </div>
		             </div>
		          <br>
		        <div class="form-group" align="center" >
					 <button type="button" class="btn btn-primary btn-sm submit" id="rfaSubmit"></button>
					 <input type="hidden" name="rfaUploadId" id="rfaUploadId" value="">
					 <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				</div>
			 </form>
				</div>
		</div>
	 </div>
</div>


</body>
<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});
$('#rfadate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
function validateFile(inputId, errorMsgId) {
    var fileInput = document.getElementById(inputId);
    var errorMsg = document.getElementById(errorMsgId);
    var file = fileInput.files[0];

    if (file) {
        var fileType = file.type;
        var fileSize = file.size;
        var maxSize = 10 * 1024 * 1024; // 10MB

        if (fileType !== "application/pdf") {
            errorMsg.innerHTML = "Please upload a PDF file.";
            fileInput.value = ""; // Clear the file input
            return false;
        } else if (fileSize > maxSize) {
            errorMsg.innerHTML = "File size must be less than 10MB.";
            fileInput.value = ""; // Clear the file input
            return false;
        } else {
            errorMsg.innerHTML = ""; // Clear any previous error message
            return true;
        }
    }
}

var oldRfaNumbers = [];

<% if (oldRfaUploadList != null) { %>
    <% for (Object[] obj : oldRfaUploadList) { %>
    oldRfaNumbers.push('<%= obj[1].toString() %>');<% } %>
<% } %>

function checkDuplicateNumber() {
    var inputNumber = document.getElementById('oldrfano').value;
    var errorMessage = document.getElementById('duplicatemessage');

    if (oldRfaNumbers.includes(inputNumber)) {
        errorMessage.style.display = 'block';
        setTimeout(function() {
            errorMessage.style.display = 'none';
        }, 2000);
        $('#oldrfano').val("");
    } else {
        errorMessage.style.display = 'none';
    }
}

function validateForm(isEdit = false) {
    var isValid = true;
    var rfaNo = $('#oldrfano').val().trim();
    var rfaDate = $('#rfadate').val().trim();
    var rfaFile = $('#rfafile').val().trim();
    var existingRfaFile = $('#rfafileName').text().trim();

    if (rfaNo === '') {
        alert('RFA Number is required.');
        isValid = false;
    } else if (rfaDate === '') {
        alert('RFA Date is required.');
        isValid = false;
    } else if (!isEdit && rfaFile === '') {
        alert('RFA File is required.');
        isValid = false;
    } else if (isEdit && rfaFile === '' && existingRfaFile === '') {
        alert('RFA File is required.');
        isValid = false;
    }

    return isValid;
}
function rfaAddModal(){
    $('#olarfauploadModal').modal('show');
    // Clear the form fields
    $('#oldrfano').val('');
    $('#rfadate').val(getCurrentDate());
    $('#rfafile').val('');
    $('#rfafileName').html('');
    $('#closurefile').val('');
    $('#closurefileName').html('');
    // Set form action and modal title for "Add" operation
    $('form').attr('action', 'OldRfaUploadSubmit.htm');
    $('#modal-title').text('Add New RFA Details');
    $('#rfaSubmit').text('Submit').off('click').on('click', function(e) {
        e.preventDefault();
        if (validateForm()) {
            if (confirm('Are you sure you want to submit?')) {
                $('#modalForm').submit();
            }
        }
    });
}

function getCurrentDate() {
    var today = new Date();
    var day = String(today.getDate()).padStart(2, '0');
    var month = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
    var year = today.getFullYear();
    return day + '-' + month + '-' + year; // Adjust the format as needed
}

function rfaEditModal(uploadId,rfano,rfadate,rfafile,closurefile){
    $('#rfaUploadId').val(uploadId);
    $('#oldrfano').val(rfano);
    $('#rfadate').val(rfadate);
    $('#rfafileName').html(rfafile ? rfafile : ''); 
    $('#closurefileName').html(closurefile !== 'null' ? closurefile : '');

    // Set form action and modal title for "Edit" operation
    $('form').attr('action', 'OldRfaUploadEditSubmit.htm'); // Set the correct action for edit
    $('#modal-title').text('Edit RFA Details');
    $('#rfaSubmit').text('Update').off('click').on('click', function(e) {
        e.preventDefault();
        if (validateForm(true)) {
            if (confirm('Are you sure you want to update?')) {
                $('#modalForm').submit();
            }
        }
    });

    $('#olarfauploadModal').modal('show');
}
</script>
</html>