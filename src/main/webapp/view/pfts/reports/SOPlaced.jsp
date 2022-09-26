<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../../static/header.jsp"></jsp:include>
<title>SO Placed</title>
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
	List<Object[]>  modewiseCountList=(List<Object[]>)request.getAttribute("modewiseCountList");
	List<Object[]>  modewiseDetails=(List<Object[]>)request.getAttribute("modewiseDetails");
	Map<String,List<Object[]>>  detailsMap=(Map<String,List<Object[]>>)request.getAttribute("detailsMap");

	String fromDate=(String)request.getAttribute("fromDate");
	String toDate=(String)request.getAttribute("toDate");
	SimpleDateFormat format=new SimpleDateFormat("dd-MM-yyyy");
	DecimalFormat df=new DecimalFormat("###############.##");
%>
<input type="hidden" id="fromDate" value="<%=fromDate%>">
<input type="hidden" id="toDate" value="<%=toDate%>">
	<div class="container-fluid">
			
			<div class="card" >
				<div class="card-header" >
					<div class="row" >
						<div class="col-md-6" ><h4>Supply Order Placed Report</h4></div>
						<div class="col-md-6" align="right">
							<form action="SOPlaced.htm" style="float:right; " >
								<div class="form-inline" align="right">
									<div class="form-group">
										<label class="control-label" for="textinput"><font size="3">From Date :&nbsp;&nbsp;&nbsp;</font></label>
										<input type="text" name="fromDate"  size="10" class="datepickerF form-control" readonly/>
									</div>
									<div class="form-group" style="margin-left: 10px;" >
										<label class="control-label" for="textinput"><font size="3">To Date :&nbsp;&nbsp;&nbsp;</font></label>
										<input type="text" name="toDate"  size="10" class="datepickerT form-control" readonly/>
									</div>
									<div class="form-group" >
										<button type="Submit" class="btn btn-primary"><i class="fa fa-arrow-right"></i></button>
									</div>
								</div>
							</form>	
						</div>
					</div>
				</div>	
				
				<div class="card-body" >
					
					<table  class="table table-hover  table-striped table-condensed table-bordered " id="datatable">
                              <thead> 
                                <tr style="background-color: #94DAFF;">            
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
                               <%if(modewiseCountList!=null){ 
                               for(Object[] count:modewiseCountList){
                               %>
                               
								<tr>
									<%if(count[0].toString().equalsIgnoreCase("OrderPlaced0to20Days")){ %>
									<td>Order Placed Between 0-20 Days</td>
									<%} %>
									<%if(count[0].toString().equalsIgnoreCase("OrderPlaced21to40Days")){ %>
									<td>Order Placed Between 21-40 Days</td>
									<%} %>
									<%if(count[0].toString().equalsIgnoreCase("OrderPlaced41to60Days")){ %>
									<td>Order Placed Between 41-60 Days</td>
									<%} %>
									<%if(count[0].toString().equalsIgnoreCase("OrderPlacedAbove60Days")){ %>
									<td>Order Placed Above 60 Days</td>
									<%} %>
									<%if(count[0].toString().equalsIgnoreCase("TotalFileRecievedAndOrderPlaced")){ %>
									<td>Total File Received And Order Placed</td>
									<%} %>
									<td align="center"><%=count[1] %></td>
									<td align="center"><%=count[2] %></td>
									<td align="center"><%=count[3] %></td>
									<td align="center"><%=count[4] %></td>
									<td align="center"><%=count[5] %></td>
									<td align="center"><%=count[6] %></td>
									<td align="center"><%=count[7] %></td>
									<td align="center"><%=count[8] %></td>
								</tr>
								
								<%}}%>                               
                               </tbody> 
       				</table>
					
					
					<font size="3"><b>List Of Files Whose Order Placed:-</b></font>
					<table  class="table table-hover  table-striped table-condensed table-bordered customers" id="datatable1">
                              <thead> 
                                <tr style="background-color: #94DAFF;">            
									<th style="text-align:center;">Sl No.</th>
									<th style="text-align:center;">Demand&nbsp;No.</th>
									<th style="text-align:left;">SO&nbsp;No</th>
									<th style="text-align:center;">SO&nbsp;Date&nbsp;&nbsp;&nbsp;&nbsp;</th>
									<th style="text-align:left;">Project&nbsp;Code</th>
									<th style="text-align:left;">Demand&nbsp;For</th>
									<th style="text-align:right;">Estimated&nbsp;Cost</th>
									<th style="text-align:center;">FileReceived Date</th>
									<th style="text-align:center;">No&nbsp;Of Days</th>
									
								</tr>
                               </thead>
                               <tbody>
                               <%
                               int count=0;
                               if(detailsMap!=null && !detailsMap.isEmpty()){ 
                            	   for (String key:detailsMap.keySet()){
                               %>
                              
                               	<tr style="background-color:#d2fafb;">
<%--                                	<%=detailsMap.get(key).size()+1%> --%>
									<td colspan="9" style="vertical-align : middle;text-align:center;"><font size="3"><b> Demand Mode : <%=key.toString() %></b></font></td>
          						</tr>
                               <%for(Object[] details:detailsMap.get(key)){ 
                               		count++;
                               %>
								<tr>
									<td align="center"><%=count%></td>
									<td align="center"><%=details[1] %></td>
									<%if(details[5]!=null){ %>
									<td align="left"><%=details[5] %></td>
									<%}else{ %>
									<td align="left">--</td>
									<%} %>
									<td align="left"><%=format.format(details[7]) %></td>
									<td align="center"><%=details[2] %></td>
									<td align="left"><%=details[3] %></td>
									<td align="right"><%=df.format(details[4]) %></td>
									<td align="right"><%=format.format(details[6]) %></td>
									<td align="right"><%=details[8] %></td>
								</tr>
								 
								<%}}%>  
								<%}else{%>        
								<tr class="table-row table-tr " >
								<td align="center" colspan="10">No Recored Found</td>
								</tr>
								<%} %>                      
                               </tbody> 
       </table>
					
					
					
					
					
					
					
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
</script>

<script type="text/javascript">

	
    $('#datatable, #datatable1').DataTable( 
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
</script>
</body>
</html>