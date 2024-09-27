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


<title>RFA Action</title>
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
#remarksTd1{
font-weight: bold;

color: #007bff;
}
#remarksDate{
color: black;
font-size: 13px;
}
#closeImg{
height: 25px;
width: 25px;
background-color: transparent;
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


</style>
</head>
<body>

<%
	  FormatConverter fc=new FormatConverter(); 
	  SimpleDateFormat sdf=fc.getRegularDateFormat();
	  SimpleDateFormat sdf1=fc.getSqlDateFormat();

	  SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");
	  SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM-dd");

List<Object[]> AssigneeList=(List<Object[]>) request.getAttribute("AssigneeEmplList");
List<Object[]> RfaActionList=(List<Object[]>) request.getAttribute("RfaActionList");
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
String Project=(String)request.getAttribute("Project");
String ModalEmpList=(String)request.getAttribute("ModalEmpList");
String ModalTDList=(String)request.getAttribute("ModalTDList");
String Employee=(String)request.getAttribute("Employee");
String EmpId=(String)request.getAttribute("EmpId");
String fdate=(String)request.getAttribute("fdate");
String tdate=(String)request.getAttribute("tdate");  
String LoginType=(String)request.getAttribute("LoginType");
String UserId=(String)request.getAttribute("UserId");
String Status = (String)request.getAttribute("Status");
List<String> toUserStatus  = Arrays.asList("AA","RC","RV","REV","RE");


