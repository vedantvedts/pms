	<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal,java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Part-I</title>

<%
List<Object[]> costbreak = (List<Object[]>)request.getAttribute("costbreak");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();

Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes"); 
String initiationid = (String) request.getAttribute("initiationid");
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
List<Object[]>DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> ProjectInitiationLabList = (List<Object[]>) request.getAttribute("ProjectInitiationLabList");
Object[]MacroDetails=(Object[])request.getAttribute("MacroDetails");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
List<Object[]>ProcurementList=(List<Object[]>)request.getAttribute("ProcurementList");
List<String>CostList=(List<String>)request.getAttribute("CostList");
%>
<style type="text/css">
/* .executive th{
	padding:10px 5px;
}



.heading{
	font-size: 26px;
}

.heading-color{
	color: #145374;
}

.breiftable {
	border:1px solid black;
	border-collapse : collapse;
}

.breiftable td{
	border:1px solid black;
	border-collapse : collapse;
}

.breiftable-th{
	font-weight: 800;
}

.editor-text span,p,h1,h2,h3,h4,h5,h6{
	font-size: 18px !important;
	font-family: 'Times New Roman', Times, serif !important;
}

.editor-text {
	font-size: 18px !important;
	font-family: 'Times New Roman', Times, serif !important;
}

.editor-text-font{
	font-size : 18px !important;
}

.editor-text span,p{
	font-weight: 500 !important;
}

.executive, .executive th, .executive td {
  border: 1px solid black;
  border-collapse: collapse;
}

.brieftable td,.brieftable th{
	padding: 15px; 
}

.editor-text table{
	width: 450px !important;
	maargin-left:20px !important;
} */
td{
	padding : -13px 5px;
}
p{
text-align:justify !important;
}

 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      
    }     
 
		@page{             
          size: 790px 1050px;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
         /*  border: 2px solid black;  */   
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          @top-right {
          	 content : "Project : <%=ProjectTitle!=null?StringEscapeUtils.escapeHtml4(ProjectTitle): " - " %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=Labcode%>";
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=Labcode%>";
          }     
 }
 .border_black{
 	border : 1px solid black;

 }
 hr{
background:black;
 }
 
 .border-black{
 border:1px solid black !important;
 border-collapse: collapse !important;
 }
 .border-black td th{
 padding:px !important;
 margin: 0px !important;
 }

td>table{
  border:1px solid black;
 border-collapse: collapse;
}
 td table>tbody>tr>td{
 margin-top:20px !important;
  padding:5px !important;
  }
  li{
  text-align: justify;
  }
  
  .mainTD{
 color:#021B79;
 font-weight: 600;
 

}
 </style>

