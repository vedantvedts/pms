<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SoC</title>
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
          size: 790px 950px;
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
             content: "<%=carsIni.getCARSNo()!=null?StringEscapeUtils.escapeHtml4(carsIni.getCARSNo()): " - "%>";
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
 vertical-align: top;
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

#timestamptable{
 margin-left : 10px;
 border-collapse : collapse;
 width : 98.5%;
}

/* #tabledata tr td:nth-child(3n) {
      color: blue; 
    } */
</style>
</head>
<body>
<%
Object[] emp = (Object[])request.getAttribute("EmpData");
List<Object[]> socApprovalEmpData = (List<Object[]>)request.getAttribute("SoCApprovalEmpData");
List<Object[]> socRemarksHistory = (List<Object[]>)request.getAttribute("CARSSoCRemarksHistory");

Object[] rsqrDetails = (Object[])request.getAttribute("RSQRDetails");
CARSSoC carsSoC =(CARSSoC)request.getAttribute("CARSSoCData");

Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
int socforwardslno=0;
%>

<div align="center">
   <h4 style="font-weight: bold;margin-top: 1.5rem;">Statement of Case for availing CARS</h4>
</div>
<table id="tabledata">
	<%-- <tr>
		<td colspan="2" style="text-align: left;border:none;">No. <span><%=carsIni.getCARSNo() %></span> </td>
		<td style="text-align: right;border:none;">Date : 
			<span><%if(carsSoC.getSoCDate()!=null) {%> <%=fc.SqlToRegularDate(carsSoC.getSoCDate()) %><%} else{%><%=rdf.format(new Date()) %> <%} %></span> 
		</td>
	</tr> --%>
	<tr>
		<td style="width: 5%;text-align: center;"><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Title</td>
		<td style="width: 73%;"><%=carsIni.getInitiationTitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()): " - " %></td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;"><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Aim</td>
		<td style="width: 73%;"><%=carsIni.getInitiationAim()!=null?StringEscapeUtils.escapeHtml4(carsIni.getInitiationAim()): " - " %></td>
	</tr>
  	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;" >Scope</td>
		<td style="width: 73%;"><%if(rsqrDetails[6]!=null) {%> <%=StringEscapeUtils.escapeHtml4(rsqrDetails[6].toString()) %><%} else{%>-<%} %></td>
	</tr>
	<tr>
	    <td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
	    <td style="width: 20.5%;">Duration (Months)</td>
	    <td style="width: 73%;"><%=carsSoC.getSoCDuration()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getSoCDuration()): " - " %> </td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Project Name & No., for which the CARS will be used</td>
		<td style="width: 73%;">
			<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
				Build-up
			<%} else {%>
				<%if(PDs!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[4].toString())+" ("+PDs[0]!=null?StringEscapeUtils.escapeHtml4(PDs[0].toString()): " - "+")" %> <%} %>
			<%} %>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Alignment with </td>
		<td style="width: 73%;">
			<%if(carsSoC.getAlignment()!=null) {%>
				<%=StringEscapeUtils.escapeHtml4(carsSoC.getAlignment()) %>
			<%} else {%>
				-
			<%} %>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">RSQR</td>
		<td style="width: 73%;text-align: center;">
			<a href="CARSFinalRSQRDownload.htm?carsInitiationId=<%=carsIni.getCARSInitiationId()%>" target="_blank">Annexure - I</a>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Milestones and Deliverables</td>
		<td style="width: 73%;text-align: center;">
			<a href="CARSSoCMilestonesDownload.htm?carsInitiationId=<%=carsIni.getCARSInitiationId()%>" target="_blank">Annexure - II</a>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Justification for raising CARS</td>
		<td style="width: 73%;"><%=carsIni.getJustification()!=null?StringEscapeUtils.escapeHtml4(carsIni.getJustification()): " - " %> </td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Justification for time reasonability</td>
		<td style="width: 73%;"><%=carsSoC.getTimeReasonability()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getTimeReasonability()): " - " %> </td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Justification for cost reasonability</td>
		<td style="width: 73%;"><%=carsSoC.getCostReasonability()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getCostReasonability()): " - " %> </td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Justification for selection of RSP</td>
		<td style="width: 73%;"><%=carsSoC.getRSPSelection()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getRSPSelection()): " - " %> </td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Research Service Provider</td>
		<td style="width: 73%;">
			<%=carsIni.getPITitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPITitle()): " - "+". "+carsIni.getPIName()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIName()): " - " %>,
			<%=carsIni.getPIDesig()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIDesig()): " - " %> <br>
			<%=carsIni.getPIDept()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIDept()): " - " %> <br>
			<%=carsIni.getPIMobileNo()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIMobileNo()): " - " %> <br>
			<%=carsIni.getPIEmail()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIEmail()): " - " %> <br>
			<%if(carsIni.getPIFaxNo()!=null && !carsIni.getPIFaxNo().isEmpty()){ %>
				<br> <%=StringEscapeUtils.escapeHtml4(carsIni.getPIFaxNo()) %>
			<%} %>
			
			<span style="color: black;">From</span> <br>
			<%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - " %> <br>
  			<%=carsIni.getRSPAddress()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPAddress()): " - "+", "+carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - "+", "+carsIni.getRSPState()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPState()): " - "+" - "+carsIni.getRSPPinCode()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPPinCode()): " - " %>.
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Execution Plan</td>
		<td style="width: 73%;text-align: center;">
			<a href="CARSSoCFileDownload.htm?carsSocId=<%=carsSoC.getCARSSoCId()%>&filename=exeplanfile" target="_blank">Annexure - IV</a>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Success / Acceptance Criterion</td>
		<td style="width: 73%;"><%=carsSoC.getSoCCriterion()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getSoCCriterion()): " - " %> </td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Summary of Offer (SoO)</td>
		<td style="width: 73%;text-align: center;">
			<a href="CARSSoCFileDownload.htm?carsSocId=<%=carsSoC.getCARSSoCId()%>&filename=soofile" target="_blank">Download Document</a>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
		<td style="width: 20.5%;">Feasibility Report</td>
		<td style="width: 73%;text-align: center;">
			<a href="CARSSoCFileDownload.htm?carsSocId=<%=carsSoC.getCARSSoCId()%>&filename=frfile" target="_blank">Download Document</a>
		</td>
	</tr>
