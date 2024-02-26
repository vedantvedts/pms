<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureSoC"%>
<%@page import="com.vts.pfms.project.model.ProjectMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SoC</title>

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
          margin-top: 49px;
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
             content: "DRDO.DPFM.FF.13";
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
}
#tabledata td{
 text-align : left;
 vertical-align: top;
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
</style>

</head>
<body>
<%
ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
ProjectClosureSoC soc = (ProjectClosureSoC)request.getAttribute("ProjectClosureSoCData");

long projectId = soc!=null? soc.getProjectId():0;
Object[] potherdetails = (Object[])request.getAttribute("ProjectOriginalRevDetails");

List<Object[]> socApprovalEmpData = (List<Object[]>)request.getAttribute("SoCApprovalEmpData");	

String labcode = (String)session.getAttribute("labcode");

FormatConverter fc = new FormatConverter();
%>

	<div align="center">
		<h5 style="font-weight: bold;margin-top: 1rem;">STATEMENT OF CASE FOR PROJECT COMPLETED WITH 
       		<%if(soc.getClosureCategory()!=null) {
				String category = soc.getClosureCategory(); %>
				<%if(category.equalsIgnoreCase("Completed Successfully")) {%>
					COMPLETE SUCCESS
				<%} else if(category.equalsIgnoreCase("Partial Success")){%>
					PARTIAL SUCCESS
				<%} else if(category.equalsIgnoreCase("Stage Closure")){%>
					STAGE CLOSURE
				<%} else if(category.equalsIgnoreCase("Cancellation")){%>
					CANCELLATION
				<%} %>
			<%} %>	
		</h5>
    </div>
    
    <%int slno=0; %>
    <%if(soc!=null) {%>
	    <table id="tabledata">
			<tr>
				<td style="width: 5%;"><%=++slno %>.</td>
				<td style="width: 35%;">Name of Lab/Est</td>
				<td>: <%=labcode %> </td>
			</tr>
			<tr>
				<td style="width: 5%;"><%=++slno %>.</td>
				<td style="width: 35%;">Title of the Project/Programme</td>
				<td>: <%=projectMaster.getProjectName() %> </td>
			</tr>
			<tr>
				<td style="width: 5%;"><%=++slno %>.</td>
				<td style="width: 35%;">Project/Programme No.</td>
				<td>: <%=projectMaster.getSanctionNo() %> </td>
			</tr>
			<tr>
				<td style="width: 5%;"><%=++slno %>.</td>
				<td style="width: 35%;">Category of Project</td>
				<td>: <%if(potherdetails!=null && potherdetails[0]!=null) {%><%=potherdetails[0] %><%} %> </td>
			</tr>
			<tr>
				<td style="width: 4%;"><%=++slno %>.</td>
				<td style="width: 35%;">Sponsoring Agency and QR No.</td>
				<td>: <%=projectMaster.getEndUser() %> and <%if(soc.getQRNo()!=null && !soc.getQRNo().isEmpty()) {%> <%=soc.getQRNo() %><%} else{%>NA<%} %> </td>
			</tr>
			<tr>
				<td style="width: 4%;"><%=++slno %>.</td>
				<td style="width: 35%;">Date of Sanction</td>
				<td>: <%if(projectMaster.getSanctionDate()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getSanctionDate()+"") %><%} %> </td>
			</tr>
			<tr>
				<td style="width: 4%;"><%=++slno %>.</td>
				<td style="width: 35%;">PDC original given and <br> Subsequent amendment, if any </td>
				<td>: <%if(projectMaster.getPDC()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getPDC()+"") %><%} %>
													    		
					<br>: <%if(potherdetails!=null && potherdetails[8]!=null) {%>
						  	<%=fc.SqlToRegularDate(potherdetails[8].toString()) %>
						  <%} else{%>--<%} %>
				</td>
			</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Sanctioned Cost ( <span style="font-size: 12px;">&#x20B9;</span> Cr) </td>
	    		<td style="">: Total <span style="text-decoration: underline;"><%=String.format("%.2f", projectMaster.getTotalSanctionCost()/10000000 ) %></span> Cr (FE <span style="text-decoration: underline;"><%=String.format("%.2f", projectMaster.getSanctionCostRE()/10000000 ) %></span> Cr)</td>
	    	</tr> 
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Statement of Accounts ( as on <%if(soc.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(soc.getExpndAsOn()) %><%} %> )</td>
	    		<td>: Expenditure incurred (<span style="font-size: 12px;">&#x20B9;</span> Cr) : Total <span style="text-decoration: underline;"><%=String.format("%.2f", Double.parseDouble(soc.getTotalExpnd())/10000000 ) %></span> Cr (FE <span style="text-decoration: underline;"><%=String.format("%.2f", Double.parseDouble(soc.getTotalExpndFE())/10000000 ) %></span> Cr)</td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<!-- <td style="width: 39.2%;">Present Status</td>
	    		<td style="width: 55.3%;">:</td> -->
	    		<td style="width: 35%;">Present Status</td>
	    		<td style="">: <%=soc.getPresentStatus() %> </td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Detailed reasons/considerations for Project <%=soc.getClosureCategory() %> </td>
	    		<td style="">: <%if(soc.getReason()!=null) {%><%=soc.getReason() %> <%} else{%>-<%} %> </td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Recommendation of Review Committee for Project success (as applicable)</td>
	    		<td style="">: <%if(soc.getRecommendation()!=null && !soc.getRecommendation().isEmpty()) {%><%=soc.getRecommendation() %> <%} else{%>NA<%} %> </td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">
	    			Minutes of Monitoring Committee Meetings held so far and recommendations 
	 				of the highest monitoring committee for closure of the project/programme
	 			</td>
	    		<td style="">: <%=soc.getMonitoringCommittee() %>
	    			<a href="ProjectClosureSoCFileDownload.htm?projectId=<%=projectId%>&filename=monitoringcommitteefile" target="_blank">Download</a>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Direction of DMC</td>
	    		<td style="">: <%=soc.getDMCDirection() %> </td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Lessons Learnt</td>
	    		<td style="">:
	    			<a href="ProjectClosureSoCFileDownload.htm?projectId=<%=projectId%>&filename=lessonslearntfile" target="_blank">Download</a>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td style="width: 4%;"><%=++slno %>.</td>
	    		<td style="width: 35%;">Other relevant details</td>
	    		<td style="">: <%if(soc.getOtherRelevant()!=null && !soc.getOtherRelevant().isEmpty()) {%><%=soc.getOtherRelevant() %> <%} else{%>--<%} %></td>
	    	</tr>
		</table>
   	<%} %> 												
   	<br>
			               		   					
	<!-- Signatures and timestamps -->
			               		   					
	<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 18px;margin-top: 20px;">
		<div style="font-size: 15px;">Project Director</div>
		<%for(Object[] apprInfo : socApprovalEmpData){ %>
			<%if(apprInfo[8].toString().equalsIgnoreCase("SFW")){ %>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
		<%break;}} %>  
	</div>
	
	<%for(Object[] apprInfo : socApprovalEmpData) {%>
		<div style="width: 96%;text-align: left;margin-left: 40px;line-height: 18px;margin-top: 40px;">
			<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
				<div style="font-size: 15px;"> Signature of Director</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAC")) {%> 
				<div style="font-size: 15px;"> Signature of Competent Authority</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>
		
			<%} %>
		</div>	
	<%} %>
							            			 
</body>
</html>