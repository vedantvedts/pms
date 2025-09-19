<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
.star {
  font-size: 40px;
  color: #ccc; /* Default star color */
  cursor: pointer;
}

.star:hover,
.star:hover ~ .star {
  color: gold; /* Hover color */
}

.star.selected,
.star.selected ~ .star {
  color: gold; /* Selected stars */
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
List<Object[]> preProjectList = (List<Object[]>) request.getAttribute("preProjectList");
String projectId=(String)request.getAttribute("projectId");
String projectType = (String)request.getAttribute("projectType");
String initiationId =(String)request.getAttribute("initiationId");
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
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				 <form method="post" id="myFrom">
					<div class="card-header position-relative p-0">
					    <!-- Left: RFA List Title -->
					    <h5 class="mb-0" style="position: absolute; left: 15px; top: 50%; transform: translateY(-50%);">RFA List</h5>
					
                            <div class="d-flex justify-content-center flex-wrap" style="margin-bottom: 10px">
					        <!-- Project Type -->
					        <div class="d-flex align-items-center mx-2 my-1">
					            <label for="projectType" class="mr-2 font-weight-bold" style="font-size: 17px;">Project Type:</label>
					            <select class="form-control selectdee" id="projectType" name="projectType">
					                <option disabled selected value="">Choose...</option>
					                <option value="P" <%if(projectType.equalsIgnoreCase("P")){ %> selected <% }%>>Project</option>
					                <option value="I" <%if(projectType.equalsIgnoreCase("I")){ %> selected <% }%>>Pre Project</option>
					            </select>
					        </div>
					
					        <!-- Project -->
					        <div class="d-flex align-items-center mx-2 my-1">
					            <label for="projectId" class="mr-2 font-weight-bold" style="font-size: 17px;">Project:</label>
					            <% if(projectType.equalsIgnoreCase("P")) { %>
					                <select class="form-control selectdee" name="projectId" id="projectId" required data-live-search="true">
					                    <option value="A" <%if(projectId.equalsIgnoreCase("A")){%> selected <%}%>>ALL</option>
					                    <% for(Object[] obj : ProjectList) {
					                        String projectshortName = (obj[17] != null) ? " ( " + obj[17].toString() + " ) " : "";
					                    %>
					                        <option value="<%=obj[0]%>" <%if(projectId.equalsIgnoreCase(obj[0].toString())){ %> selected <% } %>><%=(obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - ")%> <%= projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):" - " %></option>
					                    <% } %>
					                </select>
					            <% } else { %>
					                <select class="form-control selectdee" id="initiationId" name="initiationId" data-live-search="true">
					                    <option value="A" <%if(initiationId.equalsIgnoreCase("A")){%> selected <%}%>>ALL</option>
					                    <% if(preProjectList != null && preProjectList.size() > 0) {
					                        for(Object[] obj : preProjectList) { %>
					                            <option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(initiationId)) { %> selected <% } %>><%= (obj[3] != null ? StringEscapeUtils.escapeHtml4(obj[3].toString()) : " - ") + " ( " + (obj[2] != null ? StringEscapeUtils.escapeHtml4(obj[2].toString())  : " - ") + " )"%></option>
					                    <% } } %>
					                </select>
					            <% } %>
					        </div>
					
					        <!-- RFA Status -->
					        <div class="d-flex align-items-center mx-2 my-1">
					            <label for="Status" class="mr-2 font-weight-bold" style="font-size: 17px;">RFA Status:</label>
					            <select class="form-control selectdee" name="Status" id="Status" required>
					                <option value="A" <%if("A".equalsIgnoreCase(Status)) {%> selected <% } %>>All</option>
					                <option value="O" <%if("O".equalsIgnoreCase(Status)) {%> selected <% } %>>Open</option>
					                <option value="C" <%if("C".equalsIgnoreCase(Status)) {%> selected <% } %>>Close</option>
					                <option value="CAN" <%if("CAN".equalsIgnoreCase(Status)) {%> selected <% } %>>Cancel</option>
					            </select>
					        </div>
			
					   </div>
					</div>

                 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<div class="card-body">
						     <div class="d-flex justify-content-end align-items-center">
						        <!-- From Date -->
						        <div class="form-group mb-2 mr-4 d-flex align-items-center">
						            <label for="fdate" class="control-label mb-0 mr-2" style="font-size: 17px; font-weight: 700;">From Date:</label>
						            <input type="text" class="form-control" data-date-format="dd/mm/yyyy" id="fdate" name="fdate" 
						                   required="required" value="<%=sdf.format(sdf1.parse(fdate))%>" style="width: 150px;">
						        </div>
						
						        <!-- To Date -->
						        <div class="form-group mb-2 d-flex align-items-center">
						            <label for="tdate" class="control-label mb-0 mr-2" style="font-size: 17px; font-weight: 700;">To Date:</label>
						            <input type="text" class="form-control" data-date-format="dd/mm/yyyy" id="tdate" name="tdate" 
						                   required="required" value="<%=sdf2.format(sdf3.parse(tdate))%>" style="width: 150px;">
						        </div>
						     </div>

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
										
											<td style="text-align: center;"><%=++i %> <input type="hidden" name="createdBy" value="<%= obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):""%>"> </td>
											<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - " %></td>
											<td style="text-align: center;"><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
											<td style="text-align: center;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - " %></td>
											<td style="text-align: center;"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):" - " %></td>
											<td>
											<%if(AssigneeList!=null ){ 
												for(Object[] obj1 : AssigneeList){
													if(obj1[0].toString().equalsIgnoreCase(obj[0].toString())){
													%>
											      <p style="margin-bottom:0px !important;"> <%=  (obj1[1] != null ? StringEscapeUtils.escapeHtml4(obj1[1].toString())  : " - ") + ","+ (obj1[2] != null ? StringEscapeUtils.escapeHtml4(obj1[2].toString())  : " - ")%> (<%=obj1[4]!=null?StringEscapeUtils.escapeHtml4(obj1[4].toString()):" - " %>) </p>          
											<% }}}%>
											</td>
											<td style="text-align: center;">
	                                       	  	<button type="submit" class="btn btn-sm btn-link btn-status" formaction="RfaTransStatus.htm" value="<%=obj[0] %>" name="rfaTransId"  data-toggle="tooltip" data-placement="top" title="Transaction History" 
	                                       	  	style=" color: #E65100; font-weight: 600;" formtarget="_blank"><%=obj[17]!=null?StringEscapeUtils.escapeHtml4(obj[17].toString()):" - " %> 
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
												%>  <%
					                       if(obj[11].toString().equalsIgnoreCase(UserId) && toUserStatus.contains(obj[14].toString())){%>
				                         <button class="editable-click"  style="background-color: transparent; name="rfa" value="<%=obj[0]%>" 
											type="button"	data-toggle="tooltip" data-placement="top" id="rfaCloseBtn" 
											onclick="forwardmodal('<%=obj[3]%>',<%=obj[0]%>,'<%=obj[13]%>','<%=obj[19]%>')" title="" data-original-title="FORWARD RFA">
												<div class="cc-rockmenu" >
														<figure class="rolling_icon" >
															<img src="view/images/forward1.png">
														</figure>
												</div>
											</button>
										
												
	                                      <% }if(obj[11].toString().equalsIgnoreCase(UserId) && (obj[14].toString().equalsIgnoreCase("AF") || obj[14].toString().equalsIgnoreCase("AX"))){
	                                      %>
												<button data-original-title="REVOKE RFA" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;" data-toggle="tooltip" data-placement="top"
													formaction="RfaActionReturnList.htm" formmethod="POST"
													formnovalidate="formnovalidate"  id="rfaRevokeBtn"
													onclick="return returnRfa(<%=obj[0]%>,'<%=obj[14]%>','<%=obj[15]%>','<%=obj[13]%>','<%=obj[19]%>')">
												  <i class="fa fa-backward" aria-hidden="true" style="color: #007bff; font-size: 24px; position: relative; top: 5px;"></i>
												</button> 
													<input type="hidden" name="rfa" id="rfaHidden">
 													<input type="hidden" name="RfaStatus" id="RfaStatusHidden">
      												<input type="hidden" name="assignor" id="assignorId">
      												<input type="hidden" name="revokeProjType" id="pType">
      												<input type="hidden" name="revokeProjId" id="pId">
	                                    <% } if(Integer.valueOf(obj[16].toString())>0 && obj[11].toString().equalsIgnoreCase(UserId) || obj[14].toString().equalsIgnoreCase("RFC")){ %>
													<button title="REMARKS" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formnovalidate="formnovalidate" name="rfa" id="rfaRemarksBtn"
													value="<%=obj[0]%>"
													onclick="return rfaRemarks(<%=obj[0]%>,'<%=obj[14]%>')">
													<i class="fa fa-comment" aria-hidden="true" style="color: #143F6B; font-size: 24px; position: relative; top: 5px;"></i>
												    </button> 
											 <%} %>
											 <%if(toUserStatus.contains(obj[14].toString().toString()) && obj[15].toString().equalsIgnoreCase(EmpId)){ %>
											 	<button type="button" class="editable-click"  style="background-color: transparent;" 
												name="RFAID" value="<%=obj[0]%>" formaction="#" formmethod="POST"
												onclick="returnCancelRfa(<%=obj[0]%>,'<%=obj[13]%>','<%=obj[14]%>','<%=obj[15]%>','<%=obj[19]%>');"
													data-toggle="tooltip" data-placement="top" id="rfaCancelBtn" title="" data-original-title="CANCEL RFA">
												<div class="cc-rockmenu" >
														<figure class="rolling_icon" >
															<img src="view/images/close.png" id="closeImg">
														</figure>
												</div>
											   </button>
											   <input type="hidden" name="rfaoptionby" value="RFC" >
											<%} %>
											
											 <%if((obj[14].toString().equalsIgnoreCase("AP") && obj[15].toString().equalsIgnoreCase(EmpId)) ){ %>
											 	<button type="button" class="editable-click btn btn-sm btn-info"  style="" 
												onclick="closeModal('<%=obj[0].toString() %>','<%=obj[3] %>','<%=obj[2].toString() %>','<%=obj[18] %>','<%=obj[13] %>','<%=obj[19] %>')"
													data-toggle="tooltip" data-placement="top" id="rfaCancelBtn" title="" data-original-title="CLOSE RFA">
										                   	CLOSE
											   </button>
											   <input type="hidden" name="rfaoptionby" value="ARC" >
											<%} %>
											 <%if((obj[14].toString().equalsIgnoreCase("AV") && obj[18].toString().equalsIgnoreCase("E")) ){ %>
											 	<button type="button" class="editable-click btn btn-sm btn-info"  style="" 
												onclick="closeModal('<%=obj[0].toString() %>','<%=obj[3] %>','<%=obj[2].toString() %>','<%=obj[18] %>','<%=obj[13] %>','<%=obj[19] %>')"
													data-toggle="tooltip" data-placement="top" id="rfaCancelBtn" title="" data-original-title="CLOSE RFA">
										                	CLOSE
											   </button>
											   <input type="hidden" name="rfaoptionby" value="ARC" >
											   											   <input type="hidden" name="rfaoptionby" value="ARC" >
											<%} %>
											</td>
										</tr>
										<%}} %>
									</tbody>
								</table>
							</div>
						</div>
						<div align="center" style="margin-bottom: 20px">
								
							<button class="btn add" type="button" formaction="RfaActionAdd.htm" name="sub" value="add" onclick="addRfa()" id="addRfaBtn">ADD</button>
						  	<input type="hidden" name="projectId" value="<%=projectId%>">
						  	<input type="hidden" name="projectType" value="<%=projectType%>">
						  	<input type="hidden" name="initiationId" value="<%=initiationId%>">
						  
							<a class="btn btn-info shadow-nohover back" href="MainDashBoard.htm">BACK</a>
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
							<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
							<input type="hidden" name="rfano1" id="rfanomodal" value=""> 
							<input type="submit" name="sub" class="btn  btn-sm submit" form="specadd" id="rfaforwarding" value="SUBMIT"
								onclick="return confirm('Are you sure To Submit?')" /> 
							<input type="hidden" name="RFAID" id="RFAID">
							<input type="hidden" name="projectType" id="proType">
							<input type="hidden" name="projectId" id="proId">
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
									    <div class="col-md-12">
									        <label class="control-label returnLabel" style="font-weight: 600; font-size: 16px;">
									            Reason For Cancel <span class="mandatory" style="color: #cd0a0a;">*</span>
									        </label>
									        <textarea class="form-control mt-2" rows="4" cols="30"
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
                                    <input type="hidden" name="revokeProjType" id="cancelProjectType">
                                    <input type="hidden" name="revokeProjId" id="cancelProjectId">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
 <!-- Cancel Modal Remarks End -->	
		
		
	
