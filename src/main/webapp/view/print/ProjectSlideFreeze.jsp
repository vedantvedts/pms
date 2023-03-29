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
			 <%if(review!=null && reviewdate!=null){%><div align="left" style="margin-top: -5px;"> <b>Review By :- </b><%=review%> &nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=reviewdate %></div><%}%>
				<div align="center" ><h2 style="margin-top: -5px; color: #c72626;!important;font-family: 'Muli'!important"><%if(projectdata!=null && projectdata[12]!=null){%><%=projectdata[12]%> <%}%> </h2></div>
				<table class="table meeting" style="margin-top: -30px;">
									<tr>
										<td style="width: 286px;font-size: 1.02rem;font-weight: bold; color: #115bc9;width: 100px;">Project No :</td>
										<td style="width: 286px;"><%=projectdata[11]%></td>
										<td rowspan="7">
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
					<hr>
					<table class="table meeting">
						<tr>
								<td   style="width: 1150px;"><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Status : </b> </td>
								<td style="text-align: left;"><a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File"><b>Linked File</b></a> </td>
						</tr>
						<tr>
							<td colspan="2"><%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>300){%> <%=projectslidedata[0].toString().substring(0,250)%><span onclick="ViewInModel('Status')" style="color:#1176ab;font-size: 14px; cursor: pointer;"><b> ...View More </b></span> <%}else{%> <%=projectslidedata[0]%> <%}%></td>
						</tr>
						<tr>
								<td colspan="2" align="center">
									<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
										<img data-enlargable style="max-height:300px; max-width:1100px; margin-bottom: 5px;margin-top: -10px;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
									<%}%>
								</td>
					      </tr>
					</table>
				<%}else{%>
				<%if(review!=null && reviewdate!=null){%><div align="center" style="margin-top: -5px;"> <b>Review By :- </b><%=review%> &nbsp;&nbsp;&nbsp; <b>Review date :- </b><%=reviewdate %></div><%}%>
				<div align="center" ><h2 style="margin-bottom:5px; margin-top: -5px; color: #c72626;!important;font-family: 'Muli'!important"><%if(projectdata!=null && projectdata[12]!=null){%><%=projectdata[12]%> <%}%> </h2></div>
						<table class="table meeting" style="margin-top: -10px;">
									<tr>
										<td style="width:10% !important;   font-size: 1.02rem;font-weight: bold; color: #115bc9;">Project No :</td>
										<td colspan="7" style="width:40% !important; text-align: left;"><%=projectdata[11]%></td>
										<td rowspan="10" style="width:50% !important;">
											<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
												<img data-enlargable style="max-height: 600px; max-width: 625px; margin-bottom: 5px;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">	
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
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Objectives : </b> <%if(projectdata[7]!=null && projectdata[7].toString().length()>350){%> <%=projectdata[7].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[7]%> <%}%> </p> 
											<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b> <%if(projectdata[9]!=null && projectdata[9].toString().length()>350){%> <%=projectdata[9].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[9]%> <%}%> </p>
										   	<p ><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b> <%if(projectdata[8]!=null && projectdata[8].toString().length()>350){%> <%=projectdata[8].toString().substring(0,300)%><b>...See more</b> <%}else{%> <%=projectdata[8]%> <%}%></p>
										</td>
									</tr>
									<tr>
										<td colspan="6">
											<p><b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Status : </b></p>  
										</td>
										<td colspan="2" style="text-align: right;"><p><a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File"><b>Linked File</b></a></p></td>
									</tr>
									<tr>
										<td colspan="8"><p>
										<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%> <%=projectslidedata[0].toString().substring(0,350)%><b>...See more</b> <%}else{%> <%=projectslidedata[0]%> <%}%>
										</p></td>
									</tr>
						</table>
				<%}%>			
</div>
</body>
</html>