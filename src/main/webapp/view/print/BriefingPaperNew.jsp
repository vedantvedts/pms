<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.Format"%>
<%@page import="java.util.Locale"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Briefing Paper</title>


<%String isprint=(String)request.getAttribute("isprint"); %>

<style type="text/css">


p{
  text-align: justify;
  text-justify: inter-word;
}



.break
	{
		page-break-after: always;
	} 
	 
 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
@page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; */    
           @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          /*
          @top-right {
             content: "Project";            
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "Project";
          }          
          @top-center { 
          margin-top: 30px;
          content: "Project";          
          } */

 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 div
 {
  	width: 670px;
 }
 
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
  
 .textcenter{
 	
 	text-align: center;
 }

 .sth
 {
 	   font-size: 16px;
 	   border: 1px solid black;
 }
 
 .std
 {
 	text-align: center;
 	border: 1px solid black;
 }
 
 
  #containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container 
{
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

img
{
	width:17cm;
	height:25cm;
<%if(isprint!=null && isprint.equals("1")){%>
	margin-left: -15px;
<%}%>
}
 
.pname
{
	margin: 10px 0px 10px 20px;
}
 
 
</style>



</head>

<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();
Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));

String projectid=(String)request.getAttribute("projectid");
String committeeid=(String)request.getAttribute("committeeid");

List<Object[]> projectattributeslist = (List<Object[]> )request.getAttribute("projectattributes");
List<List<Object[]>> ebandpmrccount = (List<List<Object[]>>)request.getAttribute("ebandpmrccount");
List<Object[]> projectdatadetails = (List<Object[]> )request.getAttribute("projectdatadetails");
List<List<Object[]>> milestonesubsystems= (List<List<Object[]>>)request.getAttribute("milestonesubsystems");
List<List<Object[]>> milestones= (List<List<Object[]>>)request.getAttribute("milestones");
List<List<Object[]>> lastpmrcminsactlist = (List<List<Object[]>>)request.getAttribute("lastpmrcminsactlist");
List<List<Object[]>> lastpmrcactions = (List<List<Object[]>>)request.getAttribute("lastpmrcactions");
List<List<ProjectFinancialDetails>> projectFinancialDetails =(List<List<ProjectFinancialDetails>>)request.getAttribute("financialDetails");
List<List<Object[]>> ganttchartlist=(List<List<Object[]>>)request.getAttribute("ganttchartlist"); 
List<List<Object[]>> oldpmrcissueslist=(List<List<Object[]>>)request.getAttribute("oldpmrcissueslist");

List<List<Object[]>> riskmatirxdata = (List<List<Object[]>> )request.getAttribute("riskmatirxdata");

List<List<Object[]>> procurementOnDemand = (List<List<Object[]>>)request.getAttribute("procurementOnDemandlist");
List<List<Object[]>> procurementOnSanction = (List<List<Object[]>>)request.getAttribute("procurementOnSanctionlist");
List<List<Object[]>> actionplanthreemonths = (List<List<Object[]>>)request.getAttribute("actionplanthreemonths");
List<Object[]> lastpmrcdecisions = (List<Object[]> )request.getAttribute("lastpmrcdecisions");
List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails");

List<String> projectidlist = (List<String>)request.getAttribute("projectidlist");
%>


<%

/* 
List<Object[]> projectattributeslist = (List<Object[]> )request.getAttribute("projectattributes");
List<List<Object[]>> ebandpmrccount = (List<List<Object[]>> )request.getAttribute("ebandpmrccount");
List<List<Object[]>> milestonesubsystems= (List<List<Object[]>>)request.getAttribute("milestonesubsystems");
List<List<Object[]>> milestones= (List<List<Object[]>>)request.getAttribute("milestones");
List<List<Object[]>> lastpmrcactions = (List<List<Object[]>>)request.getAttribute("lastpmrcactions");
List<List<Object[]>> lastpmrcminsactlist = (List<List<Object[]>>)request.getAttribute("lastpmrcminsactlist");
List<List<Object[]>> ganttchartlist=(List<List<Object[]>>)request.getAttribute("ganttchartlist");
List<Object[]> projectdatadetails = (List<Object[]> )request.getAttribute("projectdatadetails");
List<List<Object[]>> oldpmrcissueslist=(List<List<Object[]>>)request.getAttribute("oldpmrcissueslist");


List<List<ProjectFinancialDetails>> projectFinancialDetails = (List<List<ProjectFinancialDetails>>)request.getAttribute("financialDetails");
List<List<Object[]>> procurementOnDemand = (List<List<Object[]>>)request.getAttribute("procurementOnDemandlist");
List<List<Object[]>> procurementOnSanction = (List<List<Object[]>>)request.getAttribute("procurementOnSanctionlist");
 
List<List<Object[]>> riskmatirxdata = (List<List<Object[]>>)request.getAttribute("riskmatirxdata");


List<Object[]> lastpmrcdecisions = (List<Object[]>)request.getAttribute("lastpmrcdecisions");
List<List<Object[]>> actionplanthreemonths = (List<List<Object[]>>)request.getAttribute("actionplanthreemonths");

List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails"); 

List<String> projectidlist = (List<String>)request.getAttribute("projectidlist"); 

*/


%>


<body>


	<!-- <div  id="detailContainer" align="center" > -->
	<div  id="detailContainer" align="center" >
			<div><h2>Briefing Paper For <%if(Long.parseLong(committeeid)==1){ %>
   						PMRC
   						<%}else if(Long.parseLong(committeeid)==2){ %>
   						EB
   						<%} %> Meeting</h2></div>
			
