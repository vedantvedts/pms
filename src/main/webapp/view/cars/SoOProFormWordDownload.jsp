<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CARS-02</title>
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


<spring:url value="/resources/css/cars/SoOProFormWordDownload.css" var="soOProFormWordDownload" />
<link href="${soOProFormWordDownload}" rel="stylesheet" />

</head>
<body>
<%
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData");
String labcode = (String)session.getAttribute("labcode");
LabMaster labMaster = (LabMaster)request.getAttribute("LabMasterData");

FormatConverter fc = new FormatConverter();

Object[] rsqr =(Object[])request.getAttribute("RSQRDetails");
%>
	<div  align="center" ><button class="btn btn-lg bg-transparent" id="btn-export" onclick=exportHTML() ><i class="fa fa-lg fa-download text-success" aria-hidden="true"></i></button></div>
	<div id="source-html">
		<div id="container pageborder" align="center"  class="firstpage" id="firstpage">
			<div class="firstpage" id="firstpage"> 	
				<div class="right">
					<h5 class="mr-2-rem fw-bold" ><%=labcode!=null?StringEscapeUtils.escapeHtml4(labcode): " - " %> : CARS-02</h5>
				</div>
				<div class="center">
			       <h4 class="fw-bold mt-4" >Summary Offer of Provision of Research Services</h4>
			    </div>
			    <table class="table-ml">
			    	<tbody>
			    		<tr>
			    			<td colspan="3" class="td-1">
			    				1. Title of DRDO's Research Service Qualitative Requirement (RSQR):&nbsp;
			    			 	<%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%> <%=StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()) %> <%} else {%>-<%} %> <br><br><br><br>
			    			</td>
			    			<td  class="td-1">
				    			Offer Number: <br>
				    			Date received: <br>
				    			Revised on:
			    			</td>
			    			<td rowspan="3" colspan="1" class="w-50-px text-center">
			    			F <br> o<br>r<br><br> D<br>R<br>D<br>O<br><br> u<br>s<br>e<br>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td  class="td-1"> 
			    				RSQR Document Ref. No. :&nbsp;<%if(rsqr!=null && rsqr[11]!=null) {%><%=StringEscapeUtils.escapeHtml4(rsqr[11].toString()) %><%} else{%>-<%} %> <br><br> <!-- <br><br><br><br> --> 
			    			</td>
			    			<td  class="td-1">
			    				Date of issue :&nbsp;<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%><%=fc.SqlToRegularDate(carsIni.getInitiationApprDate()) %><%} else{%>-<%} %><br><br>
			    				
			    			</td>
			    			<td  class="td-1">
								Issuing DRDO Estt :&nbsp;
								<%if(labMaster!=null) {%>
									<%if(labMaster.getLabCode()!=null) {%><%=StringEscapeUtils.escapeHtml4(labMaster.getLabCode()) %><%} else{%>-<%} %>
									<%if(labMaster.getLabAddress()!=null) {%><%=", "+StringEscapeUtils.escapeHtml4(labMaster.getLabAddress()) %><%} else{%>-<%} %>
									<%if(labMaster.getLabCity()!=null) {%><%=", "+StringEscapeUtils.escapeHtml4(labMaster.getLabCity()) %><%} else{%>-<%} %>
									<%if(labMaster.getLabPin()!=null) {%><%=" - "+StringEscapeUtils.escapeHtml4(labMaster.getLabPin()) %><%} else{%>-<%} %>
									
								<%} %>
								 <br><br><!-- <br><br><br><br> --> 
							</td>
			    			<td  class="td-1"> 
			    				Remarks of RSQR initiator : <br><br><!-- <br><br><br><br> --> 
			    			</td>
			    		</tr>
			    		<tr>
			    			<td rowspan="2" colspan="2"  class="td-1">
			    				3. Name of Research Service Provider (RSP) making this offer:&nbsp;
			    					<%if(carsIni!=null) {%><%=carsIni.getPITitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPITitle()): " - "%> . <%=carsIni.getPIName()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIName()): " - "%>, <%=carsIni.getPIDesig()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIDesig()): " - " %> <%} else{%>-<%} %> <br>
			    				3. (a) RSP's address for correspondence:&nbsp;
			    				  	<%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - "%>, <%=carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - " %> <%} else{%>-<%} %>	<br>
			    				  	&nbsp;&nbsp;&nbsp;&nbsp;<%if(carsIni!=null) {%><%=carsIni.getRSPAddress()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPAddress()): " - "%>, <%=carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - "%>, <%=carsIni.getRSPState()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPState()): " - "%> - <%=carsIni.getRSPPinCode()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPPinCode()): " - " %> <%} else{%>-<%} %> <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;Phone :&nbsp;<%if(carsIni!=null) {%><%=carsIni.getPIMobileNo()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIMobileNo()): " - " %> <%} else{%>-<%} %> <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;Fax :&nbsp;<%if(carsIni!=null && carsIni.getPIFaxNo()!=null) {%><%=carsIni.getPIFaxNo() %> <%} else{%>-<%} %> <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;Email :&nbsp;<%if(carsIni!=null) {%><%=carsIni.getPIEmail()!=null?StringEscapeUtils.escapeHtml4(carsIni.getPIEmail()): " - " %> <%} else{%>-<%} %> <br>
			    				<br><br><br><br>
			    			</td>
			    			<td rowspan="1"  class="td-1">
			    				4. RSP's Ref.
			    				<br><br><br><br>
			    				Date : 
			    			</td>
			    			<td rowspan="1"  class="td-1">
			    				Judgment of OEC <br><br><br><br><br><br><br>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td rowspan="1" colspan="3"  class="td-1">
			    				5. (a) Key personnel of RSP to be deployed: <br><br>
			    				5. (b) RSP'S sub-contractors / consultants: <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i) Name: <br>
			    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ii) Institute / Company: 
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5"  class="td-1">
			    			 6. Principal technical features of offer as related to RSQR As per Annexure I
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5"  class="td-1">
			    			 7. DRDO-owned equipment that RSP requires to be positioned by DRDO: 
			    			</td>
			    		</tr>
			    		
			    	</tbody>
			    </table>
			    <table class="table-ml-2">
			    	<tbody>
			    		<tr>
			    			<td colspan="3" class="td-6"> 8. Estimated time to complete provision of professional services and submit Final Report </td>
			    			<td colspan="2" class="td-6"> Months:  </td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-1"> 9.1 Estimated expenditure (as elaborated on reverse) on: </td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;(a) Personnel</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;(b) Equipment</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;(c) Others</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sub-Total</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TAX</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" class="td-7">Total&nbsp;&#11162;&nbsp;</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-8"> 9.2. Required Schedule of payments (&#8377;) </td>
			    			<td colspan="1" class="td-9"> Date / Duration  </td>
			    			<td colspan="2" class="td-9"> Payment (&#8377;) </td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;(a) Initial Advance &nbsp;&nbsp;<span class="text-ul">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>% </td>
			    			<td colspan="1" class="td-1">T0*</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;(b) at Performance Milestone I of RSQR &nbsp;&nbsp;<span class="text-ul">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>% </td>
			    			<td colspan="1" class="td-1">T0+</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">&nbsp;&nbsp;&nbsp;&nbsp;(c) at Performance Milestone II of RSQR &nbsp;&nbsp;<span class="text-ul">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>% </td>
			    			<td colspan="1" class="td-1">T0+</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1"> &nbsp;&nbsp; </td>
			    			<td colspan="1" class="td-1"> &nbsp;&nbsp; </td>
			    			<td colspan="2" class="td-1"> &nbsp;&nbsp; </td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1"> &nbsp;&nbsp; </td>
			    			<td colspan="1" class="td-1"> &nbsp;&nbsp; </td>
			    			<td colspan="2" class="td-1"> &nbsp;&nbsp; </td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-10">[Inclusive of Service Tax if applicable]</td>
			    			<td colspan="1" class="td-11"> Total&nbsp;&#11162;&nbsp;</td>
			    			<td colspan="2" class="td-1"></td>
			    		</tr>
			    		<tr>
			    			<td rowspan="2" colspan="2" class="td-1">
			    				10. References to R&D work being performed by RSP for Armed Services / DRDO / other S&T (including foreign) agencies: <br><br><br><br><br><br></td>
			    			<td colspan="3" class="td-11">
			    				11. Offer as above valid till (date): </td>
			    		</tr>
			    		<tr>
			    			<td rowspan="1" colspan="3" class="td-1">
			    			 12. Signature of the competent authority of RSP: <br> 
			    			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name: <br>
			    			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Designation: 
			    			</td>
			    		</tr>
			    	</tbody>
			    </table>
			    
			</div>
		</div>
		<p class="p-sty">&nbsp;&nbsp;&nbsp;&nbsp;</p>
		<div id="container pageborder" align="center"  class="secondpage" id="secondpage">
			<div class="secondpage" id="secondpage"> 	
				<div class="center">
			       <h4 class="fw-bold mt-4">Guidance to fill form</h4>
			    </div>
			    <table class="table-ml-2">
			    	<tbody>
			    		<tr>
			    			<td class="td-12">Item 5(a)  </td>
			    			<td>: In offers whose expected time of completion is more than 18 months, RSP shall identify at least two key personnel who will engage in the work.</td>
			    		</tr>
			    		<tr>
			    			<td class="td-12">Item 5(b)  </td>
			    			<td>: Consultants who are non-Indian citizens (whether or not of Indian origin) will require prior approval of DRDO.</td>
			    		</tr>
			    		<tr>
			    			<td class="td-12">Item 6  </td>
			    			<td>: Highlight investigation methodology and/or experimental design intended to be followed.</td>
			    		</tr>
			    		<tr>
			    			<td class="td-12">Item 7 </td>
			    			<td>: Identify equipment. Detail in Attachment B, including proposed country of origin.</td>
			    		</tr>
			    		<tr>
			    			<td class="td-12">Item 9.1(a)  </td>
			    			<td>: Indicate below categories, and numbers in each category, of personnel proposed to be engaged and their monthly total emoluments.</td>
			    		</tr>
			    		<tr>
			    			<td class="td-12">Item 9.1(b)  </td>
			    			<td>: List below all equipment required. Prior approval of L/E/P will be required to order any equipment for which the potential supplier asks for an end-use or end-user certificate.</td>
			    		</tr>
			    		<tr>
			    			<td class="td-12">Item 9.1(c) </td>
			    			<td>: Enter total of expected other expenses listed below:</td>
			    		</tr>
			    	</tbody>
			    </table>
			    <table class="table-ml-3">
			    	<tbody>
			    		<tr>
			    			<td colspan="2" class="td-1">Expected other expenses on:</td>
			    			<td class="td-13">Rs. in lakhs</td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Sub-contracts (Details to be provided in separate sheet
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Operation and maintenance of equipment required for provision of the Research Service
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Expendables/Consumables
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Travel
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Contingencies
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Visiting Faculty or Research Consultants
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Technical support services procured from outside the RSP
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Fees for use of intellectual assets (including royalties for legally protected IPR)
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="2" class="td-1">
			    				Overheads <br>
									&nbsp;&nbsp;&#x2022;&nbsp;&nbsp;Overheads (fixed amount till completion of provision of Research Services) for Contracts which are successfully concluded. <br>
									&nbsp;&nbsp;&#x2022;&nbsp;&nbsp;Overheads will be charged on actual for all Contracts which are either short or stage closed.  
			    			</td>
			    			<td class="td-3"></td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" class="td-4">
			    				# Will not be changed notwithstanding variations in actual expenditure under other heads in Item 9.
			    			</td>
			    			<td colspan="1" class="td-5">
			    				Total&nbsp;&#11162;&nbsp;
			    			</td>
			    			<td colspan="1" class="td-3"></td>
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
   	    $("#source-html").wordExport("CARS-02");
   	  });
   	});
   
</script>	
</body>
</html>