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
<title>Part-I</title>
<%Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes"); 
String initiationid = (String) request.getAttribute("initiationid");
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
List<Object[]>DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> ProjectInitiationLabList = (List<Object[]>) request.getAttribute("ProjectInitiationLabList");
Object[]MacroDetails=(Object[])request.getAttribute("MacroDetails");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
List<Object[]>ProcurementList=(List<Object[]>)request.getAttribute("ProcurementList");
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


 th , td{
 
 font-size: 17px;
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
		<h2 style="text-align: center;">Part-I</h2>
		<h3 style="text-align: center;">Macro Details of Project / Programme</h3><hr style="width:80%">
    <table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4>1.&nbsp;&nbsp;a.&nbsp;&nbsp; Title of the Project:</h4></td>
	<td ><%=ProjectDetailes[7].toString() %><hr style="margin:0px;"></td>
	</tr>
	<tr>
	<td style="width:300px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;b.&nbsp;&nbsp; Short Name or Acronym :</h4></td>
	<td ><%=ProjectDetailes[6].toString() %><hr style="margin:0px;"></td>
	</tr>
	<tr>
	<td style="width:300px;text-align: left;"><h4>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Title of the Programme:<br>(If the Project is part of a Programme) </h4></td>
	<td ><%=ProjectDetailes[16].toString() %><hr style="margin:0px;"></td>
	</tr>
	</table>
	<h1 class="break"></h1>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align:left;">
	<h4>3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Objective:</h4>	
	</td>
	</tr>
	<tr>
	<td style="width:650px;text-align:left;">
   <%						if(!DetailsList.isEmpty()){
												for (Object[] obj : DetailsList) {
													if (obj[1] != null) {%>
													<% if(obj[1].toString().trim().length()==0){%>
													<p align="center"> Not Mentioned</p>
													<%}else {
												%>
												<%=obj[1].toString()%>
												<%}}}}else{ %>
												<p align="center">Not Mentioned</p>
												<%} %>
    </td>
	</tr>
	<tr>
	<td style="width:650px;text-align:left;">
	<h4>4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scope:</h4>	
	</td>
	</tr>
		<tr>
	<td style="width:650px;text-align:left;">
     <%						if(!DetailsList.isEmpty()){
												for (Object[] obj : DetailsList) {
													if (obj[2] != null) {%>
													<% if(obj[2].toString().trim().length()==0){%>
													<p align="center"> Not Mentioned</p>
													<%}else {
												%>
												<%=obj[2].toString()%>
												<%}}}}else{ %>
												<p align="center">Not Mentioned</p>
												<%} %>
    </td>
	</tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4>5.&nbsp;&nbsp;&nbsp;&nbsp;Proposed project deliverables: 
	</h4></td>
	<td></td>
	</tr>
	<tr>
	<td style="width:400px;margin-top:20px;text-align: center;">(a) No of prototypes for testing </td>
		<td>
	 <%if(MacroDetails.length!=0){ %>
	 <%if(MacroDetails[6]!=null){ %><p style="margin:0px;margin-left:25px;text-align:center;"><%=MacroDetails[6].toString()%><%} %><hr style="margin:0px;width:30%"></p>
	 <%}else{ %>
	<p>Not Specified</p>
	<%} %>
		</td>
	</tr>
	</table>
	<table style="margin-left:40px; margin-top:30px;border:0px solid black;font-family:FontAwesome; width:650px;">
		<tr>
		<td style="width:400px;margin-left:100px;;text-align: center;">(b) No of (type approved/qualified) deliverables </td>
		<td align="center">
	 <%if(MacroDetails.length!=0){ %>
	 <%if(MacroDetails[7]!=null){ %><p style="margin:0px;margin-left:25px;text-align: center;"><%=MacroDetails[7].toString()%><hr style="margin:0px;width:30%"><p><%} %>
	 <%}else{ %>
	<p>Not Specified</p>
	<%} %>
		</td>
		</tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4>6.&nbsp;&nbsp;&nbsp;&nbsp;Is it a Multi-lab Project?  
	</h4></td>
	<td >
	<%if (ProjectDetailes[11] != null && ProjectDetailes[11].toString().equalsIgnoreCase("Y")) {%>Yes<%} else {%>No<%}%>
	<hr style="margin:0px;">
	</td>
	</tr>
	
	</table>
	<table style="margin-left:20px; margin-top:0px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align: left;"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Participating Labs Name - </h4></td>
	</tr>
 <tr><td align="justify"><h5><%int count = 1;
 if (!ProjectInitiationLabList.isEmpty()) {
	for (Object[] obj : ProjectInitiationLabList) {
	count++;
	%>
	<%=obj[2]+"("+obj[3]+")" %><%if(count<ProjectInitiationLabList.size()){ %>,<%} %>
	<%}} %>					
 </h5></td></tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4>7.&nbsp;&nbsp;&nbsp;&nbsp;Specify the User  </h4></td>
	<td> <%if(ProjectDetailes[22]!=null){ %>
	<%if(ProjectDetailes[22].toString().equalsIgnoreCase("IA")){%>Army<%} %>
	<%if(ProjectDetailes[22].toString().equalsIgnoreCase("IAF")){%>Air Force<%} %>
	<%if(ProjectDetailes[22].toString().equalsIgnoreCase("IN")){%>Navy<%} %>
	<%if(ProjectDetailes[22].toString().equalsIgnoreCase("IS")){%>Inter-services<%} %>
	<%if(ProjectDetailes[22].toString().equalsIgnoreCase("DO")){%>DRDO<%} %>
	<%if(ProjectDetailes[22].toString().equalsIgnoreCase("OH")){%>Others<%} %>
		<%}else{ %>Not Specified<%} %><hr style="margin:0px;"></td>
	</tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align: left;"><h4>8.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Specify the proposed LSI / DcPP/ PA or selection methodology 
 </h4></td>
	</tr>
	<tr>
	<td style="width:650px;text-align: left;">
	<%if(MacroDetails.length!=0){ %>
	<%if(MacroDetails[3]!=null){ %><%=MacroDetails[3].toString()%><%} %>
	<%}else{ %>
	<p>Not Specified</p>
	<%} %>
	</td>
	</tr>
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;"><h4>10.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Additional requirement of mechanical transport vehicles specific to the 
	project, for equipment/developed systems and stores (with justifications): 
 	</h4></td>
	</tr>
		<tr>
	<td style="width:650px; ">
	<%if(MacroDetails.length!=0){ %>
	<%if(MacroDetails[2]!=null){ %><%=MacroDetails[2].toString()%><%} %>
	<%}else{ %>
	<p>Not Specified</p>
	<%} %>
	</td>
	</tr>
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;"><h4>11.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Proposed Six monthly milestones along-with financial outlay (&#8377; in Cr):
 	</h4></td>
	</tr>
	</table>	
			<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black;">
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
							<td class="border-black" style="text-align: center;"><h5><%=i+1%></h5></td>
							<td class="border-black" style="text-align: center;"><h5><%=((i*6)+1)+"-"+((i+1)*6)%></h5></td>
						
							<td class="border-black"><h5>
							<%for(Object[]obj:ScheduleList) {
								boolean case1=Integer.parseInt(obj[5].toString())<=i;
								boolean case2=Integer.parseInt(obj[6].toString())>=((i*6)+1);
								boolean case3=Integer.parseInt(obj[6].toString())>((i+1)*6);
								boolean case4=case2&&Integer.parseInt(obj[6].toString())<((i+1)*6);
								boolean case5=Integer.parseInt(obj[5].toString())>=monthDivision;
								if(case1&&(case2||case3)){
								%>
								<%="MIL -"+obj[0].toString() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<%}else if(case5 &&case4){%>
								<%="MIL -"+obj[0].toString() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<%}}%>
							</h5>	</td>
								<td class="border-black" id="td<%=i+1%>" align="right"><button class="finance" type="button" style="display:none;" onclick="finance(<%=i%>,<%=((i*6)+1)%>,<%=((i+1)*6)%>)"></button></td>
								</tr>
								<%}} %>
						
							</tbody>
						</table>  
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;">
	<h4>
	12.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Procurement Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Attached as a Annexure-A)
	</h4>
	</td>
	</tr>
	</table>
	<table id="a1" style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;"><h4>
	13.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Details of Demand approvals required 
	</h4></td>
	</tr>		
	</table>			
			<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;">SN</th>
								<th class="border-black" style="width:30%;text-align: center;">Name</th>
								<th class="border-black" style="width:30%;text-align: center;">source</th>
								<th class="border-black" style="width:10%;text-align: center;">Mode</th>
								<th class="border-black" style="width:10%;text-align: center;">cost</th>
								</tr>
							</thead>
								<tbody >
							<% int i=1;
							if(ProcurementList.isEmpty()){%>
							<tr class="border-black"><td colspan="4" align="center"><h4>Please add Procurement plan for this project</h4><td></tr>
							<%}else{
							for(Object[]obj:ProcurementList){	
							%>	
							<tr>
							<td class="border-black" style="padding:px;"><%=i %></td>
							<td class="border-black"style="padding:px;"><%=obj[2] %></td>
							<td class="border-black"style="padding:px;"><%=obj[4] %></td>
							<td class="border-black"style="padding:px;"><%=obj[5] %></td>
							<td class="border-black"style="padding:px;"><%=obj[6] %></td>
							</tr>
							<%
							i++;}
							}%>
							</table>	
			<table style="margin-left:20px; margin-top:25px; border:0px solid black;font-family:FontAwesome; width:650px;">
			<tr>
				<td style="width: 650px; text-align: left; margin-top: 20px;"><h4>
						14.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Any other information:
						</h4></td>
			</tr>
			<tr>
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length != 0) {
					%> <%
 					if (MacroDetails[4] != null) {
 					%><%=MacroDetails[4].toString()%>
					<%
					}else{
					%> 
					<p>Not Specified</p>
 					<%} }else {%>
					<p>Not Specified</p>
					 <%}%>
 					
				</td>
			</tr>
		</table>
					<table style="margin-left:20px; margin-top:25px; border:0px solid black;font-family:FontAwesome; width:650px;">
			<tr>
				<td style="width: 650px; text-align: left; margin-top: 20px;"><h4>
					15.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; List of enclosures: 
						</h4></td>
			</tr>
			<tr>
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length != 0) {
					%> <%
 					if (MacroDetails[5] != null) {
 					%><%=MacroDetails[5].toString()%>
					<%
					}else{
					%> 
					<p>Not Specified</p>
 					<%} }else {%>
					<p>Not Specified</p>
					 <%}%>
 					
				</td>
			</tr>
		</table>	
							<table style="margin-left:20px; margin-top:25px; border:0px solid black;font-family:FontAwesome; width:650px;">
			<tr>
				<td style="width: 650px; text-align: left; margin-top: 20px;"><h4>
					16. PD AND Lab Director have to give certificate that this technology is not available in India and also mention that selected Industry/DcPP is not in negative list of vendors.

						</h4></td>
			</tr>
			
			</table>	
			
			
			
						
	</div>
</body>
</html>