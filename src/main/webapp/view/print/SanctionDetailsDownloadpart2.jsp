	<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<title>Part-II</title>
<%
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
List<Object[]> ConsultancyList = (List<Object[]>) request.getAttribute("ConsultancyList");
List<Object[]> CarsList = (List<Object[]>) request.getAttribute("CarsList");
List<Object[]> WorkPackageList = (List<Object[]>) request.getAttribute("WorkPackageList");
List<Object[]> TrainingRequirementList=(List<Object[]>)request.getAttribute("TrainingRequirementList");
List<Object[]> CapsiList=(List<Object[]>)request.getAttribute("CapsiList");
List<Object[]> ManpowerList=(List<Object[]>)request.getAttribute("ManpowerList");
Object[] macrodetailsTwo = (Object[]) request.getAttribute("macrodetailsTwo");
Object[] MacroDetails = (Object[]) request.getAttribute("MacroDetails");
Object[]BriefList=(Object[])request.getAttribute("BriefList");
List<Object[]> DetailsList = (List<Object[]>) request.getAttribute("DetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
List<String>CostList=(List<String>)request.getAttribute("CostList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();
int snCount=0;
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
          size: 790px 1050px;
          margin-top: 35px;
          margin-left: 49px;
          margin-right: 49px;
          margin-bottom: 35px; 	
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 10px;
             margin-right: 5px;
          }
          @top-right {
          	 content : "Project : <%=ProjectTitle!=null?StringEscapeUtils.escapeHtml4(ProjectTitle): " - "  %>";
             margin-top: 10px;
             margin-right: 10px;
          }
                 
           @top-left {
          	margin-top: 10px;
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
 border:1px solid black !important;
 border-collapse: collapse !important;
 }
 .border-black td th{
 padding:px !important;
 margin: 0px !important;
 }

td>table{
  border:1px solid black;
 border-collapse: collapse;
}
 td table>tbody>tr>td{
 margin-top:20px !important;
  padding:5px !important;
  }
  li{
  text-align: justify;
  }
 </style>
</head>
<body>
	<div style="text-align:center;">
		<h2 style="text-align: center;color:#021B79;">Part-II</h2>
		<h3 style="text-align: center;color:#021B79;" >Micro Details of Project / Programme</h3><hr style="width:80%;margin-top:0px;">
		
		    <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>1&nbsp;&nbsp;.&nbsp; Brief technical appreciation</h4></td>
				</tr>		
				<tr>
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  Justification (need) for undertaking the project/programme along with the 
					recommendation of the cluster council/DMC.</h4></td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[6]!=null){%>
				<%=StringEscapeUtils.escapeHtml4(obj[6].toString()) %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
				
					<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %> Scope. </h4></td>
				</tr>				
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[2]!=null){%>
				<%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %> What will be achieved by taking this project.</h4></td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				<%if(BriefList.length>0 && BriefList[12]!=null) {%>
				<%=StringEscapeUtils.escapeHtml4(BriefList[12].toString()) %>
				<%}else{ %>
				<p>Not Specified</p>
				<%} %>
				</td></tr>
			
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %> Competence level/preliminary work done to acquire the same. </h4></td>
				</tr>				
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[5]!=null){%>
				<%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align:justify;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
						Critical technologies from industry <h4></td>
			</tr>	
							<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				<%if(BriefList.length>0 && BriefList[13]!=null) {%>
				<%=StringEscapeUtils.escapeHtml4(BriefList[13].toString()) %>
				<%}else{ %>
				<p>Not Specified</p>
				<%} %>
				</td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
				Brief of TRL analysis.</h4></td>
			</tr>	
				<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				<%if(BriefList.length>0 && BriefList[2]!=null) {%>
				<%=StringEscapeUtils.escapeHtml4(BriefList[2].toString()) %>
				<%}else{ %>
				<p>Not Specified</p>
				<%} %>
				</td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %> Peer Review Committee recommendations </h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[3]!=null) {
					%>
					<%=StringEscapeUtils.escapeHtml4(BriefList[3].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
		<%-- 	<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
						For MM and TD(S) project, PDR should be conducted in lieu of PRC.
						Enclose the copy of PDR and major recommendations in case of MM
						and TD(S) projects.</h4></td>
			</tr> --%>

			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				</td>
			</tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
				Action Plan for prototype development.
				</h4>
				</td>
				</tr>			
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[4]!=null) {
					%>
					<%=StringEscapeUtils.escapeHtml4(BriefList[4].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
<!-- 			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1..
				The proposal should contain the number of design iterations required at 
				the component / sub-system level in a TD(T) project and number of design 
				iterations required at the overall system / project level in TD(S) and MM 
				projects. Time penalty for each design iteration should be given. 
				</h4>
				</td>
				</tr>	 -->
				<tr></tr>
					<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
					Number of design Iterations Required
				</h4>
				</td>
				</tr>	
					<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length > 0 && MacroDetails[18]!=null) {
						%> <%=StringEscapeUtils.escapeHtml4(MacroDetails[18].toString())%> <%
						 } else { %>	
						 <p>Not Specified</p> 
						 <%} %>
				</td>
			</tr>
				
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
					Realisation Plan
				</h4>
				</td>
				</tr>	
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[10]!=null){%>
				<%=StringEscapeUtils.escapeHtml4(obj[10].toString()) %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
		
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
					Testing Plan - Should include a Para on tests required, tests equipments / 
					facilities, tests methodology to meet the performance as envisaged in the 
					project (refer DPFM 2021). 
				</h4>
				</td>
				</tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[5]!=null) {
					%>
					<%=StringEscapeUtils.escapeHtml4(BriefList[5].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
				 Six monthly technical milestones linking financial outlay and timelines.
				</h4>
				</td>
				</tr>																							
		</table>
					<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;margin-top:15px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:8%;text-align: center;">SN</th>
								<th class="border-black" style="width:10%;text-align: center;">Time<br>(Months)</th>
								<th class="border-black" style="width:50%;text-align: center;">Six Monthly Technical Milestone</th>
								<th class="border-black" style="width:25%;text-align: center;">Financial Outlay <br>&nbsp;(&#8377; in Lakhs.)</th>
								</tr>
							</thead>
							<tbody >
							<%/* int i=0; */
							if(ScheduleList.isEmpty()){%>
							<tr class="border-black"><td colspan="3" align="center"><h5>Please add Schedule for the project in Project Initiation</h5><td></tr>
							<%}else{
							int monthDivision=Integer.parseInt(ProjectDetailes[9].toString())%6==0?Integer.parseInt(ProjectDetailes[9].toString())/6:Integer.parseInt(ProjectDetailes[9].toString())/6+1;
							
							for(int i=0;i<monthDivision;i++){
							%>
							<tr >
							<td class="border-black" style="text-align: center;"><h5 style="font-weight: 500"><%=i+1%></h5></td>
							<td class="border-black" style="text-align: center;"><h5 style="font-weight: 500"><%="T0 + "+(i+1)*6%></h5></td>
						
							<td class="border-black" style="text-align: left;"><h5 style="font-weight: 500">
								<%for(Object[]obj:ScheduleList) {
								int milstonetotalMont = Integer.parseInt(obj[6].toString());
								if( milstonetotalMont>((i)*6) && milstonetotalMont<=((i+1)*6) ){
								%>
						<%-- 		boolean case1=Integer.parseInt(obj[5].toString())<=i;
								boolean case2=Integer.parseInt(obj[6].toString())>=((i*6)+1);
								boolean case3=Integer.parseInt(obj[6].toString())>((i+1)*6);
								boolean case4=case2&&Integer.parseInt(obj[6].toString())<((i+1)*6);
								boolean case5=Integer.parseInt(obj[5].toString())>=monthDivision;
								if(case1&&(case2||case3)){
								%>
								<%=obj[1].toString() %><br>
								<%}else if(case5 &&case4){%>
								<%=obj[1].toString() %><br>
								<%} %> --%>
								<div><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></div>
								
								<%}}%>
							</h5>	</td>
								<td class="border-black" id="td<%=i+1%>" align="right">
								<%for(Object[]obj:ScheduleList) {
								int milstonetotalMont = Integer.parseInt(obj[6].toString());
								if( milstonetotalMont>((i)*6) && milstonetotalMont<=((i+1)*6) ){
								%>
								
								<p style="text-align: right !important;"><%=nfc.convert(Double.parseDouble(obj[9].toString())) %></p>
								<%}}%>
								
								</td>
								</tr>
								<%}} %>
						
							</tbody>
						</table>   
						
		    	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  Critical factors/technology involved.</h4></td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[7]!=null){%>
				<%=StringEscapeUtils.escapeHtml4(obj[7].toString()) %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  High development risk areas and remedial actions proposed. </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length > 0 && MacroDetails[17] != null) {
					%> <%=StringEscapeUtils.escapeHtml4(MacroDetails[17].toString())%> <%
 						} else {%><p>Not Specified</p> <%}%>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  Responsibility Matrix </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[6]!=null) {
					%>
					<%=StringEscapeUtils.escapeHtml4(BriefList[6].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>	
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  Development Partners/DcPP/LSI </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[7]!=null) {
					%>
					<%=StringEscapeUtils.escapeHtml4(BriefList[7].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  Production agencies proposed.  </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[8]!=null) {
					%>
					<%=StringEscapeUtils.escapeHtml4(BriefList[8].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>  Costs benefit analysis/spin-off benefits.   </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[9]!=null) {
					%> <%=StringEscapeUtils.escapeHtml4(BriefList[9].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
						Project management and monitoring structure proposed.</h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[10]!=null) {
					%> <%=StringEscapeUtils.escapeHtml4(BriefList[10].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
						PERT/Gantt ChartsPERT/Gantt Charts</h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[11]!=null) {
					%> <%=StringEscapeUtils.escapeHtml4(BriefList[11].toString())%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;1. <%=++snCount  %>
						Details of Sub-Projects / Work Packages </h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length > 0 && MacroDetails[19]!=null) {
						%> <%=StringEscapeUtils.escapeHtml4(MacroDetails[19].toString())%> <%
						 } else { %>	
						 <p>Not Specified</p> 
						 <%} %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
						2.&nbsp;&nbsp;&nbsp;&nbsp; If the project is to be executed by multiple laboratories,
						please outline the agreed work-packages among the various
						labs/estts.</h4></td>
			</tr>			
		</table>
				`			<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:1%;text-align: center;">SN</th>
								<th class="border-black" style="width:15%;text-align: center;">Title of <br>Sub Project</th>
								<th class="border-black" style="width:40%;text-align: center;">Objectives & scope</th>
								<th class="border-black" style="width:10%;text-align: center;">Lab</th>
								<th class="border-black" style="width:10%;text-align: center;">Cost<br>&nbsp;(&#8377;in cr.)</th>
								<th class="border-black" style="width:10%;text-align: center;">PDC<br>(in Months)</th>
								</tr>
							</thead>
							</table>
  <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
						3.&nbsp;&nbsp;&nbsp;&nbsp; List of major additional facilities (capital) required for the project</h4></td></tr>
						<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (macrodetailsTwo.length > 0 && macrodetailsTwo[5].toString().trim().length() > 0) {
					%> <p style="margin-left: 50px;"><%=StringEscapeUtils.escapeHtml4(macrodetailsTwo[5].toString())%></p><%
 						} else {
						 %>
					<p style="margin-left: 50px;">Not Specified</p> <%
 						}
 						%>
				</td>
			</tr>	
			
			
							
  </table>	  
    <div style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  	</div><h4 style="text-align: left;color:#021B79;margin-left:20px;">
				4.&nbsp;&nbsp;&nbsp;&nbsp; Major training requirements </h4>
  	
				<%if(TrainingRequirementList.size()>0){ %>
					<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 25px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;color:#021B79;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;color:#021B79;">Discipline/Area for Training</th>
								<th class="border-black" style="width:18%;text-align: center;color:#021B79;">Agency Contacted</th>
								<th class="border-black" style="width:16%;text-align: center;color:#021B79;">No of personnel proposed to be trained</th>
								<th class="border-black" style="width:8%;text-align: center;color:#021B79;">Duration</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Remarks</th>
								</tr>
							</thead>
							<tbody>
							<%if(TrainingRequirementList.size()>0){
							int i=0;
								for(Object[]obj:TrainingRequirementList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[7].toString()))/10000000)%></h6></td>
							<td class="border-black " ><h6 style="padding:18px; padding-bottom: 18px;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7" style="padding:15px;"><h4>Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
				<%}else{ %>
				<p style="margin-left: 50px;"> Not specified
				</p>				
				<%} %>

      <div style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  		</div>	<h4 style="text-align: left;color:#021B79;margin-left:20px;">
				5.&nbsp;&nbsp;&nbsp;&nbsp; Details of Work Packages  </h4>
  		
				<%if(WorkPackageList.size()>0){ %>
			
					<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 10px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;color:#021B79;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;color:#021B79;">Name of Govt. Agencies</th>
								<th class="border-black" style="width:20%;text-align: center;color:#021B79;">Work Package</th>
								<th class="border-black" style="width:35%;text-align: center;color:#021B79;">Objectives & Scope of Work</th>
								<th class="border-black" style="width:10%;text-align: center;color:#021B79;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Duration<br>(In Months)</th>								
								</tr>
							</thead>
							<tbody>
							<%if(WorkPackageList.size()>0){
							int i=0;
								for(Object[]obj:WorkPackageList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %><br><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[7].toString()))/10000000)%></h6></td>
								<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7"><h4 style="padding:15px;">Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
				<%}else{ %>
				<p style="margin-left: 50px;"> Not specified
				</p>				
				<%} %>
			
        <div style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			</div><h4 style="text-align: left;color:#021B79;margin-left:20px;">
				6.&nbsp;&nbsp;&nbsp;&nbsp; Details of CARS   </h4>
  			
				<%if(CarsList.size()>0){ %>
								<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 15px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;color:#021B79;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;color:#021B79;">Name of Institute/Agency</th>
								<th class="border-black" style="width:18%;text-align: center;color:#021B79;">Name of the identified profesor</th>
								<th class="border-black" style="width:16%;text-align: center;color:#021B79;">Area where R&D is required</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
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
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[5].toString()))/10000000)%></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></h6></td>
							<td class="border-black " ><h6 style="padding:18px; padding-bottom: 18px;"><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7" style="padding:15px;"><h4>Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
				<%}else{ %>
				<p style="margin-left: 50px;"> Not specified
				</p>				
				<%} %>		
				
				
				      <div style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			</div><h4 style="text-align: left;color:#021B79;margin-left:20px;">
				7.&nbsp;&nbsp;&nbsp;&nbsp; Details of CAPSI   </h4>
  			
				<%if(CarsList.size()>0){ %>
				<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 10px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;color:#021B79;">SN</th>
								<th class="border-black" style="width:20%;text-align: center;color:#021B79;">Station</th>
								<th class="border-black" style="width:16%;text-align: center;color:#021B79;">Area where R&D is required</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:8%;text-align: center;color:#021B79;">Duration</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Confidence level of the Agency</th>
								</tr>
							</thead>
																	<tbody>
							<%if(CapsiList.size()>0){
							int i=0;
								for(Object[]obj:CapsiList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h6></td>
<%-- 							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3] %></h6></td> --%>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[5].toString()))/10000000)%></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></h6></td>
							<td class="border-black " ><h6 style="padding:18px; padding-bottom: 18px;"><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7" style="padding:15px;"><h4>Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
				<%}else{ %>
				<p style="margin-left: 50px;"> Not specified
				</p>				
				<%} %>
											
  				
  </table>
          <div align="left" style=" margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			 </div>
  			 <h4 style="color:#021B79; margin-top: 10px;text-align: left;margin-left:20px;">
				8.&nbsp;&nbsp;&nbsp;&nbsp; Details of Consultancy requirements</h4>
  			
				<%if(ConsultancyList.size()>0){ %>
									<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 10px;">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;color:#021B79;">SN</th>
								<th class="border-black" style="width:25%;text-align: center;color:#021B79;">Discipline/Area</th>
								<th class="border-black" style="width:15%;text-align: center;color:#021B79;">Agency</th>
								<th class="border-black" style="width:20%;text-align: center;color:#021B79;">Name of Person/expert</th>
								<th class="border-black" style="width:12%;text-align: center;color:#021B79;">Cost<br>&nbsp;(&#8377; in Cr.)</th>
								<th class="border-black" style="width:25%;text-align: center;color:#021B79;">Process that will be followed</th>								
								</tr>
							</thead>
							<tbody>
							<%if(ConsultancyList.size()>0){
							int i=0;
								for(Object[]obj:ConsultancyList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %><br></h6></td>
							<td class="border-black right"  align="right"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[5].toString()))/10000000)%></h6></td>
								<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7"><h4 style="padding:15px;">Not Specified</h4></td></tr>
							<%} %>
							</tbody>
							</table>
				<%}else{ %>
				<p style="margin-left: 50px;"> Not specified
				</p>			
				<%} %>				
  		  
           <div style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			</div><h4 style="color:#021B79; margin-top: 10px;text-align: left;margin-left:20px;">
				9.&nbsp;&nbsp;&nbsp;&nbsp; Details of additional manpower requirements</h4>
  			
				<%if(ManpowerList.size()>0){ %>
								<table  id="mytable" class="border-black"
							style="width: 650px;  margin-left:20px;font-family: 'FontAwesome'; font-size:p;margin-top: 15px;">
							<thead style="background: #055C9D; ;color: black;">
								<tr>
								<th class="border-black" style="width:5%; padding:15px;text-align: center;color:#021B79;">SN</th>
								<th class="border-black" style="width:25%;text-align: center;color:#021B79;">Designation/Rank</th>
								<th class="border-black" style="width:25%;text-align: center;color:#021B79;">Discipline</th>
								<th class="border-black" style="width:10%;text-align: center;color:#021B79;">Numbers</th>
								<th class="border-black" style="width:10%;text-align: center;color:#021B79;">Period</th>
								<th class="border-black" style="width:15%;text-align: center;color:#021B79;">Remarks</th>								
								</tr>
							</thead>
							<tbody>
							<%if(ManpowerList.size()>0){
							int i=0;
								for(Object[]obj:ManpowerList){	
								%>
							<tr style="">
							<td class="border-black" style="width:5%;text-align"><h6 style="padding-top:18px;padding-bottom: 18px;"><%=++i %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h6></td>
							<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></h6></td>
							<td class="border-black" align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %><br></h6></td>
							<td class="border-black right"  align="center"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%></h6></td>
								<td class="border-black" align="left"><h6 style="padding-top:18px; padding-bottom: 18px;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></h6></td>
							</tr>
							<%}}else{ %>
							<tr><td class="border-black"  colspan="7"><h4 style="padding:15px;">Not Specified</h4></td></tr>
							<%} %>
							</tbody>							
							</table>
				<%}else{ %>
				<p style="margin-left: 50px;"> Not specified
				</p>				
				<%} %>
				
				
            <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
				10.&nbsp;&nbsp;&nbsp;&nbsp; Details of additional building space requirement </h4></td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				<!-- 		<p style="margin-left: 50px;">1. &nbsp;&nbsp;Funds for construction of building
						should be booked under Major Head-4076 (Capital)/Sub
						Head-111(Works) for MM, TD (S/T), UT & IF Projects and under Major
						Head-4076 (Capital)/Sub Head 052 for S&T (B/A) & PS projects.</p> -->
						
					<%if(macrodetailsTwo.length!=0&&macrodetailsTwo[6].toString().length()>0) {%>
					<p style="margin-left: 50px;"><%=StringEscapeUtils.escapeHtml4(macrodetailsTwo[6].toString()) %> </p><%} else {%> <p style="margin-left: 50px;"> Not Specified  </p>  <%} %>	
						</td>
			</tr>

			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
				11.&nbsp;&nbsp;&nbsp;&nbsp; Additional information<span>(Any other important information which is not covered).</span></h4></td></tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				<%if (macrodetailsTwo.length > 0 && macrodetailsTwo[2].toString().trim().length() > 0) {
				%> <p style="margin-left: 50px;"><%=StringEscapeUtils.escapeHtml4(macrodetailsTwo[2].toString())%></p><%
 				} else {%>
					<p style="margin-left: 50px;">Not Specified</p> <%
 }
 %>
				</td>
			</tr>	
<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
				12.&nbsp;&nbsp;&nbsp;&nbsp; Comments of Project Director with signature and date.</span></h4></td></tr>									
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (macrodetailsTwo.length > 0 && macrodetailsTwo[3].toString().trim().length() > 0) {
					%> <p style="margin-left: 50px;"><%=StringEscapeUtils.escapeHtml4(macrodetailsTwo[3].toString())%> </p><%
 } else {
 %>
					<p style="margin-left: 50px;">Not Specified</p> <%
 }
 %>
				</td>
			</tr>	
			
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
				13.&nbsp;&nbsp;&nbsp;&nbsp; Following details need to be certified by Lab Director.</span></h4></td></tr>

			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length > 0 && MacroDetails[16].toString().trim().length() > 0) {
					%>
					<div style="margin-left: 50px;"><%=StringEscapeUtils.escapeHtml4(MacroDetails[16].toString())%>
					</div>
					<%
					} else {
					%>
					<p style="margin-left: 50px;">Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;color:#021B79;"><h4>
				14.&nbsp;&nbsp;&nbsp;&nbsp;<span> Recommendations of Cluster DG with signature and date.</span></h4></td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (macrodetailsTwo.length > 0 && macrodetailsTwo[4].toString().trim().length() > 0) {
					%> <p style="margin-left: 50px;"><%=StringEscapeUtils.escapeHtml4(macrodetailsTwo[4].toString())%> </p><%
 } else {
 %>
					<p style="margin-left: 50px;">Not Specified</p> <%
 }
 %>
				</td>
			</tr>
<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				</h4></td></tr>			
												
		</table>		 												
		</div>

</body>
</html>