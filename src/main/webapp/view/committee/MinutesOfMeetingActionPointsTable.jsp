<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%

List<Object[]> speclists = (List<Object[]>) request.getAttribute("committeeminutesspeclist");
Object[] committeescheduleeditdata = (Object[]) request.getAttribute("committeescheduleeditdata");
List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("committeeinvitedlist");
Object[] labdetails = (Object[]) request.getAttribute("labdetails");
List<Object[]> actionlists = (List<Object[]>) request.getAttribute("actionlist");
List<Object[]> committeeagendalist=(List<Object[]>)request.getAttribute("committeeagendalist");
int addcount=0; 
 
String projectid= committeescheduleeditdata[9].toString();
String divisionid= committeescheduleeditdata[16].toString();
String initiationid= committeescheduleeditdata[17].toString();
Object[] projectdetails=(Object[])request.getAttribute("projectdetails");
Object[] divisiondetails=(Object[])request.getAttribute("divisiondetails");
Object[] initiationdetails=(Object[])request.getAttribute("initiationdetails");
int meetingcount= (int) request.getAttribute("meetingcount");

String[] no=committeescheduleeditdata[11].toString().split("/");

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();

String isprint=(String)request.getAttribute("isprint");
String lablogo=(String)request.getAttribute("lablogo");
Object[] membersec=null; 
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");

String ccmFlag = (String)request.getAttribute("ccmFlag");
String labcode= (String) session.getAttribute("labcode");
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
          size: 1120px 790px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black;    
         /* @bottom-right {          		
             content: "Page-AI " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          } */
          <%-- @top-right {
          		<%if( Long.parseLong(projectid)>0){%>
             content: "<%=projectdetails[1]!=null?projectdetails[1].toString(): " - "%>";
             <%}else if(Long.parseLong(divisionid)>0){%>
               	content: "Division:<%=divisiondetails[1]!=null?divisiondetails[1].toString(): " - "%>";
             <%}else {%>
             	content: "<%=labdetails[1]!=null?labdetails[1].toString(): " - "%>";
             <%}%>
             margin-top: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=committeescheduleeditdata[11]!=null?committeescheduleeditdata[1].toString(): " - " %>";
            font-size: 13px;
          }            
          
          @top-center { 
          margin-top: 30px;
          content: "<%=committeescheduleeditdata[15]!=null?committeescheduleeditdata[1].toString(): " - "%>"; 
           font-size: 13px;
          
          }
         
          @bottom-center { 
	          margin-bottom: 30px;
	          content: "<%=committeescheduleeditdata[15]!=null?committeescheduleeditdata[1].toString(): " - "%>"; 
          
          }
          
           @bottom-left { 
             font-size: 13px;
	          margin-bottom: 30px;
	          content: "<%=LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"))%>"; 
	          
          
          }   --%> 
          <%--     @bottom-left {          		
 			 content : "The info in this Doc. is proprietary of  <%if( Long.parseLong(projectid)>0){%> <%=projectdetails[1]%> <%}else if(Long.parseLong(divisionid)>0){%> Division:<%=divisiondetails[1]%> <%}else {%> <%=labdetails[1]%> <%}%> 	/DRDO , MOD Govt. of India. Unauthorized possession may be liable for prosecution.";
 			 margin-bottom: 30px;
             font-size: 9.5px;
          }  
          } --%>
  	 /* @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          } */
          @top-right {
          		<%if( Long.parseLong(projectid)>0){%>
             content: "Project:<%=projectdetails[4]!=null?projectdetails[4].toString(): " - "%>";
             <%}else if(Long.parseLong(divisionid)>0){%>
               	content: "Division:<%=divisiondetails[1]!=null?divisiondetails[1].toString(): " - "%>";
             <%}else if(Long.parseLong(initiationid)>0){ %>
             	content: "Pre-Project :<%=initiationdetails[1]!=null?initiationdetails[1].toString(): " - "%>";
             <%} else{%>
             	content: "<%=labdetails[1]!=null?labdetails[1].toString(): " - "%>";
             <%}%>
             margin-top: 30px;
             margin-right: 10px;
               font-size: 13px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=no[0]!=null?no[0].toString(): " - "%>/<%=no[1]!=null?no[1].toString(): " - "%>/<%=no[2]!=null?no[2].toString(): " - " %><%if(meetingcount>0){ %>#<%=meetingcount %><%} %>/<%=no[3]!=null?no[3].toString(): " - "%>";
             font-size: 13px;
          }      
          
          @top-center { 
           font-size: 13px;
          margin-top: 30px;
          content: "<%=committeescheduleeditdata[15]!=null?committeescheduleeditdata[15].toString(): " - "%>"; 
          
          }
          
           @bottom-center { 
             font-size: 13px;
	          margin-bottom: 30px;
	          content: "<%=committeescheduleeditdata[15]!=null?committeescheduleeditdata[15].toString(): " - "%>"; 
          
          } 
          
          @bottom-left { 
             font-size: 13px;
	          margin-bottom: 30px;
	          content: "<%=LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"))%>"; 
          } 
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

.fixed-table {
    table-layout: fixed; /* Forces equal strict width distribution */
    width: 100%; /* or set specific width if needed */
}
.fixed-table th, .fixed-table td {
    word-wrap: break-word; /* Prevent content from expanding cells */
}

 </style>
</head>
<body>
<div align="center" style="text-decoration: underline; margin:10px;">Annexure - A</div>	
<div align="left" style="margin:10px;margin-left: 30px; font-weight: bold;">Record of Discussions and Action Points of Current Meeting</div>
<div align="left" style="margin:10px;margin-left: 60px;">Item Code/Type : A: Action, C: Comment, D: Decision, R: Recommendation</div>
		
