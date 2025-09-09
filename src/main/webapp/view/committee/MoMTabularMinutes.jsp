<%@page import="java.util.Comparator"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.IOError"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		List<Object[]> speclists = (List<Object[]>) request.getAttribute("committeeminutesspeclist");
		Object[] committeescheduleeditdata = (Object[]) request.getAttribute("committeescheduleeditdata");
		List<Object[]> committeeminutes = (List<Object[]>) request.getAttribute("committeeminutes");
		List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("committeeinvitedlist");
		Object[] labdetails = (Object[]) request.getAttribute("labdetails");
		HashMap< String, ArrayList<Object[]>> actionlist = (HashMap< String, ArrayList<Object[]>>) request.getAttribute("actionsdata");
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
	%>
	<style type="text/css">
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
	</style>
<meta charset="UTF-8">
<title><%=committeescheduleeditdata[8]%> Minutes View</title>
</head>
<body>

	<div id="container" align="center" style="margin: 15px;">
	  <table style=" border:1px solid black;  border-collapse: collapse; width:100%;">
	    <tr>
	      <!-- Left column with right border -->
	     <%--  <td width="30%" align="left" style="border-right:1px solid black; padding:5px; padding-left: 10px;">
	        <img style="width: 3cm; height: 3cm;" src="data:image/png;base64,<%=lablogo%>"><br>
	        <h4 style=" margin:0; padding:0;">RCI/PROGRAMME AD</h4>
	        <p style="margin:0; padding:0;">Kanchanbagh P.O., <br> Hyderabad - 58 </p>
	      </td> --%>
	      
	       <td width="30%" align="left" style="border-right:1px solid black; padding:5px; padding-left: 10px;">
	        <img style="width: 3cm; height: 3cm;" src="data:image/png;base64,<%=lablogo%>"><br>
	        <h4 style=" margin:0; padding:0;"><%=labdetails[2]!=null?labdetails[2].toString(): " - " %> (<%=labdetails[1]!=null?labdetails[1].toString(): " - "%>)</h4>
	        <p style="margin:0; padding:0;"><%=labdetails[4]!=null?labdetails[4].toString(): " - " %></p>
	        <p style="margin:0; padding:0;"><%=labdetails[5]!=null?labdetails[5].toString(): " - " %> - <%=labdetails[6]!=null?labdetails[6].toString(): " - " %> </p>
	      </td> 
	
	      <!-- Right column -->
	      <td width="70%" align="left" style="padding:5px;">
	        <p>1.Meeting Title : <span style="font-weight: bold;"> <%=committeescheduleeditdata[7]!=null?committeescheduleeditdata[7].toString().toUpperCase():" - "%>  (<%=committeescheduleeditdata[8]!=null?committeescheduleeditdata[8].toString().toUpperCase():" - " %><%if(meetingcount>0){ %>&nbsp;&nbsp;#<%=meetingcount %><%} %>)</span> </p>
	        <p>2.Venue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <%=committeescheduleeditdata[12]!=null?committeescheduleeditdata[12].toString(): " - " %> </p>
	        <p>3.Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=committeescheduleeditdata[2]!=null?sdf.format(sdf1.parse(committeescheduleeditdata[2].toString())): " - " %> </p>
	        <p>4.Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=committeescheduleeditdata[3]!=null?committeescheduleeditdata[3].toString(): " - "%> </p>
	        <p>5.<%=committeescheduleeditdata[11]!=null?committeescheduleeditdata[11].toString(): " - " %></p>
	      </td>
	    </tr>
	  </table>
	  <div>
	  	<p style="text-decoration: underline; font-weight: bold;">Ref: Committee formation Letter No:&nbsp;&nbsp; <%=committeescheduleeditdata[11]!=null?committeescheduleeditdata[11].toString(): " - " %>&nbsp;&nbsp; Dated: <%=committeescheduleeditdata[2]!=null?sdf.format(sdf1.parse(committeescheduleeditdata[2].toString())): " - " %> </p>
	  </div>
	  
	  <!-------------------------------------------------Introduction And Opening Remarks ----------------------------------->
	  
	  <div align="left">
	  <!-- <h4> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I.</h4> -->
	  	<%
	  		StringBuilder title1 = new StringBuilder();
			for (Object[] committeemin : committeeminutes) {
			if (committeemin[0].toString().equals("1") || committeemin[0].toString().equals("2")) {
				title1.append(committeemin[1].toString()+"-");
			}}
			String[] titlearr = title1.toString().split("-");
			String title = "";
			for(int i=0;i<titlearr.length;i++){
				title+=titlearr[i];
				if(i!=titlearr.length-1) title+=" & ";
			}
		%>
		
	   <!-- <h4 style="margin-bottom:10; padding:0;">&nbsp;&nbsp;&nbsp;&nbsp; I. &nbsp;&nbsp;	 Introduction & Opening Remarks: </h4> --> 
	   <h4 style="margin-bottom:10; padding:0;">&nbsp;&nbsp;&nbsp;&nbsp; I. &nbsp;&nbsp;	 <%=title %>: </h4> 
		  <%
				for (Object[] committeemin : committeeminutes) {
				if (committeemin[0].toString().equals("1") || committeemin[0].toString().equals("2")) {
			%>
			 
	  		<span style="font-weight: bold; margin:0; padding:0; padding-left: 40px; " > <%=committeemin[0]!=null?committeemin[0].toString(): " - "%>. &nbsp;&nbsp; <%=committeemin[1]!=null?committeemin[1].toString(): " - "%> </span>
	  		<% int count = 0;

				for (Object[] speclist : speclists)
				{
					if (speclist[3].toString().equals(committeemin[0].toString()) && speclist[1]!=null && !speclist[1].toString().trim().isEmpty()) 
					{
						count++;
				%>	
				 <div style="padding-left: 70px"><%=speclist[1]!=null?speclist[1].toString(): " - "%></div> 
	  		<%	break;		
							}
						}
						if (count == 0) 
						{%>
						<p style="padding-left: 70px;">NIL<p>
					
	  		<%}}} %>
	  </div>
	  
	  <!----------------------------------------------------------------- ATTENDANCE -------------------------------------------------->
	  
	 	<%if(invitedlist.size()>0){ %>
		<% ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","CW","CO","CH"));
		   ArrayList<String> members = new ArrayList<String>();
		   
		   Map<Object,List<Object[]>> membersname = invitedlist.stream().filter(row->row[4].toString().equalsIgnoreCase("P")).collect(Collectors.groupingBy(row -> row[3]));
		   
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
	  <div>
	  	<table style="border:1px solid black; border-collapse: collapse; width: 100%" >
	  		<thead>
	  			<tr>
	  				<th colspan="2" style="border-bottom: 1px solid black; padding:5px; text-align: left;">&nbsp;&nbsp;&nbsp; II. &nbsp;&nbsp;Participants List (Committee Members and Invitees):</th>
	  			</tr>
	  		</thead>
	  		<tbody>	  		
	  		 <%if(memPresent > 0){ %>
			 <% 
			 	for(int i=0;i<invitedlist.size();i++)
				{
			 	if(invitedlist.get(i)[4].toString().equals("P") && membertypes.contains( invitedlist.get(i)[3].toString()) )
			 	{ j++;
			 		if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) membersec=invitedlist.get(i); 
			 		%>
			 		
			 		<%}}} %>
	  		<%if(memPresent > 0){ %>
			 <% 
			 	for(int i=0;i<invitedlist.size();i++)
				{
			 	if(invitedlist.get(i)[4].toString().equals("P") && membertypes.contains( invitedlist.get(i)[3].toString()) )
			 	{ j++;
			 		if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) membersec=invitedlist.get(i); 
			 		if(invitedlist.get(i)[6].toString()!=null && invitedlist.get(i)[7].toString()!=null)	members.add(invitedlist.get(i)[6].toString()+", "+invitedlist.get(i)[7].toString());
			 		//if(invitedlist.get(i)[6].toString()!=null && invitedlist.get(i)[7].toString()!=null)	members.add(invitedlist.get(i)[12].toString()+". "+ invitedlist.get(i)[6].toString()+", "+invitedlist.get(i)[7].toString());
			 		}
			 	}} %>
	  		<%if(memAbscent > 0){ %>
			 <% 
			 	for(int i=0;i<invitedlist.size();i++)
				{
			 	if(invitedlist.get(i)[4].toString().equals("N") && membertypes.contains( invitedlist.get(i)[3].toString()) )
			 	{ j++;
			 	//if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) membersec=invitedlist.get(i); 
			 	//if(invitedlist.get(i)[6].toString()!=null && invitedlist.get(i)[7].toString()!=null) members.add(invitedlist.get(i)[12].toString()+". " + invitedlist.get(i)[6].toString()+", "+invitedlist.get(i)[7].toString());
			 	}}} %>
	  			<%if(ParPresent > 0){ %>
			 <% 
			 	for(int i=0;i<invitedlist.size();i++)
				{
			 	if(invitedlist.get(i)[4].toString().equals("P") && !membertypes.contains( invitedlist.get(i)[3].toString()) )
			 	{ j++;
			 	//if(invitedlist.get(i)[6].toString()!=null && invitedlist.get(i)[7].toString()!=null) members.add(invitedlist.get(i)[12].toString()+". "+ invitedlist.get(i)[6].toString()+", "+invitedlist.get(i)[7].toString());
			 	if(invitedlist.get(i)[6].toString()!=null && invitedlist.get(i)[7].toString()!=null) members.add( invitedlist.get(i)[6].toString()+", "+invitedlist.get(i)[7].toString());
			 		
			 	}}} %>
	  			<%if(parAbscent > 0){ %>
			 <% 
			 	for(int i=0;i<invitedlist.size();i++)
				{
			 	if(invitedlist.get(i)[4].toString().equals("N") && !membertypes.contains( invitedlist.get(i)[3].toString()) )
			 	{ j++;
			 	//if(invitedlist.get(i)[6].toString()!=null && invitedlist.get(i)[7].toString()!=null) members.add(invitedlist.get(i)[12].toString()+". " +invitedlist.get(i)[6].toString()+", "+invitedlist.get(i)[7].toString());
			 	}}} %>
			 	
			 	<%-- <% for(int i=0;i<members.size();i++){
			 	%>
			 	<tr>
			 		<td width="50%" align="left" style="padding-left: 30px; padding:5px; border:1px solid black; "><%=members.get(i++) %></td>
	  				<td width="50%" align="left" style="padding-left: 30px; padding:5px; border:1px solid black; "><%if(i<members.size()){ %><%=members.get(i) %> <%} %></td>
			 	</tr>
			 	<%} %> --%>
			 	
			 	  <%
			 	  int leftsize = members.size() / 2 + (members.size() % 2 == 0 ? 0 : 1);
			 	  int rightsize = members.size()-leftsize;
			 	  List<String> leftlist = new ArrayList<String>(members.subList(0, leftsize));
			 	  List<String> rightlist = new ArrayList<String>(members.subList(leftsize,members.size()));
			 	  int ji=leftsize;
			 	  for(int i=0;i<leftsize || i<rightsize;i++){
			 	%>
			 	<tr>
			 		<td width="50%" align="left" style="padding-left: 30px; padding:5px; border:1px solid black; "><%=(i+1)+". " + leftlist.get(i) %></td>
	  				<td width="50%" align="left" style="padding-left: 30px; padding:5px; border:1px solid black; "><%if(i<rightsize){ %><%=++ji +". "+ rightlist.get(i) %> <%} %></td>
			 	</tr>
			 	<%} %> 
			 	
	  		
	  		</tbody>
	  	</table>
	  	<%} %>
	  </div>
	  
	   <!----------------------------------------------------------------- Deliberations and Action Points ------------------------------------------------->
	  
	  <div align="left">
	  	<h4>&nbsp;&nbsp;&nbsp;&nbsp; III. &nbsp;&nbsp; Deliberations and Action Points </h4>
	  </div>
	  <div>
	  	<table style="border:1px solid black; border-collapse: collapse; width: 100%" >
	  		<thead>
	  			<tr>
	  				<th width="10%" style="border: 1px solid black; padding:5px;">S.No</th>
	  				<th width="42%" style="border: 1px solid black; padding:5px; text-align: left;">Decisions/Action Points</th>
	  				<th width="33%" style="border: 1px solid black; padding:5px; text-align: left;">Action By</th>
	  				<th width="15%" style="border: 1px solid black; padding:5px; text-align: left;">PDC</th>
	  			</tr>
	  		</thead>
	  		<tbody>
	  		<% int count=0,index=0, indexcount=1;
				String agenda="";
				
				Map<String, List<Object[]>> actionslist = speclists!=null && speclists.size()>0?speclists.stream()
						  .collect(Collectors.groupingBy(array -> array[1].toString() , LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
						 
					if (actionslist!=null && actionslist.size() > 0) {
						for (Map.Entry<String, List<Object[]>> map : actionslist.entrySet()) {
						    List<Object[]> values = map.getValue();
						    int i=1;
						    for (Object[] obj : values) {
						    	
						        if(obj[3] != null && Integer.parseInt(obj[3].toString()) == 3 && obj[7].toString().equalsIgnoreCase("A") || obj[7].toString().equalsIgnoreCase("D")){
						        		//&& Integer.parseInt(obj[3].toString()) < 6 && obj[7]!=null && obj[7].toString().equalsIgnoreCase("A") || obj[7].toString().equalsIgnoreCase("D")) {
						            
						            if(obj[10] != null && !obj[10].toString().equalsIgnoreCase(agenda)) {
						                indexcount = 1;
						                count++;
						%>
						<tr>
						    <td style="border: 1px solid black; font-weight:bold; padding:5px;"><%= ++index %></td>	  			
						    <td style="border: 1px solid black; padding:5px; font-weight:bold; text-align: left;" colspan="3">
						        <%= obj[10] != null ? obj[10].toString() : "-" %>
						    </td>
						</tr>
						<%
			                agenda = obj[10].toString();
			            }
						%>
						<tr>
						    <%if(i==1){ %>
							    <td rowspan="<%=values.size() %>"  style="border: 1px solid black; padding:5px; text-align: center;"><%= index + "." + indexcount++ %></td>	  			
							    <td rowspan="<%=values.size() %>"  style="border: 1px solid black; padding:5px; text-align: left;">
							        <% if(obj[7]!=null && obj[7].toString().equalsIgnoreCase("A")) { %> <%=obj[1]!=null?obj[1].toString(): " - "%> <%} %>
									<% if(obj[7]!=null && obj[7].toString().equalsIgnoreCase("D")) { %> <%=obj[1]!=null?obj[1].toString(): " - "%> <%} %>
							    </td>
						    <%} %>	
						    <td style="border: 1px solid black; padding:5px; text-align: left;"><%= obj[13] != null ? obj[13].toString() : " - " %></td>	  			
						    <td style="border: 1px solid black; padding:5px; text-align: left;"><%= obj[12] != null ? fc.SqlToRegularDate(obj[12].toString()) : " - " %></td>	  			
						</tr>
						<%
								i=0;
						        }
						    }
						}
				 if(count==0){%>
					<tr>
						<td class="std" style="text-align :center;border:1px solid black;"  colspan="4">No Minutes details Added</td>
					</tr>
				<%}}
				else {
				%>
					<tr>
						<td class="std" style="text-align :center;border:1px solid black;"  colspan="4">No Minutes details Added</td>
					</tr>
				<%}%>
	  		</tbody>
	  	</table>
	  </div>
	  
	   <!----------------------------------------------------------------- Conclusions & Recommendations ------------------------------------------->
	  
	  <div align="left">
	  	<%
			 if(ccmFlag==null) {
			 for (Object[] committeemin : committeeminutes) { 
				 if ( committeemin[0].toString().equals("6")) { %>
	  		<h4>&nbsp;&nbsp;&nbsp;&nbsp; IV. &nbsp;&nbsp; Conclusions & Recommendations: </h4>
		  	<% for (Object[] speclist : speclists)
							{
								if (speclist[3].toString().equals(committeemin[0].toString())) 
								{
									if(speclist[3].toString().equals("6")){
									%>
			<div style="padding-left: 40px;"> <%if(speclist[1]!=null && !speclist[1].toString().trim().equalsIgnoreCase("")){%> <%=speclist[1]!=null?speclist[1].toString(): " - "%>  <%}else{ %> - <%} %></div>
				<%}} } } }} %>
	  </div>
	  
	  <!------------------------------------------------------------------ Final -------------------------------------------------------->
	  <div style="width: 650px;margin-left: 15px; ">
			<div align="left" >
				These minutes are issued with the approval of the Chairperson.
			</div>
			<div align="left" style="padding-right: 0rem;padding-bottom: 0rem; margin-right: 0px">
				<!-- <br>Date :&emsp;&emsp;&emsp;&emsp;&emsp;  <br>Time :&emsp;&emsp;&emsp;&emsp;&emsp; -->
				<%if(membersec!=null){ %>
					<div align="right" style="padding-right: 0rem;padding-bottom: 2rem;">
						<br><br><%if(membersec[6]!=null){%><%= membersec[6].toString().substring(membersec[6].toString().indexOf(".")+1) %><%} %>
						<br>(Member Secretary)
					</div>
				<%} %>
			</div>
			<!-- <div align="left" ><b>NOTE : </b>Action item details are enclosed as Annexure - AI.</div> -->		
		</div> 
	</div>


</body>
</html>