<!-- ------------------------------------project attributes------------------------------------------------- -->
			<div style="margin-left: 10px;" align="left"><b>1. Project Attributes: </b></div>
			
			<%for(int z=0;z<projectidlist.size();z++)
			{	
			Object[] projectattributes =projectattributeslist.get(z);  %>  
			<%if(ProjectDetail.size()>1){ %>
				<div class="pname" align="left" >
					<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
				</div>	
			<%} %>
			
			<%if(projectattributes!=null){ %>
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
										<tr>
											 <td style="width: 30px; padding: 5px; padding-left: 10px">(a)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Project Title</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"> <%=projectattributes[1] %></td>
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(b)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Project No</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"> <%=projectattributes[0]%> </td>
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(c)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Category</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"><%=projectattributes[14]%></td>
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(d)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Date of Sanction</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"><%=sdf.format(sdf1.parse(projectattributes[3].toString()))%></td>
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(e)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Nodal and Participating Labs</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"><%if(projectattributes[15]!=null){ %><%=projectattributes[15]%><%} %></td>
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(f)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Objective</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"> <%=projectattributes[4]%></td>
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(g)</td>
											 <td  style="width: 200px;padding: 5px; padding-left: 10px">Deliverables</td>
											 <td colspan="3" style=" width: 310px; padding: 5px; padding-left: 10px"> <%=projectattributes[5]%></td>
										</tr>
										<tr>
											 <td rowspan="2" style="width: 30px; padding: 5px; padding-left: 10px">(h)</td>
											 <td rowspan="2" style="width: 200px;padding: 5px; padding-left: 10px">PDC</td>
											 <th >Original</th>
											 <th ></th>
								 			 <th ></th>
										</tr>
								 		<tr>
								 			 <td > <%= sdf.format(sdf1.parse(projectattributes[6].toString()))%> </td>
								 			 <td ></td>
								 		     <td ></td>
								 		</tr>
											 	
										<tr>
											 <td rowspan="2" style="width: 30px; padding: 5px; padding-left: 10px">(i)</td>
											 <td rowspan="2" style="width: 200px;padding: 5px; padding-left: 10px">Cost Breakup(In Lakhs)</td>
											
											<th >RE Cost</th>
											<th >FE Cost</th>
											<th >Total</th>
										</tr>
										<tr>
											<td ><%=projectattributes[8] %></td>
											<td ><%=projectattributes[9] %></td>
											<td ><%=projectattributes[7] %></td>
										</tr>											 	
										<tr>
											<td  style="width: 30px; padding: 5px; padding-left: 10px">(j)</td>
											<td  style="width: 200px;padding: 5px; padding-left: 10px">No. of EBs and PMRCs held </td>
								 			<td colspan="2" >EB: <%=ebandpmrccount.get(z).get(1)[1] %></td>
								 			<td colspan="1">PMRC: <%=ebandpmrccount.get(z).get(0)[1] %></td>
								 			
										</tr>
										<tr>
											 <td  style="width: 30px; padding: 5px; padding-left: 10px">(k)</td>
											 <td  style="width: 310px;padding: 5px; padding-left: 10px">Current Stage of Project</td>
											 <td colspan="3" style=" width: 200px; padding: 5px; padding-left: 10px"><span style="background-color: <%if(projectdatadetails.get(z)!=null){ %><%=projectdatadetails.get(z)[11] %> ;<%} %> padding:3px; border-radius:3px; " ><%if(projectdatadetails.get(z)!=null){ %> <%=projectdatadetails.get(z)[10] %> <%}else{ %>Data Not Found<%} %></span></td>
										</tr>	
			</table>
			<%}else{ %>
				<div align="center"  style="margin: 25px;" > Complete Project Data Not Found </div>
			<%} %>
			
		<%} %>
<!-- ------------------------------------project attributes------------------------------------------------- -->
		<h1 class="break"></h1>
<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->	
		<div style="margin-left: 10px;" align="left"><b>2. Schematic Configuration :</b></div>
		<%for(int z=0;z<projectidlist.size();z++){ %>
		
			<%if(ProjectDetail.size()>1){ %>
				<div class="pname" align="left" style="width: 100%;" >
					<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
				</div>	
			<%} %>
			
			<div align="left" style="margin-left: 15px;margin-top: 5px;">2(a) System Configuration</div>
			
				<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[3]!=null){ %>
				<div>
					<div><b>As on File Attached</b></div>
				</div>
				<%}else{ %>
				<div><b>File Not Found</b></div>
				<%} %>
			
			
			<div align="left" style="margin-left: 15px;margin-top: 5px;">2(b) System Specification</div>
			<br>
			
				<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[4]!=null){ %>
					<div><b>As on File Attached</b></div>
				<%}else{ %>
					<div><b>File Not Found</b></div>
				<%} %>
			<br>
		<%} %>
	<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->
	<%for(int z=0;z<projectidlist.size();z++){ %>	
		<div align="left" style="margin-left: 10px;margin-top: 5px;"><b>3. Overall Product tree/WBS:</b></div>
		<div>		
			<%if(ProjectDetail.size()>1){ %>
				<div class="pname" align="left" >
					<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
				</div>	
			<%} %>
			<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[5]!=null){ %>	
				<div><b>As on File Attached</b></div>
			<%}else{ %>
				<div><b>File Not Found</b></div>
			<%} %>
		</div>	
	<%} %>
	<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->
		
		

		<h1 class="break"></h1> 
