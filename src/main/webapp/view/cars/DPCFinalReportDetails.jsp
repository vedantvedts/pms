<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/cars/DPCFinalReportDetails.css" var="dpcfinalreport" />
<link href="${dpcfinalreport}" rel="stylesheet" />

</head>
<body>
<%
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 

FormatConverter fc = new FormatConverter();
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

	<div class="container">
		<div class="row" >
			<div class="col-md-12">
				<div class="card shadow-nohover" >
	        
					<div class="card-body">
	        		
						<form action="CARSFinalReportEditSubmit.htm" method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
					    	<div class="row">
					        	<div class="col-md-2">
					        		<div class="form-group">
					                	<label class="control-label">Contract Date:</label><span class="mandatory">*</span>
					                    <input  class="form-control form-control" type="text" name="contractDate" id="contractDate"
					                     value="<%if(carsContract!=null && carsContract.getContractDate()!=null){ %><%=fc.SqlToRegularDate(carsContract.getContractDate())%><%} %>" required readonly> 
					                </div>
					            </div>
					        	<div class="col-md-2">
					        		<div class="form-group">
					                	<label class="control-label">T0 Date:</label><span class="mandatory">*</span>
					                    <input  class="form-control form-control" type="text" name="t0Date" id="t0Date"
					                     value="<%if(carsContract!=null && carsContract.getT0Date()!=null){ %><%=fc.SqlToRegularDate(carsContract.getT0Date())%><%} %>" required readonly> 
					                </div>
					            </div>
					        	<div class="col-md-8" >
					        		<div class="form-group">
					                	<label class="control-label">T0 Remarks</label><span class="mandatory">*</span>
					                    <input  class="form-control form-control" type="text" name="t0Remarks" id="t0Remarks"
					                     value="<%if(carsContract!=null && carsContract.getT0Remarks()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsContract.getT0Remarks())%><%} %>" required> 
					                </div>
					            </div>
					        </div>
					        <div class="row">
					        
					        </div>
					    	<div align="center">
								<%if(carsContract!=null && carsContract.getContractNo()!=null){ %>
									<input type="hidden" name="firstTime" value="N">
									<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
								<%}else{ %>
									<input type="hidden" name="firstTime" value="Y">
									<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
								<%} %>
								<a class="btn btn-info btn-sm  shadow-nohover back text-white" href="CARSRSQRApprovedList.htm?AllListTabId=3" >Back</a>
							</div>
					    </form>
	    				<br>
					    <div class="text-center">
					    	<%if(carsContract!=null && carsContract.getContractNo()!=null){ %>
					    		<a class="btn btn-info btn-sm prints shadow-nohover" href="CARSFinalFormWordDownload.htm?carsInitiationId=<%=carsIni.getCARSInitiationId()%>" target="_blank">Download CARS-03 Word&nbsp;<img src="view/images/worddoc.png" class="w-23"></a>
					    		<a class="btn btn-info btn-sm prints shadow-nohover" href="CARSFinalFormPdfDownload.htm?carsInitiationId=<%=carsIni.getCARSInitiationId()%>" target="_blank">Download CARS-03 Pdf</a>
					    	<%} %>
					    	
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$('#contractDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "maxDate" : new Date(), */
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	

$('#t0Date').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "maxDate" : new Date(), */
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	
</script>	
</body>
</html>