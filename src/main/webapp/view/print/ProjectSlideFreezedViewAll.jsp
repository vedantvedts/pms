<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />
<style type="text/css">
td{
height:15px;
color: #00416A ;
}

span {
	font-size: 1.2rem !important;
	font-weight: bold !important;
}
tr.clickable:hover{
cursor:pointer;
background-color: rgba(247,236,208);
}
</style>

</head>
<body class="slides-container" id="slides-container" style="background-color: #F9F2DF66">
<%
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
String filePath = (String)request.getAttribute("filepath");
List<Object[]> freezedproject = (List<Object[]>)request.getAttribute("getAllProjectSlidedata");
List<Object[]> FreezedSlide = (List<Object[]>)request.getAttribute("getAllProjectSlidesdata"); //status ,  slide , ImageName , path ,SlideId ,attachmentname, brief
List<Object[]> projects = (List<Object[]>)request.getAttribute("getAllProjectdata");
String[] a = new String[projects.size()];
for(int i=0;i<projects.size();i++)
{a[i]=projects.get(i)[0].toString();}
String filepath = (String)request.getAttribute("filepath");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();

FormatConverter fc = new FormatConverter();
%>

<div id="presentation-slides" class="carousel slide " data-ride="carousel">
	<div class="carousel-inner" align="center">
		<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
		<div class="carousel-item active">
				
			<div class="content" align="center" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					
				<div class="firstpage"  > 
	
					<div class="mt-5" align="center"><h2 style="color: #145374 !important;font-family: 'Muli'!important">Presentation</h2></div>
					<div align="center" ><h3 style="color: #145374 !important">of</h3></div>
							
					<div align="center" >
						<h3 style="color: #4C9100 !important" >  <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %> Projects</h3>
			   		</div>
					
					<div align="center" ><h3 style="color: #4C9100 !important"></h3></div>
					
					<table style="margin-top:35px;" class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
						<tr>			
							<th colspan="8" style="text-align: center; font-weight: 700;">
								<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
								<br>
							</th>
						</tr>
					</table>	
					
					<br><br><br><br><br><br><br><br><br>
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
		
			
		<!-- ----------------------------------------  P-0  Div ----------------------------------------------------- -->


		<div class="carousel-item ">
			<div class="content" align="center" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
				<div align="center"><h2 style="color: #145374 !important;font-family: 'Muli'!important">Project Outline</h2></div>
				<div class="card-body shadow-nohover" >
					<div class="">
						<div class="">
							<table style="width: 100%;">
								<thead style="background-color: maroon;color: white;">
									<tr>
										<th style="width: 2%;">SN</th>
										<th style="width: 44%;">Projects</th>
										<!-- <th style="width: 12%;">Cost (In Cr, &#8377)</th> -->
										<th style="width: 8%;">DOS</th>
										<th style="width: 8%;">PDC</th>
										<th style="width: 6%;">Sanction Cost<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Expenditure<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Out Commitment<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Dipl<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Balance<br>(In Cr, &#8377)</th>
									</tr>
								</thead>
								<tbody>
								
									<% if(projects!=null && projects.size()>0) {
										
										for(int i=0;i<projects.size();i++ ){ %>
										<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=2+i%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;">
											<td style="text-align: center;font-weight: bold;"><%=1+i %> </td>
											<td style="font-weight: bold;"  >
													<%if (projects.get(i) != null )
														if(projects.get(i)[1] != null) { %><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
													<%}%>
												</b>
											</td>
											<%-- <td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[3].toString())/10000000) %>
												<%}%>
											</td> --%>
											<td style="font-weight: bold;text-align: center;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[5]!= null) { %>
													<%=fc.SqlToRegularDate(projects.get(i)[5].toString())%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: center;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[4]!= null) { %>
													<%=fc.SqlToRegularDate(projects.get(i)[4].toString())%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[3].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[16]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[16].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[17]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[17].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[18]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[18].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[19]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[19].toString())/10000000)%>
												<%}%>
											</td>
										</tr>
									<%} }%>
								</tbody>
					
							</table>
						</div>
					</div>
							
				</div>
			</div>
		</div>


		<!-- ----------------------------------------  Freezed Project Slide ----------------------------------------------------- -->
		<!-- ----------------------------------------- Slide Two ------------------------------------------------------------ -->
		<%if(projects!=null && projects.size()>0 && FreezedSlide!=null){
				for(int i=0;i<projects.size();i++ ){
					if(FreezedSlide.get(i)!=null && projects.get(i)!=null && freezedproject != null){
						if(FreezedSlide.get(i)[1]==null)FreezedSlide.get(i)[1]="1";
						if(FreezedSlide.get(i)[1]!=null ){
							if(FreezedSlide.get(i)[1].toString().equals("2")){%>
								<div class="carousel-item " >
									<div class="container-fluid" >
										<div class="container-fluid"  >
											<div id="slide2" >
								
												<%
												double cost = Double.parseDouble(projects.get(i)[3].toString());
												String enduser = "--";
												if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IA")) {
												enduser = "Indian Army";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IN")) {
												enduser = "Indian Navy";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IAF")) {
												enduser = "Indian Air Force";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IH")) {
												enduser = "Home Land Security";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("DRDO")) {
												enduser = "DRDO";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("OH")) {
												enduser = "Others";
												}
												%>
								
												<div class="content-header row " style="margin-top: 10px; padding: 10px" > 
							 						<div class="col-md-1" align="left" style="padding-top:5px;" >
														<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
													</div>
													<h4 class="card-title col-md-10" align="center">
														<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
														%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
														
														
														
														<%}%>
													</h4>
							 						<div class="col-md-1" align="right" style="padding-top:5px;" >
							 							<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
							 						</div>
												</div>
												<div class="content shadow-nohover" style="padding: 0.25rem;border: 6px solid green;border-radius: 5px !important;height:85vh !important;padding-top: 15px;overflow-x: hidden;" align="center">
													<div class="row" >
														<div class="col-md-12">
												
															<table style="width: 99%;font-weight: bold;margin-left: 0.5%;margin-right: 1%;font-size: 1.2rem;">
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 10%;">Project No :</td>
																	<td colspan="1" style="width: 25%;color: black;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 10%">User :</td>
																	<td colspan="1" style="width: 17%;color: black;"><%=enduser!=null?enduser:"--"%></td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 8%;">Category :</td>
																	<td colspan="1" style="width: 32%;color: black;"><%=projects.get(i)[2]!=null?projects.get(i)[2]:"--"%></td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">DoS :</td>
																	<td colspan="1" style="color: black;"><%=sdf.format(projects.get(i)[5])%></td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Cost (In Cr) :</td>
																	<td colspan="1" style="color: black;"><%=nfc.convert(cost / 10000000)%> </td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">PDC :</td>
																	<td colspan="1" style="color: black;"><%=sdf.format(projects.get(i)[4])%></td>
																</tr>
		
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;vertical-align: top;">Brief :</td>
																	<td colspan="5" style="font-size: 1.2rem;color: black;">
																		<%if(FreezedSlide.get(i)[6]!=null){%>
																			<%=FreezedSlide.get(i)[6]%>
																		<%}else{%>
																			--
																		<%}%>
																	</td>
																</tr>
																<tr>
																	<td colspan="1"><b style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Objectives : </b></td>
																	<td colspan="5"style="color: black;">
																			<%if(projects.get(i)[7]!=null) {%>
																				<%=projects.get(i)[7]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																<tr>
																	<td colspan="1"><b style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Scope : </b></td>
																	<td colspan="5"style="color: black;">
																			<%if(projects.get(i)[9]!=null) {%> 
																				<%=projects.get(i)[9]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Application :</td>
																	<td colspan="5"style="color: black;">
																		<%if (projects.get(i) != null && projects.get(i)[10] != null) {%>
																			<%=projects.get(i)[10]%>
																		<%} else {%> 
																			--
																		 <%}%>
																	</td>
																</tr>
																
																<tr>
																	<td colspan="1"><b style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Deliverables : </b> </td>
																	<td colspan="5"style="color: black;">
																			<%if(projects.get(i)[8]!=null) {%>
																				<%=projects.get(i)[8]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Current Stage : </td>
																	<td colspan="5"style="color: black;">
																		<%if(projects.get(i)[14]!=null){%>
																			<%=projects.get(i)[14]%>
																		<%}else{%>
																			--
																		<%}%>
																	</td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;" >
																		Current Status : 
																	</td>
																	<td colspan="5" style="color: black;">
																	<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																			<%=projects.get(i)[20]%>
																		<%} else{%>-<%} %> 
																	</td>
																</tr>
																
															</table>
													
														</div>
														<!-- <div class="col-md-7">
															<table style="width: 100%;font-weight: bold;vertical-align: top;">
																
																
															</table>
														</div> -->
													</div>
										
													<div class="col-md-12" style="padding-top: 40px">
														<table style="width: 100%;height: 100%;border-style: hidden;">
															<tbody >
																
																<tr  style="border-style: hidden;">
																	<td class="align-middle" style="border-style: hidden;text-align: center;">
																		<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2]).exists()){%>
																		<div style="max-height: 300px; max-width: 600px;margin: auto;">
																		<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[5]).exists()){%>
																			<a  href="SlidePdfOpenAttachDownload.htm?slideId=<%=FreezedSlide.get(i)[4]%>" target="_blank" title="PDF File">
																				<img class=" d-flex justify-content-center" data-enlargable style="max-height: 300px; max-width: 600px; margin-bottom: 5px;margin: auto;" 
																				src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2])))%>">
																			</a>
																		<%}else{ %>
																				<img class=" d-flex justify-content-center" data-enlargable style="max-height: 300px; max-width: 600px; margin-bottom: 5px;margin: auto;" 
																				src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2])))%>">
																			
																			<%} %>
																		</div>
																		<%} else{ %>image<%} %>
																	</td>
																</tr>
																<tr>
																	<td style="text-align: right;">
																	<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[5]).exists()){%>
																		<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=FreezedSlide.get(i)[4]%>" target="_blank" title="PDF File"><b>Show more</b></a>
																	<%} %>
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
									
													<%-- <div class="row" style="margin-top: 10%;">
														<div class="col-md-2" align="left">
															<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[4]%>" target="_blank" title="PDF File"><b>Show more</b></a>
														</div>
													</div> --%>
												</div>
								
											</div>
										</div>
									</div>
								</div>
								<!-- ----------------------------------------- Slide One ------------------------------------------------------------ -->
							<%}} if(FreezedSlide.get(i)!=null && projects.get(i)!=null)if(FreezedSlide.get(i)[1].toString().equals("1")){ %> 
								<div class="carousel-item " >
									<div class="container-fluid" >
										<div>
											<div class="container-fluid"  >
											<div class="" id="slide1">
												<%	double cost = Double.parseDouble(projects.get(i)[3].toString());
												 String enduser="--";
												if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IA")){
													enduser="Indian Army";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IN")){
													enduser="Indian Navy";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IAF")){
													enduser="Indian Air Force";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IH")){
													enduser="Home Land Security";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("DRDO")){
													enduser="DRDO";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("OH")){
													enduser="Others";
												}
												%>
												<div class="content-header row " style="margin-top: 10px; padding: 10px" > 
 					
							 						<div class="col-md-1" align="left" style="padding-top:5px;" >
														<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
													</div>
													<h4 class="card-title col-md-10" align="center"> <%if(projects.get(i)!=null )if( projects.get(i)[1]!=null){%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)  <%}%></h4>
							 						<div class="col-md-1" align="right" style="padding-top:5px;" >
							 							<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
							 						</div>
												</div>
												
												<div class="content" style="padding: 0.25rem;border: 6px solid green;border-radius: 5px !important;height:85vh !important;padding-top: 15px;overflow-x: hidden;" align="center">
													<div class="row" style="">
														<div class="col-md-6">
															<div class="row"><div class="col">
																<table style="width: 100%;font-weight: bold;margin-left: 1%;font-size: 1.2rem">
																	<tr>
																		<td style="font-size: 1.2rem;font-weight: bold; color: #021B79;">Project No :</td>
																		<td style="color: black;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																		<td style="font-size: 1.2rem;width: 10%;font-weight: bold;color: #021B79;">User :</td>
																		<td style="color: black;"><%=enduser%></td>
																	</tr>
																	<tr>
																		<td style="font-size: 1.2rem;font-weight: bold;color: #021B79;">Category :</td>
																		<td style="color: black;"><%=projects.get(i)[2]!=null?projects.get(i)[2]:"--"%></td>
																		<td style="font-size: 1.2rem;font-weight: bold;color: #021B79;">DoS :</td>
																		<td style="color: black;"><%=sdf.format(projects.get(i)[5]) %></td>
																	</tr>
																	<tr>
																		<td style="font-size: 1.2rem;font-weight: bold;color: #021B79;">Cost (In Cr):</td>
																		<td style="color: black;"><%=nfc.convert(cost/10000000)%></td>
																		<td style="font-size: 1.2rem;font-weight: bold;color: #021B79;">PDC :</td>
																		<td style="color: black;"><%=sdf.format(projects.get(i)[4]) %></td>
																	</tr>
																	
																	<tr>
																		<td style="border-top: none;width: 22.6%;vertical-align: top;">
																			<b style="font-size: 1.2rem;font-weight: bold;color: #021B79;"> Brief:</b>
																		</td>
																		<td colspan="3" style="font-size: 1.2rem;border-top: none;vertical-align: top;color: black;">
																			<%if(FreezedSlide.get(i)[6]!=null){%>
																				<%=FreezedSlide.get(i)[6]%>
																			<%}else{%>
																				--
																			<%}%>
																		</td>
																	</tr>
																	<tr>
																		<td>
																			<b style="font-size: 1.2rem;font-weight: bold;color: #021B79;">Objectives : </b>
																		</td>
																		<td colspan="3" style="color: black;"> 
																				<%=projects.get(i)[7]==null?"--":projects.get(i)[7]%> 
																		</td>
																	</tr>
																	<tr>
																		<td>
																			<b style="font-size: 1.2rem;font-weight: bold;color: #021B79;">Scope : </b>
																		</td>
																		<td colspan="3" style="color: black;"> 
																				<%=projects.get(i)[9]==null?"--":projects.get(i)[9]%> 
																		</td>
																	</tr>
																	<tr>
																		<td style="font-size: 1.2rem;font-weight: bold;color: #021B79;">Application :</td>
																		<td colspan="3" style="color: black;">
																		<%if(projects.get(i)!=null && projects.get(i)[10]!=null){%>
																			<%=projects.get(i)[10]%>
																		<%}else{%> 
																			-- 
																		<%}%></td>
																	</tr>
																			
																	<tr>
																		<td>
																			<b style="font-size: 1.2rem;font-weight: bold;color: #021B79;">Deliverables : </b>
																		</td>
																		<td colspan="3" style="color: black;"> 
																				<%=projects.get(i)[8]==null?"--":projects.get(i)[8]%> 
																		</td>
																	</tr>
																	<tr>
																		<td style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
																			Current Stage
																		</td>
																		<td colspan="3" style="color: black;">
																			<%if(projects.get(i)[14]!=null){%>
																				<%=projects.get(i)[14]%>
																			<%}else{%>
																				--
																			<%}%>
																		</td>
																	</tr>
																	<tr>
																		<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;vertical-align: top;" >
																			<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">Current Status : </b> 
																		</td>
																		<td colspan="5" style="font-weight: bold;color:#212529 ">
																		<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																				<%=projects.get(i)[20]%>
																			<%} else{%>-<%} %> 
																		</td>
																	</tr>
																				
																</table>
																
															</div>
														</div>
														<br>
															  	 	
														
														</div>
														<div class="col-md-6">
															<table style="width: 100%;height: 100%;border-style: hidden;">
																<tbody>
																	<tr >
																		<td style="border-bottom: none;text-align: center;">
																			<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2]).exists()){%>
																			<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[5]).exists()){%>
																			<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=FreezedSlide.get(i)[4]%>" style="max-height: 600px; max-width: 1600px;" target="_blank" title="PDF File">
																			<img class=" d-flex justify-content-center mx-auto d-block" data-enlargable style="max-height: 600px; max-width: 1600px;" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2])))%>">
																			</a>
																			<%}else{ %>
																			<img class=" d-flex justify-content-center mx-auto d-block" data-enlargable style="max-height: 600px; max-width: 1600px;" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2])))%>">
																			
																			<%} %>
																			<%} else{%>image<%}%>
																		</td>
																
																	</tr>
																	<tr>
																		<td style="border-top: none;text-align: right;">
																		<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[5]).exists()){%>
																			<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=FreezedSlide.get(i)[4]%>"  target="_blank" title="PDF File"><b>Show more</b></a>
																		<%} %>
																		</td>
																	</tr>
																</tbody>
															</table>
															<br>
							
														</div>
														
													</div>	
												</div>
					
											</div>
					
										</div>	
									</div>
								</div>
							</div>	
						<!-- ----------------------------------------- Slide Three - No Data ------------------------------------------------------------ -->
						<%}}else{%>
							
							<div class="carousel-item " >
									<div class="container-fluid" >
										<div class="container-fluid"  >
											<div id="slide2" >
								
												<%
												double cost = Double.parseDouble(projects.get(i)[3].toString());
												String enduser = "--";
												if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IA")) {
												enduser = "Indian Army";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IN")) {
												enduser = "Indian Navy";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IAF")) {
												enduser = "Indian Air Force";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IH")) {
												enduser = "Home Land Security";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("DRDO")) {
												enduser = "DRDO";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("OH")) {
												enduser = "Others";
												}
												%>
								
												<div class="content-header row " style="margin-top: 10px; padding: 10px" > 
	 					
							 						<div class="col-md-1" align="left" style="padding-top:5px;" >
														<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
													</div>
													<h4 class="card-title col-md-10" align="center">
														<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
														%><%=projects.get(i)[1]%> (<%=projects.get(i)[12]%>)
														<%}%>
													</h4>
							 						<div class="col-md-1" align="right" style="padding-top:5px;" >
							 							<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
							 						</div>
												</div>
												<div class="content shadow-nohover" style="padding: 0.25rem;;border: 6px solid green;border-radius: 5px !important;height:85vh !important;padding-top: 15px;overflow-x: hidden;" align="center">
													<div class="row" >
														<div class="col-md-12">
												
															<table style="width: 99%;font-weight: bold;margin-left: 0.5%;margin-right: 1%;font-size: 1.2rem;">
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 10%;">Project No :</td>
																	<td colspan="1" style="width: 25%;color: black;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 8%;">User :</td>
																	<td colspan="1" style="width: 27%;color: black;"><%=enduser%></td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 8%;">Category :</td>
																	<td colspan="1" style="width: 32%;color: black;"><%=projects.get(i)[2]!=null?projects.get(i)[2]:"--"%></td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">DoS :</td>
																	<td colspan="1" style="color: black;"><%=sdf.format(projects.get(i)[5])%></td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Cost (In Cr):</td>
																	<td colspan="1" style="color: black;"><%=nfc.convert(cost / 10000000)%> </td>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">PDC :</td>
																	<td colspan="1" style="color: black;"><%=sdf.format(projects.get(i)[4])%></td>
																</tr>
		
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Brief :</td>
																	<td colspan="5" style="font-size: 1.2rem;color: black;">
																		--
																	</td>
																</tr>
																<tr>
																	<td colspan="1"><b style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Objectives : </b></td>
																	<td colspan="5" style="color: black;">
																	 <%if(projects.get(i)[7] != null && projects.get(i)[7].toString().length() > 320) {%>
																		<%=projects.get(i)[7].toString().substring(0, 280)%>
																	<%} else {%> 
																		<%=projects.get(i)[7]!=null?projects.get(i)[7]:"--"%> 
																	<%}%>
																	</td>
																</tr>
																<tr>
																	<td colspan="1">
																		<b style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Scope : </b>
																	</td>
																	<td colspan="5" style="color: black;">
																		<%if (projects.get(i)[9] != null && projects.get(i)[9].toString().length() > 600) {%>
																			<%=projects.get(i)[9].toString().substring(0, 600)%>
																		<%} else {%> 
																			<%=projects.get(i)[9]!=null?projects.get(i)[9]:"--"%> 
																		<%}%>
																	</td>
																</tr>
																
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Application :</td>
																	<td colspan="5" style="color: black;">
																		<%if (projects.get(i) != null && projects.get(i)[10] != null) {%>
																			<%=projects.get(i)[10]%>
																		<%} else {%>
																			-- 
																		<%}%>
																	</td>
																</tr>
																
																<tr>
																	<td colspan="1"><b style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Deliverables : </b> </td>
																	<td colspan="5" style="color: black;">
																		<% if (projects.get(i)[8] != null && projects.get(i)[8].toString().length() > 320) {%>
																			<%=projects.get(i)[8].toString().substring(0, 280)%>
																		<%} else {%> 
																			<%=projects.get(i)[8]!=null?projects.get(i)[8]:"--"%> 
																		<% } %>
																	</td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Current Stage :</td>
																	<td colspan="5" style="color: black;">
																		<%if(projects.get(i)[14]!=null){%>
																			<%=projects.get(i)[14]%>
																		<%}else{%>
																			--
																		<%}%>
																	</td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;" >
																		Current Status : 
																	</td>
																	<td colspan="5" style="color: black;">
																	<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																			<%=projects.get(i)[20]%>
																		<%} else{%>-<%} %> 
																	</td>
																</tr>
																
															</table>
													
														</div>
													</div>
										
													<div class="col-md-12" style="padding-top: 40px">
														<table style="width: 100%;border-style: hidden;border: none;border-style: hidden;padding: 10px;">
															<tbody style="border: none;" >
																
																<tr style="border-style: hidden;">
																	<td class="align-middle" style="border-style: hidden;text-align: center;vertical-align: middle;color: red;">
																		Image
																	</td>
																</tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;">
																	<td style="text-align: right;vertical-align: bottom;color: red;">
																		Show more
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
								
											</div>
										</div>
									</div>
								</div>
							
							
						<%}}}else{%><%} %>
			
							<!-- ----------------------------------------  Freezed Project Slide ----------------------------------------------------- -->
		
							<!-- ----------------------------------------  Thank you Div ----------------------------------------------------- -->

							<div class="carousel-item " >
				
								<div class="content" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
									
									
									<div style=" position: absolute ;top: 40%;left: 34%;">
										<h1 style="font-size: 5rem;">Thank You !</h1>
									</div>
									
								</div>
				
							</div>
						</div>
						<!-- ----------------------------------------   Thank you Div ----------------------------------------------------- -->
		
			 			<a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
							<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
						</a> 
						<a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
							<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
						</a> 
	
						<ol class="carousel-indicators">
							<li data-target="#presentation-slides" data-slide-to="0"  class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
							<li data-target="#presentation-slides" data-slide-to="1"  class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="projectNamesListCorousel"><b><i class="fa fa-list" aria-hidden="true"></i></b></li>
							<% int i=1;if(projects!=null && projects.size()>0){
							for(Object[] obj: projects){%>
							<li data-target="#presentation-slides" data-slide-to="<%=++i%>"  class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="<%=i%>. <%=obj[6]%>"><b><%=i-1%></b></li>
							<%}}%>
							<li data-target="#presentation-slides" data-slide-to="<%=i+1%>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="Thank You"><b>End</b></li>
							<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_full_screen" data-toggle="tooltip" data-placement="top" title="Full Screen Mode"><b><i class="fa fa-expand fa-lg" aria-hidden="true"></i></b></li>
							<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_reg_screen" data-toggle="tooltip" data-placement="top" title="Exit Full Screen Mode"><b><i class="fa fa-compress fa-lg" aria-hidden="true"></i></b></li>	
							<li style="background-color:  white;width: 55px;margin-left: 20px;"><a onclick="DownloadSelected()" target="_blank" id='downloadselect'><i class="fa fa-download fa-2x" style="color: green;" aria-hidden="true"></i></a>	
						</ol>
	
