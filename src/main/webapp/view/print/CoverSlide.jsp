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
</style>

</head>
<body style="background-color: #F9F2DF66;">
	<%
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
String filePath = (String)request.getAttribute("filepath");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
String enduser="--";

%>
	<div class="container-fluid">
		<div class="carousel-inner" align="center">
			<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">

				<div class="content" align="center"
					style="border-radius: 5px !important; height: 93vh !important; padding-top: 5px;">

					<div class="firstpage">

						<div align="center" style="margin-top: 85px">
							<h2
								style="color: #145374 !important; font-family: 'Muli' !important">Presentation</h2>
						</div>
						<div align="center">
							<h3 style="color: #145374 !important">of</h3>
						</div>

						<div align="center">
							<h3 style="color: #4C9100 !important">
								Projects of
								<%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%>
								<%}%>
							</h3>
						</div>

						<div align="center">
							<h3 style="color: #4C9100 !important"></h3>
						</div>
						<table style="margin-top: 35px;" class="executive home-table"
							style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;">
							<tr>
								<th colspan="8" style="text-align: center; font-weight: 700;">
									<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
									<br>
								</th>
							</tr>
						</table>
						<br>
						<div align="center">

							<table style="margin-top: 35px;" class="executive home-table"
								style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;">
								<% if(labInfo!=null){ %>
								<tr>
									<td style="height: 25px"></td>
								</tr>
								<tr>
									<th colspan="8"
										style="text-align: center; font-weight: 700; font-size: 22px">
										<%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %>
										<%}else{ %>LAB NAME<%} %>
									</th>
								</tr>

								<%}%>
								<tr>
									<td style="height: 25px"></td>
								</tr>
								<tr>
									<th colspan="8"
										style="text-align: center; font-weight: 700; font-size: 15px"><br>Government
										of India, Ministry of Defence</th>
								</tr>
								<tr>
									<td style="height: 25px"></td>
								</tr>
								<tr>
									<th colspan="8"
										style="text-align: center; font-weight: 700; font-size: 15px">Defence
										Research & Development Organization</th>
								</tr>
								<tr>
									<td style="height: 25px"></td>
								</tr>
								<tr>
									<th colspan="8"
										style="text-align: center; font-weight: 700; font-size: 15px">
										<%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()%>
										, <%=labInfo.getLabCity()%>
										<%}else{ %>LAB ADDRESS<%} %>
									</th>
								</tr>

							</table>


						</div>

					</div>

				</div>
			</div>
		</div>
</body>
</html>