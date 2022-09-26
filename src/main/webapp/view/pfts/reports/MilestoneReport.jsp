<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../../static/header.jsp"></jsp:include>



<title>File MileStone Report</title>

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

.btn1
{
	background-color: #CAB8FF;
	border: 0px;
	padding: 5px 10px;
	margin: 0px -3px;
	border: 1px solid grey;
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
	List<Object[]>  milestoneDetails=(List<Object[]>)request.getAttribute("milestoneDetails");
	String fromDate=(String)request.getAttribute("fromDate");
	String toDate=(String)request.getAttribute("toDate");
	SimpleDateFormat format=new SimpleDateFormat("dd-MM-yyyy");
	DecimalFormat df=new DecimalFormat("###############.##");
%>


	<div class=" container-fluid" >
		<div class="card ">
		
			<div class="card-header" >
				<div class="row">
					<div class="col-md-6">
						<h4>File Milestone Report</h4>
					</div>
					<div class="col-md-6" align="right">
						<form action="PftsMilestoneReport.htm" method="post" >
							<table style="width: 75%;">
								<tr>
									<td><font size="3">From Date :</font></td>
									<td><input type="text" name="fromDate" id="" size="8" class="datepickerF form-control" readonly/></td>
								
									<td><font size="3">To Date :</font></td>
									<td><input type="text" name="toDate" id="" size="8" class="datepickerT form-control" readonly/></td>
								
									<td><button type="Submit" class="btn btn-primary"><i class="fa fa-arrow-right"></i></button></td>
								</tr>
							</table>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>				
				</div>
			</div>	
			
			
			<div class="card-body" style="min-height :35rem ;">			
	<!--  ---------------------- table ------------------------------------------  -->
				<div>	
			
	                     <table id="example" class="table table-bordered table-hover DataTableWithPdfandExcel" > 
	                         <thead>  
	                                <tr style="background-color:#B5DEFF">
	                                	<th>Sl&nbsp;No</th>            
	                                    <th>Demand&nbsp;No</th>
										<th>Demand&nbsp;For</th>
										<th style="text-align:right;">Estimated Cost</th>
										<th>Mode</th>
										<th>Initiating Officer</th>
								<!-- 	<th>Case Worker</th> -->
										<th style="text-align:center;">File Received</th>
										<th style="text-align:center;">PAC Request&nbsp;&nbsp;</th>
										<th style="text-align:center;">PAC Received</th>
										<th style="text-align:center;">CFA Approval</th>
										<th style="text-align:center;">Tender No</th>
										<th style="text-align:center;">Tender&nbsp;&nbsp; Date</th>
										<th style="text-align:center;">Tender Due&nbsp;Date</th>
										<th style="text-align:center;">CST/TCEC Date</th>
										<th style="text-align:center;">CNC Request&nbsp;&nbsp;</th>
										<th style="text-align:center;">CNC Date</th>
										<th style="text-align:center;">FC Request&nbsp;&nbsp;</th>
										<th style="text-align:center;">FC Received</th>
										<th style="text-align:center;">BG Received</th>
										<th style="text-align:center;">Sanction Date</th>
										<th style="text-align:center;">SO&nbsp;Date</th>
										<th>No&nbsp;Of Days</th>
										<th>Event&nbsp;Status</th>
										<th>Remarks</th>
										
									</tr>
	                               </thead>
	                               <tbody>
	                               <%
	                               int count=0;
	                               if(milestoneDetails!=null){ 
	                               for(Object[] details:milestoneDetails){
	                            	   count++;
	                               %>
									<tr>
										<td  align="center" ><%=count %></td>
										<td align="center"><%=details[0] %></td>
										<td><%=details[1] %></td>
										<td align="right"><%=NFormatConvertion.convert(Double.parseDouble(details[2].toString())) %></td>
										<td align="center"><%=details[3] %></td>
										<td><%=details[4] %></td>
										
										
										<%if(details[6]!=null){ %>
										<td style="white-space: nowrap;"><%=format.format(details[6]) %></td>
										<%}else{ %>
										<td>--</td>
										<%} %>
										
										<%if(details[7]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[7]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[8]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[8]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[9]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[9]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[10]!=null){ %>
										<td align="center"><%=details[10] %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[11]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[11]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[12]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[12]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[13]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[13]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[14]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[14]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[15]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[15]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[16]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[16]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[17]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[17]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[19]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[19]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[18]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[18]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[21]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=format.format(details[21]) %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[33]!=null){ %>
										<td style="white-space: nowrap;" align="center"><%=details[33] %></td>
										<%}else{ %>
										<td align="center">--</td>
										<%} %>
										
										<%if(details[32]!=null){ %>
										<td><%=details[32] %></td>
										<%}else{ %>
										<td>--</td>
										<%} %>
										
										<%if(details[34]!=null){ %>
										<td><%=details[34] %></td>
										<%}else{ %>
										<td>--</td>
										<%} %>
									</tr>
									<%}}%>                               
	                               </tbody> 
	    			   </table>
				</div>
	<!--  ---------------------- table ------------------------------------------  -->		
			</div>
			
			
			
		</div>
	</div>
	<input type="hidden" id="fromDate" value="<%=fromDate%>">
	<input type="hidden" id="toDate" value="<%=toDate%>">
	
	
	
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

</script>
<script type="text/javascript">
$(document).ready(function() {

	
    $('.DataTableWithPdfandExcel').DataTable( 
    {
    	lengthMenu : [  5,10,25, 50, 75, 100 ], 
    	scrollY : 350,
    	scrollX: true,
    	paging: true,
    	dom: 'Bfrtip',
    	buttons: [
         	{
         		extend: "pdfHtml5",
         		className: "btn-sm btn1  ",
         		title: 'Milestone Report', 
         		orientation: 'landscape',
         		pageSize: 'LEGAL',
         		pageSize: 'A2',
         		titleAttr: 'Print PDF',
         		text: '<i class="fa fa-file-pdf-o"style="font-size: 25px;" aria-hidden="true" ></i>',
         		download:'open'
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