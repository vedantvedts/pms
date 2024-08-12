<%@page import="com.vts.pfms.committee.model.CommitteeSchedule"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="shortcut icon" type="image/png" href="view/images/drdologo.png">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />

<title>Presentation</title>

<meta charset="ISO-8859-1">

</head>
<body style="background-color: #F9F2DF66;">
	<%
		FormatConverter fc = new FormatConverter();
		SimpleDateFormat sdf = fc.getRegularDateFormat();
		SimpleDateFormat sdf1 = fc.getSqlDateFormat();
	
		CommitteeSchedule ccmSchedule = (CommitteeSchedule) request.getAttribute("ccmScheduleData");
		List<Object[]> agendaList =  (List<Object[]>) request.getAttribute("agendaList");
		
		LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
		String lablogo = (String)request.getAttribute("lablogo");
		String drdologo = (String)request.getAttribute("drdologo");
				
	%>


	<div id="presentation-slides" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner" align="center">
			<!-- ---------------------------------------- P-1  Div ----------------------------------------------------- -->
			<div class="carousel-item active">
				<div class="content" align="center" style="height:93vh !important;padding-top: 15px;">
					<div class="firstpage"  > 
						<div align="center" ><h2 style="color: #145374 !important;font-family: 'Muli'!important">Presentation</h2></div>
						<div align="center" ><h3 style="color: #145374 !important">for</h3></div>
							
						<div align="center" >
							<h3 style="color: #4C9100 !important" >Cluster Council Meeting </h3>
				   		</div>
						
						<table class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
							<tr>			
								<th colspan="8" style="text-align: center; font-weight: 700;">
								<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="Image Not Found" <%} %> > 
								<br>
								</th>
								
							</tr>
						</table>	
						
						<table style="align: center;width: 650px;  "  >
							<tr style="margin-top: 10px">
								 <th  style="text-align: center;font-size: 18px;border:0px !important; "> Meeting Id </th></tr><tr>
								 <th  style="text-align: center;font-size: 18px;border:0px !important;  "> <%if(ccmSchedule!=null && ccmSchedule.getMeetingId()!=null) {%> <%=ccmSchedule.getMeetingId() %> <%} else{%>-<%} %> </th>				
							 </tr>
						</table>
						
						<table style="align: left; width: 650px; "  >
							<tr>
								 <th  style="text-align: center; width: 50%;font-size: 18px;border:0px !important; ">  Meeting Date </th>
								 <th  style="text-align: center;  width: 50%;font-size: 18px;border:0px !important;  "> Meeting Time </th>
							</tr>
							<tr>
								 <td  style="text-align: center; width: 50%;font-size: 18px ;padding-top: 5px;border:0px !important;"> <b> <%if(ccmSchedule!=null && ccmSchedule.getScheduleDate()!=null) {%> <%=fc.sdfTordf(ccmSchedule.getScheduleDate().toString()) %> <%} else{%>-<%} %> </b></td>
								 <td  style="text-align: center; width: 50%;font-size: 18px ;padding-top: 5px;border:0px !important; "> <b><%if(ccmSchedule!=null && ccmSchedule.getScheduleStartTime()!=null) {%> <%=ccmSchedule.getScheduleStartTime() %> <%} else{%>-<%} %></b></td>
							</tr>
						</table>
						
						<table style="align: center; width: 650px;"  >
							<tr style="margin-top: 10px">
								 <th  style="text-align: center;font-size: 18px;border:0px !important; "> Meeting Venue</th></tr><tr>
								 <th  style="text-align: center;;font-size: 18px ;border:0px !important; "> <%if(ccmSchedule!=null && ccmSchedule.getMeetingVenue()!=null) {%> <%=ccmSchedule.getMeetingVenue() %> <%} else{%>-<%} %> </th>				
							 </tr>
						</table>
						
						<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
							<% if(labInfo!=null){ %>
								<tr>
									<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %></th>
								</tr>
							<%}%>
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
							</tr>
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
							</tr>
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
							</tr>
						</table>			
					</div>
					
				</div>
				
			</div>
			<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->
			
			
			<!-- ---------------------------------------- P-2  Div ----------------------------------------------------- -->
			
			<div class="carousel-item">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(drdologo!=null ){ %> src="data:image/*;base64,<%=drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:19px;" >
						<b style="margin-left: -35px;"><%="" %></b>
					</div>
					<div class="col-md-8">
						<h3>Agenda</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%="" %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>
				
				<div class="content" >

					<%-- <div class="row" style="float: right;">
						<form  action="#" method="post" id="myfrm" target="_blank" style="float: right;margin-right: 25px;padding: 5px;">
							
							<% if(scheduledata[23].toString().equalsIgnoreCase("Y")){%>
								<input type="submit" class="btn btn-sm back" formaction="MeetingBriefingPaper.htm" value="Briefing" formmethod="get" data-toggle="tooltip" data-placement="bottom" title="Briefing Paper" >
							<%}%>
								
							<button type="submit" class="btn btn-sm " style="background-color: #96D500;" formaction="BriefingPresentation.htm"  formmethod="post" formtarget="_blank"  data-toggle="tooltip" data-placement="bottom" title="Presentation"  >
									<img src="view/images/presentation.png" style="width:19px !important">
							</button>
								<input type="hidden" name="scheduleid" value="<%=scheduleid%>">	
								<input type="hidden" name="committeeid" value="<%=committeeid%>">
								<input type="hidden" name="projectid" value="<%=projectid %>">
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>	
					</div> --%>
							
								
		         	<table class="table table-bordered table-hover table-condensed " style="margin-top:10px;width:100% ">
		     	      	<thead>
		            		<tr>
		            			<th>Expand</th>
		                    	<th style="width: 5%;">SN</th>
		                       	<th style="width: 22%;">Agenda Item</th> 
		                       	<th style="width: 24%;">Presenter</th>
		                       	<th style="width: 14%;">Duration</th>
		                    </tr>
		              	</thead> 
			            <tbody>
		              		<%//LocalTime starttime = LocalTime.parse(LocalTime.parse(scheduledata[3].toString(),DateTimeFormatter.ofPattern("HH:mm:ss")).format( DateTimeFormatter.ofPattern("HH:mm") ));  %>
		              		
			    			<%
								if(agendaList!=null && agendaList.size()>0) {
									LocalTime starttime = LocalTime.parse(ccmSchedule.getScheduleStartTime());
									int  count=0;
								  	for(Object[] level1: agendaList){
										if(level1[2].toString().equalsIgnoreCase("0")) {
											++count;
							%>
								<tr>
									<td class="center" style="width: 3%;">
										<span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button type="button" class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"  data-toggle="tooltip" data-placement="top" title="Expand"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span>
									</td>
									<td class="center" style="width: 5%;"><%=count %></td>
									
									<td style="width: 35%;"><%=level1[4] %></td>
									<td style="width: 25%;">
										<%if(level1[6]!=null && !level1[6].toString().equalsIgnoreCase("0")) {%>
											<%=level1[9] %>
										<%} else {%>
											-
										<%} %>
									</td>
									
									<td class="center" style="width: 10%;">
										<%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %> - <%=starttime.plusMinutes(Long.parseLong(level1[7].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
									</td>
									
								</tr>
		
								<%
								List<Object[]> agendaList2 = agendaList.stream().filter(e -> level1[0].toString().equalsIgnoreCase(e[2].toString())).collect(Collectors.toList());
								
								if(agendaList2.size()>0) {
									LocalTime substarttime = starttime ;
								%>
				
									<tr class="collapse row<%=count %>" id="rowcollapse<%=count%>" >
										<td colspan="1"></td>
										<td colspan="8">
											<table style="width:100%;" class="table table-bordered table-hover table-condensed  subagendatable" id="subagendatable">
												<tbody>
													<%	int countA=0;
														for(Object[] level2: agendaList2){
																++countA;
													%>
														<tr>
															<%-- <td class="center"><%=level2[3] %></td> --%>
															<td class="center" style="width: 6%;"><%=count+"."+countA %></td>
															<td style="width: 44.6%;"><%=level2[4] %></td>
															
															<td style="width: 31.9%;">
																<%if(level2[6]!=null && !level2[6].toString().equalsIgnoreCase("0")) {%>
																	<%=level2[9] %>
																<%} else {%>
																	-
																<%} %>
															</td>
															
															<td class="center" style="width: 17.5%;">
																<%=substarttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %> - <%=substarttime.plusMinutes(Long.parseLong(level2[7].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
																<%substarttime = substarttime.plusMinutes(Long.parseLong(level2[7].toString())); %>
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
				</div>
				
			</div>
	
			<!-- ----------------------------------------  P-2  Div ----------------------------------------------------- -->


		</div>

		<a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a>

		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="0" class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
			<li data-target="#presentation-slides" data-slide-to="1" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="Agenda"><b>1</b></li>
			<li style="background-color:  white;width: 55px;margin-left: 20px;">
				<a target="_blank" href="CCMScheduleAgendaPdfDownload.htm?ccmScheduleId=<%=ccmSchedule.getScheduleId() %>" data-toggle="tooltip" title="Download Agenda" ><i class="fa fa-download fa-2x" style="color: green;" aria-hidden="true"></i></a>	
			</li>
		</ol>
	</div>

<script type="text/javascript">

$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})

$(function () {
$('[data-toggle="tooltip"]').tooltip()
})

/* --------------------- Expand Button Handle for Agenda List--------------------------- */
	function ChangeButton(id) {
		  
		if($("#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
		$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
		$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
		$( ".row"+id).show();
	    }else{
		$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
		$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
		$( ".row"+id).hide();
	    }
	}	
/* --------------------- Expand Button Handle for Agenda List End --------------------------- */
</script>



</body>
</html>