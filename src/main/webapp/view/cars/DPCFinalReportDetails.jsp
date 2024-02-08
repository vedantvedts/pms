<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}

</style>
</head>
<body>
<%
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 

FormatConverter fc = new FormatConverter();
%>

<% String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

	<div class="container">
		<div class="row" style="">
			<div class="col-md-12">
				<div class="card shadow-nohover" >
					
					<%-- <div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;margin-top: ">
	                    <b class="text-white">SECTION I: PROJECT INITIATION EDIT</b> 
	                    <span class="text-white" style="float:right;font-weight: 600"><%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %> Main Project : <%=ProjectEditData[18] %> <%} %> </span>
	        		</div> --%>
	        
					<div class="card-body">
	        		
						<form action="CARSFinalReportEditSubmit.htm" method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
					    	<div class="row">
					        	<div class="col-md-2" style="">
					        		<div class="form-group">
					                	<label class="control-label">Contract Date:</label><span class="mandatory">*</span>
					                    <input  class="form-control form-control" type="text" name="contractDate" id="contractDate"
					                     value="<%if(carsContract!=null && carsContract.getContractDate()!=null){ %><%=fc.SqlToRegularDate(carsContract.getContractDate())%><%} %>" required readonly> 
					                </div>
					            </div>
					        	<div class="col-md-2" style="">
					        		<div class="form-group">
					                	<label class="control-label">T0 Date:</label><span class="mandatory">*</span>
					                    <input  class="form-control form-control" type="text" name="t0Date" id="t0Date"
					                     value="<%if(carsContract!=null && carsContract.getT0Date()!=null){ %><%=fc.SqlToRegularDate(carsContract.getT0Date())%><%} %>" required readonly> 
					                </div>
					            </div>
					        	<div class="col-md-8" style="">
					        		<div class="form-group">
					                	<label class="control-label">T0 Remarks</label><span class="mandatory">*</span>
					                    <input  class="form-control form-control" type="text" name="t0Remarks" id="t0Remarks"
					                     value="<%if(carsContract!=null && carsContract.getT0Remarks()!=null){ %><%=carsContract.getT0Remarks()%><%} %>" required> 
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
								<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSRSQRApprovedList.htm?AllListTabId=3" style="color: white!important">Back</a>
							</div>
					    </form>
	    				<br>
					    <div style="text-align: center;">
					    	<%if(carsContract!=null && carsContract.getContractNo()!=null){ %>
					    		<a class="btn btn-info btn-sm prints shadow-nohover" href="CARSFinalFormWordDownload.htm?carsInitiationId=<%=carsIni.getCARSInitiationId()%>" target="_blank">Download CARS-03 Word&nbsp;<img src="view/images/worddoc.png" style="width: 23px;"></a>
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