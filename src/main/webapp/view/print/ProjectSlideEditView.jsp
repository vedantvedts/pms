<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"
 import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@page import="java.util.List , java.util.stream.Collectors,com.vts.pfms.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="shortcut icon" type="image/png" href="view/images/drdologo.png">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />
<title>PMS</title>
<style type="text/css">
[type=radio] { 
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
}

.meeting thead tr td{
	font-family: 'Muli',sans-serif;
	font-size: 16px !important
}

/* IMAGE STYLES */
[type=radio] + img {
  cursor: pointer;
}

/* CHECKED STYLES */
[type=radio]:checked + img {
  border: 1px solid #fff;
  box-shadow: 0 0 3px 3px #5b45b1;
  transition: 500ms all;
}

.fixed-table tbody .custom-td{
	padding-left : 1rem !important;
}

.fixed-table tbody .custom-td .col-md-11, .fixed-table tbody .custom-td .col-md-10 {
	padding-left : 25px !important;
}

.tableFixHead          { overflow: auto; }
.tableFixHead thead td { position: sticky; }
.tableFixHead thead td {background-color: #1363DF}

.modal-xl{
	max-width: 1200px;
}
pre{
	margin-bottom: -6px;
}
ol{
	margin-top: -4px;
}
</style>
</head>
<body style="background-color: #F9F2DF66;" class="slides-container" id="slides-container">
<%
List<Object[]> freezedslide = (List<Object[]>)request.getAttribute("freezedSlidedata");
List<Object[]> getAllProjectSlidedata=(List<Object[]>)request.getAttribute("getAllProjectSlidedata");
String filePath = (String)request.getAttribute("filepath");
Object[] projectslidedata = (Object[])request.getAttribute("projectslidedata");
Object[] projectdata = (Object[])request.getAttribute("projectdata");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
double cost = Double.parseDouble(projectdata[3].toString());
String enduser="--";
if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IA")){
	enduser="Indian Army";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IN")){
	enduser="Indian Navy";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IAF")){
	enduser="Indian Air Force";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IH")){
	enduser="Home Land Security";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("DRDO")){
	enduser="DRDO";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("OH")){
	enduser="Others";
}
%>

