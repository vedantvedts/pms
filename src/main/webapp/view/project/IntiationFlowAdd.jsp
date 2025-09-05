<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.model.IndustryPartner"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalTime"%>

<%@page import="java.time.format.DateTimeFormatter"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>
	 	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>
		<style type="text/css">
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
		
		.tdclass {
			padding-top:7px;
			padding-bottom: 7px;
		}
		
		/* tr_clone .select2{
			width:600px !important;
		}
		
		tr_clone1 .select2{
			width:350px !important;
		}
		tr_clone2 select .select2{
			width:350px !important;
		} */
		sp::before {
		  content: "\2022";
		  color: red;
		  font-weight: bold;
		  display: inline-block; 
		  width: 1em;
		  margin-left: 1em;
		}	
		.swal2-confirm {
		background: green;
		}	
	</style>
</head>
<body>
<%


Object[]ApprovalData=(Object[])request.getAttribute("ApprovalData");

Object[] initiationdata=(Object[])request.getAttribute("ProjectEditData");

String initiationid = (String)request.getAttribute("initiationid");
FormatConverter fc = new FormatConverter();
SimpleDateFormat sdf = fc.getRegularDateFormat();
SimpleDateFormat sdf1 = fc.getSqlDateFormat();
SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
String EmpId = (Long)session.getAttribute("EmpId")+"";
List<Object[]>employeelist = (List<Object[]>)request.getAttribute("employeelist");
List<Object[]>AllLabList = (List<Object[]>)request.getAttribute("AllLabList");
List<String> forwardstatus = Arrays.asList("INI","RR1","RR2","RR3","RR4","RR5","RAP","REV");
List<String> reforwardstatus = Arrays.asList("RR1","RR2","RR3","RR4","RR5","RAP");
Object[]NewApprovalList = (Object[])request.getAttribute("NewApprovalList");
String labcode= (String) session.getAttribute("labcode");
//29-04-2025
%>

<%
String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
<%-- 	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div> --%>
                    <script>
	Swal.fire({
		  icon: "warning",
		  title: "Sorry",
		  text: "<%=StringEscapeUtils.escapeHtml4(ses1)%>",
		  allowOutsideClick :false
		});
	</script>
	<%}if(ses!=null){ %>
	<%-- <div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
	</div></div> --%>
	<script>
	Swal.fire({
		  icon: "success",
		  title: "SUCCESS",
		  text: "<%=StringEscapeUtils.escapeHtml4(ses)%>",
		  allowOutsideClick :false
		});
	</script>
    <%} %>
                    
                    
