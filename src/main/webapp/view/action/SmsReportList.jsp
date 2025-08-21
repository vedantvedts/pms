<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SMS Action Report List</title>
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
		List<Object[]> SmsReportList=(List<Object[]>)request.getAttribute("SmsReportList");
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
		
		</div>
		
		<div class="card" style="width: 100%;">
		<div class="card-header" style="height: 3rem">
 <form action="SmsReportList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
          <input type="hidden" name="frmdate" value="<%=frmDt%>">
          <input type="hidden" name="tdate" value="<%=toDt%>">
          <span><b>PMS Action Report (SMS) </b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <button type="submit" style="margin-top: -10px;" formaction="PMSSmsReportListExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/ExcelSheet.jpg"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <span><b>SMS Action Report Excel List ( <%=fromdate!=null?sdf.format(fromdate):" - "+" to "+todate!=null?sdf.format(todate):" - " %> )</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" style="margin-top: -10px;" formaction="SmsActionReportExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/ExcelSheet.jpg"></button>&nbsp;&nbsp;&nbsp; 
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
									<th style="text-align: center;" class="text-nowrap">AIP</th>
									<th style="text-align: center;" class="text-nowrap">AITP</th>
								    <th style="text-align: center;" class="text-nowrap">AIDP</th> 
								    <th style="text-align: center;" class="text-nowrap">MSP</th> 
								    <th style="text-align: center;" class="text-nowrap">MSTP</th> 
								    <th style="text-align: center;" class="text-nowrap">MSDP</th> 
								    <th style="text-align: center;" class="text-nowrap">MTP</th> 
								    <th style="text-align: center;" class="text-nowrap">MTTP</th> 
								    <th style="text-align: center;" class="text-nowrap">MTDP</th> 
								</tr>
							</thead>
							<tbody>
							<%
							 int count=1;
							if(SmsReportList!=null && SmsReportList.size()>0){
							for (Object[] obj : SmsReportList) {
								if(obj[2]!=null && Integer.parseInt(obj[2].toString())>0 || obj[5]!=null && Integer.parseInt(obj[5].toString())>0 || obj[8]!=null && Integer.parseInt(obj[8].toString())>0){
							%>
								<tr>
									<td style="width:10px; text-align: center;"><%=count%></td>
                                     <td class="wrap" style="text-align: left; width:200px;"><%if(obj[0]!=null && obj[1]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[0].toString()).trim()+", "+StringEscapeUtils.escapeHtml4(obj[1].toString()) %><%}else{ %>-<%} %></td>
                                    <td class="wrap" style="text-align: center; width:80px;"><%if(obj[11]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[11].toString())%><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center; width:50px;" ><%if(obj[2]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[3]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[3].toString()) %><%}else{ %>-<%} %></td> 
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[4]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[4].toString())%><%}else{%>-<%} %></td> 
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[5]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[5].toString())%><%}else{%>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[6]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[6].toString())%><%}else{%>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[7]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[7].toString())%><%}else{%>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[8]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[8].toString())%><%}else{%>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[9]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[9].toString())%><%}else{%>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:50px;"><%if(obj[10]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[10].toString())%><%}else{%>-<%} %></td>
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