%>

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
						<h5 class="col-md-2">RFA List</h5>  
							<div class="col-md-10" style="float: right; margin-top: -12px;">
					   			<form method="post" action="#" name="dateform" id="dateform">
					   				<table >
					   					<tr>
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;font-weight: 700;">Project: </label>
					   						</td>
					   						<td style=" padding-right: 50px">
                                                        <select class="form-control selectdee " name="Project" id="Project" required="required"  data-live-search="true"  >
                                                         <option value="A"  <%if(Project.equalsIgnoreCase("A")){%> selected="selected" <%}%>>ALL</option>	
                                                           <%
                                                           for(Object[] obj:ProjectList){
                                                           String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
                                                           %>
														   <option value="<%=obj[0] %>" <%if(Project.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4]+projectshortName %></option>	
														<%} %>
																</select>	        
											</td>
											
					   									   		
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;font-weight: 700;">From Date: </label>
					   						</td>
					   						<td style="padding-right: 20px">
					   							<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="<%=sdf.format(sdf1.parse(fdate))%>">
					   						</td>
					   						<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem; font-weight: 700;">To Date: </label>
					   						</td>
					   						<td style=" padding-right: 20px">
					   							<input  class="form-control "  data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  required="required"  value="<%= sdf2.format(sdf3.parse(tdate))%>">
					   						</td>
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;font-weight: 700;">RFA Status: </label>
					   						</td>
					   						<td style=" padding-right: 20px">
                                                <select class="form-control selectdee " name="Status" id="Status" required="required" >                                                     
											        <option value="A" <%if("A".equalsIgnoreCase(Status)){%>selected="selected" <%}%> >  All</option>	
											        <option value="O" <%if("O".equalsIgnoreCase(Status)){%>selected="selected" <%}%> >  Open</option>
											        <option value="C" <%if("C".equalsIgnoreCase(Status)){%>selected="selected" <%}%> > Close</option>
											        <option value="CAN" <%if("CAN".equalsIgnoreCase(Status)){%>selected="selected" <%}%> > Cancel</option>
										        </select>	       
											</td>
					   						<td>
					   							
					   						</td>			
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
		   					</div>
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
											<th>Project</th>
											<th>Priority</th>
											<th>Assigned To</th>
											<th>Status</th>
											<th style="width: 14%">Action</th>
										</tr>
									</thead>
									<tbody>
									
										<%if(RfaActionList!=null){
										int i=0;
										for(Object[] obj:RfaActionList) { %>
										<tr>
										
											<td style="text-align: center;"><%=++i %> <input type="hidden" name="createdBy" value="<%= obj[11]%>"> </td>
											<td><%=obj[3] %></td>
											<td style="text-align: center;"><%=sdf.format(obj[4])%></td>
											<td style="text-align: center;"><%=obj[2] %></td>
											<td style="text-align: center;"><%=obj[5] %></td>
											<td>
											<%if(AssigneeList!=null ){ 
												for(Object[] obj1 : AssigneeList){
													if(obj1[0].toString().equalsIgnoreCase(obj[0].toString())){
													%>
											      <p style="margin-bottom:0px !important;"> <%=obj1[1].toString()+","+obj1[2].toString() %> </p>          
											<% }}}%>
											</td>
											<td style="text-align: center;">
	                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                       	  	<button type="submit" class="btn btn-sm btn-link btn-status" formaction="RfaTransStatus.htm" value="<%=obj[0] %>" name="rfaTransId"  data-toggle="tooltip" data-placement="top" title="Transaction History" 
	                                       	  	style=" color: #E65100; font-weight: 600;" formtarget="_blank"><%=obj[17] %> 
								    			</button>
	                                        </td>
											<td class="left width">
												<button class="editable-click bg-transparent"
													formaction="RfaActionPrint.htm" formmethod="get"
													formnovalidate="formnovalidate" name="rfaid" value="<%=obj[0]%>,<%=obj[3] %>,<%=obj[2] %>" 
													style="margin-left:10%;" formtarget="_blank"   data-toggle="tooltip" data-placement="top"  data-original-title="VIEW DOCUMENT">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/preview3.png">
															</figure>
														</div>
													</div>
												</button> 
												<%if(obj[11].toString().equalsIgnoreCase(UserId) && toUserStatus.contains(obj[14].toString())) {
                                                %>
												<button class="btn bg-transparent"
													formaction="RfaActionEdit.htm" formmethod="post"
													type="submit" name="Did" value="<%=obj[0].toString()%>"
													onclick="" data-toggle="tooltip" data-placement="top"
													data-original-data="" title="" data-original-title="EDIT">
													<i class="fa fa-lg fa-pencil-square-o"
														style="color: orange" aria-hidden="true"></i>
												</button>
												<%
												}
												%> <input type="hidden" /> <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}" /> <%
					                       if(obj[11].toString().equalsIgnoreCase(UserId) && toUserStatus.contains(obj[14].toString())){%>
				                         <button class="editable-click"  style="background-color: transparent; name="rfa" value="<%=obj[0]%>" 
											type="button"	data-toggle="tooltip" data-placement="top" id="rfaCloseBtn" 
											onclick="forwardmodal('<%=obj[3]%>',<%=obj[0]%>)" title="" data-original-title="FORWARD RFA">
												<div class="cc-rockmenu" >
														<figure class="rolling_icon" >
															<img src="view/images/forward1.png">
														</figure>
												</div>
											</button>
											
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> 
												
	                                      <% }if(obj[11].toString().equalsIgnoreCase(UserId) && (obj[14].toString().equalsIgnoreCase("AF") || obj[14].toString().equalsIgnoreCase("AX"))){
	                                      %>
												<button data-original-title="REVOKE RFA" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;" data-toggle="tooltip" data-placement="top"
													formaction="RfaActionReturnList.htm" formmethod="POST"
													formnovalidate="formnovalidate"  id="rfaRevokeBtn"
													onclick="return returnRfa(<%=obj[0]%>,'<%=obj[14]%>','<%=obj[15]%>')">
												  <i class="fa fa-backward" aria-hidden="true" style="color: #007bff; font-size: 24px; position: relative; top: 5px;"></i>
												</button> 
													<input type="hidden" name="rfa" id="rfaHidden">
 													<input type="hidden" name="RfaStatus" id="RfaStatusHidden">
      												 <input type="hidden" name="assignor" id="assignorId">
	                                    <% } if(Integer.valueOf(obj[16].toString())>0 && obj[11].toString().equalsIgnoreCase(UserId) || obj[14].toString().equalsIgnoreCase("RFC")){ %>
													<button title="REMARKS" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formnovalidate="formnovalidate" name="rfa" id="rfaRemarksBtn"
													value="<%=obj[0]%>"
													onclick="return rfaRemarks(<%=obj[0]%>,'<%=obj[14]%>')">
													<i class="fa fa-comment" aria-hidden="true" style="color: #143F6B; font-size: 24px; position: relative; top: 5px;"></i>
												    </button> 
											 <%} %>
											 <%if(obj[14].toString().equalsIgnoreCase("AA") && obj[15].toString().equalsIgnoreCase(EmpId)){%>
											 	<button type="button" class="editable-click"  style="background-color: transparent;" 
												name="RFAID" value="<%=obj[0]%>" formaction="#" formmethod="POST"
												onclick="returnCancelRfa(<%=obj[0]%>,'<%=obj[14]%>','<%=obj[15]%>');"
													data-toggle="tooltip" data-placement="top" id="rfaCancelBtn" title="" data-original-title="CANCEL RFA">
												<div class="cc-rockmenu" >
														<figure class="rolling_icon" >
															<img src="view/images/close.png" id="closeImg">
														</figure>
												</div>
											   </button>
											   <input type="hidden" name="rfaoptionby" value="RFC" >
											<%} %>
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
								
							<button class="btn add" type="button" formaction="RfaActionAdd.htm" name="sub" value="add" onclick="addRfa()" id="addRfaBtn">ADD</button>
						  
							<a class="btn btn-info shadow-nohover back"
								href="MainDashBoard.htm">BACK</a>
						</div>
						<input type="hidden" name="sub" value="add">
					</form>
				</div>
			</div>
		</div>
	</div>

		<!-- -- ******************************************************************Remarks  Model Start ***********************************************************************************-->
	<form class="form-horizontal" role="form" action="#" method="POST"
		id="returnFrm" autocomplete="off">
		<div class="modal fade bd-example-modal-lg" id="rfaRemarksmodal"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq"
					style="width: 100%; position: relative;">
					<div class="modal-header" id="modalreqheader"
						style="background-color: #021B79">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #fff">RFA
							Remarks</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div style="height: 300px; overflow: auto;">
						<div class="modal-body">

							<div class="form-inline">
								<table class=" table-hover table-striped remarksDetails "
									style="width: 100%;">
									<tbody id="remarksTb"></tbody>
								</table>

								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden" name="rfa"
									id="rfaHidden"> <input type="hidden" name="RfaStatus"
									id="RfaStatusHidden"> <input type="hidden"
									name="assignor" id="assignorId">
							</div>


						</div>
					</div>
				</div>

			</div>
		</div>

	</form>

	<div class="modal fade  bd-example-modal-lg" tabindex="-1"
		role="dialog" id="ActionAssignfilemodal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						RFA No : <b id="rfamodalval"></b>
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form name="specadd" id="specadd" action="RfaActionForward.htm"
					method="POST">
					<div class="modal-body">

						<div class="row">

							<div class="col-3">
								<div class="form-group">
									<b><label> RFA By : <span class="mandatory"
											style="color: red;">* </span></label></b> <br> <select
										class=" form-control selectdee"
										onchange="return rfaOptionFunc()" style="width: 100%;"
										name="rfaoptionby" id="rfaoptionby"
										style="margin-top:-5px">
										<option disabled="disabled" selected value="">Choose...</option>
										<option value="AF">Checked By</option>
										<option value="AX">Approved By</option>
									</select>
								</div>
							</div>

							<div class="col-6" id="selectClassModal2" style="display:none;">
								<div class="form-group">
									<b><label>RFA Forward To : </label><br></b> <select
										class="form-control selectdee " style="width: 100%;"
										name="rfaEmpModal" id="modalEmpList2" required="required"
										data-live-search="true" data-placeholder="Select Assignee">
									</select>
								</div>
							</div>
						</div>
						<div align="center">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="hidden" name="rfano1"
								id="rfanomodal" value=""> <input type="submit"
								name="sub" class="btn  btn-sm submit" form="specadd"
								id="rfaforwarding" value="SUBMIT"
								onclick="return confirm('Are you sure To Submit?')" /> <input
								type="hidden" name="RFAID" id="RFAID">
						</div>

					</div>

					<!-- Form End -->
				</form>
			</div>
		</div>
	</div>

	<!-- Cancel Modal Remarks Start -->	

	<form class="form-horizontal" role="form"
		action="RfaActionReturnList.htm" method="POST" id="returnFrm"
		autocomplete="off">
		<div class="modal fade bd-example-modal-lg" id="rfaCancelmodal"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-md">
				<div class="modal-content addreq"
					style="height: 20rem; width: 150%; margin-left: -22%; position: relative;">
					<div class="modal-header" id="modalreqheader"
						style="background-color: #021B79">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #fff">RFA CANCEL</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div style="height: 520px; overflow: auto;">
						<div class="modal-body">
							<div class="row" style="" id="mainrow">
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-3">
											<label class="control-label returnLabel" style="font-weight: 600;font-size: 16px">Reason For Cancel</label> <span
												class="mandatory" style="color: #cd0a0a;">*</span>
										</div>
										<div class="col-md-9" style="max-width: 82%">
											<textarea class="form-control" rows="5" cols="30"
												placeholder="Max 500 Characters" name="replyMsg"
												id="replyMsg" maxlength="500" required></textarea>
										</div>
									</div>
									<br>
									<div class="form-group" align="center">
										<span id="btnsub"><button type="submit"
												class="btn btn-primary btn-sm submit" id="submit"
												value="SUBMIT"
												onclick="return confirm('Are you sure to close this RFA ?')">SUBMIT</button></span>
									</div>

									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input type="hidden" name="rfa"
										id="rfaIdHidden"> <input type="hidden" name="RfaStatus"
										id="" value="RFC"> <input type="hidden"
										name="assignor" id="assignorHidden">

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
 <!-- Cancel Modal Remarks End -->	
		
</body>

<script type="text/javascript">


function Edit(myfrm){

	 var fields = $("input[name='Did']").serializeArray();
	
	 console.log(fields+"--")
	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;	
	}

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});


