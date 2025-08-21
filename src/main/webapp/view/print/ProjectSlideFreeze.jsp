<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
	border: 6px solid green;
	border-radius: 5px !important;
	padding: 10px 15px 10px 15px;         
          /*size: 1300px 800px;
          margin: 10px 10px 10px 10px;
          border: 5px solid green;
           margin-left: 50px;
           margin-right: 50px;*/
           margin: 25px  50px   25px    50px; 
           //      top, right, bottom, left
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
	<h1 style="text-align: center;float: none; color: black;">
		<%if(projectdata!=null && projectdata[13]!=null){%>
			<%=projectdata[1]!=null?StringEscapeUtils.escapeHtml4(projectdata[1].toString()): " - "%>&nbsp;-&nbsp;<%=StringEscapeUtils.escapeHtml4(projectdata[13].toString())%><%=projectdata[12]!=null?"("+StringEscapeUtils.escapeHtml4(projectdata[12].toString())+")":"-"%> 
		<%}%>
	</h1>
	<div style="margin-top: -28px;margin-right: 75px;">
		<p style="font-size: 1.02rem;font-weight: bold; color: #021B79;padding: 3px;margin: 0px 0px 0px 0px;float: right;margin-top: -35px;">
			<%if(new File(filePath +projectdata[25]+projectdata[27]).exists()){%>
			<a href="<%=filePath!=null?StringEscapeUtils.escapeHtml4(filePath): " - " +projectdata[25]!=null?StringEscapeUtils.escapeHtml4(projectdata[25].toString()): " - "+projectdata[27]!=null?StringEscapeUtils.escapeHtml4(projectdata[27].toString()): " - "%>"  target="_blank" title="PDF File">
				Show More
			</a> 
			<%} %>
		</p>
		<br>
		
		<p style="font-size: 1.02rem;font-weight: bold; color: #021B79;padding: 3px;margin: 0px 0px 0px 0px;float: right;margin-top: -30px;">
			<%if(new File(filePath +projectdata[25]+projectdata[30]).exists()){%>
			<a href="<%=filePath!=null?StringEscapeUtils.escapeHtml4(filePath): " - " +projectdata[25]!=null?StringEscapeUtils.escapeHtml4(projectdata[25].toString()): " - "+projectdata[30]!=null?StringEscapeUtils.escapeHtml4(projectdata[30].toString()): " - "%>"  target="_blank" title="Video File">
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
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 7%;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Project No</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 13%;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										DoS</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										PDC</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 13%">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										User</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 13%;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Category</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Cost (In Cr)
										</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Application
										</b></td>
										<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Current Stage</b></td>
									</tr>
									<tr>
										<td colspan="1" style="width: 12%;color: black;"><%=projectdata[11]!=null?StringEscapeUtils.escapeHtml4(projectdata[11].toString()):"--"%></td>
										<td colspan="1" style="width: 12%;color: black;"><%=sdf.format(projectdata[5])%></td>
										<td colspan="1" style="color: black;"><%=sdf.format(projectdata[4])%></td>
										<td colspan="1" style="width: 12%;color: black;"><%=projectdata[6]!=null?StringEscapeUtils.escapeHtml4(projectdata[6].toString()):"--"%></td>
										<td colspan="1" style="width: 12%;color: black;"><%=projectdata[32]!=null?StringEscapeUtils.escapeHtml4(projectdata[32].toString()):"--"%></td>
										<td colspan="1" style="color: black;"><%=nfc.convert(cost / 10000000)%></td>
										<td colspan="1" style="color: black;"><%if (projectdata != null && projectdata[10] != null) {%><%=StringEscapeUtils.escapeHtml4(projectdata[10].toString())%><%} else {%>--<%}%></td>
										<td colspan="1" style="color: black;"><%if(projectdata[14]!=null){%><%=StringEscapeUtils.escapeHtml4(projectdata[14].toString())%><%} else {%>--<%}%></td>
									</tr>

									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color:#212529 ; vertical-align: top;width: 10%">
										<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
										Brief : </b>  </td>
										<td colspan="7" style="font-weight: bold;color:#212529 ">
											<%=projectdata[15]!=null?StringEscapeUtils.escapeHtml4(projectdata[15].toString()):"--"%>
										</td>
									</tr>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; vertical-align: top;">
											<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
												Objectives :
											</b>
										</td>
										<td colspan="7" style="font-weight: bold;color:#212529 "><%=projectdata[7]!=null?StringEscapeUtils.escapeHtml4(projectdata[7].toString()):"--"%>
										</td>
									</tr>
								<%-- 	<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; vertical-align: top;">
											<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">Scope : </b>
										</td>
										<td colspan="7" style="font-weight: bold;color:#212529 "><%=projectdata[9]!=null?projectdata[9]:"--"%>
										</td>
									</tr> --%>
									<tr>
										<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9; vertical-align: top;">
											<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">Deliverables : </b> 
										</td>
										<td colspan="7" style="font-weight: bold;color:#212529 "><%=projectdata[8]!=null?StringEscapeUtils.escapeHtml4(projectdata[8].toString()):"--"%>
										</td>
									</tr>
								</table>
					</div>
				</div>
				<br><br><br><br>
				<p style="width: 100%; float: left;margin-top: 10px;text-align: left;">
					<span style="text-align: left;font-size: 1.02rem;font-weight: bold;color:maroon ;">
						Current Status : 
					</span>
					<%if(projectdata!=null && projectdata[20]!=null) {%>
						<%=StringEscapeUtils.escapeHtml4(projectdata[20].toString()).substring(3,projectdata[20].toString().length()-1 )%>
					<%} else{%>-<%} %>  
				</p>
				<br>
				<%if(projectdata[31]!=null && projectdata[31]!=""){%>
					<br>
					<p style="width: 100%; float: left;text-align: left;">
					<span style="text-align: left;font-size: 1.02rem;font-weight: bold;color:maroon ;">
						Way Forward : 
					</span>
					<%=StringEscapeUtils.escapeHtml4(projectdata[31].toString()).substring(3,projectdata[31].toString().length()-1 )%>
				<%}%>
				<div style="position: relative;"><p>&nbsp;</p>
					<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
						<table style="width:100%;font-weight: bold;height: 100%;position: relative;">
						
							<tbody style="width:100%;border : none;padding: 5px;">
								<tr style="width:100%;height: 300px;border : none;padding: 0px;">
									<td style="border : none;padding: 0px;">
									<div style="align-content: center;padding: 0px;">	
										
											<img data-enlargable style="max-height: 250px; display: block; margin: 0 auto;  width: 40%;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
										
										</div>
									</td>
								</tr>
							</tbody>
							
						</table>
					<%}else{%><% }%>
						
				</div>
				<%}else{%>

<!-----------------------------------------------------------------------   Slide 1   ------------------------------------------------------------------------>

				<div style="position: relative;" >
				<table style="font-weight: bold;width: 100%;border-bottom: 1px solid black;">
					<tr>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 7%;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						Project No</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 13%;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						DoS</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						PDC</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 13%">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						User</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;width: 13%;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						Category</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						Cost (In Cr)
						</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						Application
						</b></td>
						<td colspan="1" style="font-size: 1.2rem; font-weight: bold; color: #021B79;">
						<b style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">
						Current Stage</b></td>
					</tr>
					<tr  >
						<td colspan="1" style="width: 12%;color: black;border-bottom: 0px solid black;"><%=projectdata[11]!=null?StringEscapeUtils.escapeHtml4(projectdata[11].toString()):"--"%></td>
						<td colspan="1" style="width: 12%;color: black;border-bottom: 0px solid black;"><%=sdf.format(projectdata[5])%></td>
						<td colspan="1" style="color: black;border-bottom: 0px solid black;"><%=sdf.format(projectdata[4])%></td>
						<td colspan="1" style="width: 12%;color: black;border-bottom: 0px solid black;"><%=projectdata[6]!=null?StringEscapeUtils.escapeHtml4(projectdata[6].toString()):"--"%></td>
						<td colspan="1" style="width: 12%;color: black;border-bottom: 0px solid black;"><%=projectdata[32]!=null?StringEscapeUtils.escapeHtml4(projectdata[32].toString()):"--"%></td>
						<td colspan="1" style="color: black;border-bottom: 0px solid black;"><%=nfc.convert(cost / 10000000)%></td>
						<td colspan="1" style="color: black;border-bottom: 0px solid black;"><%if (projectdata != null && projectdata[10] != null) {%><%=StringEscapeUtils.escapeHtml4(projectdata[10].toString())%><%} else {%>--<%}%></td>
						<td colspan="1" style="color: black;border-bottom: 0px solid black;"><%if(projectdata[14]!=null){%><%=StringEscapeUtils.escapeHtml4(projectdata[14].toString())%><%} else {%>--<%}%></td>
					</tr>
				</table>
				<div style="float: left;width: 50%;height: 100%;display: block;">
				
						<table style="align-items: flex-end;height: 100%;font-weight: bold;border-top: none;">
						
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;border-top: none; padding-bottom: 6px;vertical-align: top;width: 24%">
										Brief : 
								</td>
								<td colspan="7" style="text-align: left;color:#212529;border-top: none; ">
									<%=projectdata[15]!=null?StringEscapeUtils.escapeHtml4(projectdata[15].toString()):"--"%>
								</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px;vertical-align: top;">
									Objectives :
								</td>
								<td colspan="7" style="text-align: left;color:#212529;border-top: none; "><%=projectdata[7]!=null?StringEscapeUtils.escapeHtml4(projectdata[7].toString()):"--"%>
								</td>
							</tr>
						<%-- 	<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px;vertical-align: top;">Scope :
								</td>
								<td colspan="7" style="text-align: left;color:#212529 "> <%=projectdata[9]!=null?projectdata[9]:"--"%> 
								</td>
						   	</tr> --%>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 0px;vertical-align: top;">Deliverables : 
								</td>
								<td colspan="7" style="text-align: left;color:#212529 "> <%=projectdata[8]!=null?StringEscapeUtils.escapeHtml4(projectdata[8].toString()):"--"%>
					   			</td>
							</tr>
						
						</table>
						<br>
						<p style="width: 80%; float: left;">
							<span style="text-align: left;font-size: 1.02rem;font-weight: bold;color:maroon ;">
								Current Status : 
							</span>
							<%if(projectdata!=null && projectdata[20]!=null) {%>
								<%=StringEscapeUtils.escapeHtml4(projectdata[20].toString()).substring(3,projectdata[20].toString().length()-1 )%>
							<%} else{%>-<%} %>  
						</p>
						<br>
						<%if(projectdata[31]!=null && projectdata[31]!=""){%>
							<br><br><br>
							<p style="width: 80%; float: left;margin-top: 15px;">
							<span style="text-align: left;font-size: 1.02rem;font-weight: bold;color:maroon ;width: 20%; float: left;margin: 0px;">
								Way Forward : 
							</span>
							
							<%=StringEscapeUtils.escapeHtml4(projectdata[31].toString()).substring(3,projectdata[31].toString().length()-1 )%> 
						<%}%>
				</div>
							<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
							<div style="float: right;width: 50%;align-content: center;margin-top: 5px">
											<img  height="475" width="352" style=" max-width: 352px; display: block; margin: 0 auto;  width: 75%;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
							</div>
							<%}else{%><% }%>
								<p>&nbsp;</p>
							</div>
					<%}%>
</div>
</body>
</html>