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
<title>Sanction Details-Part2</title>
<%
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
List<String>CostList=(List<String>)request.getAttribute("CostList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();
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
		<h2 style="text-align: center;">Part-II</h2>
		<h3 style="text-align: center;" >Macro Details of Project / Programme</h3><hr style="width:80%;margin-top:0px;">
		
		    <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>1&nbsp;&nbsp;.&nbsp; Brief technical appreciation</h4></td>
				</tr>		
				<tr>
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  Justification (need) for undertaking the project/programme along with the 
					recommendation of the cluster council/DMC.</h4></td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[6]!=null){%>
				<%=obj[6].toString() %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226; What will be achieved by taking this project.</h4></td>
				</tr>
				<tr style="margin-top: 10px;">
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226; Competence level/preliminary work done to acquire the same. </h4></td>
				</tr>				
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[5]!=null){%>
				<%=obj[5].toString() %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align:justify;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
						Critical technologies from industry <h4></td>
			</tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
				Brief of TRL analysis.</h4></td>
			</tr>	
				<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				<%if(BriefList.length>0 && BriefList[2].toString().trim().length()>0) {%>
				<%=BriefList[2].toString() %>
				<%}else{ %>
				<p>Not Specified</p>
				<%} %>
				</td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226; Peer Review Committee recommendations </h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[3].toString().trim().length() > 0) {
					%>
					<%=BriefList[3].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
						For MM and TD(S) project, PDR should be conducted in lieu of PRC.
						Enclose the copy of PDR and major recommendations in case of MM
						and TD(S) projects.</h4></td>
			</tr>

			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
				</td>
			</tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
				Action Plan for prototype development.
				</h4>
				</td>
				</tr>			
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[4].toString().trim().length() > 0) {
					%>
					<%=BriefList[4].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
				The proposal should contain the number of design iterations required at 
				the component / sub-system level in a TD(T) project and number of design 
				iterations required at the overall system / project level in TD(S) and MM 
				projects. Time penalty for each design iteration should be given. 
				</h4>
				</td>
				</tr>	
				<tr></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
					Realisation Plan
				</h4>
				</td>
				</tr>	
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[10]!=null){%>
				<%=obj[10].toString() %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
					Testing Plan - Should include a Para on tests required, tests equipments / 
					facilities, tests methodology to meet the performance as envisaged in the 
					project (refer DPFM 2021). 
				</h4>
				</td>
				</tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[5].toString().trim().length() > 0) {
					%>
					<%=BriefList[5].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
				 Six monthly technical milestones linking financial outlay and timelines.
				</h4>
				</td>
				</tr>																							
		</table>
			<table  id="mytable" class="border-black"
							style="width: 650px;margin-top:20px; margin-left:20px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black; ">
								<tr>
								<th class="border-black" style="width:8%;text-align: center;">SN</th>
								<th class="border-black" style="width:10%;text-align: center;">Time<br>(Months)</th>
								<th class="border-black" style="width:50%;text-align: center;">Six Monthly Technical Milestone</th>
								<th class="border-black" style="width:25%;text-align: center;">Financial Outlay <br>&nbsp;(&#8377; in Cr.)</th>
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
							<td class="border-black" style="text-align: center;"><h5 style="font-weight: 300"><%=i+1%></h5></td>
							<td class="border-black" style="text-align: center;"><h5 style="font-weight: 300"><%=((i*6)+1)+"-"+((i+1)*6)%></h5></td>
						
							<td class="border-black" style="text-align: left;"><h5 style="font-weight: 300">
								<%for(Object[]obj:ScheduleList) {
								boolean case1=Integer.parseInt(obj[5].toString())<=i;
								boolean case2=Integer.parseInt(obj[6].toString())>=((i*6)+1);
								boolean case3=Integer.parseInt(obj[6].toString())>((i+1)*6);
								boolean case4=case2&&Integer.parseInt(obj[6].toString())<((i+1)*6);
								boolean case5=Integer.parseInt(obj[5].toString())>=monthDivision;
								if(case1&&(case2||case3)){
								%>
								<%="MS-"+obj[0].toString()+"  ( "+obj[1].toString()+" )" %><br>
								<%}else if(case5 &&case4){%>
								<%="MS-"+obj[0].toString()+"  ( "+obj[1].toString()+" )" %><br>
								<%}}%>
							</h5>	</td>
								<td class="border-black" id="td<%=i+1%>" align="right"><%=nfc.convert(Double.parseDouble(CostList.get(i))/10000000) %></td>
								</tr>
								<%}} %>
						
							</tbody>
						</table>  
						
		    	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  Critical factors/technology involved.</h4></td>
				</tr>
				<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;">
				<%if(!DetailsList.isEmpty()) {
				for(Object[]obj:DetailsList){
				if(obj[7]!=null){%>
				<%=obj[7].toString() %><%}else{ %><p>Not specified</p><%} %>
				<%}}%>
				</td>
				</tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  High development risk areas and remedial actions proposed. </h4></td>
				</tr>
				<tr></tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  Responsibility Matrix </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[6].toString().trim().length() > 0) {
					%>
					<%=BriefList[6].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>	
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  Development Partners/DcPP/LSI </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[7].toString().trim().length() > 0) {
					%>
					<%=BriefList[7].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  Production agencies proposed.  </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[8].toString().trim().length() > 0) {
					%>
					<%=BriefList[8].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
		    	<tr style="margin-top: 10px;">
				<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;  Costs benefit analysis/spin-off benefits.   </h4></td>
				</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[9].toString().trim().length() > 0) {
					%> <%=BriefList[9].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
						Project management and monitoring structure proposed.</h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[10].toString().trim().length() > 0) {
					%> <%=BriefList[10].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&#8226;
						PERT/Gantt ChartsPERT/Gantt Charts</h4></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (BriefList.length > 0 && BriefList[11].toString().trim().length() > 0) {
					%> <%=BriefList[11].toString()%> <%
 } else {
 %>
					<p>Not Specified</p> <%
 }
 %>
				</td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
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
				<td style="width: 650px; text-align: left;"><h4>
						3.&nbsp;&nbsp;&nbsp;&nbsp; List of major additional facilities (capital) required for the project</h4></td></tr>	
  </table>	
  
  
    <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				4.&nbsp;&nbsp;&nbsp;&nbsp; Major training requirements </h4></td></tr>
  			<tr style="margin-top: 10px;">
				<%if(TrainingRequirementList.size()>0){ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Attached as Annexure-A
				</p></td>
				<%}else{ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Not specified
				</p></td>				
				<%} %>
				</tr>					
  </table>	
      <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				5.&nbsp;&nbsp;&nbsp;&nbsp; Details of Work Packages  </h4></td></tr>
  			<tr style="margin-top: 10px;">
				<%if(WorkPackageList.size()>0){ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Attached as Annexure-B
				</p></td>
				<%}else{ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Not specified
				</p></td>				
				<%} %>
				</tr>					
  </table>	
        <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				6.&nbsp;&nbsp;&nbsp;&nbsp; Details of CARS   </h4></td></tr>
  			<tr style="margin-top: 10px;">
				<%if(CarsList.size()>0){ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Attached as Annexure-C
				</p></td>
				<%}else{ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Not specified
				</p></td>				
				<%} %></tr>					
  </table>									
        <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				7.&nbsp;&nbsp;&nbsp;&nbsp; Details of CAPSI</h4></td></tr>
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Attached as Annexure-D
				</p></td></tr>					
  </table>
          <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				8.&nbsp;&nbsp;&nbsp;&nbsp; Details of Consultancy requirements</h4></td></tr>
  			<tr style="margin-top: 10px;">
				<%if(ConsultancyList.size()>0){ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Attached as Annexure-E
				</p></td>
				<%}else{ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Not specified
				</p></td>				
				<%} %></tr>					
  </table>
           <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				9.&nbsp;&nbsp;&nbsp;&nbsp; Details of additional manpower requirements</h4></td></tr>
  			<tr style="margin-top: 10px;">
				<%if(ManpowerList.size()>0){ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Attached as Annexure-F
				</p></td>
				<%}else{ %>
				<td style="width: 650px; text-align: left;"><p style="margin-left: 50px;"> Not specified
				</p></td>				
				<%} %></tr>					
  </table>
            <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
  			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				10.&nbsp;&nbsp;&nbsp;&nbsp; Details of additional building space requirement </h4></td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
						<p style="margin-left: 50px;">&#8226;&nbsp;&nbsp;Funds for construction of building
						should be booked under Major Head-4076 (Capital)/Sub
						Head-111(Works) for MM, TD (S/T), UT & IF Projects and under Major
						Head-4076 (Capital)/Sub Head 052 for S&T (B/A) & PS projects.</p></td>
			</tr>
		<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><p
						style="margin-left: 50px;">&#8226;&nbsp;&nbsp;AE&apos;s should be obtained from concerned CCE/DCW&E and appended with the proposal </p></td>
			</tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				11.&nbsp;&nbsp;&nbsp;&nbsp; Additional information<span>(Any other important information which is not covered).</span></h4></td></tr>	
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (macrodetailsTwo.length > 0 && macrodetailsTwo[2].toString().trim().length() > 0) {
					%> <p style="margin-left: 50px;"><%=macrodetailsTwo[2].toString()%></p><%
 } else {
 %>
					<p style="margin-left: 50px;">Not Specified</p> <%
 }
 %>
				</td>
			</tr>	
<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				12.&nbsp;&nbsp;&nbsp;&nbsp; Comments of Project Director with signature and date.</span></h4></td></tr>									
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (macrodetailsTwo.length > 0 && macrodetailsTwo[3].toString().trim().length() > 0) {
					%> <p style="margin-left: 50px;"><%=macrodetailsTwo[3].toString()%> </p><%
 } else {
 %>
					<p style="margin-left: 50px;">Not Specified</p> <%
 }
 %>
				</td>
			</tr>	
<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;"><h4>
				13.&nbsp;&nbsp;&nbsp;&nbsp;<span> Recommendations of Cluster DG with signature and date.</span></h4></td></tr>
			<tr style="margin-top: 10px;">
				<td style="width: 650px; text-align: left;">
					<%
					if (macrodetailsTwo.length > 0 && macrodetailsTwo[4].toString().trim().length() > 0) {
					%> <p style="margin-left: 50px;"><%=macrodetailsTwo[4].toString()%> </p><%
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