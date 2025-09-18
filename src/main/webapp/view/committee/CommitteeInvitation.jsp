<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/CommitteeInvitation.css" var="CommitteeInvitation" />
<link href="${CommitteeInvitation}" rel="stylesheet" />
<title>COMMITTEE INVITATION</title>
</head>
<body>
	<%
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		String committeescheduleid=(String)request.getAttribute("committeescheduleid");
		Object[] committeescheduledata=(Object[])request.getAttribute("committeescheduledata");
		String Committeeid=committeescheduledata[7].toString();
		List<Object[]> agendalist=(List<Object[]>) request.getAttribute("agendalist");
		String labid=(String)request.getAttribute("labid");
		String committeemainid=(String)request.getAttribute("committeemainid");
		
		List<Object[]> committeeallmemberlist=(List<Object[]>) request.getAttribute("committeeallmemberlist");
		
		List<Object[]> agendaList=(List<Object[]>) request.getAttribute("agendaList");
		String ccmFlag = (String)request.getAttribute("ccmFlag");
		String committeeId = (String)request.getAttribute("committeeId");
	%>

	<% 
	    String ses = (String) request.getParameter("result");
	    String ses1 = (String) request.getParameter("resultfail");
	    if (ses1 != null) { %>
	    <div align="center">
	        <div class="alert alert-danger" role="alert">
	            <%=StringEscapeUtils.escapeHtml4(ses1) %>
	        </div>
	    </div>
	<% }if (ses != null) { %>
	    <div align="center">
	        <div class="alert alert-success" role="alert">
	            <%=StringEscapeUtils.escapeHtml4(ses) %>
	        </div>
	    </div>
	<% } %>