<div class="container-fluid" style="margin-top: -1%;">
	<div class="row">
		<div class="col-md-12">	
		   
			<div class="card shadow-nohover">	
						
					<div class="card-header">						
						<div class="row">										
						
							<h4 style="color:#055C9D" >
						
							Approval Flow for Project <%=initiationdata[6]!=null?StringEscapeUtils.escapeHtml4(initiationdata[6].toString()): " - " %>
							</h4>
							
																	
						
						</div>
					</div>
					
					<div class="card-body">	
					<form action="InitiationForward.htm" method="Post" id="enotefrm">
					<div class="row">
					<!-- <div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important">Reference No. :</label>
					</div> -->
				<%-- 	<div class="col-md-2">
					<input class="form-control" type="text" name="RefNo"  readonly="readonly"
					 value="<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[1]!=null){%><%=CommitteMainEnoteList[1].toString() %><%}else{%><%=committeedata[11]!=null? committeedata[11].toString():"" %> <%}%>">
					<input class="form-control" type="text" name="RefNo"  readonly="readonly" value="">
					
					</div> --%>
					
				
					</div>
				
					<div class="row mt-4">
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important">Subject :</label>
					</div>
					<div class="col-md-5">
					<textarea class="form-control" rows="2" cols="40" name="subject" placeholder="max 500 Characters" maxlength="498"> <%if(ApprovalData!=null && ApprovalData[3]!=null){%><%=ApprovalData[3].toString()%><%}else{%><%} %> </textarea>
					</div>
					
					<div class="col-md-1">
					<label class="control-label" style="margin-bottom: 4px !important">Comment :</label>
					</div>
					<div class="col-md-4">
					<textarea class="form-control" rows="2" cols="30" name="Comment" placeholder="max 500 Characters" maxlength="498"><%if(ApprovalData!=null && ApprovalData[4]!=null){%><%=ApprovalData[4].toString()%><%}else{%><%} %> </textarea>
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-2"><label class="control-label" style="margin-bottom: 4px !important;font-size: 1.2 rem;">Initiated By : </label></div>
					<div class="col-md-3">
					<select class="form-control selectdee" name="InitiatedBy" id="InitiatedBy" onchange="checkNewEmp()">
				<%-- 	<%for(Object[]obj:employeelist){ %>
					<option value="<%=obj[0].toString()%>"   <%if(CommitteMainEnoteList!=null && obj[0].toString().equalsIgnoreCase(CommitteMainEnoteList[17].toString())) {%> selected  <%} %>><%=obj[1].toString() %>, <%=obj[2].toString() %></option>
					<%} %> --%>
					<%for(Object[]obj:employeelist){ %>
					<option value="<%=obj[0].toString()%>"  <%if(obj[0].toString().equalsIgnoreCase(ApprovalData!=null ? ApprovalData[16].toString() :initiationdata[1].toString())) {%>  selected <%}else{ %> disabled="disabled"  <%} %>  ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>
					<%} %>
					</select>
					</div>
					
					</div>
					<div class="row mt-4">
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important;" >Officer1 Role: &nbsp;<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
				
 					<input class="form-control" required="required" maxlength="18" name="Rec1_Role" value="<%if(ApprovalData!=null && ApprovalData[7]!=null) {%><%=StringEscapeUtils.escapeHtml4(ApprovalData[7].toString())%> <%}%>"> 
					</div>
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important">Recommended Officer 1: &nbsp;<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-4">
					<select class="form-control selectdee" name="Recommend1" id="Recommend1" required ="required" title ="Please select officer 1">
					<option   selected value="">SELECT</option>
					<%for(Object[]obj:employeelist){ %>
					<option value="<%=obj[0].toString()%>"  <%if(ApprovalData!=null && ApprovalData[6]!=null &&  obj[0].toString().equalsIgnoreCase(ApprovalData[6].toString())) {%> selected  <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></option>
					<%} %> 
				
					</select>
					</div>
					</div>
					
					<!-- Officer 2 -->
					
					<div class="row mt-4">
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important;">Officer2 Role: &nbsp;</label>
					</div>
					<div class="col-md-2">
					 <input class="form-control" maxlength="18" name="Rec2_Role" id="Rec2_Role" value="<%if(ApprovalData!=null && ApprovalData[9]!=null) {%><%=StringEscapeUtils.escapeHtml4(ApprovalData[9].toString()) %> <%}%>"> 
				
					</div>
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important">Recommended Officer 2: &nbsp;</label>
					</div>
					<div class="col-md-4">
					<select class="form-control selectdee" name="Recommend2" id="Recommend2">
					<option   selected value="">SELECT</option>
					<%for(Object[]obj:employeelist){ %>
					<option value="<%=obj[0].toString()%>"  <%if(ApprovalData!=null && ApprovalData[8]!=null &&  obj[0].toString().equalsIgnoreCase(ApprovalData[8].toString())) {%> selected  <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></option>
					<%} %> 
					
					</select>
					</div>
					</div>
					
					
						<!-- Officer 3 -->
					
					<div class="row mt-4">
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important;">Officer3 Role: &nbsp;</label>
					</div>
					<div class="col-md-2">
		<input class="form-control" maxlength="18" name="Rec3_Role" id="Rec3_Role" value="<%if(ApprovalData!=null && ApprovalData[11]!=null) {%><%=StringEscapeUtils.escapeHtml4(ApprovalData[11].toString()) %> <%}%>"> 
					</div>
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important">Recommended Officer 3: &nbsp;</label>
					</div>
					<div class="col-md-4">
					<select class="form-control selectdee" name="Recommend3" id="Recommend3">
					<option   selected value="">SELECT</option>
					<%for(Object[]obj:employeelist){ %>
					<option value="<%=obj[0].toString()%>"  <%if(ApprovalData!=null && ApprovalData[10]!=null &&  obj[0].toString().equalsIgnoreCase(ApprovalData[10].toString())) {%> selected  <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></option>
					<%} %> 
				
					</select>
					</div>
					</div>
					
					
					
							<!-- Approver -->
					
					<div class="row mt-4">
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important;">Approving Officer Role: &nbsp;<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input class="form-control" name="Approving_Role" maxlength="18" 

					value="<%if(ApprovalData!=null && ApprovalData[13]!=null) {%><%=StringEscapeUtils.escapeHtml4(ApprovalData[13].toString()) %> <%}%>" required="required">
<%-- 					<input class="form-control" name="Approving_Role" maxlength="18" 
					<%if(CommitteMainEnoteList!=null && !forwardstatus.contains(CommitteMainEnoteList[15].toString())) {%> readonly="readonly" <%} %>
					value="<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[14]!=null) {%><%=CommitteMainEnoteList[14].toString() %> <%}%>" required="required"> --%>
					</div>
					<div class="col-md-2">
					<label class="control-label" style="margin-bottom: 4px !important">Approving Officer: &nbsp;<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<select class="form-control selectdee" style="width: 80%;" name="ApprovingOfficerLabCode" id="ApprovingOfficerLabCode" required="required"  onchange="chooseEmp()">
					
					<%for(Object[]obj:AllLabList){ %>
					<option value="<%=obj[3].toString()%>"  <%if(ApprovalData!=null && ApprovalData[21]!=null && ApprovalData[21].toString().equalsIgnoreCase(obj[3].toString()) ) {%> selected  <%} %> ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></option>
					<%} %>
<%-- 					<%for(Object[]obj:AllLabList){ %>
					<option value="<%=obj[3].toString()%>"  <%if (CommitteMainEnoteList!=null &&  CommitteMainEnoteList[22]!=null && obj[3].toString().equalsIgnoreCase(CommitteMainEnoteList[22].toString())) {%> selected  <%} %>><%=obj[3].toString() %></option>
					<%} %> --%>
					</select>
					</div>
					<div class="col-md-3">
					<select class="form-control selectdee" name="ApprovingOfficer" id="ApprovingOfficer" required="required"  
					
					>
				<!-- 	<option   selected value="">SELECT</option> -->
				<%-- 	<%for(Object[]obj:employeelist){ %>
					<option value="<%=obj[0].toString()%>"  <%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[13]!=null &&  obj[0].toString().equalsIgnoreCase(CommitteMainEnoteList[13].toString())) {%> selected  <%} %>><%=obj[1].toString() %>, <%=obj[2].toString() %></option>
					<%} %> --%>
					</select>
					</div>
				
					</div>
					
					<div align="center" style="margin-top:4%;">
				<% if(ApprovalData==null ){%>
					
					<button type="button" onclick="return checkOfficer('S')" class="btn btn-sm submit" name="action" value="Update"

					>submit</button>
					<%} %>
			
				<%if(ApprovalData!=null && forwardstatus.contains(ApprovalData[14].toString())) {%>	
				
					<button type="button" onclick="return checkOfficer('U')" class="btn btn-sm edit" name="action" value="Update"

					>UPDATE</button>
					<% if(ApprovalData!=null ){%>
					<button type="button"  class="btn btn-sm submit" onclick="return checkOfficer('F')" id="Forward">Forward</button>
					<%} %>
					
					<%} %>
						<input type="hidden" name="flow" value="A" id="flow">
					<input id="submit" type="submit"  name="action"  hidden="hidden" />     
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
					<input type="hidden" name="EnoteId" value="<%= ApprovalData!=null?ApprovalData[0].toString():"0" %>">
					<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
					<input type="hidden" name="flag" id="flag" value="UpdateForward">
					
					<%if(ApprovalData!=null && ApprovalData[14].toString().equalsIgnoreCase("FWD")) {%>	
				<button type="submit" name="flow" value="Rev" class="btn btn-sm btn-danger delete" onclick="return Revoke('enotefrm')" >
				REVOKE</button>
				 <%} %> 
					<a class="btn btn-sm back" type="button" href="ProjectIntiationList.htm">BACK</a>
					
					</div>
				
					</form>
						<% if(ApprovalData!=null ){%>
					<div align="center" style="margin-top:1%; display: flex;justify-content: center">
				<form action="#">
				<button type ="submit"  class="btn btn-sm btn-link w-100 btn-status" formaction="InitiationFlowTrack.htm" value="<%=ApprovalData[0]%>" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Transaction History" name="EnoteTrackId" style=" color: <%=ApprovalData[20].toString()%>; font-weight: 600;display: contents" > <%=ApprovalData[19].toString() %> 
				<i class="fa fa-external-link" aria-hidden="true"></i></button>
				</form>
				
				
				<form action="InitiationApprovalPrint.htm" target="_blank" style="margin-left:1%;">
					<button type="submit" class="btn btn-sm edit" style="background: #088395;border-color: #088395" data-toggle="tooltip" data-placement="top" title="Approval Print"><i class="fa fa-download" style="   font-size: 0.90rem;color:white "></i></button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
					<input type="hidden" name="EnoteId" value="<%=ApprovalData[0].toString()%>">
						<input type="hidden" name="InitiationId" value="<%=ApprovalData[5].toString()%>">
						<input type="hidden" name="returnFlag" value="N">
					</form>
				</div>
				<%} %>

					</div>
	 			<%if(NewApprovalList!=null ){ %>
							 	<div class="row mb-3"  style="text-align: center;" >
				                <table  align="center" >
				                	<tr>
				                	
				                		<td class="trup" style="background: #B5EAEA;">
				                		&nbsp;<%if(Arrays.asList("FWD","RC1","RC2","RC3","APR").contains(ApprovalData[14].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %><br>
				                			Initiated By (PDD)
				                			<br>
				                			<%=NewApprovalList[0]!=null?StringEscapeUtils.escapeHtml4(NewApprovalList[0].toString()): " - "  %>
				                		</td>
				                		<%if(NewApprovalList!=null && NewApprovalList[2]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td >
				                		
				                		<td class="trup" style="background: #C6B4CE;">
				                			&nbsp;<%if(Arrays.asList("RC1","RC2","RC3","APR").contains(ApprovalData[14].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %><br>
				                			Recommended Officer 1
				                		
				                			<br>
				                			<%=NewApprovalList[1]!=null?StringEscapeUtils.escapeHtml4(NewApprovalList[1].toString()): " - " %>
				                		</td>
				                		
				                		<%} %>
				                		<%if(NewApprovalList!=null && NewApprovalList[4]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #E8E46E;">
				                			&nbsp;<%if(Arrays.asList("RC2","RC3","APR").contains(ApprovalData[14].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %>
				                		<br>
				                		Recommended Officer 2
				                	
				                		<br>
				                			<%=NewApprovalList[3]!=null?StringEscapeUtils.escapeHtml4(NewApprovalList[3].toString()): " - "  %>
				                		</td>
				                		<%} %>
				                		<%if(NewApprovalList!=null && NewApprovalList[6]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #FBC7F7;" >
				                			&nbsp;<%if(Arrays.asList("RC3","APR").contains(ApprovalData[14].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %>
				                		<br>
				                			Recommended Officer 3
				                		
				                			<br>
				                			<%=NewApprovalList[5]!=null?StringEscapeUtils.escapeHtml4(NewApprovalList[5].toString()): " - " %>
				                		</td>
				                		<%} %>
				                		<%if(NewApprovalList!=null && NewApprovalList[8]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #F4A261;" >
				                		&nbsp;<%if(Arrays.asList("APR").contains(ApprovalData[14].toString()) && ApprovalData[21]!=null && ApprovalData[21].toString().equalsIgnoreCase((String)session.getAttribute("labcode")) ) {%>
				                		<img src="view/images/check.png">
				                		<%} %>
				                		<br>
				                			Approving Officer
				                			<br>
				                			<%=NewApprovalList[7]!=null?StringEscapeUtils.escapeHtml4(NewApprovalList[7].toString()): " - "  %>, <%=NewApprovalList[9]!=null?StringEscapeUtils.escapeHtml4(NewApprovalList[9].toString()): " - "  %>
				                	
				                		</td>
				                		<%} %>
				                			                		
				                	</tr>	
				                	
				                	</table>
				                	
				                <br>
				                
				             <%--    <div class="col-md-12" >
				                <%if(CommitteMainEnoteList[22]!=null && !CommitteMainEnoteList[22].toString().equalsIgnoreCase((String)session.getAttribute("labcode"))){ %>
				                	<%if(NewApprovalList[5]!=null) {%>
				                <h6 style="color:red">Note : This committee will be approved once it receives a recommendation from <%=NewApprovalList[5] %>.</h6>
				                <%}else if(NewApprovalList[3]!=null){ %>
				             <h6 style="color:red">Note : This committee will be approved once it receives a recommendation from <%=NewApprovalList[3] %>.</h6>
				                <%}else if(NewApprovalList[1]!=null){ %>
				             <h6 style="color:red">Note : This committee will be approved once it receives a recommendation from <%=NewApprovalList[1] %>.</h6>
				                <%}} %>
				                </div> --%>	
				                	</div>
					<%} %>
					</div>
					
					</div>
					</div>
					</div>
    
    <script>
    
	function checkOfficer(value){
		var InitiatedBy = Number($('#InitiatedBy').val());
		var Recommend1 = Number($('#Recommend1').val());
		var Recommend2 = Number($('#Recommend2').val());
		var Recommend3 = Number($('#Recommend3').val());
		var ApprovingOfficer = Number($('#ApprovingOfficer').val());
		var Rec2_Role = $('#Rec2_Role').val().trim();
		var Rec3_Role = $('#Rec3_Role').val().trim();
		
		if(Recommend3!==0 && Recommend2===0){
			Swal.fire({
				  icon: "error",
				  title: "Oops...",
				  text: "Recommended Officer 2 field can not be empty despite having Recommended Officer 3!",
				  allowOutsideClick :false
				});
	
			return false;
		}
		if(Recommend2!==0 && !Rec2_Role.length>0){
			Swal.fire({
				  icon: "error",
				  title: "Oops...",
				  text: "Recommended Officer 2 role can not be empty!",
				  allowOutsideClick :false
				});
			 $('#Rec2_Role').focus();
			return false;
		}
		if(Recommend3!==0 && !Rec3_Role.length>0){
			Swal.fire({
				  icon: "error",
				  title: "Oops...",
				  text: "Recommended Officer 3 role can not be empty!",
				  allowOutsideClick :false
				});
			
			 $('#Rec3_Role').focus();
			return false;
		}
		console.log(Rec2_Role.length)
		console.log(Rec3_Role.length)
		
		
		var array = Array.of(InitiatedBy, Recommend1, Recommend2, Recommend3, ApprovingOfficer);
		

/* 	
		for(var i=0;i<array.length-1;i++){
			if(array[i]!==0){
				for(var j=i+1;j<array.length;j++ ){
					if(array[i]===array[j]){
						Swal.fire({
							  icon: "error",
							  title: "Oops...",
							  text: "You can not choose same person for different roles.",
							  allowOutsideClick :false
							});
				
						return false;
					}
				}
			}
			
		} */
		
		if(value==='S'){
			var msg ="Are you sure to submit?"
				$('#submit').val('SUBMIT');
		}
	
		else if(value==='U'){
			var msg ="Are you sure to submit?"
					$('#submit').val('UPDATE');
		}else{
			var msg ="Are you sure to forward?"
				$('#submit').val('Forward');
		}
		
		
		/* if(confirm(msg)){
			$('#submit').click();
		}else{
			event.preventDefault();
		} */
		
		 event.preventDefault(); // Prevent the default action initially

	        Swal.fire({
	            title: msg,
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: 'green',
	            cancelButtonColor: '#d33',
	            confirmButtonText: 'Yes'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                $('#submit').click(); // Trigger the submit action
	            } else {

					event.preventDefault();
	                console.log("Action cancelled");
	            }
	        });
	}
	
	
	$(function () {
		$('[data-toggle="tooltip"]').tooltip();
		} )
	
	$( document ).ready(function() {
		
		
		
		<%if(ApprovalData!=null && ApprovalData[12]!=null ){%>
		
		var value = "<%=ApprovalData[12].toString()%>"
		var labcode= "<%=ApprovalData[21].toString()%>"
			$('#ApprovingOfficerLabCode').val(labcode+"")
		chooseEmp(value);
		<%}else{%>
		var labcodeVal = "<%=labcode%>"

		$('#ApprovingOfficerLabCode').val(labcodeVal+"")
			chooseEmp(labcodeVal);
		<%}%>
	});
	
	function chooseEmp(value){

		
		var labCode=$('#ApprovingOfficerLabCode').val();
		$.ajax({
				
				type : "GET",
				url : "ActionAssigneeEmployeeList.htm",
				data : {
					LabCode : labCode,	
				},
				datatype : 'json',
				success : function(result) {
					var result = JSON.parse(result);
					var values = Object.keys(result).map(function(e) {
						return result[e]
					});
				
				
					var s = '';
					s += '<option   value="">SELECT</option>';
				/* 	if($AssigneeLabCode == '@EXP'){
						
					} */
					for (i = 0; i < values.length; i++) 
					{

						s += '<option value="'+values[i][0]+'">'+values[i][1] + ', ' +values[i][3] + '</option>';
					} 
					
					$('#ApprovingOfficer').html(s);
				 $('#ApprovingOfficer').val(''+value).trigger('change'); 
				}
			});
	}
    
	
	function Revoke(enotefrm){
		
		$('#flow').val('REV');
		$('#submit').val('REV');
		/* if(confirm('Are you sure to revoke?')){
			$('#enotefrm').submit();
		}else{
			event.preventDefault();
		} */
		
		 event.preventDefault(); // Prevent the default action initially

	        Swal.fire({
	            title: 'Are you sure to revoke?',
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: 'green',
	            cancelButtonColor: '#d33',
	            confirmButtonText: 'Yes'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                $('#submit').click(); // Trigger the submit action
	            } else {
	            	event.preventDefault();
	                console.log("Action cancelled");
	            }
	        });
	}
    </script>    
        
            
</body>
</html>