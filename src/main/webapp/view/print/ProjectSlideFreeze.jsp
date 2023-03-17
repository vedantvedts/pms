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
p{
	margin-bottom: -10px;
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
				<div align="center" ><h1 style="margin-top: -10px; color: #c72626;!important;font-family: 'Muli'!important"><%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%> </h1></div>
				<table class="table meeting" style="margin-top: -30px;">
									<tr>
										<td style="width: 286px;font-size: 1.02rem;font-weight: bold; color: #115bc9;width: 100px;">Project No :</td>
										<td style="width: 286px;"><%=projectdata[11]%></td>
										<td rowspan="7">
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%=projectdata[7]%> </p> 
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projectdata!=null && projectdata[9]!=null){%><%=projectdata[9]%><%}else{%> -- <%}%> </p>
										   	<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata!=null && projectdata[8]!=null){%><%=projectdata[8]%><%}else{%> -- <%}%></p>
										</td>
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
					<hr >
					<table class="table meeting">
						<tr>
								<td  colspan="2" style="width: 1150px;"><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Status : </b> <%=projectslidedata[0]%></td>
								<td><a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File"><b>Linked File</b></a> </td>
						</tr>
						<tr>
								<td colspan="3" align="center">
									<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
										<img data-enlargable style="height: 300px; width:1000px; margin-bottom: 5px;margin-top: 15px;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
										
									<%}%>
								</td>
					      </tr>
					</table>

				<%}else{%>
				<div align="center" ><h1 style="margin-bottom:25px; margin-top: -10px; color: #c72626;!important;font-family: 'Muli'!important"><%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%> </h1></div>
				<table class="table meeting" style="margin-top: -30px;">
									<tr>
										<td style="width:10% !important;   font-size: 1.02rem;font-weight: bold; color: #115bc9;">Project No :</td>
										<td colspan="7" style="width:40% !important; text-align: left;"><%=projectdata[11]%></td>
										<td rowspan="9" style="width:50% !important;">
											<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
												<img data-enlargable style="height: 600px; width: 625px; margin-bottom: 5px;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">	
											<%}%>
										</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Category :</td>
										<td colspan="7" style="text-align: left;"><%=projectdata[2]%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Cost Rs.:</td>
										<td colspan="7" style="text-align: left;"><%=nfc.convert(cost/10000000)%> (In Cr)</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">User :</td>
										<td colspan="7" style="text-align: left;"><%=enduser%></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">DoS :</td>
										<td colspan="7" style="text-align: left;"><%=sdf.format(projectdata[5]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">PDC :</td>
										<td colspan="7" style="text-align: left;"><%=sdf.format(projectdata[4]) %></td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Application :</td>
										<td colspan="7" style="text-align: left;"><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
									</tr>	
									<tr>
										<td colspan="8">
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%=projectdata[7]%> </p> 
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projectdata!=null && projectdata[9]!=null){%><%=projectdata[9]%><%}else{%> -- <%}%> </p>
										   	<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata!=null && projectdata[8]!=null){%><%=projectdata[8]%><%}else{%> -- <%}%></p>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<p><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Status: </b> <%=projectslidedata[0]%> </p> 
										</td>
										<td colspan="3"><a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File"><b>Linked File</b></a></td>
									</tr>
					</table>
				<%}%>			
			</div>	
</body>
</html>