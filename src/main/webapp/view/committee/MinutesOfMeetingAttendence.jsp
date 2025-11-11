<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<% 
	Object[] committeescheduleeditdata = (Object[]) request.getAttribute("committeescheduleeditdata");
	Object[] labdetails = (Object[]) request.getAttribute("labdetails");
	List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("committeeinvitedlist");
	String[] no=committeescheduleeditdata[11].toString().split("/");
	int meetingcount= (int) request.getAttribute("meetingcount");
	int count=0;
	int addcount=0;
	Object[] membersec=null; 
%>
<style>
@page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          @top-right {
          		<%-- <%if( Long.parseLong(projectid)>0){%>
             content: "Project:<%=projectdetails[4]!=null?projectdetails[4].toString(): " - "%>";
             <%}else if(Long.parseLong(divisionid)>0){%>
               	content: "Division:<%=divisiondetails[1]!=null?divisiondetails[1].toString(): " - "%>";
             <%}else if(Long.parseLong(initiationid)>0){ %>
             	content: "Pre-Project :<%=initiationdetails[1]!=null?initiationdetails[1].toString(): " - "%>";
             <%} else{%> --%>
             	content: "<%=labdetails[1]!=null?labdetails[1].toString(): " - "%>";
             <%-- <%}%> --%>
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
</style>
</head>
<body>
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
			<table style="margin: 18px; width: 100%; font-size: 16px; border-collapse:collapse;" >	
				
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