<!-- ----------------------------------------------4.Details of work------------------------------------------------- -->			
		<div align="left" style="margin-left: 10px;"><b>4. Particulars of Meeting.</b></div>
		
		<%for(int z=0;z<projectidlist.size();z++){ %>
		
			<%if(ProjectDetail.size()>1){ %>
				<div class="pname" align="left" >
					<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
				</div>	
			<%} %>
		
			<div align="left" style="margin-left: 15px;">(a) Ratification of <b>recommendations</b> of last PMRC  (if any)</div>
			
			
										<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
											<tr>
												 <th  style="max-width: 30px;  ">Sl. No.</th>
												 <th  style="max-width: 610px; ">Recommendation Point</th>
											</tr>
											
											<%if(lastpmrcminsactlist.get(z).size()==0){ %>
											<tr><td colspan="6" align="center" > No Data</td></tr>
											<%}
											else if(lastpmrcminsactlist.get(z).size()>0)
											{int i=1;
											for(Object[] obj:lastpmrcminsactlist.get(z)){
													if(obj[3].toString().equalsIgnoreCase("R")){%>
												<tr>
													<td  style="max-width: 30px;"><%=i %></td>
													<td  style="max-width: 250px; styfill"><%=obj[2] %></td>
													
												</tr>		
											<%i++;}
											}%>
											<%if(i==1){ %> <tr><td colspan="5" align="center" > No Milestones Achieved</td></tr>	<%} %>
											
											<%} %>
												
										</table>
										
										
								<div align="left" style="margin-left: 15px;">(b) Last EB action points with Expected Date of completion (EDC)  and current status.
	   							</div>
								<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
											<tr>
										 		<th  style="max-width: 30px;  ">Sl. No.</th>
												 <th  style="max-width: 250px; ">Action Point</th>
												 <th  style="max-width: 80px; "> Expected Date of Completion (PDC)</th>
												 <th  style="max-width: 80px; "> Actual Date of Completion</th>
												 <th  style="max-width: 100px; "> Responsible agency/ Person</th>
												 <th  style="max-width: 100px; ">Status/ Remarks</th>			
											</tr>
											
											<%if(lastpmrcactions.get(z).size()==0){ %>
											<tr><td colspan="6" align="center" > No Data</td></tr>
											<%}
											else if(lastpmrcactions.get(z).size()>0)
											  {int i=1;
											for(Object[] obj:lastpmrcactions.get(z)){ %>
												<tr>
													<td  style="max-width: 30px;"><%=i %></td>
													<td  style="max-width: 250px;"><%=obj[2] %></td>
													<td  style="max-width: 80px;" ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
													<td  style="max-width: 80px;"> 
													<%if(obj[9].toString().equals("C")){ %>
													
													<%= sdf.format(sdf1.parse(obj[13].toString()))%> 
													<%}else{ %>-<%} %></td>
													<td  style="max-width: 100px;"> <%=obj[11] %>(<%=obj[12] %>) </td>
													<td  style="max-width: 100px;"> 
														<%if(obj[9].toString().equals("A") ){ %>
															ACTIVE
														<%}else if(obj[9].toString().equals("I") ){  %>
															IN PROGRESS
														<%}else if(obj[9].toString().equals("C") ){  %>
															COMPLETED
														<%} %> 
													</td>				
												</tr>			
											<%i++;
											}} %>
										</table>
							<div align="left" style="margin-left: 15px;">(c) Details of Technical/ User Reviews (if any).</div>
							
							<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				<%} %>
				 <h1 class="break"></h1>
<!-- -------------------------------------------------------------------------------------------- -->
		<div align="left" style="margin-left: 10px;"><b>5. Milestones achieved prior to this  
						<%if(Long.parseLong(committeeid)==1){ %>
   						PMRC
   						<%}else if(Long.parseLong(committeeid)==2){ %>
   						EB
   						<%}else if(Long.parseLong(committeeid)==0){ %>
   						Meeting
   						<%} %>  period.  </b></div>
			<%for(int z=0;z<projectidlist.size();z++){ %>
		
			<%if(ProjectDetail.size()>1){ %>
				<div class="pname" align="left" >
					<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
				</div>	
			<%} %>
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
				<tr>
										 <th  style="max-width: 65px; ">Milestone No.</th>
										 <th  style="max-width: 300px; ">Milestones (as per Project Proposal / Latest PDC Extension)</th>
										 <th  style="max-width: 80px; "> Original PDC (as per Project Proposal / Latest PDC Extension)</th>
										 <th  style="max-width: 80px; "> Revised PDC</th>
										 <th  style="max-width: 125px; "> Reason for Delay / Status</th>
									</tr>
									<%if(milestones.get(z).size()==0){ %>
										<tr><td colspan="5" align="center" > No Milestones Found</td></tr>
									<%}else if(milestones.get(z).size()>0)
									  {	
										int i=1;
										for(Object[] obj:milestones.get(z)){ 
											if(obj[10].toString().equalsIgnoreCase("3") ||obj[10].toString().equalsIgnoreCase("3") || obj[10].toString().equalsIgnoreCase("5"))
											{ %>
										<tr>
											<td  style="max-width: 65px;">M<%=obj[2]%></td>
											<td  style="max-width: 300px;"><%=obj[3] %></td>
											<td  style="max-width: 80px;" ><%= sdf.format(sdf1.parse(obj[5].toString()))%> </td>
											<td  style="max-width: 80px;"> <%= sdf.format(sdf1.parse(obj[7].toString()))%></td>
											<td  style="max-width: 125px;"><%=obj[11] %>	</td>
										</tr>			
									<% i++;
											}	
										}%>
										
									
									<%if(i==1){ %> <tr><td colspan="5" align="center" >No Milestones Achieved</td></tr>	<%} %>	
										
									<%} %>
									
								</table>
			<%} %>
						 <h1 class="break"></h1>
