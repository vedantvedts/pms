<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Summary Offer of Provision of Research Services</title>
<script src="./webjars/jquery/3.4.0/jquery.min.js"></script>
<spring:url value="/resources/js/FileSaver.min.js" var="FileSaver" />
<script src="${FileSaver}"></script>

<spring:url value="/resources/js/jquery.wordexport.js" var="wordexport" />
<script src="${wordexport}"></script>
	<!--BootStrap Bundle JS  -->
<script src="./webjars/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

<!--BootStrap JS  -->
<!-- <script src="./webjars/bootstrap/4.0.0/js/*.js"></script> -->

<!--BootStrap CSS  -->
<link rel="stylesheet" href="./webjars/bootstrap/4.0.0/css/bootstrap.min.css" />

<link rel="stylesheet" href="./webjars/font-awesome/4.7.0/css/font-awesome.min.css" />

<style type="text/css">

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
 

 @page  {             
          size: 790px 1120px;
          margin-top: -20px; 
          margin-left: 10px;
          margin-right: 10px;
          margin-buttom: 10px; 	
 }
       

</style>
</head>
<body>
<%
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData");
String labcode = (String)session.getAttribute("labcode");
LabMaster labMaster = (LabMaster)request.getAttribute("LabMasterData");

FormatConverter fc = new FormatConverter();
%>
	<div  align="center" ><button class="btn btn-lg bg-transparent" id="btn-export" onclick=exportHTML() ><i class="fa fa-lg fa-download" aria-hidden="true"style="color:green"></i></button></div>
	<div id="source-html">
		<div id="container pageborder" align="center"  class="firstpage" id="firstpage">
			<div class="firstpage" id="firstpage"> 	
				<div style="text-align: right;">
					<h5 style="font-weight: bold;margin-right: 2rem;">LRDE : CARS-02</h5>
				</div>
				<div class="center">
			       <h4 style="font-weight: bold;margin-top: 1.5rem;">Summary Offer of Provision of Research Services</h4>
			    </div>
			    <table style="margin-left : 10px;border-collapse : collapse;border : 1px solid black;width : 98.5%;">
			    	<tbody>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				1. Title of DRDO's Research Service Qualitative Requirement (RSQR):&nbsp;
			    			 	<%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%> <%=carsIni.getInitiationTitle() %> <%} else {%>-<%} %> <br><br><br><br>
			    			</td>
			    			<td  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
				    			Offer Number: <br>
				    			Date received: <br>
				    			Revised on:
			    			</td>
			    			<td rowspan="3" colspan="1" style="text-align: center;width: 50px;">
			    			F <br> o<br>r<br><br> D<br>R<br>D<br>O<br><br> u<br>s<br>e<br>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> 
			    				RSQR Document Ref. No. :&nbsp;<%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=carsIni.getCARSNo() %><%} else{%>-<%} %> <br><br> <!-- <br><br><br><br> --> 
			    			</td>
			    			<td  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				Date of issue :&nbsp;<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%><%=fc.SqlToRegularDate(carsIni.getInitiationApprDate()) %><%} else{%>-<%} %><br><br>
			    				<!-- <table style="border-collapse: collapse;width: 103%;border: none;margin: -5px -5px -5px -5px;">
				    				<tbody>
				    					<tr>
				    						<td colspan="3" style="text-align: center;border-top: 0;border-left: 0;border-right: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;">Date of issue</td>
				    					</tr>
					    				<tr>
					    					<td style="text-align: center;border-left: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;">YY</td>
					    					<td style="text-align: center;border-left: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;">MM</td>
					    					<td style="text-align: center;border-left: 0;border-right: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;">DD</td>
					    				</tr>
					    				<tr>
					    					<td style="border-left: 0;border-bottom: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;"><br></td>
					    					<td style="border-left: 0;border-bottom: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;"><br></td>
					    					<td style="border-left: 0;border-right: 0;border-bottom: 0;border : 1px solid black;padding : 5px;word-wrap: break-word;word-break: normal ;"><br></td>
					    				</tr>
				    				</tbody>
			    				</table> -->
			    			</td>
			    			<td  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
								Issuing DRDO Estt :&nbsp;
								<%if(labMaster!=null) {%>
									<%if(labMaster.getLabCode()!=null) {%><%=labMaster.getLabCode() %><%} else{%>-<%} %>
									<%if(labMaster.getLabAddress()!=null) {%><%=", "+labMaster.getLabAddress() %><%} else{%>-<%} %>
									<%if(labMaster.getLabCity()!=null) {%><%=", "+labMaster.getLabCity() %><%} else{%>-<%} %>
									<%if(labMaster.getLabPin()!=null) {%><%=" - "+labMaster.getLabPin() %><%} else{%>-<%} %>
									
								<%} %>
								 <br><br><!-- <br><br><br><br> --> 
							</td>
			    			<td  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> 
			    				Remarks of RSQR initiator : <br><br><!-- <br><br><br><br> --> 
			    			</td>
			    		</tr>
			    		<tr>
			    			<td rowspan="2" colspan="2"  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				3. Name of Research Service Provider (RSP) making this offer:&nbsp;
			    					<%if(carsIni!=null) {%><%=carsIni.getPITitle()+". "+carsIni.getPIName()+", "+carsIni.getPIDesig() %> <%} else{%>-<%} %> <br>
			    				3. (a) RSP's address for correspondence:&nbsp;
			    				  	<%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> <%} else{%>-<%} %>	<br>
			    				  	&nbsp;&nbsp;&nbsp;&nbsp;<%if(carsIni!=null) {%><%=carsIni.getRSPAddress()+", "+carsIni.getRSPCity()+", "+carsIni.getRSPState()+" - "+carsIni.getRSPPinCode() %> <%} else{%>-<%} %> <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;Phone :&nbsp;<%if(carsIni!=null) {%><%=carsIni.getPIMobileNo() %> <%} else{%>-<%} %> <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;Fax :&nbsp;<%if(carsIni!=null && carsIni.getPIFaxNo()!=null) {%><%=carsIni.getPIFaxNo() %> <%} else{%>-<%} %> <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;Email :&nbsp;<%if(carsIni!=null) {%><%=carsIni.getPIEmail() %> <%} else{%>-<%} %> <br>
			    				<br><br><br><br>
			    			</td>
			    			<td rowspan="1"  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				4. RSP's Ref.
			    				<br><br><br><br>
			    				Date : 
			    			</td>
			    			<td rowspan="1"  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				Judgment of OEC <br><br><br><br><br><br><br>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td rowspan="1" colspan="3"  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				5. (a) Key personnel of RSP to be deployed: <br><br>
			    				5. (b) RSP'S sub-contractors / consultants: <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i) Name: <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ii) Institute / Company: 
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5"  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    			 6. Principal technical features of offer as related to RSQR As per Annexure I
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5"  style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    			 7. DRDO-owned equipment that RSP requires to be positioned by DRDO: 
			    			</td>
			    		</tr>
			    		
			    	</tbody>
			    </table>
			    <table style="margin-left : 10px;border-collapse : collapse;width : 98.5%;">
			    	<tbody>
			    		<tr>
			    			<td colspan="3" style="border-top: 0 !important;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> 8. Estimated time to complete provision of professional services and submit Final Report </td>
			    			<td colspan="2" style="border-top: 0 !important;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> Months:  </td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> 9.1 Estimated expenditure (as elaborated on reverse) on: </td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;(a) Personnel</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;(b) Equipment</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;(c) Others</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sub-Total</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TAX</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="text-align: right;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">Total&nbsp;&#11162;&nbsp;</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="border-top: 0;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> 9.2. Required Schedule of payments (Rs. in Lakhs) </td>
			    			<td colspan="1" style="text-align: center;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> Date / Duration  </td>
			    			<td colspan="2" style="text-align: center;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> Payment </td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;(a) Initial Advance &nbsp;&nbsp;<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>% </td>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">T0</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;(b) at Performance Milestone I of RSQR &nbsp;&nbsp;<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>% </td>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">T0+</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">&nbsp;&nbsp;&nbsp;&nbsp;(c) at Performance Milestone II of RSQR &nbsp;&nbsp;<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>% </td>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">T0+</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> &nbsp;&nbsp; </td>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> &nbsp;&nbsp; </td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> &nbsp;&nbsp; </td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> &nbsp;&nbsp; </td>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> &nbsp;&nbsp; </td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> &nbsp;&nbsp; </td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align: center;border-right: 0;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">[ Inclusive of Service Tax if applicable ]</td>
			    			<td colspan="1" style="text-align: right;border-left: 0;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"> Total&nbsp;&#11162;&nbsp;</td>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;"></td>
			    		</tr>
			    		<tr>
			    			<td rowspan="2" colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				10. References to R&D work being performed by RSP for Armed Services / DRDO / other S&T (including foreign) agencies : <br><br><br><br><br><br><br> </td>
			    			<td colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal ;">
			    				11. Offer as above valid till (date) : </td>
			    		</tr>
			    		<tr>
			    			<td rowspan="1" colspan="3" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    			 12. Signature of the competent authority of RSP : <br> 
			    			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name : <br>
			    			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Designation : 
			    			</td>
			    		</tr>
			    	</tbody>
			    </table>
			    <br> <br><br> <br>
			</div>
		</div>
		<h1 class="break"></h1> 
		<div id="container pageborder" align="center"  class="secondpage" id="secondpage">
			<div class="secondpage" id="secondpage"> 	
				<div class="center">
			       <h4 style="font-weight: bold;margin-top: 1.5rem;">Guidance to fill form</h4>
			    </div>
			    <table style="margin-left : 10px;border-collapse : collapse;width : 98.5%;">
			    	<tbody>
			    		<tr>
			    			<td style="width: 15%;">Item 5(a) <br><br> </td>
			    			<td>: In offers whose expected time of completion is more than 18 months, RSP shall identify at least two key personnel who will engage in the work.</td>
			    		</tr>
			    		<tr>
			    			<td style="width: 15%;">Item 5(b) <br><br> </td>
			    			<td>: Consultants who are non-Indian citizens (whether or not of Indian origin) will require prior approval of DRDO.</td>
			    		</tr>
			    		<tr>
			    			<td style="width: 15%;">Item 6 <br><br> </td>
			    			<td>: Highlight investigation methodology and/or experimental design intended to be followed.</td>
			    		</tr>
			    		<tr>
			    			<td style="width: 15%;">Item 7 <br><br> </td>
			    			<td>: Identify equipment. Detail in Attachment B, including proposed country of origin.</td>
			    		</tr>
			    		<tr>
			    			<td style="width: 15%;">Item 9.1(a) <br><br> </td>
			    			<td>: Indicate below categories, and numbers in each category, of personnel proposed to be engaged and their monthly total emoluments.</td>
			    		</tr>
			    		<tr>
			    			<td style="width: 15%;">Item 9.1(b) <br><br> </td>
			    			<td>: List below all equipment required. Prior approval of L/E/P will be required to order any equipment for which the potential supplier asks for an end-use or end-user certificate.</td>
			    		</tr>
			    		<tr>
			    			<td style="width: 15%;">Item 9.1(c) <br></td>
			    			<td>: Enter total of expected other expenses listed below:</td>
			    		</tr>
			    	</tbody>
			    </table>
			    <table style="margin-left : 10px;border-collapse : collapse;border : 1px solid black;width : 98.5%;border-bottom: 0 !important;border-left: 0;">
			    	<tbody>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">Expected other expenses on:</td>
			    			<td style="text-align: center;width: 20%;">Rs. in lakhs</td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Sub-contracts (Details to be provided in separate sheet
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Operation and maintenance of equipment required for provision of the Research Service
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Expendables/Consumables
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Travel
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Contingencies
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Visiting Faculty or Research Consultants
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Technical support services procured from outside the RSP
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Fees for use of intellectual assets (including royalties for legally protected IPR)
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Overheads <br>
									&nbsp;&nbsp;&#x2022;&nbsp;&nbsp;Overheads (fixed amount till completion of provision of Research Services) for Contracts which are successfully concluded. <br>
									&nbsp;&nbsp;&#x2022;&nbsp;&nbsp;Overheads will be charged on actual for all Contracts which are either short or stage closed.  
			    			</td>
			    			<td style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" style="text-align: left;padding : 3px;word-wrap: break-word;word-break: normal;border-left: 0 !important;border-bottom: 0 !important;">
			    				# Will not be changed notwithstanding variations in actual expenditure under other heads in Item 9.
			    			</td>
			    			<td colspan="1" style="text-align: right;padding : 3px;word-wrap: break-word;word-break: normal;border-left: 0 !important;border-bottom: 0 !important;">
			    				Total&nbsp;&#11162;&nbsp;
			    			</td>
			    			<td colspan="1" style="width: 20%;text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;"></td>
			    		</tr>
			    	</tbody>
			    </table>
			</div>
		</div>
		<br>	    
	</div>
<script>
  jQuery(document).ready(function($) {
   	  $("#btn-export").click(function(event) {
   	    $("#source-html").wordExport("Summary Offer of Provision of Research Service");
   	  });
   	});
   
</script>	
</body>
</html>