$('#tdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})
	
		$(document).ready(function(){
						   $('#fdate, #tdate,#Project,#Status').change(function(){
							   var form = document.getElementById("dateform");
							 
				               if (form) {
				                        // Set the form's action attribute to the formactionValue o submit form
				                        form.setAttribute("action", "RfaAction.htm");
				                         form.submit();
				                     }
				                });
						 
						}); 
		function frdRfa(rfaId,RfaStatus) {
			$('#rfa').val(rfaId);
			$('#RfaStatus').val(RfaStatus);
			
			  var confirmation = confirm('Are You Sure To Forward this RFA ?');
			  if(confirmation){
				  var form = document.getElementById("myFrom");
				   
		        if (form) {
		         var rfaFwdBtn = document.getElementById("rfaFwdBtn");
		            if (rfaFwdBtn) {
		                var formactionValue = rfaFwdBtn.getAttribute("formaction");
		                
		                 form.setAttribute("action", formactionValue);
		                  form.submit();
		              }
		         }
			  } else{
		  	  return false;
			  }
			
		}
		
		function rfaClose(rfaId,RfaStatus) {
			$('#rfa').val(rfaId);
			$('#RfaStatus').val(RfaStatus);
			
			  var confirmation = confirm('Are You Sure To Close this RFA ?');
			  if(confirmation){
				  var form = document.getElementById("myFrom");
				   
		        if (form) {
		         var rfaFwdBtn = document.getElementById("rfaCloseBtn");
		            if (rfaFwdBtn) {
		                var formactionValue = rfaFwdBtn.getAttribute("formaction");
		                
		                 form.setAttribute("action", formactionValue);
		                  form.submit();
		              }
		         }
			  } else{
		  	  return false;
			  }
			
		}
						
function returnRfa(rfaId,RfaStatus,createdBy) {
	$('#rfaHidden').val(rfaId);
	$('#RfaStatusHidden').val(RfaStatus);
	$('#assignorId').val(createdBy);
	  var confirmation = confirm('Are You Sure To Revoke this RFA ?');
	  if(confirmation){
		  var form = document.getElementById("myFrom");
		   
        if (form) {
         var rfaRevokeBtn = document.getElementById("rfaRevokeBtn");
            if (rfaRevokeBtn) {
                var formactionValue = rfaRevokeBtn.getAttribute("formaction");
                
                 form.setAttribute("action", formactionValue);
                  form.submit();
              }
         }
	  } else{
  	  return false;
	  }
	
}
function rfaRemarks(rfaId,RfaStatus) {
	$('#rfaRemarksmodal').modal('show');
	console.log(rfaId);
	$.ajax({
        type: "GET",
        url: "getrfaRemarks.htm",
        data: {
        	rfaId : rfaId,
        	status : 'user'
        },
        dataType: 'json', 
        success: function(result) {
        	$("#remarksTb").empty();
        	if(result!=null && Array.isArray(result) && result.length>0){
        		
        		
        		  var ReplyAttachTbody = '';
		          for (var z = 0; z < result.length; z++) {
		            var row = result[z];
		            ReplyAttachTbody += '<tr>';
		            ReplyAttachTbody += '<td id="remarksTd1">'+row[0]+' &nbsp; <span id="remarksDate"> '+fDate(row[2])+'</span>';
		            ReplyAttachTbody += '</td>';
		            ReplyAttachTbody += '</tr>';
		            ReplyAttachTbody += '<tr>';
		            ReplyAttachTbody += '<td id="remarksTd2">  '+row[1]+'';
		            ReplyAttachTbody += '</td>';
		            ReplyAttachTbody += '</tr>';

		          }
		          $('#remarksTb').append(ReplyAttachTbody);
        }
        }
	})
}

 function fDate(fdate) {
	 var dateString = fdate;

	// Create a Date object from the original date string
	var date = new Date(dateString);

	// Get the date components
	var day = date.getDate().toString().padStart(2, '0'); // Get day and pad with leading zero if necessary
	var month = (date.getMonth() + 1).toString().padStart(2, '0'); // Get month (zero-based) and pad with leading zero if necessary
	var year = date.getFullYear();
	var hours = date.getHours().toString().padStart(2, '0'); // Get hours and pad with leading zero if necessary
	var minutes = date.getMinutes().toString().padStart(2, '0'); // Get minutes and pad with leading zero if necessary

	// Create the formatted date string
	var formattedDate = day+'-'+month+'-'+year+' '+hours+':'+minutes;
	return formattedDate;
}
 


function addRfa() {
	
		  var form = document.getElementById("myFrom");
		   
      if (form) {
       var addRfaBtn = document.getElementById("addRfaBtn");
          if (addRfaBtn) {
              var formactionValue = addRfaBtn.getAttribute("formaction");
              
               form.setAttribute("action", formactionValue);
                form.submit();
            }
       }
	 
	
}

function forwardmodal(rfanomodal,RFAID){
         $('#rfamodalval').html(rfanomodal);
         $('#RFAID').val(RFAID);

	     $('#ActionAssignfilemodal').modal('show');
	     		
}

function rfaOptionFunc(){
	
	 var selectValue = $("#rfaoptionby").val();
	 document.getElementById("selectClassModal2").style.display = "block";
	 var ModalEmpList =<%=ModalEmpList%>;
	 var ModalTDList =<%=ModalTDList%>;
	 if (selectValue === "AF") {
			var html="";
			
			for(var i=0;i<ModalEmpList.length;i++){
				html=html+'<option value="'+ModalEmpList[i][0]+'">'+ModalEmpList[i][1]+","+ModalEmpList[i][2]+'</option>'
			}
			$('#modalEmpList2').html("");
			$('#modalEmpList2').html(html);
			
		  } else {
         
				for(var i=0;i<ModalTDList.length;i++){
					html=html+'<option value="'+ModalTDList[i][0]+'">'+ModalTDList[i][1]+","+ModalTDList[i][2]+'</option>'
				}
				$('#modalEmpList2').html("");
				$('#modalEmpList2').html(html);
		  }
}

function returnCancelRfa(rfaId,RfaStatus,assignee) {
	$('#rfaCancelmodal').modal('show');
	$('#rfaIdHidden').val(rfaId);
	$('#StatusHidden').val(RfaStatus);
	$('#assignorHidden').val(assignee);
	
}
</script>

</html>