<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<div align="center">
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>
<div id="presentation-slides" class="carousel slide " data-ride="carousel">
	<div class="carousel-inner" align="center">
	<!-- ----------------------------------------  View  Div ----------------------------------------------------- -->
		<div class="carousel-item active" >
		<div class="col-lg">
						</div>
			<div class="container-fluid"  >
				<div class="card shadow-nohover" id="slide2" style="border: 6px solid green;border-radius: 5px !important;height:90vh !important;">
						<%
						if (getAllProjectSlidedata != null && getAllProjectSlidedata.size() > 0) {
						%><div align="center"><b>Review By :- </b><%=getAllProjectSlidedata.get(0)[4]%> &nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=sdf.format(getAllProjectSlidedata.get(0)[5])%></div><%
						 }
 							%>
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%></h4>
						<hr style="margin-top: -5px;">
					<div class="card-body" style="padding: 0.25rem; margin-top: -14px;" align="center">
						<div class="row">
							<div class="col-md-4">
							<div class="row"><div class="col">
								<table class="table meeting">
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold; color: #115bc9;width: 150px;">Project No :</td>
										<td style="width: 286px;"><%=projectdata[11]%></td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; width: 80px;">User :</td>
										<td style="width: 150px;"><%=enduser%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Category :</td>
										<td><%=projectdata[2]%></td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">DoS :</td>
										<td><%=sdf.format(projectdata[5]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Cost Rs.:</td>
										<td><%=nfc.convert(cost/10000000)%> (In Cr)</td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">PDC :</td>
										<td><%=sdf.format(projectdata[4]) %></td>
									</tr>
									
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Application :</td>
										<td colspan="4"><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
									</tr>
								</table>
								</div>
								</div>
							</div>
							<div class="col-md-6">
								<table class="table meeting">
									<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projectdata[7]!=null && projectdata[7].toString().length()>320){%> <%=projectdata[7].toString().substring(0,280)%><span onclick="ViewInModel('O')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[7]%> <%}%></td></tr>
									<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b><%if(projectdata[9]!=null && projectdata[9].toString().length()>320){%> <%=projectdata[9].toString().substring(0,280)%><span onclick="ViewInModel('S')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[9]%> <%}%></td></tr>
									<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata[8]!=null && projectdata[8].toString().length()>320){%> <%=projectdata[8].toString().substring(0,280)%><span onclick="ViewInModel('D')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[8]%> <%}%></td></tr>
								</table>
								<div class="col" align="left">
								<div class="row" align="left" >
								<div class="col-2" style="padding: 0px !important" align="center">
								<p style="font-size: 1.02rem;font-weight: bold;color: #115bc9;"> Current Status:</p>

								</div>
								<div class="col" style="padding: 0px !important;font-size: 1.02rem" align="left">
							<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>300){%> <%=projectslidedata[0].toString().substring(0,250)%><span onclick="ViewInModel('Status')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span> <%}else{%> <%=projectslidedata[0]%> <%}%>

								</div>
								</div>
							</div>
							
							</div>
						</div>	
						<div class="row">
							<div class="col-md-2" align="left">
								
								   <a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projectslidedata[4]%>"  target="_blank" title="PDF File"><b>Linked File</b></a>
							</div>
						</div>
						
							<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
								<img data-enlargable style="max-height:300px; max-width:1200px; margin-bottom: 5px;position: relative;display: flex;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
								<hr>
							<%}%>
					</div>
				</div>
					<div class="card shadow-nohover" id="slide1" style="border: 6px solid green;border-radius: 5px !important;height:90vh !important;">
					<%if(getAllProjectSlidedata!=null && getAllProjectSlidedata.size()>0){%><div align="center"> <b>Review By :- </b><%=getAllProjectSlidedata.get(0)[4]%> &nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=sdf.format(getAllProjectSlidedata.get(0)[5]) %></div><%}%>
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%></h4>
						<hr style="margin-top: -5px;">
					<div class="card-body" style="padding: 0.25rem;margin-top: -14px;" align="center">
						<div class="row">
							<div class="col-md-5">
							<div class="row"><div class="col">
							<table class="table meeting" style="margin-bottom: -11px;">
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold; color: #115bc9;width: 150px;">Project No :</td>
										<td style="width: 286px;"><%=projectdata[11]%></td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; width: 80px;">User :</td>
										<td style="width: 150px;"><%=enduser%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Category :</td>
										<td><%=projectdata[2]%></td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">DoS :</td>
										<td><%=sdf.format(projectdata[5]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Cost Rs.:</td>
										<td><%=nfc.convert(cost/10000000)%> (In Cr)</td>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">PDC :</td>
										<td><%=sdf.format(projectdata[4]) %></td>
									</tr>
									
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Application :</td>
										<td colspan="4"><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
									</tr>
								</table>
										</div>
										<div>
										</div>
										</div>
										<br>
										<br>
										<br>
								  	 	<table class="table meeting" style="margin-top: -11px;">
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projectdata[7]!=null && projectdata[7].toString().length()>320){%> <%=projectdata[7].toString().substring(0,280)%><span onclick="ViewInModel('O')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[7]%> <%}%></td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projectdata[9]!=null && projectdata[9].toString().length()>320){%> <%=projectdata[9].toString().substring(0,280)%><span onclick="ViewInModel('S')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[9]%> <%}%> </td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata[8]!=null && projectdata[8].toString().length()>320){%> <%=projectdata[8].toString().substring(0,280)%><span onclick="ViewInModel('D')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[8]%> <%}%></td></tr>
										</table>
								<div class="row">
									<div class="col-md-12" align="left">
										<label style="font-size: 1.02rem;font-weight: bold;color: #115bc9;"> Current Status :</label>
										<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%> <%=projectslidedata[0].toString().substring(0,350)%><span onclick="ViewInModel('Status')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span> <%}else{%> <%=projectslidedata[0]%> <%}%>
										<br><a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projectslidedata[4]%>"  target="_blank" title="PDF File"><b>Linked File</b></a>
									</div>
								</div>		
							</div>
							<div class="col-md-7">
									<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
										<img data-enlargable style="max-height: 75%; max-width: 75%; margin-bottom: 5px;position: relative;display: flex;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
									<%}%>
							</div>
						</div>	
					</div>
					<hr>
				</div>			
			</div>	
			<div class="row" style="margin-top: 10px;">
					<div class="col">
					<p style="padding-left: 25px"><b style="color: red;">Note:-</b> Slide-1 Image Dimensions :- 3400 * 4600  &nbsp;&nbsp;&nbsp;  Slide-2 Image Dimensions :- 6000 * 3300</p>
					</div>
					<div class="col-2">
						<div class="form-group">
							 <b>Slide 1 :</b> <span class="mandatory">*</span>
									<img src="view/images/Slide1.png" onclick="onclickslide(1)" id="image1"
								alt="Option 1" style="height: 40px; width: 45px; cursor: pointer;" />
						</div>
					</div>
					<div class="col-2">
						<div class="form-group">
							<b>Slide 2 : </b><span class="mandatory">*</span>
								<img src="view/images/Slide2.png"  onclick="onclickslide(2)" id="image2" 
								alt="Option 2" style="height: 40px; width: 45px; cursor: pointer;" />
						</div>
					</div>
							
						</div>
		</div>
		
		<!-- ----------------------------------------  View  Close ----------------------------------------------------- -->
		
		
		<!-- ----------------------------------------  Edit  Div ----------------------------------------------------- -->
		 <div class="carousel-item " >
			<div class="container-fluid" style="margin-top:8%" >
				<div class="card shadow-nohover" style="border-radius: 36px;border-color: green; border-width: 6px;">
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%></h4>
					<hr style="margin-top: -5px;">
					<div class="card-body" style="padding: 0.25rem;margin-top: -5px;">
					<br>
						<div class="row" >
								<div class="col" >
									<div class="row">
										<div class="col">
											<table class="table meeting">
												<tr>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9; width: 150px;">Project
														Name :</td>
													<td style="width: 286px;"><%=projectdata[11]%></td>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9; width: 80px;">User
														:</td>
													<td style="width: 150px;"><%=enduser%></td>
												</tr>
												<tr>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">Category
														:</td>
													<td><%=projectdata[2]%></td>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">DoS
														:</td>
													<td><%=sdf.format(projectdata[5])%></td>
												</tr>
												<tr>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">Cost
														Rs.:</td>
													<td><%=nfc.convert(cost / 10000000)%> (In Cr)</td>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">PDC
														:</td>
													<td><%=sdf.format(projectdata[4])%></td>
												</tr>

												<tr>
													<td
														style="font-size: 1.02rem; font-weight: bold; color: #115bc9;">Application
														:</td>
													<td colspan="4">
														<%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%>
														<%}else{%> -- <%}%>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
								<div class="col">
								<table class="table meeting">
										<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projectdata[7]!=null && projectdata[7].toString().length()>320){%> <%=projectdata[7].toString().substring(0,280)%><span onclick="ViewInModel('O')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span><%}else{%> <%=projectdata[7]%> <%}%></td></tr>
										<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b><%if(projectdata[9]!=null && projectdata[9].toString().length()>320){%> <%=projectdata[9].toString().substring(0,280)%><span onclick="ViewInModel('S')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span> <%}else{%> <%=projectdata[9]%> <%}%></td></tr>
										<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata[8]!=null && projectdata[8].toString().length()>320){%> <%=projectdata[8].toString().substring(0,280)%><span onclick="ViewInModel('D')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span> <%}else{%> <%=projectdata[8]%> <%}%></td></tr>
								</table>
							</div>
						</div>	
						<br>
						<hr style="margin: 0px 0px !important;">
						<br>
							
						
						
						
						
						 <form action="EditProjectSlides.htm" method="post" enctype="multipart/form-data" id="formslide">	
						 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						 <input type="radio" name="silde" value="1" <%if(projectslidedata!=null && projectslidedata[1]!=null)if( projectslidedata[1].toString().equalsIgnoreCase("1")){%> checked="checked" <%}%> />
						 <input type="radio" name="silde" value="2" <%if(projectslidedata!=null && projectslidedata[1]!=null)if( projectslidedata[1].toString().equalsIgnoreCase("2")){%> checked="checked" <%}%> />
						 
						<div class="card" style="border-radius: 30px" >
							 <div class="card-body">
							 <div class="container-fluid">
							 	<div class="row" >
									<div class="col">
										<div class="form-check form-check-inline" >
													<label class="form-check-label" for="Status"> <b>Current Status </b> <span class="mandatory">*</span></label>
										</div>
										<textarea class="form-control" placeholder="Enter Maximum 5000 charcters" name="Status" id="ckeditor1" rows="5" cols="20" maxlength="5"   required="required"> </textarea>
									</div>
									<div class="col">
									
									<div class="container-fluid" >
										<div class="row">				                    		
				                    		<div class="col">
				                        		<div class="form-group">
				                        		<div class="col" >		
		                            				<label  ><b> Image : </b></label><span class="mandatory">*</span><a href="SlideAttachDownload.htm?slideId=<%=projectslidedata[4]%>"  target="_blank"><i class="fa fa-download fa-2x"></i></a>
												</div>
				                        		<div class="col" >
				                              		<input  class="form-control form-control"  type="file"  name="Attachment1" accept="image/png, image/jpeg" id="Attachment1" required="required" maxlength="3" style="font-size: 15px;"> 
												</div>
				                        		</div>
				                    		</div>
					                        <div class="col">
				                        		<div class="form-group">
				                        		<div class="col" >
													<label  ><b> Attachment : </b></label><span class="mandatory">*</span>
													<a href="SlidePdfAttachDownload.htm?slideId=<%=projectslidedata[4]%>"  target="_blank"><i class="fa fa-download fa-2x"></i></a>

												</div>
				                        		<div class="col">
													<input  class="form-control form-control"  type="file" name="Attachment2" id="Attachment2" accept="application/pdf, application/vnd.ms-excel" required="required" maxlength="3" style="font-size: 15px;"> 
												</div>
					                        
				                        		</div>
		                    				</div>
				                    	</div>
				                    </div>
				                    	
				                    	<br><br><br><br>
				                    	<button type="button"  class="btn btn-primary btn-sm add"  onclick="return checkData()">SUBMIT </button>
										<%if(freezedslide!=null && freezedslide.size()==0){ %>
										<button type="button"  class="btn btn-sm prints my-2 my-sm-0"  data-toggle="modal" data-target="#newfilemodal">FREEZE </button>
										<%}%>
									</div>							 	
							 	</div>
							 </div>
									<div align="center">
										<input type="hidden" name="ProjectslideId" value="<%=projectslidedata[4]%>">
										<input type="hidden" name="ProjectId" value="<%=projectdata[0]%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</div>
							</div>
						</div>
						</form> 
					</div>
				</div>			
			</div> 
	<!-- ----------------------------------------  Edit  Close ----------------------------------------------------- -->	
		</div>
		<div class="carousel-item" >
			<div class="container-fluid">
			<%List<Object[]> FreezingHistory = (List<Object[]>)request.getAttribute("FreezingData");%>
				<div class="card shadow-nohover" id="slide2" style="border: 6px solid green;border-radius: 5px !important;height:90vh !important;">
				<p class="h1 mx-auto">Freezing History</p>
				
			<table  class="table table-bordered table-hover table-striped table-condensed" id="myTable">
			  <thead>
			    <tr>
			      <th style="width: 3%;">SN</th>
			      <th style="width: 25%;" >Reviewed By</th>
			      <th style="width: 25%;" >Freezed Date</th>
			      <th style="width: 25%;" >Freezed Slide</th>
			    </tr>
			  </thead>
			  <tbody>
			  <%for(int i=0;i<FreezingHistory.size();i++){ %>
			    <tr>
			      <th scope="row"><%=i+1 %></th>
			      <td style="text-align: center;"><%=FreezingHistory.get(i)[1] %></td>
			      <td style="text-align: center;"><%=sdf.format(FreezingHistory.get(i)[2]) %></td>
			      <td style="text-align: center;"><a href='SlidefileShow.htm?projectid=<%=projectdata[0]%>&freezeid=<%= FreezingHistory.get(i)[5] %>' target="_blank">OpenSlide</a></td>
			    </tr>
			    <%} %>
			  </tbody>
			</table>
			</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a>
	</div>
</div>

<!-- Modal -->
<div class="modal fade  bd-example-modal-lg" tabindex="-1" role="dialog" id="newfilemodal">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Project Slide Freeze </h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body" align="center">
							<form action="SlideFreezeSubmit.htm" method="post" autocomplete="off" id="editform" >
								<table>
									<tr>
										<th style="padding: 10px 0px;border: 0px solid black; width: 10% ;"> Review By :</th>
										<td style="padding: 10px 0px; border: 0px solid black; "> 
											<input type="text" name="review" class="form-control" id="reviewby" maxlength="100" required="required">
										</td>
									</tr>
									<tr>
										<th style="padding: 10px 0px;border: 0px solid black; width: 10% ;"> Review Date  :</th>
										<td style="padding: 10px 0px;border: 0px solid black;  width: 30% ; "  >
											<input type="text" style="width: 150px;" name="reviewdate" value="" class="form-control" id="modalipdc1"  readonly required >
										</td>
									</tr>
								</table>
								<button type="submit" class="btn btn-sm submit" id="modalsubmitbtn" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
								<input type="hidden" name="ProjectId" value="<%=projectdata[0]%>">
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="recdecmodel"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true" >
				<div class="modal-dialog modal-xl" role="document">
					<div class="modal-content"  >
						<div class="modal-header" style="background-color: rgba(0,0,0,.03);">
					    	<h4 class="modal-title" id="model-card-header" style="color: #145374"> <span id="val1"></span> </h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
					          <span aria-hidden="true">&times;</span>
					        </button>
					    </div>
						<div class="modal-body" style="max-height: 25rem; overflow-y:auto;">
			  	      		<div class="row">
								<div class="col-md-12" > 
										<span id="Objective" style="display: none;"><%=projectdata[7]%></span>
										<span id="Scope" style="display: none;"><%=projectdata[9]%></span>
										<span id="Deliverable" style="display: none;"><%=projectdata[8]%></span>
										<span id="projectdata2" style="display: none;"><%=projectslidedata[0]%></span>
			  	      		    </div>
			  	      		</div>
  	      				</div>		
					</div>
				</div>
			</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});


