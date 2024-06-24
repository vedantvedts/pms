<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
 import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@page import="java.util.List , java.util.stream.Collectors,com.vts.pfms.*"%>
<%@page import="java.io.File"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1"/>
<style type="text/css">
  
@page {             
          size: 1300px 800px;
          margin: 10px 10px 10px 10px;
          border: 5px solid green;
          /* margin-left: 50px;
          margin-right: 50px;
          margin-buttom: 40px; */   	
}
.data{
 			
			border-radius: 5px;
			padding: 10px;
			margin: 10px;
}
p{
	margin:auto;
}
pre{
	margin-bottom: -10px;
}
ol{
	margin-top: -4px;
}
* {
  box-sizing: border-box;
}

.row {
  display: flex;
  margin-left:-5px;
  margin-right:-5px;
}

.column {
  flex: 50%;
  padding: 5px;
}

table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
   border: 1px solid black; 
}

th, td {
  text-align: left;
  padding: 5px;
  border: 1px solid black; 
}
span{
margin: auto;
}
</style>

</head>
<%
String review = (String)request.getAttribute("review");
String reviewdate= (String)request.getAttribute("reviewdate");
String filePath = (String)request.getAttribute("filepath");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
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
<div  style=" padding: 10px; background-color: #ffd8b1;display: flex;z-index: 100 !important;" >
	<div align="left" style="padding-top:5px;float: left;" >
		<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
	</div>
	<div  style="float: right;margin-top: 30px;" >
		<img style="width: 45px;margin-left: 5px;margin-top: -60px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%= lablogo %>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
	</div>
	<h4 style="text-align: center;float: none; color: black;">
		<%if(projectdata!=null && projectdata[13]!=null){%>
			<%=projectdata[1]%>&nbsp;<%=projectdata[13]%><%=projectdata[12]!=null?"("+projectdata[12]+")":"-"%> 
		<%}%>
	</h4>
	<div style="margin-top: -28px;margin-right: 75px;">
		<p style="font-size: 1.02rem;font-weight: bold; color: #021B79;padding: 3px;margin: 0px 0px 0px 0px;float: right;margin-top: -35px;">
			<%if(new File(filePath +projectdata[25]+projectdata[27]).exists()){%>
			<a href="<%=filePath +projectdata[25]+projectdata[27]%>"  target="_blank" title="PDF File">
				Show More
			</a> 
			<%} %>
		</p>
		<br>
		
		<p style="font-size: 1.02rem;font-weight: bold; color: #021B79;padding: 3px;margin: 0px 0px 0px 0px;float: right;margin-top: -30px;">
			<%if(new File(filePath +projectdata[25]+projectdata[30]).exists()){%>
			<a href="<%=filePath +projectdata[25]+projectdata[30]%>"  target="_blank" title="Video File">
				Show Video
			</a> 
			<%} %>
		</p> 
	</div>
	
</div>
<body>


