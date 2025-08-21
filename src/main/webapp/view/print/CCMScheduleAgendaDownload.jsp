<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.committee.model.CommitteeSchedule"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CCM Agenda</title>
<%
CommitteeSchedule ccmSchedule = (CommitteeSchedule) request.getAttribute("ccmScheduleData");
List<Object[]> agendaList = (List<Object[]>) request.getAttribute("agendaList");
%>

<style>

.break{
	page-break-after: always;
} 
 
.left{
	text-align: left;
}

.right{
	text-align: right;
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
 
@page  {             
	size: 820px 1050px;
	margin-top: 49px;
	margin-left: 20px;
	margin-right: 25px;
	margin-buttom: 49px; 	
	
	@bottom-left {          		
	   content: "";
	   margin-bottom: 30px;
	   margin-right: 10px;
	   font-size: 13px;
	}
	          
	@bottom-right  {
	  content: "";
	  margin-bottom: 30px;
	}
	
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
	  content: "<%=ccmSchedule.getMeetingId()!=null?StringEscapeUtils.escapeHtml4(ccmSchedule.getMeetingId()): " - "%>";
	  font-size: 13px;
	  margin-left: 10px;
	}               
          
 }

.agendatable{
	margin-left : 10px;
	margin-right : 10px;
	margin-top : 10px;
	border-collapse : collapse;
	border : 1px solid black;
	width : 100%;
}  

.agendatable th{
	text-align : center;
	font-size: 14px;
	font-size: 1.2rem !important;
}

.agendatable td,th{
	border : 1px solid black;
	padding : 7px;
}

.subagendatable{
	
	border-collapse : collapse;
	border : 1px solid black;
	width : 100%;
}  

.subagendatable th{
	text-align : center;
	font-size: 14px;
}

.subagendatable td,th{
	border : 1px solid black;
	padding : 7px;
}

.agendatable td{
	padding: 7px !important;
}
.agendatable tbody{
	font-size: 1rem !important;
}
   
</style>       
</head>
<body>
	<table class="agendatable" style="">
		<thead style="">  
			<tr>
				<th>SN</th>
				<th>Agenda Item</th>
				<!-- <th>Lab</th> -->
				<th>Presenter</th>
				<th>Duration </th>
				<th>File</th> 
			</tr>
		</thead>
		<tbody>
			<%
				if(agendaList!=null && agendaList.size()>0) {
					LocalTime starttime = LocalTime.parse(ccmSchedule.getScheduleStartTime());
					int  count=0;
				  	for(Object[] level1: agendaList){
						if(level1[2].toString().equalsIgnoreCase("0")) {
							++count;
			%>
				<tr>
					<td class="center" style="width: 5%;"><%=count %></td>
					
					<td style="width: 35%;"><%=level1[4]!=null?StringEscapeUtils.escapeHtml4(level1[4].toString()): " - " %></td>
					
					<%-- <td class="center" style="width: 10%;">
						<%if(level1[5]!=null && !level1[5].toString().equalsIgnoreCase("0")) {%>
							<%=level1[5] %>
						<%} else {%>
							-
						<%} %>
					</td> --%>
						
					<td style="width: 25%;">
						<%if(level1[6]!=null && !level1[6].toString().equalsIgnoreCase("0")) {%>
							<%=level1[9]!=null?StringEscapeUtils.escapeHtml4(level1[9].toString()): " - " %>
						<%} else {%>
							-
						<%} %>
					</td>
					
					<td class="center" style="width: 20%;">
						<%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %> - <%=starttime.plusMinutes(Long.parseLong(level1[7].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
					</td>
					
					<td class="center" style="width: 13%;">
						<%if(level1[8]!=null && !level1[8].toString().isEmpty()) {%>
							<a class="btn btn-sm" href="CCMScheduleAgendaFileDownload.htm?scheduleAgendaId=<%=level1[0] %>&count=<%=count %>&subCount=0" target="_blank">
								Annex-<%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()): " - " %>
               				</a>
						<%} else{%>	
							-
						<%} %>
					</td>
				</tr>
				
				<%
				List<Object[]> agendaList2 = agendaList.stream().filter(e -> level1[0].toString().equalsIgnoreCase(e[2].toString())).collect(Collectors.toList());
				
				if(agendaList2.size()>0) {
					LocalTime substarttime = starttime ;
				%>
				
					<tr>
						<td colspan="1"></td>
						<td colspan="8">
							<table style="width:100%;" class="subagendatable" id="subagendatable">
								<tbody>
									<%	int countA=0;
										for(Object[] level2: agendaList2){
												++countA;
									%>
										<tr>
											<%-- <td class="center"><%=level2[3] %></td> --%>
											
											<td style="width: 37.3%;"><%=level2[4]!=null?StringEscapeUtils.escapeHtml4(level2[4].toString()): " - " %></td>
											
											<%-- <td class="center" style="width: 11%;">
												<%if(level2[5]!=null && !level2[5].toString().equalsIgnoreCase("0")) {%>
													<%=level2[5] %>
												<%} else {%>
													-
												<%} %>
											</td> --%>
												
											<td style="width: 27.7%;">
												<%if(level2[6]!=null && !level2[6].toString().equalsIgnoreCase("0")) {%>
													<%=level2[9]!=null?StringEscapeUtils.escapeHtml4(level2[9].toString()): " - " %>
												<%} else {%>
													-
												<%} %>
											</td>
											
											<td class="center" style="width: 22%;">
												<%=substarttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %> - <%=substarttime.plusMinutes(Long.parseLong(level2[7].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
												<%substarttime = substarttime.plusMinutes(Long.parseLong(level2[7].toString())); %>
											</td>
											
											<td class="center" style="width: 13%;">
												<%if(level2[8]!=null && !level2[8].toString().isEmpty()) {%>
													<a class="btn btn-sm" href="CCMScheduleAgendaFileDownload.htm?scheduleAgendaId=<%=level2[0] %>&count=<%=count %>&subCount=<%=countA %>" target="_blank">
														Annex-<%=count %>-<%=countA %>
						               				</a>
												<%} else{%>	
													-
												<%} %>
											</td>
										</tr>
										
									<%} %>
								</tbody>
							</table>
						</td>	
					</tr>	
				<%} %>
				<%starttime=starttime.plusMinutes(Long.parseLong(level1[7].toString())); %>
			<%} } }%>
		</tbody>
	</table>	
</body>
</html>