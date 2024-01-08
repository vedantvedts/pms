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


<title>RFA Inspection</title>
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
#modalreqheader {
	background: #055C9D;
	height: 47px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}
#remarksTd1{
font-weight: bold;
width: 30%;
color: #007bff;
}
#remarksDate{
color: black;
font-size: 13px;
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
		
List<Object[]> RfaInspectionList=(List<Object[]>) request.getAttribute("RfaInspectionList");
String EmpId=(String)request.getAttribute("EmpId");
String UserId=(String)request.getAttribute("UserId");
String rfaCount=(String) request.getAttribute("rfaCount");
List<String> toAssigneRevokeStatus  = Arrays.asList("RFA");
List<String> forwardAllow = Arrays.asList("AAA","RP","RR","RE","AV");
List<String> remarksShowStatus  = Arrays.asList("RE","RFA","RR","RP","ARC");
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
						<h5 class="col-md-2">RFA Inspection List</h5>  
					</div>
               </div>
					<form action="#" method="post" id="myFrom">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<div class="card-body">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
									<thead>
										<tr>
											<th>Select</th>
											<th>RFA No</th>
											<th>RFA Date</th>
											<th>Project</th>
											<th>Priority</th>
											<th>Forwarded By</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
									
										<%if(RfaInspectionList!=null){
										int count=0;
										for(Object[] obj:RfaInspectionList) {%>
										<tr>
											<td style="text-align: center;"><%=++count%></td>
											<td><%=obj[3] %></td>
											<td style="text-align: center;"><%=sdf.format(obj[4])%></td>
											<td style="text-align: center;"><%=obj[2] %></td>
											<td style="text-align: center;"><%=obj[5] %></td>
											<td><%=obj[11] %></td>
																<td class="left width" style="text-align: center;">

												<button class="editable-click bg-transparent"
													formaction="RfaActionPrint.htm" formmethod="get"
													formnovalidate="formnovalidate" name="rfaid"
													value="<%=obj[0]%>/<%=obj[3] %>"
													formtarget="_blank">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/preview3.png">
															</figure>
														</div>

													</div>

												</button> 
												<%if(rfaCount.equalsIgnoreCase("0")){ %>
														<button title="ADD"  data-original-title="ADD" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													onclick="showModel('<%=obj[3].toString()%>',<%=obj[0].toString()%>)">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon" >
																<img src="view/images/assign.jpg">
															</figure>
														</div>
													</div>
												</button>
												<%} %>
												 <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}" /> <input
												type="hidden" name="projectid"
												value="<%=obj[12].toString() %>"> <input
												type="hidden" name="RfaStatus"
												value="<%=obj[10].toString()%>">
											<%if(obj[9].toString().equalsIgnoreCase(EmpId) ){
												if(forwardAllow.contains(obj[10]) && !rfaCount.equalsIgnoreCase("0")){
											%>
												<button class="editable-click"
													style="background-color: transparent;"
													formaction="RfaActionForward.htm" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa"
													value="<%=obj[0]%>"
													onclick="return confirm('Are You Sure To Forward this RFA ?');">
													<div class="cc-rockmenu">
														<figure class="rolling_icon">
															<img src="view/images/forward1.png">
														</figure>
													</div>
												</button>
										
												 <input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> 
												<%
													
													if(rfaCount.equalsIgnoreCase("0")){
												%>
										
												<%}else{ %>
												<button title="EDIT"  class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"data-original-title="EDIT"
													onclick="showdata(<%=obj[0].toString()%>,'<%=obj[3].toString()%>')">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon" >
																<img src="view/images/edit.png">
															</figure>
														</div>
													</div>
												</button> <%} } }%>
												 <%if(toAssigneRevokeStatus.contains(obj[10])){%> 
												<button data-original-title="REVOKE" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formaction="RfaActionReturnList.htm" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa" id="rfaRevokeBtn"
													value="<%=obj[0]%>"
													onclick="return returnRfa(<%=obj[0]%>,'<%=obj[10]%>','<%=obj[9]%>')">
													
														
														<i class="fa fa-backward" aria-hidden="true" style="color: #007bff; font-size: 24px; position: relative; top: 5px;"></i>
													
												</button> 
												<%} if(obj[15]!=null){
												 if(Integer.valueOf(obj[15].toString())>0){ %>  
												 	<button title="REMARKS" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formaction="RemarksList.htm" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa" id="rfaRemarksBtn"
													value="<%=obj[0]%>"
													onclick="return rfaRemarks(<%=obj[0]%>,'<%=obj[14]%>')">
													
														
														<i class="fa fa-comment" aria-hidden="true" style="color: #143F6B; font-size: 24px; position: relative; top: 5px;"></i>
													
												</button> 
												<% }} %>
											</td>
										</tr>
										<%}} %>
									</tbody>
								</table>
							</div>
						</div>
						<input type="hidden" name="rfa" id="rfaHidden">
						<input type="hidden" name="RfaStatus" id="RfaStatusHidden">
						<input type="hidden" name="assigneed" id="assigneedHidden">
					</form>
					</div>
					</div>
					</div>
					</div>
	<!-- -- ******************************************************************Assign  Model Start ***********************************************************************************-->
 		<form class="form-horizontal" role="form"
			action="#" method="POST" id="myform1" autocomplete="off">
			<div class="modal fade bd-example-modal-lg" id="rfamodal"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content addreq" style="width: 120%;">
						<div class="modal-header" id="modalreqheader">
							<h5 class="modal-title" id="exampleModalLabel">RFA Add</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 550px; overflow: auto;">
							<div class="modal-body">
							
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-5">
											<label style="font-size: 17px; margin-top: 5%; margin-left: 4%; color: #07689f; font-weight: bold;" >RFA No. </label>
				                            <label><input type="text" class="form-control" name="RfaNo" id="RfaNo" readonly="readonly"></label>
										</div>
										
										<div class="col-md-7">
											<label style="font-size: 17px; margin-top: 4%; margin-left: 5%; color: #07689f; font-weight: bold;" >Date of Completion : </label><span class="mandatory" style="color: red;">*</span>
				                            <label><input type="text"  id="fdate" name="fdate" value=""class="form-control"></label>
										</div>
										</div>
									</div>
                                 
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-5">
												<label style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem; font-weight: bold;">Visual Inspection and Observation<span class="mandatory" style="color: red;">*</span></label>
											</div>
											<div class="col-md-7" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="observation" class="form-control"
														id="observation" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters"
														style="line-height: 4rem !important">
												</div>
											</div>
										</div>
									</div>
									
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-6">
												<label style="margin: 0px; font-size: 17px; color: #07689f; font-weight: bold;">Clarification <span class="mandatory" style="color: red;">*</span></label>
											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12" id="textarea" >
												<div class="form-group">
													<textarea required="required" name="clarification"
														class="form-control" maxlength="1000" id="clarification"
														rows="5" cols="53" placeholder="Maximum 1000 Chararcters"></textarea>
												</div>
											</div>
										</div>
									</div>
									
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-3">
												<label style="font-size: 18px; margin-top: 5%; color: #07689f; margin-left: 0.1rem ; font-weight: bold;">Action Required<span class="mandatory" style="color: red;">*</span></label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group" style="width: 113%">
													<input type="text" class="form-control" name="Rfaaction"
														id="action" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters"
														style="line-height: 3rem !important">
												</div>
											</div>
										</div>
									</div>
									

									<input type="hidden" name="rfaid" id="rfaidvalue"
										value="" />
									<div class="form-group" align="center" style="margin-top: 3%;">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<span id="btnsub"><button type="button" id="assignSubBtn" class="btn btn-primary btn-sm submit" id="submit" formaction="RfaAssignFormSubmit.htm"  value="SUBMIT" onclick="return assignSub()">SUBMIT</button></span>
									</div>
	
							</div>
						</div>
					</div>

				</div>
			</div>
			
		</form>
		
		<!-- -- ******************************************************************Assign  Model End ***********************************************************************************-->

	<!-- -- ******************************************************************Remarks  Model Start ***********************************************************************************-->
