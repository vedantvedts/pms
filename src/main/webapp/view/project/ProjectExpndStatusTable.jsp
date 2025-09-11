<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACP"%>
<%@page import="com.vts.pfms.project.model.ProjectMasterRev"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosure"%>
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
          size: 1050px 850px;
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


String labcode = (String)session.getAttribute("labcode");

long closureId = closure!=null? closure.getClosureId():0;

FormatConverter fc = new FormatConverter();

DecimalFormat df = new DecimalFormat("#.####");
df.setMinimumFractionDigits(4); 

List<String> projectidlist = (List<String>) request.getAttribute("projectidlist");
List<List<ProjectFinancialDetails>> projectFinancialDetails = (List<List<ProjectFinancialDetails>>) request.getAttribute("financialDetails");
%>
	<table id="tabledata">
		<tr>
			<td style="width: 5%;">20.</td>
			<td style="width: 35%;"style="font-weight: 600;">
				Expenditure Status in Cr 
			</td>
			<td></td>
		</tr>
	</table>
	<!-- <br><br><br> -->
	<!-- <div style="transform: rotate(90deg); transform-origin: left top;"> -->
	
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
							<td style=""><b><%=projectFinancialDetail.getBudgetHeadDescription()!=null?StringEscapeUtils.escapeHtml4(projectFinancialDetail.getBudgetHeadDescription()): " - "%></b></td>
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
							<td><b><%=projectFinancialDetail.getBudgetHeadDescription()!=null?StringEscapeUtils.escapeHtml4(projectFinancialDetail.getBudgetHeadDescription()): " - "%></b></td>
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
	<!-- </div> -->
</body>
</html>