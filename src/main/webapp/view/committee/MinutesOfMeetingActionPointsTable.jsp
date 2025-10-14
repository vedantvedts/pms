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
          @top-right {
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
	          
          
          }   
          <%--     @bottom-left {          		
 			 content : "The info in this Doc. is proprietary of  <%if( Long.parseLong(projectid)>0){%> <%=projectdetails[1]%> <%}else if(Long.parseLong(divisionid)>0){%> Division:<%=divisiondetails[1]%> <%}else {%> <%=labdetails[1]%> <%}%> 	/DRDO , MOD Govt. of India. Unauthorized possession may be liable for prosecution.";
 			 margin-bottom: 30px;
             font-size: 9.5px;
          }  --%> 
          }
  	<%-- /* @bottom-right {          		
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
 
 
 --%>
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
								
								if(obj[3]!=null && Integer.parseInt(obj[3].toString())>=3&&Integer.parseInt(obj[3].toString())<6){ %>					
					<%if(obj[10]!=null && !obj[10].toString().equalsIgnoreCase(agenda)){ %>
					<tr>
						<td colspan="8" class="std"
							style="text-align: center; border: 1px solid black;padding:10px;font-weight: bold"><%=obj[10]!=null?obj[10].toString(): " - "%>
						</td>
					</tr>
					<%} %>
					<% if( obj[1]!=null && !obj[1].toString().equalsIgnoreCase(action)) { %>
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
											<%= obj1[13].toString()%>
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
						
	 	<%if(invitedlist.size()>0){ %>
		<% 
			ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","CW","CO","CH"));
			
			int memPresent=0,memAbscent=0,ParPresent=0,parAbscent=0;
			int j=0;
			for(Object[] temp : invitedlist){
			
				if(temp[4].toString().equals("P") &&  membertypes.contains( temp[3].toString()) )
				{ 
					memPresent++;
				}
				else if(temp[4].toString().equals("N") &&  membertypes.contains( temp[3].toString()) )
				{
					memAbscent++;
				}
				else if( temp [4].toString().equals("P") && !membertypes.contains( temp[3].toString()) )
				{ 
					ParPresent++;
				}
				else if( temp [4].toString().equals("N") && !membertypes.contains( temp[3].toString()) )
				{ 
					parAbscent++;
				}
			}
		%>
		
		
			<div align="center">
				<h2>ATTENDANCE</h2> 
			<div align="center" style="text-align: center;">
			<table style="margin: 10px auto; width: 80%; font-size: 16px; border-collapse:collapse;" >	
				
				 <tr>
					 <th style="text-align: center ;padding: 5px;border: 1px solid black;width: 10px; ">SN</th>
					 <th style="text-align: center ;padding: 5px;border: 1px solid black;width: 380px; ">Name, Designation</th>
					 <th style="text-align: center ;padding: 5px;border: 1px solid black;width: 120px; ">Estt. / Agency</th>
					 <th style="text-align: center ;padding: 5px;border: 1px solid black;width: 140px; ">Role</th>
				 </tr>
				  <tr>
					 <th colspan="4" style="text-align: left; font-weight: 700; border: 1px solid black; padding: 5px; padding-left: 15px">Members Present</th>
				 </tr>
				 <%if(memPresent > 0){ %>
				 
				 <% 
				 	for(int i=0;i<invitedlist.size();i++)
					{
				 	if(invitedlist.get(i)[4].toString().equals("P") && membertypes.contains( invitedlist.get(i)[3].toString()) )
				 	{ j++;%>
				 	
				 	 <tr>
				 	 <td style="border: 1px solid black; padding: 5px;text-align: center"><%=j%> </td>
				 	  	<td style="border: 1px solid black; padding: 5px;text-align: left">  
				 	  	
				 			<%= invitedlist.get(i)[6]!=null?invitedlist.get(i)[6].toString(): " - "%>,&nbsp;<%=invitedlist.get(i)[7]!=null?invitedlist.get(i)[7].toString(): " - " %>  
					 	</td>
					 	<td style="border: 1px solid black; padding: 5px;text-align: left;">  
				 	  	
				 			<%= invitedlist.get(i)[11]!=null?invitedlist.get(i)[11].toString(): " - "%>  
					 	</td>	
					 	<td style="border: 1px solid black;padding: 5px ;text-align: left">
					 		<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ){ %> Co-Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11]%>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
					 			// Prudhvi - 27/03/2024 start
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CIP") )    {%>Industry Partner<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("IP") )    {%>Addl. Industry Partner<%}
								// Prudhvi - 27/03/2024 end
								else {%> REP_<%=invitedlist.get(i)[3]!=null?invitedlist.get(i)[3].toString(): " - "%><%-- &nbsp; (<%=invitedlist.get(i)[11] %>) --%>  <%}
							%>
				 		</td>	
				 		</tr>
				 <%}
				 } %>
				 
				 <% } %>
				 
				 <%if(memAbscent > 0){ %>
				 	
				  	<tr >
						<th colspan="4" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Following Members Could not Attend due to Prior Commitments</th>
					</tr>
				<% 
				count=0;
				for(int i=0;i<invitedlist.size();i++)
				 {
				 	if(invitedlist.get(i)[4].toString().equals("N")&& membertypes.contains( invitedlist.get(i)[3].toString()) )
				 	{count++; j++; %>
				 	 <tr > 	
				 	  <td style="border: 1px solid black; padding: 5px;text-align: center"> <%=j%> </td>
				 	 <td style="border: 1px solid black ;padding: 5px;text-align: left " >  
				 		<%= invitedlist.get(i)[6]!=null?invitedlist.get(i)[6].toString(): " - "%>,&nbsp;<%=invitedlist.get(i)[7]!=null?invitedlist.get(i)[7].toString(): " - " %>
				 		</td>	
				 		<td style="border: 1px solid black; padding: 5px;text-align: left;">  
				 	  	
				 			<%= invitedlist.get(i)[11]!=null?invitedlist.get(i)[11].toString(): " - "%>  
					 	</td>
				 		<td style="border: 1px solid black ;padding: 5px ;text-align: left "> 
				 			<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ){ %> Co-Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11]%>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
					 			// Prudhvi - 27/03/2024 start
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CIP") )    {%>Industry Partner<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("IP") )    {%>Addl. Industry Partner<%}
								// Prudhvi - 27/03/2024 end
								else {%> REP_<%=invitedlist.get(i)[3]!=null?invitedlist.get(i)[3].toString(): " - "%><%-- &nbsp; (<%=invitedlist.get(i)[11] %>) --%>  <%}
							%>
				 		</td>	
				 	</tr>
				 	
				 <%}
				 } %>
				 
				 <%if(count==0){ %>
				 	<tr><th colspan="4" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Nil</th></tr>
				 <%} %>
				
				<%} %>
				
				 <%if(ParPresent > 0){ %>
				
				 <tr>
					 <th colspan="4" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Other Invitees&nbsp;/&nbsp;Participants </th>
				 </tr>
				 
				 <%
					
				 for(int i=0;i<invitedlist.size();i++)
					{
				 	if(invitedlist.get(i)[4].toString().equals("P") && !membertypes.contains( invitedlist.get(i)[3].toString()) )
				 	{ j++;
				 	addcount++;
				 	%>
				 	
				 	 <tr>
				 	 <td style="border: 1px solid black; padding: 5px;text-align: center"> <%=j%> </td>
				 	  	<td style="border: 1px solid black; padding: 5px;text-align: left">  
				 	  	
				 			<%= invitedlist.get(i)[6]!=null?invitedlist.get(i)[6].toString(): " - "%>,&nbsp;<%=invitedlist.get(i)[7]!=null?invitedlist.get(i)[7].toString(): " - " %>
					 	</td>	
					 	<td style="border: 1px solid black; padding: 5px;text-align: left;">  
				 	  	
				 			<%= invitedlist.get(i)[11]!=null?invitedlist.get(i)[11].toString(): " - "%>  
					 	</td>
					 	<td style="border: 1px solid black;padding: 5px ;text-align: left">
					 		<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ){ %> Co-Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11]%>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
					 			// Prudhvi - 27/03/2024 start
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CIP") )    {%>Industry Partner<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("IP") )    {%>Addl. Industry Partner<%}
								// Prudhvi - 27/03/2024 end
								else {%> REP_<%=invitedlist.get(i)[3]!=null?invitedlist.get(i)[3].toString(): " - "%>&nbsp; (<%=invitedlist.get(i)[11]!=null?invitedlist.get(i)[11].toString(): " - " %>)  <%}
							%>
				 		</td>	
				 		</tr>
				 <%}
				 } %>
				 
				  <%if(addcount==0)
				  {%>
					 	<tr><th colspan="4" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Nil</th> </tr>
				  <%}%>
				  <% } %>
				  
				  <%if(parAbscent > 0){ %>
				  
				 <tr >
						<th colspan="4" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Other Invitees&nbsp;/&nbsp;Participants Absent</th>
					</tr>
				
				 
				 
				<% 
				int count1=0;
				for(int i=0;i<invitedlist.size();i++)	
				 {
				 	if(invitedlist.get(i)[4].toString().equals("N")&& !membertypes.contains( invitedlist.get(i)[3].toString()) )
				 	{count1++; j++; %>
				 	 <tr > 	
				 	  <td style="border: 1px solid black; padding: 5px;text-align: center"> <%=j%> </td>
				 	 <td style="border: 1px solid black ;padding: 5px;text-align: left " >  
				 		<%= invitedlist.get(i)[6]!=null?invitedlist.get(i)[6].toString(): " - "%>,&nbsp;<%=invitedlist.get(i)[7]!=null?invitedlist.get(i)[7].toString(): " - " %>
				 		</td>	
				 		<td style="border: 1px solid black; padding: 5px;text-align: left;">  
				 	  	
				 			<%= invitedlist.get(i)[11]!=null?invitedlist.get(i)[11].toString(): " - "%>  
					 	</td>
				 		
				 		<td style="border: 1px solid black ;padding: 5px ;text-align: left "> 
				 			<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ){ %> Co-Chairperson<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11]%>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External<%-- &nbsp;(<%=invitedlist.get(i)[11] %>) --%><%}
					 			// Prudhvi - 27/03/2024 start
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CIP") )    {%>Industry Partner<%}
								else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("IP") )    {%>Addl. Industry Partner<%}
								// Prudhvi - 27/03/2024 end
								else {%> REP_<%=invitedlist.get(i)[3]!=null?invitedlist.get(i)[3].toString(): " - "%><%-- &nbsp; (<%=invitedlist.get(i)[11] %>) --%>  <%}
							%>
				 		</td>	
				 	</tr>
				 	
				 <%}
				 } %>
				 
				 <%if(count1==0){ %>
				 	<tr><th colspan="4" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Nil</th></tr>
				 <%} %>
				
				
				 <%} %>
			
				  
				 <tr> <td></td>	</tr>
			</table>
			
			</div>
			
			</div>
		<%} %>	
</body>
</html>