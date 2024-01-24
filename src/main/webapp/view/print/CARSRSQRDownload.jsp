<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="com.vts.pfms.cars.model.CARSRSQRDeliverables"%>
<%@page import="com.vts.pfms.cars.model.CARSRSQRMajorRequirements"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CARS RSQR</title>

<%
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData");
%>
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
          border: 1px solid black; 
          
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
             content: "Annexure-I";
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
            content: "<%=carsIni.getCARSNo()%>";
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
 margin-left : 10px;
 border-collapse : collapse;
 border : 1px solid black;
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
}
#tabledata td{
 text-align : left;
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
</style>
</head>
<body>
<%
Object[] rsqr =(Object[])request.getAttribute("RSQRDetails");
List<CARSRSQRMajorRequirements> majorReqr = (List<CARSRSQRMajorRequirements>)request.getAttribute("RSQRMajorReqr");
List<CARSRSQRDeliverables> deliverables = (List<CARSRSQRDeliverables>)request.getAttribute("RSQRDeliverables");
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
%>
	<div align="center">
       <h5 style="font-weight: bold;margin-top: 1.5rem;">Research Service Qualitative Requirement (RSQR) for <%=carsIni.getInitiationTitle() %></h5>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">1. Introduction</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[2]!=null) {%><%=rsqr[2]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">2. Overview of the Research Work</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[3]!=null) {%><%=rsqr[3]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">3. Objectives</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[4]!=null) {%><%=rsqr[4]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">4. Major Requirements</h4>
    	<div>
    		<%if(majorReqr!=null && majorReqr.size()>0) {%>
    			<table id="tabledata">
    				<thead>
    					<tr>
    						<!-- <th>SN</th> -->
    						<th>Req Id</th>
    						<th>Req Description</th>
    						<th>Relevant Specs</th>
    						<th>Validation Method</th>
    						<th>Remarks</th>
    					</tr>
    				</thead>
    				<tbody>
    					<%int i=0; for(CARSRSQRMajorRequirements mr : majorReqr) { %>
    						<tr>
    							<%-- <td><%=++i %> </td> --%>
    							<td style="text-align: center;"><%if(mr.getReqId()!=null) {%><%=mr.getReqId() %><%} else{%>-<%} %></td>
    							<td><%if(mr.getReqDescription()!=null) {%><%=mr.getReqDescription() %><%} else{%>-<%} %></td>
    							<td><%if(mr.getRelevantSpecs()!=null) {%><%=mr.getRelevantSpecs() %><%} else{%>-<%} %></td>
    							<td><%if(mr.getValidationMethod()!=null) {%><%=mr.getValidationMethod() %><%} else{%>-<%} %></td>
    							<td><%if(mr.getRemarks()!=null) {%><%=mr.getRemarks() %><%} else{%>-<%} %></td>
    						</tr>
    					<%} %>
    				</tbody>
    			</table>
    		<%}else {%><div style="text-align: center;">No Details Added!</div><%} %>
    	</div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">5. Deliverables</h4>
    	<div>
    		<%int j=0; if(deliverables!=null && deliverables.size()>0) { %>
    			<table id="tabledata">
    				<thead>
    					<tr>
    						<th>SN</th>
    						<th>Description</th>
    						<th>Type</th>
    					</tr>
    				</thead>
    				<tbody>
    					<%for(CARSRSQRDeliverables del : deliverables) {%>
    						<tr>
    							<td style="text-align: center;width: 5%;"><%=++j %> </td>
    							<td style="width: 87.5%;"><%if(del.getDescription()!=null) {%><%=del.getDescription() %><%} else{%>-<%} %></td>
    							<td style="width: 6%">
    								<%if(del.getDeliverableType()!=null) {%>
    									<%if(del.getDeliverableType().equalsIgnoreCase("S")) {%>Software
    									<%} else if(del.getDeliverableType().equalsIgnoreCase("H")) {%>Hardware
    									<%} else if(del.getDeliverableType().equalsIgnoreCase("R")) {%>Report
    									<%} %>
    								<%} else{%>-<%} %>
    							</td>
    						</tr>
    					<%} %>
    				</tbody>
    			</table>
    		<%}else {%><div style="text-align: center;">No Details Added!</div><%} %>
    	</div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">6. Proposed Milestones & Timelines</h4>
    	<div>
	   		<%if(milestones!=null && milestones.size()>0) {%>
	   			<table id="tabledata">
	   				<thead>
	   					<tr>
	   						<th style="width: 5%;">Milestone No.</th>
	   						<th style="width: 20%;">Task Description</th>
	   						<th style="width: 10%;">Months</th>
	   						<th >Deliverables</th>
	   						<th style="width: 5%;">Payment ( In %)</th>
	   						<th style="width: 20%;">Payment Terms</th>
	   					</tr>
	   				</thead>
	   				<tbody>
	   					<%int i=0; for(CARSSoCMilestones mil : milestones) { %>
	   						<tr>
	   							<td style="text-align: center;width: 5%;"><%if(mil.getMilestoneNo()!=null) {%><%=mil.getMilestoneNo() %><%} else{%>-<%} %></td>
	   							<td style="width: 20%;"><%if(mil.getTaskDesc()!=null) {%><%=mil.getTaskDesc() %><%} else{%>-<%} %></td>
	   							<td style="text-align: center;width: 10%;"><%if(mil.getMonths()!=null) {%><%="T0 + "+mil.getMonths() %><%} else{%>-<%} %></td>
	   							<td style=""><%if(mil.getDeliverables()!=null) {%><%=mil.getDeliverables() %><%} else{%>-<%} %></td>
	   							<td style="text-align: center;width: 5%;"><%if(mil.getPaymentPercentage()!=null) {%><%=mil.getPaymentPercentage() %><%} else{%>-<%} %></td>
	   							<td style="width: 20%;"><%if(mil.getPaymentTerms()!=null) {%><%=mil.getPaymentTerms() %><%} else{%>-<%} %></td>
	   						</tr>
	   					<%} %>
	   				</tbody>
	   			</table>
	   		<%}else {%><div style="text-align: center;">No Details Added!</div><%} %>
   	</div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">7. Scope of RSP</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[6]!=null) {%><%=rsqr[6]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">8. Scope of LRDE</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[7]!=null) {%><%=rsqr[7]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">9. Success Criterion</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[8]!=null) {%><%=rsqr[8]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    <div>
    	<h4 style="margin-left: 10px;">10. Literature Reference if any</h4>
    	<div class="editor-data"><%if(rsqr!=null && rsqr[9]!=null) {%><%=rsqr[9]%><%}else {%><div style="text-align: center;">No Details Added!</div><%} %></div>
    </div>
    
    <%if(rsqr==null && majorReqr==null && deliverables==null) {%>
    	<div align="center" style="margin-top:350px"><h2>No Data Available !</h2></div>	
    <%} %>

</body>
</html>