<% if(projectslidedata[1]!=null)if(projectslidedata[1].toString().equalsIgnoreCase("1")){ %>
		document.getElementById('slide1').style.display='block';
		document.getElementById('slide2').style.display='none';
		radio = document.getElementById("image2");radio.style.boxShadow=""
			radio = document.getElementById("image1");
			radio.style.boxShadow="0 0 3px 3px #28a745"
			console.log(radio.style.boxShadow );
		<%}%>
		<% if(projectslidedata[1]!=null)if(projectslidedata[1].toString().equalsIgnoreCase("2")){ %>
		document.getElementById('slide1').style.display='none';
		document.getElementById('slide2').style.display='block';
		radio = document.getElementById("image1");radio.style.boxShadow=""
			radio = document.getElementById("image2");
			radio.style.boxShadow="0 0 3px 3px #28a745"
			console.log(radio.style.boxShadow );
		<%}%>
 AjaxForStatus()

function AjaxForStatus() {
	 $.ajax({
		type : "GET",
		url : "GetSlidedata.htm",
		data : {
			slideid : <%=projectslidedata[4]%>,
		},
		datatype : 'json',
		success : function(results){
			var result = JSON.parse(results);
			CKEDITOR.instances['ckeditor1'].setData(result.Status);
		}
	});
}

