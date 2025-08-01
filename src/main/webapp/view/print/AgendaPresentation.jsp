<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.net.Inet4Address"%>
<%@page import="com.vts.pfms.Zipper"%>
<%@page import="java.math.MathContext"%>
<%@page import="com.vts.pfms.model.TotalDemand"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.vts.pfms.committee.model.Committee"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="com.vts.pfms.print.model.TechImages"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.AESCryptor"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.text.Format"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="shortcut icon" type="image/png"
	href="view/images/drdologo.png">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />

<title>PMS - Presentation</title>

<meta charset="ISO-8859-1">

</head>
<body style="background-color: #F9F2DF66;">
	<%
		FormatConverter fc = new FormatConverter();
		SimpleDateFormat sdf = fc.getRegularDateFormat();
		SimpleDateFormat sdf1 = fc.getSqlDateFormat();
		List<String> SplCommitteeCodes=(List<String>) request.getAttribute("SplCommitteeCodes");
	
		Object[] projectattributes = (Object[]) request.getAttribute("projectattributes");
		Object[] committeeMetingsCount =  (Object[]) request.getAttribute("committeeMetingsCount");
		Object[] scheduledata =  (Object[]) request.getAttribute("scheduledata");
	
		List<Object[]> AgendaList =  (List<Object[]>) request.getAttribute("AgendaList");
		List<Object[]> AgendaDocList =  (List<Object[]>) request.getAttribute("AgendaDocList");
		
		LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
		String lablogo = (String)request.getAttribute("lablogo");
		String Drdologo = (String)request.getAttribute("Drdologo");
		Committee committeeData = (Committee) request.getAttribute("committeeData");
		
		String scheduleid = scheduledata[6].toString();
		String committeeid = scheduledata[0].toString();
		String CommitteeCode = committeeData.getCommitteeShortName().trim();
		String CommitteeName = committeeData.getCommitteeName().trim();
		String projectid = scheduledata[9].toString();
		String scheduletype = scheduledata[26]!=null?scheduledata[26].toString():"N";
		
		String ProjectCode="General";
				if(projectattributes!=null){
					ProjectCode=projectattributes[0].toString();
				}
				
		String MeetingNo = CommitteeCode+" #"+(Long.parseLong(committeeMetingsCount[1].toString())+1);
		
		
		List<Object[]> decesions =  (List<Object[]>) request.getAttribute("decesions");
		List<Object[]> recommendationList =  (List<Object[]>) request.getAttribute("recommendationList");
		List<Object[]> ActionDetails =  (List<Object[]>) request.getAttribute("ActionDetails");
		List<Object[]> meetingsHeld =  (List<Object[]>) request.getAttribute("meetingsHeld");
		List<Object[]> OpenActionDetails = new ArrayList<>();
		List<Object[]> closeActionDetails = new ArrayList<>();
		
		if(ActionDetails!=null && ActionDetails.size()>0){
			OpenActionDetails = ActionDetails.stream().filter(e->!e[3].toString().equalsIgnoreCase("C")).collect(Collectors.toList());
			closeActionDetails = ActionDetails.stream().filter(e->e[3].toString().equalsIgnoreCase("C")).collect(Collectors.toList());
		}
		
	%>


	<div id="presentation-slides" class="carousel slide"
		data-ride="carousel">

		<div class="carousel-inner" align="center">

			<!-- ---------------------------------------- P-1  Div ----------------------------------------------------- -->
			<div class="carousel-item active">

				<div class="content" align="center"
					style="height: 93vh !important; padding-top: 15px;">

					<div class="firstpage">

						<div align="center">
							<h2
								style="color: #145374 !important; font-family: 'Muli' !important">Presentation</h2>
						</div>
						<div align="center">
							<h3 style="color: #145374 !important">for</h3>
						</div>

						<div align="center">
							<h3 style="color: #4C9100 !important"><%=CommitteeName %>
								#<%=Long.parseLong(committeeMetingsCount[1].toString())+1 %>
								Meeting
							</h3>
						</div>

						<div align="center">
							<h3 style="color: #4C9100 !important">
								<%if(projectattributes!=null){%>
								<%= projectattributes[1] %>
								(<%= projectattributes[0] %>)
								<%}%>
							</h3>
						</div>

						<table class="executive home-table"
							style="align: center; margin-left: auto; margin-right: auto; border: 0px; font-size: 16px;">
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;">
									<img class="logo" style="width: 120px; height: 120px;"
									<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
									alt="Logo" <%}else{ %> alt="File Not Found" <%} %>> <br>
								</th>

							</tr>
						</table>

						<table style="align: center; width: 650px;">
							<tr style="margin-top: 10px">
								<th
									style="text-align: center; font-size: 18px; border: 0px !important;">
									<u>Meeting Id </u>
								</th>
							</tr>
							<tr>
								<th
									style="text-align: center; font-size: 18px; border: 0px !important;">
									<%=scheduledata[11] %>
								</th>
							</tr>
						</table>
						<table style="align: left; width: 650px;">
							<tr>
								<th
									style="text-align: center; width: 50%; font-size: 18px; border: 0px !important;">
									<u> Meeting Date </u>
								</th>
								<th
									style="text-align: center; width: 50%; font-size: 18px; border: 0px !important;"><u>
										Meeting Time </u></th>
							</tr>
							<tr>
								<%-- <%LocalTime starttime = LocalTime.parse(LocalTime.parse(nextMeetVenue[3].toString(),DateTimeFormatter.ofPattern("HH:mm:ss")).format( DateTimeFormatter.ofPattern("HH:mm") ));   %> --%>
								<td
									style="text-align: center; width: 50%; font-size: 18px; padding-top: 5px; border: 0px !important;">
									<b><%=sdf.format(sdf1.parse(scheduledata[2].toString()))%></b>
								</td>
								<td
									style="text-align: center; width: 50%; font-size: 18px; padding-top: 5px; border: 0px !important;">
									<b><%=scheduledata[3]/* starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) */%></b>
								</td>
							</tr>
						</table>
						<table style="align: center; width: 650px;">
							<tr style="margin-top: 10px">
								<th
									style="text-align: center; font-size: 18px; border: 0px !important;">
									<u>Meeting Venue</u>
								</th>
							</tr>
							<tr>
								<th
									style="text-align: center;; font-size: 18px; border: 0px !important;">
									<% if(scheduledata[12]!=null){ %><%=scheduledata[12] %> <%}else{ %>
									- <%} %>
								</th>
							</tr>
						</table>

						<table class="executive home-table"
							style="align: center; margin-bottom: 5px; margin-left: auto; margin-right: auto; border: 0px; font-size: 16px;">
							<% if(labInfo!=null){ %>
							<tr>
								<th colspan="8"
									style="text-align: center; font-weight: 700; font-size: 22px">
									<%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %>
									<%}else{ %>LAB NAME<%} %>
								</th>
							</tr>
							<%}%>
							<tr>
								<th colspan="8"
									style="text-align: center; font-weight: 700; font-size: 15px"><br>Government
									of India, Ministry of Defence</th>
							</tr>
							<tr>
								<th colspan="8"
									style="text-align: center; font-weight: 700; font-size: 15px">Defence
									Research & Development Organization</th>
							</tr>
							<tr>
								<th colspan="8"
									style="text-align: center; font-weight: 700; font-size: 15px">
									<%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %>
									, <%=labInfo.getLabCity() %>
									<%}else{ %>LAB ADDRESS<%} %>
								</th>
							</tr>
						</table>


					</div>

				</div>

			</div>
			<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->


			<!-- ---------------------------------------- P-2  Div ----------------------------------------------------- -->

			<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>Agenda</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">




					<% if(Long.parseLong(projectid)>0  && SplCommitteeCodes.contains(CommitteeCode)){ %>
					<div class="row" style="float: right;">
						<form action="#" method="post" id="myfrm" target="_blank"
							style="float: right; margin-right: 25px; padding: 5px;">

							<% if(scheduledata[23].toString().equalsIgnoreCase("Y")){%>
							<input type="submit" class="btn btn-sm back"
								formaction="MeetingBriefingPaper.htm" value="Briefing"
								formmethod="get" data-toggle="tooltip" data-placement="bottom"
								title="Briefing Paper">
							<%}%>

							<button type="submit" class="btn btn-sm "
								style="background-color: #96D500;"
								formaction="BriefingPresentation.htm" formmethod="post"
								formtarget="_blank" data-toggle="tooltip"
								data-placement="bottom" title="Presentation">
								<img src="view/images/presentation.png"
									style="width: 19px !important">
							</button>
							<input type="hidden" name="scheduleid" value="<%=scheduleid%>">
							<input type="hidden" name="committeeid" value="<%=committeeid%>">
							<input type="hidden" name="projectid" value="<%=projectid %>">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
					<% } %>


					<table
						class="table table-bordered table-hover table-striped table-condensed "
						style="margin-top: 10px; width: 100%">
						<thead>
							<tr>
								<th style="width: 5%;">SN</th>
								<th style="width: 22%;">Agenda Item</th>
								<!-- 	<th style="width: 15%;">Reference</th>
			                       	<th style="width: 10%;">Remarks</th> -->
								<th style="width: 24%;">Presenter</th>
								<th style="width: 14%;">Duration</th>
								<th style="width: 10%;">Attachment</th>
								<%if(scheduletype.equalsIgnoreCase("P")) {%>
									<th width="10%">Present</th>
								<%} %>
							</tr>
						</thead>
						<tbody>
							<%LocalTime starttime = LocalTime.parse(LocalTime.parse(scheduledata[3].toString(),DateTimeFormatter.ofPattern("HH:mm:ss")).format( DateTimeFormatter.ofPattern("HH:mm") ));  %>
							<%	int count=0;
								for(Object[] 	obj:AgendaList){ count++;%>
							<tr>

								<td style="text-align: center;"><%=count%></td>
								<td><%=obj[3] %></td>
								<%-- <td><%=obj[4] %>  </td>									
									<td><%=obj[6] %></td> --%>
								<td><%=obj[10]%>,  <%=obj[11] %></td>
								<td style="text-align: center;"><%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %>
									- <%=starttime.plusMinutes(Long.parseLong(obj[12].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
									<%starttime=starttime.plusMinutes(Long.parseLong(obj[12].toString()) /* + 1 */); %>

								</td>
								<td>
							 			<table>
											<%for(Object[] doc : AgendaDocList) { 
											if(obj[0].toString().equalsIgnoreCase(doc[1].toString())){%>
												<tr>
													<td><%=doc[3] %></td>
													<td style="width:1% ;white-space: nowrap;" ><a href="AgendaDocLinkDownload.htm?filerepid=<%=doc[2]%>" target="blank"><i class="fa fa-download" style="color: green;" aria-hidden="true"></i></a></td>
												<tr>													
											<%} }%>
										</table>
									</td> 
								<%if(scheduletype.equalsIgnoreCase("P")) {%>	
									<td>
										<form action="#" method="post" id="myfrm_<%=count %>" target="_blank"
											style="float: right; margin-right: 25px; padding: 5px;">
				
											<% if(scheduledata[23].toString().equalsIgnoreCase("Y")){%>
												<input type="submit" class="btn btn-sm back" 
												formaction="MeetingBriefingPaper.htm" value="Briefing" formmethod="get" data-toggle="tooltip" 
												data-placement="bottom" title="Briefing Paper">
											<%}%>
				
											<button type="submit" class="btn btn-sm " style="background-color: #96D500;"
												formaction="BriefingPresentation.htm" formmethod="post" formtarget="_blank" data-toggle="tooltip"
												data-placement="bottom" title="Presentation">
												<img src="view/images/presentation.png" style="width: 19px !important">
											</button>
											<input type="hidden" name="scheduleid" value="<%=scheduleid%>">
											<input type="hidden" name="committeeid" value="<%=committeeid%>">
											<input type="hidden" name="projectid" value="<%=obj[5] %>">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</td>
								<%} %>
							</tr>

							<%} %>
						</tbody>
					</table>
				</div>

			</div>

			<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>Previous Meetings</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">
					<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-3">
					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
								<thead>
								<tr>
								<th  style="width: 140px; ">Committee</th>
								<th  style="width: 140px; "> Date Held</th>
								</tr>
							</thead>
						<tbody>
						<% 
						int meetingCount=0;
						if( meetingsHeld !=null && meetingsHeld.size()>0) {
						for(Object[]obj:meetingsHeld.stream().limit(15).collect(Collectors.toList()) ){
						%>
						<tr>
						<td> 
						<%if(!obj[3].toString().equalsIgnoreCase("0")){ %>
						 <a target="blank" href="CommitteeMinutesNewDownload.htm?committeescheduleid=<%=obj[0].toString() %>"><%=obj[7].toString()+"#"+(++meetingCount) %> </a> 
						<%}else{ %>
				<a target="blank" href="CommitteeMinutesViewAllDownload.htm?committeescheduleid=<%=obj[0].toString() %>"><%=obj[7].toString()+"#"+(++meetingCount) %> </a> 
						
						<%} %>
						</td>
						<td style="text-align: center;"> <%= sdf.format(sdf1.parse(obj[2].toString()))%> </td>
						</tr>
						<%} %>
						<%}else{ %>
						<tr>
						<td colspan="2" style="text-align: center;" >No Meetings Held !</td>
						</tr>
						<%} %>
						</tbody>


					</table>
					</div>
					<% if( meetingsHeld !=null && meetingsHeld.stream().skip(10).collect(Collectors.toList()).size()>0) {%>
					<div class="col-md-3">
					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
								<thead>
								<tr>
								<th  style="width: 140px; ">Committee</th>
								<th  style="width: 140px; "> Date Held</th>
								</tr>
							</thead>
						<tbody>
						<%for(Object[]obj:meetingsHeld.stream().skip(15).collect(Collectors.toList()) ){
						%>	
						<tr>
						<td>
											<%
											if (!obj[3].toString().equalsIgnoreCase("0")) {
											%> <a
											target="blank"
											href="CommitteeMinutesNewDownload.htm?committeescheduleid=<%=obj[0].toString()%>"><%=obj[7].toString() + "#" + (++meetingCount)%>
										</a> <%
											 } else {
											 %> <a target="blank"
											href="CommitteeMinutesViewAllDownload.htm?committeescheduleid=<%=obj[0].toString()%>"><%=obj[7].toString() + "#" + (++meetingCount)%>
										</a> <%} %>
										</td>
						<td style="text-align: center;"> <%= sdf.format(sdf1.parse(obj[2].toString()))%> </td>
						</tr>
						<%} %>
						
						</tbody>


					</table>
					</div>
					<%} %>
					<div class="col-md-3"></div>
					</div>
				</div>

			</div>


			<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>Open Action Points From Previous Meetings</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">

					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="">
									<p style="font-size: 12px; text-align: center">
									
										<span class="assigned">AA</span> : Activity Assigned
										&nbsp;&nbsp; <span class="ongoing">OG</span> : On Going
										&nbsp;&nbsp; <span class="delay">DO</span> : Delay - On Going
										&nbsp;&nbsp; <span class="delay">FD</span> : Forwarded With
										Delay &nbsp;&nbsp;<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
									</p>
								</td>

							</tr>
							<tr>
								<th class="std" style="width: 20px;">SN</th>
								<th class="std" style="width: 60px;">Action No</th>
								<th class="std" style="width: 300px;">Action Point</th>
								<th class="std" style="width: 100px;">PDC</th>
								<th class="std" style="width: 80px;">Progress</th>
								<th class="std" style="width: 100px;">Responsibility</th>
								<th class="std" style="width: 70px;">Status<!-- (DD) --></th>
							</tr>
						</thead>

						<tbody>
							<%if(OpenActionDetails.size()>0) { %>
							<%int count1=0;String key="";;
								for(Object[]obj:OpenActionDetails){ %>
							<tr>
								<td class="std" align="center"
									style="padding: 5px; text-align: center;"><%=++count1 %>.
								</td>
								<td class="std"
									style="text-align: center; padding: 2px; font-weight: 600">
							<button class="btn btn-sm" style="text-align: justify; padding: 4px; font-weight: 600"  onclick="ActionDetails( <%=obj[0] %>);" ><%=obj[1] %> </button>		
								</td>
								<td class="std" style="text-align: justify; padding: 2px">
									<%=obj[5].toString() %>
								</td>
								<td class="std" style="text-align: center;"><%=sdf.format(sdf1.parse(obj[10].toString())) %></td>
								<td class="std" style="font-size: 14px;text-align: center;"><%=obj[13].toString() %></td>
								<td class="std" style="font-size: 14px;"><%=obj[2].toString() %></td>
								<td class="std">
									<%if(obj[4]!= null){ %> <%	String actionstatus = obj[3].toString();
														int progress = obj[13]!=null ? Integer.parseInt(obj[13].toString()) : 0;
														LocalDate pdcorg = LocalDate.parse(obj[10].toString());
														LocalDate lastdate = obj[14]!=null ? LocalDate.parse(obj[14].toString()): null;
														LocalDate today = LocalDate.now();
													%> <%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
									<span class="ongoing">RC</span> <%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
									<span class="delay">FD</span> <%}else if((pdcorg.isAfter(today) || pdcorg.isEqual(today)) && progress>0){  %>
									<span class="ongoing">OG</span> <%}else if(pdcorg.isBefore(today) && progress>0){  %>
									<span class="delay">DO <%-- (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  --%>
								</span> <%}else if( progress==0) {%> <span class="assigned">AA</span> <%} %>
									<%}else { %> <span class="notassign">NA</span> <%} %>



								</td>
							</tr>
							<% }%>
							<%}else{ %>
							<tr>
								<td colspan="6" style="text-align: center;">No Data
									Available</td>
							</tr>
							<%} %>
						</tbody>

					</table>






				</div>

			</div>



			<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>Close Action Points From Previous Meetings</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">

					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="">
									<p style="font-size: 12px; text-align: center">
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; <span
											class="completeddelay">CD</span> : Completed with Delay
										&nbsp;&nbsp;
									</p>
								</td>

							</tr>
							<tr>
								<th class="std" style="width: 20px;">SN</th>
								<th class="std" style="width: 60px;">Action No</th>
								<th class="std" style="width: 300px;">Action Point</th>
								<th class="std" style="width: 100px;">PDC</th>
								<th class="std" style="width: 80px;">Progress</th>
								<th class="std" style="width: 100px;">Responsibility</th>
								<th class="std" style="width: 70px;">Status<!-- (DD) --></th>
							</tr>
						</thead>

						<tbody>
							<%if(closeActionDetails  .size()>0) { %>
							<%int count1=0;String key="";;
								for(Object[]obj:closeActionDetails){ %>
							<tr>
								<td class="std" align="center"
									style="padding: 5px; text-align: center;"><%=++count1 %>.
								</td>
									<td class="std"
									style="text-align: center; padding: 2px; font-weight: 600">
							<button class="btn btn-sm" style="text-align: justify; padding: 2px; font-weight: 600"  onclick="ActionDetails( <%=obj[0] %>);" ><%=obj[1] %> </button>		
								</td>
								<td class="std" style="text-align: justify; padding: 2px">
									<%=obj[5].toString() %>
								</td>
								<td class="std"><%=sdf.format(sdf1.parse(obj[10].toString())) %></td>
								<td class="std" style="font-size: 14px;text-align: center;"><%=obj[13].toString() %></td>
								<td class="std" style="font-size: 14px;"><%=obj[2].toString() %></td>
								<td class="std">
									<%if(obj[4]!= null){ %> <%	String actionstatus = obj[3].toString();
														int progress = obj[13]!=null ? Integer.parseInt(obj[13].toString()) : 0;
														LocalDate pdcorg = LocalDate.parse(obj[10].toString());
														LocalDate lastdate = obj[14]!=null ? LocalDate.parse(obj[14].toString()): null;
														LocalDate today = LocalDate.now();
													%> <% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
									<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
									<span class="completed">CO</span> <%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>
									<span class="completeddelay">CD <%-- (<%= ChronoUnit.DAYS.between(pdcorg, lastdate) %>)  --%></span>
									<%} %> <%}else{ %> <%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
									<span class="ongoing">RC</span> <%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
									<span class="delay">FD</span> <%}else if((pdcorg.isAfter(today) || pdcorg.isEqual(today)) && progress>0){  %>
									<span class="ongoing">OG</span> <%}else if(pdcorg.isBefore(today) && progress>0){  %>
									<span class="delay">DO <%-- (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  --%>
								</span> <%}else if( progress==0) {%> <span class="assigned">AA</span> <%} %>
									<%} %> <%}else { %> <span class="notassign">NA</span> <%} %>



								</td>
							</tr>
							<% }%>
							<%}else{ %>
							<tr>
								<td colspan="6" style="text-align: center;">No Data
									Available</td>
							</tr>
							<%} %>
						</tbody>

					</table>






				</div>

			</div>


			<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>All Action Points From Previous Meetings</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">

					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="">
									<p style="font-size: 12px; text-align: center">
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; <span
											class="completeddelay">CD</span> : Completed with Delay
										&nbsp;&nbsp; <span class="assigned">AA</span> : Activity
										Assigned &nbsp;&nbsp; <span class="ongoing">OG</span> : On
										Going &nbsp;&nbsp; <span class="delay">DO</span> : Delay - On
										Going &nbsp;&nbsp; <span class="delay">FD</span> : Forwarded
										With Delay &nbsp;&nbsp;<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 

									</p>
								</td>

							</tr>
							<tr>
								<th class="std" style="width: 20px;">SN</th>
								<th class="std" style="width: 60px;">Action No</th>
								<th class="std" style="width: 300px;">Action Point</th>
								<th class="std" style="width: 100px;">PDC</th>
								<th class="std" style="width: 80px;">Progress</th>
								<th class="std" style="width: 100px;">Responsibility</th>
								<th class="std" style="width: 70px;">Status<!-- (DD) --></th>
							</tr>
						</thead>

						<tbody>
							<%if(ActionDetails  .size()>0) { %>
							<%int count1=0;String key="";;
								for(Object[]obj:ActionDetails){ %>
							<tr>
								<td class="std" align="center"
									style="padding: 5px; text-align: center;"><%=++count1 %>.
								</td>
								<td class="std"
									style="text-align: center; padding: 2px; font-weight: 600">
							<button class="btn btn-sm" style="text-align: justify; padding: 2px; font-weight: 600"  onclick="ActionDetails( <%=obj[0] %>);" ><%=obj[1] %> </button>		
								</td>
								<td class="std" style="text-align: justify; padding: 2px">
									<%=obj[5].toString() %>
								</td>
								<td class="std"><%=sdf.format(sdf1.parse(obj[10].toString())) %></td>
								<td class="std" style="font-size: 14px;text-align: center;"><%=obj[13].toString() %></td>
								<td class="std" style="font-size: 14px;"><%=obj[2].toString() %></td>
								<td class="std">
									<%if(obj[4]!= null){ %> <%	String actionstatus = obj[3].toString();
														int progress = obj[13]!=null ? Integer.parseInt(obj[13].toString()) : 0;
														LocalDate pdcorg = LocalDate.parse(obj[10].toString());
														LocalDate lastdate = obj[14]!=null ? LocalDate.parse(obj[14].toString()): null;
														LocalDate today = LocalDate.now();
													%> <% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
									<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
									<span class="completed">CO</span> <%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>
									<span class="completeddelay">CD <%-- (<%= ChronoUnit.DAYS.between(pdcorg, lastdate) %>)  --%></span>
									<%} %> <%}else{ %> <%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
									<span class="ongoing">RC</span> <%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
									<span class="delay">FD</span> <%}else if((pdcorg.isAfter(today) || pdcorg.isEqual(today)) && progress>0){  %>
									<span class="ongoing">OG</span> <%}else if(pdcorg.isBefore(today) && progress>0){  %>
									<span class="delay">DO <%-- (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  --%>
								</span> <%}else if( progress==0) {%> <span class="assigned">AA</span> <%} %>
									<%} %> <%}else { %> <span class="notassign">NA</span> <%} %>



								</td>
							</tr>
							<% }%>
							<%}else{ %>
							<tr>
								<td colspan="6" style="text-align: center;">No Data
									Available</td>
							</tr>
							<%} %>
						</tbody>

					</table>






				</div>

			</div>
			
			
						<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>All  Recommendation  Points From Previous Meetings</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">

					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="">
									<p style="font-size: 12px; text-align: center">
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; <span
											class="completeddelay">CD</span> : Completed with Delay
										&nbsp;&nbsp; <span class="assigned">AA</span> : Activity
										Assigned &nbsp;&nbsp; <span class="ongoing">OG</span> : On
										Going &nbsp;&nbsp; <span class="delay">DO</span> : Delay - On
										Going &nbsp;&nbsp; <span class="delay">FD</span> : Forwarded
										With Delay &nbsp;&nbsp;<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 

									</p>
								</td>

							</tr>
							<tr>
								<th class="std" style="width: 20px;">SN</th>
								<th class="std" style="width: 60px;">Action No</th>
								<th class="std" style="width: 300px;">Action Point</th>
								<th class="std" style="width: 100px;">PDC</th>
								<th class="std" style="width: 80px;">Progress</th>
								<th class="std" style="width: 100px;">Responsibility</th>
								<th class="std" style="width: 70px;">Status<!-- (DD) --></th>
							</tr>
						</thead>

						<tbody>
							<%if(recommendationList  .size()>0) { %>
							<%int count1=0;String key="";;
								for(Object[]obj:recommendationList){ %>
							<tr>
								<td class="std" align="center"
									style="padding: 5px; text-align: center;"><%=++count1 %>.
								</td>
								<td class="std"
									style="text-align: center; padding: 2px; font-weight: 600">
							<button class="btn btn-sm" style="text-align: justify; padding: 2px; font-weight: 600"  onclick="ActionDetails( <%=obj[0] %>);" ><%=obj[1] %> </button>		
								</td>
								<td class="std" style="text-align: justify; padding: 2px">
									<%=obj[5].toString() %>
								</td>
								<td class="std"><%=sdf.format(sdf1.parse(obj[10].toString())) %></td>
								<td class="std" style="font-size: 14px;text-align: center;"><%=obj[13].toString() %></td>
								<td class="std" style="font-size: 14px;"><%=obj[2].toString() %></td>
								<td class="std">
									<%if(obj[4]!= null){ %> <%	String actionstatus = obj[3].toString();
														int progress = obj[13]!=null ? Integer.parseInt(obj[13].toString()) : 0;
														LocalDate pdcorg = LocalDate.parse(obj[10].toString());
														LocalDate lastdate = obj[14]!=null ? LocalDate.parse(obj[14].toString()): null;
														LocalDate today = LocalDate.now();
													%> <% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
									<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
									<span class="completed">CO</span> <%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>
									<span class="completeddelay">CD <%-- (<%= ChronoUnit.DAYS.between(pdcorg, lastdate) %>)  --%></span>
									<%} %> <%}else{ %> <%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
									<span class="ongoing">RC</span> <%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
									<span class="delay">FD</span> <%}else if((pdcorg.isAfter(today) || pdcorg.isEqual(today)) && progress>0){  %>
									<span class="ongoing">OG</span> <%}else if(pdcorg.isBefore(today) && progress>0){  %>
									<span class="delay">DO <%-- (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  --%>
								</span> <%}else if( progress==0) {%> <span class="assigned">AA</span> <%} %>
									<%} %> <%}else { %> <span class="notassign">NA</span> <%} %>



								</td>
							</tr>
							<% }%>
							<%}else{ %>
							<tr>
								<td colspan="6" style="text-align: center;">No Data
									Available</td>
							</tr>
							<%} %>
						</tbody>

					</table>






				</div>

			</div>
			
			
					<div class="carousel-item">

				<div class="content-header row ">

					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>
					<div class="col-md-1" align="left" style="padding-top: 19px;">
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
					</div>
					<div class="col-md-8">
						<h3>All  Decision  Points From Previous Meetings</h3>
					</div>
					<div class="col-md-1" align="right" style="padding-top: 19px;">
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo"
							style="width: 45px; margin-left: 5px; margin-top: -2px;"
							<%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>"
							alt="Logo" <%}else{ %> alt="File Not Found" <%} %>>
					</div>

				</div>

				<div class="content">

					<table class="subtables"
						style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>
					<!-- 		<tr>
								<td colspan="10" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; <span
											class="completeddelay">CD</span> : Completed with Delay
										&nbsp;&nbsp; <span class="assigned">AA</span> : Activity
										Assigned &nbsp;&nbsp; <span class="ongoing">OG</span> : On
										Going &nbsp;&nbsp; <span class="delay">DO</span> : Delay - On
										Going &nbsp;&nbsp; <span class="delay">FD</span> : Forwarded
										With Delay &nbsp;&nbsp;

									</p>
								</td>

							</tr> -->
							<tr>
								<th class="std" style="width: 20px;">SN</th>
								<th class="std" style="width: 300px;">Details</th>
							</tr>
						</thead>
						<tbody>
						<%if(decesions!=null &&  !decesions.isEmpty() ){
						int decCount = 0;
							for(Object[]obj:decesions){	
						%>
						<tr>
						<td style="text-align: center;"><%=++decCount %>.</td>
						<td><%=obj[1].toString() %></td>
						</tr>
						<%}}else{ %>
						<tr>
						<td colspan="2"> No Details Available ! </td>
						</tr>
						<%} %>
						</tbody>

			

					</table>






				</div>

			</div>
			<!-- ----------------------------------------  P-2  Div ----------------------------------------------------- -->


		</div>

		<a class="carousel-control-prev" href="#presentation-slides"
			role="button" data-slide="prev"
			style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
				<i class="fa fa-chevron-left fa-2x" style="color: #000000"
				aria-hidden="true"></i>
		</span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#presentation-slides"
			role="button" data-slide="next"
			style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
				<i class="fa fa-chevron-right fa-2x" style="color: #000000"
				aria-hidden="true"></i>
		</span> <span class="sr-only">Next</span>
		</a>

		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="0"
				class="carousel-indicator active" data-toggle="tooltip"
				data-placement="top" title="Start"><b><i class="fa fa-home"
					aria-hidden="true"></i></b></li>
			<li data-target="#presentation-slides" data-slide-to="1"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="Agenda"><b>1</b></li>
			<li data-target="#presentation-slides" data-slide-to="2"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="Previous Meetings"><b>2</b></li>
			<li data-target="#presentation-slides" data-slide-to="3"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="Open Action Points"><b>3</b></li>
			<li data-target="#presentation-slides" data-slide-to="4"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="Close Action Points"><b>4</b></li>
			<li data-target="#presentation-slides" data-slide-to="5"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="All Action Points"><b>5</b></li>
					<li data-target="#presentation-slides" data-slide-to="6"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="All Recommendation Points"><b>6</b></li>
					<li data-target="#presentation-slides" data-slide-to="7"
				class="carousel-indicator" data-toggle="tooltip"
				data-placement="top" title="All Decesions"><b>7</b></li>
		</ol>
	</div>
	
	
	
	<!--  Action Modal   -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; ">
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title" id="modal_action_no" style="font-weight:700; color: #A30808;"></h5>
						</div>
					</div>
					
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%;">
							<tr>
								<td style="width:20%;padding: 5px;border :0;font-weight: bold;"> Action Item :</td>
								<td class="tabledata" style="width:80%;padding: 5px;word-wrap:break-word;border :0;" colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assign Date :</td>
								<td style="padding: 5px;border :0;" id="modal_action_date"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >PDC :</td>
								<td style="padding: 5px;border :0;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignor :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignor"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignee :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignee"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Final Progress :</td>
								<td style="padding: 5px;border :0;" id="modal_action_progress"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" > Type :</td>
								<td style="padding: 5px;font-weight: bold;color:#A30808 ;border :0;" id="modal_action_type"></td>
							</tr>
							
						</table>
						</form>
						<hr>
						<form action="#" method="get">
						
						<table class="table table-bordered table-hover table-striped table-condensed " id="" style="width: 100%">
							<thead> 
								<tr style="background-color: #055C9D; color: white;">
									<th style="text-align: center;width:5% !important;">SN</th>
									<th style="text-align: center;width:15% !important;">Progress Date</th>
									<th style="text-align: center;width:15% !important;"> Progress</th>
									<th style="width:60% !important;">Remarks</th>
									<th style="text-align: center;width:5% !important;">Download</th>
								</tr>
							</thead>
							<tbody id="modal_progress_table_body">
								
							</tbody>
						</table>
						</form>
					
				</div>
				
			</div>
		</div>
	</div>
		<!--  -->
	<script type="text/javascript">

