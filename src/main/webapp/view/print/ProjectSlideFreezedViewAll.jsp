<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.stream.Collectors"%>
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
<title>Project Master Slides</title>
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

.content-header.row {
background-color: #ffd8b1
}
.card-title.col-md-10{
color: black;
}
.zoom {
  transition: transform .4s; 
}
.zoom:hover {
  transform: scale(1.5); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
  z-index: 99999928374 !important;
}
.modal-list{
	font-size: 14px;
	text-align: left;
	padding: 0px !important;
	margin-bottom: 5px;
}

.modal-list li{
	display: inline-block;
}

.modal-list li .modal-span{
	font-size: 1.5rem;
	padding: 0px 7px;
}

.modal-list li .modal-text{
	font-size: 1rem;
	vertical-align: text-bottom;
	font-family: Lato;
}
.zoom {
  transition: transform .4s; 
}
.zoom:hover {
  transform: scale(1.2); /* (130% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
  z-index: 99999928374 !important;
}
.zoom2 {
  transition: transform .4s; 
}
.zoom2:hover {
  transform: scale(1.7); /* (180% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
  z-index: 99999928374 !important;
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
//List<Object[]> FreezedSlide = (List<Object[]>)request.getAttribute("getAllProjectSlidesdata"); //status ,  slide , ImageName , path ,SlideId ,attachmentname, brief
List<Object[]> projects = (List<Object[]>)request.getAttribute("getAllProjectdata");
String[] a = new String[projects.size()];
for(int i=0;i<projects.size();i++)
{a[i]=projects.get(i)[0].toString();}
String filepath = (String)request.getAttribute("filepath");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
String reviewedby = "";
String reviewDate = "";
FormatConverter fc = new FormatConverter();
List<Object[]> mainProjectList =  projects!=null && projects.size()>0 ? (projects.stream().filter(e-> e[21]!=null && e[21].toString().equals("1")).collect(Collectors.toList())): new ArrayList<Object[]>();
List<Object[]> subProjectList =  projects!=null && projects.size()>0 ? (projects.stream().filter(e-> e[21]!=null && e[21].toString().equals("0")).collect(Collectors.toList())): new ArrayList<Object[]>();
projects.clear();
projects.addAll(mainProjectList);
projects.addAll(subProjectList);

int pageCOunt=1;
%>

<div id="presentation-slides" class="carousel slide " data-ride="carousel">
	<div class="carousel-inner" align="center">
		<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
		<div class="carousel-item active">
				
			<div class="content" align="center" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					
				<div class="firstpage"  > 
	
					<div class="mt-2" align="center"><h2 style="color: #145374 !important;">Presentation</h2></div>
					<div align="center" ><h2 style="color: #145374 !important;">of</h2></div>
							
					<div align="center" >
						<h2 style="color: #145374 !important;" >  <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %> Projects</h2>
			   		</div>
					
					<div align="center" ><h2 style=" color: #145374 !important;"></h2></div>
					
					<table style="margin-top:35px;" class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
						<tr>			
							<th colspan="8" style="text-align: center; font-weight: 700;">
								<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
								<br>
							</th>
						</tr>
					</table>	
					<br><br><br><br>
					<% Boolean flag=false;
						for(int i=0;i<freezedproject.size();i++)
						{
							for(int j=0;j<projects.size();j++)
							{
								if(freezedproject.get(i)[3].toString().equals(projects.get(j)[0].toString())){
									reviewedby=freezedproject.get(i)[4].toString();
									reviewDate=sdf.format(freezedproject.get(i)[5]).toString();
									flag=true;
									break;
								}
								if(flag)break;
							}
							
						}
					%>
					<h4 style="color: #145374 !important;text-align: center;"><%if( reviewedby!="" ) {%> Review By - <%=reviewedby %>  <%} %></h4>
					<h4 style="color: #145374 !important;text-align: center;"><%if( reviewDate!="" ) {%> Review Date - <%=reviewDate %> <%} %></h4>
					<br><br><br><br><br>
					<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;font-weight: bold;"  >
						<% if(labInfo!=null){ %>
							<tr>
								<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size: 22px"> <h2 style="color: #145374 !important;"> <%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %> </h2> </th>
							</tr>
						<%}%>
						<tr>
							<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px"><br>Government of India, Ministry of Defence</th>
						</tr>
						<tr>
							<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px">Defence Research & Development Organization</th>
						</tr>
						<tr>
							<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
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
						
			        	<%-- <% for(int i=0;i<mainProjectList.size();i++){ %><%=mainProjectList.get(i)[13] %><%} %>
			        	<% for(int i=0;i<subProjectList.size();i++){ %><%=subProjectList.get(i)[13] %><%} %> --%>
			        	<!-- ----------------------------------Main projects List -------------------------- -->	
			        	<% int val=0;
			        	if(mainProjectList.size()>0){ %>
			        	<h4 style="text-align: left;">Main Project<a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a>
			        	</h4>
							<table style="width: 100%;font-size: 1.2rem;">
								<thead style="background-color: #ffd8b1; color: black;">
									<tr >
										<th style="width: 2%;">SN</th>
										<th style="width: 5%;">Code</th>
										<th style="width: 35%;">Project Name</th>
										<th style="width: 4%;">Category</th> 
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
									<% if(mainProjectList!=null && mainProjectList.size()>0) {
										
										for(int i=0;i<mainProjectList.size();i++ ){val=i; %>
										<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=(++pageCOunt)%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;">
											<td style="text-align: center;font-weight: bold;"><%=1+i %> </td>
											<td style="text-align: center;font-weight: bold;">
												<%=mainProjectList.get(i)[12]!=null?mainProjectList.get(i)[12]:"-" %>
											</td>
											<td style="font-weight: bold;"  >
											<div class="container-fluid">
													<div class="row">
														<div class="col-1">
															<ul class="modal-list">
																<%
																	double cost = Double.parseDouble(mainProjectList.get(i)[3].toString());
																	String enduser = "--";
																	if (mainProjectList != null && mainProjectList.get(i)[6] != null && mainProjectList.get(i)[6].toString().equalsIgnoreCase("IA")) {
																%>
																	
																<li><span class="modal-span" style="color:green">&#11044;</span></li>
																
																<%
																} else if (mainProjectList != null && mainProjectList.get(i)[6] != null && mainProjectList.get(i)[6].toString().equalsIgnoreCase("IN")) {
																		%>
																		
																<li><span class="modal-span" style="color:#007bff">&#11044;</span></li>
																		
																		<%
																} else if (mainProjectList != null && mainProjectList.get(i)[6] != null && mainProjectList.get(i)[6].toString().equalsIgnoreCase("IAF")) {
																		%>
																		
																<li><span class="modal-span" style="color:#1F4690">&#11044;</span></li>
																		
																		<%
																} else if (mainProjectList != null && mainProjectList.get(i)[6] != null && mainProjectList.get(i)[6].toString().equalsIgnoreCase("IH")) {
																	%>
																	
																<li><span class="modal-span" style="color:#8E3200">&#11044;</span></li>
																	
																	<%
																} else if (mainProjectList != null && mainProjectList.get(i)[6] != null && mainProjectList.get(i)[6].toString().equalsIgnoreCase("DRDO")) {
																	%>
																	
																<li><span class="modal-span" style="color:orange;">&#11044;</span></li>
																	
																	<%
																} else if (mainProjectList != null && mainProjectList.get(i)[6] != null && mainProjectList.get(i)[6].toString().equalsIgnoreCase("OH")) {
																	%>
																	
																<li><span class="modal-span" style="color:#EE5007">&#11044;</span></li>
																	
																	<%
																}
																
																%>
															
															</ul>
												
													
														</div>
														<div class="col">
															<%if (mainProjectList.get(i) != null )
																if(mainProjectList.get(i)[1] != null) { %><%=mainProjectList.get(i)[1]%> - <%=mainProjectList.get(i)[13]!=null?mainProjectList.get(i)[13]:"-"%> 
															<%}%>
														</div>
													</div>
												</div>										
											</td>
											
											<td style="font-weight: bold;text-align: center;">
												<%if(mainProjectList.get(i)[32]!=null){%><%=mainProjectList.get(i)[32] %><%}else {%>-<%} %>
											</td>
											<%-- <td>
											<%=mainProjectList.get(i)[32]%>
											</td> --%>
											<%-- <td style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[3].toString())/10000000) %>
												<%}%>
											</td> --%>
											<td style="font-weight: bold;text-align: center;">
												<%if (mainProjectList.get(i) != null )
													
													if(mainProjectList.get(i)[5]!= null) {	%>
													<%=fc.SqlToRegularDate(mainProjectList.get(i)[5].toString())%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: center;<%
													DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
											LocalDate regularDate = LocalDate.parse(fc.SqlToRegularDate(mainProjectList.get(i)[4].toString()), formatter);
													if (mainProjectList.get(i) != null )
														if(mainProjectList.get(i)[4]!= null)
											if(regularDate.isBefore(LocalDate.now())){%>  color: red;  <%}%> ">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[4]!= null) {
													 formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
														 regularDate = LocalDate.parse(fc.SqlToRegularDate(mainProjectList.get(i)[4].toString()), formatter);
														%>
													<%=fc.SqlToRegularDate(mainProjectList.get(i)[4].toString())%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[3].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[16]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[16].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[17]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[17].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[18]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[18].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[19]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[19].toString())/10000000)%>
												<%}%>
											</td>
										</tr>
									<%} }%>
								</tbody>
					
							</table>
						<%} %>
									<!-- ----------------------------------sub projects List -------------------------- -->		
									<br><br><br>
									<%if(subProjectList.size()>0){ %>
							<h4 style="text-align: left;">Sub Project<a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a></h4>
									<table style="width: 100%;font-size: 1.25rem">
									<thead style="background-color: #ffd8b1; color: black;">
										<tr >
											<th style="width: 2%;">SN</th>
											<th style="width: 5%;">Code</th>
											<th style="width: 35%;">Project Name</th>
											<th style="width: 4%;">Category</th>
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
									
										<% if(subProjectList!=null && subProjectList.size()>0) {
											if(val>0)val++;
											for(int i=0;i<subProjectList.size();i++ ){ %>	
											<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=(++pageCOunt)%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;">
												<td style="text-align: center;font-weight: bold;"><%=1+i %> </td>
												<td style="text-align: center;font-weight: bold;">
													<%=subProjectList.get(i)[12]!=null?subProjectList.get(i)[12]:"-" %>
												</td>
												<td  style="font-weight: bold;"  >
													<div class="container-fluid">
														<div class="row">
															<div class="col-1">
																<ul class="modal-list">
																	<%
																		double cost = Double.parseDouble(subProjectList.get(i)[3].toString());
																		String enduser = "--";
																		if (subProjectList != null && subProjectList.get(i)[6] != null && subProjectList.get(i)[6].toString().equalsIgnoreCase("IA")) {
																	%>
																		
																	<li><span class="modal-span" style="color:green">&#11044;</span></li>
																	
																	<%
																	} else if (subProjectList != null && subProjectList.get(i)[6] != null && subProjectList.get(i)[6].toString().equalsIgnoreCase("IN")) {
																			%>
																			
																	<li><span class="modal-span" style="color:#007bff">&#11044;</span></li>
																			
																			<%
																	} else if (subProjectList != null && subProjectList.get(i)[6] != null && subProjectList.get(i)[6].toString().equalsIgnoreCase("IAF")) {
																			%>
																			
																	<li><span class="modal-span" style="color:#1F4690">&#11044;</span></li>
																			
																			<%
																	} else if (subProjectList != null && subProjectList.get(i)[6] != null && subProjectList.get(i)[6].toString().equalsIgnoreCase("IH")) {
																		%>
																		
																	<li><span class="modal-span" style="color:#8E3200">&#11044;</span></li>
																		
																		<%
																	} else if (subProjectList != null && subProjectList.get(i)[6] != null && subProjectList.get(i)[6].toString().equalsIgnoreCase("DRDO")) {
																		%>
																		
																	<li><span class="modal-span" style="color:orange;">&#11044;</span></li>
																		
																		<%
																	} else if (subProjectList != null && subProjectList.get(i)[6] != null && subProjectList.get(i)[6].toString().equalsIgnoreCase("OH")) {
																		%>
																		
																	<li><span class="modal-span" style="color:#EE5007">&#11044;</span></li>
																		
																		<%
																	}
																	
																	%>
																
																</ul>
															</div>
															<div class="col">
																<%if (subProjectList.get(i) != null )
																	if(subProjectList.get(i)[1] != null) { %><%=subProjectList.get(i)[1]%> - <%=subProjectList.get(i)[13]!=null?subProjectList.get(i)[13]:"-"%>
																<%}%>
															</div>
														</div>
													</div>
													
												
														
												</td>
												<td style="font-weight: bold;text-align: center;">
													<%if(subProjectList.get(i)[32]!=null){%><%=subProjectList.get(i)[32] %><%}else {%>-<%} %>
												</td>
												<%-- <td style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[3]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[3].toString())/10000000) %>
													<%}%>
												</td> --%>
												<td style="font-weight: bold;text-align: center;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[5]!= null) { %>
														<%=fc.SqlToRegularDate(subProjectList.get(i)[5].toString())%>
													<%}%>
												</td>
												<td style="font-weight: bold;text-align: center;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[4]!= null) { %>
														<%=fc.SqlToRegularDate(subProjectList.get(i)[4].toString())%>
													<%}%>
												</td>
												<td style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[3]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[3].toString())/10000000)%>
													<%}%>
												</td>
												<td style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[16]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[16].toString())/10000000)%>
													<%}%>
												</td>
												<td style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[17]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[17].toString())/10000000)%>
													<%}%>
												</td>
												<td style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[18]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[18].toString())/10000000)%>
													<%}%>
												</td>
												<td style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[19]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[19].toString())/10000000)%>
													<%}%>
												</td>
											</tr>
										<%} }%>
									</tbody>
						
									</table>
									<%} %>
						</div>
					</div>
							
				</div>
			</div>
		</div>


		<!-- ----------------------------------------  Freezed Project Slide ----------------------------------------------------- -->
		<!-- ----------------------------------------- Slide Two ------------------------------------------------------------ -->
		<%if(projects!=null && projects.size()>0){
				for(int i=0;i<projects.size();i++ ){
					if(projects.get(i)[22]!=null || projects.get(i)[23]!=null || projects.get(i)[24]!=null ||
							projects.get(i)[25]!=null || projects.get(i)[27]!=null || projects.get(i)[29]!=null ||
							projects.get(i)[26]!=null || projects.get(i)[30]!=null || projects.get(i)[31]!=null){
							if(projects.get(i)[23].toString().equals("2")){ %>
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
													<h2 style="color: black;" class="col-md-9" align="center">
															<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
															%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
															<%}%>
													</h2>
													<h6 class="col">
							 							<%-- <%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
															<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" ><b>Show more</b></a>
														<%} %> --%>
														<br>
								 					<%-- 	<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
															<a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a>
														<%} %> --%>
							 						</h6>
							 						<div class="col-md-1" align="right" style="padding-top:5px;" >
							 							<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
							 						</div>
												</div>
												<div class="content shadow-nohover" style="padding: 0.25rem;border: 6px solid green;border-radius: 5px !important;height:85vh !important;padding-top: 15px;overflow-x: hidden;" align="center">
													<div class="row" >
														<div class="col-md-12">
												
															<table style="width: 99%;font-weight: bold;margin-left: 0.5%;margin-right: 1%;font-size: 1.35rem;">
																<tr>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%;">Project No </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%;">DoS </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">PDC </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%">User </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%;">Category </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">Cost (In Cr) </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">Application </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">Current Stage </td>
																	
																	
																	
																</tr>
																<tr>
																	<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																	<td colspan="1" style="width: 12%;color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[5])%></td>
																	<td colspan="1" style="color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[4])%></td>
																	<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[6]!=null?projects.get(i)[6]:"--"%></td>
																	<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[32]!=null?projects.get(i)[32]:"--"%></td>
																	<td colspan="1" style="color:#007bff;text-align:right"><%=nfc.convert(cost / 10000000)%> </td>
																	<td colspan="1" style="color:#007bff;"> <%if (projects.get(i) != null && projects.get(i)[10] != null) {%> <%=projects.get(i)[10]%>
																		<%} else {%> -- <%}%></td>
																	<td colspan="1" style="color:#007bff;"> <%if(projects.get(i)[14]!=null){%> <%=projects.get(i)[14]%>
																		<%} else {%> -- <%}%></td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.5rem; font-weight: bold; color: #021B79;vertical-align: top;">Brief :</td>
																	<td colspan="7" style="font-size: 1.5rem;color: black;">
																		<%if(projects.get(i)[28]!=null){%>
																			<%=projects.get(i)[28]%>
																		<%}else{%>
																			--
																		<%}%>
																	</td>
																</tr>
																<tr>
																	<td colspan="1"><b style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Objectives : </b></td>
																	<td colspan="7"style="color: black;">
																			<%if(projects.get(i)[7]!=null) {%>
																				<%=projects.get(i)[7]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																<%-- <tr>
																	<td colspan="1"><b style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Scope : </b></td>
																	<td colspan="7"style="color: black;">
																			<%if(projects.get(i)[9]!=null) {%> 
																				<%=projects.get(i)[9]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr> --%>
																
																<tr>
																	<td colspan="1"><b style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Deliverables : </b> </td>
																	<td colspan="7"style="color: black;">
																			<%if(projects.get(i)[8]!=null) {%>
																				<%=projects.get(i)[8]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																
																
															</table>
															<br>
															<div class="container-fluid">
																<div class="row">
																	<div class="col">
																	<p>
																	<span style="text-align: left;font-size: 1.5rem; font-weight: bold; color: #021B79;">
																				Current Status :</span> 
																				<%if(projects.get(i)!=null && projects.get(i)[20]!=null && projects.get(i)[20].toString().length()>0) {%>
																				<%-- 	<%=projects.get(i)[20].toString().substring(3,projects.get(i)[20].toString().length()-1 )%> --%>
																				<div class="ml-3" style="text-align: left;"><%=projects.get(i)[20]%></div>
																				<%} else{%>-<%} %>
																	</div>
																</div>
																<%if(projects.get(i)[31]!=null && projects.get(i)[31]!=""){%>
																		
																			
																<div class="row">
																	<div class="col">
																	<p>
																		<span style="text-align: left;font-size: 1.5rem; font-weight: bold; color: #021B79;">
																			Way Forward : 
																			</span>
																	<%-- 	<%=projects.get(i)[31].toString().substring(3,projects.get(i)[31].toString().length()-1 )%> --%>
																		<div class="ml-4">
																				<%=projects.get(i)[31].toString() %>
																				</div>
																	</div>
																		
																</div>
																<%}%>
																	
																	<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
															<div class="row ml-3">
												<span>	<i class="fa fa-lg fa-angle-double-right text-success" aria-hidden="true" style="font-size: 2rem"></i>	<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" ><b>Show more</b></a></span>
														</div>
														<%} %>
														<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
															<div class="row ml-3">
														<span>	<i class="fa fa-lg fa-angle-double-right text-success" aria-hidden="true" style="font-size: 2rem"></i>	<a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a></span>
													</div>
														<%} %>
															</div>
																	
												
													
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
																	<td class="align-middle" style="border-style: hidden;text-align: center; ">
																		<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[24]).exists()){%>
																		<div style="max-height: 300px; max-width: 600px;margin: auto;">
																		<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
																			<a  href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>" target="_blank" >
																				<img class=" d-flex justify-content-center zoom2" data-enlargable style="max-height: 300px; max-width: 600px; margin-bottom: 5px;margin: auto;" 
																				src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																			</a>
																		<%}else{ %>
																				<img class=" d-flex justify-content-center zoom2" data-enlargable style="max-height: 300px; max-width: 600px; margin-bottom: 5px;margin: auto;" 
																				src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																			
																			<%} %>
																		</div>
																		<%} else{ %>image<%} %>
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
							<%}%><% if(projects.get(i)[23].toString().equals("1")){ %> 
								<div class="carousel-item " >
									<div class="container-fluid" >
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
													<h2 style="color: black;" class="col-md-9" align="center"> <%if(projects.get(i)!=null )if( projects.get(i)[1]!=null){%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)  <%}%></h2>
							 					<%-- 	<h6 class="col">
							 							<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
															<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" ><b>Show more</b></a>
														<%} %>
														<br>
								 						<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
															<a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a>
														<%} %>
							 						</h6> --%>
							 						<div class="col-md-1" align="right" style="padding-top:5px;" >
							 							<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
							 						</div>
												</div>
												
												<div class="content" style="padding: 0.25rem;border: 6px solid green;border-radius: 5px !important;height:85vh !important;padding-top: 15px;overflow-x: hidden;" align="center">
													<table style="width: 99%;font-weight: bold;margin-left: 0.5%;margin-right: 1%;font-size: 1.35rem;">
														<tr>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%;">Project No </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%;">DoS </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">PDC </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%">User </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;width: 12%;">Category </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">Cost (In Cr) </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">Application </td>
															<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold; color: maroon;">Current Stage </td>
														</tr>
														<tr>
															<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
															<td colspan="1" style="width: 12%;color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[5])%></td>
															<td colspan="1" style="color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[4])%></td>
															<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[6]!=null?projects.get(i)[6]:"--"%></td>
															<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[32]!=null?projects.get(i)[32]:"--"%></td>
															<td colspan="1" style="color:#007bff;text-align:right"><%=nfc.convert(cost / 10000000)%> </td>
															<td colspan="1" style="color:#007bff;"> <%if (projects.get(i) != null && projects.get(i)[10] != null) {%> <%=projects.get(i)[10]%>
																<%} else {%> -- <%}%></td>
															<td colspan="1" style="color:#007bff;"> <%if(projects.get(i)[14]!=null){%> <%=projects.get(i)[14]%>
																<%} else {%> -- <%}%></td>
														</tr>
													</table>
													<div class="row" style="">
														<div class="col-md-6">
															<div class="row">
																<div class="col left">
																	<table style="width: 98.1%;font-weight: bold;font-size: 1.5rem;margin-left: 1%">
																		<tr>
																			<td style="border-top: none;width: 24.8%;vertical-align: top;">
																				<b style="font-size: 1.5rem;font-weight: bold;color: #021B79;"> Brief:</b>
																			</td>
																			<td colspan="3" style="font-size: 1.5rem;border-top: none;vertical-align: top;color: black;">
																				<%if(projects.get(i)[28]!=null){%>
																					<%=projects.get(i)[28]%>
																				<%}else{%>
																					--
																				<%}%>
																			</td>
																		</tr>
																		<tr>
																			<td>
																				<b style="font-size: 1.5rem;font-weight: bold;color: #021B79;vertical-align: top;">Objectives : </b>
																			</td>
																			<td colspan="3" style="color: black;"> 
																					<%=projects.get(i)[7]==null?"--":projects.get(i)[7]%> 
																			</td>
																		</tr>
																		<%-- <tr>
																			<td>
																				<b style="font-size: 1.5rem;font-weight: bold;color: #021B79;vertical-align: top;">Scope : </b>
																			</td>
																			<td colspan="3" style="color: black;"> 
																					<%=projects.get(i)[9]==null?"--":projects.get(i)[9]%> 
																			</td>
																		</tr> --%>
																				
																		<tr>
																			<td>
																				<b style="font-size: 1.5rem;font-weight: bold;color: #021B79;vertical-align: top;">Deliverables : </b>
																			</td>
																			<td colspan="3" style="color: black;"> 
																					<%=projects.get(i)[8]==null?"--":projects.get(i)[8]%> 
																			</td>
																		</tr>
																					
																	</table>
																	<br>
																	<div class="container-fluid">
																	<div class="row">
																		<div class="col">
																			<p><span style="text-align: left;font-size: 1.5rem; font-weight: bold; color: #021B79;">
																				Current Status : 
																			</span>
																			<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																				<%-- <%=projects.get(i)[20].toString().substring(3, projects.get(i)[20].toString().length())%> --%>
																					<div class="ml-3" style="text-align: left;"><%=projects.get(i)[20]%></div>
																			<%} else{%>-<%} %> 
																		</div>
																	</div>
																	<%if(projects.get(i)[31]!=null && projects.get(i)[31]!=""){%>	
																		<div class="row">
																			<div class="col">
																				<span style="text-align: left;font-size: 1.5rem; font-weight: bold; color: #021B79;">
																					Way Forward :</span> 
																				<div class="ml-3">
																				<%=projects.get(i)[31].toString() %>
																				</div>
																			</div>
																		</div>
																	<%}%>
																	
																	<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
															<div class="row ml-3">
													<span><i class="fa fa-lg fa-angle-double-right text-success" aria-hidden="true" style="font-size: 2rem"></i>	<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" ><b>Show more </b></a> </span>	
														</div>
														<%} %>
														
															<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
																						<div class="row ml-3">
													<span><i class="fa fa-lg fa-angle-double-right text-success" aria-hidden="true" style="font-size: 2rem"></i><a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a>
														</span></div>
														<%} %>
																	
																</div>
																</div>
																
															</div>
														</div>
														<br>
														<div class="col-md-6">
															<table style="width: 100%;height: 100%;border-style: hidden;">
																<tbody>
																	<tr >
																		<td style="border-bottom: none;max-height: 300px; max-width: 600px;margin: auto;">
																			<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[24]).exists()){%>
																				<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
																					<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>" target="_blank" >
																						<img class="zoom" data-enlargable height="600" style=" max-width: 70%; margin: auto; position: relative;display: flex;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																					</a>
																				<%}else{ %>
																					<img class=" d-flex justify-content-center zoom mx-auto d-block" data-enlargable style="max-height: 600px; max-width: 600px;" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																				<%} %>
																			<%} else{%>image<%}%>
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
													
													<h2 style="color: black;" class="col-md-10" align="center">
														<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
														%><%=projects.get(i)[1]%> (<%=projects.get(i)[12]%>)
														<%}%>
													</h2>
							 						<div class="col-md-1" align="right" style="padding-top:5px;" >
							 							<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
							 						</div>
												</div>
												<div class="content shadow-nohover" style="padding: 0.25rem;;border: 6px solid green;border-radius: 5px !important;height:85vh !important;padding-top: 15px;overflow-x: hidden;" align="center">
													<div class="row" >
														<div class="col-md-12">
												
															<table style="width: 99%;font-weight: bold;margin-left: 0.5%;margin-right: 1%;font-size: 1.35rem;">
																<tr>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;width: 12%;">Project No </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;width: 12%;">DoS </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;">PDC </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;width: 12%">User </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;width: 12%;">Category </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;">Cost (In Cr) </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;">Application </td>
																	<td colspan="1" style="text-align:center;font-size: 1.5rem; font-weight: bold;color: maroon;">Current Stage </td>
																</tr>
																<tr>
																	<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																	<td colspan="1" style="width: 12%;color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[5])%></td>
																	<td colspan="1" style="color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[4])%></td>
																	<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[6]!=null?projects.get(i)[6]:"--"%></td>
																	<td colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[32]!=null?projects.get(i)[32]:"--"%></td>
																	<td colspan="1" style="color:#007bff;text-align:right;"><%=nfc.convert(cost / 10000000)%> </td>
																	<td colspan="1" style="color:#007bff;"> <%if (projects.get(i) != null && projects.get(i)[10] != null) {%> <%=projects.get(i)[10]%>
																		<%} else {%> -- <%}%></td>
																	<td colspan="1" style="color:#007bff"> <%if(projects.get(i)[14]!=null){%> <%=projects.get(i)[14]%>
																		<%} else {%> -- <%}%></td>
																</tr>
																<tr>
																	<td colspan="1" style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Brief :</td>
																	<td colspan="7" style="font-size: 1.5rem;color: black;">
																		--
																	</td>
																</tr>
																<tr>
																	<td colspan="1"><b style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Objectives : </b></td>
																	<td colspan="7" style="color: black;">
																	 <%if(projects.get(i)[7] != null && projects.get(i)[7].toString().length() > 320) {%>
																		<%=projects.get(i)[7].toString().substring(0, 280)%>
																	<%} else {%> 
																		<%=projects.get(i)[7]!=null?projects.get(i)[7]:"--"%> 
																	<%}%>
																	</td>
																</tr>
															<%-- 	<tr>
																	<td colspan="1">
																		<b style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Scope : </b>
																	</td>
																	<td colspan="7" style="color: black;">
																		<%if (projects.get(i)[9] != null && projects.get(i)[9].toString().length() > 600) {%>
																			<%=projects.get(i)[9].toString().substring(0, 600)%>
																		<%} else {%> 
																			<%=projects.get(i)[9]!=null?projects.get(i)[9]:"--"%> 
																		<%}%>
																	</td>
																</tr> --%>
																
																<tr>
																	<td colspan="1"><b style="font-size: 1.5rem; font-weight: bold; color: #021B79;">Deliverables : </b> </td>
																	<td colspan="7" style="color: black;">
																		<% if (projects.get(i)[8] != null && projects.get(i)[8].toString().length() > 320) {%>
																			<%=projects.get(i)[8].toString().substring(0, 280)%>
																		<%} else {%> 
																			<%=projects.get(i)[8]!=null?projects.get(i)[8]:"--"%> 
																		<% } %>
																	</td>
																</tr>
																
															</table>
															<br>
															<div class="container-fluid">
															<div class="row">
															<div class="col-2">
															<h4 style="text-align: left;font-size: 1.5rem; font-weight: bold; color: #021B79;">
																		Current Status : 
																	</h4>
															</div>
															<div class="col">
															
																	<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																				<div class="ml-3" style="text-align: left;"><%=projects.get(i)[20]%></div>
																		<%} else{%>-<%} %> 
						
															</div>
															</div>
															</div>
															
													
														</div>
													</div>
										
													<div class="col-md-12" style="padding-top: 40px">
														<table style="width: 100%;border-style: hidden;border: none;border-style: hidden;padding: 10px;">
															<tbody style="border: none;" >
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
																<tr style="border-style: hidden;"><td></td></tr>
															</tbody>
														</table>
													</div>
												</div>
								
											</div>
										</div>
									</div>
								</div>
							
							
						<%}}}else{%><% } %>
			
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
						<!-- ----------------------------------------   Thank you Div Ends ----------------------------------------------------- -->
		
			 			<a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
							<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
						</a> 
						<a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
							<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
						</a> 
	
						<ol class="mt-6 carousel-indicators">
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
<div class="modal fade " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="width: 900px;">
				      
				<div class="modal-header ">
					<h5 class="modal-title" id="exampleModalLabel" style="color:#145374">Colour Coding Summary</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
			        </button>
			  	</div>
					      
				<div class="modal-body">
						
					<%
					 if(true ) { %>	
						
					<div class="row">
						<div style="text-align: left">
								<ul class="modal-list">
						          	<li><span class="modal-span" style="color:green">&#11044;</span><span class="modal-text">Indian Army</span></li>
						           	<li><span class="modal-span" style="color:#007bff">&#11044;</span><span class="modal-text">Indian Navy</span></li>
						           	<li><span class="modal-span" style="color:#1F4690">&#11044;</span><span class="modal-text">Indian Air Forces</span></li>
						           	<li><span class="modal-span" style="color:#8E3200">&#11044;</span><span class="modal-text">Home Land Security</span></li>
						           	<li><span class="modal-span" style="color:orange;">&#11044;</span><span class="modal-text">DRDO</span></li>
						           	<li><span class="modal-span" style="color:#EE5007">&#11044;</span><span class="modal-text">Others</span></li>
					            </ul>
							</div>
					</div>
					
					<%} %>	
					          
				</div>
				
					      
			</div>
		</div>
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
	});
	
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