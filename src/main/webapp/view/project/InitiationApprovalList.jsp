<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.time.format.DateTimeFormatter"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title></title>
<style type="text/css">
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
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
	label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}
</style>
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

	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
	</div></div>
                    <%} %>
<div class="container-fluid" >
	<div class="row">
		<div class="col-md-12">	
		   
			<div class="card shadow-nohover">	
						
					<div class="card-header">						
						<div class="row">										
							<div class="col-md-12"><h3 style="color:#055C9D;margin-top:-5px;" >Approval List 
						</h3>
						
							</div>	
																	
						
						</div>
					</div>
					
		<div class="card-body">
		<!-- tabList  -->
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link active" style="text-align: center;" id="eNotePendingtab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
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
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link" style="text-align: center;" id="eNoteApprovedtab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
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
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">Project Title</th>
									<th style="text-align: center;">Project ShortName</th>
									<th style="text-align: center;">Project Cost(In Lakh)</th>
									<th style="text-align: center;">Project Duration (In Months)</th>
									<th style="text-align: center;">Status</th>	
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
 							<tbody>
							<%
							int firstCount=0;
							if(EnoteApprovalPendingList!=null&& EnoteApprovalPendingList.size()>0){
							for(Object[] obj: EnoteApprovalPendingList) {%>
							<tr>
							<td style="text-align: center;"> <%=++firstCount %></td>
							<td style="text-align: center;"><%=obj[8].toString() %></td>
							<td style="text-align: center;"><%=obj[9].toString() %></td>
		
							<td style="text-align: right;"> 
							<%=
							Double.parseDouble(obj[12].toString())/100000
							%>
							
							</td>
				<td style="text-align: center;"> <%=obj[13].toString() %></td>
				<td>
				<div align="center" style="margin-top:1%;">
				<form action="#">
				<button type ="submit"  class="btn btn-sm btn-link w-100 btn-status" formaction="InitiationFlowTrack.htm" value="<%=obj[0]%>" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Transaction History" name="EnoteTrackId" style=" color: <%=obj[7].toString()%>; font-weight: 600;display: contents" > <%=obj[6].toString() %> 
				<i class="fa fa-external-link" aria-hidden="true"></i></button>
				</form>
				</div> 
				</td>
				<td>
				<div style="display: flex;justify-content: space-evenly;align-items: center;">
				
					<form action="InitiationRecommendation.htm" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
					<input type="hidden" name="InitiationId" value="<%=obj[14].toString()%>">
						<input type="hidden" name="EnoteId" value="<%=obj[0].toString()%>">
					<button type="submit" class="btn btn-sm"><i class="fa fa-eye" aria-hidden="true"></i></button>
					</form>
				
				
				
				<!-- Executive summary  -->
				<form action="#">
					<button type="submit" class="btn btn-sm" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Executive Summary">
					<i class="fa fa-download" aria-hidden="true" style="color:green;"></i>
					</button>	
				<input type="hidden" name="IntiationId" value="<%=obj[14].toString()%>">
				</form>
					
					
						<form action="#">
									<button type="submit" class="btn btn-sm btn-primary" formaction="InitiationApprovalPrint.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Approval Report">
									<i class="fa fa-download" aria-hidden="true" style="color:white;"></i>
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

    
        <div class="col-12" style="width: 100%;" >
          <div class="row" style="align-items: center;justify-content: end;">
              <label  class="control-label" for="fromdate" style="text-align:  center;font-size: 16px;width:80px; ">From	</label>&nbsp;&nbsp;
              <input type="text" style="width:113px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label class="control-label" for="todate" style="text-align: center;font-size: 16px;width:20px; ">To</label>&nbsp;&nbsp;
              <input type="text" style="width:113px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="hidden" id="redirectedvalue" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
          </div>
        </div>
     
      </form>
     
     <table class="table table-bordered table-hover table-striped table-condensed mt-2" id="myTable2">
							<thead>
								<tr >
									<th style="text-align: center;width:20px;;">SN</th>
									<th style="text-align: center;width:10%;">Project Title</th>
									<th style="text-align: center;width:5%;">Project Short Name</th>
									<th style="text-align: center;width:10%;">Project Director</th>
								
									<th style="text-align: center;">Status</th>	
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
 							<tbody>
						<%
						int count=0;
						if(EnoteApprovedList!=null && EnoteApprovedList.size()>0){
						for(Object[]obj:EnoteApprovedList){
						%>
						<tr>
						<td style="text-align: center;width:20px;"><%=++count %></td>
						<td style="text-align: center;"><%=obj[13].toString() %></td>
						<td style="text-align: center;"><%=obj[10].toString() %></td>
						<td style="text-align: center;"> 
						<%=obj[11].toString() %>, <%=obj[12].toString() %>
							
							</td>
						
							<td style="text-align: justify;">
							
							<div align="center" style="margin-top:1%;">
							<form action="#">
							<button type ="submit"  class="btn btn-sm btn-link w-100 btn-status" formaction="EnoteStatusTrack.htm" value="<%=obj[0]%>" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Transaction History" name="EnoteTrackId" style=" color: <%=obj[8].toString()%>; font-weight: 600;display: contents" > <%=obj[7].toString() %> 
							<i class="fa fa-external-link" aria-hidden="true"></i></button>
							</form>
							</div>
							</td>
							<td style="text-align: center;">
							<div style="display: flex;justify-content: space-evenly;align-items: center;">
							<form action="#">
									<button type="submit" class="btn btn-sm" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Executive Summary">
									<i class="fa fa-download" aria-hidden="true" style="color:green;"></i>
									</button>	
								<input type="hidden" name="IntiationId" value="<%=obj[14].toString()%>">
							</form>
				
				
									<form action="#">
									<button type="submit" class="btn btn-sm btn-primary" formaction="InitiationApprovalPrint.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Print Approval Report">
									<i class="fa fa-download" aria-hidden="true" style="color:white;"></i>
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