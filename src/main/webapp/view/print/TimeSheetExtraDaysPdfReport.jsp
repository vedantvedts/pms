<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Extra Days</title>

<style>

.break{
	page-break-after: always;
} 

.border_black {
	border : 1px solid black;
	padding : 10px 5px;
}

    
.left{
	text-align: left !important;
}

.right{
	text-align: right !important;
}

.center{
	text-align: center !important;
}


#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
.bold{
	font-weight: 800 !important;
}

 @page  {             
          size: 790px 1120px;
          margin-top: 40px;
          margin-left: 50px;
          margin-right: 50px;
          margin-buttom: 40px; 	
          /* border: 1px solid black; */ 
          
          @bottom-left {          		
             content: "";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
             
                    
          /*  @bottom-right  {
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
          }  */
           @top-right {
             content: "";
             margin-top: 30px;
             font-size: 13px;
          }
          
          @top-center {
             content: "";
             margin-top: 30px;
             font-size: 13px;
          }
          
          @top-left {
          	margin-top: 30px;
          	content: "";
            font-size: 13px;
            
          }               
          
 }
       
#tabledata{
 margin-left : 10px;
 border-collapse : collapse;
 border : 1px solid black;
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
}

#tabledata td,th{
 border : 1px solid black;
 padding : 5px;
}

p
{
	text-align: justify !important;
  	text-justify: inter-word;
}
p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}
span,p,h1,h2,h3,h4,h5,h6{
	font-size: 17px !important;
	font-family: 'Times New Roman', Times, serif !important;
}

#tabledata td:first-child { 
	text-align: center; 
}

</style>
</head>
<body>
<%
String fromDate = (String)request.getAttribute("fromDate");
String toDate = (String)request.getAttribute("toDate");
String employeeName = (String)request.getAttribute("employeeName");
List<Object[]> extraworkingDaysList = (List<Object[]>)request.getAttribute("extraworkingDaysList");
List<Object[]> projectWiseExtraworkingDaysList = (List<Object[]>)request.getAttribute("projectWiseExtraworkingDaysList");
List<Object[]> holidayList = (List<Object[]>)request.getAttribute("holidayList");

FormatConverter fc = new FormatConverter();
%>

	<div style="width: 98.5%;display: block;">
		<span class="left" style="width: 58.5%;margin-left: 10px;font-weight: bold;">Employee : <%=employeeName!=null?employeeName: " - " %></span>
		<span class="right" style="width: 40%;float: right;font-weight: bold;">Period : <%=fromDate!=null?fromDate: " - " %> to <%=toDate!=null?toDate: " - " %></span>
	</div>
	<table id="tabledata">
		<thead class="center">
			<tr>
				<th style="font-size: 18px;" colspan="4">EXTRA DAYS</th>
			</tr>
			<tr>
				<th>SN</th>
				<th>Date</th>
				<th>Day</th>
				<th>No of Hrs</th>
			</tr>
		</thead>
		<tbody class="center">
			<%
				if(extraworkingDaysList!=null && extraworkingDaysList.size()>0){
					int slno=0;
					for(Object[] obj : extraworkingDaysList){
						String holidayName = holidayList!=null && holidayList.size()>0? holidayList.stream()
								.filter(e -> e[1].equals(obj[4]))
								.map(e -> e[2].toString()).findFirst().orElse(null):null;
			%>
				<tr>
					<td class="center"><%=++slno %></td>
					<td class="center"><%=obj[4]!=null?fc.sdfTordf(obj[4].toString()):"-" %></td>
					<td class="left"><%=obj[4]!=null?LocalDate.parse(obj[4].toString()).getDayOfWeek()+""+(holidayName!=null?" ("+holidayName+") ":""):"-" %></td>
					<td class="center"><%=obj[5]!=null?obj[5].toString()+":00":"-" %></td>
				</tr>
			<%} }else{%>
				<tr>
					<td colspan="4">No Data Available</td>
				</tr>
			<%} %>
		</tbody>	
	</table>
	
	<h1 class="break"></h1>
	<table id="tabledata">
		<thead class="center">
			<tr>
				<th style="font-size: 18px;" colspan="3">Project Wise Extra Hrs</th>
			</tr>
			<tr>
				<th>SN</th>
				<th>Project</th>
				<th>No of Hrs</th>
			</tr>
		</thead>
		<tbody class="center">
			<%
			if(projectWiseExtraworkingDaysList!=null && projectWiseExtraworkingDaysList.size()>0) {
				int slno=0;
				for(Object[] obj : projectWiseExtraworkingDaysList) {
			%>
				<tr>
					<td class="center"><%=++slno %></td>
					<td class="center"><%=obj[2]!=null?obj[2].toString():"-" %></td>
					<td class="center"><%=obj[3]!=null?obj[3].toString():"-" %></td>
				</tr>
			<%} }else{%>
				<tr>
					<td colspan="3">No Data Available</td>
				</tr>
			<%} %>
		</tbody>	
	</table>
</body>
</html>