<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.vts.pfms.projectclosure.model.ProjectClosureCheckList"%>
    <%@page import="com.vts.pfms.FormatConverter"%>
    <%@page import="com.vts.pfms.project.model.ProjectMaster"%>
    <%@page import="java.time.LocalDate"%>
    <%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Check List Download</title>
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
             content: "";
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
 border : 1px solid black; 
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
  border : 1px solid black; 
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

     String labcode = (String)session.getAttribute("labcode");
     ProjectClosureCheckList chlist = (ProjectClosureCheckList)request.getAttribute("ProjectClosureCheckListData");
     FormatConverter fc = new FormatConverter();
     String closureId=(String)request.getAttribute("closureId");
     ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
     String ProjectId=(String)request.getAttribute("projectId");
     
     LocalDate currentDate = LocalDate.now();
    
     
     LocalDate firstDayOfCurrentMonth = currentDate.withDayOfMonth(1);
     
     // Get the first day of the previous month
     LocalDate firstDayOfPreviousMonth = firstDayOfCurrentMonth.minusMonths(1);
     
     
     String ProjectCode=(String)request.getAttribute("ProjectCode");
     
     String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";

   

%>

<div align="center">
		<h5 style="font-weight: bold;margin-top: -0.5rem;">
			CHECK-LIST FOR ADMINISTRATIVE CLOSURE REPORT FOR <%=projectMaster.getProjectName()%> & <%=projectMaster.getProjectDescription()%>
			
		</h5>
		
	</div>
	<%int slno=0;
	  int a=0;
	%>
	
	 <table id="tabledata" style="margin-top: -2rem;">
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td style="width: 35%;text-align: left !important;font-weight: 600;">Name of the Lab</td>
			<td><%=labcode %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Project Appraisal Letter (PAR)</td>
			
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. Sent by the Lab to HQrs</td>
			<td><%if(chlist!=null && chlist.getQARHQrsSentDate()!=null && !chlist.getQARHQrsSentDate().toString().equalsIgnoreCase("NA")) {%><%=fc.SqlToRegularDate(chlist.getQARHQrsSentDate()) %><%} else{%> NA <%}%></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii.When sent to the CFA </td>
			<td><%if(chlist!=null && chlist.getQARSentDate()!=null && !chlist.getQARSentDate().toString().equalsIgnoreCase("NA")) {%><%=fc.SqlToRegularDate(chlist.getQARSentDate()) %><%} else{%> NA <%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii.Objective  of the  Project mentioned in the QAR</td>
			<td><%if(chlist!=null && chlist.getQARObjective()!=null) {%><%=chlist.getQARObjective() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv.Milestones</td>
			<td><%if(chlist!=null && chlist.getQARMilestone()!=null){ %>
			
             <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=QARMilestonefile&closureId=<%=closureId%>" target="_blank" title="QARMilestone Download">
			       Annexure-<%=++a %>
		     </a>
		<%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">v.PDC</td>
			<td><%if(chlist!=null && chlist.getQARPDCDate()!=null) {%><%=fc.SqlToRegularDate(chlist.getQARPDCDate()) %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">vi.Proposed Cost</td>
			<td><%if(chlist!=null && chlist.getQARProposedCost()>=0) {%><%=chlist.getQARProposedCost() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">vii.Cost Break-up (Activity wise, Period wise)</td>
			<td>  <%if(chlist!=null && chlist.getQARCostBreakup()!=null){ %>
			
			 <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=QARCostBreakupfile&closureId=<%=closureId %>" target="_blank" title="QARCostBreakup Download">
			       Annexure-<%=++a %>
		     </a>
			
			
			<%} %>
			</td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">viii.List of non-consumable items required (at least costing more than Rs. 10 lakhs)</td>
			<td><%if(chlist!=null && chlist.getQARNCItems()!=null){ %>
			
			 <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=QARNCItemsfile&closureId=<%=closureId %>" target="_blank" title="QARNCItems Download">
			       Annexure-<%=++a %>
		     </a>
			
			
			<%} %>
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Project Sanction Letter </td>
			
		</tr>
		
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td  style="width: 35%;text-align: left !important;font-weight: 400;">i.No & Date </td>
			<td><%if(projectMaster!=null && projectMaster.getSanctionNo()!=null){ %><%=projectMaster.getSanctionNo() %><%} %>
			
			&nbsp;&nbsp;
			
			<%if(projectMaster!=null && projectMaster.getSanctionDate()!=null){ %><%=fc.SqlToRegularDate(projectMaster.getSanctionDate().toString()) %><%} %>
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii.Sanctioned Cost </td>
			<td>
			
			<%if(projectMaster!=null && projectMaster.getTotalSanctionCost()!=null){ %>
			
			<%  DecimalFormat df1 = new DecimalFormat( "################.00"); 
				String v = df1.format((Double.valueOf(projectMaster.getTotalSanctionCost().doubleValue()/100000 ))); 
				NFormatConvertion nfc1=new NFormatConvertion();
				
			%>
			
			<%=v%><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td  style="width: 35%;text-align: left !important;font-weight: 400;">iii.Cost Break-up (activity wise & period wise) </td>
			<td>
			
			
			<a href="http://192.168.1.14:8085/ibas/FinancialPerformancePdf.htm?ProjectIdSel=<%=ProjectId%>%23<%=ProjectCode%>&Date=<%=fc.SqlToRegularDate(currentDate.toString())%>&Amount=Rupees&rupeevalue=1" >
			Annexure-<%=++a %>
			
			</a>  
			
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td  style="width: 35%;text-align: left !important;font-weight: 400;">iv.PDC </td>
			<td><%if(projectMaster!=null && projectMaster.getPDC()!=null){ %><%=fc.SqlToRegularDate(projectMaster.getPDC().toString())%><%} %></td>
			
		</tr>
		
		
		<!-- <tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">v.	Any other point worth mentioning </td>
			<td></td>
		</tr> -->
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Revision in sanctioned cost if any </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.	When requested </td>
			<td><%if(chlist!=null && chlist.getSCRequested()!=null) {%><%=fc.SqlToRegularDate(chlist.getSCRequested()) %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. When granted </td>
			<td><%if(chlist!=null && chlist.getSCGranted()!=null) {%><%=fc.SqlToRegularDate(chlist.getSCGranted()) %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. How much/ revised cost </td>
			<td><%if(chlist!=null && chlist.getSCRevisionCost()>=0){%><%=chlist.getSCRevisionCost() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv. Any reason specified </td>
			<td><%if(chlist!=null && chlist.getSCReason()!=null){ %><%=chlist.getSCReason() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Revision in PDC if any </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.	When requested </td>
			<td><%if(chlist!=null && chlist.getPDCRequested()!=null) {%><%=fc.SqlToRegularDate(chlist.getPDCRequested()) %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. When granted </td>
			<td><%if(chlist!=null && chlist.getPDCGranted()!=null) {%><%=fc.SqlToRegularDate(chlist.getPDCGranted()) %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. Quantum/ revised PDC </td>
			<td><%if(chlist!=null && chlist.getPDCRevised()!=null) {%><%=fc.SqlToRegularDate(chlist.getPDCRevised()) %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv. Any reason specified </td>
			<td><%if(chlist!=null && chlist.getPDCReason()!=null){ %><%=chlist.getPDCReason() %><%} %></td>
		</tr>
		
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Project Register </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.	Maintained in proper format </td>
			<td><% if(chlist!=null &&  chlist.getPRMaintained() !=null ){%><%=chlist.getPRMaintained() %> <%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii.Sanctioned projects entered (including sub-projects) </td>
			<td><% if(chlist!=null &&  chlist.getPRSanctioned() !=null ){%><%=chlist.getPRSanctioned() %> <%} %> </td>
		</tr>
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Project expenditure Card  </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.	Maintained separately for consumable & non-consumables </td>
			<td>
			
			
			<!--   <a href="http://192.168.1.14:8085/ibas/ProjectExpenditureReportPrint.htm?_csrf=79269a60-d989-47b5-8e7f-5e4c8ebc27f3&ProjectIdSel=1%23PRJ-01&BudgetHeadIdSel=0%23All&ItemTypeSel=A%23ALL&FromDate=01-03-2024&toDate=22-04-2024&action=pdf">
			       Download
		     </a>   -->
		      
		       <a href="http://192.168.1.14:8085/ibas/ProjectExpenditureReportPrint.htm?ProjectIdSel=<%=ProjectId%>%23<%=ProjectCode%>&BudgetHeadIdSel=0%23All&ItemTypeSel=A%23ALL&FromDate=<%=fc.SqlToRegularDate(firstDayOfPreviousMonth.toString())%>&toDate=<%=fc.SqlToRegularDate(currentDate.toString())%>&action=pdf" target="_blank" title="PEC Download">
			        Annexure-<%=++a %>
		       </a>   
		      
			</td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Expenditure verified by Project Director/ In-charge </td>
			<td><% if(chlist!=null &&  chlist.getPECVerified() !=null ){%><%=chlist.getPECVerified() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Commitment Register </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.If required, maintained properly </td>
			<td>
			
			<a href="http://192.168.1.14:8085/ibas/CommitmentListPdfExl.htm?ControllerProjectId=<%=ProjectId%>&ControllerProjectCode=<%=ProjectCode%>&ControllerFromDate=<%=fc.SqlToRegularDate(firstDayOfPreviousMonth.toString())%>&ControllerToDate=<%=fc.SqlToRegularDate(currentDate.toString())%>&ControllerbudgetHeadId=1&ControllerBudgetHeadDescription=Revenue&ControllerbudgetItemId=0&ControllerHeadOfAccounts=All&ControllerProjShortName=+%28TMS%29&Action=Pdf">
			
			  Annexure-<%=++a %>
			
			</a>    
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Subsidiary register </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.If required, maintained properly </td>
			<td><% if(chlist!=null &&  chlist.getSRMaintained()!=null){%><%= chlist.getSRMaintained() %><%} %> </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Procurement/ Accounting Procedure (consumable Stores) </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.Procedure followed (purchased directly or through main stores) </td>
			<td><%if(chlist!=null && chlist.getCSProcedure()!=null){%><%=chlist.getCSProcedure()%><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii.If through main stores, drawn from main Stock Register through Demand-cum-issue voucher </td>
			<td><% if(chlist!=null && chlist.getCSDrawn()!=null ){%><%=chlist.getCSDrawn() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. Amount is debited to Project Expenditure card </td>
			<td><% if(chlist!=null && chlist.getCSamountdebited()!=null){%><%=chlist.getCSamountdebited()  %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;"> iv.If not through main stores, reason thereof </td>
			<td><% if(chlist!=null && chlist.getCSReason()!=null) {%><%=chlist.getCSReason() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Procurement/ Accounting Procedure (Non-consumable Stores) </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;"> i.Procedure followed (Purchased directly or through main stores) </td>
			<td><%if(chlist!=null && chlist.getNCSProcedure()!=null){%><%=chlist.getNCSProcedure()%><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;"> ii. If through main stores, drawn from main Stock Register through nominal Demand-cum-issue voucher</td>
			<td><% if(chlist!=null && chlist.getNCSDrawn()!=null ){%><%=chlist.getNCSDrawn() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;"> iii.	Amount is debited to Project Expenditure  Card </td>
			<td><% if(chlist!=null && chlist.getNCSamountdebited()!=null){%><%=chlist.getNCSamountdebited()  %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;"> iv. If not through main stores, reason thereof </td>
			<td><% if(chlist!=null && chlist.getNCSReason()!=null) {%><%=chlist.getNCSReason() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;"> v. In main stores ledger, item shown as distributed to Project Inventory of non-consumables being maintained in project group</td>
			<td><% if(chlist!=null && chlist.getNCSDistributed()!=null){%><%=chlist.getNCSDistributed() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">vi. Any non-consumable item incorporated in any prototype stores are received and SIR is prepared before closure of project</td>
			<td><% if(chlist!=null && chlist.getNCSIncorporated()!=null){%><%=chlist.getNCSIncorporated() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td  colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Equipment </td>
			
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. List out major non-consumable/ equipment procured </td>
			<td> <%if(chlist!=null && chlist.getEquipProcured()!=null){ %>
			
			 <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=EquipProcuredfile&closureId=<%=closureId %>" target="_blank" title="EquipProcured Download">
			       Annexure-<%=++a %>
		     </a>  
		     
			<%} %>
			
			</td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Any major equipment not listed in Q.P.R has been purchased? </td>
			<td><% if(chlist!=null && chlist.getEquipPurchased()!=null){%><%=chlist.getEquipPurchased() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. If yes, reason assigned </td>
			<td><% if(chlist!=null && chlist.getEquipReason()!=null ) {%><%=chlist.getEquipReason() %> <%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv. Any major equipment procured within one month before the PDC (give details and reason thereof) </td>
			<td><% if(chlist!=null && chlist.getEquipProcuredBeforePDC()!=null){%> <%=chlist.getEquipProcuredBeforePDC() %><%} %>
			
			  <%if(chlist!=null && chlist.getEquipProcuredBeforePDCAttach()!=null){ %>
			
			 <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=EquipProcuredBeforePDCfile&closureId=<%=closureId %>" target="_blank" title="EquipProcuredBeforePDC Download">
			       Annexure-<%=++a %>
		     </a>
			<%} %>
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">v. Any equipment bought on charge within one month before the PDC or after PDC (Give details and reasons thereof) </td>
			<td><% if(chlist!=null && chlist.getEquipBoughtOnCharge()!=null ){%><%=chlist.getEquipBoughtOnCharge() %><%} %>
			
		 <%if(chlist!=null && chlist.getEquipBoughtOnChargeReason()!=null){ %><%=chlist.getEquipBoughtOnChargeReason() %>
			<%-- <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=EquipBoughtOnChargefile&closureId=<%=closureId %>" target="_blank" title="EquipBoughtOnCharge Download">
			       Annexure-<%=++a %>
		     </a> --%>
		     
			<%} %>
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td  colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Budget </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.Yearly break up of Allotment & Expenditure since the Project  sanctioned </td>
			<td>
			
			<a href="http://192.168.1.14:8085/ibas/ProjectDetailsAllotExp.htm?ProjectIdSel=<%=ProjectId%>%23<%=ProjectCode%>&Amount=L" target="_blank" title="Budget Yearly BreakUp Download">
			       Annexure-<%=++a %>
		     </a> 
			
			</td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. The reviewing officer should  see  the allocation  w.r.t demands  and  also  the  projections  in  the Q.P.R </td>
			<td><% if(chlist!=null && chlist.getBudgetAllocation()!=null){%><%=chlist.getBudgetAllocation() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. What is the mechanism for monitoring/ control of head-wise expenditure? </td>
			<td><% if(chlist!=null && chlist.getBudgetMechanism()!=null) {%><%=chlist.getBudgetMechanism() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv. Mention, if expenditure under any head exceeded the respective allocation </td>
			<td>
			
			 <%if(chlist!=null && chlist.getBudgetExpenditure()!=null){ %><%=chlist.getBudgetExpenditure() %>
			 
			 <%-- <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=BudgetExpenditurefile&closureId=<%=closureId %>" target="_blank" title="BudgetExpenditure Download">
			       Annexure-<%=++a %>
		     </a> --%>
			
			<%} %>
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">Comment: Whether financial progress is in consonance with Tech. progress. </td>
			<td><% if(chlist!=null && chlist.getBudgetFinancialProgress()!=null){%><%=chlist.getBudgetFinancialProgress() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. Monthly/ Quarterly expenditure Reports are rendered to R&D HQrs and copy sent to local CDA </td>
			<td><% if(chlist!=null && chlist.getBudgetexpenditureReports()!=null ){%><%=chlist.getBudgetexpenditureReports() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Any expenditure incurred after Project PDC (Give details and reasons thereof)</td>
			<td><% if(chlist!=null && chlist.getBudgetexpenditureIncurred()!=null ){%><%=chlist.getBudgetexpenditureIncurred() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td  colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Utilization of Equipment </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i.	Log book maintained in r/o high cost equipment </td>
			<td><% if(chlist!=null && chlist.getLogBookMaintained()!=null){%><%=chlist.getLogBookMaintained() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Job cards maintained </td>
			<td><% if(chlist!=null && chlist.getJobCardsMaintained()!=null){%><%=chlist.getJobCardsMaintained() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td  colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Staff Position </td>
			
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. Demanded as per Q.P.R </td>
			<td><% if(chlist!=null && chlist.getSPdemand()!=null){%><%=chlist.getSPdemand() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Actual position-held </td>
			<td>
			 <%if(chlist!=null && chlist.getSPActualposition()!=null){ %><%=chlist.getSPActualposition() %>
			
			<%-- <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=SPActualpositionfile&closureId=<%=closureId %>" target="_blank" title="SPActualposition Download">
			       Annexure-<%=++a %>
		     </a> --%>
			
			
			<%} %>
			
			</td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. General Specific (Category wise) </td>
			<td>
			 <%if(chlist!=null && chlist.getSPGeneralSpecific()!=null){ %><%=chlist.getSPGeneralSpecific()%><%} %>
			
			
			<%-- <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=SPGeneralSpecificfile&closureId=<%=closureId %>" target="_blank" title="SPGeneralSpecific Download">
			       Annexure-<%=++a %>
		     </a> --%>
			
			
			
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td  colspan="2"  style="width: 35%;text-align: left !important;font-weight: 600;">Civil Works </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. Civil works are included in the estimated prepared before project sanction.</td>
			<td><% if(chlist!=null && chlist.getCWIncluded()!=null){%><%=chlist.getCWIncluded() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Admin approval is accorded for the work.</td>
			<td><% if(chlist!=null && chlist.getCWAdminApp()!=null ){%><%=chlist.getCWAdminApp() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. Minor works are completed within the financial year and not costing more than one lakh.</td>
			<td><% if(chlist!=null && chlist.getCWMinorWorks()!=null){%><%=chlist.getCWMinorWorks() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv. Revenue major works are completed within the financial year and not costing more than two lakhs.</td>
			<td><% if(chlist!=null && chlist.getCWRevenueWorks()!=null ){%><%=chlist.getCWRevenueWorks() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">v.	There are no deviations from the  admin   approval</td>
			<td><% if(chlist!=null && chlist.getCWDeviation()!=null){%> <%=chlist.getCWDeviation() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">vi. Expenditure is not incurred just for the sake of exhausting funds at the end of Project.</td>
			<td><% if(chlist!=null && chlist.getCWExpenditure()!=null){%><%=chlist.getCWExpenditure() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %>.</td>
			<td  colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">Vehicles </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. No. of vehicles sanctioned in the project (With types).</td>
			<td> <% if(chlist!=null && chlist.getNoOfVehicleSanctioned()!=null){%><%=chlist.getNoOfVehicleSanctioned() %><%} %></td>
		</tr>
		
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Average  monthly run of each vehicle.</td>
			<td><% if(chlist!=null && chlist.getVehicleAvgRun()!=null){ %> <%=chlist.getVehicleAvgRun() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. Average monthly fuel consumption of each vehicle.</td>
			<td><% if(chlist!=null && chlist.getVehicleAvgFuel()!=null){ %> <%=chlist.getVehicleAvgFuel() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %></td>
			<td  colspan="2" style="width: 35%;text-align: left !important;font-weight: 600;">If the project is closed </td>
			
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">i. When the project finally closed </td>
			<td><% if(chlist!=null && chlist.getProjectClosedDate()!=null){ %> <%=fc.SqlToRegularDate(chlist.getProjectClosedDate()) %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">ii. Project closures Report send to R&D HQrs.(Mention Dated) </td>
			<td><% if(chlist!=null && chlist.getReportDate()!=null){ %> <%=fc.SqlToRegularDate(chlist.getReportDate()) %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iii. If undue delay in sending the Closure Report, reasons thereof </td>
			<td><% if(chlist!=null && chlist.getDelayReason()!=null){ %> <%=chlist.getDelayReason() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">iv. As per Closure Report </td>
			<td></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">a. Whether  the  stated  objectives achieved </td>
			<td><% if(chlist!=null && chlist.getCRObjective()!=null){%><%=chlist.getCRObjective() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">b. Any other spin-off achieved </td>
			<td><% if(chlist!=null && chlist.getCRspinoff()!=null){%><%=chlist.getCRspinoff() %><%} %></td>
		</tr>
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">c. Reason, if PDC not  meet (Delay in  convening of TPC or  delayed placement of indent by the user) </td>
			<td><% if(chlist!=null && chlist.getCRReason()!=null){%><%=chlist.getCRReason() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">d. Reason, if Cost Over-run </td>
			<td><% if(chlist!=null && chlist.getCRcostoverin()!=null) {%><%=chlist.getCRcostoverin() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">v. Non-consumable items returned to main stores on nominal voucher (No credit to be given in Project expenditure  card) </td>
			<td><% if(chlist!=null && chlist.getNonConsumableItemsReturned()!=null){%><%=chlist.getNonConsumableItemsReturned() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">vi. Consumable (non-consumed) returned to main store on Issue voucher (Credit to be given in Project Expenditure Card) </td>
			<td><% if(chlist!=null && chlist.getConsumableItemsReturned()!=null){%><%=chlist.getConsumableItemsReturned() %><%} %></td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"></td>
			<td style="width: 35%;text-align: left !important;font-weight: 400;">vii. How the manpower sanctioned in the Project has been disposed of (Permanent as well as temporary) </td>
			<td>
			  <%if(chlist!=null && chlist.getManPowerSanctioned()!=null){ %><%=chlist.getManPowerSanctioned()%><%}%>
			  
			  <%-- <a href="<%=path%>ProjectClosureChecklistFileDownload.htm?filename=CRAttachfile&closureId=<%=closureId %>" target="_blank" title="CRAttachfile Download">
				          Annexure-<%=++a %>
			     </a> --%>
			 
			</td>
		</tr>
		
		
		<tr>
			<td style="width: 5%;"><%=++slno %></td>
			<td style="width: 35%;text-align: left !important;font-weight: 600;">Overall Review Remarks/Recommendations </td>
			<td><%if(chlist!=null && chlist.getRemarks()!=null){ %> <%=chlist.getRemarks() %><%} %></td>
		</tr>
		
		
		
   </table>

</body>
</html>