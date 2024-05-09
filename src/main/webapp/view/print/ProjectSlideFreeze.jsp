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
}

th, td {
  text-align: left;
  padding: 5px;
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
					<h2 style="margin-top: -5px; color: #c72626;;font-family: 'Muli'"><%if(projectdata!=null && projectdata[13]!=null){%><%=projectdata[13]%>(<%=projectdata[12]%>) <%}%> 
					</h2>
				</div>
				<div style="position: relative;">
					<div style="float: left;width: 50%;position: relative;">
						<table style="font-weight: bold;width: 100%;height: 50%;position: relative;" >
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;width: 25%">Project No :</td>
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
					<div style="float: right;width: 50%;">
						<table style="font-weight: bold;width: 100%;height: 50%">
						<tr>
							<td style="width: 25%">
								<b style="font-size: 1.09rem;font-weight: bold;color:  #115bc9;">Objectives : </b> 
							</td>
							<td>
								<%if(projectdata[7]!=null && projectdata[7].toString().length()>350){%> <%=projectdata[7].toString().substring(0,300)%>  <%}else{%> <%=projectdata[7]%> <%}if(projectdata[7]==null){%>--<%} %> 
							</td>
						</tr>
						<tr>
							<td>
									<b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b>
							</td>
							<td> <%if(projectdata[9]!=null && projectdata[9].toString().length()>350){%> <%=projectdata[9].toString().substring(0,300)%>  <%}else{%> <%=projectdata[9]%> <%}if(projectdata[9]==null){%>--<%} %> 
							</td>
						</tr>
						<tr>
							<td>
						   		<b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b>
						   	</td>
						   	<td> 
						   		<%if(projectdata[8]!=null && projectdata[8].toString().length()>350){%> <%=projectdata[8].toString().substring(0,300)%>  <%}else{%> <%=projectdata[8]%> <%}if(projectdata[8]==null){%>--<%} %>
					   		</td>
						</tr>
						<tr >
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Current Stage
							</td>
							<td >
								 <%if(projectdata[14]!=null){%><%=projectdata[14]%>  <%}else{%> -- <%}%>
							</td> 
						</tr>	
		
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Brief :
							</td>
							<td>
								<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%>  <%=projectslidedata[0].toString().substring(0,350)%>
								<b>...See more</b> 
								<%}else{%> <%=projectslidedata[0]%> <%}%>
							</td>
						</tr>
					</table>
					</div>
				</div>
				
				
				<table style="width:100%;height: 40%;">
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
				<p style="width: 286px;font-size: 1.02rem;font-weight: bold; color: #115bc9;padding: 3px;position: relative;margin: 0px 0px 0px 0px;">
					<a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File">
						<b>Show More</b>
					</a> 
				</p>
				<%}else{%>
				<div align="center" style="padding: 3px" ><h2 style="margin-bottom:5px; margin-top: -5px; color: #c72626;;font-family: 'Muli'">
					<%if(projectdata!=null && projectdata[13]!=null){%><%=projectdata[13]%>(<%=projectdata[12]%>) <%}%> 
					</h2>
				</div>
				
				<div style="float: left;width: 50%;height: 100%">
						<table class="table meeting" style="margin-top: -10px; align-items: flex-end;height: 100%">
							<tr >
								<td style="width:15% ;   font-size: 1.02rem;font-weight: bold; color: #115bc9;padding-top: 12px; padding-bottom: 12px">Project No :</td>
								<td colspan="4" style="width:20% ; text-align: left;"><%=projectdata[11]%></td>
								
								
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">Category :</td>
								<td colspan="4" style="text-align: left;"><%=projectdata[2]%></td>
								
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">Cost Rs.:</td>
								<td colspan="4" style="text-align: left;"><%=nfc.convert(cost/10000000)%> (In Cr)</td>
								
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">Application :</td>
								<td colspan="7" style="text-align: left;"><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
							</tr>
							 <tr>
							 <td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">User :</td>
								<td colspan="7" style="text-align: left;"><%=enduser%></td>
							 </tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">DoS :</td>
								<td colspan="7" style="text-align: left;"><%=sdf.format(projectdata[5]) %></td>
							</tr>
							<tr>
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">PDC :</td>
								<td colspan="7" style="text-align: left;"><%=sdf.format(projectdata[4]) %></td>
							</tr>
						<tr>
							<td>
									<b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Scope : </b>
							</td>
							<td> <%if(projectdata[9]!=null && projectdata[9].toString().length()>350){%> <%=projectdata[9].toString().substring(0,300)%>  <%}else{%> <%=projectdata[9]%> <%}if(projectdata[9]==null){%>--<%} %> 
							</td>
						</tr>
						<tr>
							<td>
						   		<b style="font-size: 1.09rem;font-weight: bold;color: #115bc9;">Deliverables : </b>
						   	</td>
						   	<td> 
						   		<%if(projectdata[8]!=null && projectdata[8].toString().length()>350){%> <%=projectdata[8].toString().substring(0,300)%>  <%}else{%> <%=projectdata[8]%> <%}if(projectdata[8]==null){%>--<%} %>
					   		</td>
						</tr>
						<tr >
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Current Stage
							</td>
							<td >
								 <%if(projectdata[14]!=null){%><%=projectdata[14]%>  <%}else{%> -- <%}%>
							</td> 
						</tr>	
		
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Brief :
							</td>
							<td>
								<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%>  <%=projectslidedata[0].toString().substring(0,350)%>
								<b>...See more</b> 
								<%}else{%> <%=projectslidedata[0]%> <%}%>
							</td>
						</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">
									Objectives :
								</td>
								<td>
									<%if(projectdata[7]!=null && projectdata[7].toString().length()>350){%> <%=projectdata[7].toString().substring(0,300)%>  <%}else{%> <%=projectdata[7]%> <%}if(projectdata[7]==null){%>--<%} %> 
								</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">Scope : 
								</td>
								<td colspan="7" style="text-align: left;">
								<%if(projectdata[9]!=null && projectdata[9].toString().length()>350){%>
								 <%=projectdata[9].toString().substring(0,300)%> 
								 <%}else{%> -- <%}%> 
							   	</td>
						   	</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">Deliverables : 
								</td>
								<td colspan="7" style="text-align: left;">
								<%if(projectdata[8]!=null && projectdata[8].toString().length()>350){%> <%=projectdata[8].toString().substring(0,300)%> <%}else{%> -- <%}%>
								</td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">
									Current Status :
									</td>
									<td colspan="7" style="text-align: left;"><p>
								 <%if(projectdata[14]!=null){%><%=projectdata[14]%>  <%}else{%> -- <%}%>
								</p></td>
							</tr>
							<tr >
								<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;padding-top: 12px; padding-bottom: 12px">
									Brief :
									</td>
									<td colspan="6"><p>
								<%if(projectslidedata[0]!=null && projectslidedata[0].toString().length()>400){%> <%=projectslidedata[0].toString().substring(0,350)%> <%=projectslidedata[0]%> <%}else{%> -- <%}%>
								</p></td> 
									
							</tr>
							<tr >
								<td style="padding-top: 12px; padding-bottom: 12px"><p><a href="<%=filePath +projectslidedata[3]+projectslidedata[5]%>"  target="_blank" title="PDF File">
									<b>Show More</b></a></p></td>
							</tr>
						</table>
						
						</div>
						<div style="float: right;width: 50%;">
							<%if(new File(filePath + projectslidedata[3] + projectslidedata[2]).exists()){%>
								<img  style="max-height: 300px; max-width: 1200px; margin: auto;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projectslidedata[3] + projectslidedata[2])))%>">	
							<%}%>
						</div>
				<%}%>			
</div>
</body>
</html>