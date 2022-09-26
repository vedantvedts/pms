<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../../static/header.jsp"></jsp:include>

<style type="text/css">
.content-header{
padding-top:10px !important;
padding-bottom:10px !important;
}


.customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

.customers td, .customers th {
    border: 1px solid #ddd;
    padding: 8px;
}


.customers th {
    padding-top: 12px;
    padding-bottom: 12px;
/*     text-align: left; */
    background-color: #0b7abf;
    color: white;
}

.clickable:hover{
  cursor: pointer;
  background-color: #68829e;
  color:#f9f9f9;
}

.btn{
    padding-top: 4px;
    padding-right: 12px;
    padding-bottom: 4px;
    padding-left: 12px;
}

</style>


<spring:url value="/resources/js/dataTables.buttons.min.js" var="datatablejsbuttons" />
<script src="${datatablejsbuttons}"></script>

<spring:url value="/resources/js/buttons.flash.min.js" var="datatablejsflash" />
<script src="${datatablejsflash}"></script>

<spring:url value="/resources/js/jszip.min.js" 	var="datatablejszip" />
<script src="${datatablejszip}"></script>

<spring:url value="/resources/js/pdfmake.min.js" var="datatablejspdfmake" />
<script src="${datatablejspdfmake}"></script>

<spring:url value="/resources/js/vfs_fonts.js" var="datatablejsvfs" />
<script src="${datatablejsvfs}"></script>

<spring:url value="/resources/js/buttons.html5.min.js" 	var="datatablejshtml5" />
<script src="${datatablejshtml5}"></script>

<spring:url value="/resources/js/buttons.print.min.js" 	var="datatablejsprint" />
<script src="${datatablejsprint}"></script>


</head>
<body>

<%
	List<Object[]>  modewisefilesCount=(List<Object[]>)request.getAttribute("modewisefilesCount");
	

	String fromDate=(String)request.getAttribute("fromDate");
	String toDate=(String)request.getAttribute("toDate");
	SimpleDateFormat format=new SimpleDateFormat("dd-MM-yyyy");