$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})

$(function () {
$('[data-toggle="tooltip"]').tooltip()
})





function ActionDetails(InAssignId)
{
		$("#modal_progress_table").DataTable().destroy();
		
		$.ajax({		
			type : "GET",
			url : "ActionAssignDataAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_item').html(result[1]);
				$('#modal_action_no').html(result[2]);
				$('#modal_action_date').html(moment(new Date(result[5]) ).format('DD-MM-YYYY'));
				$('#modal_action_PDC').html(moment(new Date(result[6]) ).format('DD-MM-YYYY'));
				$('#modal_action_assignor').html(result[8]);
				$('#modal_action_assignee').html(result[9]);
				
				var InActionType = result[10];
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				var InProgress = '0'
				if(result[4]!=null){
					InProgress=result[4]+'';
				}
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height: 1.5rem !important;">'; 
					progressBar += 		'<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height:1.5rem !important; ">'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: '+InProgress+'%;  " aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
			}
		});
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success :  function(result) {
				var result = JSON.parse(result);
				
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
						{
						htmlStr += '<tr>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						if(result[v][5]=== null)
						{
						htmlStr += '<td class="tabledata" style="text-align: center;">-</td>';
						}
						else
						{
						htmlStr += '<td class="tabledata" style="text-align: center;"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					htmlStr += '<td colspan="5" style="text-align: center;"> Progress Not Updated </td>';
					htmlStr += '</tr>';
				}
				setModalDataTable();
				$('#modal_progress_table_body').html(htmlStr);
				
				
				$('#action_modal').modal('toggle');
			}
		});
	}
	setModalDataTable();
	function setModalDataTable()
	{
		$("#modal_progress_table").DataTable({
			"lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			"pagingType": "simple",
			"pageLength": 5
		});
	}
</script>



</body>
</html>