var editor_config = {
	
	maxlength: '4000',
	toolbar: [{
	          name: 'clipboard',
	          items: ['PasteFromWord', '-', 'Undo', 'Redo']
	        },
	        {
	          name: 'basicstyles',
	          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
	        },
	        {
	          name: 'links',
	          items: ['Link', 'Unlink']
	        },
	        {
	          name: 'paragraph',
	          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
	        },
	        {
	          name: 'insert',
	          items: ['Image', 'Table']
	        },
	        {
	          name: 'editing',
	          items: ['Scayt']
	        },
	        '/',

	        {
	          name: 'styles',
	          items: ['Format', 'Font', 'FontSize']
	        },
	        {
	          name: 'colors',
	          items: ['TextColor', 'BGColor', 'CopyFormatting']
	        },
	        {
	          name: 'align',
	          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
	        },
	        {
	          name: 'document',
	          items: ['Print', 'PageBreak', 'Source']
	        }
	      ],
	     
	    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

		customConfig: '',

		disallowedContent: 'img{width,height,float}',
		extraAllowedContent: 'img[width,height,align]',

		height: 150,
		
		 contentsCss: [CKEDITOR.basePath +'mystyles.css' ], 

		bodyClass: 'document-editor',
		format_tags: 'p;h1;h2;h3;pre',
		
		removeDialogTabs: 'image:advanced;link:advanced',
		
		stylesSet: [
		
			{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
			{ name: 'Cited Work', element: 'cite' },
			{ name: 'Inline Quotation', element: 'q' },

			
			{
				name: 'Special Container',
				element: 'div',
				styles: {
					padding: '5px 10px',
					background: '#eee',
					border: '1px solid #ccc'
				}
			},
			{
				name: 'Compact table',
				element: 'table',
				attributes: {
					cellpadding: '5',
					cellspacing: '0',
					border: '1',
					bordercolor: '#ccc'
				},
				styles: {
					'border-collapse': 'collapse'
				}
			},
			{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
			{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } },
			]
	} ;
CKEDITOR.replace('ckeditor1', editor_config );


function onclickslide(slidenum)
{
	if(slidenum==1 && document.getElementById('slide2').style.display=='block'){
		$("input[name='silde']")[0].checked= true;
		$("input[name='silde']")[1].checked= false;
		console.log(document.getElementsByName('silde'))
		radio = document.getElementById("image1");
		radio.style.boxShadow="0 0 3px 3px #28a745";
		if(confirm("Are You Sure To Submit")){
		document.getElementById('slide1').style.display='block';
		document.getElementById('slide2').style.display='none';
		var silde = $("input[name='silde']").serializeArray();
		
		var datastring = $("#formslide").serialize();
		console.log(document.getElementById('silde'));
		$('#formslide').submit();
		event.preentDefault;
		}
		else {
			radio = document.getElementById("image1");radio.style.boxShadow=""
			radio = document.getElementById("image2");
			radio.style.boxShadow="0 0 3px 3px #28a745"
			console.log(radio.style.boxShadow );
		}
	}
	else if(slidenum==2 && document.getElementById('slide1').style.display=='block'){
		$("input[name='silde']")[0].checked= false;
		$("input[name='silde']")[1].checked= true;
		
		var datastring = $("#formslide").serialize();
		console.log(datastring);
		radio = document.getElementById("image2");
		radio.style.boxShadow="0 0 3px 3px #28a745";
		
		if(confirm("Are You Sure To Submit")){
		document.getElementById('slide2').style.display='block';
		document.getElementById('slide1').style.display='none';
		
		var silde = $("input[name='silde']").serializeArray();
		console.log(document.getElementById('silde'));
		
		var datastring = $("#formslide").serialize();
		console.log(datastring);
		$('#formslide').submit();
		event.preentDefault;
		}
		else {
			let radio = document.getElementById("image1");radio.style.boxShadow="0 0 3px 3px #28a745";
			console.log(radio.style.boxShadow )
		      
		      	radio = document.getElementById("image2");radio.style.boxShadow="";
		      	$("input[name='silde']")[0].checked= false;
				$("input[name='silde']")[1].checked= true;
				var silde = $("input[name='silde']").serializeArray();
				console.log(silde);
		      
		}
	}
	else
		{
		<% if(projectslidedata[1]!=null)if(projectslidedata[1].toString().equalsIgnoreCase("1")){ %>
		document.getElementById('slide1').style.display='block';
		document.getElementById('slide2').style.display='none';
		radio = document.getElementById("image2");radio.style.boxShadow=""
			radio = document.getElementById("image1");
			radio.style.boxShadow="0 0 3px 3px #28a745"
			console.log(radio.style.boxShadow );
		<%}%>
		<% if(projectslidedata[1]!=null)if(projectslidedata[1].toString().equalsIgnoreCase("2")){ %>
		document.getElementById('slide1').style.display='none';
		document.getElementById('slide2').style.display='block';
		radio = document.getElementById("image1");radio.style.boxShadow=""
			radio = document.getElementById("image2");
			radio.style.boxShadow="0 0 3px 3px #28a745"
			console.log(radio.style.boxShadow );
		<%}%>
		}
}

function checkData(){
	var silde = $("input[name='silde']").serializeArray();
	var status = CKEDITOR.instances['ckeditor1'].getData();
	var attachment  = $("#Attachment").val();
	
	if(status=='' || status=='null' || status==null){
		alert("Please Enter the Status Data!");
		  event.preventDefault();
		  return false;
	} else if(status.length>5000){
		alert("Status Data is Too Long!");
		  event.preventDefault();
		  return false;
	}else if (silde.length === 0){
		  alert("Please Select Atleast One Silde!");
		  event.preventDefault();
		  return false;
	 }else{
		 if(confirm("Are you sure to submit?")){
			 $("#formslide").submit();
			  event.preventDefault();
			 return true;
		 }else{
			 return false;
		 }
	 }
}
$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})
window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 4000);


$('#modalipdc1').daterangepicker({
	
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	},
});

function ViewInModel(val) {
	document.getElementById("Deliverable").style.display='none';
	document.getElementById("Scope").style.display='none';
	document.getElementById("Objective").style.display='none';
	document.getElementById("projectdata2").style.display='none';
	console.log(val);
	if("O"==val){
		console.log("QQQQQQQ");
		document.getElementById("Objective").style.display='';
		$("#val1").html("Objectives");
	}else if("S"==val){
		document.getElementById("Scope").style.display='';
		$("#val1").html("Scope");
	}else if("D"==val){
		document.getElementById("Deliverable").style.display='';
		$("#val1").html("Deliverables");
	}else if("Status"==val){
		$("#val1").html("Status");
		document.getElementById("projectdata2").style.display='';
	}
	$('#recdecmodel').modal('toggle');
}
</script>
</html>
