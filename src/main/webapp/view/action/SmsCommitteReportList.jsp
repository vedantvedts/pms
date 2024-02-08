<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SMS Committe Report List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>
<div class="page-wrapper">
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Change the pattern according to your date format
		Date fromdate=dateFormat.parse(frmDt);
		Date todate=dateFormat.parse(toDt);
		List<Object[]> SmsCommitteReportList=(List<Object[]>)request.getAttribute("SmsReportList");
		%>
		<%
		String ses=(String)request.getParameter("result"); 
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
		
		</div>
		
		<div class="card" style="width: 100%;">
		<div class="card-header" style="height: 3rem">
 <form action="SmsCommitteReportList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
          <input type="hidden" name="frmdate" value="<%=frmDt%>">
          <input type="hidden" name="tdate" value="<%=toDt%>">
          <span><b>PMS Committe Report (SMS) </b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <button type="submit" style="margin-top: -10px;" formaction="PMSSmsCommitteReportListExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/ExcelSheet.jpg"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <span><b>SMS Committe Report Excel List ( <%=sdf.format(fromdate)+" to "+sdf.format(todate) %> )</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" style="margin-top: -10px;" formaction="SmsCommitteReportExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/ExcelSheet.jpg"></button>&nbsp;&nbsp;&nbsp; 
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:50px; ">From	</label>&nbsp;&nbsp;
              <input type="text" style="width:120px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label for="todate" style="text-align: center;font-size: 16px;width:50px; ">To</label>&nbsp;&nbsp;
              <input type="text" style="width:120px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              
          </div>
        </div>
      </div>
      </form>
</div>
<div class="card-body" >
			<div class="table-responsive">
 	  		  <table class="table table-bordered table-hover table-striped table-condensed" style="width: 100%"   id="myTable1">
							<thead>
								<tr>
									<th style="text-align: center;" class="text-nowrap">SN</th>
									<th style="text-align: center;" class="text-nowrap">EmpName</th>
									<th style="text-align: center;" class="text-nowrap">Mobile No</th>
									<th style="text-align: center;" class="text-nowrap">Message</th>
									<th style="text-align: center;" class="text-nowrap">Sms Sent Date</th>
								</tr>
							</thead>
							<tbody>
							<%
							 int count=1;
							if(SmsCommitteReportList!=null && SmsCommitteReportList.size()>0){
							for (Object[] obj : SmsCommitteReportList) {
								if(obj[2]!=null && Integer.parseInt(obj[2].toString())>0 || obj[5]!=null && Integer.parseInt(obj[5].toString())>0 || obj[8]!=null && Integer.parseInt(obj[8].toString())>0){
							%>
								<tr>
									<td style="width:10px; text-align: center;"><%=count%></td>
                                    <td class="wrap" style="text-align: left; width:200px;"><%if(obj[0]!=null && obj[1]!=null){ %><%=obj[0].toString().trim()+", "+obj[1].toString() %><%}else{ %>-<%} %></td>
                                    <td class="wrap" style="text-align: center; width:80px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center; width:50px;" ><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[4]!=null){ %><%=sdf.format(obj[4]) %><%}else{ %>NA<%} %></td> 
									</tr>
									<%
									count++;}}}
									%> 
									</tbody>
						    </table>
						</div>
			</div>
</div>
</body>
<script>
$("#myTable1").DataTable({
    "lengthMenu": [15, 30, 60, 80, 100],
     ordering: true

});	

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
		"maxDate" : new Date(maxDate),  
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$(document).ready(function(){
		   $('#fromdate,#todate').change(function(){
		       $('#myform').submit();
		    });
		});
</script>
</html>