<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>

<%	
	Object[] committeescheduleeditdata = (Object[]) request.getAttribute("committeescheduleeditdata");	
	LinkedHashMap< String, ArrayList<Object[]>> actionlist = (LinkedHashMap< String, ArrayList<Object[]>>) request.getAttribute("tableactionlist");
	Object[] projectdetails=(Object[])request.getAttribute("projectdetails");
	Object[] labdetails = (Object[]) request.getAttribute("labdetails");
		
	Object[] divisiondetails=(Object[])request.getAttribute("divisiondetails");
	String projectid= committeescheduleeditdata[9].toString();
	String divisionid= committeescheduleeditdata[16].toString();
		
	FormatConverter fc=new FormatConverter(); 
	SimpleDateFormat sdf=fc.getRegularDateFormat();
	SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
%>
<style type="text/css">

p{
  text-align: justify;
  text-justify: inter-word;
}



.break
	{
		page-break-after: always;
	} 
              
 
@page {             
          size: portrait;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black;    
         @bottom-right {          		
             content: "Page-AI " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
          @top-right {
          		<%if( Long.parseLong(projectid)>0){%>
             content: "<%=projectdetails[1]%>";
             <%}else if(Long.parseLong(divisionid)>0){%>
               	content: "Division:<%=divisiondetails[1]%>";
             <%}else {%>
             	content: "<%=labdetails[1]%>";
             <%}%>
             margin-top: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=committeescheduleeditdata[11] %>";
            font-size: 13px;
          }            
          
          @top-center { 
          margin-top: 30px;
          content: "<%=committeescheduleeditdata[15]%>"; 
           font-size: 13px;
          
          }
         
          @bottom-center { 
	          margin-bottom: 30px;
	          content: "<%=committeescheduleeditdata[15]%>"; 
          
          }
          
           @bottom-left { 
             font-size: 13px;
	          margin-bottom: 30px;
	          content: "<%=LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"))%>"; 
	          
          
          }   
          
      <%--     @bottom-left {          		
 			 content : "The info in this Doc. is proprietary of  <%if( Long.parseLong(projectid)>0){%> <%=projectdetails[1]%> <%}else if(Long.parseLong(divisionid)>0){%> Division:<%=divisiondetails[1]%> <%}else {%> <%=labdetails[1]%> <%}%> 	/DRDO , MOD Govt. of India. Unauthorized possession may be liable for prosecution.";
 			 margin-bottom: 30px;
             font-size: 9.5px;
          }  --%>
 }
 
 

 .sth
 {
 	font-size: 16px;
 	border: 1px solid black;
 }
 
 .std
 {
 	text-align: left;
 	border: 1px solid black;
 	padding :3px;
 }
 
</style>
<meta charset="ISO-8859-1">
<title><%=committeescheduleeditdata[8]%> Minutes View</title>
</head>
<body>
	
				<%if(actionlist.size()>=0){ %>
							
					<div align="center">
						<div style="text-align: center ; padding-right: 15px; " ><h3 style="text-decoration: underline;">Annexure - AI</h3></div>
						<div style="text-align: center;  " class="lastpage" id="lastpage"><h2>ACTION ITEM DETAILS</h2></div>
					
						<table style="  margin-left:10px; font-size: 16px; border-collapse: collapse ;border: 1px solid black ">
						<tbody>
							<tr>
								<th  class="sth" style=" max-width: 40px"> SN </th>
								<th  class="sth" style=" max-width: 110px"> Action Id</th>	
								<th  class="sth" style=" max-width: 600px"> Item</th>				
								<th  class="sth" style=" max-width: 100px"> Responsibility </th>					
								<th  class="sth" style=" width: 100px"> PDC</th>
							</tr>
							
							<% 	int count =1;
							  	Iterator actIterator = actionlist.entrySet().iterator();
								while(actIterator.hasNext()){	
								Map.Entry mapElement = (Map.Entry)actIterator.next();
					            String key = ((String)mapElement.getKey());
					            ArrayList<Object[]> values=(ArrayList<Object[]>)mapElement.getValue();
								%>
								<tr>
									<td class="std" style="text-align: center;"> <%=count%></td>
									<td  class="std">
										
										<%	int count1=0;
											for(Object obj[]:values){
												 count1++; %>
												<%if(count1==1 ){ %>
													<%if(obj[3]!=null){ %> <%= obj[3]%><%}else{ %> - <%} %>
												<%}else if(count1==values.size() ){ %>
													<%if(obj[3]!=null){ %> <br> - <br> <%= obj[3]%> <%}else{ %> - <%} %>
												<%} %>
										<%} %>
									</td>
									
									<td  class="std" style="padding-left: 5px;padding-right: 5px;text-align: justify;"><%= values.get(0)[1]  %></td>
									<td  class="std" >
									<%	int count2=0;
										for(Object obj[]:values){ %>
										<%if(obj[13]!=null){ %> <%= obj[13]%>,&nbsp;<%=obj[14] %>
											<%if(count2>=0 && count2<values.size()-1){ %>
											,&nbsp;
											<%} %>
										<%}else{ %> - <%} %>
									<%count2++;} %>
									</td>                       						
									<td  class="std"><%if( values.get(0)[5]!=null){ %> <%=sdf.format(sdf1.parse(values.get(0)[5].toString()))%> <%}else{ %> - <%} %></td>
								</tr>				
							<% count++;} %>
						</tbody>
					</table>
					</div>
					<br>	
				<%} %>

</body>
</html>