</head>
<body>
	<div style="text-align:center;">
		<h2 style="text-align: center;">Part-I</h2>
		<h3 style="text-align: center;">Micro Details of Project / Programme</h3><hr style="width:80%">
    <table class="border-black" style="margin-left:20px; margin-top:15px;border:1px solid black;border-collapse:collapse;font-family:FontAwesome; width:650px;">
	<tr >
	<td  style="width:300px;text-align: left;padding: 1px !important; border:1px solid plack;"><h4 class="mainTD">&nbsp;1.&nbsp;&nbsp;a.&nbsp;&nbsp; Title of the Project:</h4></td>
	<td align="left" style="border:1px solid plack;"><%=ProjectDetailes[7]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()): " - " %></td>
	</tr>
	<tr style="">
	<td  style="width:300px;text-align: left;padding: 1px !important;border:1px solid plack;"><h4 class="mainTD">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.&nbsp;&nbsp; Short Name or Acronym :</h4></td>
	<td align="left"style="border:1px solid plack;"><%=ProjectDetailes[6]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()): " - "  %></td>
	</tr>
	<tr>
	<td class="mainTD" class="border-black" style="width:300px;padding: 1px !important;text-align: left;"><h4 class="mainTD">&nbsp;2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Title of the Programme:<br>(If the Project is part of a Programme) </h4></td>
	<td class="border-black" align="left"><%=MacroDetails!=null && MacroDetails.length>0 && MacroDetails[13]!=null?StringEscapeUtils.escapeHtml4(MacroDetails[13].toString()):"-" %></td>
	</tr>
	</table>
	<h1 class="break"></h1>
	<table  style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align:left;">
	<h4 class="mainTD">3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Objective:</h4>	
	</td>
	</tr>
	<tr>
	<td style="width:650px;text-align:left;">
   <%						if(!DetailsList.isEmpty()){
												for (Object[] obj : DetailsList) {
													if (obj[1] != null) {%>
													<% if(obj[1].toString().trim().length()==0){%>
													<p align="center"> Not Mentioned</p>
													<%}else {
												%>
												<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>
												<%}}}}else{ %>
												<p align="center">Not Mentioned</p>
												<%} %>
    </td>
	</tr>
	<tr>
	<td style="width:650px;text-align:left;">
	<h4 class="mainTD">4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scope:</h4>	
	</td>
	</tr>
		<tr>
	<td style="width:650px;text-align:left;">
     <%	if(!DetailsList.isEmpty()){for (Object[] obj : DetailsList) {
		if (obj[2] != null) {%><% if(obj[2].toString().trim().length()==0){%>
		<p align="center"> Not Mentioned</p><%}else {%><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%><%}}}}else{ %>
		<p align="center">Not Mentioned</p><%} %>
    </td>
	</tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4 class="mainTD">5.&nbsp;&nbsp;&nbsp;&nbsp;Proposed project deliverables: 
	</h4></td>
	<td></td>
	</tr>
	</table>
	<div style="margin-left:50px;">
	
		<%if(MacroDetails!=null && MacroDetails.length>0 && MacroDetails[14]!=null){ %><%=StringEscapeUtils.escapeHtml4(MacroDetails[14].toString())%>
		<%}else{ %><p>Not Specified</p><%} %>
	</div>


	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4 class="mainTD">6.&nbsp;&nbsp;&nbsp;&nbsp;Is it a Multi-lab Project?  
	</h4></td>
	<td >
	<%if (ProjectDetailes[11] != null && ProjectDetailes[11].toString().equalsIgnoreCase("Y")) {%>Yes<%} else {%>No<%}%>
	</td>
	</tr>
	
	</table>
	<table style="margin-left:20px; margin-top:0px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align: left;"><h4 class="mainTD">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Participating Labs Name - </h4></td>
	</tr>
 <tr><td align="justify"><h5><%int count = 1;
 	if (!ProjectInitiationLabList.isEmpty()) {
	for (Object[] obj : ProjectInitiationLabList) {
	count++;%>
	<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "+"("+obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "+")" %><%if(count<ProjectInitiationLabList.size()){ %>,<%} %>
	<%}} %>					
 </h5></td></tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:300px;text-align: left;"><h4 class="mainTD">7.&nbsp;&nbsp;&nbsp;&nbsp;Specify the User  </h4></td>
	<td>
	<%if(ProjectDetailes[22]!=null){%>
		<%=StringEscapeUtils.escapeHtml4(ProjectDetailes[22].toString()) %>
	<%}else{ %>Not Specified<%}%>
	</td>
	</tr>
	</table>
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome;width:700px ">
	<tr>
	<td style="text-align: left;"><span class="mainTD">8.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Specify the proposed LSI / DcPP/ PA or selection methodology 
 </h4></td>
	</tr>
	<tr colspan="1">
	<td style="padding: 7px;">
	<%if(MacroDetails.length!=0){ %>
	<%if(MacroDetails[3]!=null){ %><div><%=StringEscapeUtils.escapeHtml4(MacroDetails[3].toString())%></div><%}else{ %> <p>Not Specified</p> <%} %>
	<%}else{ %>
	<p>Not Specified</p>
	<%} %>
	</td>
	</tr>
	<tr>
	<td style="width:300px;text-align: left;"><span class="mainTD">9. PDC of Main Project -</span> 	<%if(MacroDetails.length != 0 && MacroDetails[12]!= null) { String[]temp = MacroDetails[12].toString().split("-");String datetemp = temp[2]+"-"+temp[1]+"-"+temp[0];%><%=datetemp!=null?StringEscapeUtils.escapeHtml4(datetemp): " - "%><%}else{%>Not Specified <%}%>
	</td>
	
	</tr>
	</table>
	
	 <%
  
 double totalcost = costbreak.stream().mapToDouble(e-> Double.parseDouble(e[0].toString())).sum();
 if(ProjectDetailes[21]!=null && ProjectDetailes[21].toString().equalsIgnoreCase("1") ||
		 ProjectDetailes[21].toString().equalsIgnoreCase("2")|| ProjectDetailes[21].toString().equalsIgnoreCase("4") ||
		 ProjectDetailes[21].toString().equalsIgnoreCase("6") ||ProjectDetailes[21].toString().equalsIgnoreCase("7") ||
		 ProjectDetailes[21].toString().equalsIgnoreCase("8")){ 
		 
		 
	  double transportation=0; 
	  double Equipment = 0;
	  double CARSCAPSI =0;
	  double Consultancy=0;
	  double TechnicalServices=0;
	  double HiringofTransport=0;
	  double ProjectVehicles=0;
	  double Miscellaneous=0;
	  double PlantMachinery=0;
	  double ProjectrelatedVehicles=0;
	  double Works=0;
	  
	  double FEtransportation=0; 
	  double FEEquipment = 0;
	  double FECARSCAPSI =0;
	  double FEConsultancy=0;
	  double FETechnicalServices=0;
	  double FEHiringofTransport=0;
	  double FEProjectVehicles=0;
	  double FEMiscellaneous=0;
	  double FEPlantMachinery=0;
	  double FEProjectrelatedVehicles=0;
	  double FEWorks=0;
	  for(Object[] obj:costbreak){
	  
	   if(obj[3].toString().contains("Consultancy ")){
		   Consultancy+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEConsultancy+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Fuel")){
		   ProjectVehicles+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectVehicles+=Double.parseDouble(obj[0].toString()); }
	  } 
	 if(obj[3].toString().contains("CAPSI")){
		 CARSCAPSI+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FECARSCAPSI+=Double.parseDouble(obj[0].toString()); }
	  } 
	 
	    if(obj[3].toString().contains("Equipment")){
	    	Equipment+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEEquipment+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Miscellaneous")){
		   Miscellaneous+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEMiscellaneous+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Hiring")){
		   HiringofTransport+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEHiringofTransport+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Jobwork")){
		   TechnicalServices+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FETechnicalServices+=Double.parseDouble(obj[0].toString()); }
	  } 
	if(obj[3].toString().contains("Machinery")){
		PlantMachinery+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEPlantMachinery+=Double.parseDouble(obj[0].toString()); }
	  } 
	    if(obj[3].toString().contains("Project related Vehicles")){
	    	ProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectrelatedVehicles+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Transportation")){
		   transportation+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEtransportation+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Works")){
		   Works+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEWorks+=Double.parseDouble(obj[0].toString()); }
	  }  
			}
		 
		 
		 %>

 		<table class="border-black" style="margin-top:10px; margin-bottom: 10px;margin-left: 10px;width:670px;  " id="cost">
		  <thead>
		  		  	<tr style=" border:0px !important;">
				<td style="width: 650px; text-align: left;  border:0px !important;"><h4 class="mainTD">
				10. Breakup of Cost (&#8377; in Cr.):
				</h4></td></tr>
			  	<tr> 
				  	 <th colspan="5" class="border_black weight_700 center">
				 		 	 Cost Break-Up Table for MM, TD, UT & IF Projects  <br> (in &#x20B9; Lakhs.)
				  	</th>
			  	</tr>
			  	<tr>
			  		<th rowspan="2" class="border_black weight_700 center"> Minor Head </th>
			  		<th class="border_black weight_700 center" > Major Head 4076 - Revenue </th>
			  		<th class="border_black weight_700 center"> Nodal  Lab</th>
			  		<th class="border_black weight_700 center"> Participating <br> Lab, if any</th>
			  		<th rowspan="2" class="border_black weight_700 center"> Total  (FE) </th>
			  	</tr>
			  	<tr>
			  		<th class="border_black weight_700 center"> Heads of Expenditure </th>
			  		<th class="border_black weight_700 center"> Total (FE) </th>
			  		<th class="border_black weight_700 center"> Total (FE)</th>
			  	</tr>
		  </thead>
		  
		  <tbody>
				  	<tr>	
				  		<td class="border-black" rowspan="10">052 <br>(Code Head-929/25)*</td>	
				  		<td class="border-black" style="padding:12px;"> Transportation (Movement of Stores)</td>
				  		<td class="border-black" style="text-align:right;font-size: 13px;"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
				  		<td class="border-black" align="right"style="font-size: 13px">0.00</td>
				  		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000) %>)</td>
				   </tr>
				   <tr>
				   		<td class="border-black" style="padding-top:20px;padding-bottom: 20px;"> Equipment/Stores</td>
				   		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Equipment/100000)%><br>(<%=nfc.convert(FEEquipment/100000)%>)</td>
				  		<td class="border-black" align="right" style="font-size: 13px">0.00</td>
				  		<td class="border-black" style="text-align:right;font-size: 13px">(<%=nfc.convert(Equipment/100000)%><br>(<%=nfc.convert(FEEquipment/100000)%>)</td>
				   </tr>	 	
				  <tr>
				 		<td class="border-black"  style="padding:12px;"> CARS/CAPSI </td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(CARSCAPSI/100000)%>)<br>(<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  		<td class="border-black"  align="right" style="font-size: 13px">0.00</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(CARSCAPSI/100000)%><br>(<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  </tr>
				  <tr>
				 		<td class="border-black"  style="padding:12px;"> Consultancy Contracts </td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(Consultancy/100000)%><br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  		<td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(Consultancy/100000)%><br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  </tr> 
				  <tr>
				  		<td class="border-black"  style="padding:12px;"> Job Work/Contracts/Technical Services</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(TechnicalServices/100000)%><br>(<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  		<td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(TechnicalServices/100000)%><br>(<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  </tr>

				  <tr>
				 	 <td class="border-black"  style="padding:12px;"> Hiring of Transport </td>
				 	 <td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(HiringofTransport/100000)%><br>(<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				  	 <td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				  	 <td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(HiringofTransport/100000)%><br>(<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				 </tr>
				 <tr>
				 	<td class="border-black"  style="padding:12px;"> Fuel/Oil/Lubricants for Project Vehicles</td>
				 	<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectVehicles/100000)%><br>(<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				  	<td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				    <td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectVehicles/100000)%><br>(<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				 </tr>	
				  <tr>
				 	<td class="border-black"  style="padding:12px;"> Contingency & Miscellaneous</td>
				 	<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(Miscellaneous/100000)%><br>(<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Miscellaneous/100000)%><br>(<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				 </tr>	 
				 <tr>
				  	<td  class="border-black" style="padding:12px;"> Plant & Machinery</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(PlantMachinery/100000)%><br>(<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(PlantMachinery/100000)%><br>(<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				</tr>
			    <tr>
			  		<td  class="border-black" style="padding:12px;"> Project related Vehicles </td>
			  		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectrelatedVehicles/100000)%> <br>(<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectrelatedVehicles/100000)%><br>(<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
			  	</tr>
			  	 <tr>
			  		<td  class="border-black" style="padding:12px;"> 111 </td>
			  		<td class="border-black" > Works</td>
			  		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Works/100000)%><br>(<%=nfc.convert(FEWorks/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Works/100000)%><br>(<%=nfc.convert(FEWorks/100000)%>)</td>
				  	
			  	</tr>
			  	<tr>
			  		<td colspan="2" class="border-black"style="padding:12px;" > Total </td>
			  		<td style="text-align:right;font-size: 13px"class="border-black "><%=nfc.convert(totalcost/100000)%><br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td>
			  		<td class="border-black"  align="right" style="font-size: 13px">0.00</td>
			  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(totalcost/100000)%><br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td></td>
			  	</tr>
		  </tbody>
 </table>
 	
 <h1 class="break"></h1>
  <%}%>
  <%if(ProjectDetailes[21]!=null && ProjectDetailes[21].toString().equalsIgnoreCase("3") ||
		  ProjectDetailes[21].toString().equalsIgnoreCase("5")){
		 
		  double grandtotal = costbreak.stream().mapToDouble(e-> Double.parseDouble(e[0].toString())).sum();
		  double transportation=0; 
		  double Equipment = 0;
		  double CARS =0;
		  double CAPSI=0;
		  double Consultancy=0;
		  double TechnicalServices=0;
		  double HiringofTransport=0;
		  double ProjectVehicles=0;
		  double Miscellaneous=0;
		  double PlantMachinery=0;
		  double ProjectrelatedVehicles=0;
		  double Works=0;
		  double CapWorks=0;
		  
		  double FEtransportation=0; 
		  double FEEquipment = 0;
		  double FECARS =0;
		  double FECAPSI=0;
		  double FEConsultancy=0;
		  double FETechnicalServices=0;
		  double FEHiringofTransport=0;
		  double FEProjectVehicles=0;
		  double FEMiscellaneous=0;
		  double FEPlantMachinery=0;
		  double FEProjectrelatedVehicles=0;
		  double FEWorks=0;
		  double FECapWorks=0;
		  for(Object[] obj:costbreak){ 

				/*  capital part start*/
				if(obj[3].toString().contains("Machinery")){
					PlantMachinery+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FEPlantMachinery+=Double.parseDouble(obj[0].toString());}
				}
				
				if(obj[3].toString().contains("Project related Vehicles")){
					ProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());}
				}
				
				if(obj[3].toString().contains("Works") && obj[4].toString().equalsIgnoreCase("4076")){
					CapWorks+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FECapWorks+=Double.parseDouble(obj[0].toString());}
				}
				/*  capital part end */ 
				
				/*revenue start  */
				
				if(obj[3].toString().contains("CAPSI")){
					CAPSI+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FECAPSI+=Double.parseDouble(obj[0].toString());}
				}
				
				if(obj[3].toString().contains("CARS")){
					CARS+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FECARS+=Double.parseDouble(obj[0].toString());}
				}
				   if(obj[3].toString().contains("Consultancy ")){
					   Consultancy+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEConsultancy+=Double.parseDouble(obj[0].toString()); }
				  } 
				
				   if(obj[3].toString().contains("Fuel")){
					   ProjectVehicles+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectVehicles+=Double.parseDouble(obj[0].toString()); }
				  } 
				   
				   if(obj[3].toString().contains("Equipment")){
				    	Equipment+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEEquipment+=Double.parseDouble(obj[0].toString()); }
				  } 
				   if(obj[3].toString().contains("Hiring")){
					   HiringofTransport+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEHiringofTransport+=Double.parseDouble(obj[0].toString()); }
				  } 
				  
				   if(obj[3].toString().contains("Jobwork")){
					   TechnicalServices+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FETechnicalServices+=Double.parseDouble(obj[0].toString()); }
				  } 
				   if(obj[3].toString().contains("Transportation")){
					   transportation+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEtransportation+=Double.parseDouble(obj[0].toString()); }
				  } 
				   if(obj[3].toString().contains("Miscellaneous")){
					   Miscellaneous+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEMiscellaneous+=Double.parseDouble(obj[0].toString()); }
				  }
				   if(obj[3].toString().contains("Works") && obj[4].toString().equalsIgnoreCase("2080")){
					   Works+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEWorks+=Double.parseDouble(obj[0].toString()); }
				   } 
		  }
			 
		 
		 
		 %>  
			 
  <table class="border-black" style="margin-top:10px; margin-bottom: 10px;margin-left: 10px;width:670px;  " id="cost">
		  <thead>
		  	 	<tr style=" border:0px !important;">
				<td style="width: 650px; text-align: left; border:0px !important;"><h4 class="mainTD">
				10. Breakup of Cost (&#8377; in Cr.):
				</h4></td></tr>
			  	<tr> 
				  	 <th colspan="5" class="border_black weight_700 center">
				  	 		Cost Break-up Table for S&T & PS Projects  <br> (in &#x20B9; Lakhs.) 
				  	</th> 
			  	</tr>
			  	<tr>
			  		<th rowspan="2" class="border_black weight_700 center"> Minor Head </th>
			  		<th class="border_black weight_700 center" > Major Head 2080 - Capital <br> Sub Major Head - 05 </th>
			  		<th class="border_black weight_700 center"> Nodal <br> Lab</th>
			  		<th class="border_black weight_700 center"> Participating <br> Lab, if any</th>
			  		<th class="border-black" rowspan="2"> Total <br> (FE) </th>
			  	</tr>
			  	<tr>
			  		<th class="border_black weight_700 center"> Heads of Expenditure </th>
			  		<th class="border_black weight_700 center"> Total (FE) </th>
			  		<th class="border_black weight_700 center"> Total (FE)</th>
			  	</tr>
		  </thead>
		  
		  <tbody>
			  	<tr>
			  		<td class="border-black"> 105</td>
			  		<td class="border-black" style="padding:12px;"> Transportation (Movement of Stores) </td>
			  		<td class="border-black"  style="text-align:right;font-size:13px;"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
			  		<td class="border-black" style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black" style="text-align:right;font-size:13px; "><%=nfc.convert(transportation/100000)%> <br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
			  	</tr>
			  	
			  	<tr>
			  		<td class="border-black" rowspan="7"> 110 <br> (Code Head - <br>856/01)**</td>
			  		<td class="border-black"style="padding:12px;"> Equipment/Stores </td>
			     	<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(Equipment/100000)%><br> (<%=nfc.convert(FEEquipment/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Equipment/100000)%><br> (<%=nfc.convert(FEEquipment/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td class="border-black" style="padding:12px;"> CARS</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CARS/100000)%><br> (<%=nfc.convert(FECARS/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CARS/100000)%><br> (<%=nfc.convert(FECARS/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> CAPSI</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CAPSI/100000)%><br> (<%=nfc.convert(FECAPSI/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CAPSI/100000)%><br> (<%=nfc.convert(FECAPSI/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> Consultancy Contracts </td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Consultancy/100000)%><br> (<%=nfc.convert(FEConsultancy/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Consultancy/100000)%> <br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> Job Work/Contracts/Hiring of <br>Technical Services</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(TechnicalServices/100000)%><br> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(TechnicalServices/100000)%><br> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>

			  	</tr> 
				<tr>
			  		<td class="border-black"style="padding:12px;font-size:13px;"> Hiring of Transport,  <br>Fuel/Oil/Lubricants for Project <br> Vehicles</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((ProjectVehicles+HiringofTransport)/100000)%><br> (<%=nfc.convert((FEProjectVehicles+FEHiringofTransport)/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((ProjectVehicles+HiringofTransport)/100000)%><br> (<%=nfc.convert((FEProjectVehicles+FEHiringofTransport)/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;">Contingency & Miscellaneous</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Miscellaneous/100000)%><br> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Miscellaneous/100000)%><br> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>

			  	</tr>
			  	<tr>
			 	 	<td class="border-black"> 111</td>
			  		<td class="border-black"style="padding:12px;"> Works</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Works/100000)%><br> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Works/100000)%><br> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;" colspan="2" class="border_black"> Total (Revenue)</td>
			  	    <td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((transportation + Equipment + CARS +HiringofTransport+ CAPSI + Consultancy + TechnicalServices + ProjectVehicles + Miscellaneous + Works)/100000)%> 
			  	 <br> (<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+FEHiringofTransport)/100000)%>)</td>	
			  		<td class="border-black"style="text-align:right;font-size:13px;">0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((transportation + Equipment + CARS + CAPSI + Consultancy + TechnicalServices + ProjectVehicles + Miscellaneous + Works)/100000)%> 
			  		<br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+FEHiringofTransport)/100000)%>)</td>
			  	</tr>
			  	<tr>
			 	 	<td class="border-black"rowspan="3"> 052 <br>(Code Head - <br>929/24)*** </td>
			  		<td class="border-black"style="padding:12px;"> Plant & Machinery </td>
			  		<td class="border-black"rowspan="2" style="font-size:13px;;text-align:right;"> <%=nfc.convert((PlantMachinery + ProjectrelatedVehicles)/100000) %> <br>(<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles)/100000) %>)</td>
			  		<td class="border-black"rowspan="2" style="font-size:13px;text-align:right;">0.00</td>
			  		<td class="border-black"rowspan="2" style="text-align:right;font-size:13px;"> <%=nfc.convert((PlantMachinery + ProjectrelatedVehicles)/100000) %><br> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles)/100000) %>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black" style="padding:12px;"> Project related Vehicles </td>
			  		
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> Works </td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(CapWorks/100000) %><br> (<%=nfc.convert(FECapWorks/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(CapWorks/100000) %><br> (<%=nfc.convert(FECapWorks/100000)%>)</td>
			  	</tr>
			  	
			  	
			  	
			  	<tr>
			  		<td class="border-black"style="padding:12px;"colspan="2" class="border_black"> Total (Capital)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((PlantMachinery + ProjectrelatedVehicles+CapWorks)/100000)%><br> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles + FECapWorks)/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;">0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((PlantMachinery + ProjectrelatedVehicles+CapWorks)/100000)%> <br>(<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles + FECapWorks)/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"colspan="2" class="border_black "> Grand Total (Revenue & Capital)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(grandtotal/100000)%> <br>  (<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+ FEPlantMachinery + FEProjectrelatedVehicles+FECapWorks+FEHiringofTransport)/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(grandtotal/100000)%></td>
			  	</tr>
		  </tbody>
  
 </table>
  <h1 class="break"></h1>
  <%}%>			
	
	
	<table>
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;"><h4 class="mainTD">11.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Additional requirement of mechanical transport vehicles specific to the 
	project, for equipment/developed systems and stores (with justifications): 
 	</h4></td>
	</tr>
		<tr>
	<td style="width:650px; ">
	<%if(MacroDetails.length!=0){ %>
	<%if(MacroDetails[2]!=null){ %><%=StringEscapeUtils.escapeHtml4(MacroDetails[2].toString())%><%}else { %> 	<p style="text-align: center;">Not Specified</p> <%} %>
	<%}else{ %>
	<p>Not Specified</p>
	<%} %>
	</td>
	</tr>
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;"><h4 class="mainTD">12.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Proposed Six monthly milestones along-with financial outlay (&#8377; in Cr):
 	</h4></td>
	</tr>
	</table>	
			<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;margin-top:15px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:8%;text-align: center;">SN</th>
								<th class="border-black" style="width:10%;text-align: center;">Time<br>(Months)</th>
								<th class="border-black" style="width:50%;text-align: center;">Six Monthly Technical Milestone</th>
								<th class="border-black" style="width:25%;text-align: center;">Financial Outlay <br>&nbsp;(&#8377; in Lakhs.)</th>
								</tr>
							</thead>
							<tbody >
							<%/* int i=0; */
							if(ScheduleList.isEmpty()){%>
							<tr class="border-black"><td colspan="3" align="center"><h5>Please add Schedule for the project in Project Initiation</h5><td></tr>
							<%}else{
							int monthDivision=Integer.parseInt(ProjectDetailes[9].toString())%6==0?Integer.parseInt(ProjectDetailes[9].toString())/6:Integer.parseInt(ProjectDetailes[9].toString())/6+1;
							
							for(int i=0;i<monthDivision;i++){
							%>
							<tr >
							<td class="border-black" style="text-align: center;"><h5 style="font-weight: 500"><%=i+1%></h5></td>
							<td class="border-black" style="text-align: center;"><h5 style="font-weight: 500"><%="T0 + "+(i+1)*6%></h5></td>
						
							<td class="border-black" style="text-align: left;"><h5 style="font-weight: 500">
								<%for(Object[]obj:ScheduleList) {
								int milstonetotalMont = Integer.parseInt(obj[6].toString());
								if( milstonetotalMont>((i)*6) && milstonetotalMont<=((i+1)*6) ){
								%>
						<%-- 		boolean case1=Integer.parseInt(obj[5].toString())<=i;
								boolean case2=Integer.parseInt(obj[6].toString())>=((i*6)+1);
								boolean case3=Integer.parseInt(obj[6].toString())>((i+1)*6);
								boolean case4=case2&&Integer.parseInt(obj[6].toString())<((i+1)*6);
								boolean case5=Integer.parseInt(obj[5].toString())>=monthDivision;
								if(case1&&(case2||case3)){
								%>
								<%=obj[1].toString() %><br>
								<%}else if(case5 &&case4){%>
								<%=obj[1].toString() %><br>
								<%} %> --%>
								<div><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></div>
								
								<%}}%>
							</h5>	</td>
								<td class="border-black" id="td<%=i+1%>" align="right">
								<%for(Object[]obj:ScheduleList) {
								int milstonetotalMont = Integer.parseInt(obj[6].toString());
								if( milstonetotalMont>((i)*6) && milstonetotalMont<=((i+1)*6) ){
								%>
								
								<p style="text-align: right !important;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[9].toString()))) %></p>
								<%}}%>
								
								</td>
								</tr>
								<%}} %>
						
							</tbody>
						</table>  
	<table style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr>
	<td style="width:650px;text-align: left;margin-top: 20px;">
	<h4 class="mainTD">
	13.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Procurement Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	</td>
	</tr>
	</table>
	
			  <table class="border-black" style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
		 								<thead style="background: #055C9D;color: black; font-size: 13px;">
								<tr>
								<th class="border-black" style="width:2%;text-align: center;">SN</th>
								<th class="border-black" style="width:14%;text-align: center; ">Name of the item/ Service</th>
									<th class="border-black" style="width:30%;text-align: center;">Description/Purpose </th>
								<th class="border-black" style="width:15%;text-align: center;">Source</th>
								<th class="border-black" style="width:10%;text-align: center;">Mode of tendering</th>
								<th class="border-black" style="width:6%;text-align: center;">Expected cost</th>
								<th class="border-black" style="width:10%;text-align: center;">ETS<br>( Months )</th>
										<th class="border-black" style="width:10%;text-align: center;">ED<br>( Months )</th>
								</tr>
							</thead>
							<tbody>
							<%int i=0;
							if(!ProcurementList.isEmpty()) {
							for(Object[]obj:ProcurementList){
							%><tr style="font-size: 13px;">
							<td class="border-black" style="width:2%;text-align: center;padding: 5px;"><%=(++i) %></td>
							<td class="border-black" style="width:2%;text-align: center;padding: 5px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
							<td class="border-black" style="width:2%;text-align: center; padding:10px;" ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></td>
							<td class="border-black" style="width:2%;text-align: center;padding: 5px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
							<td class="border-black" style="width:2%;text-align: center;padding: 5px;"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
							<td class="border-black" style="width:2%;text-align: right;padding: 5px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[6].toString()))/10000000)%></td>
							<td class="border-black" style="width:2%;text-align: center;padding: 5px;"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %></td>
							<td class="border-black" style="width:2%;text-align: center;padding: 5px;"><%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %></td>
							</tr>
							<%}} %>
							</tbody>
		  </table>
		  <table class="border-black" style="margin-left:20px; border-top:none solid white;font-size:15px;font-family:FontAwesome; width:650px;">					
		 				<thead style="background: #055C9D;color: black; font-size: "> 
						<tr>
						<td class="border-black" style="width:650px;text-align: left;padding: 5px;">
						<h5>ETS-Expected Date of Tendering / Placing of SO&nbsp;, &nbsp;ED-Expected date of Delivery</h5>  </td>
						</tr>
						</thead>
		 </table>
	<table id="a1" style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:650px;">
	<tr  style="font-size: 13px;">
	<td style="width:650px;text-align: left;margin-top: 20px;"><h4 class="mainTD">
	14.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Details of Demand approvals required 
	</h4></td>
	</tr>		
	</table>			
			<table  id="mytable" class="border-black"
							style="width: 650px; margin-left:20px;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: black;">
								<tr>
								<th class="border-black" style="width:5%;text-align: center;">SN</th>
								<th class="border-black" style="width:30%;text-align: center;">Name</th>
								<th class="border-black" style="width:30%;text-align: center;">source</th>
								<th class="border-black" style="width:10%;text-align: center;">Mode</th>
								<th class="border-black" style="width:10%;text-align: center;">cost<br>&nbsp;(&#8377; in Cr.)</th>
								</tr>
							</thead>
								<tbody >
							<% int j=1;
							if(ProcurementList.isEmpty()){%>
							<tr class="border-black"><td colspan="4" align="center"><h4>Please add Procurement plan for this project</h4><td></tr>
							<%}else{
							for(Object[]obj:ProcurementList){	
							%>	
							<tr>
							<td class="border-black" style="padding:px;"><%=j %></td>
							<td class="border-black"style="padding:px;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
							<td class="border-black"style="padding:px;"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
							<td class="border-black"style="padding:px;"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
							<td class="border-black"style="padding:px;"><%=nfc.convert(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[6].toString()))/10000000)%></td>
							</tr>
							<%
							j++;}
							}%>
							</table>	
			<table style="margin-left:20px; margin-top:25px; border:0px solid black;font-family:FontAwesome; width:650px;">
			<tr>
				<td style="width: 650px; text-align: left; margin-top: 20px;"><h4 class="mainTD">
						15.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Any other information:
						</h4></td>
			</tr>
			<tr>
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length != 0) {
					%> <%
 					if (MacroDetails[4] != null) {
 					%><%=StringEscapeUtils.escapeHtml4(MacroDetails[4].toString())%>
					<%
					}else{
					%> 
					<p>Not Specified</p>
 					<%} }else {%>
					<p>Not Specified</p>
					 <%}%>
 					
				</td>
			</tr>
		</table>
					<table style="margin-left:20px; margin-top:25px; border:0px solid black;font-family:FontAwesome; width:650px;">
			<tr>
				<td style="width: 650px; text-align: left; margin-top: 20px;"><h4 class="mainTD">
					16.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; List of enclosures: 
						</h4></td>
			</tr>
			<tr>
				<td style="width: 650px; text-align: left;">
					<%
					if (MacroDetails.length != 0) {
					%> <%
 					if (MacroDetails[5] != null) {
 					%><%=StringEscapeUtils.escapeHtml4(MacroDetails[5].toString())%>
					<%
					}else{
					%> 
					<p>Not Specified</p>
 					<%} }else {%>
					<p>Not Specified</p>
					 <%}%>
 					
				</td>
			</tr>
		</table>	
		<table style="margin-left:20px; margin-top:25px; border:0px solid black;font-family:FontAwesome; width:650px;">
		<tr><td style="width: 650px; text-align: left; margin-top: 20px;">
			<p style="font-weight: bold;;" class="mainTD">17.It is certified that this technology is not available in India and the selected industry DCPP is not in negative list of Vendors</p>
			</td></tr>
		
			</table>
			<div style="margin-left: 50px;"> 	<%if(MacroDetails!=null && MacroDetails.length>0 && MacroDetails[15]!=null){ %> <%=StringEscapeUtils.escapeHtml4(MacroDetails[15].toString()) %> <%} %></div>
			<br></br>	
			<h4 style="width:35%;margin-left:10px;"><%=ProjectDetailes[1]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[1].toString()): " - "  %><hr style="padding-bottom: 0px;">
			</h4><h4 style="text-align:left;margin-left: 80px;margin-top:0px;"> Project Director </h4>


	</div>
</body>
</html>