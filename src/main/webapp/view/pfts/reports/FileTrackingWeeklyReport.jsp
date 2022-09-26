<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../../static/header.jsp"></jsp:include>

<title>Weekly Report</title>


<style type="text/css">
/* .table thead tr th{vertical-align:middle; text-align:center; font-size:12px; white-space:nowrap;} */
/* .table tbody tr td{vertical-align:middle; text-align:center; font-size:12px; white-space:nowrap;} */

.label-sanc{
  background-color:#006400;
}

.label-indigo{
  background-color:	#4B0082;
}
.content-header{
padding-top:10px !important;
padding-bottom:10px !important;
}
.card-title
{
	margin: 0px;
}
.btn1
{
	 
}

</style>


</head>
<body>

<%
FormatConverter fc=new FormatConverter(); 

List<Object[]>  FileTrackingWeeklyReportResult=(List<Object[]>)request.getAttribute("FileTrackingWeeklyReportResult");
String asOnDate=(String)request.getAttribute("asOnDate");
%>


<div class="container-fluid" >
	<div class="row">
	
		<div class=" text-center col-md-12" >
			<div class="card">
				<div class="card-header" align="left">
					<input type="hidden" id="fromDate" value="<%=asOnDate%>">
					<div class="row">
						<div class="col-md-9">
							<h4><b>Weekly Report As On Date : <%=asOnDate %></b></h4>
						</div>
						<div class="col-md-3">	
							<form action="FileTrackingWeeklyReport.htm" method="post">
								<table style="width: 100%;">
									<tr>
										<td><b>As On Date :</b></td>
										<td><input type="text" name="SelectedDate" size="8" class="datepickerF form-control" readonly/></td>
										<td><button type="Submit" class="btn btn-primary"><i class="fa fa-arrow-right"></i></button></td>
									</tr>
								</table>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>	
						</div>
					</div>
					
				</div>
				
				<div class="card-body">
					<div class="row" align="right">
						<div class="col-12" >
							<form action="WeeklyReport.htm" method="post" target="_blank" style="float: right;" >
								<input type="hidden" name="asOnDate" value="<%=asOnDate%>">
								<button type="submit" class="btn" name="action" value="pdf" style="background-color: red;padding: 5px; ">
									<i class="fa fa-file-pdf-o fa-lg" style="color: white;" aria-hidden="true"></i>
								</button>
								<button type="submit" class="btn" name="action" value="xls" style="background-color: blue;padding: 5px; ">
									<i class="fa fa-file-excel-o fa-lg" style="color: white;" aria-hidden="true"></i>
								</button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>  
						</div>
					 </div>
				 
					<%
						int DemandCount=0;
						int TenderCount=0;
						int SupplyCount=0;
						int ReceiptCount=0;
						int AccountingCount=0;
						int BillCount=0;
						int totalCount=0;
						
						for(Object[] ls: FileTrackingWeeklyReportResult){ 
						if("D".equalsIgnoreCase(ls[0].toString()))
						{
							   ++DemandCount;
						}
						if("T".equalsIgnoreCase(ls[0].toString()))
						{
							   ++TenderCount;
						}
						if("S".equalsIgnoreCase(ls[0].toString()))
						{
							   ++SupplyCount;
						}
						
						if("R".equalsIgnoreCase(ls[0].toString()))
						{
							   ++ReceiptCount;
						}
						if("A".equalsIgnoreCase(ls[0].toString()))
						{
							   ++AccountingCount;
						}
						if("B".equalsIgnoreCase(ls[0].toString()))
						{
							   ++BillCount;
						}
						}
						totalCount=DemandCount+TenderCount+SupplyCount+ReceiptCount+AccountingCount+BillCount;
					%>
					
				
					<%-- <div class=" text-center col-md-12" >
						<form class="form-group" action="weekly-Report.htm" method="post" target="_blank">
							<input type="hidden" name="asOnDate" value="<%=asOnDate%>">
							<button type="submit" name="action" value="pdf">
								<img src="vtsfolder/images/pdf.png" alt="" >
							</button>
							&nbsp;
							<button type="submit" name="action" value="xls">
								<img src="vtsfolder/images/excel.png" alt="" >
							</button>
						</form>
					</div> --%>
					
					<!-- //Demand  accordion group -->
					<div class="card">
					      <div class="card-header">
					        <h5 class="card-title" align="left">
					          <button class="btn btn-sm btn1" style="background-color: #B5DEFF; " data-toggle="collapse" data-parent="#accordion" data-target="#collapse1">
						          
						        <b>Demand (<b> <%=DemandCount%> </b>  )</b> 
						         
					          </button>
					        </h5>
					      </div>
					  <div id="collapse1" class="card-collapse collapse show">
					
					<!-- Demand -->
					
					   
					 <div class="col-md-12"><h5 class="text-primary"><b>Demand Details</b></h5></div>
					        <table  class="table table-bordered table-hover table-striped table-condensed">
					            <thead>
					                <tr>
					                	<th>Sl No</th>
					                    <th>Dem No</th>
					                    <th>Received Date</th>
					                    <th>Item For</th>
					                    <th>Mode</th>
					                    <th>Budget</th>
					                    <th>Estimated Cost</th>
					                    <th>Event Date</th>
					                    <th>Current Status</th>
					                    <th>Days</th>
					                    
					                    
					                </tr>
					            </thead>
					            <tbody>
					            
					           <%
					           int count=0;
					           for(Object[] ls: FileTrackingWeeklyReportResult){
					            if("D".equalsIgnoreCase(ls[0].toString()))
					            {count++;
					            %> 
					        	   <tr>
					        	   <td><%=count%></td>
					        	   <td><%=ls[1]%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[2].toString())%></td>
					        	   <td><%=ls[3]%></td>
					        	   <td><%=ls[4]%></td>
					        	   <td><%=ls[5]%></td>
					        	   <td><%=ls[6]%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[25].toString())%></td>
					        	   <td><%=ls[22]%></td>
					        	   <td><%=ls[23]%></td>
					        	  </tr> 
					            <%}}%>
					          
					           </tbody>
					     </table>
					
					
					
					<!-- //Demand -->
					
					</div>
					</div>
					
					
					<!--  Tender  accordion group -->

					<!-- Tender  -->
					<div class="card">
						      <div class="card-header">
						        <h5 class="card-title" align="left">
						          <button class="btn btn-sm btn1" style="background-color: #FFCCD2;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse2">
							         	 
							         	<b> Tender (<b>  <%=TenderCount%></b> )</b>
							         	 
							      </button>
						        </h5>
						      </div>
						  <div id="collapse2" class="card-collapse collapse">
												
						<!-- Tender   -->
												   
						  <div class="col-md-12"><h5 class="text-primary"><b>Tender Details</b></h5></div>
						        <table  class="table table-hover  table-striped table-condensed table-bordered customers " >
						            <thead>
						                <tr>
						                	<th>Sl No</th>
						                    <th>Dem No</th>
						                    <th>Received Date</th>
						                    <th>Item For</th>
						                    <th>Mode</th>
						                    <th>Budget</th>
						                    <th>Estimated Cost</th>
						                    <th>Tender No</th>
						<!--                <th>Tender Date</th> -->
						                    <th>Due Date</th>
						                    <th>Event Date</th>
						                    <th>Current Status</th>
						                    <th>Days</th>
						                    
						                </tr>
						            </thead>
						            <tbody>
						            <%int count1=0;
						            for(Object[] ls: FileTrackingWeeklyReportResult){
						            if("T".equalsIgnoreCase(ls[0].toString()))
						            {count1++;%> 
						        	   <tr>
						        	   <td><%=count1%></td>
						        	   <td><%=ls[1]%></td>
						        	   <td><%=fc.SqlToRegularDate(ls[2].toString())%></td>
						        	   <td><%=ls[3]%></td>
						        	   <td><%=ls[4]%></td>
						        	   <td><%=ls[5]%></td>
						        	   <td><%=ls[6]%></td>
						        	   <td><%if(ls[7]!=null){%><%=ls[7]%><%}else{%><%="--"%><%}%></td>
						<%--           <td><%if(ls[8]!=null){%><%=GetDateAndTime.fromDatabaseToActual(ls[8].toString())%><%}else{%><%="--"%><%}%></td> --%>
						        	   <td><%if(ls[9]!=null){%><%=fc.SqlToRegularDate(ls[9].toString())%><%}else{%><%="--"%><%}%></td>
						        	   <td><%=fc.SqlToRegularDate(ls[25].toString())%></td>
						        	   <td><%=ls[22]%></td>
						        	   <td><%=ls[23]%></td>
						        	  </tr> 
						            <%}}%>
						            
						            </tbody>
						     </table>
						<!-- //Tender  -->
						
						
						</div>
						</div>
					
					
					<!-- supply order    accordion group -->
					<div class="card">
					      <div class="card-header">
					        <h5 class="card-title" align="left">
					          <button class="btn btn-sm btn1" style="background-color: #CDBBA7;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse3">
					         	 <b> Supply Order (<b> <%=SupplyCount%> </b>  ) </b>
					          </button>
					        </h5>
					      </div>
					  <div id="collapse3" class="card-collapse collapse">
					    
					<!--supply order    -->
					 
					   <div class="col-md-12"> <h5 class="text-primary"><b>Supply order Details </b></h5></div>
					           <table  class="table table-bordered  table-striped  table-hover table-condensed ">
					            <thead>
					                <tr>
					                	<th>Sl No</th>
					                    <th>Dem No</th>
					                    <th>Received Date</th>
					                    <th>Item For</th>
					                    <th>Mode</th>
					                    <th>Budget</th>
					                    <th>So No</th>
					                    <th>So Date</th>
					                    <th>DP Date</th>
					                    <th>Total Cost</th>
					                    <th>Event Date</th>
					                    <th>Current Status</th>
					                    <th>Days</th>
					                    
					                </tr>
					            </thead>
					           <%int count2=0;
					           for(Object[] ls: FileTrackingWeeklyReportResult){
					            if("S".equalsIgnoreCase(ls[0].toString()))
					            {count2++;%> 
					        	   <tr>
					        	   <td><%=count2%></td>
					        	   <td><%=ls[1]%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[2].toString())%></td>
					        	   <td><%=ls[3]%></td>
					        	   <td><%=ls[4]%></td>
					        	   <td><%=ls[5]%></td>
					        	   <td><%if(ls[10]!=null){%><%=ls[10]%><%}else{%><%="--"%><%}%></td>
					        	   <td><%if(ls[11]!=null){%><%=fc.SqlToRegularDate(ls[11].toString())%><%}else{%><%="--"%><%}%></td>
					        	   <td><%if(ls[12]!=null){%><%=fc.SqlToRegularDate(ls[12].toString())%><%}else{%><%="--"%><%}%></td>
					        	   <td><%if(ls[13]!=null){%><%=ls[13]%><%}else{%><%="--"%><%}%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[25].toString())%></td>
					        	   <td><%=ls[22]%></td>
					        	   <td><%=ls[23]%></td>
					        	  </tr> 
					            <%}}%>
					            <tbody>
					           
					           
					           </tbody>
					          </table>
					    
					<!--//supply order --> 
					</div>
					</div>
					
					<!-- //supply order accordion group -->
					
					<!--Receipt -->
					<div class="card">
					      <div class="card-header">
					        <h5 class="card-title" align="left">
						        <button class="btn btn-sm btn1" style="background-color: #F09AE9;" data-toggle="collapse" data-parent="#accordion" href="#collapse4">
						        	<b>Receipt (<b> <%=ReceiptCount%> </b> )</b>
						        </button>
					        </h5>
					      </div>
					  <div id="collapse4" class="card-collapse collapse">
					
					
					<!-- Receipt   -->
					
					   
					  <div class="col-md-12"><h5 class="text-primary"><b>Receipt Details</b></h5></div>
					        <table  class="table table-bordered table-hover table-striped table-condensed">
					            <thead>
					                <tr>
					                	<th>Sl No</th>
					                    <th>Dem No</th>
					                    <th>Received Date</th>
					                    <th>Item For</th>
					                    <th>Mode</th>
					                    <th>Budget</th>
					                    <th>So No</th>
					                    <th>Total Cost</th>
					<!--                     <th>RIN No</th> -->
					                    <th>Receipt Date</th>
					                    <th>Inspection Date</th>
					                    <th>Event Date</th>
					                    <th>Current Status</th>
					                    <th>Days</th>
					                    
					                </tr>
					            </thead>
					            <tbody>
					            <%int count3=0;
					            for(Object[] ls: FileTrackingWeeklyReportResult){
					            if("R".equalsIgnoreCase(ls[0].toString()))
					            {count3++;%> 
					        	   <tr>
					        	    <td><%=count3%></td>
					        	   <td><%=ls[1]%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[2].toString())%></td>
					        	   <td><%=ls[3]%></td>
					        	   <td><%=ls[4]%></td>
					        	   <td><%=ls[5]%></td>
					        	   <td><%if(ls[10]!=null){%><%=ls[10]%><%}else{%><%="--"%><%}%></td>
					        	   <td><%if(ls[13]!=null){%><%=ls[13]%><%}else{%><%="--"%><%}%></td>
					<%--         	   <td><%if(ls[14]!=null){%><%=ls[14]%><%}else{%><%="--"%><%}%></td> --%>
					        	   <td><%if(ls[15]!=null){%><%=fc.SqlToRegularDate(ls[15].toString())%><%}else{%><%="--"%><%}%></td>
					        	   <td><%if(ls[16]!=null){%><%=fc.SqlToRegularDate(ls[16].toString())%><%}else{%><%="--"%><%}%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[25].toString())%></td>
					        	   <td><%=ls[22]%></td>
					        	   <td><%=ls[23]%></td>
					        	  </tr> 
					            <%}}%>
					              </tbody>
					     </table>
					
					<!-- //Receipt-->
					
					
					</div>
					</div>
					
					<!-- // Receipt accordion group -->

					<!-- Accounting  accordion group -->
					
					<!--Accounting -->
					<div class="card">
					      <div class="card-header">
					        <h5 class="card-title" align="left">
					          <button class="btn btn-sm btn1" style="background-color: #EDE682;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse5">
					         	<b> Accounting (<b> <%=AccountingCount%> </b> ) </b>
					          </button>
					        </h5>
					      </div>
					  <div id="collapse5" class="card-collapse collapse">
					
					<!-- Accounting   -->
					
					  <div class="col-md-12"><h5 class="text-primary"><b>Accounting Details</b></h5></div>
					        <table  class="table table-bordered table-hover table-striped table-condensed">
					            <thead>
					                <tr>
					                	<th>Sl No</th>
					                    <th>Dem No</th>
					                    <th>Received Date</th>
					                    <th>Item For</th>
					                    <th>Mode</th>
					                    <th>Budget</th>
					                    <th>So No</th>
					                    <th>Total Cost</th>
					<!--                     <th>CRV No</th> -->
					                    <th>CRV Date</th>
					                    <th>Event Date</th>
					                    <th>Current Status</th>
					                    <th>Days</th>
					                    
					                </tr>
					            </thead>
					            <tbody>
					            <%int count4=0;
					            for(Object[] ls: FileTrackingWeeklyReportResult){
					            if("A".equalsIgnoreCase(ls[0].toString()))
					            {count4++;%> 
					        	   <tr>
					        	   <td><%=count4%></td>
					        	   <td><%=ls[1]%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[2].toString())%></td>
					        	   <td><%=ls[3]%></td>
					        	   <td><%=ls[4]%></td>
					        	   <td><%=ls[5]%></td>
					        	   <td><%if(ls[10]!=null){%><%=ls[10]%><%}else{%><%="--"%><%}%></td>
					        	   <td><%if(ls[13]!=null){%><%=ls[13]%><%}else{%><%="--"%><%}%></td>
					<%--         	   <td><%if(ls[17]!=null){%><%=ls[17]%><%}else{%><%="--"%><%}%></td> --%>
					        	   <td><%if(ls[18]!=null){%><%=fc.SqlToRegularDate(ls[18].toString())%><%}else{%><%="--"%><%}%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[25].toString())%></td>
					        	   <td><%=ls[22]%></td>
					        	   <td><%=ls[23]%></td>
					        	  </tr> 
					            <%}}%>
					             
					            </tbody>
					     </table>
					  
					<!-- //Accounting-->
					
					</div>
					</div>
					
					<!-- // Accounting accordion group -->

					
					
					<!-- Bill  accordion group -->
					
					<!--Bill -->
					<div class="card">
					      <div class="card-header">
					      	<h5 class="card-title" align="left" >
					          <button class="btn btn-sm btn1" style="background-color: #A2B29F;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse6">
					            <b> Bill (<b> <%=BillCount%> </b> ) </b>
					         </button>
					        </h5>
					       
					      </div>
					  <div id="collapse6" class="card-collapse collapse">
					
					<!-- Bill   -->
										   
					  <div class="col-md-12"><h5 class="text-primary"><b>Bill Details</b></h5></div>
					        <table  class="table table-bordered table-hover table-striped table-condensed">
					            <thead>
					                <tr>
					                	<th>Sl No</th>
					                   	<th>Dem No</th>
					                    <th>Received Date</th>
					                    <th>Item For</th>
					                    <th>Mode</th>
					                    <th>Budget</th>
					<!--                     <th>In Bill Date</th> -->
					                    <th>Out Bill Date</th>
					                    <th>Event Date</th>
					                    <th>Current Status</th>
					                    <th>Days</th>
					                    
					                </tr>
					            </thead>
					            <tbody>
					            <%int count5=0;
					            for(Object[] ls: FileTrackingWeeklyReportResult){
					            if("B".equalsIgnoreCase(ls[0].toString()))
					            {count5++;%> 
					        	   <tr>
					        	   <td><%=count5%></td>
					        	   <td><%=ls[1]%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[2].toString())%></td>
					        	   <td><%=ls[3]%></td>
					        	   <td><%=ls[4]%></td>
					        	   <td><%=ls[5]%></td>
					<%--         	   <td><%if(ls[19]!=null){%><%=fc.SqlToRegularDate(ls[19].toString())%><%}else{%><%="--"%><%}%></td> --%>
					        	   <td><%if(ls[20]!=null){%><%=fc.SqlToRegularDate(ls[20].toString())%><%}else{%><%="--"%><%}%></td>
					        	   <td><%=fc.SqlToRegularDate(ls[25].toString())%></td>
					        	   <td><%=ls[22]%></td>
					        	   <td><%=ls[23]%></td>
					        	  </tr> 
					            <%}}%>
					             
					            </tbody>
					     </table>
					  
					<!-- //Bill-->
					
					
					</div>
					</div>
					
					<!-- // Bill accordion group -->
					
				 <div class="row" style="margin:1rem 2rem;color:#382039; "><b>Total Files ( <%=totalCount %>   )</b></div>
					

					
					
					
				
				</div> <!-- ----------------card body-------------  -->
				
				
			</div>
		</div>
		
	</div>
</div>
<script type="text/javascript">
var fromdate=$('#fromDate').val();

$('.datepickerF').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,	
	"startDate" : fromdate ,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>


</body>
</html>