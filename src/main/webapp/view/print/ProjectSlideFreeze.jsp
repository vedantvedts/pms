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
<jsp:include page="../static/dependancy.jsp"></jsp:include>

<style type="text/css">
#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
}   
@page {             
          size: 1300px 800px; 
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          padding-top: 15px;
          border-radius: 36px;
	      border-color: green; 
	      border-width: 6px;
}

</style>

</head>
<body style="background-color: #F9F2DF66;">
<%
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

		<div class="container-fluid" >
			<%if(projectslidedata[0]!=null && projectslidedata[1].toString().equalsIgnoreCase("2")){%>
				<div class="card shadow-nohover" style="border-radius: 36px;border-color: green; border-width: 6px;">
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%></h4>
					<hr style="margin-top: -5px;">
					<div class="card-body" style="padding: 0.25rem; margin-top: -14px;" >
						<div class="row">
							<div class="col-md-4">
								<table class="table meeting">
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold; color: #115bc9;">Project No :</td>
										<td style="width: 286px;"><%=projectdata[11]%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Category :</td>
										<td><%=projectdata[2]%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Cost Rs.:</td>
										<td><%=nfc.convert(cost/10000000)%> (In Cr)</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">User :</td>
										<td><%=enduser%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">DoS :</td>
										<td><%=sdf.format(projectdata[5]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">PDC :</td>
										<td><%=sdf.format(projectdata[4]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Application :</td>
										<td><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
									</tr>
								</table>
							</div>
							<div class="col-md-8">
								<table class="table meeting">
									<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%=projectdata[7]%></td></tr>
									<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b><%if(projectdata!=null && projectdata[9]!=null){%><%=projectdata[9]%><%}else{%> -- <%}%></td></tr>
									<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%=projectdata[8]%></td></tr>
								</table>
							</div>
						</div>	
						<div class="row">
							<div class="col-md-10" align="left">
								<label style="font-size: 1.02rem;font-weight: bold;color: #115bc9;"> Status:</label>
								<%=projectslidedata[0]%>
							</div>
							<div class="col-md-2" align="left">
								
								   <a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projectslidedata[4]%>"  target="_blank" title="PDF File"><b>Linked File</b></a>
							</div>
						</div>
						
							<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
								<img data-enlargable style="max-width: 28cm; margin-bottom: 5px;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
								<hr>
							<%}%>
					</div>
				</div>
				<%}else{%>
					<div class="card shadow-nohover" style="border-radius: 36px;border-color: green; border-width: 6px;">
					<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;"> <%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%></h4>
						<hr style="margin-top: -5px;">
					<div class="card-body" style="padding: 0.25rem;margin-top: -14px;" >
						<div class="row">
							<div class="col-5">
								<table class="table meeting" style="margin-bottom: -11px;">
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold; color: #115bc9;">Project No :</td>
												<td style="width: 286px;"><%=projectdata[11]%></td>
											</tr>
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Category :</td>
												<td><%=projectdata[2]%></td>
											</tr>
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Cost Rs.:</td>
												<td><%=nfc.convert(cost/10000000)%> (In Cr)</td>
											</tr>
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">User :</td>
												<td><%=enduser%></td>
											</tr>
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">DoS :</td>
												<td><%=sdf.format(projectdata[5]) %></td>
											</tr>
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">PDC :</td>
												<td><%=sdf.format(projectdata[4]) %></td>
											</tr>
											<tr>
												<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Application :</td>
												<td><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
											</tr>
										</table>
								  	<hr style="border-top: 1.9px solid #170960;">
								  	 	<table class="table meeting" style="margin-top: -11px;">
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%=projectdata[7]%></td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b><%if(projectdata!=null && projectdata[9]!=null){%><%=projectdata[9]%><%}else{%> -- <%}%></td></tr>
											<tr><td><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%=projectdata[8]%></td></tr>
										</table>
								<div class="row">
									<div class="col-12" align="left">
										<label style="font-size: 1.02rem;font-weight: bold;color: #115bc9;"> Status:</label>
										<%=projectslidedata[0]%>
										<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projectslidedata[4]%>"  target="_blank" title="PDF File"><b>Linked File</b></a>
									</div>
									
								</div>		
							</div>
							<div class="col-7">
									
									<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
										<img data-enlargable style="max-width: 12cm; margin-bottom: 5px;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
										
									<%}%>
							</div>
						</div>	
					</div>
					<hr>
				</div>
				<%}%>			
			</div>	
</body>
</html>