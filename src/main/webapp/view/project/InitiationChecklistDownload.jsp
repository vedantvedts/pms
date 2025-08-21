<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%String clno= (String)request.getAttribute("clno");
Object[] initiationdata= (Object[])request.getAttribute("initiationdata");%>
<title>Checklist - <%=clno!=null?StringEscapeUtils.escapeHtml4(clno): " - " %></title>
<style type="text/css">

td{
	padding : 5px 15px;
}

 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
@page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          @top-right {
          	 
          	 content : "Project : <%=initiationdata[9]!=null?StringEscapeUtils.escapeHtml4(initiationdata[9].toString()): " - " %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "DRDO";
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "DRDO";
          }     
          
           @top-center { 
          margin-top: 30px;
          content: "Checklist - 0<%=clno!=null?StringEscapeUtils.escapeHtml4(clno): " - " %>" ; 
          
          }

 }
 
 th , td{
 
 font-size: 19px;
 }
 
</style>
</head>
<body>
<%
	List<Object[]> checklist= (List<Object[]>)request.getAttribute("checklist");
%>
<div class="pageborder"  >
	<div  style="max-width: 650px; " >
		<table style="margin: auto; max-width: 650px; " >
			<%--  <tr>
				<th colspan="6" style="text-align: center ; "><b>Checklist0<%=clno %></b><br><br></th>
			</tr> --%>
			<tr>
				<th colspan="6" style="text-align: left;"><br><br><b>This check-list should be placed on the file on top of Detailed Project Proposal</b><br><br></th>
			</tr> 
			<% 	ArrayList<String> clsn1 =new  ArrayList<String>();
				for(Object[] item : checklist){
					
					if(item[1].toString().equalsIgnoreCase(clno))
					{
			%>
			<tr>
				<td style="width: 10%; text-align: right; padding-top: 0px;">
			  					
					<%if(!clsn1.contains(item[2].toString() ))
					{
						clsn1.add(item[2].toString() );%>
						<%=item[2]!=null?StringEscapeUtils.escapeHtml4(item[2].toString()): " - " %>
					<%} %>
				</td>			
				  					
				<td colspan="4"  style=" overflow-wrap: break-word; width: 80%">
					<%if(Integer.parseInt(item[3].toString())>0) { %>	
						<%=item[4]!=null?StringEscapeUtils.escapeHtml4(item[4].toString()): " - " %>
					<%}else if(Integer.parseInt(item[3].toString())==0){ %>
						<b><%=item[4]!=null?StringEscapeUtils.escapeHtml4(item[4].toString()): " - " %></b>
					<%} %>
				</td>
				<td style="width: 10%" >
					<%if(Integer.parseInt(item[3].toString())>0) { %>				  						
						<%if(item[5]!= null && (item[5]).toString().equalsIgnoreCase("1")){ %>
							<b>YES</b>						
						<%}else{%>
							<b>NO</b>
						<%} %>
					<%} %>
				</td>
			</tr>
			<%	}
			}%>
		
		
			<tr >
				<td></td>
				<td colspan="5" >
				<br>
						It is certified that points raised in check list has been taken into consideration and necessary information / papers have been placed in file.
				</td>
			</tr>
			<tr>
				<td colspan="6" style="text-align: right;" ><br><br><br><br><br><br><b> (Signature of Director PM O/o of Cluster DG) </b>	<br><br>	</td>
			</tr>
		</table>
		
	</div>
</div>

</body>
</html>