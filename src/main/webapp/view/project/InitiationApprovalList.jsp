<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.time.format.DateTimeFormatter"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectModule/initiationApprovalList.css" var="initiationApprovalList" />
<link href="${initiationApprovalList}" rel="stylesheet" />
<title>PMS</title>

</head>
<body>

	<%
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat sdf = fc.getRegularDateFormat();
	SimpleDateFormat sdf1 = fc.getSqlDateFormat();
	SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		String redirectedvalue=(String)request.getAttribute("redirectedvalueForward");
		List<Object[]>  EnoteApprovalPendingList=(List<Object[]>)request.getAttribute("EnoteApprovalPendingList");
		List<Object[]> EnoteApprovedList=(List<Object[]>)request.getAttribute("eNoteApprovalList");
	//29-04-2025
	%>
	<% 
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
<div class="container-fluid" >
	<div class="row">
		<div class="col-md-12">	
		   
			<div class="card shadow-nohover">	
						
					<div class="card-header">						
						<div class="row">										
							<div class="col-md-12"><h3 class="cs-h3">Approval List 
						</h3>
						
							</div>	
																	
						
						</div>
					</div>
					
		<div class="card-body">
		<!-- tabList  -->
		<ul class="nav nav-pills mb-3 cs-ul" id="pills-tab" role="tablist">
		  <li class="nav-item w-50">
		    <div class="nav-link active text-center" id="eNotePendingtab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>Approval Pending List 
				   <span class="badge badge-danger badge-counter count-badge ml-2">
				 		<%if( EnoteApprovalPendingList!=null && EnoteApprovalPendingList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=EnoteApprovalPendingList.size()%>
						<%} %>		   			
				  </span>  
				</span> 
		    </div>
		  </li>
		  <li class="nav-item w-50">
		    <div class="nav-link text-center" id="eNoteApprovedtab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span> Approved List     
				   <span class="badge badge-danger badge-counter count-badge ml-2">
				  	<%if(EnoteApprovedList!=null && EnoteApprovedList.size()>99){ %>
				   		99+
				   		<%}else{ %>
				   		<%=EnoteApprovedList.size()%>
						<%} %>   			
				   </span>  
				</span> 
		    
		    
		    </div>
		  </li>
		</ul>
		
		<!-- two divs for List  -->
			<div class="tab-content" id="pills-tabContent">
			<!-- pendig Div  -->
			<div class=" tab-pane  show active" id="pills-OPD" role="tabpanel" aria-labelledby="eNotePendingtab" >
					<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th class="text-center">SN</th>
									<th class="text-center">Project Title</th>
									<th class="text-center">Project ShortName</th>
									<th class="text-center">Project Cost(In Lakh)</th>
									<th class="text-center">Project Duration (In Months)</th>
									<th class="text-center">Status</th>	
									<th class="text-center">Action</th>
								</tr>
							</thead>
 							<tbody>
							<%
							int firstCount=0;
							if(EnoteApprovalPendingList!=null&& EnoteApprovalPendingList.size()>0){
							for(Object[] obj: EnoteApprovalPendingList) {%>
							<tr>
							<td class="text-center"> <%=++firstCount %></td>
							<td class="text-center"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %></td>
							<td class="text-center"><%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %></td>
		
							<td class="text-right"> 
							<%=
							Double.parseDouble(obj[12].toString())/100000
							%>
							
							</td>
				<td class="text-center"> <%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - " %></td>
				<td>
				<div align="center" class="mt-1p">
				<form action="#">
				<%
				   String colorCode = (String) obj[7];
				   String className = "C" + colorCode.replace("#", "").toUpperCase();
				%>
				<button type ="submit"  class="btn btn-sm btn-link w-100 btn-status fw-800 <%=className%>" formaction="InitiationFlowTrack.htm" value="<%=obj[0]%>" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Transaction History" name="EnoteTrackId"> <%=obj[6].toString() %> 
				<i class="fa fa-external-link" aria-hidden="true"></i></button>
				</form>
				</div> 
				</td>
				<td>
				<div class="cs-recomend">
				
					<form action="InitiationRecommendation.htm" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
					<input type="hidden" name="InitiationId" value="<%=obj[14].toString()%>">
						<input type="hidden" name="EnoteId" value="<%=obj[0].toString()%>">
					<button type="submit" class="btn btn-sm"><i class="fa fa-eye" aria-hidden="true"></i></button>
					</form>
				
				
				
				<!-- Executive summary  -->
				<form action="#">
					<button type="submit" class="btn btn-sm" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Executive Summary">
					<i class="fa fa-download text-success" aria-hidden="true"></i>
					</button>	
				<input type="hidden" name="IntiationId" value="<%=obj[14].toString()%>">
				</form>
					
					
						<form action="#">
									<button type="submit" class="btn btn-sm btn-primary" formaction="InitiationApprovalPrint.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Approval Report">
									<i class="fa fa-download text-light" aria-hidden="true"></i>
									</button>	
								<input type="hidden" name="InitiationId" value="<%=obj[14].toString()%>">
								<input type="hidden" name="EnoteId" value="<%=obj[0].toString()%>">
							</form>
				
					

					
			
					</div>
					</td>
							</tr>
							<%}} %>
							</tbody> 
							</table>
				
		
			</div>
			
			<!--Approved Div  -->
			<div class="card tab-pane " id="pills-IPD" role="tabpanel" aria-labelledby="eNoteApprovedtab" >	
		    <div class="card-body"> 
    
 <form action="InitiationApprovalList.htm" method="post" id="myform"> 

    
        <div class="col-12">
          <div class="row cs-row">
              <label  class="control-label cs-from" for="fromdate">From	</label>&nbsp;&nbsp;
              <input type="text" class="form-control input-sm mydate cs-input" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label class="control-label cs-to" for="todate">To</label>&nbsp;&nbsp;
              <input type="text" class="form-control input-sm mydate cs-input" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="hidden" id="redirectedvalue" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
          </div>
        </div>
     
      </form>
     
     <table class="table table-bordered table-hover table-striped table-condensed mt-2" id="myTable2">
							<thead>
								<tr >
									<th class="text-center w-20px">SN</th>
									<th class="text-center w-10">Project Title</th>
									<th class="text-center w-5">Project Short Name</th>
									<th class="text-center w-10">Project Director</th>
								
									<th class="text-center">Status</th>	
									<th class="text-center">Action</th>
								</tr>
							</thead>
 							<tbody>
						<%
						int count=0;
						if(EnoteApprovedList!=null && EnoteApprovedList.size()>0){
						for(Object[]obj:EnoteApprovedList){
						%>
						<tr>
						<td class="text-center w-20px"><%=++count %></td>
						<td class="text-center"><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - "%></td>
						<td class="text-center"><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %></td>
						<td class="text-center"> 
						<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>, <%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - "%>
							
							</td>
						
							<td class="text-justify">
							
							<div align="center" class="mt-1p">
							<form action="#">
							<%
							   String colorCode = (String) obj[8];
							   String className = "C" + colorCode.replace("#", "").toUpperCase();
							%>
							<button type ="submit"  class="btn btn-sm btn-link w-100 btn-status fw-800 <%=className%>" formaction="EnoteStatusTrack.htm" value="<%=obj[0]%>" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Transaction History" name="EnoteTrackId" > <%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %> 
							<i class="fa fa-external-link" aria-hidden="true"></i></button>
							</form>
							</div>
							</td>
							<td class="text-center">
							<div class="cs-summary-div">
							<form action="#">
									<button type="submit" class="btn btn-sm" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Executive Summary">
									<i class="fa fa-download text-success" aria-hidden="true"></i>
									</button>	
								<input type="hidden" name="IntiationId" value="<%=obj[14].toString()%>">
							</form>
				
				
									<form action="#">
									<button type="submit" class="btn btn-sm btn-primary" formaction="InitiationApprovalPrint.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Approval Report">
									<i class="fa fa-download text-light" aria-hidden="true"></i>
									</button>	
								<input type="hidden" name="InitiationId" value="<%=obj[14].toString()%>">
								<input type="hidden" name="EnoteId" value="<%=obj[0].toString()%>">
							</form>
							</div>
							</td>
						</tr>
						<%}} %>
							</tbody>
							</table>
     
      </div>
			
			</div>
			
			</div>
		
					</div>
					</div>
					</div>
					</div>
					</div>
					
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
$("#myTable2").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})
	
	$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 "startDate" : new Date('<%=frmDt%>'), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

