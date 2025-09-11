<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
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
<%
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData");
String MilestoneNo = (String)request.getAttribute("MilestoneNo");
%>
<title>Payment towards <%=MilestoneNo!=null?MilestoneNo: " - " %> </title>
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
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");


List<CARSSoCMilestones> milestonedetailsbymilestoneno = milestones.stream().filter(e-> MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSSoCMilestones milestonedetails = milestonedetailsbymilestoneno!=null && milestonedetailsbymilestoneno.size()>0? milestonedetailsbymilestoneno.get(0):null;

List<CARSOtherDocDetails> ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSOtherDocDetails ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0?ptcdetailslist.get(0):null;

List<CARSOtherDocDetails> mpdetailslist = otherdocdetails.stream().filter(e-> "M".equalsIgnoreCase(e.getOtherDocType()) && MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSOtherDocDetails mpdetails = mpdetailslist!=null && mpdetailslist.size()>0?mpdetailslist.get(0):null;

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();

String labcode =(String)session.getAttribute("labcode");
String EmpId =((Long) session.getAttribute("EmpId")).toString();

long carsInitiationId = carsIni.getCARSInitiationId();
String statuscode = carsIni.getCARSStatusCode();

long otherDocDetailsId = ptcdetails!=null ? ptcdetails.getOtherDocDetailsId():0;

Object[] dPandC = (Object[])request.getAttribute("DPandC");
%>

	<div align="center">
    	<h5 style="font-weight: bold;">D-P&C</h5>
    </div>
    
    <table style="border-collapse: collapse;width: 98%;margin-top: 10px;">
     	<tr>
     		<td>
     			<span>No:</span> <span><%=carsContract.getContractNo()!=null?carsContract.getContractNo(): " - " %> </span>
     		</td>
     		<td style="text-align: right;" >
     			<span>Date:</span> <span><%if(ptcdetails.getOtherDocDate()!=null) {%> <%=fc.SqlToRegularDate(ptcdetails.getOtherDocDate()) %><%} else{%><%=rdf.format(new Date()) %><%} %> </span>
     		</td>
     	</tr>
     </table>
     
     <br>
     
     <div class="row">
		<div align="center">
			<h5 style="font-weight: bold;margin-top: 1.5rem;">Sub: Payment towards CARS Project</h5>
		    <%-- <span style="font-size: large;"><%=carsIni.getInitiationTitle() %> </span> --%>
		</div>
	</div>
	
	<table style="width: 98%;margin-top: 10px;">
		<tr>
			<td>1.</td>
			<td>
				&nbsp;&nbsp;Reference is made to CARS Contract No. <%if(carsContract!=null) {%><%=carsContract.getContractNo()!=null?carsContract.getContractNo(): " - " %> <%} %> 
				dt. <%if(carsContract!=null && carsContract.getContractDate()!=null) {%>
					<%=fc.SqlToRegularDate(carsContract.getContractDate()) %>.
					<%} %>
			</td>
		</tr>
		<tr><td></td></tr>
		<tr>
			<td style="vertical-align: top;">2.</td>
			<td>
				&nbsp;&nbsp;Invoice received from <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - "%> <%=", "%> <%=carsIni.getRSPCity()!=null?carsIni.getRSPCity(): " - " %> <%} %>,
				 for the subject CARS is enclosed for release of
				 <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%><%=MilestoneNo %> <%} else{%>Initial Advance<%} %>
				 payment and further necessary action please.
			</td>
		</tr>
	</table>
	
	<br><br><br><br>
	
	<%if(dPandC!=null) {%>
	<table style="width: 98%;margin-top: 10px;">
		<tr>
			<td style="text-align: right;">
			<%if(dPandC[4]!=null) {%><%=dPandC[4].toString() %>
			<%} else if(dPandC[5]!=null){%><%=dPandC[5].toString() %>
			<%} else{%><%} %>
			<%=dPandC[1]!=null?dPandC[1].toString(): " - "%> <%=", "%> <%=dPandC[2]!=null?dPandC[2].toString(): " - " %>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;">D-P&C</td>
		</tr>
		
	</table>
	<%} %>
	<br> <br> <br> 
	<table style="width: 98%;margin-top: 10px;">
		<tr>
			<td style="text-align: left;">To</td>
		</tr>
		<tr>
			<td style="text-align: left;">DFMM-AG</td>
		</tr>
		<tr><td></td></tr>
		<tr><td></td></tr>
		<tr><td></td></tr>
		<tr><td></td></tr>
		<tr>
			<td>Encl:</td>
		</tr>
		<tr>
			<td>i. &nbsp;&nbsp;&nbsp;Original invoice no. <%if(mpdetails!=null) {%><%=mpdetails.getInvoiceNo()!=null?mpdetails.getInvoiceNo(): " - " %><%} %> 
			dated <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%>
					<%=fc.SqlToRegularDate(mpdetails.getInvoiceDate()) %>
					<%} %>
			for Rs. <%if(milestones.get(0).getActualAmount()!=null) {%>
						<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(0).getActualAmount())) %>
					<%} else{%>
						-
					<%} %> /-</td>
		</tr>
		<tr>
			<td>ii.	&nbsp;&nbsp;Contractor's bill</td>
		</tr>
		<tr>
			<td>iii. &nbsp;ECS Form</td>
		</tr>
		<tr>
			<td>iv. &nbsp;Copy of the PAN card of the institute</td>
		</tr>
		<tr><td>v. &nbsp;&nbsp;Cancelled Cheques</td></tr>
		<tr><td>vi. &nbsp;CFA's approval in original for payment release </td></tr>
	</table>
</body>
</html>