<table class="fixed-table" style="margin: 20px;width: 100%; font-size: 16px; border-collapse: collapse ;border: 1px solid black; ">
					<thead>
						<tr>
							<th  class="sth" style="width: 5%; border: 1px solid black;"> SN</th>
							<th  class="sth" style="width: 20%; border: 1px solid black;">Action Id</th>
							<th  class="sth" style="width: 5%; border: 1px solid black;"> Type</th>
							<th  class="sth" style="width: 10%; border: 1px solid black;"> Aircraft</th>
							<th  class="sth" style="width: 10%; border: 1px solid black;"> SubSystem</th>
							<th  class="sth" style="width: 20%; border: 1px solid black;"> Item</th>				
							<th  class="sth" style="width: 20%; border: 1px solid black;"> Responsibility</th>
							<th  class="sth" style="width: 10%; border: 1px solid black;"> PDC</th>	
						</tr>
					</thead>
					<tbody>
							<% int count=0;
							Map<String, List<Object[]>> actionslist = speclists!=null && speclists.size()>0?speclists.stream()
									  .collect(Collectors.groupingBy(array -> array[1].toString() , LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
								
							String agenda="";
							String action = "";
							if (actionslist!=null && actionslist.size() > 0) {
							for (Map.Entry<String, List<Object[]>> map : actionslist.entrySet()) {
							    List<Object[]> values = map.getValue();
							    for (Object[] obj : values) {
								
								if(obj[3]!=null && Integer.parseInt(obj[3].toString())==3 ){ %>					
					<%if(obj[10]!=null && !obj[10].toString().equalsIgnoreCase(agenda)){ %>
					<tr>
						<td colspan="8" class="std"
							style="text-align: center; border: 1px solid black;padding:10px;font-weight: bold"><%=obj[10]!=null?obj[10].toString(): " - "%>
						</td>
					</tr>
					<%} %>
					<% if( obj[1]!=null && obj[7]!=null && obj[7].toString().equalsIgnoreCase("A") && !obj[1].toString().equalsIgnoreCase(action)) { %>
							 <tr>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;"  > <%=++count%></td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;">
								<%-- <%=obj[14]!=null?obj[14].toString(): " - "%> --%>
								<%	int count1=0;
									for(Object obj1[]:values){
										 count1++; %>
										<%if(count1==1 ){ %>
											<%if(obj1[14]!=null){ %> <%= obj1[14].toString()%><%}else{ %> - <%} %>
										<%}else if(count1==values.size() ){ %>
											<%if(obj1[14]!=null){ %> <br> - <br> <%=obj1[14].toString()%> <%}else{ %> - <%} %>
										<%} %>
								<%} %>
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;" >	
								<%=obj[7]!=null?obj[7].toString(): " - "%>
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;" >	
								<%=obj[15]!=null?obj[15].toString(): " - "%>
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;" >	
								<%=obj[16]!=null?obj[16].toString(): " - "%>
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:5px;">
								<%=obj[1]!=null?obj[1].toString(): " - "%>
								<%-- <%= action!=null?action:"-" %> --%>
								
								</td> 
								<td  class="std" style="border:1px solid black;padding:10px;text-align: center;">
									<%-- <%=obj[13]!=null?obj[13].toString(): " - "%> --%>
									<%	int count2=0;
										for(Object obj1[]:values){ %>
										<%if(obj1[13]!=null){ %> 
											<%= obj1[13].toString() %>
										<%}else{ %> - <%} %>
									<%count2++;} %>
								</td>
								
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;">
									<% if(obj[12]!=null) {%><%=sdf.format(sdf1.parse(obj[12].toString())) %> <%} else { %> - <%} %>
									<%-- <%if( values.get(0)[5]!=null){ %> <%=sdf.format(sdf1.parse(values.get(0)[5].toString()))%> <%}else{ %> - <%} %> --%>
								</td>
							</tr> 
							<%
								action = obj[1].toString();
							} else if(obj[7]!=null && !obj[7].toString().equalsIgnoreCase("A")) { %>
							 <tr>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;"  > <%=++count%></td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;">
								<%=obj[14]!=null?obj[14].toString(): " - "%> 
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;" >							
									<%if(obj[7].toString().equals("D")){ %>D<%}
							 		else if(obj[7].toString().equals("R")){ %>R<%} 
							 		else if(obj[7].toString().equals("I")){ %>I<%} 
							 		else if(obj[7].toString().equals("C")){ %>C<%}
							 		else if(obj[7].toString().equals("K")){ %>Ri<%} %> 				
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;" >	
									<%=obj[15]!=null?obj[15].toString(): " - "%>
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;" >	
									<%=obj[16]!=null?obj[16].toString(): " - "%>
								</td>
								<td class="std" style="text-align :center;border:1px solid black; padding:5px;">
									<%=obj[1]!=null?obj[1].toString(): " - "%>
								</td>
								<td  class="std" style="border:1px solid black;padding:10px;text-align: center;">
									<%=obj[13]!=null?obj[13].toString(): " - "%>
								</td>
								
								<td class="std" style="text-align :center;border:1px solid black; padding:10px;">
									<% if(obj[12]!=null) {%><%=sdf.format(sdf1.parse(obj[12].toString())) %> <%} else { %> - <%} %>
								</td>
							</tr> 
							<%
							action = obj[1].toString();
							}
							agenda=obj[10].toString();
 						} 
							}}}%>
							<% if(count==0){%>
								<tr>
									<td class="std" style="text-align :center;border:1px solid black;"  colspan="8">No Minutes details Added</td>
								</tr>
							<%} %>
							</tbody>
						</table>
						
</body>
</html>