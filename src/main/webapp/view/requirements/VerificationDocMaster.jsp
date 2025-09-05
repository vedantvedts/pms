<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<style type="text/css">
.control-label{
    font-weight: 600 !important;
    font-size: 15px;
}
#myTable2_wrapper{
width: 98% !important;
}
</style>

<%
List<Object[]>VerifiyMasterList = (List<Object[]>)request.getAttribute("VerifiyMasterList");
List<Object[]>verificationDataList = (List<Object[]>)request.getAttribute("verificationDataList");
String projectId =(String)request.getAttribute("projectId");
String initiationid =(String)request.getAttribute("initiationid");
String reqInitiationId =(String)request.getAttribute("reqInitiationId");
String projectType =(String)request.getAttribute("projectType");
String verificationId =(String)request.getAttribute("verificationId");
%>
</head>
<body>

     <nav class="navbar navbar-light bg-light justify-content-between" style="margin-top: -1%">
			<a class="navbar-brand"> 
			<b style="color: #585858; font-size: 19px; font-weight: bold; text-align: left; float: left">
			<span style="color: #31708f">Verification Method for Project </span>
			</b>
			</a>
			<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="projectId" value="<%=projectId%>">
			<input type="hidden" name="initiationId" value="<%=initiationid%>">
			<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
			<button class="btn btn-info btn-sm  back ml-2 mt-1" formaction="RequirementList.htm" formmethod="get" formnovalidate="formnovalidate" style="float: right;">BACK</button>
			</form>
		</nav>

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

	<div class="card mt-3" style="">
		<div class="col-md-10 row">
			<div class="col-md-3">
				<div class="requirementid mt-2 ml-2">
					<%
					for (Object[] obj : VerifiyMasterList) {
					%>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2"
						onclick="showDemonstration('<%=obj[0]%>','<%=obj[1]%>')"><img
						alt="" src="view/images/requirements.png">&nbsp;&nbsp;<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></span>
					<%
					}
					%>
				</div>
			</div>
			<div class="col-md-7 mt-3">
				<div class="col-md-5 justify-content-end"
					style="float: right; margin-top: -0.50rem;">
					<div class="form-inline" style="margin-bottom: 1rem;">
						<table>
							<tbody>
								<tr>
									<td style="border: 0"><label class="control-label"
										style="font-size: 17px; font-weight: bold;">Verification:&nbsp;&nbsp; </label></td>
									<td style="border: 0">
										<form method="post" action="RequirementVerifyMaster.htm" id="verifychange">
											<select class="form-control selectdee"
												required="required" style="width: 200px;" name="verificationId"
												data-live-search="true" data-container="body"
												onchange="submitForm('verifychange');">
												<%
												for (Object[] obj : VerifiyMasterList) {
													%>
													<option <%if(verificationId!=null && verificationId.equalsIgnoreCase(obj[0].toString())) {%>selected="selected"<%} %> value="<%=obj[0]%>">
														<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>
													</option>
													<%
													}
													%>
											</select> 
														<input type="hidden" name="projectId" value=<%=projectId %>>
														<input type="hidden" name="initiationId" value=<%=initiationid %>>
														<input type="hidden" name="reqInitiationId" value=<%=reqInitiationId %>>
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
										</form>
									</td>
								</tr>
						</table>
					</div>
				</div>

			<div class="table-responsive" style="width: 160%">
				<form action="RequirementVerifyDataEdit.htm" method="post">
					<table class="table table-bordered table-hover table-striped table-condensed"
						id="myTable2" style="width:100%">
						<thead style="text-align: center;">
							<tr>
							<td>SN</td>
								<td>Code</td>
								<td>Type of Test</td>
								<td>Purpose</td>
								<td>Action</td>
							</tr>
						</thead>
						<%
						if (verificationDataList != null && verificationDataList.size()>0) {
							int sn=0;
							for (Object[] obj1 : verificationDataList) {
							++sn;
						%>
						<tr>
							<td style="text-align: center;"><%=sn %>.</td>
							<td style="text-align: center;"> <%=obj1[1]!=null?StringEscapeUtils.escapeHtml4(obj1[1].toString()).substring(0,1)+(sn):" - "%></td>
							<td style="width: 30%">
							<textarea rows="" cols="" class="form-control" name="TestType<%=obj1[0] %>" required="required"><%=obj1[2]!=null?obj1[2].toString(): " - "%></textarea>
							</td>
							<td>
							<textarea rows="" cols="" class="form-control" name="Purpose<%=obj1[0] %>" required="required"><%=obj1[3]!=null?obj1[3].toString(): " - "%></textarea>
							</td>
							<td style="text-align: center;width:8%">
							   <button class="fa fa-pencil-square-o btn " type="submit" name="verificationDataId" value="<%=obj1[0] %>"  onclick="return confirm('Are You Sure To Edit ?');"></button>
					  
					             <input type="hidden" name="verificationMasterId" value="<%=obj1[4]%>">
					      	<input type="hidden" name="projectId" value=<%=projectId %>>
					<input type="hidden" name="initiationId" value=<%=initiationid %>>
					<input type="hidden" name="reqInitiationId" value=<%=reqInitiationId %>>
					             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							</td>
						</tr>
						<%
						}
						}
						%>
					</table>
					</form>
				</div>
				
			</div>
		</div>
	</div>


