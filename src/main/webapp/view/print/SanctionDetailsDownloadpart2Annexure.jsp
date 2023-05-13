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
<title>Insert title here</title><%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
List<Object[]> ConsultancyList = (List<Object[]>) request.getAttribute("ConsultancyList");
List<Object[]> CarsList = (List<Object[]>) request.getAttribute("CarsList");
List<Object[]> WorkPackageList = (List<Object[]>) request.getAttribute("WorkPackageList");
List<Object[]> TrainingRequirementList=(List<Object[]>)request.getAttribute("TrainingRequirementList");
List<Object[]> ManpowerList=(List<Object[]>)request.getAttribute("ManpowerList");
Object[] macrodetailsTwo = (Object[]) request.getAttribute("macrodetailsTwo");
Object[]BriefList=(Object[])request.getAttribute("BriefList");
List<Object[]> DetailsList = (List<Object[]>) request.getAttribute("DetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
%>
<style type="text/css">

td{
	padding : -13px 5px;
}
p{
text-align:justify !important;
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
          size:1120px 790px  ;
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
 .border_black{
 	border : 1px solid black;

 }
 hr{
background:black;
 }
 
 .border-black{
 border:1px solid black;
 border-collapse: collapse;
 }
 .border-black td th{
 padding:0px;
 margin: 0px;
 }
 </style>
</head>
<body>
	<div style="text-align:center;">
		<h2 style="text-align: center;color: #145374;text-align:right;margin-right:25px;;">Annexure-A</h2>
		
			<table  id="mytable" class="border-black"
							style="width: 980px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 25px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;">Discipline/Area for Training</th>
								<th class="border-black" style="width:18%;text-align: center;">Agency Contacted</th>
								<th class="border-black" style="width:16%;text-align: center;">No of personnel proposed to be trained</th>
								<th class="border-black" style="width:8%;text-align: center;">Duration</th>
								<th class="border-black" style="width:12%;text-align: center;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:12%;text-align: center;">Remarks</th>
								</tr>
							</thead>
							<tbody>
							<%if(TrainingRequirementList.size()>0){
							int i=0;
								for(Object[]obj:TrainingRequirementList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4] %></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[5] %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(obj[7].toString())/10000000)%></h6></td>
							<td class="border-black " ><h6 style="padding:18px; padding-bottom: 18px;"><%=obj[6] %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7" style="padding:15px;"><h4>Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
		</div>
		<div style="page-break-before:always">&nbsp;</div> 
	<div style="text-align:center;">
		<h2 style="text-align: center;color: #145374;text-align:right;margin-right:25px;;">Annexure-B</h2>
		
			<table  id="mytable" class="border-black"
							style="width: 980px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 25px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;">Name of Govt. Agencies</th>
								<th class="border-black" style="width:20%;text-align: center;">Work Package</th>
								<th class="border-black" style="width:35%;text-align: center;">Objectives & Scope of Work</th>
								<th class="border-black" style="width:10%;text-align: center;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:12%;text-align: center;">Duration<br>(In Months)</th>								
								</tr>
							</thead>
							<tbody>
							<%if(WorkPackageList.size()>0){
							int i=0;
								for(Object[]obj:WorkPackageList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4] %><br><%=obj[5] %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(obj[7].toString())/10000000)%></h6></td>
								<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6] %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7"><h4 style="padding:15px;">Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
		</div>	
		<div style="page-break-before:always">&nbsp;</div> 
		<div style="text-align:center;">
		<h2 style="text-align: center;color: #145374;text-align:right;margin-right:25px;;">Annexure-C</h2>
					<table  id="mytable" class="border-black"
							style="width: 980px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 25px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;">Name of Institute/Agency</th>
								<th class="border-black" style="width:18%;text-align: center;">Name of the identified profesor</th>
								<th class="border-black" style="width:16%;text-align: center;">Area where R&D is required</th>
								<th class="border-black" style="width:12%;text-align: center;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:8%;text-align: center;">Duration</th>
								<th class="border-black" style="width:12%;text-align: center;">Confidence level of the Agency</th>
								</tr>
							</thead>
										<tbody>
							<%if(CarsList.size()>0){
							int i=0;
								for(Object[]obj:CarsList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4] %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(obj[5].toString())/10000000)%></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6] %></h6></td>
							<td class="border-black " ><h6 style="padding:18px; padding-bottom: 18px;"><%=obj[7] %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7" style="padding:15px;"><h4>Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
		</div>	
		<div style="page-break-before:always">&nbsp;</div> 
		<div style="text-align:center;">
		<h2 style="text-align: center;color: #145374;text-align:right;margin-right:25px;">Annexure-E</h2>
					<table  id="mytable" class="border-black"
							style="width: 980px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 25px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;">SN</th>
								<th class="border-black" style="width:25%;text-align: center;">Discipline/Area</th>
								<th class="border-black" style="width:15%;text-align: center;">Agency</th>
								<th class="border-black" style="width:20%;text-align: center;">Name of Person/expert</th>
								<th class="border-black" style="width:12%;text-align: center;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:25%;text-align: center;">Process that will be followed</th>								
								</tr>
							</thead>
							<tbody>
							<%if(ConsultancyList.size()>0){
							int i=0;
								for(Object[]obj:ConsultancyList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4] %><br></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(obj[5].toString())/10000000)%></h6></td>
								<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6] %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7"><h4 style="padding:15px;">Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
		</div>		
			<div style="page-break-before:always">&nbsp;</div> 
		<div style="text-align:center; ">
		<h2 style="text-align: center;color: #145374;text-align:right;margin-right:25px;;">Annexure-F</h2>
							<table  id="mytable" class="border-black"
							style="width: 980px;  margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 25px;">
							<thead style="background: #055C9D; ;color: black;">
								<tr>
								<th class="border-black" style="width:5%; padding:15px;text-align: center;">SN</th>
								<th class="border-black" style="width:25%;text-align: center;">Designation/Rank</th>
								<th class="border-black" style="width:25%;text-align: center;">Discipline</th>
								<th class="border-black" style="width:10%;text-align: center;">Numbers</th>
								<th class="border-black" style="width:10%;text-align: center;">Period</th>
								<th class="border-black" style="width:15%;text-align: center;">Remarks</th>								
								</tr>
							</thead>
							<tbody>
							<%if(ManpowerList.size()>0){
							int i=0;
								for(Object[]obj:ManpowerList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2] %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3] %></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4] %><br></h6></td>
							<td class="border-black right"  align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[5]%></h6></td>
								<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6] %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7"><h4 style="padding:15px;">Not Specified</h4></td></tr>
							<%} %>
							</tbody>							
							</table>
		</div>	
					
</body>
</html>