<!-- ------------------------------------------------------------------------------------------------------------ -->

		<div align="left" style="margin-left: 10px;"><b>6. Details of work and current status of sub system with major milestones (since last <%if(Long.parseLong(committeeid)==1){ %>
															   						PMRC
															   						<%}else if(Long.parseLong(committeeid)==2){ %>
															   						EB
															   						<%}else if(Long.parseLong(committeeid)==0){ %>
															   						Meeting
															   						<%} %>) period </b></div> 
				<%for(int z=0;z<projectidlist.size();z++){ %>
						<%if(ProjectDetail.size()>1){ %>
							<div class="pname" align="left" >
								<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
							</div>	
						<%} %>
			
						<div align="left" style="margin-left: 15px;">(a) Work carried out, Achievements, test result etc.</div>
						<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
									<tr>
										 <th  style="max-width: 50px; ">Sl. No</th>
										 <th  style="max-width: 315px; ">System/ Subsystem/ Activities</th>
										 <th  style="max-width: 150px; "> Present Status</th>
										 <th  style="max-width: 120px; "> Original PDC</th>
										 <th  style="max-width: 120px; "> Revised PDC/impact on overall project</th>
									</tr>
									
									<%if(milestonesubsystems.size()==0){ %>
										<tr><td colspan="5" align="center" > No SubSystems</td></tr>
									<%}else if(milestonesubsystems.size()>0)
									  { int i=1;
										for(Object[] obj:milestonesubsystems.get(z)){ %>
										<tr>
											<td  style="max-width: 50px;"><%=i%></td>
											<td  style="max-width: 315px;"><%=obj[2] %></td>
											<td  style="max-width: 150px;" ><%=obj[6] %></td>
											<td  style="max-width: 120px;"> <%= sdf.format(sdf1.parse(obj[3].toString()))%> </td>
											<td  style="max-width: 120px;"><%= sdf.format(sdf1.parse(obj[4].toString()))%></td>
										</tr>
									<%i++;}} %>
						</table>
						
						
						 <div align="left" style="margin-left: 15px;">(b) TRL table with TRL at sanction stage and current stage indicating overall PRI.</div>
							<div>
								<%-- <figure class="fill">
									<img style="margin-top: 10px;" <%if(projectdatadetails!=null && images[2]!=null && images[2].length()>0){ %> src="data:image/*;base64,<%=images[2]%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
								</figure> --%>
								<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[6]!=null ){ %>
								<div><b>As on File Attached</b></div>
								<%}else { %>
								<div><b>File Not Found</b></div>
								<%} %>
							</div>
											
						
						
						
			<div align="left" style="margin-left: 15px;">(c) Risk Matrix/Management Plan/Status. </div>
		<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
			
			<tr>
				 <th  style="max-width: 30px;  ">Risk id</th>
				 <th  style="max-width: 250px; ">Description</th>
				 <th  style="max-width: 80px; "> Severity</th>
				 <th  style="max-width: 100px; "> Probability</th>
				 <th  style="max-width: 200px; "> Mitigation Plans</th>
				 
			</tr>
				<%if(riskmatirxdata.size()>0){
				int i=0;%> 
					<%for(Object[] obj : riskmatirxdata.get(z)){
					i++;%>
					<tr>
						<td  style="max-width: 30px;"><%=i %></td>
						<td  style="max-width: 250px;"><%=obj[0] %></td>
						<td  style="max-width: 80px;" ><%=obj[1] %></td>
						<td  style="max-width: 100px;"><%=obj[2] %></td>
						<td  style="max-width: 200px;"><%=obj[3] %></td>										
					</tr>			
					<%}%>
				<%}else{%>
					<tr><td colspan="5" style="align: center;" >No Data Found</td></tr>
				<%} %>		
		</table> 
		<%} %>
<!-- ----------------------------------------------5.Particulars of Meeting------------------------------------------------- -->
 <h1 class="break"></h1>