</table>
               							
<br><br><br><br>
      
<table id="timestamptable">
	<tr>
		<td style="text-align: left;">
			<div style="line-height: 17px;">
    			<div style="font-size: 15px;margin-bottom: 10px;">Signature of the initiating officer</div>
				<label style="text-transform: capitalize;">
					<%if(emp!=null && emp[1]!=null){%> <%=StringEscapeUtils.escapeHtml4(emp[1].toString())%><%} %>,
				</label><!-- <br> -->
				<label style="text-transform: capitalize;">
					<%if(emp!=null && emp[2]!=null){%> <%=StringEscapeUtils.escapeHtml4(emp[2].toString())%><%} %>
				</label><br>
				<label style="font-size: 12px;">
					Date&nbsp;:&nbsp;<%if(carsSoC.getSoCDate()!=null) {%> <%=fc.SqlToRegularDate(carsSoC.getSoCDate()) %><%} else{%><%=rdf.format(new Date()) %> <%} %>
				</label>
			</div>
		</td>
		<td style="text-align: right;">
			<div style="line-height: 17px;">
    			<div style="font-size: 15px;margin-bottom: 10px;"> Signature of the <%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>GD<%} else{%>PD<%} %></div>
				<%for(Object[] apprInfo : socApprovalEmpData){ %>
					<%if(apprInfo[8].toString().equalsIgnoreCase("SFG") || apprInfo[8].toString().equalsIgnoreCase("SFP")){ %>
						<label style="text-transform: capitalize;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
						<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
						<label style="font-size: 12px;">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19) %>]</label>
				<%break;}} %>  
			</div>	
		</td>
	</tr>
</table>       							

</body>
</html>