<div class="modal fade" id="closeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" style="width:180%;margin-left:-30%;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">RFA Close</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form action="RfaActionClose.htm" enctype="multipart/form-data" method="post">
           <div class="row" id="AttachementRow">
		                  <div class="col-md-3">
		                      <label class="control-label" style="font-weight: 800;font-size: 16px;color:#07689f;">Attachment</label><span class="mandatory" style="color: #cd0a0a;">*</span>
		                  </div>
		                  <div class="col-md-9">
		                      <input class="form-control" type="file" name="attachment"  id="attachment" accept="application/pdf , image/* "  required="required"
		                      oninput="validateFile(this)">
		                  </div>
		                  <div id="filealert"></div>
		            </div>
		             <div class="row mt-2">
		                  <div class="col-md-3">
		                      <label class="control-label" style="font-weight: 800;font-size: 16px;color:#07689f;">Remarks</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                  </div>
		                  <div class="col-md-9">
		                       <textarea class="form-control" rows="2" cols="30" placeholder="Max 250 Characters" name="remarks" id="reference" maxlength="250" required="required"></textarea>
		                      
		                  </div>
		            </div>
		           
		    <div align="center" class="mt-2 mb-2">
				    <button class="btn btn-sm submit" name="rfaoptionby" value="ARC" type="submit"  onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
				    <button id="retrunbtn" class="btn btn-sm btn-danger" name="rfaoptionby" value="RFR" type="submit"  onclick="return confirm('Are you sure to return?')">RETURN</button>
				    <input type="hidden" id="rfaidClose" name="RFAID">
				    <input type="hidden" id="rfanoClose" name="rfano">
				    <input type="hidden" id="rfaprojectCode" name="projectCode">
				    <input type="hidden" id="rfaprojectType" name="projectType">
				    <input type="hidden" id="rfaprojectId" name="projectId">
				    <!--  <input type="hidden" name="rfaoptionby" value="ARC" > -->
				    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    </div>
		   </form>	         
      </div>
    
    </div>
  </div>