<!-- ----------------------------------------------6. Procurement Status------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b>7. Details of Procurement plan (Major Items): </b></div>
								
				<%for(int z=0;z<projectidlist.size();z++){ %>
					<%if(ProjectDetail.size()>1){ %>
						<div class="pname" align="left" >
							<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
						</div>	
					<%} %>				
								
					<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
						<thead>
							<tr>
								<th colspan="6">Demand Stage</th>
							</tr>
							</thead>
								<tr>
									<th  style="max-width: 90px;">Demand No</th>
									<th  style="max-width: 90px; ">Demand Date</th>
									<th  style="max-width: 150px;"> Nomenclature</th>
									<th  style="max-width: 90px;"> Estimated Cost(Lakhs)</th>
									<th  style="max-width: 80px; "> Status</th>
									<th  style="max-width: 100px;">Remarks</th>			
								</tr>
								<%if(procurementOnDemand.get(z)!=null){%>
									<%for(Object[] obj:procurementOnDemand.get(z)){ %>
									<tr>
										<td style="max-width: 90px;"><%=obj[1]%></td>
										<td  style="max-width: 90px;"><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
										<td  style="max-width: 150px;" ><%=obj[8]%></td>
										<td  style="max-width: 90px; text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
										<td  style="max-width: 80px;"> <%=obj[10]%> </td>
										<td  style="max-width: 200px;"><%=obj[11]%> </td>				
									</tr>		
												
								<%} }%>
						</table>
						<div align="left" style="margin-left: 25px;"></div>
			                  	<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
										<thead>
										 <tr >
										 <th colspan="7">Sanction Stage</th>
										 </tr>
										</thead>
										<tr>
											 <th  style="max-width: 120px;">Supply Oder No</th>
											 <th  style="max-width: 100px; ">DP Date</th>
											 <th  style="max-width: 100px;">  Nomenclature</th>
											 <th  style="max-width: 90px;"> SO Cost(Lakhs)</th>
											 <th  style="max-width: 80px; "> Status</th>
											 <th  style="max-width: 80px;">Revised DP Date</th>
											 <th  style="max-width: 100px;">Remarks</th>			
										</tr>
										    <%if(procurementOnSanction.get(z)!=null){%>
										    <%for(Object[] obj:procurementOnSanction.get(z)){ %>
											<tr>
												<td  style="max-width: 120px;"><%=obj[2]%></td>
												<td  style="max-width: 100px;  text-align: center; font-size: 12px;"><%=sdf.format(sdf1.parse(obj[4].toString()))%></td>
												<td  style="max-width: 100px;"><%=obj[8]%></td>
												<td  style="max-width: 90px; text-align: right;"><%=format.format(new BigDecimal(obj[6].toString())).substring(1)%></td>
												<td  style="max-width: 80px;"><%=obj[10]%></td>
												   <td  style="max-width: 80px; text-align: center; font-size: 12px;"><%if(obj[7]!=null){%> <%=sdf.format(sdf1.parse(obj[7].toString()))%><%}else{ %>--<%} %></td>
												<td  style="max-width: 100px;"><%=obj[11]%></td>				
											</tr>		
											<%} }%>
									</table>
               			<%} %>
<!-- ----------------------------------------------6. Procurement Status------------------------------------------------- -->
 <h1 class="break"></h1>
<!-- ----------------------------------------------7. Overall financial Status------------------------------------------------- -->

		 
   					<div align="left" style="margin-left: 10px;"><b>8. Overall Financial Status </b></div><div align="right"><b><i><span style="text-decoration: underline;">(In crore)</span></i></b></div>
					
					<%for(int z=0;z<projectidlist.size();z++){ %>
						<%if(ProjectDetail.size()>1){ %>
							<div class="pname" align="left" >
								<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
							</div>	
						<%} %>
					
						 
						<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
						  	    <thead>
		                           <tr>
		                         	<td colspan="2" align="center"><b>Head</b></td>
		                         	<td colspan="2" align="center"><b>Sanction</b></td>
			                        <td colspan="2" align="center"><b>Expenditure</b></td>
			                        <td colspan="2" align="center"><b>Out Commitment</b> </td>
		                           	<td colspan="2" align="center"><b>Balance</b></td>
			                        <td colspan="2" align="center"><b>DIPL</b></td>
		                          	<td colspan="2" align="center"><b>Notional Balance</b></td>
			                      </tr>
			                      <tr>
				                    <th>SN</th>
				                    <th>Head</th>
				                    <th>RE</th>
				                    <th>FE</th>
				                    <th>RE</th>
				                    <th>FE</th>
			            	        <th>RE</th>
			                    	<th>FE</th>
		                  		    <th>RE</th>
				                    <th>Fe</th>
				                    <th>RE</th>
				                    <th>FE</th>
				                    <th>RE</th>
				                    <th>Fe</th>
		                       	  </tr>
			                    </thead>
			                    <tbody>
			                    <% DecimalFormat df=new DecimalFormat("####################.##");
		                		double totSanctionCost=0,totReSanctionCost=0,totFESanctionCost=0;
			                	double totExpenditure=0,totREExpenditure=0,totFEExpenditure=0;
			                 	double totCommitment=0,totRECommitment=0,totFECommitment=0,totalDIPL=0,totalREDIPL=0,totalFEDIPL=0;
				                double totBalance=0,totReBalance=0,totFeBalance=0,btotalRe=0,btotalFe=0;
				                int count=1;
			                        if(projectFinancialDetails!=null && projectFinancialDetails.size()>0 && projectFinancialDetails.get(z)!=null){
			                      for(ProjectFinancialDetails projectFinancialDetail:projectFinancialDetails.get(z)){                       %>
			 
			                         <tr>
								<td align="center"><%=count++ %></td>
								<td><%=projectFinancialDetail.getBudgetHeadDescription()%></td>
								<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction()) %></td>
								<%totReSanctionCost+=(projectFinancialDetail.getReSanction());%>
								<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
								<%totFESanctionCost+=(projectFinancialDetail.getFeSanction());%>
								<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure()) %></td>
								<%totREExpenditure+=(projectFinancialDetail.getReExpenditure());%>
							    <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
								<%totFEExpenditure+=(projectFinancialDetail.getFeExpenditure());%>
							    <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
								<%totRECommitment+=(projectFinancialDetail.getReOutCommitment());%>
							    <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeOutCommitment())%></td>
								<%totFECommitment+=(projectFinancialDetail.getFeOutCommitment());%>
								<td align="right"style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl())%></td>
								<%btotalRe+=(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl());%>
								<td align="right"style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl())%></td>
						       	<%btotalFe+=(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl());%>
							 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReDipl())%></td>
								<%totalREDIPL+=(projectFinancialDetail.getReDipl());%>
							 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeDipl())%></td>
								<%totalFEDIPL+=(projectFinancialDetail.getFeDipl());%>
					<%-- 				<%double balance=(res.getDouble("SanctionCost")-(res.getDouble("Expenditure")+res.getDouble("OutCommitment")+res.getDouble("Dipl"));%> --%>
							 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance())%></td>
								<%totReBalance+=(projectFinancialDetail.getReBalance());%>
							 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance())%></td>
								<%totFeBalance+=(projectFinancialDetail.getFeBalance());%>
							</tr>
								<%} }%>
								</tbody>
										<tr>
								<td colspan="2">Total</td>
								<td align="right" style="text-align: right;"><%=df.format(totReSanctionCost)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totFESanctionCost)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totREExpenditure)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totFEExpenditure)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totRECommitment)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totFECommitment)%></td>
								<td align="right" style="text-align: right;"><%=df.format(btotalRe)%></td>
								<td align="right" style="text-align: right;"><%=df.format(btotalFe)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totalREDIPL)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totalFEDIPL)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totReBalance)%></td>
								<td align="right" style="text-align: right;"><%=df.format(totFeBalance)%></td>
							</tr>
							<tr>
								<td colspan="2">GrandTotal</td>
								<td colspan="2" align="right" style="text-align: right;"><%=df.format(totReSanctionCost+totFESanctionCost)%></td>
								<td colspan="2" align="right" style="text-align: right;"><%=df.format(totREExpenditure+totFEExpenditure)%></td>
								<td colspan="2" align="right" style="text-align: right;"><%=df.format(totRECommitment+totFECommitment)%></td>
								<td colspan="2" align="right" style="text-align: right;"><%=df.format(btotalRe+btotalFe)%></td>
								<td colspan="2" align="right" style="text-align: right;"><%=df.format(totalREDIPL+totalFEDIPL)%></td>
								<td colspan="2" align="right" style="text-align: right;"><%=df.format(totReBalance+totFeBalance)%></td>
							</tr>
					     </tbody>
					</table>  	
							
								