</div>	
<script type="text/javascript">
var s = new Array();
<%for(int ij=0;ij<a.length;ij++){%>
s.push(<%=a[ij]%>);
<%}%>
console.log(s);
function DownloadSelected(){
	document.getElementById("downloadselect").href="DownloadSelectedSlides.htm/"+s;
	document.getElementById("downloadselect").click();
		//document.getElementById('submitdownloadselect').submit();
}

$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})
	
	  function onTryItClick() {
        var content = document.getElementById("iframecontent").innerHTML;
        var iframe = document.getElementById("myiframeid");

        var frameDoc = iframe.document;
        if (iframe.contentWindow)
            frameDoc = iframe.contentWindow.document;

        frameDoc.open();
        frameDoc.writeln(content);
        frameDoc.close();
    }

    
$('.content_reg_screen').hide();
$('.content_full_screen, .content_reg_screen').on('click', function(e){
	  
	  if (document.fullscreenElement) {
	    	document.exitFullscreen();
	  } else {
		  $('.slides-container').get(0).requestFullscreen();
	  }
	});

$('.content_full_screen').on('click', function(e){ contentFullScreen() });

$('.content_reg_screen').on('click', function(e){ contentRegScreen() });

function contentFullScreen()
{
	$('.content_full_screen').hide();
	$('.content_reg_screen').show();
	openFullscreen();
}

function contentRegScreen()
{
	$('.content_reg_screen').hide();
	$('.content_full_screen').show();
	closeFullscreen();
}


/* Get the documentElement (<html>) to display the page in fullscreen */
var elem = document.documentElement;

/* View in fullscreen */
function openFullscreen() {
  if (elem.requestFullscreen) {
    elem.requestFullscreen();
  } else if (elem.webkitRequestFullscreen) { /* Safari */
    elem.webkitRequestFullscreen();
  } else if (elem.msRequestFullscreen) { /* IE11 */
    elem.msRequestFullscreen();
  }
}

/* Close fullscreen */
function closeFullscreen() {
  if (document.exitFullscreen) {
    document.exitFullscreen();
  } else if (document.webkitExitFullscreen) { /* Safari */
    document.webkitExitFullscreen();
  } else if (document.msExitFullscreen) { /* IE11 */
    document.msExitFullscreen();
  }
}

</script>
</body>
</html>