%>
<input type="hidden" id="fromDate" value="<%=fromDate%>">
<input type="hidden" id="toDate" value="<%=toDate%>">
<div class="container-fluid" >
	<div class="card" >
	
		<div class="card-header" align="left">
			<div class="row" >
				<div class="col-md-6"> <h4>File Monitoring Report</h4></div>
				<div class="col-md-6" align="right">
					<form action="ModeWiseFilesReport.htm" style="float: right;" method="post" >
						<div class="form-inline" >
							<div class="form-group">
								<label class="control-label" for="textinput"><font size="3">From Date :&nbsp;&nbsp;&nbsp;</font></label>
								<input type="text" name="fromDate" id="" size="8" class="datepickerF form-control" readonly/>
							</div>
							<div class="form-group" style="margin-left: 10px;" >
								<label class="control-label" for="textinput"><font size="3">To Date :&nbsp;&nbsp;&nbsp;</font></label>
								<input type="text" name="toDate" id="" size="8" class="datepickerT form-control" readonly/>
							</div>
							<div class="form-group" >
								<button type="Submit" class="btn btn-primary"><i class="fa fa-arrow-right"></i></button>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>	
				</div>
			</div>
		</div>	
		
		<div class="card-body">
				<table  class="table table-hover  table-striped table-condensed table-bordered customers DataTableWithPdfandExcel">
			                              <thead> 
			                                <tr>            
			                                    <th>Process</th>
												<th style="text-align:center;">OT</th>
												<th style="text-align:center;">LT</th>
												<th style="text-align:center;">ST</th>
												<th style="text-align:center;">PAC</th>
												<th style="text-align:center;">LPC</th>
												<th style="text-align:center;">GeM</th>
												<th style="text-align:center;">OTHERS</th>
												<th style="text-align:center;">TOTAL</th>
											</tr>
			                               </thead>
			                               <tbody>
			                               <%if(modewisefilesCount!=null){ 
			                               for(Object[] count:modewisefilesCount){
			                               %>
			                               
											<tr>
												<%if(count[0].toString().equalsIgnoreCase("BF_FileReceived")){ %>
												<td>Brought Forward File Received On <%=fromDate %></td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("ReceivedFromToDate")){ %>
												<td>File Received between <%=fromDate %> to <%=toDate %></td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("CancelFromToDate")){ %>
												<td>Cancel/ShortClosed Files From <%=fromDate %> to <%=toDate %></td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("Total")){ %>
												<td>Total Files In Progress As On <%=toDate %></td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("OrderPlacedFromToDate")){ %>
												<td>Order Placed From <%=fromDate %> to <%=toDate %></td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("OrderNotPlaced")){ %>
												<td>Files In Progress As On <%=toDate %></td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("OrderPlacedWithin60Days")){ %>
												<td>Order Placed Within 60 Days</td>
												<%} %>
												<%if(count[0].toString().equalsIgnoreCase("PercentageAchieved")){ %>
												<td>% Achieved</td>
												<%} %>
												
												<%if(count[1]!=null){ %>
												<td align="center"><%=count[1] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[2]!=null){ %>
												<td align="center"><%=count[2] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[3]!=null){ %>
												<td align="center"><%=count[3] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[4]!=null){ %>
												<td align="center"><%=count[4] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[5]!=null){ %>
												<td align="center"><%=count[5] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[6]!=null){ %>
												<td align="center"><%=count[6] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[7]!=null){ %>
												<td align="center"><%=count[7] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
												<%if(count[8]!=null){ %>
												<td align="center"><%=count[8] %></td>
												<%}else{ %>
												<td align="center">0</td>
												<%} %>
											</tr>
											
											<%}}%>
			                               </tbody> 
			       </table>
			       <div class="row" align="center">
				       <div class="col-md-3"></div>
				       <div class="col-md-6">
							<form action="SOPlaced.htm" method="post" >
				       			<input type="hidden" name="fromDate" value="<%=fromDate%>">
				       			<input type="hidden" name="toDate" value="<%=toDate%>">
				       			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				       			
				      	 		<button type="submit" formaction="SOPlaced.htm"  formmethod="post" class="btn btn-primary "   name="Details" ><b>So Placed</b></button>
							
				      	 		<button type="submit" formaction="FirleInProgress.htm" formmethod="post" class="btn btn-primary " name="Details" ><b>File In Progress</b></button>
							
				      	 		<button type="submit" formaction="fileMonitoring.htm" formmethod="post" class="btn btn-primary " name="Details" ><b>SO Placed-Days</b></button>
					
				      	 		<button type="submit" formaction="ClosedFiles.htm" formmethod="post" class="btn btn-primary " name="Details" ><b>Closed Files</b></button>
							</form>
						</div>
				   </div>	
		</div>					
	</div>
</div>

<script type="text/javascript">


var fromdate=$("#fromDate").val();
var todate=$("#toDate").val();


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


$('.datepickerT').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,	
	"startDate" : todate ,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(document).ready(function() {
	
    $('.DataTableWithPdfandExcel').DataTable( 
    {    	
    	dom: 'Brt',
    	
    	buttons: [
         	{
         		
         		extend: "pdfHtml5",
         		className: "btn-sm btn1  ",
         		title: 'Milestone Report', 
         		orientation: 'portrait',
         		pageSize: 'A4',
         		titleAttr: 'Print PDF',
         		text: '<i class="fa fa-file-pdf-o"style="font-size: 25px;" aria-hidden="true" ></i>',
         		
         		download:'open',
         		
         	 	
         	},
         	{
         		extend: "excel",
         		className: "btn-sm btn1 ",
         		title: 'Milestone Report',
         		titleAttr: 'Print excel',
         		text: '<i class="fa fa-file-excel-o" style="font-size:25px" aria-hidden="true" 	 ></i>'
         	},{
                extend:    'csvHtml5',
                className: "btn-sm btn1 ",
                text:      '<i class="fa fa-file-text-o" style="font-size:25px" aria-hidden="true" ></i>',
                titleAttr: 'CSV'
            },{
                extend: 'copyHtml5',
                className: "btn-sm btn1 ",
                text:   '<i class="fa fa-clipboard" style="font-size:25px" aria-hidden="true"></i>',
                titleAttr: 'Copy',
                title: 'Milestone Report'
            }
    	]
    } );
} );
</script>


</body>
</html>