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
List<Object[]> projects = (List<Object[]>)request.getAttribute("getAllProjectdata");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
FormatConverter fc = new FormatConverter();
String enduser="--";

%>
	<div class="container-fluid">
		<div class="carousel-inner" align="center">
			<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">

				<div class="content" align="center"
					style="border-radius: 5px !important; height: 93vh !important;">
					<div align="center"><h2 style="color: #145374 !important;font-family: 'Muli'!important">Project Outline</h2></div>
					<table style="width: 100%;border: 1px solid black; border-collapse: collapse;">
								<tbody>
								
								<tr style="background-color: maroon;color: white;">
										<th style="width: 2%;">SN</th>
										<th style="width: 44%;">Projects</th>
										<th style="width: 8%;">DOS</th>
										<th style="width: 8%;">PDC</th>
										<th style="width: 6%;">Sanction Cost<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Expenditure<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Out Commitment<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Dipl<br>(In Cr, &#8377)</th>
										<th style="width: 6%;">Balance<br>(In Cr, &#8377)</th>
									</tr>
								
									<% if(projects!=null && projects.size()>0) {
										
										for(int i=0;i<projects.size();i++ ){ %>
										<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=2+i%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;border: 1px solid black;">
											<td style="text-align: center;font-weight: bold;border: 1px solid black;height: 30px"><%=1+i %> </td>
											<td style="font-weight: bold;border: 1px solid black"  >
													<%if (projects.get(i) != null )
														if(projects.get(i)[1] != null) { %><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
													<%}%>
												</b>
											</td>
											<%-- <td style="font-weight: bold;text-align: right;">
												<%if (projects.get(i) != null )
													if(projects.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[3].toString())/10000000) %>
												<%}%>
											</td> --%>
											<td style="font-weight: bold;text-align: center;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[5]!= null) { %>
													<%=fc.SqlToRegularDate(projects.get(i)[5].toString())%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: center;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[4]!= null) { %>
													<%=fc.SqlToRegularDate(projects.get(i)[4].toString())%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[3].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[16]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[16].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[17]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[17].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[18]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[18].toString())/10000000)%>
												<%}%>
											</td>
											<td style="font-weight: bold;text-align: right;border: 1px solid black">
												<%if (projects.get(i) != null )
													if(projects.get(i)[19]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(projects.get(i)[19].toString())/10000000)%>
												<%}%>
											</td>
										</tr>
									<%} }%>
								</tbody>
					
							</table>
				</div>
			</div>
		</div>
</body>
</html>