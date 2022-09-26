<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>

<%
String seslabid=(String)session.getAttribute("labid");
	List<Object[]> speclists = (List<Object[]>) request.getAttribute("committeeminutesspeclist");
	Object[] committeescheduleeditdata = (Object[]) request.getAttribute("committeescheduleeditdata");
	List<Object[]> committeeminutes = (List<Object[]>) request.getAttribute("committeeminutes");
	List<Object[]> committeeminutessub = (List<Object[]>) request.getAttribute("committeeminutessub");
	List<Object[]> agendas = (List<Object[]>) request.getAttribute("CommitteeAgendaList");
	List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("committeeinvitedlist");
	Object[] labdetails = (Object[]) request.getAttribute("labdetails");
	HashMap< String, ArrayList<Object[]>> actionlist = (HashMap< String, ArrayList<Object[]>>) request.getAttribute("actionlist");
	Object[] projectdetails=(Object[])request.getAttribute("projectdetails");
	Object[] divisiondetails=(Object[])request.getAttribute("divisiondetails");
	Object[] initiationdetails=(Object[])request.getAttribute("initiationdetails");
	String projectid= committeescheduleeditdata[9].toString();
	String divisionid= committeescheduleeditdata[16].toString();
	String initiationid= committeescheduleeditdata[17].toString();
	String lablogo=(String)request.getAttribute("lablogo");
	
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
          		<%if( Long.parseLong(projectid)>0){%>
             content: "Project:<%=projectdetails[1]%>";
             <%}else if(Long.parseLong(divisionid)>0){%>
               	content: "Division:<%=divisiondetails[1]%>";
             <%}else if(Long.parseLong(initiationid)>0){ %>
             	content: "Pre-Project :<%=initiationdetails[1]%>";
             <%} else{%>
             	content: "<%=labdetails[1]%>";
             <%}%>
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=committeescheduleeditdata[11] %>";
          }            
          
          @top-center { 
          margin-top: 30px;
          content: "<%=committeescheduleeditdata[15]%>"; 
          
          }

 }

 
 
 
 .sth
 {
 	   font-size: 16px;
 	   border: 1px solid black;
 }
 
 .std
 {
 	text-align: center;
 	border: 1px solid black;
 }
 
</style>
<meta charset="ISO-8859-1">
</head>
<body>
	<div class="card-header" style="background-color: #09009B;border-radius: 10px;" >
		<form action="MeetingMinutesApprovalSubmit.htm" name="myfrm" id="myfrm" method="post">
			<div class="row">
				<div class="col-md-1" style="margin-top:0px;"><b style="margin-top:10px;color: white;" >Decision :</b> </div>
				<div class="col-md-6">
					<textarea rows="2" style="display:block" class="form-control"  id="Remark" name="Remark"  placeholder="Enter Remarks to Return ..!!"></textarea>
				</div>
				<div class="col-md-5" align="center">
					<button type="submit"  name="sub" value="approve" class="btn btn-success" style="margin-top:10px; font-weight: 600" onclick="return confirm('Are You Sure To Approve ?')"><i class="fa fa-check" aria-hidden="true" ></i> Approve</button>
					<button type="submit"  name="sub" value="return" class="btn btn-danger" onclick="remarks()" style="margin-top:10px;padding: 0.375rem 17px;font-weight: 600"><i class="fa fa-repeat" aria-hidden="true" ></i> Return</button>
					<button type="submit"  name="sub" value="back" class="btn btn-primary back"  style="margin-top:10px;padding: 0.375rem 17px;"> Back</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="scheduleid" value="<%=committeescheduleeditdata[6] %>"/>
				</div>
			</div>
		</form>			
	</div>				
						

						


	<div id="container pageborder" align="center"  class="firstpage" id="firstpage">
		<div class="firstpage" id="firstpage">		
			<br>
			<div style="text-align: center;" ><h1>MINUTES OF MEETING</h1></div>
			<br>
			<div style="text-align: center;" ><h2 style="margin-bottom: 2px;"><%=committeescheduleeditdata[7].toString().toUpperCase()%>  (<%=committeescheduleeditdata[8].toString().toUpperCase() %>) </h2></div>				
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
				 <td  style="text-align: center;  width: 650px;font-size: 20px ;padding-top: 5px"> <b><%=sdf.format(sdf1.parse(committeescheduleeditdata[2].toString()))%></b></td>
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
			<br>				<br><br>
			
			
			<div style="text-align: center;" ><h3><%=labdetails[2] %> (<%=labdetails[1]%>)</h3></div>
			
			<div style="text-align: center;" ><h3><%=labdetails[4] %></h3></div>
		</div>
		
 <h1 class="break"></h1> 
