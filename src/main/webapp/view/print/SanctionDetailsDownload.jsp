	<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal,java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@page import="java.net.URL"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Main</title>
<%Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
Object[] LabList=(Object[])request.getAttribute("LabList"); 
List<Object[]>sanctionlistdetails=(List<Object[]>)request.getAttribute("sanctionlistdetails");
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
NFormatConvertion nfc=new NFormatConvertion();
List<Object[]>projectFiles=(List<Object[]>)request.getAttribute("projectFiles");
List<Object> DocumentId=new ArrayList<>();
	if(!projectFiles.isEmpty()){
	 DocumentId=projectFiles.stream().map(e->e[8]).collect(Collectors.toList());
	 }
	String lablogo=(String)request.getAttribute("lablogo");
	Object[] AllLabList=(Object[])request.getAttribute("AllLabList"); 	
	int port=new URL( request.getRequestURL().toString()).getPort();
	String path="http://localhost:"+port+request.getContextPath()+"/";
	String conPath=(String)request.getContextPath();
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
          size: 790px 1100px;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
 /*          border: 2px solid black;   */  
  
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
 
 .tr-style{
 border:1px solid black;
 }
 


.mainTD{
 color:#021B79;
 font-weight: 600;
 padding: 10px;
 font-size: 15px;
}
 </style>
