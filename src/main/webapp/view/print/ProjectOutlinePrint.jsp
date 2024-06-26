<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
 import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@page import="java.util.List , java.util.stream.Collectors,com.vts.pfms.*"%>
<%@page import="java.io.File"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<style type="text/css">
@page {
	size: 1300px 800px;
	border: 6px solid green;
	border-radius: 5px !important;
	padding: 15px;
}

p {
	margin-top: -10px;
}

pre {
	margin-bottom: -10px;
}

ol {
	margin-top: -4px;
}

.modal-list{
	font-size: 14px;
	text-align: left;
	padding: 0px !important;
	margin-bottom: 5px;
}
table{
border-collapse: collapse;
}
table, th, td {
  border: 1px solid black;
}
.modal-list li{
	display: inline-block;
}

.modal-list li .modal-span{
	font-size: 2rem;
	padding: 0px 7px;
}

.modal-list li .modal-text{
	font-size: 1rem;
	vertical-align: text-bottom;
	font-family: Lato;
}
</style>

</head>
<body style="background-color: #F9F2DF66;">
	<%
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
List<Object[]> projects = (List<Object[]>)request.getAttribute("getAllProjectdata");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
FormatConverter fc = new FormatConverter();
String enduser="--";
List<Object[]> mainProjectList =  projects!=null && projects.size()>0 ? (projects.stream().filter(e-> e[21]!=null && e[21].toString().equals("1")).collect(Collectors.toList())): new ArrayList<Object[]>();
List<Object[]> subProjectList =  projects!=null && projects.size()>0 ? (projects.stream().filter(e-> e[21]!=null && e[21].toString().equals("0")).collect(Collectors.toList())): new ArrayList<Object[]>();
projects.clear();
projects.addAll(mainProjectList);
projects.addAll(subProjectList);
%>
	<div class="container-fluid">
		<div class="carousel-inner" align="center">
			<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">

				<div class="content" align="center"
					style="border-radius: 5px !important; height: 93vh !important;">
					<div align="center"><h2 style="color: #145374 !important;font-family: 'Muli'!important">Project Outline</h2></div>
					<div class="">
						<div class="">
						
			        	<%-- <% for(int i=0;i<mainProjectList.size();i++){ %><%=mainProjectList.get(i)[13] %><%} %>
			        	<% for(int i=0;i<subProjectList.size();i++){ %><%=subProjectList.get(i)[13] %><%} %> --%>
			        	<!-- ----------------------------------Main projects List -------------------------- -->	
			        	<% int val=0;
			        	if(mainProjectList.size()>0){ %>
			        	<h4 style="text-align: left;">Main Project<a  data-toggle="modal"  class="fa faa-pulse animated " data-target="#exampleModal1" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a>
			        	</h4>
							<table style="width: 100%;">
								<thead style="background-color: #ffd8b1; color: black;">
									<tr style="background-color: #ffd8b1; color: black;" >
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
										<tr style="margin-bottom: 15px">
											<td style="text-align: center;font-weight: bold;"><%=1+i %> </td>
											<td style="text-align: center;font-weight: bold;">
												<%=mainProjectList.get(i)[12]!=null?mainProjectList.get(i)[12]:"-" %>
											</td>
											<td style="font-weight: bold;"  >
											<div class="container-fluid">
													<div class="row">
														<div>
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
									<table style="width: 100%;">
									<thead style="background-color: #ffd8b1; color: black;">
										<tr style="background-color: #ffd8b1; color: black;" >
											<th style="width: 2%;">SN</th>
											<th style="width: 5%;">Code</th>
											<th style="width: 35%;">Projects</th>
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
											<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=2+val%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;">
												<td style="text-align: center;font-weight: bold;"><%=1+i %> </td>
												<td style="text-align: center;font-weight: bold;">
													<%=subProjectList.get(i)[12]!=null?subProjectList.get(i)[12]:"-" %>
												</td>
												<td  style="font-weight: bold;margin-top: -20px"  >
													<div class="container-fluid">
														<div class="row">
															<div>
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
</body>
</html>