<!-- ------------------------------------------------------- members --------------------------------- -->
<%if(invitedlist.size()>0){ %>
		<% ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","CW","CO"));
		 //ArrayList<String> addlmembertypes=new ArrayList<String>(Arrays.asList("W","E","I","P")); %>

<div style="align : center;">
	<h2>ATTENDANCE</h2>
  <table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;" >	
	 <tr>
		 <th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Members Present</th>
	 </tr>
	 <% int j=0;
	
	
	 	for(int i=0;i<invitedlist.size();i++)
		{
	 	if(invitedlist.get(i)[4].toString().equals("P") && membertypes.contains( invitedlist.get(i)[3].toString()) )
	 	{ j++;%>
	 	
	 	 <tr>
	 	 <td style="border: 1px solid black; padding: 5px;text-align: left"><%=j%> .</td>
	 	  	<td style="border: 1px solid black; padding: 5px;text-align: left">  
	 	  	
	 			<%= invitedlist.get(i)[6]%>,&nbsp;<%=invitedlist.get(i)[7] %>  
		 	</td>	
		 	<td style="border: 1px solid black;padding: 5px ;text-align: left">
		 		<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %> Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %> External(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%> External(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%> (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 		</tr>
	 <%}
	 } %>
	 
	 
	 <tr  >
		 
		 <th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Other Invitees </th>
		 
	 </tr>
	 
	 <%
		
	 for(int i=0;i<invitedlist.size();i++)
		{
	 	if(invitedlist.get(i)[4].toString().equals("P") && !membertypes.contains( invitedlist.get(i)[3].toString()) )
	 	{ j++;
	 	addcount++;
	 	%>
	 	
	 	 <tr>
	 	 <td style="border: 1px solid black; padding: 5px;text-align: left"> <%=j%> .</td>
	 	  	<td style="border: 1px solid black; padding: 5px;text-align: left">  
	 	  	
	 			<%= invitedlist.get(i)[6]%>,&nbsp;<%=invitedlist.get(i)[7] %>
		 	</td>	
		 	<td style="border: 1px solid black;padding: 5px ;text-align: left">
		 		<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>External(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>External(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%> (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 		</tr>
	 <%}
	 } %>
	 
	  <%if(addcount==0)
	  {%>
		 	<tr><th colspan="3" style="text-align:center; font-weight: 20; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">No Additional Invites</th> </tr>
	  <%}%>
	 
	
	 
	<%if(j < invitedlist.size() ){ %>	 
	  	<tr >
			<th colspan="3" style="text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px">Members Absent</th>
		</tr>
	<%} %>
	 
	 
	<% 
	int count=0;
	for(int i=0;i<invitedlist.size();i++)
	 {
	 	if(invitedlist.get(i)[4].toString().equals("N"))
	 	{count++; %>
	 	 <tr > 	
	 	  <td style="border: 1px solid black; padding: 5px;text-align: left"> <%=count%> .</td>
	 	 <td style="border: 1px solid black ;padding: 5px;text-align: left " >  
	 		<%= invitedlist.get(i)[6]%>, <%=invitedlist.get(i)[7] %>
	 		</td>	<td style="border: 1px solid black ;padding: 5px ;text-align: left "> 
	 			<%  if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI")){   %>Internal<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")){	 %>External(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")){	 %>External(<%=invitedlist.get(i)[11]%>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("I")){	 %><%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("W") ){	 %>(<%=invitedlist.get(i)[11] %>)<%}
					else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("E") )    {%>(<%=invitedlist.get(i)[11] %>)<%}
					else {%> REP_<%=invitedlist.get(i)[3].toString()%> (<%=invitedlist.get(i)[11] %>)  <%}
				%>
	 		</td>	
	 	</tr>
	 	
	 <%}
	 } %>
	  
	 <tr> <td></td>	</tr>
  </table>


</div>
<%} %>
	


 <h1 class="break"></h1> 
<!-- -------------------------------------------------------members----------------------------- -->
	<div>
		<%
			for (Object[] committeemin : committeeminutes) {
			if (committeemin[0].toString().equals("1") || committeemin[0].toString().equals("2")) {
		%>
		
		<table style="margin-top: 00px; margin-bottom: 0px; margin-left: 0px; width: 650px; font-size: 16px; border-collapse: collapse;">
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
				</div>
				<!-- <div class="break"></div> -->
	<!-- ------------------------- agenda---------------------------- -->
				<%
					} 
			else if (committeemin[0].toString().equals("3") ) 
			{						
				%>
						<div align="center">
							<table style="margin-top: 00px; margin-bottom: 0px; margin-left: 0px; width: 650px; font-size: 16px; border-collapse: collapse;">
								<tr>
									<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%>s</th>
								</tr>
							</table>	
						</div>		
					
						<%if(agendas.size()!=0)
						{
							int agendaid = 1;
							for (Object[] agenda : agendas) 
							{	int brcount=0;							
						%>
								<div align="center" >
								    <table style="margin-top: 00px; margin-bottom: 0px; margin-left: 0px; width: 650px; font-size: 16px; border-collapse: collapse;">
										<tr>								
											<td colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]+"."+agendaid%>.&nbsp;&nbsp;&nbsp;<%=agenda[3]%></td>
										</tr>
								<%
									int index = 1;
									for (Object[] minssub : committeeminutessub) 
									{
								%>				
										<tr >
											<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=committeemin[0]+"."+agendaid+"."+index%>.&nbsp;&nbsp;&nbsp;<%=minssub[1]%></th>
										</tr>								
								<%
										int count=0;
										int count1=0;
										int index1=0;
										for (Object[] speclist : speclists) 
										{
											if (agenda[0].toString().equals(speclist[6].toString()) && minssub[0].toString().equals(speclist[5].toString())) 
											{
												count++; 
													index1++;						
											%>						
												
													
																			
												<%	if(speclist[5].toString().equals("7") )
												{%>	
													<td style="text-align: left;">
														<div align="left" style="padding-left: 70px"><%=speclist[1]%></div>
													</td>					
												<%}else if(speclist[5].toString().equals("8")){
												%>
													<td style="text-align: left;">
														<div align="left" style="padding-left: 70px"><%=speclist[1]%></div>
													</td>	
													
												<%}else if(speclist[5].toString().equals("9")){
												%>
													<tr >
														<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=committeemin[0]+"."+agendaid+"."+index+"."+index1%>.&nbsp;&nbsp;&nbsp;<%=speclist[9]%></th>
													</tr>	
													<td style="text-align: left;">
														<div align="left" style="padding-left: 70px"><%=speclist[1]%></div>
													</td>		
																						
												<%}
											
											}
										}
									if (count == 0)
									{%>
									<tr style="page-break-after: ;">
									<td style="text-align: left;"><div style="padding-left: 50px"><p>NIL</p></div>
									</td>	
									</tr>								
									<%}%>
									
								
								
								<%index++;
								} 
								agendaid++;
								
							}%>
							
							  
						
						<%}else{%>
							<tr>
							<td style="text-align: left;"><div style="padding-left: 30px"><p>NIL</p>
							</td>
							</tr>
							
						<%}%>
						</table>
					</div>
				<!-- <div class="break"></div>  -->
	<!-- ----------------------------------------------agenda end------------------------------------------- -->
				
			<%}else if (committeemin[0].toString().equals("4") || committeemin[0].toString().equals("5") || committeemin[0].toString().equals("6")) {%>
			
			<div align="center">
				<table style="margin-top: 00px; margin-bottom: 0px; margin-left: 0px; width: 650px; font-size: 16px; border-collapse: collapse;">
					<tbody>
						<tr>
							<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;<%=committeemin[0]%>.&nbsp;&nbsp;&nbsp;<%=committeemin[1]%></th>
						</tr>
				
						<%
						int count = 0;
						
						for (Object[] speclist : speclists)
						{
							if (speclist[3].toString().equals(committeemin[0].toString())) 
							{
								count++;%>						
							 	
							<%	if(speclist[3].toString().equals("4") )
								{%>	
									<td style="text-align: left;">
									<div align="left" style="padding-left: 70px"><%=speclist[1]%></div>
									</td>					
								<%}else if(speclist[3].toString().equals("5")){
								%>
								<tr>
									<th colspan="8" style="text-align: left; font-weight: 700;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=committeemin[0]+"."+count%>.&nbsp;&nbsp;&nbsp;<%=speclist[9]%></th>
								</tr>
									<td style="text-align: left;">
									<div align="left" style="padding-left: 70px">
										<%=speclist[1]%>
									</div>
									</td>
									
									<%}else if(speclist[3].toString().equals("6")){
								%>
							
									<td style="text-align: left;">
									<div align="left" style="padding-left: 70px">
										<%=speclist[1]%>
									</div>
									</td>						
								<%}
							}							
							
						}if (count == 0)
						{%>
						<tr style="page-break-after: ;">
						<td style="text-align: left;"><div style="padding-left: 50px"><p>NIL</p></div>
						</td>	
						</tr>								
						<%}%>
							
				
				
				</table>
			</div>
				
	<%}
	}%>
	
	
	
	<%if(actionlist.size()>0 ){ %>
			 <div class="break"></div>	
			<br>
						
		<div align="center">
			<div style="text-align: center;  " class="lastpage" id="lastpage"><h2>ACTION DETAILS</h2></div>
		
			<table style="margin-top: 00px; margin-bottom: 0px; margin-left: 5px; width: 670px; font-size: 16px; border-collapse: collapse ;border: 1px solid black ">
			<tbody>
				<tr>
					<th  class="sth" style=" max-width: 30px"> SN. </th>
					<th  class="sth" style=" max-width: 70px"> Action Id</th>	
					<th  class="sth" style=" max-width: 600px"> Item</th>				
					<th  class="sth" style=" max-width: 70px"> Assignee</th>					
					<th  class="sth" style=" width: 90px"> PDC</th>
				</tr>
				
				<% int count =0;
				  Iterator actIterator = actionlist.entrySet().iterator();
				while(actIterator.hasNext()){	
					Map.Entry mapElement = (Map.Entry)actIterator.next();
		            String key = ((String)mapElement.getKey());
		            ArrayList<Object[]> values=(ArrayList<Object[]>)mapElement.getValue();
		            count++;
					%>
					<tr>
						<td class="std"> <%=count%></td>
						<td  class="std">
							
							<%	int count1=0;
								for(Object obj[]:values){
									 count1++; %>
									<%if(count1==1 ){ %>
										<%if(obj[3]!=null){ %> <%= obj[3]%><%}else{ %> - <%} %>
									<%}else if(count1==values.size() && projectid.equals("0")){ %>
										<%if(obj[3]!=null){ %>  - <br> <%= obj[3].toString().split("/")[3]%> <%}else{ %> - <%} %>
									<%}else if(count1==values.size() && !projectid.equals("0")){ %>
										<%if(obj[3]!=null){ %>  - <br> <%= obj[3].toString().split("/")[4]%> <%}else{ %> - <%} %>
									<%} %>
							<%} %>
							
						</td>
						
						<td  class="std" style="padding-left: 5px;padding-right: 5px"><%= values.get(0)[1]  %></td>
						<td  class="std">
							<%for(Object obj[]:values){ %>
								<%if(obj[13]!=null){ %> <%= obj[13]%> (<%=obj[14] %>), &nbsp;<%}else{ %> - <%} %>
							<%} %>
						</td>                       						
						<td  class="std"><%if( values.get(0)[5]!=null){ %> <%=sdf.format(sdf1.parse(values.get(0)[5].toString()))%> <%}else{ %> - <%} %></td>
					</tr>				
				<% } %>
			</tbody>
		</table>
	</div>
	<br>	
	<%} %>
	
	
	
	
</div> 
	
	
	
	
	
	
	
<script>



function remarks(){
	
	 event.preventDefault();
	
	 if($("#Remark").val()==""){
		 alert('Kindly fill Remarks to Return !')
	 }
	 if($("#Remark").val()!=""){
		 
		 var r=confirm("Are you sure, You want to Return ?");
	
		 if(r==true){
		 var input= $("<input>").attr("type","hidden").attr("name","sub").val("return");
		 
		 $("#myfrm").append(input);
		 $("#myfrm").submit(); 
		 }
		 
	 }
	 
	

}

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#readonlystartdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate":new Date(), */
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

 
$(function() {
	   $('#starttime').daterangepicker({
	            timePicker : true,
	            singleDatePicker:true,
	            timePicker24Hour : true,
	            timePickerIncrement : 1,
	            timePickerSeconds : false,
	            locale : {
	                format : 'HH:mm'
	            }
	        }).on('show.daterangepicker', function(ev, picker) {
	            picker.container.find(".calendar-table").hide();
	   });
	})
 
	
function Add(myfrm){
	
	event.preventDefault();
	
	var date=$("#readonlystartdate").val();
	var time=$("#starttime").val();
	
	bootbox.confirm({ 
 		
	    size: "large",
		message: "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Update Schedule to "+date+" &nbsp;("+ time +") ?</b></center>",
	    buttons: {
	        confirm: {
	            label: 'Yes',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'No',
	            className: 'btn-danger'
	        }
	    },
	    callback: function(result){ 
	 
	    	if(result){
	    	
	    		$("sub").value;
	         $("#editform").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}	


	
//When the user scrolls the page, execute myFunction
window.onscroll = function() {myFunction()};

// Get the header
var header = document.getElementById("myHeader");

// Get the offset position of the navbar
var sticky = header.offsetTop;

// Add the sticky class to the header when you reach its scroll position. Remove "sticky" when you leave the scroll position
function myFunction() {
  if (window.pageYOffset > sticky) {
    header.classList.add("sticky");
  } else {
    header.classList.remove("sticky");
  }
}	
	

 
</script>
	
	
	
	
			

</body>
</html>

