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
}
</style>

</head>
<body class="slides-container" id="slides-container">
<%
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
String filePath = (String)request.getAttribute("filepath");
List<Object[]> freezedproject = (List<Object[]>)request.getAttribute("getAllProjectSlidedata");
List<Object[]> FreezedSlide = (List<Object[]>)request.getAttribute("getAllProjectSlidesdata");
List<Object[]> projects = (List<Object[]>)request.getAttribute("getAllProjectdata");
String[] a = new String[projects.size()];
for(int i=0;i<projects.size();i++)
{a[i]=projects.get(i)[0].toString();}
String filepath = (String)request.getAttribute("filepath");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();

%>

<div id="presentation-slides" class="carousel slide " data-ride="carousel">
	<div class="carousel-inner" align="center">
		<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">
				
				<div class="content" align="center" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					
					<div class="firstpage"  > 

						<div align="center" style="margin-top: 85px"><h2 style="color: #145374 !important;font-family: 'Muli'!important">Presentation</h2></div>
						<div align="center" ><h3 style="color: #145374 !important">of</h3></div>
							
						<div align="center" >
							<h3 style="color: #4C9100 !important" >  Projects of <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %></h3>
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
						
						<br>
						<% Boolean f = true;
						for(int i=0;i<freezedproject.size();i++)
								 {if(freezedproject.get(i)!=null)
									if (freezedproject.get(i)[4] != null ) {f=false;
								%><div align="center">
									<b>Review By :- </b><%=freezedproject.get(i)[4]%>
									&nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=sdf.format(freezedproject.get(i)[5])%></div>
								<%break;}
									}if(f){
									%>
								<div align="center">
									<b>Review By :- </b>Reviewed by Person
									&nbsp;&nbsp;&nbsp; <b>Review date :- </b>Reviewed On Date</div>
								<%} %>
						
						<table style="margin-top:35px;" class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
						<% if(labInfo!=null){ %>
						<tr>
												<td style="height: 25px"></td>
												</tr>	
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %></th>
						</tr>
						
						<%}%>
						<tr>
												<td style="height: 25px"></td>
												</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
						</tr>
						<tr>
												<td style="height: 25px"></td>
												</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
						</tr>
						<tr>
												<td style="height: 25px"></td>
												</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
						</tr>
						
						</table>			
						
						
					</div>
					
				</div>
				
			</div>
			
			<!-- ----------------------------------------  P-0  Div ----------------------------------------------------- -->
			
		<!-- ----------------------------------------  Freezed Project Slide ----------------------------------------------------- -->
					<%if(projects!=null && projects.size()>0 && FreezedSlide!=null){
						for(int i=0;i<projects.size();i++ ){
						if(FreezedSlide.get(i)!=null && projects.get(i)!=null && freezedproject != null){if(FreezedSlide.get(i)[1]==null)FreezedSlide.get(i)[1]="1";
							if(FreezedSlide.get(i)[1]!=null ){if(FreezedSlide.get(i)[1].toString().equals("2")){%>
							<div class="carousel-item " >
				<div class="container-fluid" >
					<div class="container-fluid"  ><div class="card shadow-nohover" id="slide2"
								style="border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
								<%
								if (freezedproject.size() > 0 && (freezedproject.size()-1)>=i) {
									if(freezedproject.get(i)!=null){
								%><div align="center">
									<b>Review By :- </b><%=freezedproject.get(i)[4]%>
									&nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=sdf.format(freezedproject.get(i)[5])%></div>
								<%}else{%>
								<div align="center">
									<b>Review By :- </b>Reviewerd Name
									&nbsp;&nbsp;&nbsp; <b>Review date :- </b>Reviewed Date</div>
									
									<% }}else{%>
								
								<div align="center">
									<b>Review By :- </b>Reviewed Name
									&nbsp;&nbsp;&nbsp; <b>Review date :- </b>Reviewed Date</div>
									
									<%}
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
								<h4 class="card-title" align="center"
									style="color: #c72626; margin-top: 5px;">
									<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
									%><%=projects.get(i)[1]%>
									<%}%>
								</h4>
								<hr style="margin-top: -5px;">
								<div class="card-body"
									style="padding: 0.25rem; margin-top: -14px;" align="center">
									<div class="row">
										<div class="col-md-4">
											<div class="row">
												<div class="col">
													<table style="margin-top:35px;" class="table meeting">
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; width: 150px;height: 41.6px;">Project
																No :</td>
															<td style="width: 286px;"><%=projects.get(i)[11]%></td>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; width: 80px;">User
																:</td>
															<td style="width: 150px;"><%=enduser%></td>
														</tr>
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">Category
																:</td>
															<td><%=projects.get(i)[2]%></td>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">DoS
																:</td>
															<td><%=sdf.format(projects.get(i)[5])%></td>
														</tr>
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">Cost
																Rs.:</td>
															<td><%=nfc.convert(cost / 10000000)%> (In Cr)</td>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">PDC
																:</td>
															<td><%=sdf.format(projects.get(i)[4])%></td>
														</tr>

														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">Application
																:</td>
															<td colspan="4">
																<%if (projects.get(i) != null && projects.get(i)[10] != null) {
																%><%=projects.get(i)[10]%>
																<%} else {%> -- <%}%>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<table style="margin-top:45px;" class="table meeting">
												<tr>
													<td><b
														style="font-size: 1.09rem; font-weight: bold; color: #115bc9;">Objectives
															: </b> <%
														 if (projects.get(i)[7] != null && projects.get(i)[7].toString().length() > 320) {
 															%>
														<%=projects.get(i)[7].toString().substring(0, 280)%><span
														onclick="ViewInModel('O')"
														style="color: #1176ab; font-size: 14px; cursor: pointer;"><b>
																...View More </b></span>
														<%
														} else {
														%> <%=projects.get(i)[7]%> <%}%></td>
												</tr>
												<tr>
													<td><b
														style="font-size: 1.09rem; font-weight: bold; color: #115bc9;">Scope
															: </b>
														<%
														if (projects.get(i)[9] != null && projects.get(i)[9].toString().length() > 320) {
														%>
														<%=projects.get(i)[9].toString().substring(0, 280)%><span
														onclick="ViewInModel('S')"
														style="color: #1176ab; font-size: 14px; cursor: pointer;"><b>
																...View More </b></span>
														<%
														} else {
														%> <%=projects.get(i)[9]%> <%}%></td>
												</tr>
												<tr>
													<td><b
														style="font-size: 1.09rem; font-weight: bold; color: #115bc9;">Deliverables
															: </b> <% if (projects.get(i)[8] != null && projects.get(i)[8].toString().length() > 320) {%>
														<%=projects.get(i)[8].toString().substring(0, 280)%><span
														onclick="ViewInModel('D')"
														style="color: #1176ab; font-size: 14px; cursor: pointer;"><b>
																...View More </b></span>
														<%
														} else {
														%> <%=projects.get(i)[8]%> <% } %></td>
												</tr>
											</table>
										
										<div class="col" align="left">
								<div class="row" align="left" >
								<div class="col-3" align="center">
								<label style="font-size: 1.02rem;font-weight: bold;color: #115bc9;"> Current Status:</label>

								</div>
								<div class="col" align="left">
<%if(FreezedSlide.get(i)[0]!=null && FreezedSlide.get(i)[0].toString().length()>300){%>
											<%=FreezedSlide.get(i)[0].toString().substring(0,250)%><span
												onclick="ViewInModel('Status')"
												style="color: #1176ab; font-size: 14px; cursor: pointer;"><b>
													...View More </b></span>
											<%}else{%>
											<%=FreezedSlide.get(i)[0]%>
											<%}%>
								</div>
								</div>
							</div>
										</div>
									</div>
									<div class="row">
										
										<div class="col-md-2" align="left">
											<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[4]%>"
												target="_blank" title="PDF File"><b>Linked File</b></a>
										</div>
									</div>
									<div class="col-md-7">
										<table style="width: 100%;height: 100%;border-style: hidden;">
											<tbody >
												
												<tr  style="border-style: hidden;">
												<td class="align-middle" style="border-style: hidden;">
									<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2]).exists())
									{%>
									<img class=" d-flex justify-content-center" data-enlargable style="max-height: 300px; max-width: 1200px; margin-bottom: 5px;margin: auto;" 
									src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2])))%>">
									<%} else{ %>image<%} %>
									</td>
									</tr>
									</tbody>
									</table>
									</div>
									
									
								</div>
							</div></div></div>
							</div>
							<%}}
								if(FreezedSlide.get(i)!=null && projects.get(i)!=null)if(FreezedSlide.get(i)[1].toString().equals("1")){ %> 
					<div class="carousel-item " >
				<div class="container-fluid" >
					<div>
					<div class="container-fluid"  ><div class="card shadow-nohover" id="slide1" style="border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					<%if ((freezedproject.size()-1)>=i){if(freezedproject!=null && freezedproject.size()>0) if(freezedproject.get(i)!=null){%><div align="center"> 
					<b>Review By :- </b> <%=freezedproject.get(i)[4]%> &nbsp;&nbsp;&nbsp;<b>Review date :- 
					</b><%=sdf.format(freezedproject.get(i)[5]) %></div><%}%>
					<% }else{ %>
					<div align="center">
									<b>Review By :- </b>Reviewer Name
									&nbsp;&nbsp;&nbsp; <b>Review date :- </b>Reviewed Date</div>
					<%} %>
					
					
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
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projects.get(i)!=null )if( projects.get(i)[1]!=null){%><%=projects.get(i)[1]%> <%}%></h4>
						<hr>
					<div class="card-body" style="padding: 0.25rem;margin-top: -14px;" align="center">
						<div class="row">
							<div class="col-md-5">
							<div class="row"><div class="col">
							<table style="margin-top:35px;" class="table meeting" style="margin-bottom: -11px;">
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold; color: #115bc9;width: 150px;height: 41.6px;">Project No :</td>
										<td style="width: 286px;"><%=projects.get(i)[11]%></td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;height: 41.6px; width: 80px;">User :</td>
										<td style="width: 150px;"><%=enduser%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;height: 41.6px;">Category :</td>
										<td><%=projects.get(i)[2]%></td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;height: 41.6px;">DoS :</td>
										<td><%=sdf.format(projects.get(i)[5]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;height: 41.6px;">Cost Rs.:</td>
										<td><%=nfc.convert(cost/10000000)%> (In Cr)</td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;height: 41.6px;">PDC :</td>
										<td><%=sdf.format(projects.get(i)[4]) %></td>
									</tr>
									
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;height: 41.6px;">Application :</td>
										<td colspan="4"><%if(projects.get(i)!=null && projects.get(i)[10]!=null){%><%=projects.get(i)[10]%><%}else{%> -- <%}%></td>
									</tr>
								</table>
										</div>
										<div>
										</div>
										</div>
								  	<br>
								  	 	<table style="margin-top:45px;" class="table meeting">
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projects.get(i)[7]!=null && projects.get(i)[7].toString().length()>320){%> <%=projects.get(i)[7].toString().substring(0,280)%><span onclick="ViewInModel('O')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projects.get(i)[7]==null?"--":projects.get(i)[7]%> <%}%></td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projects.get(i)[9]!=null && projects.get(i)[9].toString().length()>320){%> <%=projects.get(i)[9].toString().substring(0,280)%><span onclick="ViewInModel('S')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projects.get(i)[9]==null?"--":projects.get(i)[9]%> <%}%> </td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projects.get(i)[8]!=null && projects.get(i)[8].toString().length()>320){%> <%=projects.get(i)[8].toString().substring(0,280)%><span onclick="ViewInModel('D')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projects.get(i)[8]==null?"--":projects.get(i)[8]%> <%}%></td></tr>
										</table>
								<div class="row">
									<div class="col-md-12" align="left">
									<div class="row" align="left" >
								<div class="col-3" align="left">
								<label style="font-size: 1.02rem;font-weight: bold;color: #115bc9;"> Current Status:</label>

								</div>
								<div class="col" align="left">
<%if(FreezedSlide.get(i)[0]!=null && FreezedSlide.get(i)[0].toString().length()>300){%>
											<%=FreezedSlide.get(i)[0].toString().substring(0,250)%><span
												onclick="ViewInModel('Status')"
												style="color: #1176ab; font-size: 14px; cursor: pointer;"><b>
													...View More </b></span>
											<%}else{%>
											<%=FreezedSlide.get(i)[0]%>
											<%}%>
								</div>
								</div>
								
								
								
										<br><a href="SlidePdfOpenAttachDownload.htm?slideId=<%=FreezedSlide.get(i)[4]%>"  target="_blank" title="PDF File"><b>Linked File</b></a>
									</div>
								</div>
							</div>
							<div class="col-md-7">
										<table style="width: 100%;height: 100%;border-style: hidden;">
											<tbody >
												
												<tr  >
												<td >
									
									<%if(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2]).exists()){%>
									<img class=" d-flex justify-content-center mx-auto d-block" data-enlargable style="max-height: 300px; max-width: 1200px;" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + FreezedSlide.get(i)[3] + FreezedSlide.get(i)[2])))%>">
									<%} else{%>image<%}%>
									</td>
									</tr>
									</tbody>
									</table>
									
							</div>
						</div>	
					</div>
					<hr>
				</div>
					
					
			</div>	
					</div>
				</div>
			</div>	
			
			<%}}else{%>
		
		<div class="carousel-item " >
				<div class="container-fluid" >
					<div>
					<div class="container-fluid"  ><div class="card shadow-nohover" id="slide1" style="border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					<div align="center"> <b>Review By :- </b> &nbsp;&nbsp;&nbsp;Reviewed Name <b>Review date :- </b>Reviewed Date</div>
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projects.get(i)!=null )if( projects.get(i)[1]!=null){%><%=projects.get(i)[1]%> <%}%></h4>
						<hr style="margin-top: -5px;">
					<div class="card-body" style="padding: 0.25rem;margin-top: -14px;" align="center">
									<div class="row inline">
										<div class="col-md-5">
											<div class="row">
												<div class="col">
													<table style="margin-top: 35px;" class="table meeting"
														style="margin-bottom: -11px;">
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; width: 150px; height: 41.6px;">Project
																No :</td>
															<td style="width: 286px;"><%=projects.get(i)[11]%></td>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px; width: 80px;">User
																:</td>
															<td style="width: 150px;">user</td>
														</tr>
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px;">Category
																:</td>
															<td><%=projects.get(i)[2]%></td>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px;">DoS
																:</td>
															<td><%=sdf.format(projects.get(i)[5]) %></td>
														</tr>
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px;">Cost
																Rs.:</td>
															<td>cost (In Cr)</td>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px;">PDC
																:</td>
															<td><%=sdf.format(projects.get(i)[4]) %></td>
														</tr>
														<tr>
															<td
																style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px;">Application
																:</td>
															<td colspan="4">
																<%if(projects.get(i)!=null && projects.get(i)[10]!=null){%><%=projects.get(i)[10]%>
																<%}else{%> -- <%}%>
															</td>
														</tr>
													</table>
												</div>
												<div></div>
											</div>
											<br>
											<table style="margin-top: 45px;" class="table meeting">
											
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projects.get(i)[7]!=null && projects.get(i)[7].toString().length()>320){%> <%=projects.get(i)[7].toString().substring(0,280)%><span onclick="ViewInModel('O')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projects.get(i)[7]==null?"--":projects.get(i)[7]%> <%}%></td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projects.get(i)[9]!=null && projects.get(i)[9].toString().length()>320){%> <%=projects.get(i)[9].toString().substring(0,280)%><span onclick="ViewInModel('S')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projects.get(i)[9]==null?"--":projects.get(i)[9]%> <%}%> </td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projects.get(i)[8]!=null && projects.get(i)[8].toString().length()>320){%> <%=projects.get(i)[8].toString().substring(0,280)%><span onclick="ViewInModel('D')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projects.get(i)[8]==null?"--":projects.get(i)[8]%> <%}%></td></tr>
										
										</table>
											<div class="row">
												<div class="col-md-12" align="left">
													<label
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9; height: 41.6px; margin-top: 40px">
														Current Status :</label> Current Status <br> <a
														target="_blank" title="PDF File"><b>Linked File</b>
														Downloadables</a>
												</div>
											</div>
										</div><div class="col-md-7">
										<table style="width: 100%;height: 100%;border-style: hidden;">
											<tbody >
												
												<tr style="border-style: hidden;" >
													<td class="align-middle" style="border-style: hidden;" ><p class=" d-flex justify-content-center" >image</p></td>
												</tr>
									
									</tbody>
									</table></div>
								</div>	
					</div>
					<hr>
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
		</a> <a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a> 
	
		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="0"  class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
			<% int i=0;if(projects!=null && projects.size()>0){
			for(Object[] obj: projects){%>
			<li data-target="#presentation-slides" data-slide-to="<%=++i%>"  class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="<%=i%>. <%=obj[6]%>"><b><%=i%></b></li>
			<%}}%>
			<li data-target="#presentation-slides" data-slide-to="<%=i+1%>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="Thank You"><b>End</b></li>
			<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_full_screen" data-toggle="tooltip" data-placement="top" title="Full Screen Mode"><b><i class="fa fa-expand fa-lg" aria-hidden="true"></i></b></li>
			<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_reg_screen" data-toggle="tooltip" data-placement="top" title="Exit Full Screen Mode"><b><i class="fa fa-compress fa-lg" aria-hidden="true"></i></b></li>	
			<li style="background-color:  white;width: 55px;margin-left: 20px;"><a onclick="DownloadSelected()" target="blank"><i class="fa fa-download fa-2x" style="color: green;" aria-hidden="true"></i></a>	
		</ol>
	
</div>	
<script type="text/javascript">
var s = new Array();
<%for(int ij=0;ij<a.length;ij++){%>
s.push(<%=a[ij]%>);
<%}%>
console.log(s);
function DownloadSelected(){
		window.location.href="DownloadSelectedSlides.htm/"+s;
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