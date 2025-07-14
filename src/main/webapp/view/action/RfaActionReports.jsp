<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>RFA Action Reports</title>

<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}

#table tbody tr td {

	    padding: 4px 3px !important;

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
.pdfimage{
height: 50px;
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

List<Object[]> ProjectList = (List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> RfaNoTypeList = (List<Object[]>)request.getAttribute("RfaNoTypeList");
List<Object[]> RfaActionList = (List<Object[]>)request.getAttribute("rfaActionList");
String fdate=(String)request.getAttribute("fdate");
String tdate=(String)request.getAttribute("tdate");  
String rfatypeid=(String)request.getAttribute("rfatypeid");  
String projectid = (String)request.getAttribute("projectid");
String projectType = (String)request.getAttribute("projectType");
List<Object[]> preProjectList = (List<Object[]>) request.getAttribute("preProjectList");
List<Object[]> AssigneeList=(List<Object[]>) request.getAttribute("AssigneeEmplList");
String projectCode=projectType.equalsIgnoreCase("P") ? 
		                                ProjectList.stream().filter(project -> project[0] != null && project[0].toString().equals(projectid)) 
									   .map(project -> project[4] != null ? project[4].toString() : null)
									   .findFirst()
									   .orElse(null)
									           :
										preProjectList.stream().filter(project -> project[0] != null && project[0].toString().equals(projectid)) 
									   .map(project -> project[3] != null ? project[3].toString() : null)
									   .findFirst()
									   .orElse(null);

%>
<%=RfaActionList.size() %>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
           <div class="card-header position-relative p-0">  
					<div class="row">
						<h4 class="col-md-3 p-3">RFA Action Reports</h4>  
							<div class="col-md-9">
						   	  <form method="post" action="RfaActionReports.htm" name="dateform" id="myform" class="d-flex justify-content-center flex-wrap">
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
							             <select class="form-control selectdee" name="projectid" id="projectId" required data-live-search="true">
								            <% if(projectType.equalsIgnoreCase("P")) { %>
								                    <% for(Object[] obj : ProjectList) {
								                        String projectshortName = (obj[17] != null) ? " ( " + obj[17].toString() + " ) " : "";
								                    %>
								                        <option value="<%=obj[0]%>" <%if(projectid.equalsIgnoreCase(obj[0].toString())){ %> selected <% } %>><%=obj[4] + projectshortName %></option>
								                    <% } %>
								            <% } else { %>
								                    <% if(preProjectList != null && preProjectList.size() > 0) {
								                        for(Object[] obj : preProjectList) { %>
								                            <option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(projectid)) { %> selected <% } %>><%=obj[3] + " ( " + obj[2] + " )" %></option>
								                    <% } } %>
								            <% } %>
								         </select>
								      </div>
								         
								     <div class="d-flex align-items-center mx-2 my-1">
							            <label for="projectType" class="mr-2 font-weight-bold" style="font-size: 17px;">Type:</label>
							             <select class="form-control selectdee" id="rfatypeid" name="rfatypeid"  >
			                                          <option value="-" <%if(rfatypeid.equalsIgnoreCase("")) {%> selected <%} %>>ALL</option>
						   			        	<%if(RfaNoTypeList!=null && RfaNoTypeList.size()>0){
						   			        	  for (Object[] obj : RfaNoTypeList) {%>
										     <option value="<%=obj[1].toString()%>" <%if(rfatypeid!=null && rfatypeid.equalsIgnoreCase(obj[1].toString())){%>selected<%} %>><%=obj[1].toString()%></option>
										        <%}} %>   
						  	             </select>
							        </div>
							        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						   	  </form>	
		   					</div>
		   				</div>	   							
					</div>
			    <form action="#">		
			        <div class="card-body">
			        		<div class="d-flex justify-content-end align-items-center">
						        <!-- From Date -->
						        <div class="form-group mb-2 mr-4 d-flex align-items-center">
						            <label for="fdate" class="control-label mb-0 mr-2" style="font-size: 17px; font-weight: 700;">From Date:</label>
						           <input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate" 
						           required="required"  value="<%=sdf.format(sdf1.parse(fdate))%>" style="width: 150px;">
						        </div>
						
						        <!-- To Date -->
						        <div class="form-group mb-2 d-flex align-items-center">
						            <label for="tdate" class="control-label mb-0 mr-2" style="font-size: 17px; font-weight: 700;">To Date:</label>
						            <input  class="form-control " data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  
						            required="required" value="<%=sdf.format(sdf1.parse(tdate))%>" style="width: 150px;">
						        </div>
						        
						        <div>
									<button class="pdf" formaction="RfaActionReportPdf.htm" 
										formmethod="POST" formnovalidate="formnovalidate" name="rfaid"
										value="" formtarget="_blank" data-toggle="tooltip"
										data-placement="top" data-original-title="RFA Report pdf"
										style="border: none;background: transparent;margin-bottom: 7px;">
										<div>
											<img class="pdfimage" src="view/images/pdf1.png">
										</div>
									</button>
									<input type="hidden" name="reportFromdate" value="<%=fdate%>">
									<input type="hidden" name="reportTodate" value="<%=tdate%>">
									<input type="hidden" name="rfatypeid" value="<%=rfatypeid%>">
									<input type="hidden" name="projectid" value="<%=projectid%>">
									<input type="hidden" name="projectType" value="<%=projectType%>">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							   </div> 
						     </div>
		                   
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
													<thead>
														<tr style="text-align: center;">
															<th>SN</th>
															<th style="width: 15%">RFA No</th>	
															<th style="width: 7%">RFA Date</th>
															<th>Raised By</th>																								
														 	<th>Problem Statement</th>					 	
														 	<th>Assigned To</th>
														 	<th style="width: 8%">Close Date</th>
														 	<th style="width: 9%">RFA Status</th>
														 	<th style="width: 8%">Action</th>
														</tr>
													</thead>
													<tbody>
													<%if(!RfaActionList.isEmpty()) {
													int count=0;
													  for(Object[]obj:RfaActionList){%>
													<tr>
													<td style="text-align: center;"><%=++count %></td>
													
													<td <%if(obj[13]!=null && obj[13].toString().equalsIgnoreCase("RFC")){ %>style="color: red"<%} %>><%if(obj[1]!=null){%><%=obj[1].toString() %><%}else{ %>-<%} %></td>
													
													<td><%if(obj[2]!=null){%><%=sdf.format(obj[2])%><%}else{ %>-<%} %></td>
													<td><%if(obj[14]!=null){%><%=obj[14].toString()%><%}else{ %><%=obj[15].toString()%><%} %></td>
													<td>
													   <%if(obj[5]!=null){%>
														<%if(obj[5].toString().length()>70){ %>
														 <%=obj[5].toString().substring(0, 70) %>
														    <input type="hidden" value='"<%=obj[5].toString()%>"' id="tdpro<%=obj[0].toString()%>">
														    <span style="text-decoration: underline;font-size:13px;color: #145374;cursor: pointer;font-weight: bolder" onclick="showProblem('<%=obj[0].toString()%>','<%=obj[1].toString()%>')">show more..</span>
														<%}else{ %>
														<%=obj[5].toString() %>
														<%} %>
													   <%}else{ %>-<%} %>
													</td>	
											 <%-- <td>
													   <%if(obj[10]!=null){%>
														<%if(obj[10].toString().length()>70){ %>
														 <%=obj[10].toString().substring(0, 70) %>
														    <input type="hidden" value="<%=obj[10].toString()%>" id="tdobs<%=obj[0].toString()%>">
														    <span style="text-decoration: underline;font-size:13px;color: #145374;cursor: pointer;font-weight: bolder" onclick="showObservation('<%=obj[0].toString()%>','<%=obj[1].toString()%>')">show more..</span>
														<%}else{ %>
														<%=obj[10].toString() %>
														<%} %>
													  <%}else{ %>-<%} %>
													</td> --%>
													<td>
														<%if(AssigneeList!=null ){ 
															for(Object[] obj1 : AssigneeList){
																if(obj1[0].toString().equalsIgnoreCase(obj[0].toString())){
																%>
														      <p style="margin-bottom:0px !important;"> <%=obj1[1].toString()+", "+obj1[2].toString() %> (<%=obj1[4].toString() %>) </p>          
														<% }}}%>
													</td>
													<td><%if(obj[9]!=null){%><%=sdf.format(obj[9])%><%}else{ %>-<%} %></td>
													<td style="text-align: center;">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                       	  	    <button type="submit" class="btn btn-sm btn-link btn-status" formaction="RfaTransStatus.htm" value="<%=obj[0] %>" name="rfaTransId"  data-toggle="tooltip" data-placement="top" title="Transaction History" 
	                                       	  	    style=" color: #E65100; font-weight: 600;" formtarget="_blank"><%=obj[8] %> 
								    			    </button>
												    </td>
													<td style="text-align: center;">
													<button class="editable-click bg-transparent"
														formaction="RfaActionPrint.htm" formmethod="get"
														formnovalidate="formnovalidate" name="rfaid" value="<%=obj[0]%>,<%=obj[1] %>,<%=projectCode %>" 
														style="margin-left:10%;" formtarget="_blank"   data-toggle="tooltip" data-placement="top"  data-original-title="VIEW DOCUMENT">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/preview3.png">
																</figure>
															</div>
														</div>
												   </button> 
													</td>
													</tr>
													<%}} %>
													</tbody>
												</table>												
											</div>
										</div>
										</form>
									</div>
								</div>
							</div>
						</div>		
						
						
								<!-- Modal for Problem Statement -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height:50px;">
        <h5 class="modal-title" id="exampleModalLongTitle">Problem Statement</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalbody">
     
      </div>
      <div align="right" id="header" class="p-2"></div>
    </div>
  </div>
</div>

                       <!-- Modal for Observation -->
<div class="modal fade" id="exampleModalCenterObs" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height:50px;">
        <h5 class="modal-title" id="exampleModalLongTitle">Observation</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalbodyobs">
     
      </div>
      <div align="right" id="headerobs" class="p-2"></div>
    </div>
  </div>
</div>
		
</body>
<script type="text/javascript">
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

$(document).ready(function() {
	$('#projectId').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#myform').submit();
	});
});
	
$('#rfatypeid').on('change', function() {
	var temp = $(this).children("option:selected").val();
	$('#myform').submit();
});

$('#fdate').on('change', function() {
	$('#myform').submit();
});

$('#tdate').on('change', function() {
	$('#myform').submit();
});

$('#projectType').on('change', function() {
	var temp = $(this).children("option:selected").val();
	$('#myform').submit();
});

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});

function showProblem(a,b){
	/* var y=JSON.stringify(a); */
	var pro=$('#tdpro'+a).val();
	console.log(a);
	$('#modalbody').html(pro);
	$('#header').html(b);
	$('#exampleModalCenter').modal('show');
}

function showObservation(a,b){
	/* var y=JSON.stringify(a); */
	var obs=$('#tdobs'+a).val();
	console.log(a);
	$('#modalbodyobs').html(obs);
	$('#headerobs').html(b);
	$('#exampleModalCenterObs').modal('show');
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})
</script>
</html>