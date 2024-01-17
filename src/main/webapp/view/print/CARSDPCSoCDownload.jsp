<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DP&C SoC</title>

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
          margin-top: 140px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          /* border: 1px solid black; */ 
          
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
CARSSoC carsSoC =(CARSSoC)request.getAttribute("CARSSoCData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
List<Object[]> dpcSoCApprovalEmpData = (List<Object[]>)request.getAttribute("DPCSoCApprovalEmpData");


FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

String expenditure = carsSoC.getDPCExpenditure();
expenditure = expenditure!=null?expenditure.replace("\n", "<br>"):expenditure;
String labcode = (String) session.getAttribute("labcode");
%>
	<table id="headertable">
		<tr>
			<td style="border: none !important;font-size: 13px !important;">File No : <%=carsIni.getCARSNo()%></td>
		</tr>
		<tr><td style="border: none !important;"></td></tr>
		<tr><td style="border: none !important;"></td></tr>
		<tr><td style="border: none !important;"></td></tr>
		<tr><td style="border: none !important;"></td></tr>
		<tr><td style="border: none !important;"></td></tr>
		<tr><td style="border: none !important;"></td></tr>
		<tr>
			<td> <b>Subject : </b> Contract for Acquisition of Research Services ( CARS )</td>
		</tr>
		<tr>
			<td> <b>CARS Title : </b> <%if(carsIni!=null) {%><%=carsIni.getInitiationTitle() %> <%} %></td>
		</tr>
		<tr>
			<td> <b>Research Service Provider ( RSP ) : </b> <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> <%} %></td>
		</tr>
		<tr>
			<td> <b>Lab : </b> <%=labcode %> </td>
		</tr>
	</table>

	<div>
		<h4 class="socheading"><span>1.</span> <span style="text-decoration: underline;">Introduction</span></h4>
		<div class="soccontent">
			<p style="text-indent: 21px;font-size: 15px;"><%=carsSoC.getDPCIntroduction() %></p>
		</div>
	</div>
	<div>
		<h5 class="socheading"><span>2.</span> <span style="text-decoration: underline;">The Summary of the CARS is as under</span></h5>
		<div class="soccontent">
			<table class="soctable" id="tabledata">
				<thead>
					<tr>
						<th style="width: 5%;">SN</th>
						<th style="width: 28%;">Subject</th>
						<th style="">Details</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1.</td>
						<td>CARS Title</td>
						<td><%=carsIni.getInitiationTitle() %></td>
					</tr>
					<tr>
						<td>2.</td>
						<td>File No</td>
						<td><%=carsIni.getCARSNo() %></td>
					</tr>
					<!-- <tr>
						<td>3.</td>
						<td>Deliverables</td>
						<td>-do-</td>
					</tr> -->
					<tr>
						<td>3.</td>
						<td>Service Type</td>
						<td>General Revenue</td>
					</tr>
					<tr>
						<td>4.</td>
						<td>Estimated cost of service</td>
						<td><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carsIni.getAmount())) %></td>
					</tr>
					<tr>
						<td>5.</td>
						<td>CARS PDC</td>
						<td><%=carsIni.getDuration() %></td>
					</tr>
					<tr>
						<td>6.</td>
						<td>Expenditure Head</td>
						<td><%=expenditure %></td>
					</tr>
					<tr>
						<td>7.</td>
						<td>CFA approval as per DFP</td>
						<td>Under Sl. No: 2.4 of DFP dated 18 Dec 2019</td>
					</tr>
					<tr>
						<td>8.</td>
						<td>Additional Points</td>
						<td><%if(carsSoC.getDPCAdditional()!=null && !carsSoC.getDPCAdditional().isEmpty()) {%><%=carsSoC.getDPCAdditional() %><%} else{%>-<%} %></td>
					</tr>
				</tbody>
					
			</table>
		</div>
	</div>
			               		   						
	<div style="">
		<h5 class="socheading"><span>3.</span> <span style="text-decoration: underline;">Description</span></h5>
		<div class="soccontent">
			<p style="font-size: 15px;text-indent: 21px;">
				<%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> has submitted the &#39;Summary of Offer&#39; for Rs <span class="textunderline"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carsIni.getAmount())) %></span>
				(inclusive of GST) for duration of <span class="textunderline"><%=carsIni.getDuration() %></span> months. Required schedule of payments is given below.
			</p>
			<table id="tabledata">
				<thead>
					<tr>
					  <th style="width: 5%;">Milestone No.</th>
					  <th style="width: 20%;">Task Description</th>
					  <th style="width: 10%;">Months</th>
					  <th style="">Deliverables</th>
					  <th style="width: 5%;">Payment <br>( In % )</th>
					  <th style="width: 20%;">Payment Terms</th>
					</tr>
				</thead>
				<tbody>
					<%if(milestones!=null && milestones.size()>0) {
						for(CARSSoCMilestones mil : milestones){
		
					%>
						<tr>
							<td style="text-align: center;width: 5%;"><%=mil.getMilestoneNo() %></td>
							<td style="width: 20%;"><%=mil.getTaskDesc() %></td>
							<td style="text-align: center;width: 10%;"><%=mil.getMonths() %></td>
							<td style=""><%=mil.getDeliverables() %></td>
							<td style="text-align: center;width: 5%;"><%if(mil.getPaymentPercentage()!=null) {%><%=mil.getPaymentPercentage() %><%} else{%>-<%} %></td>
							<td style="width: 20%;"><%=mil.getPaymentTerms() %></td>
						</tr>
					<%}} %>
				</tbody>
				
			</table>
			<br>
			<p style="font-size: 15px;text-indent: 21px;">
				The Contract for Acquisition of Professional Services to be placed on <%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> (CARS) file is submitted with the following documents.
			</p>
			<table id="tabledata">
				<thead>
					<tr>
						<th style="width: 5%;">SN</th>
						<th style="width: 70%;">Description</th>
						<th style="width: 23%;">Reference</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align: center;">1.</td>
						<td>Statement of Case for availing CARS, Research Service Qualitative Requirement</td>
						<td>Annexure A</td>
					</tr>
					<tr>
						<td>2.</td>
						<td>Recommendation of RSQR by CARS Scrutinising Committee</td>
						<td>Annexure B</td>
					</tr>
					<tr>
						<td>3.</td>
						<td>CARS proposal and Summary of Offer from RSP</td>
						<td>Annexure C</td>
					</tr>
					<tr>
						<td>4.</td>
						<td>Recommendation by Group/ Project Director on the response of the academic institution on RSQR</td>
						<td>Annexure D</td>
					</tr>
					<tr>
						<td>5.</td>
						<td>Draft Contract Copy</td>
						<td>Annexure E</td>
					</tr>
				</tbody>	
			</table>
		</div>
		
	</div>
			               		   						
	<div style="">
		<h5 class="socheading"><span>4.</span> <span style="text-decoration: underline;">Approval Sought</span></h5>
		<div class="soccontent">
			<%if(carsSoC!=null && carsSoC.getDPCApprovalSought()!=null && !carsSoC.getDPCApprovalSought().isEmpty()) { %>
				<p style="text-indent: 21px;font-size: 15px;">
					<%=carsSoC.getDPCApprovalSought().replaceAll("\n", "<br>") %>
				</p>
			<%} else{%>
				<p style="text-indent: 21px;font-size: 15px;">
					The case is being submitted along with the above-mentioned documents for obtaining the Concurrence cum 
					Financial sanction and approval from Competent Financial Authority (CFA) for placement of 
					Contract for Acquisition of Research Services (CARS) on <%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> at a cost of Rs. <span class="textunderline"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carsIni.getAmount())) %></span> please.
				</p>
			<%} %>
		</div>
	</div>
	
	<br>
			               		   					
	<!-- Signatures and timestamps -->
			               		   					
	<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 18px;margin-top: 20px;">
     	<div style="font-size: 15px;"> Signature of GH-DP&C</div>
        <%for(Object[] apprInfo : dpcSoCApprovalEmpData){ %>
  			<%if(apprInfo[8].toString().equalsIgnoreCase("SFD")){ %>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
   		<%break;}} %>  
    </div>
							            			 
 	<%for(Object[] apprInfo : dpcSoCApprovalEmpData) {%>
 	    <br>
 		<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 18px;margin-top: 40px;">
 			<%if(apprInfo[8].toString().equalsIgnoreCase("SGD")){ %>
	 			<div style="font-size: 15px;"> Signature of GD-DP&C</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("SPD")) {%> 
				
				<div style="font-size: 15px;"> Signature of PD</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("SCR")) {%> 
				<div style="font-size: 15px;"> Signature of Chairman RPB</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("SMA")) {%> 
				<div style="font-size: 15px;"> Signature of MMFD AG</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDF")) {%> 
				<div style="font-size: 15px;"> Signature of GD DF&MM</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} %>
			<%if(carsIni.getAmount()!=null && Double.parseDouble(carsIni.getAmount())<=1000000) {%>
				<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
					<div style="font-size: 15px;"> Signature of Director</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
					<div style="font-size: 15px;"> Signature of Director</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} %>
			<%} else if(carsIni.getAmount()!=null && (Double.parseDouble(carsIni.getAmount())>1000000 && Double.parseDouble(carsIni.getAmount())<=5000000) ) {%>
				<% if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
					<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
			    	<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
			    	<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
 					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
 					<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
  			    	<div style="font-size: 15px;"> Signature of Director</div>
  			    	<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
   					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
   					<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
			    	<div style="font-size: 15px;"> Signature of Director</div>
			    	<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
 					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
 					<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} %>
			<%} else if(carsIni.getAmount()!=null && (Double.parseDouble(carsIni.getAmount())>5000000 && Double.parseDouble(carsIni.getAmount())<=7500000)) {%>
				<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
					<div style="font-size: 15px;"> Signature of Director</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
					<div style="font-size: 15px;"> Signature of Director</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
					<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
					<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				    <label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				    <label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("ADG")) {%>
					<div style="font-size: 15px;"> Signature of DG (ECS)</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} else if(apprInfo[8].toString().equalsIgnoreCase("DDG")) {%> 
					<div style="font-size: 15px;"> Signature of DG (ECS)</div>
					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
					<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
					<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%} %>
			<%} %>
 		</div>	
 	<%} %>

</body>
</html>