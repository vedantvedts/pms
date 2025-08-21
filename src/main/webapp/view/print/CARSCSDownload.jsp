<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.cars.model.CARSOtherDocDetails"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Contract Signature</title>

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
          margin-top: 40px;
          margin-left: 50px;
          margin-right: 50px;
          margin-buttom: 40px; 	
          /* border: 1px solid black; */ 
          
          @bottom-left {          		
             content: "";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
             
                    
           /* @bottom-right  {
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
          } */
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
          	content: element(pageHeader);
            font-size: 13px;
            
          }               
          
 }
 

#headertable{
  position: running(pageHeader);
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
span,p,h1,h2,h3,h4,h5,h6{
	font-size: 17px !important;
	font-family: 'Times New Roman', Times, serif !important;
}

.socheading{
	margin-left: 10px;
}  

.soccontent{
	margin-left: 15px;
	margin-right : 15px;
} 

/* Add a new style for static data */
#staticData {
    border-collapse: collapse;
    width: 100%;
    margin-bottom: 15px;
}

#staticData th, #staticData td {
    border: 1px solid black;
    padding: 5px;
    text-align: center;
}
#headertable{
 margin-left : 10px;
 border-collapse : collapse;
 width : 90%;
}

#headertable td{
 text-align : left;
 border : 1px solid black;
 padding : 1px;
 font-size: 14px;
}
#tabledata td:first-child { 
	text-align: center; 
}

</style>
</head>
<body>
<%
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 
List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");
List<Object[]> othersCSApprovalEmpData = (List<Object[]>)request.getAttribute("OthersCSApprovalEmpData");

List<CARSOtherDocDetails> csdetailslist = otherdocdetails.stream().filter(e-> "C".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());

CARSOtherDocDetails csdetails = csdetailslist!=null && csdetailslist.size()>0?csdetailslist.get(0):null;

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();

String labcode =(String)session.getAttribute("labcode");
String EmpId =((Long) session.getAttribute("EmpId")).toString();

long carsInitiationId = carsIni.getCARSInitiationId();
String statuscode = carsIni.getCARSStatusCode();

long otherDocDetailsId = csdetails!=null ? csdetails.getOtherDocDetailsId():0;

Object[] PDs = (Object[])request.getAttribute("PDEmpIds");
%>

	<div align="center">
    	<h5 style="font-weight: bold;"><%=labcode!=null?StringEscapeUtils.escapeHtml4(labcode): " - " %></h5>
        <span style="font-size: larger; text-decoration: underline;">Directorate of Planning & Coordination</span>
    </div>
     
     <table style="border-collapse: collapse;width: 98%;margin-top: 10px;">
     	<tr>
     		<td>
     			<span>No:</span> <span><%=carsContract.getContractNo()!=null?StringEscapeUtils.escapeHtml4(carsContract.getContractNo()): " - " %> </span>
     		</td>
     		<td style="text-align: right;" >
     			<span>Date:</span> <span><%if(csdetails.getOtherDocDate()!=null) {%> <%=fc.SqlToRegularDate(csdetails.getOtherDocDate()) %><%} else{%><%=rdf.format(new Date()) %><%} %> </span>
     		</td>
     	</tr>
     </table>          										
    <%-- <div style="display: inline;">
		<div style="text-align: left;">
			<span>No:</span> <span><%=csdetails.getOtherDocFileNo() %> </span>
		</div>
		<div style="text-align: right;">
			<span>Date:</span> <span><%if(csdetails.getOtherDocDate()!=null) {%> <%=fc.SqlToRegularDate(csdetails.getOtherDocDate()) %><%} else{%><%=rdf.format(new Date()) %><%} %> </span>
		</div>
		
	</div> --%>
	<hr>
	<div class="row">
		<div align="center">
			<h5 style="font-weight: bold;margin-top: 1.5rem;">CARS contract signature</h5>
		    <span style="font-size: large;"><%=carsIni.getInitiationTitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()): " - " %> </span>
		</div>
	</div>
	<br>
	<div style="line-height: 20px;">
		<div style="text-align: left;">
			<span>
				1)	SoC from 
				<%if(carsIni!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					Directorate
				<%} else{%>
				<%if(PDs!=null) {%><%=PDs[4]!=null?StringEscapeUtils.escapeHtml4(PDs[4].toString()): " - " %><%} else{%>-<%} %>
				<%} %>  
				for CARS collaboration with <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - "+", "+carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - " %> <%} %> has been approved by CFA.
			</span>
			<span>
				<%if(csdetails!=null && csdetails.getAttachFlagA()!=null) {%>
					<a href="CARSOtherDocAttachedFileDownload.htm?otherDocDetailsId=<%=otherDocDetailsId%>&filename=flagAFile&otherDocType=C" >(Flag-A)</a>
		        <%} %>
			</span>
		</div>
	</div>
	
	<div  style="line-height: 20px;margin-top: 10px;">
		<div class="col-md-12" style="text-align: left;">
			<span>
				2)	The final RSQR, Milestones and payment terms are attached. 
			</span>
			<span>
				<%if(csdetails!=null && csdetails.getAttachFlagB()!=null) {%>
					<a href="CARSOtherDocAttachedFileDownload.htm?otherDocDetailsId=<%=otherDocDetailsId%>&filename=flagBFile&otherDocType=C" >(Flag-B)</a>
		        <%} %>
			</span>
		</div>
	</div>
	
	<div  style="line-height: 20px;margin-top: 10px;">
		<div class="col-md-12" style="text-align: left;">
			<span>
				3)	The contract signed by competent authority of the RSP is placed opposite for CFA's signature please. 
			</span>
			<span>
				<%if(csdetails!=null && csdetails.getAttachFlagC()!=null) {%>
					<a href="CARSOtherDocAttachedFileDownload.htm?otherDocDetailsId=<%=otherDocDetailsId%>&filename=flagCFile&otherDocType=C" >(Flag-C)</a>
				<%} %>
			</span>
		</div>
	</div>
	<br>
			               		   					
	<!-- Signatures and timestamps -->
	<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 18px;margin-top: 20px;">
		<div style="font-size: 15px;"> Signature of GD-DP&C</div>
		<%for(Object[] apprInfo : othersCSApprovalEmpData){ %>
			<%if(apprInfo[8].toString().equalsIgnoreCase("CFW")){ %>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
				<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19) %>]</label>
		<%break;}} %>  
	</div>
							            	
	<%for(Object[] apprInfo : othersCSApprovalEmpData) {%>
		<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 18px;margin-top: 40px;">
										            			 		
			<%if(apprInfo[8].toString().equalsIgnoreCase("CFA")){ %>
				<div style="font-size: 15px;"> Signature of AD-P&C</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("CAD")) {%> 
				<div style="font-size: 15px;"> Signature of Director</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
				<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19) %>]</label>
									   			    					
			<%} %>
		</div>
	<%} %>
</body>
</html>