..........................................................................................................................................................................

					<%} %>

 	<h1 class="break"></h1>
<!-- ---------------------------------------------- -------------------------- ------------------------------------------------- -->
		<div align="left" style="margin-left: 10px;"><b>9. Action Plan for Next six months - Technical Milestones with financial outlay : </b></div>
			<%for(int z=0;z<projectidlist.size();z++){ %>
				<%if(ProjectDetail.size()>1){ %>
					<div class="pname" align="left" >
						<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
					</div>	
				<%} %>
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 15px; border-collapse:collapse;" >
				<tr>
					<th style="-width: 25px;">Sl.No.</th>
					<th style="width: 250px;">Action Plan </th>	
					<th style="width: 100px;">Probable Date of Completion</th>	
					<th style="width: 100px;">Responsible Agency/ Person </th>	
					<th style="width: 185px;">Status/ Remarks</th>	
				</tr>
				<%if(actionplanthreemonths.get(z).size()>0){ 
									long count1=1;%>
									<%for(Object[] obj:actionplanthreemonths.get(z)){ %>
										<tr>
											<td><%=count1 %></td>
											<td>
												<%if(!obj[10].toString().trim().equals("")){ %>
													<%=obj[10] %>
												<%}else if(!obj[9].toString().trim().equals("")){ %>
													<%=obj[9] %>
												<%}else if(!obj[8].toString().trim().equals("")){ %>
													<%=obj[8] %>
												<%}else if(!obj[7].toString().trim().equals("")){ %>
													<%=obj[7] %>
												<%} %>
											</td>
											<td><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td></td>
											<td><%=obj[15] %></td>
										</tr>
									<%count1++;} %>
								<%} %>
			</table>
		<%} %>
<!-- ----------------------------------------------8. Action plan for next three months------------------------------------------------- -->
<!-- ----------------------------------------------9.GANTT chart---------------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b>10. PERT/GANTT chart of overall project schedule [<span style="text-decoration: underline;">Original</span> (as per Project sanction / Latest PDC extension) and <span style="text-decoration: underline;">Current</span>]: </b></div>
			<div>
						
<!-- -----------------------------------------------gantt chart js ------------------------------------------------------------------------------------------------------------------------------- -->						    		
				<%if(isprint!=null && isprint.equals("1")){%>
					 <%for(int z=0;z<projectidlist.size();z++){ %>
					    	<%if(ProjectDetail.size()>1){ %>
								<div class="pname" align="left" >
									<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
								</div>	
							<%} %>
						    <div class="row">
						    	<div class="col-md-9 "></div>
								<div class="col-md-3 " style="float:right;margin-top:10px; ">
									<label>Interval : &nbsp;&nbsp;&nbsp; </label>
									<select class="form-control selectdee " name="interval_<%=projectidlist.get(z)%>" id="interval_<%=projectidlist.get(z)%>" required="required"  data-live-search="true"  style="width:150px !important" >
				                         <option value="quarter"> Quarterly </option>
				                         <option value="half" >Half-Yearly</option>
				                         <option value="year" >Yearly</option>
				                         <option value="month"> Monthly </option>
									</select>
								</div>
							</div>
	<!-- -----------------------------------------------gantt chart js ------------------------------------------------------------------------------------------------------------------------------- -->						    		
							<div class="row">
								<div class="col-md-12" style="float: right;" align="center">
								   	<div class="flex-container containers" id="containers_<%=projectidlist.get(z)%>"  ></div>
								</div>		
							</div>		
						</div>
					<%} %>				
				<%}else{ %>
					<br><br><br><br><br><br>
				<%} %>
						    	
			</div>	
