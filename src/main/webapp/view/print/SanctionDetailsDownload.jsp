	<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal,java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>SanctionDetails</title>
<%Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes"); 
List<Object[]>sanctionlistdetails=(List<Object[]>)request.getAttribute("sanctionlistdetails");
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
NFormatConvertion nfc=new NFormatConvertion();
List<Object[]>projectFiles=(List<Object[]>)request.getAttribute("projectFiles");
List<Object> DocumentId=new ArrayList<>();
	if(!projectFiles.isEmpty()){
	 DocumentId=projectFiles.stream().map(e->e[8]).collect(Collectors.toList());
	 }
%>
<style type="text/css">

td{
	padding : -13px 5px;
}

 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
		@page{             
          size: 790px 1080px;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
          border: 2px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
          @top-right {
          	 
          	 content : "Project : <%=ProjectTitle %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=Labcode%>";
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=Labcode%>";
          }     
 }

 th , td{
 
 font-size: 17px;
 }
 hr{
background:black;
 }
 </style>
</head>
<body>
	<div style="text-align:center;">
		<h3 style="text-align: center;">STATEMENT OF CASE FOR SANCTION OF PROJECT/PROGRAMME</h3><hr style="width:90%">
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:350px;text-align: left;"><h4>1. Name of laboratory:</h4></td>
	<td ><%=Labcode%><hr style="margin:0px;"></td>
	</tr>
	<tr>
	<td style="width:350px;text-align: left"><h4>2. Title of the Project/Programme:</h4></td>
	<td ><%=ProjectDetailes[7] %><hr style="margin:0px;"></td>
	</tr>
		<tr>
	<td style="width:350px;text-align: left"><h4>3. Category of Project:</h4></td>
	<td ><%=ProjectDetailes[4] %><hr style="margin-top:0px;"></td>
	</tr>
		<tr>
	<td style="width:350px;text-align: left"><h4>4. Security classification of Project/Programme: </h4></td>
	<td ><%=ProjectDetailes[5] %><hr style="margin-top:0px;"></td>
	</tr>
	<%--  --%>
		<tr>
	<td style="width:350px;text-align: left"><h4>5. PSQR/GSQR/NSQR/ASQR/JSQR No:<br>&nbsp;&nbsp;&nbsp;&nbsp;(for MM/ TD(S) Projects)	</h4></td>

	<%if(!ProjectDetailes[21].toString().equalsIgnoreCase("1")||ProjectDetailes[21].toString().equalsIgnoreCase("8")) {%>
							<td>Not Applicable<hr></td>
							<%}else {%><td> <hr></td><%} %>
	</tr>
	
	<tr>
	<td style="width:350px;text-align: left"><h4>6. Trial Directive No:(for UT Projects) 	</h4></td>

	<%if(!ProjectDetailes[21].toString().equalsIgnoreCase("6")) {%>
							<td>Not Applicable<hr></td>
							<%}else {%>
							<% int i=0;
							for(Object[]obj:sanctionlistdetails){i++;%>
								<%if(i==9) {%>								
								<%if(obj[3]!=null) {%><td><%=obj[3] %><hr></td><%} else{%><td>Not specified<hr></td><%break;%><%} %>	
							<%}}} %>
	</tr>
	 <tr>
	<td style="width:350px;text-align: left"><h4>7. Cost( &#8377; in Cr):  </h4></td>
	<td ><%if(ProjectDetailes[8]!=null && Double.parseDouble(ProjectDetailes[8].toString())>0){%><%=nfc.convert(Double.parseDouble( ProjectDetailes[8].toString())/10000000 )%> &nbsp;&nbsp;<%} else if(ProjectDetailes[20]!=null &&  Double.parseDouble( ProjectDetailes[20].toString())>0 ){%><%=nfc.convert(Double.parseDouble( ProjectDetailes[20].toString())/10000000 )%>&nbsp;&nbsp;<%}else{ %>-<%} %><hr style="margin-top:0px;"></td>
	</tr>
		<tr>
	<td style="width:350px;text-align: left"><h4>8. Schedule (Months): </h4></td>
	<td ><%if(ProjectDetailes[9]!=null && Integer.parseInt(ProjectDetailes[9].toString())>0){ %><%=ProjectDetailes[9]%><%}else if(ProjectDetailes[18]!=null){ %><%=ProjectDetailes[18]%><%}else{ %>-<%} %><hr style="margin-top:0px;"></td>
	</tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<%
	if(projectFiles.isEmpty()){
		int i=1;
	for(Object[]obj:sanctionlistdetails) {%>
	<tr>
	<td style="width:350px;text-align: left"><h4><%=Integer.parseInt(obj[0].toString())+8+". "+obj[1]  %></h4></td>
	<td align="">No<hr></td>
	</tr>
	
	<%i++;if(i==9)break; %>
	<%}}else{ 
	int i=1;
	for(Object[]obj:sanctionlistdetails){%>
	<tr>
	<td style="width:500px;text-align: left"><h4><%=Integer.parseInt(obj[0].toString())+8+". "+obj[1]  %></h4></td>
	<td align="left">
	<%if(DocumentId.contains(obj[0])) {%>&nbsp;&nbsp;Yes&nbsp;&nbsp;&nbsp;
			<%for(Object[]obj1:projectFiles) {
											if(obj1[8].toString().equalsIgnoreCase(obj[0].toString())){
												String []versiondoc=obj1[6].toString().split("\\.");
												String id=versiondoc[0];
												String subId=versiondoc[1]; %>
								<a style="float: right;" href="ProjectRequirementAttachmentDownload.htm?DocumentId=<%=obj1[8].toString()%>&initiationid=<%=obj1[1].toString() %>&stepid=<%=3%>&id=<%=id %>&subId=<%=subId%> " target="_blank" style="font-size: 12px;">Download</a> 
											
											<%}}%>
		
		<%}
		else{%>&nbsp;&nbsp;No<%}%><hr></td>
	</tr>
	<%i++;if(i==9)break; %>
	<%}} %> 
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:350px;text-align: left"><h4>17. Project Deliverables/Output:  </h4></td>
	<td ><%if(ProjectDetailes[12]!=null && !ProjectDetailes[12].toString().equalsIgnoreCase("")){%>	<%=ProjectDetailes[12] %><%}else{ %>-<%} %><hr style="margin-top:0px;"></td>
	</tr>
		<tr>
	<td style="width:350px;text-align: left"><h4>18. Name of the Project Director/Programme Director (for approval of Competent Authority) : </h4></td>
	<td ><%=ProjectDetailes[1] %><hr style="margin-top:0px;"></td>
	</tr>
	</table>
	
	</div>
</body>
</html>