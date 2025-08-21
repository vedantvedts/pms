<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.Duration"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Time Sheet List</title>

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
List<Object[]> workingHrsList = (List<Object[]>)request.getAttribute("workingHrsList");
%>


	<div style="width: 98.5%;display: block;">
		<span class="left" style="width: 58.5%;margin-left: 10px;font-weight: bold;"></span>
		<span class="right" style="width: 40%;float: right;font-weight: bold;">Period : <%=fromDate!=null?StringEscapeUtils.escapeHtml4(fromDate): " - " %> to <%=toDate!=null?StringEscapeUtils.escapeHtml4(toDate): " - " %></span>
	</div>
	<table id="tabledata">
		<thead class="center">
			<tr>
				<th style="font-size: 18px;" colspan="9">TIME SHEET LIST</th>
			</tr>
			<tr>
				<th>SN</th>
				<th>Name</th>
				<th>Total Hrs</th>
				<th>No of Deficit</th>
				<th>Deficit Hrs</th>
				<th>No of Extra Hrs</th>
				<th>Extra Hrs</th>
				<th>Overall Hrs</th>
			</tr>
		</thead>
		<tbody class="center">
			<%
				if(workingHrsList!=null && workingHrsList.size()>0){
					int slno=0;
					for(Object[] obj : workingHrsList){
						int deficitcount = obj[5]!=null?Integer.parseInt(obj[5].toString()):0;
						int extracount = obj[7]!=null?Integer.parseInt(obj[7].toString()):0;
			%>
				<tr>
					<td class="center"><%=++slno %></td>
					<td class="left"><%=(obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-")+", "+(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-") %></td>
					<td class="center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
					<td class="center" style="<%if(deficitcount>0) {%>font-weight: bold;color: red<%}%>"><%=deficitcount %></td>
					<td class="center" style="<%if(deficitcount>0) {%>font-weight: bold;color: red<%}%>"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></td>
					<td class="center" style="<%if(extracount>0) {%>font-weight: bold;color: green<%}%>"><%=extracount %></td>
					<td class="center" style="<%if(extracount>0) {%>font-weight: bold;color: green<%}%>"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %></td>
					<%
					Duration duration = Duration.between(LocalTime.parse(obj[6].toString()), LocalTime.parse(obj[8].toString()));
				    
					long totalSeconds = Math.abs(duration.getSeconds());
			        long hours = totalSeconds / 3600;
			        long minutes = (totalSeconds % 3600) / 60;
			        long seconds = totalSeconds % 60;
					%>
					<td class="center" style="<%if((extracount-deficitcount)<0) {%>font-weight: bold;color: red;<%}else{%>font-weight: bold;color: green;<%}%>"><%=String.format("%s%02d:%02d:%02d", duration.isNegative() ? "-" : "",hours, minutes, seconds) %></td>
				</tr>
			<%} }else{%>
				<tr>
					<td colspan="9">No Data Available</td>
				</tr>
			<%} %>
		</tbody>	
	</table>
</body>
</html>