<form  action="CommitteeInvitationCreate.htm" method="POST" name="myfrm1" id="myfrm1">

	<div class="container-fluid">		
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				
					<div class="card-header">
						<div class="row">
							<div class="col-md-3" >
					  			<h4><%=committeescheduledata[8] %> Invitations</h4>
							 </div>
							 <div class="col-md-9 meetingDivStyle" align="right">
					 			<h5 class="h5MeetingColor">(Meeting Id : <%=committeescheduledata[12]!=null?StringEscapeUtils.escapeHtml4(committeescheduledata[12].toString()): " - " %>) &nbsp;&nbsp; - &nbsp;&nbsp; (Meeting Date & Time : <%= committeescheduledata[2]!=null?sdf.format(sdf1.parse( StringEscapeUtils.escapeHtml4(committeescheduledata[2].toString()))):" - "%>  &&  <%=committeescheduledata[3]!=null?StringEscapeUtils.escapeHtml4(committeescheduledata[3].toString()): " - " %>)</h5>
							 </div>
					 	</div>
					</div>
				
							<div class="card-body">

								<div class="row">
								
									<div class="col-md-4">
										<table>
											<tr>
												<td><label class="control-label">Chairperson </label></td>
											</tr>
											<tr>
											<%for(int i=0;i<committeeallmemberlist.size();i++){
												Object[] obj=committeeallmemberlist.get(i);
												if(obj[8].toString().equalsIgnoreCase("CC")){%>
												<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
													<input type="hidden" name="chairperson" value="<%=obj[5]%>,CC,<%=obj[3]%>,<%=obj[11]%>">
													<input type="hidden" name="empid" value="<%=obj[5]%>,CC,<%=obj[3]%>,<%=obj[11]%>">
													<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
												</td>
											<%	committeeallmemberlist.remove(i);
												break;}
											}%>
											</tr>
										</table>
									</div>
									
									<div class="col-md-4">
										<table>
											<tr>
												<td><label class="control-label">Member Secretary   </label></td>
												
											</tr>
											<tr>
											
												<%for(int i=0;i<committeeallmemberlist.size();i++){
													Object[] obj=committeeallmemberlist.get(i);
													if(obj[8].toString().equalsIgnoreCase("CS")){%>
													<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
														<input type="hidden" name="empid" value="<%=obj[5]%>,CS,<%=obj[3]%>,<%=obj[11]%>">
														<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
													</td>
												<%	committeeallmemberlist.remove(i);
													break;}
												}%>									
											</tr>
										</table>
														
									</div>
									<div class="col-md-4">
										<table>
											<tr>
												<td><label class="control-label">Co-Chairperson  </label></td>
												
											</tr>
											<tr>
											
												<%for(int i=0;i<committeeallmemberlist.size();i++){
													Object[] obj=committeeallmemberlist.get(i);
													if(obj[8].toString().equalsIgnoreCase("CH")){%>
													<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
														<input type="hidden" name="empid" value="<%=obj[5]%>,CH,<%=obj[3]%>,<%=obj[11]%>">
														<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
													</td>
												<%	committeeallmemberlist.remove(i);
													break;}
												}%>									
											</tr>
										</table>
														
									</div>				
								</div>
					
					<br>
					
					<% 	LocalDate scheduledate=LocalDate.parse(committeescheduledata[2].toString());
					 	LocalDate todaydate=LocalDate.now();	%>
						
						
									<div class="row">
											<div  class="col-md-4">
											
												<h5> Internal Members</h5> 
													<hr>									
												 <table border='0'>
													<tbody>
														<%int count = 0;
														for(int i=0;i<committeeallmemberlist.size();i++){
															Object[] obj=committeeallmemberlist.get(i);
															if(obj[8].toString().equalsIgnoreCase("CI")){
															count++;	
														%>
														<tr>
														<td class="tdclass"><%=count%> )</td> 
														<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
															<input type="hidden" name="empid" value="<%=obj[5]%>,CI,<%=obj[3]%>,<%=obj[11]%>">
															<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
														</td>						
														
																																		
														</tr>
														
														<% }
														}%>
													</tbody>
												</table>						
												<br>
										</div>
								
								 	
								
								
									<div  class="col-md-4">
									<%int count1 = 0;
									if(committeeallmemberlist.size()>count){ %>
									<h5>External Members (Within DRDO)</h5>
										<hr>
									
									 <table border='0'>
										<tbody>
											<%
												for(int i=0;i<committeeallmemberlist.size();i++){
													Object[] obj=committeeallmemberlist.get(i);
													if(obj[8].toString().equalsIgnoreCase("CW")){
													count1++;	
												%>
												<tr>
													<td class="tdclass"><%=count1%> )</td> 
													<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
														<input type="hidden" name="empid" value="<%=obj[5]%>,CW,<%=obj[3]%>,<%=obj[11]%>">
														<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
													</td>						
												</tr>
															
												<% }
												}%>
											</tbody>
			
									
									</table>						
									<br>	
								<%} %>	
								</div>
							
								
								<%if(committeeallmemberlist.size()>(count+count1)){ %>
								
									<div  class="col-md-4">
									
									<h5>External Member (Outside DRDO)</h5>
										<hr>						
									 <table border='0'>
									 	
									 	<tbody>
											<%int count2 = 0;
												for(int i=0;i<committeeallmemberlist.size();i++){
													Object[] obj=committeeallmemberlist.get(i);
													if(obj[8].toString().equalsIgnoreCase("CO")){
													count2++;	
												%>
												<tr>
													<td class="tdclass"><%=count2%> )</td> 
													<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
														<input type="hidden" name="empid" value="<%=obj[5]%>,CO,<%=obj[3]%>,<%=obj[11]%>">
														<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
													</td>						
																																										
												</tr>
															
												<% }
												}%>
										</tbody>
			
										
									</table>						
									<br>	
									
								</div>
								<%} %>
								
								<%if(ccmFlag==null || (ccmFlag!=null && !ccmFlag.equalsIgnoreCase("Y"))) {%>								
								<!-- Prudhvi - 27/03/2024 start-->
								<%if(committeeallmemberlist.size()>(count+count1)){ %>
								
									<div  class="col-md-4">
									
									<h5>Industry Partner</h5>
										<hr>						
									 <table border='0'>
									 	
									 	<tbody>
											<%int count2 = 0;
												for(int i=0;i<committeeallmemberlist.size();i++){
													Object[] obj=committeeallmemberlist.get(i);
													if(obj[8].toString().equalsIgnoreCase("CIP")){
													count2++;	
												%>
												<tr>
													<td class="tdclass"><%=count2%> )</td> 
													<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>, <%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> (<%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%>)
														<input type="hidden" name="empid" value="<%=obj[5]%>,CIP,<%=obj[3]%>,<%=obj[11]%>">
														<input type="hidden" name="Labcode" value="<%=obj[9] %>" />
													</td>						
																																										
												</tr>
															
												<% }
												}%>
										</tbody>
			
										
									</table>						
									<br>	
									
								</div>
								<%} %>
								<!-- Prudhvi - 27/03/2024 end-->
								<%} %>
								
							</div>
							<div class="row">
								<div class="col-md-6">
										
									<h5>Agenda Presenters</h5>
									<hr><br>
										
									<table border='0'>
									<tr>
										<th>&emsp; &emsp;</th>
										<th><label class="control-label">Agenda Item</label></th><th>&emsp; &emsp;</th>
										<th><label class="control-label">Presenter</label></th>
									</tr>
										<%
											if(agendalist!=null && agendalist.size()>0) {
											int count4 = 1;
											for (Object[] obj : agendalist) {
										%>
									<tr>
										<td>
											<label class="control-label"> <%=count4%>)</label>
										</td>
										<td>
											<label class="control-label"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %> </label>
										</td>
										<td>
											&emsp; :&emsp;
										</td>
										<td>
											<%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - "%>, <%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - "%> (<%=obj[14]!=null?StringEscapeUtils.escapeHtml4(obj[14].toString()): " - "%>) 
											<input type="hidden" name="empid" value="<%=obj[9]%>,P,<%=obj[13] %>">
											<input type="hidden" name="Labcode" value="<%=obj[14] %>" />	
										</td>
											
									</tr>
									<%	count4++; }	%>
									<%} else if(agendaList!=null && agendaList.size()>0) { 
										int count4 = 1;
										for (Object[] obj : agendaList) {
											if(obj[6]!=null && !obj[6].toString().equalsIgnoreCase("0")) {
									%>
									<tr>
										<td>
											<label class="control-label"> <%=count4%>)</label>
										</td>
										<td>
											<label class="control-label"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %> </label>
										</td>
										<td>
											&emsp; :&emsp;
										</td>
										<td>
											
												<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %>
											 (<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%>) 
											<input type="hidden" name="empid" value="<%=obj[6]%>,P,<%=obj[10] %>">
											<input type="hidden" name="Labcode" value="<%=obj[5] %>" />	
										</td>
											
									</tr>
									<%count4++;} } }%>
								</table>
												
							</div>
					</div>
					
					
						
	
					
					   	<div class="row">
					   		<div class="col-md-12">		   			   			
					   			<div  align="center">
				   					
					            	<button type="submit" id="submit" class="btn  btn-sm submit" onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button>
					            	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="committeescheduleid" value="<%=committeescheduleid%>">
									<input type="hidden" name="Committeeidmainid" value="<%=committeemainid%>">
									<input type="hidden" name="ccmFlag" value="<%=ccmFlag%>">
									<input type="hidden" name="inviteFlag" value="Y">
									<button class="btn btn-info btn-sm  shadow-nohover back" type="button" onclick="submitForm('backfrm1');">Back</button>
								</div>
							</div>
						</div>	  
					</div>
				</div>
			</div>
		</div>        			
	 </div> 
</form>						<%if(ccmFlag!=null && ccmFlag.equalsIgnoreCase("Y")) {%>
		          				<form method="post" action="CCMSchedule.htm" id="backfrm1" >
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="ccmScheduleId" value="<%=committeescheduleid %>">
									<input type="hidden" name="committeeMainId" value="<%=committeemainid %>">
									<input type="hidden" name="committeeId" value="<%=committeeId %>">
									<!-- <button class="btn btn-info btn-sm  shadow-nohover back" formaction="CommitteeScheduleView.htm">Back</button> -->
								</form> 
	          				
	          				<%} else{%>
		          				<form method="post" action="CommitteeScheduleView.htm" id="backfrm1" >
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="scheduleid" value="<%=committeescheduleid %>">
								</form> 
	          				<%} %>	
	          				 			
	      					




<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>

</body>

</html>