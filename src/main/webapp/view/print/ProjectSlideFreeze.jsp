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
          border-radius: 5px;
	      padding: 15px;  
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
  /*  border: 1px solid #dddddd;  */
}

th, td {
  text-align: left;
  padding: 5px;
   /* border: 1px solid #dddddd;  */
}
span{
margin: auto;
}
</style>

</head>
<body>
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
<div >
			<%if(projectslidedata[0]!=null && projectslidedata[1].toString().equalsIgnoreCase("2")){%>
				<div align="center" style="padding: 10px" >
					<h2 style=" color: #c72626;font-family: 'Muli'">
						<%if(projectdata!=null && projectdata[13]!=null){%>
							<%=projectdata[13]%><%=projectdata[12]!=null?"("+projectdata[12]+")":""%> 
						<%}%> 
					</h2>
				</div>
				<div style="position: relative;">
					<div style="float: left;width: 100%;position: relative;">
						<table style="font-weight: bold;width: 100%;height: 50%;position: relative;" >
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color: #021B79;width: 10%">Project No :</td>
								<td style="width: 20%;color:#212529 "><%=projectdata[11]!=null?projectdata[11]:"--"%></td>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;width: 10%">User :</td>
								<td style="width: 20%;color:#212529 "><%=enduser!=null?enduser:"--"%></td>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;width: 10%">Category :</td>
								<td style="color:#212529 "><%=projectdata[2]!=null?projectdata[2]:"--"%></td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">DoS :</td>
								<td style="color:#212529 "><%=sdf.format(projectdata[5]) %></td>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">Cost Rs.:</td>
								<td style="color:#212529 "><%=nfc.convert(cost/10000000)%> (In Cr)</td>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">PDC :</td>
								<td style="color:#212529 "><%=sdf.format(projectdata[4]) %></td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">Application :</td>
								<td colspan="5" style="color:#212529 "><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color: #021B79;">
									<b style="font-size: 1.09rem;font-weight: bold;color:#021B79  ;">Objectives : </b> 
								</td>
								<td colspan="5" style="color:#212529 ">
									<%if(projectdata[7]!=null && projectdata[7].toString().length()>150){%> <%=projectdata[7].toString().substring(0,150)%><b>...</b>   <%}else{%> <%=projectdata[7]!=null?projectdata[7]:"--"%> <%}if(projectdata[7]==null){%>--<%} %> 
								</td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color: #021B79;">
										<b style="font-size: 1.09rem;font-weight: bold;color:#021B79 ;">Scope : </b>
								</td>
								<td colspan="5" style="color:#212529 "> <%if(projectdata[9]!=null && projectdata[9].toString().length()>150){%> <%=projectdata[9].toString().substring(0,150)%><b>...</b>   <%}else{%> <%=projectdata[9]!=null?projectdata[9]:"--"%> <%}if(projectdata[9]==null){%>--<%} %> 
								</td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">
							   		<b style="font-size: 1.09rem;font-weight: bold;color:#021B79 ;">Deliverables : </b>
							   	</td>
							   	<td colspan="5" style="color:#212529 "> 
							   		<%if(projectdata[8]!=null && projectdata[8].toString().length()>150){%> 
							   			<%=projectdata[8].toString().substring(0,150)%><b>...</b>   <%}else{%> <%=projectdata[8]%> 
							   		<%}if(projectdata[8]==null){%>--<%} %>
						   		</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;">Current Stage
								</td >
								<td colspan="5" style="color:#212529 ">
									 <%if(projectdata[14]!=null && projectdata[14].toString().length()>150){%>
									 	<%=projectdata[14].toString().substring(0, 150)%>  <%}else{%> <%=projectdata[14]!=null?150:"--" %> 
									 <%}%>
								</td> 
							</tr>	
			
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ; vertical-align: top;">Brief :
								</td>
								<td colspan="5" style="color:#212529 ">
									<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>150){%>  <%=projectslidedata[0].toString().substring(0,150)%>
									<b>...</b> 
									<%}else{%> <%=projectslidedata[0]!=null?projectslidedata[0]:"--"%> <%}%>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<table style="width:100%;height: 40%;font-weight: bold;">
					<tbody class=" d-inline-flex justify-content-center" style="width:100% ; display: grid;place-items: center; ">
						<tr class=" d-inline-flex justify-content-center" style="width:100%  ">
							<td>
							<div style="align-content: center;">	
								<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
									<img class=" d-flex justify-content-center mx-auto d-block" data-enlargable style="max-height: 300px; display: block; margin: 0 auto;  width: 40%;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">
								<%}else{%>IMAGE<% }%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<p style="font-size: 1.02rem;font-weight: bold; color: #021B79;padding: 3px;position: relative;margin: 0px 0px 0px 0px;text-align: right;">
					<a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File">
						Show More
					</a> 
				</p>
				<%}else{%>
				<div align="center" style="padding: 3px;display: block;" ><h2 style="margin-bottom:5px; margin-top: -5px; color: #c72626;;font-family: 'Muli'">
					<%if(projectdata!=null && projectdata[13]!=null){%><%=projectdata[13]%>(<%=projectdata[12]%>) <%}%> 
					</h2>
				</div>
				<div style="float: left;width: 50%;height: 100%;display: block;">
						<table style="margin-top: -10px; align-items: flex-end;height: 100%;font-weight: bold;">
							<tr >
								<td style="width:7% ;   font-size: 1.02rem;font-weight: bold; color:#021B79 ;padding-top: 6px; padding-bottom: 6px">Project No :</td>
								<td colspan="4" style="width:20% ; text-align: left;color:#212529 "><%=projectdata[11]%></td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">Category :</td>
								<td colspan="4" style="text-align: left;color:#212529 "><%=projectdata[2]%></td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">Cost Rs.:</td>
								<td colspan="4" style="text-align: left;color:#212529 "><%=nfc.convert(cost/10000000)%> (In Cr)</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">Application :</td>
								<td colspan="7" style="text-align: left;color:#212529 "><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
							</tr>
							 <tr>
							 <td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">User :</td>
								<td colspan="7" style="text-align: left;color:#212529 "><%=enduser%></td>
							 </tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">DoS :</td>
								<td colspan="7" style="text-align: left;color:#212529 "><%=sdf.format(projectdata[5]) %></td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">PDC :</td>
								<td colspan="7" style="text-align: left;color:#212529 "><%=sdf.format(projectdata[4]) %></td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">
									Objectives :
								</td>
								<td colspan="7" style="text-align: left;color:#212529 ">
									<%if(projectdata[7]!=null && projectdata[7].toString().length()>150){%> 
										<%=projectdata[7].toString().substring(0,150)%><b>...</b>   <%}else{%> <%=projectdata[7]!=null?projectdata[7]:"--"%> 
									<%}if(projectdata[7]==null){%>--<%} %> 
								</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">Scope :
								</td>
								<td colspan="7" style="text-align: left;color:#212529 "> 
									<%if(projectdata[9]!=null && projectdata[9].toString().length()>150){%> 
										<%=projectdata[9].toString().substring(0,150)%><b>...</b>   <%}else{%> <%=projectdata[9]!=null?projectdata[9]:"--"%> 
									<%}if(projectdata[9]==null){%>--<%} %> 
								</td>
						   	</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">Deliverables : 
								</td>
								<td colspan="7" style="text-align: left;color:#212529 "> 
						   		<%if(projectdata[8]!=null && projectdata[8].toString().length()>150){%> <%=projectdata[8].toString().substring(0,150)%><b>...</b>   <%}else{%> <%=projectdata[8]!=null?projectdata[8]:"--"%> <%}if(projectdata[8]==null){%>--<%} %>
					   			</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">
									Current Stage :
									</td>
									<td colspan="7" style="text-align: left;color:#212529 "><p>
								 <%if(projectdata[14]!=null){%><%=projectdata[14]%>  <%}else{%> -- <%}%>
								</p></td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color:#021B79 ;padding-top: 6px; padding-bottom: 6px">
									Brief :
								</td>
								<td colspan="6" style="color:#212529 ">
									<p>
										<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>150){%> <%=projectslidedata[0].toString().substring(0,150)%><b>...</b>  <%}else{%> <%=projectslidedata[0]!=null?projectslidedata[0]:"--"%> <%}%>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div style="float: right;width: 50%;margin: auto;">
						<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
							<img  style=" max-height: 350px; width: 575px; margin: auto;" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">	
						<%}%>
					</div>
					<p style="text-align: right;font-weight: bold;color: #021B79;position: relative;">
						<a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File">
							Show More
						</a>
					</p>
				<%}%>
</div>
</body>
</html>