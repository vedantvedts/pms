<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
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
<%-- <spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" /> --%>
<style>
#MyTable>thead {
	background: #055C9D;
	color: white;
}
</style>
</head>
<body>
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy - hh:mm:ss");
	List<Object[]> RequirementApprovalList = (List<Object[]>) request.getAttribute("RequirementApprovalList");
	%>

	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>


	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>
	</div>
	<%
	}
	%>
	<div class="container-fluid" style="display:" id="main">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-9" id="projecthead">
							<h5 style="margin-left: 1%;">Project Document Approval List
							</h5>
						</div>
					</div>
					<div class="card-body bg-light" id="cardbody">
						<table
							class="table table-bordered table-hover table-striped table-condensed "
							id="MyTable">
							<thead>
								<tr>
									<th style="width: 2%">SN</th>
									<th style="width: 10%">Project Code</th>
									<th style="width: 15%; text-align: center">Document Number</th>
									<th style="width: 25%; text-align: center">Action</th>
									<th style="width: 40%; text-align: center">Recommendation</th>
									<th style="width: 8%; text-align: center">Attachment</th>
								</tr>
							</thead>
							<tbody>
								<%
								int i = 0;
								if (!RequirementApprovalList.isEmpty()) {
								for (Object[] obj : RequirementApprovalList) {
								%>
								<tr>
									<td align="center"><%=++i%></td>
									<td><%=obj[3].toString()%></td>
									<td style="text-align: center;"><%=obj[7].toString()%></td>
									<td>
										<%
										if(obj[1].toString().equalsIgnoreCase("RFU")) {
										%> Created By: &nbsp;<%=obj[5].toString()%><br> Date:&nbsp;<%=sdf.format(obj[6])%>
										<%
										}
										%> <%
 										if (obj[1].toString().equalsIgnoreCase("RFD")) {
 										%> Reviewed By: &nbsp;<%=obj[5].toString()%><br> Date: &nbsp;<%=sdf.format(obj[6])%>
										<%
										}
										%> <br> <%
 										if (obj[2].toString().equalsIgnoreCase("")) {
 										%>Remarks : &nbsp; No remarks <%
 										} else {
 										%>
										<%="Remarks : " + obj[2].toString()%> <%
 										}
 										%>
									</td>
									<td align="center">
										<form action="#">
											<textarea rows="2" cols="25" class="form-control"
												name="Remarks" maxlength="200" placeholder="Enter remarks here( max 250 characters )" 
												style="width:80%;"
												></textarea>
											<div align="center">
												<input type="hidden" name="projectcode"
													value="<%=obj[3].toString()%>"> <input
													type="hidden" name="initiationid"
													value="<%=obj[0].toString()%>"> <input
													type="hidden" name="status" value="<%=obj[1].toString()%>">
												<button class="btn btn-sm btn-success mt-1" name="option" value="A"
													style="font-weight: 500"
													formaction="RequirementForward.htm" formmethod="GET"
													formnovalidate="formnovalidate"
													onclick="return confirm('Are You Sure To Forward this Project Document?');">
													<%
													if (obj[1].toString().equalsIgnoreCase("RFU")) {
													%>Forward<%
													} else {
													%>Approve<%
													}
													%>
												</button>
												<button 
													formaction="RequirementForward.htm" formmethod="GET"
													formnovalidate="formnovalidate"
													onclick="return confirm('Are You Sure To return this Project Document?');"
												class="btn btn-sm btn-danger mt-1" name="option" value="R" style="font-weight: 500">Return</button>
											</div>
										</form>
									</td>
									<td align="center"><form action="#">
											<input type="hidden" name="_csrf"
												value="50354352-6cae-46da-bad1-c79a69ae2f31"> <input
												type="hidden" name="projectshortName" value="AMND">
											<input type="hidden" name="initiationid"
												value="<%=obj[0].toString()%>"> <span
												id="downloadform">
												<button type="submit" class="btn btn-sm" formmethod="GET"
													style="margin-top: -3%; display: block;"
													formtarget="_blank"
													formaction="RequirementDocumentDownlod.htm"
													data-toggle="tooltip" data-placement="top" title=""
													data-original-title="Download file">
													<i class="fa fa-download fa-sm" aria-hidden="true"></i>
												</button>
											</span>
										</form></td>
										</tr>
								<%}}else{ %>
								<tr>
									<td colspan="6" align="center">No data Available</td>
								</tr>
								<%} %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})
</script>
</html>