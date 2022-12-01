<%@page import="com.vts.pfms.model.TotalDemand"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.Format"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>


<%
	HashMap< String, ArrayList<Object[]>> actionlist = (HashMap< String, ArrayList<Object[]>>) request.getAttribute("actionlist");
	
	
	List<Object[]> speclists = (List<Object[]>) request.getAttribute("committeeminutesspeclist");
	List<Object[]> committeeminutes = (List<Object[]>) request.getAttribute("committeeminutes");
	List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("committeeinvitedlist");
	List<ProjectFinancialDetails> projectFinancialDetails =(List<ProjectFinancialDetails>)request.getAttribute("financialDetails");
	List<Object[]> procurementOnDemand = (List<Object[]>)request.getAttribute("procurementOnDemand");
	List<Object[]> procurementOnSanction = (List<Object[]>)request.getAttribute("procurementOnSanction");
	List<Object[]> ActionPlanSixMonths = (List<Object[]>)request.getAttribute("ActionPlanSixMonths");
	List<Object[]> lastpmrcactions = (List<Object[]>)request.getAttribute("lastpmrcactions");
	List<TotalDemand> totalprocurementdetails = (List<TotalDemand>)request.getAttribute("TotalProcurementDetails");
	List<Object[]> MilestoneDetails6 = (List<Object[]>)request.getAttribute("milestonedatalevel6");
	/* List<Object[]> committeeminutessub = (List<Object[]>) request.getAttribute("committeeminutessub"); */
	/* List<Object[]> agendas = (List<Object[]>) request.getAttribute("CommitteeAgendaList"); */	
	/* List<Object[]> milestonesubsystems  = (List<Object[]>)request.getAttribute("milestonesubsystems"); */


	Object[] committeescheduleeditdata = (Object[]) request.getAttribute("committeescheduleeditdata");
	Object[] labdetails = (Object[]) request.getAttribute("labdetails");
	Object[] projectdetails=(Object[])request.getAttribute("projectdetails");
	Object[] divisiondetails=(Object[])request.getAttribute("divisiondetails");
	Object[] initiationdetails=(Object[])request.getAttribute("initiationdetails");
	LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
	
	
	DecimalFormat df=new DecimalFormat("####################.##");
	int meetingcount= (int) request.getAttribute("meetingcount");
	FormatConverter fc=new FormatConverter(); 
	SimpleDateFormat sdf3=fc.getRegularDateFormat();
	SimpleDateFormat sdf=fc.getRegularDateFormatshort();
	SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
	String isprint=(String)request.getAttribute("isprint"); 
	Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));
	String projectid= committeescheduleeditdata[9].toString();
	String divisionid= committeescheduleeditdata[16].toString();
	String initiationid= committeescheduleeditdata[17].toString();
	String lablogo=(String)request.getAttribute("lablogo");
	/* String committeeid1=committeescheduleeditdata[0].toString(); */
	
	String[] no=committeescheduleeditdata[11].toString().split("/");
	Object[] membersec=null; 
	String levelid= (String) request.getAttribute("levelid");
	
	
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
              font-size: 13px;
          }
          @top-right {
          		<%if( Long.parseLong(projectid)>0){%>
             content: "Project:<%=projectdetails[4]%>";
             <%}else if(Long.parseLong(divisionid)>0){%>
               	content: "Division:<%=divisiondetails[1]%>";
             <%}else if(Long.parseLong(initiationid)>0){ %>
             	content: "Pre-Project :<%=initiationdetails[1]%>";
             <%} else{%>
             	content: "<%=labdetails[1]%>";
             <%}%>
             margin-top: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
          @top-left {
           font-size: 13px;
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=no[0]+"/"+no[1]+"/"+no[2] %><%if(meetingcount>0){ %>#<%=meetingcount %><%} %><%="/"+no[3]%>";
          }            
          
          @top-center { 
           font-size: 13px;
          margin-top: 30px;
          content: "<%=committeescheduleeditdata[15]%>"; 
          
          }
          
 @bottom-center { 
             font-size: 13px;
	          margin-bottom: 30px;
	          content: "<%=committeescheduleeditdata[15]%>"; 
          
          } 
          
          @bottom-left { 
             font-size: 13px;
	          margin-bottom: 30px;
	          content: "<%=LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"))%>"; 
	          
          
          } 
          
         <%--  @bottom-left {          		
        
             content : "The information in this Document is proprietary of <%=labInfo.getLabCode() %> /DRDO , MOD Government of India. Unauthorized possession/use is violating the Government procedure which may be liable for prosecution. ";
        
 			 content : "The information in this Document is proprietary of <%=labInfo.getLabCode() %> /DRDO , MOD Govt. of India. Unauthorized possession may be liable for prosecution.";
 			 margin-bottom: 30px;
             margin-right: 5px;
             font-size: 9.5px;
          } --%>
             

 }

 .sth
 {
 	   font-size: 16px;
 	   border: 1px solid black;
 }
 
 .std
 {
 	
 	border: 1px solid black;
 	padding: 3px 2px 2px 2px; 
 	
 }
 
 .pname
{
	margin: 10px 0px 10px 20px;
}
 
 .completed{
	color: green;
	font-weight: 700;
}

.briefactive{
	color: blue;
	font-weight: 700;
}

.inprogress{
	color: #F66B0E;
	font-weight: 700;
}

.assigned{
	color: brown;
	font-weight: 700;
}

.notyet{
	color: purple;
	font-weight: 700;
}

.notassign{
	color:#AB0072;
	font-weight: 700;
}

.ongoing{
	color: #F66B0E;
	font-weight: 700;
}

.completed{
	color: green;
	font-weight: 700;
}

.delay{
	color: maroon;
	font-weight: 700;
}

.completeddelay{
	color:#BABD42;
	font-weight: 700;
}

.inactive{
	color: red;
	font-weight: 700;
}

 
.executive{
	align-items: center;
} 
 
