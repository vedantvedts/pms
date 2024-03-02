<%@page import="com.vts.pfms.projectclosure.model.ProjectClosure"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPProjects"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACP"%>
<%@page import="com.vts.pfms.project.model.ProjectMasterRev"%>
<%@page import="com.vts.pfms.project.model.ProjectMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrative Closure</title>

<style>

.break{
	page-break-after: always;
} 

.border_black {
	border : 1px solid black;
	padding : 10px 5px;
}

    
.left{
	text-align: left
}

.right{
	text-align: right
}

.center{
	text-align: center
}


#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
.bold{
	font-weight: 800 !important;
}

 @page  {             
          size: 790px 1120px;
          margin-top: 100px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          /* border: 1px solid black;  */
          
          @bottom-left {          		
             content: "";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
             
                    
           @bottom-right  {
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
          }
           @top-right {
             content: "DRDO.DPFM.FF.14";
             margin-top: 30px;
             font-size: 13px;
          }
          
          @top-center {
             content: "";
             margin-top: 30px;
             font-size: 13px;
          }
          
          
          @top-left {
          	margin-top: 30px;
            content: "";
            font-size: 13px;
          }               
          
 }
 
.editor-text span,p,h1,h2,h3,h4,h5,h6{
	font-size: 17px !important;
	font-family: 'Times New Roman', Times, serif !important;
}
          
.heading-color{
	color: #145374;
}

.editor-text table{
	width:  595px !important;
}

.editor-text span,p{
	font-weight: 500 !important;
}

.editor-text {
	font-size: 17px !important;
	font-family: 'Times New Roman', Times, serif !important;

}



.main-text{
	padding-right: 15px !important
}

.editor-text-font td{
	font-size : 17px !important;
	padding: 2px 4px !important;
}

.editor-data{
	margin-left: 10px;
	margin-right : 10px;
	text-indent: 20px;
}

#tabledata{
 margin-left : 30px;
 border-collapse : collapse;
 /* border : 1px solid black; */
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
  text-align: justify !important;
 text-justify: inter-word;
}
#tabledata td{
 text-align : left;
 vertical-align: top;
  text-align: justify !important;
 text-justify: inter-word;
}
#tabledata td,th{
 /* border : 1px solid black; */
 padding : 5px;

}

p
{
	text-align: justify !important;
  	text-justify: inter-word;
}
p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}


#projectdatatablep{
 border-collapse : collapse;
 border : 1px solid black; 
}
#projectdatatablep th{
 text-align : center !important;
 font-size: 14px;
  border : 1px solid black; 
}
#projectdatatablep td{
 text-align : left !important;
 vertical-align: top;
 white-space: normal;
 word-wrap: break-word;
 word-break: normal;
}
#projectdatatablep td,th{
 border : 1px solid black; 
 padding : 5px;
}
</style>
</head>
<body>
<%
ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
ProjectClosure closure = (ProjectClosure)request.getAttribute("ProjectClosureDetails");
ProjectMasterRev projectMasterRev = (ProjectMasterRev)request.getAttribute("ProjectMasterRevDetails");
ProjectClosureACP acp = (ProjectClosureACP)request.getAttribute("ProjectClosureACPData");

Object[] potherdetails = (Object[])request.getAttribute("ProjectOriginalRevDetails");
Object[] expndDetails = (Object[])request.getAttribute("ProjectExpenditureDetails");
List<ProjectClosureACPProjects> linkedprojectsdata = (List<ProjectClosureACPProjects>)request.getAttribute("ACPProjectsData");
List<ProjectClosureACPConsultancies> consultancies = (List<ProjectClosureACPConsultancies>)request.getAttribute("ACPConsultanciesData");
List<ProjectClosureACPTrialResults> trialresults = (List<ProjectClosureACPTrialResults>)request.getAttribute("ACPTrialResultsData");
List<ProjectClosureACPAchievements> achievements = (List<ProjectClosureACPAchievements>)request.getAttribute("ACPAchivementsData");

