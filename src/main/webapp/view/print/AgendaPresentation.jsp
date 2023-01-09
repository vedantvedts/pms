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
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />

<title>PMS - Presentation</title>

<meta charset="ISO-8859-1">

</head>
<body style="background-color: #F9F2DF66;">
	<%
		List<String> SplCommitteeCodes=(List<String>) request.getAttribute("SplCommitteeCodes");
	
		Object[] projectattributes = (Object[]) request.getAttribute("projectattributes");
		Object[] committeeMetingsCount =  (Object[]) request.getAttribute("committeeMetingsCount");
		Object[] scheduledata =  (Object[]) request.getAttribute("scheduledata");
	
		List<Object[]> AgendaList =  (List<Object[]>) request.getAttribute("AgendaList");
		List<Object[]> AgendaDocList =  (List<Object[]>) request.getAttribute("AgendaDocList");
		
		LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
		String lablogo=(String)request.getAttribute("lablogo");
		Committee committeeData = (Committee) request.getAttribute("committeeData");
		
		String scheduleid = scheduledata[6].toString();
		String committeeid = scheduledata[0].toString();
		String CommitteeCode = committeeData.getCommitteeShortName().trim();
		String projectid = scheduledata[9].toString();
				
	%>


	<div id="presentation-slides" class="carousel slide"
		data-ride="carousel">

		<div class="carousel-inner" align="center">
			
			<!-- ---------------------------------------- P-1  Div ----------------------------------------------------- -->
			<div class="carousel-item active">

				
				<div class="content" align="center" style="height:93vh !important;padding-top: 50px;">
					
					<div class="firstpage"  > 

						<div align="center" ><h1 style="color: #145374 !important;font-family: 'Muli'!important">Presentation</h1></div>
						<div align="center" ><h2 style="color: #145374 !important">for</h2></div>
							
						<div align="center" >
							<h2 style="color: #4C9100 !important" ><%=CommitteeCode %> #<%=Long.parseLong(committeeMetingsCount[1].toString())+1 %> Meeting </h2>
				   		</div>
						<%if(projectattributes!=null){ %>
						<div align="center" ><h2 style="color: #4C9100 !important"><%= projectattributes[1] %> (<%= projectattributes[0] %>)</h2></div>
						<%} %>
						<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
							<% if(labInfo!=null){  %>
								<tr>			
									<th colspan="8" style="text-align: center; font-weight: 700;">
										<img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
										<br><br>
									</th>
								</tr>
								<tr>
									<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><br><br><%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %></th>
								</tr>
								
							<% } %>
						
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
							</tr>
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
							</tr>
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> <br><br><br></th>
							</tr>
						</table>			
						
					</div>
					
				</div>
				
			</div>
			<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->
			
			
			<!-- ---------------------------------------- P-2  Div ----------------------------------------------------- -->
			
			<div class="carousel-item">

				<div class="content-header  ">
					<h3>Agenda
					
					<form  action="#" method="post" id="myfrm" target="_blank" style="float: right;margin-right: 5px;">
					
					
						<% if(Long.parseLong(projectid)>0  && SplCommitteeCodes.contains(CommitteeCode)){ %>
						
							<% if(scheduledata[23].toString().equalsIgnoreCase("Y")){%>
											
								<input type="submit" class="btn btn-sm back" formaction="MeetingBriefingPaper.htm" value="Briefing" formmethod="get" data-toggle="tooltip" data-placement="bottom" title="Briefing Paper" >
											
							<%}%>
						
							<button type="submit" class="btn btn-sm " style="background-color: #96D500;" formaction="BriefingPresentation.htm"  formmethod="post" formtarget="_blank"  data-toggle="tooltip" data-placement="bottom" title="Presentation"  >
								<img src="view/images/presentation.png" style="width:19px !important">
							</button>
						<% } %>
						<input type="hidden" name="scheduleid" value="<%=scheduleid%>">	
						<input type="hidden" name="committeeid" value="<%=committeeid%>">
						<input type="hidden" name="projectid" value="<%=projectid %>">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					</form>	
								
					
					</h3>
					
				</div>
				
				<div class="content" >
					
		         		<table  class="table table-bordered table-hover table-striped table-condensed " style="margin-top:10px;width:100% ">
			     	      	<thead>
			            		<tr>
			                    	<th style="width: 5%;">SN</th>
			                       	<th style="width: 25%;">Agenda Item</th> 
			                       	<th style="width: 15%;">Reference</th>
			                       	<th style="width: 13%;">Remarks</th>
			                       	<th style="width: 25%;">Presenter</th>
			                       	<th style="width: 7%;">Duration (Mins)</th>
			                       	<th style="width: 10%;">Attachment</th>
			                    </tr>
			              	</thead> 
			              	<tbody>
			              		<%	int count=0;
								for(Object[] 	obj:AgendaList){ count++;%>  
								<tr>
										
									<td style="text-align: center;"><%=count%></td>
									<td><%=obj[3] %></td>
									<td><%=obj[4] %>  </td>									
									<td><%=obj[6] %></td>									
									<td><%=obj[10]%>(<%=obj[11] %>)  </td>
									<td><%=obj[12] %></td>
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
									
								</tr>
							
				    			<%} %>
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

</script>



</body>
</html>