var currentDate = new Date();
var maxDate = currentDate.toISOString().split('T')[0];
console.log(maxDate);
$('#todate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date('<%=toDt%>'), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(document).ready(function(){
	   $('#todate').change(function(){
	       $('#myform').submit();
	    });
	});
	
$(document).ready(function(){
	   $('#fromdate').change(function(){
	       $('#myform').submit();
	    });
	});
	
$("#eNotePendingtab").click(function() {
	$("#redirectedvalue").val('');
    $("#redirectedvalue").val('eNotePending');
  });

  $("#eNoteApprovedtab").click(function() {
    $("#redirectedvalue").val('');
    $("#redirectedvalue").val('eNoteApproved');
  });
</script>
<script>
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = '<%= redirectedvalue %>';
  if (countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='eNotePending') {
    // Get the button element by ID
   var button = document.querySelector('[id="eNotePendingtab"]');

    // Scroll to the button element to that view
 /*    button.scrollIntoView(); */
    // Programmatically trigger a click event on the button
    if (button) {
      // Programmatically trigger a click event on the button
      
      button.click();
      
    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='eNoteApproved'){
	  var button = document.querySelector('[id="eNoteApprovedtab"]');

	    // Scroll to the button element to that view
	 /*    button.scrollIntoView(); */
	    // Programmatically trigger a click event on the button
	    if (button) {
      // Programmatically trigger a click event on the button
       
      button.click();
     
    }
  }
</script>
</body>
</html>