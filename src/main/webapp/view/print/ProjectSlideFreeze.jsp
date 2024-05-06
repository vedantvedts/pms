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
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />
<style type="text/css">
  
@page {             
          size: 1300px 800px;  	
          border: 6px solid green; 
          border-radius: 5px !important;
	      padding: 15px;  
}
p{
	margin-top: -10px;
}
pre{
	margin-bottom: -10px;
}
ol{
	margin-top: -4px;
}
</style>

</head>
<body style="background-color: #F9F2DF66;">
<%
String review = (String)request.getAttribute("review");
String reviewdate= (String)request.getAttribute("reviewdate");
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
			 <%if(review!=null && reviewdate!=null){%><div align="center" style="margin-top: -5px;"> <b>Review By :- </b><%=review%> &nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=reviewdate %></div><%}%>
				<div align="center" style="padding: 10px" >
				<h2 style="margin-top: -5px; color: #c72626;!important;font-family: 'Muli'!important"><%if(projectdata!=null && projectdata[13]!=null){%><%=projectdata[13]%>(<%=projectdata[12]%>) <%}%> </h2></div>
				<table class="table meeting">
									<tr>
										<td style="width: 286px;font-size: 1.02rem;font-weight: bold; color: #115bc9;width: 100px;">Project No :</td>
										<td style="width: 286px;"><%=projectdata[11]%></td>
										<td rowspan="3">
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projectdata[7]!=null && projectdata[7].toString().length()>350){%> <%=projectdata[7].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[7]%> <%}%></p> 
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projectdata[9]!=null && projectdata[9].toString().length()>350){%> <%=projectdata[9].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[9]%> <%}%> </p>
										   	<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata[8]!=null && projectdata[8].toString().length()>350){%> <%=projectdata[8].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[8]%> <%}%></p>
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
					<table style="padding-top: 5px" class="table meeting">
					<tbody>
					<tr>
					<td style="width: 150px;font-size: 1.02rem;font-weight: bold; color: #115bc9;"><p>Current Status :</p></td>
					<td>
										<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%> <p> <%=projectslidedata[0].toString().substring(0,350)%> </p> <b>...See more</b> <%}else{%> <%=projectslidedata[0]%> <%}%>
					</td>
					</tr>
					
					</tbody>
					</table>
							<p style="width: 286px;font-size: 1.02rem;font-weight: bold; color: #115bc9;padding: 3px">
							<a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File">
							<b>Linked File</b></a> </p>
							
							<table style="width:100% !important ">
							<tbody class=" d-inline-flex justify-content-center" style="width:100% !important; display: grid;place-items: center; ">
								<tr class=" d-inline-flex justify-content-center" style="width:100% !important ">
								
									<td >
									<div style="align-content: center;">	<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
												<img class=" d-flex justify-content-center mx-auto d-block" data-enlargable style="max-height: 300px; display: block; margin: 0 auto;  width: 40%;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
										<%}else{%>IMAGE<% }%>
										</div>
									</td>
								</tr>
							</tbody>
							</table>
									
									
				<%}else{%>
				<%if(review!=null && reviewdate!=null){%><div align="center" style="margin-top: -5px;"> <b>Review By :- </b><%=review%> &nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=reviewdate %></div><%}%>
				<div align="center" style="padding: 3px" ><h2 style="margin-bottom:5px; margin-top: -5px; color: #c72626;!important;font-family: 'Muli'!important"><%if(projectdata!=null && projectdata[13]!=null){%><%=projectdata[13]%>(<%=projectdata[12]%>) <%}%> </h2></div>
						<table class="table meeting" style="margin-top: -10px; align-items: flex-end;">
									<tr>
										<td style="width:10% !important;   font-size: 1.02rem;font-weight: bold; color: #115bc9;">Project No :</td>
										<td colspan="7" style="width:40% !important; text-align: left;"><%=projectdata[11]%></td>
										<td rowspan="11" style="height:300px !important; position: relative; margin: auto;">
											<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
												<img  style="max-height: 300px; max-width: 1200px; margin-bottom: 5px; margin-bottom: 5px;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">	
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
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">
										Objectives :
										</td>
										<td colspan="7" style="text-align: left;"> 
										 <%if(projectdata[7]!=null && projectdata[7].toString().length()>350){%> <%=projectdata[7].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[7]%> <%}%>  
										
										</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Scope : 
										</td>
										<td colspan="7" style="text-align: left;">
										<%if(projectdata[9]!=null && projectdata[9].toString().length()>350){%>
										 <%=projectdata[9].toString().substring(0,300)%> <b>...See more</b> 
										 <%}else{%> <%=projectdata[9]%> <%}%> 
									   	</td>
								   	</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Deliverables : 
										</td>
										<td colspan="7" style="text-align: left;">
										<%if(projectdata[8]!=null && projectdata[8].toString().length()>350){%> <%=projectdata[8].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[8]%> <%}%>
										</td>
									</tr>
									<tr>
										<td colspan="2" style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">
											Current Status :
											</td>
											<td colspan="6"><p>
										<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%> <%=projectslidedata[0].toString().substring(0,350)%><b>...See more</b> <%}else{%> <%=projectslidedata[0]%> <%}%>
										</p></td> 
											
									</tr>
									<tr>
										<td><p><a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File">
											<b>Linked File</b></a></p></td>
									</tr>
						</table>
				<%}%>			
</div>
</body>
</html>