<div class="data" style="position: relative;" >
<!-----------------------------------------------------------------------   Slide 2   ------------------------------------------------------------------------>
			<%if(projectslidedata[0]!=null && projectslidedata[1].toString().equalsIgnoreCase("2")){%>
			<div style="position: relative; margin-top: 5px;">
					<div style="float: left;width: 100%;position: relative;">
						<table style="font-weight: bold;width: 100%;">
									<tr>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%;">Project No</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%;">DoS</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">PDC</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%">User</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%;">Category</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Cost (In Cr)</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Application</td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Current Stage</td>
									</tr>
									<tr>
										<td colspan="1" style="width: 12%;color: black;"><%=projectdata[11]!=null?projectdata[11]:"--"%></td>
										<td colspan="1" style="width: 12%;color: black;"><%=sdf.format(projectdata[5])%></td>
										<td colspan="1" style="color: black;"><%=sdf.format(projectdata[4])%></td>
										<td colspan="1" style="width: 12%;color: black;"><%=enduser%></td>
										<td colspan="1" style="width: 12%;color: black;"><%=projectdata[2]!=null?projectdata[2]:"--"%></td>
										<td colspan="1" style="color: black;"><%=nfc.convert(cost / 10000000)%></td>
										<td colspan="1" style="color: black;"><%if (projectdata != null && projectdata[10] != null) {%><%=projectdata[10]%><%} else {%>--<%}%></td>
										<td colspan="1" style="color: black;"><%if(projectdata[14]!=null){%><%=projectdata[14]%><%} else {%>--<%}%></td>
									</tr>

									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color:#212529 ; vertical-align: top;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Brief : </b>  </td>
										<td colspan="7" style="font-weight: bold;color:#212529 ">
											<%=projectdata[15]!=null?projectdata[15]:"--"%>
										</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; vertical-align: top;">
											<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
												Objectives :
											</b>
										</td>
										<td colspan="7" style="font-weight: bold;color:#212529 "><%=projectdata[7]!=null?projectdata[7]:"--"%>
										</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; vertical-align: top;">
											<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">Scope : </b>
										</td>
										<td colspan="7" style="font-weight: bold;color:#212529 "><%=projectdata[9]!=null?projectdata[9]:"--"%>
										</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; vertical-align: top;">
											<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">Deliverables : </b> 
										</td>
										<td colspan="7" style="font-weight: bold;color:#212529 "><%=projectdata[8]!=null?projectdata[8]:"--"%>
										</td>
									</tr>
								</table>
					</div>
				</div>
				<br><br><br><br>
				<h4 style="text-align: left;font-size: 1.02rem;font-weight: bold;color:#021B79 ;width: 10%; float: left;margin: 0px; margin-top: 10px;">
					Current Status : 
				</h4>
				<p style="width: 90%; float: right;margin-top: 10px;">
					<%if(projectdata!=null && projectdata[20]!=null) {%>
						<%=projectdata[20]%>
					<%} else{%>-<%} %> 
				</p>
				<br>
				<%if(projectdata[31]!=null && projectdata[31]!=""){%>
					<br>
					<h4 style="text-align: left;font-size: 1.02rem;font-weight: bold;color:#021B79 ;width: 10%; float: left;margin: 0px;">
						Way Forward : 
					</h4>
					<p style="width: 90%; float: right;">
						<%=projectdata[31]%>
					</p>
				<%}%>
				<div style="position: relative;"><p>&nbsp;</p>
				<table style="width:100%;font-weight: bold;height: 100%;position: relative;margin: 1 1 1 1">
				
					<tbody style="width:100%;">
						<tr style="width:100%;">
							<td>
							<div style="align-content: center;">	
								<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
									<img data-enlargable style="max-height: 300px; display: block; margin: 0 auto;  width: 40%;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
								<%}else{%><% }%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
						
				</div>
				<%}else{%>

<!-----------------------------------------------------------------------   Slide 1   ------------------------------------------------------------------------>

				<div style="position: relative;" >
				<table style="font-weight: bold;width: 100%;">
					<tr>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%;">Project No</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%;">DoS</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">PDC</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%">User</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 12%;">Category</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Cost (In Cr)</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Application</td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">Current Stage</td>
					</tr>
					<tr>
						<td colspan="1" style="width: 12%;color: black;"><%=projectdata[11]!=null?projectdata[11]:"--"%></td>
						<td colspan="1" style="width: 12%;color: black;"><%=sdf.format(projectdata[5])%></td>
						<td colspan="1" style="color: black;"><%=sdf.format(projectdata[4])%></td>
						<td colspan="1" style="width: 12%;color: black;"><%=enduser%></td>
						<td colspan="1" style="width: 12%;color: black;"><%=projectdata[2]!=null?projectdata[2]:"--"%></td>
						<td colspan="1" style="color: black;"><%=nfc.convert(cost / 10000000)%></td>
						<td colspan="1" style="color: black;"><%if (projectdata != null && projectdata[10] != null) {%><%=projectdata[10]%><%} else {%>--<%}%></td>
						<td colspan="1" style="color: black;"><%if(projectdata[14]!=null){%><%=projectdata[14]%><%} else {%>--<%}%></td>
					</tr>
				</table>
				<div style="float: left;width: 50%;height: 100%;display: block;margin-top: 13px;">
				
						<table style="margin-top: -10px; align-items: flex-end;height: 100%;font-weight: bold;border-top: none;">
						
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px;border-top: none;">
								<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
								Brief : </b>  </td>
								<td colspan="7" style="text-align: left;color:#212529;border-top: none; ">
									<%=projectdata[15]!=null?projectdata[15]:"--"%>
								</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px;border-top: none;">
									Objectives :
								</td>
								<td colspan="7" style="text-align: left;color:#212529;border-top: none; "><%=projectdata[7]!=null?projectdata[7]:"--"%>
								</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px;vertical-align: top;">Scope :
								</td>
								<td colspan="7" style="text-align: left;color:#212529 "> <%=projectdata[9]!=null?projectdata[9]:"--"%> 
								</td>
						   	</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px;vertical-align: top;">Deliverables : 
								</td>
								<td colspan="7" style="text-align: left;color:#212529 "> <%=projectdata[8]!=null?projectdata[8]:"--"%>
					   			</td>
							</tr>
						
						</table>
						<br><br>
				<h4 style="text-align: left;font-size: 1.02rem;font-weight: bold;color:#021B79 ;width: 20%; float: left; margin-top: 10px;height: 15px">
					Current Status : 
				</h4>
				<p style="width: 80%; float: right;margin-top: 10px;">
					<%if(projectdata!=null && projectdata[20]!=null) {%>
						<%=projectdata[20]%>
					<%} else{%>-<%} %> 
				</p>
				<br>
				<%if(projectdata[31]!=null && projectdata[31]!=""){%>
					<br>
					<h4 style="text-align: left;font-size: 1.02rem;font-weight: bold;color:#021B79 ;width: 20%; float: left;margin: 0px;">
						Way Forward : 
					</h4>
					<p style="width: 80%; float: right;">
						<%=projectdata[31]%>
					</p>
				<%}%>
					</div>
					<div style="float: right;width: 50%;align-content: center;">
					<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
									<img  data-enlargable height="500" style=" max-width: 75%; display: block; margin: 0 auto;  width: 75%;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
								<%}else{%><% }%>
					</div>
					<p>&nbsp;</p>
					</div>
				<%}%>
</div>
</body>
</html>