</div>

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
		   $('#fdate, #tdate,#projectId,#Status,#projectType,#initiationId').change(function(){
			   var form = document.getElementById("myFrom");
			 
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
						
function returnRfa(rfaId,RfaStatus,createdBy,projectId,projectType) {
	$('#rfaHidden').val(rfaId);
	$('#RfaStatusHidden').val(RfaStatus);
	$('#assignorId').val(createdBy);
	$('#pType').val(projectType);
	$('#pId').val(projectId);
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
		            if(row[1]!==null){
		            ReplyAttachTbody += '<tr>';
		            ReplyAttachTbody += '<td id="remarksTd1">'+row[0].replaceAll("<","").replaceAll(">","").replaceAll("/","")+' &nbsp; <span id="remarksDate"> '+fDate(row[2])+'</span>';
		            ReplyAttachTbody += '</td>';
		            ReplyAttachTbody += '</tr>';
		            ReplyAttachTbody += '<tr>';
		            ReplyAttachTbody += '<td id="remarksTd2">  '+row[1].replaceAll("<","").replaceAll(">","").replaceAll("/","")+'';
		            ReplyAttachTbody += '</td>';
		            ReplyAttachTbody += '</tr>';
		        	}
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

function forwardmodal(rfanomodal,RFAID,projectId,projectType){
         $('#rfamodalval').html(rfanomodal);
         $('#RFAID').val(RFAID);
         $('#proType').val(projectType);
         $('#proId').val(projectId);
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

function returnCancelRfa(rfaId,projectId,RfaStatus,assignee,projectType) {
	$('#rfaCancelmodal').modal('show');
	$('#rfaIdHidden').val(rfaId);
	$('#StatusHidden').val(RfaStatus);
	$('#assignorHidden').val(assignee);
	$('#cancelProjectId').val(projectId);
	$('#cancelProjectType').val(projectType);
}

function closeModal(a,b,c,rfatype,projId,projtype){
	$('#closeModal').modal('show');
	$('#rfaidClose').val(a);
	$('#rfanoClose').val(b);
	$('#rfaprojectCode').val(c);
	$('#rfaprojectType').val(projtype);
	$('#rfaprojectId').val(projId);
	
	if(rfatype==='E'){
		$('#AttachementRow').show();
		$('#retrunbtn').hide();
		$('#attachment').prop("required",true)
	}else{
		$('#AttachementRow').hide();
		$('#retrunbtn').show();
		$('#attachment').prop("required",false)
	}
}
function validateFile(input) {
	  const file = input.files[0];
	  const allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];

	  if (!file) return;

	  if (!allowedTypes.includes(file.type)) {
	    document.getElementById('filealert').innerText = 'Only image and PDF files are allowed!';
	    // Clearing the file input to prevent submission
	    input.value = '';
	  } else {
	    document.getElementById('filealert').innerText = '';
	  }
	}
</script>

</html>