<!-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b>11. Issues:</b></div>
			
			 <%for(int z=0;z<projectidlist.size();z++){ %>
			   
			    	<%if(ProjectDetail.size()>1){ %>
						<div class="pname" align="left" >
							<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
						</div>	
					<%} %>
					<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 650px; font-size: 16px; border-collapse:collapse;" >
										<tr>
											 <th  style="max-width: 30px;  ">Sl. No.</th>
											 <th  style="max-width: 250px; ">Issue Point</th>
											 <th  style="max-width: 80px; "> Probable Date of Completion (PDC)</th>
											 <th  style="max-width: 80px; "> Actual Date of Completion</th>
											 <th  style="max-width: 100px; "> Responsible agency/ Person</th>
											 <th  style="max-width: 100px; ">Status/ Remarks</th>			
										</tr>
										
										<%if(oldpmrcissueslist.get(z).size()==0){ %>
										<tr><td colspan="6" align="center" > No Data</td></tr>
										<%}
										else if(oldpmrcissueslist.get(z).size()>0)
										  {int i=1;
										for(Object[] obj:oldpmrcissueslist.get(z)){ %>
											<tr>
												<td  style="max-width: 30px;"><%=i %></td>
												<td  style="max-width: 250px;"><%=obj[2] %></td>
												<td  style="max-width: 80px;" ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
												<td  style="max-width: 80px;"> 
												<%if(obj[9].toString().equals("C")){ %>
												
												<%= sdf.format(sdf1.parse(obj[13].toString()))%> 
												<%}else{ %>-<%} %></td>
												<td  style="max-width: 100px;"> <%=obj[11] %>(<%=obj[12] %>) </td>
												<td  style="max-width: 100px;"> 
													<%if(obj[9].toString().equals("A") ){ %>
														ACTIVE
													<%}else if(obj[9].toString().equals("I") ){  %>
														IN PROGRESS
													<%}else if(obj[9].toString().equals("C") ){  %>
														COMPLETED
													<%} %> 
												</td>				
											</tr>			
										<%i++;
										}} %>
									</table>
								<%} %>

									
<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
									<div align="left" style="margin-left: 10px;"><b>12. Other Relevant Points ()if any).</b></div>
										<br><br><br><br><br><br><br><br>
<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
									<div align="left" style="margin-left: 10px;"><b>13. Decision/Recommendations sought from <%if(Long.parseLong(committeeid)==1){ %>
						   						PMRC
						   						<%}else if(Long.parseLong(committeeid)==2){ %>
						   						EB
						   						<%}else if(Long.parseLong(committeeid)==0){ %>
						   						Meeting
						   						<%} %>:</b></div>
						   						
						   		<%for(int z=0;z<projectidlist.size();z++){ %>
			   
							    	<%if(ProjectDetail.size()>1){ %>
										<div class="pname" align="left" >
											<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z==0){ %>(MAIN)<%}else{ %> (SUB)<%} %>	</b>
										</div>	
									<%} %>
									<div><%if(lastpmrcdecisions.get(z)!=null && lastpmrcdecisions.get(z)[0]!=null && !lastpmrcdecisions.get(z)[0].toString().trim().equals("")){ %>
													
														<%=lastpmrcdecisions.get(z)[0] %>
													<%}else{ %>
												  	NO DATA 
												  	<br><br><br><br><br>
												  	<%} %></div>	
											<br><br><br><br><br>
									<%} %>
<!-- ----------------------------------------------11.Decisions----------------------------------------------------------------- -->


	