List<ProjectClosureACPProjects> subprojects = linkedprojectsdata!=null && linkedprojectsdata.size()>0 ? linkedprojectsdata.stream().filter(e -> e.getACPProjectType().equalsIgnoreCase("S")).collect(Collectors.toList()): new ArrayList<>();
List<ProjectClosureACPProjects> carscapsiprojects = linkedprojectsdata!=null && linkedprojectsdata.size()>0 ? linkedprojectsdata.stream().filter(e -> !e.getACPProjectType().equalsIgnoreCase("S")).collect(Collectors.toList()): new ArrayList<>();

List<Object[]> acpApprovalEmpData = (List<Object[]>)request.getAttribute("ACPApprovalEmpData");

String labcode = (String)session.getAttribute("labcode");

long closureId = closure!=null? closure.getClosureId():0;

FormatConverter fc = new FormatConverter();

DecimalFormat df = new DecimalFormat("#.####");
df.setMinimumFractionDigits(4); 

List<String> projectidlist = (List<String>) request.getAttribute("projectidlist");
List<List<ProjectFinancialDetails>> projectFinancialDetails = (List<List<ProjectFinancialDetails>>) request.getAttribute("financialDetails");
%>

	<div align="center">
		<h5 style="font-weight: bold;margin-top: -0.5rem;">
			AUDIT OF STATEMENT OF ACCOUNTS (EXPENDITURE) AND ADMINISTRATIVE CLOSURE OF PROJECT / PROGRAMME
		</h5>
		<h5 style="font-weight: bold;margin-top: -1.5rem;">Part - I</h5>
	</div>
	<%int slno=0; %>
    <table id="tabledata" style="margin-top: -2rem;">
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td style="width: 35%;text-align: left !important;font-weight: 600;">Name of Lab</td>
			<td>: <%=labcode %> </td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Title of the Project/Programme</td>
    		<td>: <%=projectMaster.getProjectName() %> </td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Date of Sanction</td>
    		<td>: <%if(projectMaster!=null && projectMaster.getSanctionDate()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getSanctionDate().toString()) %><%} else{%><%} %></td>
		</tr>	
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Category of Project</td>
    		<td>: <%if(potherdetails!=null && potherdetails[0]!=null) {%><%=potherdetails[0] %><%} %> </td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td colspan="1" style="width: 35%;font-weight: 600;">Cost in Cr (original & revised)</td>
    		<td>:</td>
		</tr>
		<tr>
			<td style="width: 5%;"></td>
			<td colspan="2">
				<table id="projectdatatablep" style="width: 80%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
					    	<th style="width: 20%;">Cost (&#8377;)</th>
					    	<th style="width: 35%;">Original</th>
					    	<th style="width: 35%;">Revised</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>RE</td>
							<td style="text-align: right !important;">
								<%if(potherdetails!=null && potherdetails[1]!=null) {%>
									<%=df.format(Double.parseDouble(potherdetails[1].toString())/10000000) %>
								<%} else{%>
									--
								<%} %>
							</td>
							<td style="text-align: right !important;">
								<%if(potherdetails!=null && potherdetails[4]!=null) {%>
									<%=df.format(Double.parseDouble(potherdetails[4].toString())/10000000) %>
								<%} else{%>
									--
								<%} %>
							</td>
						</tr>
						<tr>
							<td>FE</td>
							<td style="text-align: right !important;">
								<%if(potherdetails!=null && potherdetails[2]!=null) {%>
									<%=df.format(Double.parseDouble(potherdetails[2].toString())/10000000) %>
								<%} else{%>
									--
								<%} %>
							</td>
							<td style="text-align: right !important;">
								<%if(potherdetails!=null && potherdetails[5]!=null) {%>
									<%=df.format(Double.parseDouble(potherdetails[5].toString())/10000000) %>
								<%} else{%>
									--
								<%} %>
							</td>
						</tr>
						<tr>
							<td>Total (FE)</td>
							<td style="text-align: right !important;">
								<%if(potherdetails!=null && potherdetails[3]!=null) {%>
									<%=df.format(Double.parseDouble(potherdetails[3].toString())/10000000) %>
								<%} else{%>
									--
								<%} %>
							</td>
							<td style="text-align: right !important;">
								<%if(potherdetails!=null && potherdetails[6]!=null) {%>
									<%=df.format(Double.parseDouble(potherdetails[6].toString())/10000000) %>
								<%} else{%>
									--
								<%} %>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">PDC of the Project</td>
    		<td>:</td>
		</tr>
		<tr>
    		<td style="width: 5%;"></td>
    		<td colspan="2">
    			<table id="projectdatatablep" style="width: 80%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
					    	<th style="width: 30%;">Original</th>
					    	<th style="width: 30%;">Revised</th>
					    	<th style="width: 35%;">No of Revisions</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align: center !important;">
								<%if(potherdetails!=null && potherdetails[7]!=null) {%>
									<%=fc.SqlToRegularDate(potherdetails[7].toString()) %>
								<%} else{%>
									--
								<%} %>
							</td>
							<td style="text-align: center !important;">
								<%if(potherdetails!=null && potherdetails[8]!=null) {%>
									<%=fc.SqlToRegularDate(potherdetails[8].toString()) %>
								<%} else{%>
									--
								<%} %>
							</td>
							<td style="text-align: center !important;">
								<%if(potherdetails!=null && potherdetails[9]!=null) {%>
									<%=potherdetails[9] %>
								<%} %>
							</td>
						</tr>
					</tbody>
				</table>
    		</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Expenditure ( as on <%-- <%if(acp.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(acp.getExpndAsOn()) %> <%} else{%>-<%} %> --%> )</td>
    		<td>
    			: Total(<span style="font-size: 12px;">&#x20B9;</span>)
    				<span style="text-decoration: underline;">
    					<%-- <%if(acp.getTotalExpnd()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpnd())) %> <%} %> --%>
    					<%if(expndDetails!=null && expndDetails[0]!=null) {%>
    						<%=df.format(Double.parseDouble(expndDetails[0].toString())/10000000 ) %> 
    					<%} %>
    				</span> Cr
    			 (FE<span style="text-decoration: underline;">
    					<%-- <%if(acp.getTotalExpndFE()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpndFE())) %> <%} %> --%>
    					<%if(expndDetails!=null && expndDetails[1]!=null) {%>
    					<%=df.format(Double.parseDouble(expndDetails[1].toString())/10000000 ) %> <%} %>
    				</span>) Cr	
    		</td>
		</tr>	
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Aim & Objectives</td>
    		<td>: <%if(projectMaster.getObjective()!=null) {%><%=projectMaster.getObjective() %><%} %></td>
    	</tr>
    	<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">No of Prototypes (type approved/qualified) deliverables as brought out in Govt. Letter</td>
    		<td>: <%=acp.getPrototyes() %></td>
    	</tr>
    	<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">List of sub-projects</td>
    		<td>: </td>
		</tr>
		<tr>
			<td style="width: 5%;"></td>
			<td colspan="2">
				<table id="projectdatatablep" style="width: 100%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
							<th style="width: 5%;">SN</th>
					    	<th style="width: 15%;">Projects Name</th>
					    	<th style="width: 10%;">Project No</th>
					    	<th style="width: 15%;">Agency</th>
					    	<th style="width: 10%;">Cost in Cr (&#8377;)</th>
					    	<th style="width: 20%;">Status</th>
					    	<th style="width: 25%;">Achievement</th>
						</tr>
					</thead>
					<tbody>
						<%if(subprojects!=null && subprojects.size()>0) {
							int subprojectslno = 0;
							for(ProjectClosureACPProjects sub :subprojects) {%>
							<tr>
								<td style="width: 5%;text-align: center !important;"><%=++subprojectslno %></td>
								<td style="width: 15%;"><%=sub.getACPProjectName() %> </td>
								<td style="width: 10%;text-align: center !important;"><%=sub.getACPProjectNo() %> </td>
								<td style="width: 15%;"><%=sub.getProjectAgency() %> </td>
								<td style="width: 10%;text-align: right !important;"><%=df.format(Double.parseDouble(sub.getProjectCost())/10000000) %> </td>
								<td style="width: 20%;"><%=sub.getProjectStatus() %> </td>
								<td style="width: 25%;"><%=sub.getProjectAchivements() %> </td>
							</tr>
						<%} }%>	
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">List of CARS / CAPSI</td>
    		<td>: </td>
		</tr>
		<tr>
			<td style="width: 5%;"></td>
			<td colspan="2">
    			<table id="projectdatatablep" style="width: 100%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
							<th style="width: 5%;">SN</th>
					    	<th style="width: 5%;">CARS / CAPSI</th>
					    	<th style="width: 15%;">CARS / CAPSI Name</th>
					    	<th style="width: 10%;">CARS / CAPSI No</th>
					    	<th style="width: 15%;">Agency</th>
					    	<th style="width: 10%;">Cost in Cr (&#8377;)</th>
					    	<th style="width: 15%;">Status</th>
					    	<th style="width: 20%;">Achievement</th>
						</tr>
					</thead>
					<tbody>
						<%if(carscapsiprojects !=null && carscapsiprojects.size()>0) {
							int carscapsiprojectslno = 0;
							for(ProjectClosureACPProjects carscapsi :carscapsiprojects) {%>
							<tr>
								<td style="width: 5%;text-align: center !important;"><%=++carscapsiprojectslno %></td>
								<td style="width: 5%;">
									<%if(carscapsi.getACPProjectType()!=null && carscapsi.getACPProjectType().equalsIgnoreCase("R")) {%>
										CARS
									<%} else{%>
										CAPSI
									<%} %>
								</td>
								<td style="width: 15%;"><%=carscapsi.getACPProjectName() %> </td>
								<td style="width: 10%;text-align: center !important;"><%=carscapsi.getACPProjectNo() %> </td>
								<td style="width: 15%;"><%=carscapsi.getProjectAgency() %> </td>
								<td style="width: 10%;text-align: right !important;"><%=df.format(Double.parseDouble(carscapsi.getProjectCost())/10000000) %> </td>
								<td style="width: 20%;"><%=carscapsi.getProjectStatus() %> </td>
								<td style="width: 20%;"><%=carscapsi.getProjectAchivements() %> </td>
							</tr>
						<%} }%>	
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">List of Consultancies</td>
    		<td>: </td>
		</tr>
    	<tr>
    		<td style="width: 5%;"></td>
    		<td colspan="2">
    			<table id="projectdatatablep" style="width: 100%;" >
				<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
					<tr>
						<th style="width: 5%;">SN</th>
				    	<th style="width: 35%;">Aim</th>
				    	<th style="width: 25%;">Agency</th>
				    	<th style="width: 20%;">Amount in Cr (&#8377;)</th>
				    	<th style="width: 15%;">Date</th>
					</tr>
				</thead>
				<tbody>
					<%if(consultancies !=null && consultancies.size()>0) {
						int consultancieslno = 0;
						for(ProjectClosureACPConsultancies consultancy :consultancies) {%>
						<tr>
							<td style="width: 5%;text-align: center !important;"><%=++consultancieslno %></td>
							<td style="width: 35%;"> <span class="editor-text"><%=new String(consultancy.getConsultancyAim().getBytes("ISO-8859-1"), "UTF-8") %></span> </td>
							<td style="width: 25%;"><%=consultancy.getConsultancyAgency() %> </td>
							<td style="width: 20%;text-align: right !important;"><%=df.format(Double.parseDouble(consultancy.getConsultancyCost())/10000000) %> </td>
							<td style="width: 15%;text-align: center !important;"><%=fc.SqlToRegularDate(consultancy.getConsultancyDate()) %> </td>
						</tr>
					<%} }%>	
				</tbody>
			</table>
    		</td>
    	</tr>
    	<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Details of Facilities created (as proposed in the programme) </td>
    		<td>: </td>
		</tr>
    	<tr>
    		<td colspan="3">
    			<div class="editor-text"><%if(acp.getFacilitiesCreated()!=null) {%><%=acp.getFacilitiesCreated() %><%} %></div>
    		</td>
    	</tr>
    	<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Trial Results </td>
    		<td>: </td>
    	</tr>
    	<tr>
    		<td colspan="1"></td>
    		<td colspan="2">
    			<span><%if(acp.getTrialResults()!=null) {%><%=acp.getTrialResults() %><%} %></span>
    		</td>
    	</tr>
    	<tr>
    		<td colspan="1"></td>
    		<td colspan="2">
    			<table id="projectdatatablep" style="width: 100%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
							<th style="width: 5%;">SN</th>
					    	<th style="width: 70%;">Description</th>
					    	<th style="width: 20%;">Action</th>
						</tr>
					</thead>
					<tbody>
						<%if(trialresults!=null && trialresults.size()>0) {
							int trialresultsslno = 0;
							for(ProjectClosureACPTrialResults results :trialresults) {%>
							<tr>
								<td style="width: 5%;text-align: center;"><%=++trialresultsslno %></td>
								
								<td style="width: 70%;"><%=results.getDescription() %> </td>
								<td style="width: 25%;text-align: center !important;">
									<%if(results.getAttachment()!=null && !results.getAttachment().isEmpty()) {%>
										<a href="ProjectClosureACPTrialResultsFileDownload.htm?attachmentfile=<%=results.getTrialResultsId()%>" target="_blank">Download</a>
									<%} %>
								</td>
							</tr>
						<%} }%>	
					</tbody>
				</table>
    		</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Achievements</td>
    		<td>: </td>
		</tr>
		<tr>
			<td colspan="1"></td>
    		<td colspan="2">
    			<table id="projectdatatablep" style="width: 100%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
							<th style="width: 5%;">SN</th>
					    	<th style="width: 32.5%;">Targets as Envisaged</th>
					    	<th style="width: 32.5%;">Targets as Achieved</th>
					    	<th style="width: 25%;">Remarks</th>
						</tr>
					</thead>
					<tbody>
						<%if(achievements!=null && achievements.size()>0) {
							int achievementsslno = 0;
							for(ProjectClosureACPAchievements achieve :achievements) {%>
							<tr>
								<td style="width: 5%;text-align: center;"><%=++achievementsslno %></td>
								<td style="width: 32.5%;"><%=achieve.getEnvisaged() %> </td>
								<td style="width: 32.5%;"><%=achieve.getAchieved() %> </td>
								<td style="width: 25%;"><%=achieve.getRemarks() %> </td>
							</tr>
						<%} }%>	
					</tbody>
				</table>
    		</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td colspan="2" style="width: 35%;font-weight: 600;">Recommendation of highest Monitoring Committee Meeting for Administrative Closure of the Project</td>
		</tr>
		<tr>
    		<td colspan="1"></td>
    		<td colspan="2">
    			<span>
    				<%if(acp.getMonitoringCommittee()!=null) {%><%=acp.getMonitoringCommittee() %><%} %>
    				<%if(acp!=null && acp.getMonitoringCommitteeAttach()!=null){ %>
                     	<a href="ProjectClosureACPFileDownload.htm?closureId=<%=closureId%>&filename=monitoringcommitteefile" target="_blank">Minutes of Meeting</a>					
                  	<%} %>
    			</span>
    		</td>
		</tr>
		<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td colspan="2" style="width: 35%;font-weight: 600;">Certificate from Lab MMG/Store Section stating no outstanding commitment, no live supply order or contracts & warranty is enclosed. List of payments, to be made due to contractual obligation be enclosed. </td>
		</tr>
    	<tr>
    		<td colspan="1"></td>
    		<td colspan="2">
    			<%if(acp!=null && acp.getCertificateFromLab()!=null){ %>
                 	<a href="ProjectClosureACPFileDownload.htm?closureId=<%=closureId%>&filename=certificatefromlabfile" target="_blank">Certificate from lab MMG/Store Section </a>				 				
                <%} %>
    		</td>
    	</tr>
    	<tr>
    		<td style="width: 5%;"><%=++slno %>.</td>
    		<td style="width: 35%;font-weight: 600;">Certified that objectives set for the project have been met as per Technical Report No.</td>
    		<td>: <%if(acp.getTechReportNo()!=null) {%><%=acp.getTechReportNo() %><%} %> </td>
    	</tr>
	</table>
	
	<!-- Signature and timestamp of PD -->
			               		   					
	<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 18px;margin-top: 20px;">
    	<div style="font-size: 15px;">Project Director</div>
         <%for(Object[] apprInfo : acpApprovalEmpData){ %>
 			<%if(apprInfo[8].toString().equalsIgnoreCase("AFW")){ %>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
    	<%break;}} %>  
	</div>
   
	<br>
	<hr style="height: 1px;background-color: black;">
	<!-- <br> -->
							            			
	<div class="" align="center">
		<h5 style="font-weight: bold;">Part - II</h5>
		<h5 style="font-weight: bold;margin-top: -1.5rem;">Statement of Accounts (Expenditure)</h5>
	</div>
			               							
	<table id="tabledata" style="margin-top: -1.5rem;">
	   	<tr>
	   		<td style="width: 4%;"><%=++slno %>.</td>
	   		<td colspan="2" style="">
	   			
	   			It is certified that the project
	   			<%if(projectMaster!=null) {%>
	   				<%if(projectMaster.getProjectName()!=null) {%><%=projectMaster.getProjectName() %><%} %>
	   				(<%if(projectMaster.getProjectShortName()!=null) {%><%=projectMaster.getProjectShortName() %> <%} %>)
	   			
	   			 No. <%if(projectMaster.getSanctionNo()!=null) {%><%=projectMaster.getSanctionNo() %> <%} %>
	   			 has incurred the expenditure of 
	   			 <%-- <%if(acp.getTotalExpnd()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpnd())) %><%} %> --%>
	   			  <%if(expndDetails!=null && expndDetails[0]!=null) {%><%=df.format(Double.parseDouble(expndDetails[0].toString())/10000000 ) %> <%} %> Cr
	   			 including FE
	   			 <%-- <%if(acp.getTotalExpndFE()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpndFE())) %><%} %> --%>
				  <%if(expndDetails!=null && expndDetails[1]!=null) {%><%=df.format(Double.parseDouble(expndDetails[1].toString())/10000000 ) %> <%} %> Cr
				 against the sanctioned cost of
				 <%if(projectMaster.getTotalSanctionCost()!=null) {%><%=df.format(projectMaster.getTotalSanctionCost()/10000000) %><%} %> Cr
				 including FE
				 <%if(projectMaster.getSanctionCostFE()!=null) {%><%=df.format(projectMaster.getSanctionCostFE()/10000000) %><%} %> Cr
				 as per the enclosed Audited Statement of Expenditure.
				<%} %>
				
				<br><br>
				<span style="margin-left: 50px;">All the stores/equipment undertaken in the project has been accounted for.</span>
	   			
	   		</td>
	   	</tr>
	</table>
	
	<br>
			               		   					
	<!-- Signature and timestamp of Lab Accounts Officer -->
			               		   					
	<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 18px;margin-top: 30px;">
		<div style="font-size: 15px;">(Lab Accounts Officer or equivalent)</div>
		<%for(Object[] apprInfo : acpApprovalEmpData){ %>
			<%if(apprInfo[8].toString().equalsIgnoreCase("AAL")){ %>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
		<%break;}} %>  
	</div>	
	
	<br>
	<hr style="height: 1px;background-color: black;">
	
	<div class="" align="center">
		<h5 style="font-weight: bold;">Part - III</h5>
		<h5 style="font-weight: bold;margin-top: -1.5rem;">The Statement of Accounts (Expenditure) of the project has been audited and reconciled.</h5>
	</div>
			               							
	<br><br><br>
	<div class="" align="center">
		<span>Audit Authorities</span> <br>
		<span>(Local Audit Officer / CDA R&D)</span> <br>
		<span>(Signature with name and office seal)</span>
	</div>	
	
	<hr style="height: 1px;background-color: black;">
							            			
	<!-- Signature and timestamp of Approving officers -->
	<%for(Object[] apprInfo : acpApprovalEmpData) {%>
		<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 18px;margin-top: 50px;margin-left: 40px;">
			<%if(apprInfo[8].toString().equalsIgnoreCase("AAD")){ %>
				<div style="font-size: 15px;"> Signature of Director</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAO")) {%> 
				<div style="font-size: 15px;"> Signature of O/o DG (ECS)</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAN")) {%> 
				<div style="font-size: 15px;"> Signature of DG (Nodal)</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>	
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAC")) {%> 
				<div style="font-size: 15px;"> Signature of CFA</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>
			<%} %>
		</div>	
	<%} %>	
	
	<h1 class="break"></h1>
	<table id="tabledata">
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td style="width: 35%;"style="font-weight: 600;">
				Expenditure Status in Cr 
			</td>
			<td></td>
		</tr>
	</table>
	<br><br><br>
	<div style="transform: rotate(90deg); transform-origin: left top;">
	
	<table id="tabledata">
		
		<tr>
			<td colspan="1"></td>
			<td colspan="2">
				
				<table id="projectdatatablep" style="width: 100%;" >
					<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
						<tr>
							<th colspan="2" style="text-align: center; width: 200px !important;">Head </th>
							<th colspan="3" style="text-align: center; width: 120px !important;">Sanction </th>
							<th colspan="3" style="text-align: center; width: 120px !important;">Expenditure </th>
							<th colspan="3" style="text-align: center; width: 120px !important;">O/s Commitments </th>
							<th colspan="3" style="text-align: center; width: 120px !important;">Balance </th>
						</tr>
						<tr>
							<th style="width: 30px !important; text-align: center;">SN</th>
							<th style="width: 180px !important;" width="10">Head</th>
							<th>IC</th>
							<th>FE</th>
							<th>Total</th>
							<th>IC</th>
							<th>FE</th>
							<th>Total</th>
							<th>IC</th>
							<th>FE</th>
							<th>Total</th>
							<th>IC</th>
							<th>FE</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>
						<%
						double totSanctionCost = 0, totReSanctionCostCap = 0, totFESanctionCostCap = 0, totReFESantionCostCap = 0, totReSanctionCostRev = 0, totFESanctionCostRev = 0, totReFESantionCostRev = 0;
						double totExpenditure = 0, totREExpenditureCap = 0, totFEExpenditureCap = 0, totReFEExpenditureCap = 0, totREExpenditureRev = 0, totFEExpenditureRev = 0, totReFEExpenditureRev = 0 ;
						double totCommitment = 0, totRECommitmentCap = 0, totFECommitmentCap = 0, totReFECommitmentCap = 0, totRECommitmentRev = 0, totFECommitmentRev= 0, totReFECommitmentRev = 0;
						double totBalance = 0, btotalReCap = 0, btotalFeCap = 0, totReFeBalanceCap = 0, btotalReRev = 0, btotalFeRev = 0, totReFeBalanceRev = 0;
						
						int count = 1;
						if (projectFinancialDetails != null && projectFinancialDetails.size() > 0 && projectFinancialDetails.get(0) != null) {
							List <ProjectFinancialDetails> revenue = projectFinancialDetails.get(0).stream().filter(e -> e.getBudgetHeadId()==1).collect(Collectors.toList());
							List <ProjectFinancialDetails> capital = projectFinancialDetails.get(0).stream().filter(e -> e.getBudgetHeadId()==2).collect(Collectors.toList());
						%>
						
						<!-- Revenue -->
						<%if(revenue!=null && capital.size()>0) {
							int i=0;
							for (ProjectFinancialDetails projectFinancialDetail : revenue) {
						%>
						<tr>
							<td align="center" style="max-width: 50px !important; text-align: center;"><%=count++%></td>
							<%-- <%if(i++==0) {%> 
								<td rowspan="<%=revenue.size()+1%>" style="transform : rotate(270deg); width : 4%; text-align: center;" >
							 		REVENUE
							 	</td>
							<%} %> --%>
							<td style=""><b><%=projectFinancialDetail.getBudgetHeadDescription()%></b></td>
							<!-- Sanction Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReSanction())%></td>
							<% totReSanctionCostRev += (projectFinancialDetail.getReSanction()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
							<% totFESanctionCostRev += (projectFinancialDetail.getFeSanction()); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction()) %> </td>
							<% totReFESantionCostRev +=projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction();%>
							
							<!-- Expenditure Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReExpenditure())%></td>
							<% totREExpenditureRev += (projectFinancialDetail.getReExpenditure()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
							<% totFEExpenditureRev += (projectFinancialDetail.getFeExpenditure()); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure())%></td>
							<% totReFEExpenditureRev += (projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure()); %>
							
							<!-- O/s Commitments Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
							<% totRECommitmentRev += (projectFinancialDetail.getReOutCommitment()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeOutCommitment() )%></td>
							<% totFECommitmentRev += (projectFinancialDetail.getFeOutCommitment() ); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment())%></td>
							<% totReFECommitmentRev += (projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment()); %>
							
							<!-- Balance Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl())%></td>
							<% btotalReRev += (projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl())%></td>
							<% btotalFeRev += (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) )%></td>
							<% totReFeBalanceRev += ((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) ); %>
							
						</tr>
						<%}} %>
					
					
						<tr>
							<td colspan="2" style="text-align: right;"><b>Total (Revenue)</b></td>
							<!-- Sanction Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totReSanctionCostRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFESanctionCostRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFESantionCostRev)%></td>
							<!-- Expenditure Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totREExpenditureRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFEExpenditureRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFEExpenditureRev)%></td>
							<!-- O/s Commitments Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totRECommitmentRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFECommitmentRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFECommitmentRev)%></td>
							<!-- Balance Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(btotalReRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(btotalFeRev)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFeBalanceRev)%></td>
							
						</tr>

					
						<!-- Capital -->
						<%if(capital!=null && capital.size()>0) {
							int j=0;
							for (ProjectFinancialDetails projectFinancialDetail : capital) {
						%>
						
						<tr>
							<td align="center" style="max-width: 50px !important; text-align: center;"><%=count++%></td>
							<%-- <%if(j++==0) {%> 
								<td rowspan="<%=capital.size()+1%>" style="transform : rotate(270deg); width : 4%; text-align: center;" >
							 		CAPITAL
							 	</td>
							<%} %> --%>
							<td><b><%=projectFinancialDetail.getBudgetHeadDescription()%></b></td>
							<!-- Sanction Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReSanction())%></td>
							<% totReSanctionCostCap += (projectFinancialDetail.getReSanction()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
							<% totFESanctionCostCap += (projectFinancialDetail.getFeSanction()); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction()) %> </td>
							<% totReFESantionCostCap +=projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction();%>
							
							<!-- Expenditure Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReExpenditure())%></td>
							<% totREExpenditureCap += (projectFinancialDetail.getReExpenditure()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
							<% totFEExpenditureCap += (projectFinancialDetail.getFeExpenditure()); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure())%></td>
							<% totReFEExpenditureCap += (projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure()); %>
							
							<!-- O/s Commitments Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
							<% totRECommitmentCap += (projectFinancialDetail.getReOutCommitment()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeOutCommitment() )%></td>
							<% totFECommitmentCap += (projectFinancialDetail.getFeOutCommitment() ); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment())%></td>
							<% totReFECommitmentCap += (projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment()); %>
							
							<!-- Balance Cost -->
							<!-- IC -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl())%></td>
							<% btotalReCap += (projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()); %>
							<!-- FE -->
							<td align="right" style="text-align: right !important;"><%=df.format(projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl())%></td>
							<% btotalFeCap += (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()); %>
							<!-- Total -->
							<td align="right" style="text-align: right !important;"><%=df.format((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) )%></td>
							<% totReFeBalanceCap += ((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) ); %>
							
						</tr>
						<%}} %>
						
						<%}%>
					
						<tr>
							<td colspan="2" style="text-align: right;"><b>Total (Capital)</b></td>
							<!-- Sanction Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totReSanctionCostCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFESanctionCostCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFESantionCostCap)%></td>
							<!-- Expenditure Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totREExpenditureCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFEExpenditureCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFEExpenditureCap)%></td>
							<!-- O/s Commitments Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totRECommitmentCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFECommitmentCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFECommitmentCap)%></td>
							<!-- Balance Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(btotalReCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(btotalFeCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFeBalanceCap)%></td>
							
						</tr>
						<tr>
							<td colspan="2" style="text-align: right;"><b>GrandTotal (Rev + Cap) </b></td>
							<!-- Sanction Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totReSanctionCostRev + totReSanctionCostCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFESanctionCostRev + totFESanctionCostCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFESantionCostRev + totReFESantionCostCap)%></td>
							<!-- Expenditure Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totREExpenditureRev + totREExpenditureCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFEExpenditureRev + totFEExpenditureCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFEExpenditureRev + totReFEExpenditureCap)%></td>
							<!-- O/s Commitments Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(totRECommitmentRev + totRECommitmentCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totFECommitmentRev + totFECommitmentCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFECommitmentRev + totReFECommitmentCap)%></td>
							<!-- Balance Cost -->
							<td align="right" style="text-align: right !important;"><%=df.format(btotalReRev + btotalReCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(btotalFeRev + btotalFeCap)%></td>
							<td align="right" style="text-align: right !important;"><%=df.format(totReFeBalanceRev + totReFeBalanceCap)%></td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr> 
	</table>
	</div>		               														
</body>
</html>