</head>
<body>
	<div align="center" ><h1 style="font-size:30px !important;color: #145374;" class="heading-color"><br>STATEMENT OF CASE</h1></div>
			<div align="center" >
		
			<table style="margin-left:30px !important;  font-size: 16px;width:650px;" >
			<%
			if(LabList!=null){
			 %>

				<tr>		
				<th colspan="8" style="text-align: center; font-weight: 700;">
					<br><br><br><br><br><br><br><br><br><br><br>
						<img class	="logo" style="width:150px;height: 150px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt=	Configurat	on"<%}else	{ %> alt="File Not Found" <%} %> >
					</th>
				</tr>
				<tr>
					<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px;padding-top: 50px;"></th>
				</tr>
				<tr>
					<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><br><br><br><br><br><br><br><%if(LabList[1]!=null){ %><%=LabList[1] %><%}else{ %>LAB NAME<%} %></th>
				</tr>


				
			
			
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
			</tr>
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
			</tr>
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(LabList[2]!=null){ %><%=LabList[2] %><%}else{ %>LAB NAME<%} %></th>
			</tr> 

				<% } %>


			</table>			 
		
		</div>	
		
		
		
		<div style="page-break-before:always"></div> 
	<div style="text-align:center;">
		<h3 style="text-align: center; color:#021B79;">STATEMENT OF CASE FOR SANCTION OF PROJECT/PROGRAMME</h3>
	<table class="table" style="margin-left:20px; margin-top:15px;border:1px solid black;font-family:FontAwesome; width:650px;border-collapse: none;">
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;boder:1px solid black;">1. Name of laboratory:</td>
	<td  style="border:1px solid black;text-align: left">
	<p><%=LabList[1] %></p>
	</td>
	</tr>
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;">2. Title of the Project/Programme:</td>
	<td  style="border:1px solid black;text-align: left"><p><%=ProjectDetailes[7] %></p></td>
	</tr>
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;">3. Category of Project:</td>
	<td  style="border:1px solid black;text-align: left"><p><%=ProjectDetailes[4] %></p></td>
	</tr>
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black">4. Security classification of Project/Programme: </td>
	<td  style="border:1px solid black;text-align: left"><p><%=ProjectDetailes[5] %></p></td>
	</tr>
	<%--  --%>
		<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;">5. PSQR/GSQR/NSQR/ASQR/JSQR No:<br>&nbsp;&nbsp;&nbsp;&nbsp;(for MM/ TD(S) Projects)	</td>

	<%if(!ProjectDetailes[21].toString().equalsIgnoreCase("1")||ProjectDetailes[21].toString().equalsIgnoreCase("8")) {%>
							<td style="border:1px solid black;text-align: left"><p>Not Applicable</p></td>
							<%}else {%><td style="border:1px solid black;text-align: left">
						<p>	<%=sanctionlistdetails.get(sanctionlistdetails.size()-1)[4]!=null?sanctionlistdetails.get(sanctionlistdetails.size()-1)[4]:"-" %></p>
							 </td><%} %>
	</tr>
	
	<tr   class="tr-style">
	<td class="mainTD"  style="width:350px;text-align: left;border:1px solid black;">6. Trial Directive No:(for UT Projects) 	</td>

	<%if(!ProjectDetailes[21].toString().equalsIgnoreCase("6")) { %>
							<td  style="border:1px solid black;text-align: left"">Not Applicable</td>
							<%}else { %>
							<% int i=0;
							for(Object[]obj:sanctionlistdetails){i++;%>
								<%if(i==9) {%>								
								<%if(obj[3]!=null) {%><td  style="border:1px solid black;text-align: left"><p><%=obj[3] %></p></td><%} else{%><td style="border:1px solid black;text-align: left"><p>Not specified</p></td><%break;%><%} %>	
							<%}}} %>
	</tr>
	 <tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;">7. Cost( &#8377; in Cr):  </td>
	<td style="border:1px solid black;text-align: left"><%if(ProjectDetailes[8]!=null && Double.parseDouble(ProjectDetailes[8].toString())>0){%><p><%=nfc.convert(Double.parseDouble( ProjectDetailes[8].toString())/10000000 )%><p> &nbsp;&nbsp;<%} else if(ProjectDetailes[20]!=null &&  Double.parseDouble( ProjectDetailes[20].toString())>0 ){%><p><%=nfc.convert(Double.parseDouble( ProjectDetailes[20].toString())/10000000 )%></p>&nbsp;&nbsp;<%}else{ %>-<%} %></td>
	</tr>
		<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black">8. Schedule (Months): </td>
	<td style="border:1px solid black;text-align: left"><%if(ProjectDetailes[9]!=null && Integer.parseInt(ProjectDetailes[9].toString())>0){ %><p><%=ProjectDetailes[9]%></p><%}else if(ProjectDetailes[18]!=null){ %><p><%=ProjectDetailes[18]%></p><%}else{ %>-<%} %></td>
	</tr>

	<%
	if(projectFiles.isEmpty()){
		int i=1;
	for(Object[]obj:sanctionlistdetails) {%>
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;padding:10px;"><%=Integer.parseInt(obj[0].toString())+8+". "+obj[1]  %></td>
	<td align="" style="border:1px solid black;text-align: left">No</td>
	</tr>
	
	<%i++;if(i==9)break; %>
	<%}}else{ 
	int i=1;
	for(Object[]obj:sanctionlistdetails){%>
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;padding:10px;"><p><%=Integer.parseInt(obj[0].toString())+8+". "+obj[1]  %></p></td>
	<td align="left" style="border:1px solid black;text-align: left">
	<p><%if(DocumentId.contains(obj[0])) {%>&nbsp;&nbsp;Yes&nbsp;&nbsp;&nbsp;
	<%-- 		<%for(Object[]obj1:projectFiles) {
											if(obj1[8].toString().equalsIgnoreCase(obj[0].toString())){
												String []versiondoc=obj1[6].toString().split("\\.");
												String id=versiondoc[0];
												String subId=versiondoc[1]; %>
												<a style="float: right;" href="<%=path %>ProjectRequirementAttachmentDownload.htm?DocumentId=<%=obj1[8].toString()%>&initiationid=<%=obj1[1].toString() %>&stepid=<%=3%>&id=<%=id %>&subId=<%=subId%> " target="_blank" style="font-size: 12px;">Download</a> 
												<%}}%> --%>
		
		<%}
		else{%>&nbsp;&nbsp;No<%}%></p></td>
	</tr>
	<%i++;if(i==9)break; %>
	<%}} %> 
	
	<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;">17. Project Deliverables/Output:  </td>
	<td style="border:1px solid black;text-align: left"><p><%if(ProjectDetailes[12]!=null && !ProjectDetailes[12].toString().equalsIgnoreCase("")){%>	<%=ProjectDetailes[12] %><%}else{ %>-<%} %></p></td>
	</tr>
		<tr  class="tr-style">
	<td class="mainTD" style="width:350px;text-align: left;border:1px solid black;">18. Name of the Project Director/Programme Director (for approval of Competent Authority) : </td>
	<td style="border:1px solid black;text-align: left"><p><%=ProjectDetailes[1] %></p></td>
	</tr>
	</table>
	
	</div>
</body>
</html>