</style>
<meta charset="ISO-8859-1">
<title><%=committeescheduleeditdata[8]%> Minutes View</title>
</head>
<body>
	<div id="container pageborder" align="center"  class="firstpage" id="firstpage">
	
		  <div class="firstpage" id="firstpage"> 	
			<br>
			<div align="center" ><h1>MINUTES OF MEETING</h1></div>
			<br>
			<div align="center" ><h2 style="margin-bottom: 2px;"><%=committeescheduleeditdata[7].toString().toUpperCase()%>  (<%=committeescheduleeditdata[8].toString().toUpperCase() %><%if(meetingcount>0){ %>&nbsp;&nbsp;#<%=meetingcount %><%} %>) </h2></div>				
				<%if(Integer.parseInt(projectid)>0){ %>					
					<h3 style="margin-top: 5px; margin-bottom: 5px">For</h3>	  
				    <h2 style="margin-top: 3px">Project  : &nbsp;<%=projectdetails[1] %>  (<%=projectdetails[4]%>)</h2>
				<%}else if(Integer.parseInt(divisionid)>0){ %>					
					<h3 style="margin-top: 5px; margin-bottom: 5px">For</h3>	  
			 	   	<h2 style="margin-top: 3px">Division :&nbsp;<%=divisiondetails[2] %>  (<%=divisiondetails[1]%>)</h2>
				<%}else if(Integer.parseInt(initiationid)>0){ %>					
					<h3 style="margin-top: 5px; margin-bottom: 5px">For</h3>	  
				    <h2 style="margin-top: 3px">Pre-Project  : &nbsp;<%=initiationdetails[2] %>  (<%=initiationdetails[1]%>)</h2>
				<%}else{%>
					<br><br><br><br><br>
				<%} %>
				<br>
				<table style="align: center; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px"  border="0">
					<tr style="margin-top: 10px">
						 <th  style="text-align: center; width: 650px;font-size: 20px "> <u>Meeting Id </u> </th></tr><tr>
						 <th  style="text-align: center;  width: 650px;font-size: 20px  "> <%=committeescheduleeditdata[11] %> </th>				
					 </tr>
				</table>
				
				<br><br>
		 <table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px"  border="0">
			 <tr>
				 <th  style="text-align: center; width: 650px;font-size: 20px "> <u> Meeting Date </u></th>
				 <th  style="text-align: center;  width: 650px;font-size: 20px  "><u> Meeting Time </u></th>
			 </tr>
			
			 <tr>
				 <td  style="text-align: center;  width: 650px;font-size: 20px ;padding-top: 5px"> <b><%=sdf3.format(sdf1.parse(committeescheduleeditdata[2].toString()))%></b></td>
				 <td  style="text-align: center;  width: 650px;font-size: 20px ;padding-top: 5px "> <b><%=committeescheduleeditdata[3]%></b></td>
			 </tr>
			 
		 </table>
		 
		 <table style="align: center; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px"  border="0">
					<tr style="margin-top: 10px">
						 <th  style="text-align: center; width: 650px;font-size: 20px "> <u>Meeting Venue</u> </th></tr><tr>
						 <th  style="text-align: center;  width: 650px;font-size: 20px  "> <% if(committeescheduleeditdata[12]!=null){ %><%=committeescheduleeditdata[12] %> <%}else{ %> - <%} %></th>				
					 </tr>
				</table>
		<br><br><br><br><br>
			<figure><img style="width: 4cm; height: 4cm"  src="data:image/png;base64,<%=lablogo%>"></figure>   
						<br><br><br>
			<div align="center" ><h3><%=labdetails[2] %> (<%=labdetails[1]%>)</h3></div>
			
			<div align="center" ><h3><%=labdetails[4] %>, &nbsp;<%=labdetails[5] %>, &nbsp;<%=labdetails[6] %></h3></div>
		</div>  
		
 <h1 class="break"></h1> 
<!-- ------------------------------------------------------- members --------------------------------- -->
<%-- 	<div align="center">
		<table style="align: center; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px">
			<tr style="margin-top: 10px">
				<td  style="text-align: left; width: 650px;font-size: 20px; padding-left: 15px;"> Record/ File no __________dated___________  </td></tr><tr>
				<th  style="text-align: center;  width: 650px;font-size: 20px;padding-top: 10px; ">
					Minutes of  Apex Board/ Executive Board/ PMRC Meeting for Project titled 
				"<span style=" text-decoration: underline;"><%=projectdetails[1] %>  (<%=projectdetails[4]%>)</span>" held on <%=sdf.format(sdf1.parse(committeescheduleeditdata[2].toString()))%> at  <% if(committeescheduleeditdata[12]!=null){ %><%=committeescheduleeditdata[12] %> <%}else{ %> - <%} %>
				</th>				
			</tr>
		</table>
	
	</div> --%>


<%if(invitedlist.size()>0){ %>
<% ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","CW","CO"));
//ArrayList<String> addlmembertypes=new ArrayList<String>(Arrays.asList("W","E","I","P")); %>

<% 
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


<div style="align : center;">
<h2>ATTENDANCE</h2>
<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;" >	
	 <tr>
		 <th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Members Present</th>
	 </tr>
	 
	 <%if(memPresent > 0){ %>
	 
	 <% 
	 	for(int i=0;i<invitedlist.size();i++)
		{
	 	if(invitedlist.get(i)[4].toString().equals("P") && membertypes.contains( invitedlist.get(i)[3].toString()) )
	 	{ j++;%>
	 	
	 	 <tr>
	 	 <td style="border: 1px solid black; padding: 5px;text-align: center"><%=j%> .</td>
	 	  	<td style="border: 1px solid black; padding: 5px;text-align: left">  
	 	  	
	 			<%= invitedlist.get(i)[6]%>,&nbsp;<%=invitedlist.get(i)[7] %>  
		 	</td>	
		 	<td style="border: 1px solid black;padding: 5px ;text-align: left">
		 		<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External&nbsp;(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%>&nbsp; (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 		</tr>
	 <%}
	 } %>
	 
	 <% } %>
	 
	 <%if(memAbscent > 0){ %>
	 	
	  	<tr >
			<th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Members Absent</th>
		</tr>
	
	 
	 
	<% 
	int count=0;
	for(int i=0;i<invitedlist.size();i++)
	 {
	 	if(invitedlist.get(i)[4].toString().equals("N")&& membertypes.contains( invitedlist.get(i)[3].toString()) )
	 	{count++; j++; %>
	 	 <tr > 	
	 	  <td style="border: 1px solid black; padding: 5px;text-align: center"> <%=j%> .</td>
	 	 <td style="border: 1px solid black ;padding: 5px;text-align: left " >  
	 		<%= invitedlist.get(i)[6]%>,&nbsp;<%=invitedlist.get(i)[7] %>
	 		</td>	<td style="border: 1px solid black ;padding: 5px ;text-align: left "> 
	 			<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External&nbsp;(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%>&nbsp; (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 	</tr>
	 	
	 <%}
	 } %>
	 
	 <%if(count==0){ %>
	 	<tr><th colspan="3" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Nil</th></tr>
	 <%} %>
	
	<%} %>
	
	 <%if(ParPresent > 0){ %>
	
	 <tr>
		 <th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Other Invitees&nbsp;/&nbsp;Participants </th>
	 </tr>
	 
	 <%
		
	 for(int i=0;i<invitedlist.size();i++)
		{
	 	if(invitedlist.get(i)[4].toString().equals("P") && !membertypes.contains( invitedlist.get(i)[3].toString()) )
	 	{ j++;
	 	addcount++;
	 	%>
	 	
	 	 <tr>
	 	 <td style="border: 1px solid black; padding: 5px;text-align: center"> <%=j%> .</td>
	 	  	<td style="border: 1px solid black; padding: 5px;text-align: left">  
	 	  	
	 			<%= invitedlist.get(i)[6]%>,&nbsp;<%=invitedlist.get(i)[7] %>
		 	</td>	
		 	<td style="border: 1px solid black;padding: 5px ;text-align: left">
		 		<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External&nbsp;(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%>&nbsp; (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 		</tr>
	 <%}
	 } %>
	 
	  <%if(addcount==0)
	  {%>
		 	<tr><th colspan="3" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Nil</th> </tr>
	  <%}%>
	  <% } %>
	  
	  <%if(parAbscent > 0){ %>
	  
	 <tr >
			<th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Other Invitees&nbsp;/&nbsp;Participants Absent</th>
		</tr>
	
	 
	 
	<% 
	int count1=0;
	for(int i=0;i<invitedlist.size();i++)	
	 {
	 	if(invitedlist.get(i)[4].toString().equals("N")&& !membertypes.contains( invitedlist.get(i)[3].toString()) )
	 	{count1++; j++; %>
	 	 <tr > 	
	 	  <td style="border: 1px solid black; padding: 5px;text-align: center"> <%=j%> .</td>
	 	 <td style="border: 1px solid black ;padding: 5px;text-align: left " >  
	 		<%= invitedlist.get(i)[6]%>,&nbsp;<%=invitedlist.get(i)[7] %>
	 		</td>	<td style="border: 1px solid black ;padding: 5px ;text-align: left "> 
	 			<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){ membersec=invitedlist.get(i); %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary&nbsp;(Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External&nbsp;(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External&nbsp;(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%>&nbsp; (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 	</tr>
	 	
	 <%}
	 } %>
	 
	 <%if(count1==0){ %>
	 	<tr><th colspan="3" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Nil</th></tr>
	 <%} %>
	
	
	 <%} %>

	  
	 <tr> <td></td>	</tr>
</table>



</div>
<%} %>
	


 <h1 class="break" ></h1> 
 
<!-- -------------------------------------------------------members----------------------------- -->
		<% for (Object[] committeemin : committeeminutes) { %>
		<% if (committeemin[0].toString().equals("1") ) { %>
		
		<table style="margin-top: 0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
			<tbody>
				<tr>
					<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
				</tr>
				<tr>
						<%
							int count = 0;

						for (Object[] speclist : speclists)
						{
							if (speclist[3].toString().equals(committeemin[0].toString())) 
							{
								count++;
						%>
					
					<td style="text-align: left;">
					<div align="left" style="padding-left: 30px"><%=speclist[1]%></div>
					</td>

					<%	break;		
							}
						}
						if (count == 0) 
						{%>
							<td style="text-align: left;">
								<div align="left" style="padding-left: 30px">
									<p>NIL<p>
								</div>
							</td>

						<%
							}
						%>

				
				</tr>
				</table>
				
			<% }else if (committeemin[0].toString().equals("2")) { %>
		
		<table style="margin-top: 0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
			<tbody>
				<tr>
					<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
				</tr>
				<tr>
						<%
							int count = 0;

						for (Object[] speclist : speclists)
						{
							if (speclist[3].toString().equals(committeemin[0].toString())) 
							{
								count++;
						%>
					
					<td style="text-align: left;">
					<div align="left" style="padding-left: 30px"><%=speclist[1]%></div>
					</td>

					<%	break;		
							}
						}
						if (count == 0) 
						{%>
							<td style="text-align: left;">
								<div align="left" style="padding-left: 30px">
									<p>NIL<p>
								</div>
							</td>

						<%
							}
						%>

				
				</tr>
				</table>
				
												
					<br>
					<table style="margin-top: 0px; margin-left: 5px;width: 650px; font-size: 16px; border-collapse: collapse ;border: 1px solid black ">
					<tbody>
						<tr>
							<th  class="sth" style="text-align :center !important; max-width: 30px"> SN</th>
							<th  class="sth" style="text-align :center !important; max-width: 35px"> Type</th>
							<th  class="sth" style=" max-width: 600px"> Item</th>				
							<th  class="sth" style="width: 195px"> Remarks</th>	
						</tr>
						
							<% int countcm=0;
							long tempagenda=0;
							for(int i=0;i<speclists.size();i++)
							{ 
								if(Integer.parseInt(speclists.get(i)[3].toString())==3||Integer.parseInt(speclists.get(i)[3].toString())==5){
								countcm++;
								
								%>
								
								<% if(tempagenda!=Long.parseLong(speclists.get(i)[6].toString())){%>
								<tr>
									<td class="std" style="text-align :center;border:1px solid black;"  colspan="4"><%=speclists.get(i)[10]%></td>
								</tr>
							<%tempagenda=Long.parseLong(speclists.get(i)[6].toString());
							} %>
							<tr>
								<td class="std" style="text-align :center !important;border:1px solid black;vertical-align: top;"  ><p  style="text-align :center !important; "> <%=countcm%> </p></td>
								<td class="std" style="text-align :center !important;border:1px solid black; padding: 5px 5px 5px 5px ; vertical-align: top;" >							
								<p  style="text-align :center !important; ">	<%=speclists.get(i)[7]%> 
								</p> 				
								</td>
								<td  class="std" style="border:1px solid black;padding:  5px 5px 5px 5px ;width: 600px;text-align: justify;"><%=speclists.get(i)[1]%></td>
								<td class="std" style="text-align :center;border:1px solid black;padding:  5px 5px 5px 5px;"  > <%if( speclists.get(i)[8]!=null && !speclists.get(i)[8].toString().equalsIgnoreCase("nil")){ %> <%= speclists.get(i)[8]%> <%}else{ %> - <%} %></td>
							</tr>
							<%} 
							}%>
							<% if(countcm==0){%>
								<tr>
									<td class="std" style="text-align :center;border:1px solid black;"  colspan="4">No Minutes details Added</td>
								</tr>
							<%} %>
						</table>	
				
				<%  }else if (committeemin[0].toString().equals("3")) { %>
						 <h1 class="break"></h1> 
						  <div align="center"><p style="font-size: 14px;text-align: center"> <span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; <span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;  <span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; <span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; <span class="inactive">IA</span> : InActive </div>
						  <div align="center"><p style="font-size: 14px;text-align: center"> <span class="ongoing">OG</span> : On Going &nbsp;&nbsp; <span class="completed">CO</span> : Completed &nbsp;&nbsp; <span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp; <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; <span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; </div>
						 
							<table style="margin-top: 0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
								<tr>
									<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
								</tr>
							</table>	
   				
							<table style=" margin-left: 25px; width: 650px; font-size: 16px; border-collapse: collapse;border: 1px solid black" >
								<tr>
									<th class="std"  style="max-width: 30px;"  >SN</th>
									<th class="std"  style="max-width: 215px;" >Action Point</th>
									<th class="std"  style="max-width: 80px;min-width:80px; "  > PDC</th>
									<th class="std"  style="max-width: 115px;" > Item Code</th>
									<th class="std"  style="max-width: 100px;" > Responsible agency/ Person</th>
									<th class="std"  style="max-width: 70px;"  >Status/ Remarks</th>			
								</tr>
													
								<%if(lastpmrcactions.size()==0){ %>
									<tr><td class="std"  colspan="6" > No Data</td></tr>
								<%}
								else if(lastpmrcactions.size()>0)
								{
									int i=1;
									for(Object[] obj:lastpmrcactions){ %>
										<tr>
											<td class="std"  align="center"><%=i %></td>
											<td class="std" style="text-align: justify;"><%=obj[2] %></td>
											<td class="std" align="center">
												<%if(obj[4]!= null){ %>  
													<%=sdf.format(sdf1.parse(obj[6+(Integer)obj[9] ].toString()))%>												
												<%}else { %>
													-
												<%} %>											
											</td>
											<td class="std" align="center" > 
												<%if(obj[3].toString().equals("A") ){ %>		 A
												<%}else if(obj[3].toString().equals("I") ){  %>  I
												<%}else if(obj[3].toString().equals("R") ){  %>  R
												<%}else if(obj[3].toString().equals("D") ){ %>   D
												<%}else if(obj[3].toString().equals("C") ){  %>  C
												<%}else if(obj[3].toString().equals("K") ){  %>  K
												<%} %>  
											</td> 
											<td class="std" >
												<%if(obj[4]!= null){ %>  
													<%=obj[12] %>  (<%=obj[13] %>)
												<%}else { %><span class="notassign">NA</span><%} %> 
											</td>
											<td class="std"  align="center"> 
											<%if(obj[4]!= null){if(obj[18]!=null && Integer.parseInt(obj[18].toString())>0){ %>
											
												<%if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&(sdf.parse(obj[17].toString()).after(sdf.parse(obj[14].toString()))||obj[17].equals(obj[14]) )){ %>
													<span class="ongoing">UF</span>
												<%}else if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&sdf.parse(obj[17].toString()).before(sdf.parse(obj[14].toString()))){  %>
													<span class="delay">FD</span>
												<%}else if(obj[10].toString().equals("C")&&(sdf.parse(obj[17].toString()).after(sdf.parse(obj[14].toString()))||obj[17].equals(obj[14]))){  %>
													<span class="completed">CO</span>
												<%}else if(obj[10].toString().equals("C")&&sdf.parse(obj[17].toString()).before(sdf.parse(obj[14].toString()))){  %>
												   <span class="completeddelay">CD</span>
												<%}else if(!obj[16].toString().equals("F")&&obj[10].toString().equals("I")&&(sdf.parse(obj[17].toString()).after(sdf.parse(obj[14].toString()))||obj[17].equals(obj[14]))){  %> 
													<span class="ongoing">OG</span>
												<%}else if(!obj[16].toString().equals("F")&&obj[10].toString().equals("I")&&sdf.parse(obj[17].toString()).before(sdf.parse(obj[14].toString()))){  %> 
													<span class="delay">DO</span>
												<%}else{ %>
													<span class="ongoing">OG</span>
												<%} 
												}else if(obj[18]!=null && obj[10]!=null && obj[10].toString().equals("C") && Integer.parseInt(obj[18].toString())>0){ %>
											        <span class="completed">CO</span>
											      <% }else{ %><span class="notyet">NS</span> 
												<%}}else { %> <span class="notassign">NA</span> <%} %> 
											</td>				
										</tr>			
									<%i++;
									}} %>
							</table>
				
			<%}else if(committeemin[0].toString().equals("4") ){%>
				
					<table style="margin-top: -15px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
						<tr>
							<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
						</tr>
					</table>	
					<table style="margin-top: 00px; margin-bottom: 0px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse: collapse;border: 1px solid black" >
						           <tr>
										<!--  <th class="std"  style="width: 30px !important; ">SN</th>
										 <th class="std" style="max-width: 100px; ">Mile- stone</th>
										 <th class="std" style="max-width: 150px; ">System/ Subsystem/ Activities</th>
										 <th class="std" style="max-width: 110px; "> Original PDC</th>
										 <th class="std" style="max-width: 110px; "> Revised PDC</th>
										 <th class="std" style="max-width: 100px; "> Progress</th>
										 <th class="std" style="max-width: 70px; "> Present Status</th>
										 <th class="std" style="max-width: 100px; "> Remarks</th> -->
										 
										 
										 <th class="std"  style="width: 30px !important; ">MS</th>
										 <th class="std"  style="width: 30px !important; ">L</th>
										 <th class="std" style="max-width: 150px; ">System/ Subsystem/ Activities</th>
										 <th class="std" style="max-width: 110px; "> Original PDC</th>
										 <th class="std" style="max-width: 110px; "> Revised PDC</th>
										 <th class="std" style="max-width: 100px; "> Progress</th>
										 <th class="std" style="max-width: 70px; "> Present Status</th>
										 <th class="std" style="max-width: 100px; "> Remarks</th> 
										 
									</tr>
										
						<!-- Old Code Before 14-09-2022 -->				
															
						<%-- <%if(milestonesubsystems.size()==0){ %>
							<tr><td class="std" colspan="5" style="text-align: center;" > No SubSystems</td></tr>
						<%}else if(milestonesubsystems.size()>0)
						{int i=1;
						    int count=0;
						    String id=null;
							for(Object[] obj:milestonesubsystems){ 
								if(i==1){
									id=obj[8].toString();
								}
								if(obj[8].toString().equalsIgnoreCase(id)){
									count++;
								}else{
									id=obj[8].toString();
									count=1;
								}
							%>
							<tr>
											<td class="std"  style="max-width: 50px;text-align: center;"><%=i%></td>
											<td class="std"  style="max-width: 100px;text-align: center;"> M<%=obj[8]%>. <%=count %></td>
											<td class="std"  style="max-width: 150px;text-align: left;"><%=obj[2] %> </td>											
											<td class="std"  style="max-width: 110px;text-align: center;"> <%= sdf.format(sdf1.parse(obj[3].toString()))%> </td>
											<td class="std"  style="max-width: 110px;text-align: center;"><%= sdf.format(sdf1.parse(obj[4].toString()))%></td>
											<td class="std"  style="max-width: 100px;text-align: center;"><%=obj[7] %> %</td>
											<td class="std"  style="max-width: 70px;text-align: center;">
											<span class="<%if(obj[5].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[5].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[5].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[5].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[5].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[5].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[5].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[6] %>	
											</span>
											
											</td>
											<td class="std"  style="max-width: 100px;text-align: left;"><%if(obj[9]!=null&&!obj[9].toString().equals("null")){%><%=obj[9] %><%} %></td>
										</tr>
									<%i++;}} %> --%>
									
							<!-- New code by tharun  -->		
									
									<% if(MilestoneDetails6 !=null){ if( MilestoneDetails6.size()>0){ 
									long milcount1=1;
									int milcountA=1;
									int milcountB=1;
									int milcountC=1;
									int milcountD=1;
									int milcountE=1;%>
									<%for(Object[] obj:MilestoneDetails6){
										
										if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(levelid) ){
										%>
										<tr>
											<td class="std"  style="max-width: 50px;text-align: center;">M<%=obj[0] %></td>
											<td class="std"  style="max-width: 50px;text-align: center;" >
												<%
												
												if(obj[21].toString().equals("0")) {%>
													L
												<%	milcountA=1;
													milcountB=1;
													milcountC=1;
													milcountD=1;
													milcountE=1;
												}else if(obj[21].toString().equals("1")) { %>
													A-<%=milcountA %>
												<% milcountA++;
													milcountB=1;
													milcountC=1;
													milcountD=1;
													milcountE=1;
												}else if(obj[21].toString().equals("2")) { %>
													B-<%=milcountB %>
												<%milcountB+=1;
												milcountC=1;
												milcountD=1;
												milcountE=1;
												}else if(obj[21].toString().equals("3")) { %>
													C-<%=milcountC %>
												<%milcountC+=1;
												milcountD=1;
												milcountE=1;
												}else if(obj[21].toString().equals("4")) { %>
													D-<%=milcountD %>
												<%
												milcountD+=1;
												milcountE=1;
												}else if(obj[21].toString().equals("5")) { %>
													E-<%=milcountE %>
												<%milcountE++;
												} %>
											</td>

											<td class="std"  style="max-width: 150px;text-align: left; <%if(obj[21].toString().equals("0")) {%>font-weight: bold;<%}%>">
												<%if(obj[21].toString().equals("0")) {%>
													<%=obj[10] %>
												<%}else if(obj[21].toString().equals("1")) { %>
													&nbsp;&nbsp;<%=obj[11] %>
												<%}else if(obj[21].toString().equals("2")) { %>
													&nbsp;&nbsp;<%=obj[12] %>
												<%}else if(obj[21].toString().equals("3")) { %>
													&nbsp;&nbsp;<%=obj[13] %>
												<%}else if(obj[21].toString().equals("4")) { %>
													&nbsp;&nbsp;<%=obj[14] %>
												<%}else if(obj[21].toString().equals("5")) { %>
													&nbsp;&nbsp;<%=obj[15] %>
												<%} %>
											</td>
											<td class="std"  style="max-width: 110px;text-align: center;"><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td class="std"  style="max-width: 110px;text-align: center;"><%=sdf.format(sdf1.parse(obj[9].toString())) %></td>
											<td class="std"  style="max-width: 100px;text-align: center;"><%=obj[17] %>%</td>											
											<td class="std"  style="max-width: 70px;text-align: center;">
											<span class="<%if(obj[19].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[19].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[19].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[19].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[19].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[19].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[19].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[22] %>	
											</span>
											
											</td>
											<td class="std"  style="max-width: 100px;text-align: left;"><%if(obj[23]!=null){%><%=obj[23]%><%} %></td>
										</tr>
									<%milcount1++;}} %>
								<%} else{ %>
								<tr><td class="std" colspan="5" style="text-align: center;" > No SubSystems</td></tr>
								<%}}else{ %>
									<tr><td class="std" colspan="5" style="text-align: center;" > No SubSystems</td></tr>
								<%} %>
									
			
								<!-- New code by tharun end -->	
									

								
					</table>
				 <h1 class="break"></h1> 
				
			<%}else if (committeemin[0].toString().equals("5") ){%>
			
					<table style="margin-top: 0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
						<tr>
							<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
						</tr>
					</table>	
					<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px;  border-collapse:collapse;" >
										<thead>
										 <tr>
										 	<th class="std" colspan="8" >Demand Details</th>
											 </tr>
										</thead>
										
										<tr>
											<th class="std" style="width: 30px !important;">SN</th>
											<th class="std" style="max-width: 90px;">Demand No</th>
											<th class="std" style="max-width: 90px; ">Demand Date</th>
											<th class="std" colspan="2" style="max-width: 150px;"> Nomenclature</th>
											<th class="std" style="max-width: 90px;"> Est. Cost-Lakh &#8377;</th>
											<th class="std" style="max-width: 80px; "> Status</th>
											<th class="std" style="max-width: 200px;">Remarks</th>
										</tr>
										    <% int k=0;
										    if(procurementOnDemand!=null &&  procurementOnDemand.size()>0){
										    Double estcost=0.0;
										    Double socost=0.0;
										    for(Object[] obj : procurementOnDemand){ 
										    	k++; %>
											<tr>
												<td class="std" ><%=k%></td>
												<td class="std" ><%=obj[1]%></td>
												<td class="std" ><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
												<td class="std" colspan="2" ><%=obj[8]%></td>
												<td class="std" style=" text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
												<td class="std" > <%=obj[10]%> </td>
												<td class="std" ><%=obj[11]%> </td>		
											</tr>		
											<%
											estcost += Double.parseDouble(obj[5].toString());
										    }%>
										    
										    <tr>
										    	<td class="std" colspan="5" style="text-align: right;"><b>Total</b></td>
										    	<td class="std" style="text-align: right;"><b><%=df.format(estcost)%></b></td>
										    	
										    	<td class="std" colspan="2" style="text-align: right;"></td>

										    </tr>
										    
										    
										    <% }else{%>											
												<tr><td colspan="8" class="std" style="text-align: center;">Nil </td></tr>
											<%} %>
											 <tr >
												 <th  class="std"  colspan="8">Order Placed</th>
											 </tr>
										
										  	 	<tr>	
										  	 	 <th class="std" rowspan="2" style="width: 30px !important;">SN</th>
										  	 	 <th class="std">Demand No </th>
										  	 	  <th class="std" >Demand  Date</th>
												 <th class="std" colspan="2"> Nomenclature</th>
												 <th class="std" > Est. Cost-Lakh &#8377;</th>
												 <th class="std" style="max-width: 80px; "> Status</th>
												 <th class="std" style="max-width: 200px;">Remarks</th>
												</tr>
											<tr>
												
												 <th class="std"  style="max-width: 150px;">Supply Order No</th>
												 <th class="std" style="max-width: 90px;	">DP Date</th>
												 <th class="std" colspan="2" style="max-width: 90px;	">Vendor Name</th>
												 <th class="std" style="max-width: 80px;">Rev DP Date</th>											 
												 <th  class="std" colspan="3" style="max-width: 90px;">SO Cost-Lakh &#8377;</th>		
											 		
											</tr>
										    <%if(procurementOnSanction!=null && procurementOnSanction.size()>0){
										    	k=0;
										    	 Double estcost=0.0;
												 Double socost=0.0;
												 String demand="";
										  	 	for(Object[] obj:procurementOnSanction)
										  	 	{ 
										  	 		if(obj[2]!=null){ 
										  	 		if(!obj[1].toString().equals(demand)){
										  	 			k++;
										  	 		%>
										  	 

												<tr>
													<td class="std" rowspan="2" ><%=k%></td>
													<td class="std" ><%=obj[1]%> </td>
													<td class="std"><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
													<td class="std"  colspan="2"><%=obj[8]%></td>
													<td class="std" style=" text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
												    <td  class="std"> <%=obj[10]%> </td>
													<td  class="std"><%=obj[11]%> </td>	
												</tr>
												<%demand=obj[1].toString();
												} %>
												<tr>
													
													<td class="std" ><% if(obj[2]!=null){%> <%=obj[2]%> <%}else{ %>-<%} %>
													</td>
													<td class="std" ><%if(obj[4]!=null){%> <%=sdf.format(sdf1.parse(obj[4].toString()))%> <%}else{ %> - <%} %></td>
													<td class="std" colspan="2"> <%=obj[12] %>
													</td>
													<td  class="std"><%if(obj[7]!=null){if(!obj[7].toString().equals("null")){%> <%=sdf.format(sdf1.parse(obj[7].toString()))%><%}}else{ %>-<%} %></td>
				                                    <td  class="std" colspan="3" style=" text-align: right;"><%if(obj[6]!=null){%> <%=format.format(new BigDecimal(obj[6].toString())).substring(1)%> <%} else{ %> - <%} %></td>												
				
												</tr>		
												<% }
										  	 		
										  	 		Double value = 0.00;
										  	 		if(obj[6]!=null){
										  	 			value=Double.parseDouble(obj[6].toString());
										  	 		}
										  	 		
										  	 		estcost += Double.parseDouble(obj[5].toString());
										  	 		socost +=  value;
										  	 		
										  	 	 } 
										   	%>
										   	 
										    <tr>
										    	<td colspan="6" class="std" style="text-align: right;"><b>Total</b></td>
										    	<td colspan="2" class="std" style="text-align: right;"><b><%=df.format(socost)%></b></td>
										    	
										    </tr>
										     <% }else{%>
											
												<tr><td colspan="8" class="std"  style="text-align: center;">Nil </td></tr>
											<%} %>
									</table> 
									
									<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px;  border-collapse:collapse;" >
									       <tr >
												 <th class="std" style="max-width: 150px;">Total No. of Demand</th>
												 <th class="std" style="max-width: 150px;">Total Est. Cost-Lakh &#8377;</th>
										  	 	 <th class="std" style="max-width: 150px;">Total No. of Orders</th>
										  	 	 <th class="std" style="max-width: 150px;">Total So Cost-Lakh &#8377; </th>
										  	 	 <th class="std" style="max-width: 150px;">Total Expenditure-Lakh &#8377; </th>
											 </tr>
									<%if(totalprocurementdetails!=null && totalprocurementdetails.size()>0){ 
										 for(TotalDemand obj:totalprocurementdetails){
											 if(obj.getProjectId().equalsIgnoreCase(projectid)){
										 %>
										   <tr>
										      <td class="std" style="text-align: center;"><%=obj.getDemandCount() %></td>
										      <td class="std" style="text-align: center;"><%=obj.getEstimatedCost() %></td>
										      <td class="std" style="text-align: center;"><%=obj.getSupplyOrderCount()%></td>
										      <td class="std" style="text-align: center;"><%=obj.getTotalOrderCost() %></td>
										      <td class="std" style="text-align: center;"><%=obj.getTotalExpenditure()%></td>
										   </tr>
										   <%}}}else{%>
										   <tr>
										      <td class="std" colspan="5" style="text-align: center;">IBAS Server Could Not Be Connected</td>
										   </tr>
										   <%} %>
									</table>
									
					 <h1 class="break"></h1> 
			<%}else if (committeemin[0].toString().equals("6") ) 
			{ %>
			
					<table style="margin-top: 0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
						<tr>
							<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
						</tr>
						<tr>
							<td align="right">(Amount in Crores)</td>
						</tr>
					</table>	
					<%if(Long.parseLong(projectid) >0 && projectFinancialDetails!=null) { %>
							
								<table style="margin-top: 5px; margin-bottom: 0px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse: collapse;border: 1px solid black" >
								    <thead>
								        <tr>
								           	<td class="std" colspan="2" align="center"><b>Head</b></td>
								           	<td class="std" colspan="2" align="center"><b>Sanction</b></td>
									        <td class="std" colspan="2" align="center"><b>Expenditure</b></td>
									        <td class="std" colspan="2" align="center"><b>Out Commitment</b> </td>
								            <td class="std" colspan="2" align="center"><b>Balance</b></td>
									        <td class="std" colspan="2" align="center"><b>DIPL</b></td>
								            <td class="std" colspan="2" align="center"><b>Notional Balance</b></td>
								        </tr>
									    <tr>
											<th class="std" >SN</th>
										    <th  class="std" >Head</th>
										    <th class="std" >RE</th>
										    <th class="std" >FE</th>
										    <th class="std" >RE</th>
										    <th class="std" >FE</th>
									        <th class="std" >RE</th>
									        <th class="std" >FE</th>
								            <th class="std" >RE</th>
										    <th class="std" >FE</th>
										    <th class="std" >RE</th>
										    <th class="std" >FE</th>
										    <th class="std" >RE</th>
										    <th class="std" >FE</th>
								        </tr>
									</thead>
									<tbody>
									<% 
								    double totSanctionCost=0,totReSanctionCost=0,totFESanctionCost=0;
									double totExpenditure=0,totREExpenditure=0,totFEExpenditure=0;
									double totCommitment=0,totRECommitment=0,totFECommitment=0,totalDIPL=0,totalREDIPL=0,totalFEDIPL=0;
									double totBalance=0,totReBalance=0,totFeBalance=0,btotalRe=0,btotalFe=0;
									int count=1;
									if(projectFinancialDetails!=null){
										for(ProjectFinancialDetails projectFinancialDetail:projectFinancialDetails){    %>
									 
									    	<tr>
												<td class="std"  align="center"><%=count++ %></td>
												<td class="std"  style="text-align: left;"><%=projectFinancialDetail.getBudgetHeadDescription()%></td>
												<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction()) %></td>
												<%totReSanctionCost+=(projectFinancialDetail.getReSanction());%>
													<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
												<%totFESanctionCost+=(projectFinancialDetail.getFeSanction());%>
													<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure()) %></td>
												<%totREExpenditure+=(projectFinancialDetail.getReExpenditure());%>
												    <td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
												<%totFEExpenditure+=(projectFinancialDetail.getFeExpenditure());%>
												    <td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
												<%totRECommitment+=(projectFinancialDetail.getReOutCommitment());%>
												    <td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeOutCommitment())%></td>
												<%totFECommitment+=(projectFinancialDetail.getFeOutCommitment());%>
													<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl())%></td>
												<%btotalRe+=(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl());%>
													<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl())%></td>
												<%btotalFe+=(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl());%>
													 <td class="std"  align="right"style="text-align: right;"><%=df.format(projectFinancialDetail.getReDipl())%></td>
												<%totalREDIPL+=(projectFinancialDetail.getReDipl());%>
													 <td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeDipl())%></td>
												<%totalFEDIPL+=(projectFinancialDetail.getFeDipl());%>
													<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance())%></td>
												<%totReBalance+=(projectFinancialDetail.getReBalance());%>
													<td class="std"  align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance())%></td>
												<%totFeBalance+=(projectFinancialDetail.getFeBalance());%>
											</tr>
										<%} }%>
																
											<tr>
												<td class="std"  colspan="2"><b>Total</b></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totReSanctionCost)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totFESanctionCost)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totREExpenditure)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totFEExpenditure)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totRECommitment)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totFECommitment)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(btotalRe)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(btotalFe)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totalREDIPL)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totalFEDIPL)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totReBalance)%></td>
												<td class="std"  align="right" style="text-align: right;font-weight: bold;"><%=df.format(totFeBalance)%></td>
											</tr>
											<tr>
												<td class="std"  colspan="2"><b>GrandTotal</b></td>
												<td class="std"  colspan="2"  style="text-align: right;font-weight: bold;"><%=df.format(totReSanctionCost+totFESanctionCost)%></td>
												<td class="std"  colspan="2"  style="text-align: right;font-weight: bold;"><%=df.format(totREExpenditure+totFEExpenditure)%></td>
												<td class="std"  colspan="2"  style="text-align: right;font-weight: bold;"><%=df.format(totRECommitment+totFECommitment)%></td>
												<td class="std"  colspan="2"  style="text-align: right;font-weight: bold;"><%=df.format(btotalRe+btotalFe)%></td>
												<td class="std"  colspan="2"  style="text-align: right;font-weight: bold;"><%=df.format(totalREDIPL+totalFEDIPL)%></td>
												<td class="std"  colspan="2"  style="text-align: right;font-weight: bold;"><%=df.format(totReBalance+totFeBalance)%></td>
											</tr>
										</tbody>        
									</table>
														
							
					<% }else {  %>
						
						<table style="margin-top: -0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;padding-left: 30px;"><br> Data Unavailable</th>
							</tr>
						</table>		
							
					<% } %>
				
				
		<%}else if (committeemin[0].toString().equals("7") )
		{ %>
			
					<table style="margin-top: 0px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse: collapse;">
						<tr>
							<th colspan="8" style="text-align: left; font-weight: 700; text-align: justify;padding-left: 15px;" ><br><%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
						</tr>
					</table>	
								<table style="margin-top: 5px; margin-bottom: 0px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse: collapse;border: 1px solid black" >
								<tr>
									<th class="std"  style="width: 30px !important;">SN</th>
									<th class="std"  style="width: 30px; ">MS</th>
									<th class="std"  style="width: 40px; ">L</th>
									<th class="std"  style="max-width: 220px;">Action Plan </th>	
									<th class="std"  style="max-width: 80px;">Responsible Agency/ Person </th>
									<th class="std"  style="max-width: 85px;">PDC</th>	
									<th class="std"  style="max-width: 60px;">Progress </th>
					                <th class="std"  style="max-width: 50px;">Status</th>
					                 <th class="std"  style="max-width: 80px;">Remarks</th>
								</tr>
								<%if(ActionPlanSixMonths.size()>0){ 
									long count1=1;
									int countA=1;
									int countB=1;
									int countC=1;
									int countD=1;
									int countE=1;
									%>
									<%for(Object[] obj:ActionPlanSixMonths){
										
										if(Integer.parseInt(obj[26].toString())<= Integer.parseInt(levelid) ){
										/*  if(obj[26].toString().equals("0")||obj[26].toString().equals("1")){ */
										%>
										<tr>
											<td class="std"  style="text-align: center"><%=count1 %></td>
											<%-- <td>M <%=obj[22] %> <% if(!obj[26].toString().equals("0")) {%> L<%=obj[26] %> <%} %></td> --%>
											<td class="std"  style="text-align: center">M<%=obj[22] %></td>
											
											<!-- Old Code -->
											<%-- <td><% if(!obj[26].toString().equals("0")) {%> L<%=obj[26] %> <%} else {%> L <%} %></td>
											<td>
												<%if(!obj[10].toString().trim().equals("")){ %>
													<%=obj[10] %>
												<%}else if(!obj[9].toString().trim().equals("")){ %>
													<%=obj[9] %>
												<%}else if(!obj[8].toString().trim().equals("")){ %>
													<%=obj[8] %>
												<%}else if(!obj[7].toString().trim().equals("")){ %>
													<%=obj[7] %>
												<%} %>
											</td> --%>
											
											<!-- New Code (tharun)-->
											
											<td class="std"  style="text-align: center">
												<%
												
												if(obj[26].toString().equals("0")) {%>
													L
												<%countA=1;
													countB=1;
													countC=1;
													countD=1;
													countE=1;
												}else if(obj[26].toString().equals("1")) { %>
													A-<%=countA %>
												<% countA++;
												    countB=1;
												    countC=1;
													countD=1;
													countE=1;
												}else if(obj[26].toString().equals("2")) { %>
													B-<%=countB %>
												<%countB+=1;
												countC=1;
												countD=1;
												countE=1;
												}else if(obj[26].toString().equals("3")) { %>
													C-<%=countC %>
												<%countC+=1;
												countD=1;
												countE=1;
												}else if(obj[26].toString().equals("4")) { %>
													D-<%=countD %>
												<%
												countD+=1;
												countE=1;
												}else if(obj[26].toString().equals("5")) { %>
													E-<%=countE %>
												<%countE++;
												} %>
											</td>
											
											
											
											<td class="std" style="<%if(obj[26].toString().equals("0")) {%>font-weight: bold;<%}%> text-align:left" >
												<%if(obj[26].toString().equals("0")) {%>
													<%=obj[9] %>
												<%}else if(obj[26].toString().equals("1")) { %>
													&nbsp;&nbsp;<%=obj[10] %>
												<%}else if(obj[26].toString().equals("2")) { %>
													&nbsp;&nbsp;<%=obj[11] %>
												<%}else if(obj[26].toString().equals("3")) { %>
													&nbsp;&nbsp;<%=obj[12] %>
												<%}else if(obj[26].toString().equals("4")) { %>
													&nbsp;&nbsp;<%=obj[13] %>
												<%}else if(obj[26].toString().equals("5")) { %>
													&nbsp;&nbsp;<%=obj[14] %>
												<%} %>
											</td>
											<td class="std" ><%=obj[24] %>(<%=obj[25] %>)</td>
											<td class="std" ><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td class="std"  style="text-align: center"><%=obj[16] %>%</td>											
											<td class="std"  style="text-align: center">
											<span class="<%if(obj[20].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[20].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[20].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[20].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[20].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[20].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[20].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[27] %>	
											</span>
											
											</td>
											<td  class="std"  style="max-width: 80px;">
												<%if(obj[28]!=null){ %>
												<%=obj[28] %>
												<%} %>
												</td>
										</tr>
									<%count1++;}} %>
								<%} else{ %>
								<tr><td class="std"  colspan="9" style="text-align:center; "> Nil</td></tr>
								
								
								<%} %>
									
								</table>
							 <h1 class="break"></h1> 
				
		<%} else if (committeemin[0].toString().equals("8") || committeemin[0].toString().equals("9") || committeemin[0].toString().equals("10"))
		{%>
			
			
				<table style="margin-top:0px; margin-left: 0px; width: 650px; font-size: 16px; border-collapse: collapse;">
					<tbody>
						<tr>
							<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
						</tr>
				
						<%
						int count = 0;
						
						for (Object[] speclist : speclists)
						{ %>						
							 	
								<%if(speclist[3].toString().equals("4") && committeemin[0].toString().equals("8") )
								{  
									count++; %>	
									<tr>
										<td style="text-align: justify;padding-left: 30px"> 
											<%=speclist[1]%> 
										</td>		
									</tr>			
								<%}else if(speclist[3].toString().equals("5") && committeemin[0].toString().equals("9"))
								{ 
									count++; %>
									<tr>
										<th colspan="8" style="text-align: left; font-weight: 700;"><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=committeemin[0]+"."+count%>.&nbsp;&nbsp;&nbsp;<%=speclist[9]%></th>
									</tr>
									<tr>
										<td style="text-align: justify;padding-left: 30px">
											<%=speclist[1]%> 
										</td>
									</tr	>
								<%}else if(speclist[3].toString().equals("6") && committeemin[0].toString().equals("10")) 
								{
									count++;%>
									<tr>
										<td style="text-align: justify;padding-left: 30px">
											<%=speclist[1]%> 
										</td>	
									</tr>					
								<%}
												
							
						}if (count == 0)
						{%>
						<tr style="page-break-after: ;">
						<td style="text-align: left;"><div style="padding-left: 50px"><p>NIL</p></div>
						</td>	
						</tr>								
						<%}%>
							
				
				
				</table>
		
			
			
			
			
		<%}
	}%>
	
		<div style="width: 650px;margin-left: 15px; ">
			<div align="center" style="padding-left: 2.5rem;">
				<p>These Minutes are issued with the approval of The Chairperson <%-- <%=committeescheduleeditdata[8] %> --%>. </p>
			</div>
			<div align="left" style="padding-right: 0rem;padding-bottom: 0rem; margin-right: 0px">
				<br>Date :&emsp;&emsp;&emsp;&emsp;&emsp;  <br>Time :&emsp;&emsp;&emsp;&emsp;&emsp;
				<%if(membersec!=null){ %>
				
			<div align="right" style="padding-right: 0rem;padding-bottom: 2rem;">
			
				<br><%if(membersec!=null){%><%= membersec[6].toString().substring(membersec[6].toString().indexOf(".")+1) %><%} %>
				
				
				 <br>
				 
				 (Member Secretary)
				 <div align="left" ><b>NOTE : </b>Action item details are enclosed as Annexure - AI.</div>
			</div>
			<%} %>
			</div>
			

				
		</div> 
	
	<%if( isprint.equals("N")){ %>
		<div class="break"></div>	
		<br>
						
				<div align="center">
			<div style="text-align: center;  " class="lastpage" id="lastpage"><h2>ACTION ITEMS DETAILS</h2></div>
		
			<table style="margin-top: -5px; margin-left: 5px; width: 670px; font-size: 16px; border-collapse: collapse ;border: 1px solid black ">
			<tbody>
				<tr>
					<th  class="sth" style=" max-width: 30px"> SN. </th>
					<th  class="sth" style=" max-width: 70px"> Action Id</th>	
					<th  class="sth" style=" max-width: 600px"> Item</th>				
					<th  class="sth" style=" max-width: 70px"> Responsibility</th>					
					<th  class="sth" style=" width: 90px"> PDC</th>
				</tr>
				
				<% 	int count =0;
				 	Iterator actIterator = actionlist.entrySet().iterator();
					while(actIterator.hasNext()){	
					Map.Entry mapElement = (Map.Entry)actIterator.next();
		            String key = ((String)mapElement.getKey());
		            ArrayList<Object[]> values=(ArrayList<Object[]>)mapElement.getValue();
		            count++;
				%>
					<tr>
						<td class="std" style="text-align: center ;" > <%=count%></td>
						<td  class="std" style="text-align: left;" >
							
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
						<td  class="std" style="text-align: left;" >
							<%	int count2=0;
							for(Object obj[]:values){ %>
							<%if(obj[13]!=null){ %> <%= obj[13]%>,&nbsp;<%=obj[14] %>
								<%if(count2>=0 && count2<values.size()-1){ %>
								,&nbsp;
								<%} %>
							<%}else{ %> - <%} %>
						<%count2++;} %>
						</td>                       						
						<td  class="std" style="text-align: center;"><%if( values.get(0)[5]!=null){ %> <%=sdf.format(sdf1.parse(values.get(0)[5].toString()))%> <%}else{ %> - <%} %></td>
					</tr>				
				<% } %>
			</tbody>
		</table>
	</div>
	<br>
	<%} %>
	
	</div>
	
	
	
	
	</body>
</html>