<form method="post" action="RequirementVerifyDataAdd.htm">
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
		id="verificationModal" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="width: 170%; margin-left: -35%;">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				<div id="btnplus">
					<button type="button" class=" btn btn_add" onclick="copyDiv()"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
			    </div> 
				  <div class="divHidden mt-3" id="divHidden" style="width: 95%">
					 <div class="row col-md-12" style="margin-top:5px; margin-left: -4rem;">
		                <div class="col-md-2"><label class="control-label">Type of Test :</label></div>
		                <div class="col-md-4" style="margin-left: -6rem;"><textarea class="form-control" name="TestType" id="TestType" placeholder="Max 500 Characters"></textarea></div>
		                <div class="col-md-1"><label class="control-label">Purpose :</label></div>
		                <div class="col-md-5" style="margin-left: -1rem"><textarea class="form-control" name="Purpose" id="Purpose" placeholder="Max 1000 Characters" style="width: 137%"></textarea></div>
		                <div class="col-sm-1">
		                 <span ><button type="button" id="btnminus" class=" btn btn_rem" onclick="RemoveDiv(this)" style="margin-left: 10rem;"> 
		                 <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i>
		                 </button></span>
		                </div>
					 </div>
				
					<input type="hidden" id="verifyId" name="verificationId" value="">
					      	<input type="hidden" name="projectId" value=<%=projectId %>>
					<input type="hidden" name="initiationId" value=<%=initiationid %>>
					<input type="hidden" name="reqInitiationId" value=<%=reqInitiationId %>>
					</div>

					<div align="center">
						<button type="submit" class="btn btn-sm btn-success submit mt-4"
							onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button>
					     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</div>
                      
				</div>
			</div>
		</div>
	</div>
	</form>


	<%-- <div class="modal fade" id="exampleModalAction" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="#" method="post">
						<div class="row">
							<div class="col-md-3">
								<label
									style="font-family: 'Lato', sans-serif; font-weight: 700; font-size: 16px">Type of Test
									:</label>
							</div>
							<div class="col-md-4" style="margin-left: -6%;">
								<textarea class="form-control" name="TestType" id="TestType"></textarea>
							</div>
						</div>
						<div class="row mt-4">
							<div class="col-md-3">
								<label
									style="font-family: 'Lato', sans-serif; font-weight: 700; font-size: 16px">
									Purpose :</label>
							</div>
							<div class="col-md-8" style="margin-left: -6%;">
								<textarea class="form-control" name="Purpose" id="Purpose" "></textarea>
							</div>
						</div>
						<br>
						<div align="center">
							<button type="submit" class="btn btn-sm submit"
								onclick="return confirm('Are you sure To Submit?')">Submit</button>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div> --%>


</body>
<script type="text/javascript">
function showDemonstration(verId,verName){
	$('#verificationModal').modal('show');
	$('#verificationModal .modal-title').html('<span style="color: #C2185B;font-size: 24px;font-weight:600">'+verName);
    $('#verifyId').val(verId);
}

var elements=document.getElementById("divHidden").innerHTML;
console.log(elements);

function copyDiv(){
	
	 $(".divHidden").append('<div class="appendedDiv">' + elements + '</div>');

}

function RemoveDiv(btn) {
    var appendedDivs = document.querySelectorAll('.divHidden .appendedDiv');
    if (appendedDivs.length > 0) {
        // Remove the last appended div
        var lastAppendedDiv = appendedDivs[appendedDivs.length - 1];
        lastAppendedDiv.remove();
    } else {
        console.error("No appended divs found");
    }
}
</script>
<script type="text/javascript">
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 

$(document).ready(function(){
	  $("#myTable2").DataTable({
	 "lengthMenu": [10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});

/* function actionEditform(){
	$('#exampleModalAction').modal('show');   
} */
</script>
</html>