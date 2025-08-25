<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Project Time Sheet</title>

<style>

.break{
	page-break-after: always;
} 

.border_black {
	border : 1px solid black;
	padding : 10px 5px;
}

    
.left{
	text-align: left;
}

.right{
	text-align: right !important;
}

.center{
	text-align: center;
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
String projectName = (String)request.getAttribute("projectName");
String totalHrs = (String)request.getAttribute("totalHrs");
String cadreType = (String)request.getAttribute("cadreType");
List<Object[]> workingHrsList = (List<Object[]>)request.getAttribute("workingHrsList");
%>

	<div style="width: 98.5%;display: block;">
		<span class="left" style="width: 58.5%;margin-left: 10px;font-weight: bold;">Project : <%=projectName!=null?StringEscapeUtils.escapeHtml4(projectName): " - " %></span>
		<span class="right" style="width: 40%;float: right;font-weight: bold;">Period : <%=fromDate!=null?StringEscapeUtils.escapeHtml4(fromDate): " - " %> to <%=toDate!=null?StringEscapeUtils.escapeHtml4(toDate): " - " %></span>
	</div>
	<table id="tabledata">
		<thead class="center" >
			<tr>
				<th colspan="4" style="font-size: 18px;">PROJECT TIME SHEET</th>
			</tr>
			<tr>
				<th>SN</th>
				<th>Name</th>
				<th>Cadre</th>
				<th>Total Hrs</th>
			</tr>
		</thead>
		<tbody>
			<%
			if(cadreType!=null && !cadreType.equalsIgnoreCase("All")) {
				workingHrsList = workingHrsList!=null && workingHrsList.size()>0? workingHrsList.stream()
						 		 .filter(e -> e[3]!=null && e[3].toString().equalsIgnoreCase(cadreType))
						 		 .collect(Collectors.toList()): new ArrayList<>();
			}
				if(workingHrsList!=null && workingHrsList.size()>0){
					int slno=0;
					for(Object[] obj : workingHrsList){
			%>
				<tr>
					<td class="center"><%=++slno %></td>
					<td><%=(obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-")%> <%=", "%> <%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-") %></td>
					<td class="center"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
					<td class="center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
				</tr>
			<%} %>
				<tr>
					<td colspan="3" class="right" style="font-weight: bold;">Total</td>
					<td class="center"><%=totalHrs %></td>
				</tr>
			<%} else{%>
				<tr>
					<td colspan="4">No Data Available</td>
				</tr>
			<%} %>
		</tbody>	
	</table>
</body>
</html>