<form class="form-horizontal" role="form"
			action="#" method="POST" id="returnFrm" autocomplete="off">
			<div class="modal fade bd-example-modal-lg" id="rfaRemarksmodal"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content addreq" style="width: 100%; position: relative; " >
						<div class="modal-header" id="modalreqheader" style="background-color: #021B79">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #fff">RFA Remarks</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 300px; overflow: auto;">
							<div class="modal-body">
							
		<div class="form-inline" >
		<table class=" table-hover table-striped remarksDetails " style="width: 100%;"  >
		<tbody id="remarksTb"></tbody>
							</table>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		<input type="hidden" name="rfa" id="rfaHidden">
 		<input type="hidden" name="RfaStatus" id="RfaStatusHidden">
    
        

        
        
	</div>

	
							</div>
						</div>
					</div>

				</div>
				</div>
		
		</form>
<script>

$("#myTable1,#myTable2").DataTable({
    "lengthMenu": [ 5,10,20,50,75,100],
    "pagingType": "simple"
    	
});

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});


$('#fdate').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	/* "minDate":new Date(), */
	"startDate":new Date(), 
	locale: {
  	format: 'DD-MM-YYYY'
		}
});

function showModel(RfaNo,rfaId) {
	  document.getElementById('RfaNo').value=RfaNo;
	  document.getElementById('rfaidvalue').value=rfaId;
	  $('#rfamodal').modal('show');
	 
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
function rfaRemarks(rfaId,RfaStatus) {
	$('#rfaRemarksmodal').modal('show');
	console.log(rfaId);
	$.ajax({
        type: "GET",
        url: "getrfaRemarks.htm",
        data: {
        	rfaId : rfaId,
        	status : 'assigner'
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
function showdata(a,b){
	console.log(a+ " "+b);
	document.getElementById('RfaNo').value=b;
	document.getElementById('rfaidvalue').value=a;
	
	$.ajax({
		
		type:'GET',
		url:'RfaAssignAjax.htm',
		datatype:'json',
		data:{
			rfaId:a,
		},
		success:function(result){
			var ajaxresult = JSON.parse(result);
			console.log(result)
			  const date = new Date(ajaxresult[4]);
						   const formattedDate = date.toLocaleDateString('en-GB', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric',
                        }).replace(/\//g, '-');
						   console.log(formattedDate)
			$('#fdate').val(formattedDate);
			$('#clarification').val(ajaxresult[6]);
			$('#observation').val(ajaxresult[5]);
			$('#action').val(ajaxresult[7]);
		}
	})
	 
  $('#rfamodal').modal('show');
}
function submitform(){
	if(!confirm("Are you sure to Update")){
		
		event.preventDefault();
		return false;
	}else{
		
		$('#myform1').submit();
		return true;
	}
}

function assignSub() {
	
	  var observation=$('#observation').val();
	  var clarification=$('#clarification').val();
	  var action=$('#action').val();
	  
		if(observation==""||observation==null ||observation=="null" ){
			   alert('Please Enter observation');
			   return false;
		   }else if(clarification==""||clarification==null || clarification=="null"){
				 alert('Please Enter clarification');
				   return false;
		   }else if(action==""||action==null || action=="null"){
				 alert('Please Enter action');
				   return false;
		   }
	  var confirmation = confirm('Are you sure you want to add the Assign/Update Details?');
	  if(confirmation){
		  var form = document.getElementById("myform1");
		   
        if (form) {
         var assignSubBtn = document.getElementById("assignSubBtn");
            if (assignSubBtn) {
                var formactionValue = assignSubBtn.getAttribute("formaction");
                
                 form.setAttribute("action", formactionValue);
                  form.submit();
              }
         }
	  } else{
  	  return false;
	  }
	
}
$('#observation,#clarification,#action').keyup(function (){
	  $('#observation,#clarification,#action').css({'-webkit-box-shadow' : 'none', '-moz-box-shadow' : 'none','background-color' : 'none', 'box-shadow' : 'none'});
		  });






function returnRfa(rfaId,RfaStatus,assignee) {
	$('#rfaHidden').val(rfaId);
	$('#RfaStatusHidden').val(RfaStatus);
	$('#assigneedHidden').val(assignee);
	  var confirmation = confirm('Are You Sure To Return this RFA ?');
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
	
$("input").on("keypress", function(e) {
    if (e.which === 32 && !this.value.length)
        e.preventDefault();
});
$("textarea").on("keypress", function(e) {
    if (e.which === 32 && !this.value.length)
        e.preventDefault();
});
	
	
 </script>

</body>


</html>
	