<%if(isprint!=null && !isprint.equals("1")){%>
		
	<%for(int z=0;z<projectidlist.size();z++){ %>
				<script>
								    	  
									function chartprint_<%=projectidlist.get(z)%>(type,interval){ 
								    	  var data = [
								    		  
 											<%for(Object[] obj : ganttchartlist.get(z)){%>
								    		  
								    		  {
								    		    id: "<%=obj[3]%>",
								    		    name: "<%=obj[2]%>",
								    		    baselineStart: "<%=obj[6]%>",
								    		    baselineEnd: "<%=obj[7]%>",
								    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
								    		    actualStart: "<%=obj[4]%>",
								    		    actualEnd: "<%=obj[5]%>",
								    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
								    		    progressValue: "<%=obj[8]%>%",
								    		    progress: {fill: "#81b214 0.5", stroke: "0.5 #150e56"},
								    		    rowHeight: "35",						    		   
								    		  },
								    		  
								    		  <%}%>
								    	
								    		  ];
								    		    
								    		 
								    		// create a data tree
								    		var treeData = anychart.data.tree(data, "as-tree");
								
								    		// create a chart
								    		var chart = anychart.ganttProject();
								
								    		// set the data
								    		chart.data(treeData);   
								  
								        	// set the container id
								        	
								        	chart.container("containers_<%=projectidlist.get(z)%>");  

								        	// initiate drawing the chart
								        	chart.draw();    
									
								        	// fit elements to the width of the timeline
								        	chart.fitAll();
								        
								        	 chart.getTimeline().tooltip().useHtml(true);    
										        chart.getTimeline().tooltip().format(
										          "<span style='font-weight:600;font-size:10pt'> Actual : " +
										          "{%actualStart}{dateTimeFormat:dd MMM yyyy} - " +
										          "{%actualEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
										          "<span style='font-weight:600;font-size:10pt'> Revised : " +
										          "{%baselineStart}{dateTimeFormat:dd MMM yyyy} - " +
										          "{%baselineEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
										          "Progress: {%progress}<br>" 
										        ); 
										        
								        
								        
								       
								        /* Title */
								        
								        var title = chart.title();
										title.enabled(true);
										title.text("<%=ProjectDetail.get(z)[2] %> ( <%=ProjectDetail.get(z)[1] %> ) Gantt Chart");
										title.fontColor("#64b5f6");
										title.fontSize(18);
										title.fontWeight(600);
										title.padding(5);
								        
										<%-- <%} %> --%>
																	        
								        chart.rowHoverFill("#8fd6e1 0.3");
								        chart.rowSelectedFill("#8fd6e1 0.3");
								        chart.rowStroke("0.5 #64b5f6");
								        chart.columnStroke("0.5 #64b5f6");
								        
								        chart.defaultRowHeight(35);
								     	chart.headerHeight(90);
								     	
								     	/* Hiding the middle column */
								     	chart.splitterPosition("17.4%");
								     	
								     	var dataGrid = chart.dataGrid();
								     	dataGrid.rowEvenFill("gray 0.3");
								     	dataGrid.rowOddFill("gray 0.1");
								     	dataGrid.rowHoverFill("#ffd54f 0.3");
								     	dataGrid.rowSelectedFill("#ffd54f 0.3");
								     	dataGrid.columnStroke("2 #64b5f6");
								     	dataGrid.headerFill("#64b5f6 0.2");
								     	
								     
								     	/* Title */
								     	var column_1 = chart.dataGrid().column(0);
								     	column_1.title().enabled(false);
								     	
								     	var column_2 = chart.dataGrid().column(1);
								     	column_2.title().text("Milestone");
								     	column_2.title().fontColor("#145374");
								     	column_2.title().fontWeight(600);
								     	
								     	
								     
								     	if(interval==="year"){
								     		/* Yearly */
									     	chart.getTimeline().scale().zoomLevels([["year"]]);
									     	var header = chart.getTimeline().header();
									     	header.level(2).format("{%value}-{%endValue}");
									     	header.level(1).format("{%value}-{%endValue}"); 
								     	}
								     	
								     	if(interval==="half"){
								     		/* Half-yearly */
									     	chart.getTimeline().scale().zoomLevels([["semester", "year"]]);
									     	var header = chart.getTimeline().header();
									     	header.level(2).format("{%value}-{%endValue}");
								     	}
								     	
								     	if(interval==="quarter"){
								     		/* Quarterly */
									     	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
								     	}
								     	
								     	if(interval==="month"){
								     		/* Monthly */
									     	chart.getTimeline().scale().zoomLevels([["month", "quarter","year"]]);
								     	}
								     	
								     	else if(interval===""){
															     		
								     		/* Quarterly */
									     	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
								     		
								     	}
								     	
								     	
								     	
								     	/* chart.getTimeline().scale().fiscalYearStartMonth(4); */
								     	
								     	/* Header */
								     	var header = chart.getTimeline().header();
								     	header.level(0).fill("#64b5f6 0.2");
								     	header.level(0).stroke("#64b5f6");
								     	header.level(0).fontColor("#145374");
								     	header.level(0).fontWeight(600);
								     	
								     	/* Marker */
								     	var marker_1 = chart.getTimeline().lineMarker(0);
								     	marker_1.value("current");
								     	marker_1.stroke("2 #dd2c00");
								     	
								     	/* Progress */
								     	var timeline = chart.getTimeline();
								     	
								     	timeline.tasks().labels().useHtml(true);
								     	timeline.tasks().labels().format(function() {
								     	  if (this.progress == 1) {
								     	    return "<span style='color:orange;font-weight:bold;font-family:'Lato';'>Completed</span>";
								     	  } else {
								     	    return "<span style='color:black;font-weight:bold'>" +
								     	           this.progress * 100 + "</span>%";
								     	  }
								     	});
								     	
								     	
								    // calculate height
								     	var traverser = treeData.getTraverser();
								        var itemSum = 0;
								        var rowHeight = chart.defaultRowHeight();
								        while (traverser.advance()){
								           if (traverser.get('rowHeight')) {
								          itemSum += traverser.get('rowHeight');
								        } else {
								        	itemSum += rowHeight;
								        }
								        if (chart.rowStroke().thickness != null) {
								        	itemSum += chart.rowStroke().thickness;
								        } else {
								          itemSum += 1;
								        }
								        }
								        itemSum += chart.headerHeight();
								        
								       
								        var menu = chart.contextMenu();
								        
								       
								          
									} 
								  
	
		
		 $( document ).ready(function(){
	    	  
	    	  chartprint_<%=projectidlist.get(z)%>('type','');
	      })
	      
	      
	      function ChartPrint_<%=projectidlist.get(z)%>(){
		   		console.log("#interval_<%=projectidlist.get(z) %>");
	    	  var interval_<%=projectidlist.get(z) %> = $("#interval_<%=projectidlist.get(z) %>").val();
	    	  $('#containers_<%=projectidlist.get(z) %>').empty();
	    	  chartprint_<%=projectidlist.get(z)%>('print',interval_<%=projectidlist.get(z) %>);
	     }
	     
	 
				$('#interval_<%=projectidlist.get(z) %>').on('change',function(){
					
					$('#containers_<%=projectidlist.get(z) %>').empty();
					var interval_<%=projectidlist.get(z) %> = $("#interval_<%=projectidlist.get(z) %>").val()
					chartprint_<%=projectidlist.get(z)%>('type',interval_<%=projectidlist.get(z) %>);
					
				})
		
		
		
		</script>
					
					
					<%} %>
<%} %>
<!-- ------------------------------------------------------------------------------------------------ -->
	
<!-- ------------------------------------------------------------------------------------------------ -->


</body>
</html>