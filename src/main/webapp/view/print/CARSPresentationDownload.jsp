<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CARS Presentation</title>
<style type="text/css">
#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
}  
@page {             
      size: 1220px 850px; 
      margin-top: 50px;
      margin-left: 40px;
      margin-right: 40px;
      margin-buttom: 50px; 	
      border: 1px solid black;
      
      @bottom-left {          		
	      content : "";
	      margin-bottom: 30px;
	      margin-right: 5px;
	      font-size: 10px;
      }
      @bottom-right {          		
	      content: "Page " counter(page) " of " counter(pages);
	      margin-bottom: 30px;
	      margin-right: 10px;
      }
      @top-left {          		
	      content: "";
	      margin-left: 80px;
	      margin-top: 30px;
      }
      @top-center {          		
	      content: "";
	       margin-top: 30px;
      }
      @top-right {          		
	      content: "";
	      margin-top: 30px;
	      margin-right: 50px;
      }
          
          
 }
 .border
 {
 	border: 1px solid black;
 }


p{
  text-align: justify;
  text-justify: inter-word;
}

.break
{
	page-break-after: always;
	margin: 25px 0px 25px 0px;
}


.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}
.firstpagefontfamily  {
	font-family: 'Muli' !important;
}

.data-table{
	margin-left : 10px;
	margin-right : 10px;
	margin-top : 10px;
	border-collapse : collapse;
	border : 1px solid black;
	width : 100%;
}  

.data-table tbody{
	font-size: 1rem;
}

.data-table th{
	text-align : center;
	font-size: 1.1rem;
	padding: 7px;
}
.data-table td{
	padding: 5px;
}

.data-table td,th{
	border : 1px solid black;
	padding : 7px;
}


.heading {
	font-size: 1.5rem !important;
} 

span {
	font-weight: bold;
}

input,select,table,div,label,span,button {
	font-family : "Lato", Arial, sans-serif !important;
	font-size: 1rem ;
} 

.home-table th{
	border: none;
}

.cssideheading {
	font-weight: 800;
    color: #ed4f10;
}
</style>

</head>
<body>
	<%
		LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
		String lablogo = (String)request.getAttribute("lablogo");
		List<Object[]> initiationList = (List<Object[]>)request.getAttribute("initiationList");
		List<CARSContract> allCARSContractList = (List<CARSContract>)request.getAttribute("allCARSContractList");
		List<CARSSoCMilestones> allCARSSoCMilestonesList = (List<CARSSoCMilestones>)request.getAttribute("allCARSSoCMilestonesList");
		List<Object[]> allMilestoneProgressList = (List<Object[]>)request.getAttribute("allMilestoneProgressList");
		
		FormatConverter fc = new FormatConverter();
	%>
	
	<!-- ----------------------------------------  P-0  Div----------------------------------------------------- -->
	<div class="firstpage"  > 
		
		<div class="mt-2" align="center"><h2 style="color: #145374 !important;">Presentation</h2></div>
		<div align="center" ><h2 style="color: #145374 !important;">of</h2></div>
				
		<div align="center" >
			<h2 style="color: #145374 !important;" >CARS Projects</h2>
   		</div>
		
		<div align="center" ><h2 style=" color: #145374 !important;"></h2></div>
		
		<table class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border: none;  font-size: 16px;"  >
			<tr>			
				<th colspan="8" style="text-align: center; font-weight: 700;">
					<img class="logo" style="width:120px;height: 120px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
					<br>
				</th>
			</tr>
		</table>	
		<br><br><br><br>

		<br><br><br><br><br>
		<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;font-weight: bold;"  >
			<% if(labInfo!=null){ %>
				<tr>
					<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: bolder;font-size: 22px"> <h2 style="color: #145374 !important;font-weight: bolder;"> <%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %> ( <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %> ) </h2> </th>
				</tr>
			<%}%>
			<tr>
				<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px">Government of India, Ministry of Defence</th>
			</tr>
			<tr>
				<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px">Defence Research & Development Organization</th>
			</tr>
			<tr>
				<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %>, <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
			</tr>
		</table>
	</div>
	<!-- ----------------------------------------  P-0  Div End----------------------------------------------------- -->
			
	<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->
	
	<h1 class="break"></h1>
		
	<table class="data-table">
   		<thead>
   			<tr>
   				<th colspan="6" class="center">CARS List</th>
   			</tr>
        	<tr>
            	<th style="width: 3%;">SN</th>
            	<th style="width: 22%;">CARS No</th> 
            	<th style="width: 40%;">Title</th>
             	<th style="width: 10%;">Funds From</th>
              	<th style="width: 15%;">Duration (Months)</th>
               	<th style="width: 10%;">Cost (Lakhs)</th>
         	</tr>
		</thead> 
     	<tbody>
          	<%if(initiationList!=null && initiationList.size()>0) {
          		int slno = 1;
          		for(Object[] obj : initiationList) {
          			String amount = String.format("%.2f", Double.parseDouble(obj[20]!=null?obj[20].toString():obj[13].toString())/100000);
          	%>
           		<tr>
           			<td class="center"><%=slno %></td>
                    <td class="center"><%=obj[2]!=null?obj[2]:"-" %></td>
                    <td class="left"><%=obj[4]!=null?obj[4]:"-" %></td>
                    <td class="left"><%=obj[18]!=null?obj[18]:"-" %></td>
                    <td class="center"><%=obj[8]!=null?obj[8]:"-"  %></td>
                    <td class="right"><%=amount %></td>
           		</tr>
           	<%++slno;} }%>
    	</tbody>
   	</table>
			
	<!-- ----------------------------------------  P-1  Div End----------------------------------------------------- -->
	
	<!-- ----------------------------------------  Presentation of CARS Projects Div ----------------------------------------------------- -->
	<%if(initiationList!=null && initiationList.size()>0) {
		int slno = 0;
		for(Object[] obj : initiationList) {
			String carsInitiationId = obj[0].toString();
			String amount = String.format("%.2f", Double.parseDouble(obj[20]!=null?obj[20].toString():obj[13].toString())/100000);
			
			// Contract Data
			CARSContract carsContract = allCARSContractList!=null && allCARSContractList.size()>0?allCARSContractList.stream().filter(e -> e.getCARSInitiationId()==Long.parseLong(carsInitiationId)).findFirst().orElse(null):null;
			// Milestones Data
			List<CARSSoCMilestones> milestones = allCARSSoCMilestonesList!=null && allCARSSoCMilestonesList.size()>0? allCARSSoCMilestonesList.stream().filter(e -> e.getCARSInitiationId()==Long.parseLong(carsInitiationId)).collect(Collectors.toList()) : new ArrayList<CARSSoCMilestones>(); 
			// Milestones Progress Data
			List<Object[]> milestoneProgressList = allMilestoneProgressList!=null && allMilestoneProgressList.size()>0? allMilestoneProgressList.stream()
					.filter(e -> Long.parseLong(e[6].toString())==Long.parseLong(carsInitiationId)).collect(Collectors.toList()) : new ArrayList<Object[]>();
	%>
		<h1 class="break"></h1>
		
		<table class="data-table">
			<tr>
   				<th colspan="6" class="center"><%=obj[2] %></th>
   			</tr>
			<tr>
				<td colspan="3">
					<span class="cssideheading">Title:</span>&emsp;
             		<span class="cssideheadingdata"><%=obj[4]!=null?obj[4]:"-"  %></span>
				</td>
			</tr>
			<tr>
				<td>
					<span class="cssideheading">Funds from:</span>&emsp;
             		<span class="cssideheadingdata"><%=obj[18]!=null?obj[18]:"-" %></span>
				</td>
				<td>
					<span class="cssideheading">Duration (In Months):</span>&emsp;
             		<span class="cssideheadingdata"><%=obj[8]!=null?obj[8]:"-"  %></span>
				</td>
				<td>
					<span class="cssideheading">Amount (In Lakhs):</span>&emsp;
             		<span class="cssideheadingdata"><%=amount %></span>
				</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">
					<span class="cssideheading">Name of Research Service Provider (RSP):</span>&emsp;
             		<span class="cssideheadingdata"><%=obj[26]+". "+obj[27]+", "+obj[28] %></span>
				</td>
				<td colspan="2">
					<span class="cssideheading">RSP's Address:</span>&emsp;
             		<span class="cssideheadingdata">
             			<%=obj[21]+", "+obj[22]+", "+obj[23]+", "+obj[24]+" - "+obj[25] %> <br>
             			Phone : <%=obj[30] %> <br>
             			Email : <%=obj[31] %> <br>
             			Fax : <%=obj[32] %>
             		</span>
				</td>
			</tr>
		</table>
							
		<!-- --------------------------------------- Milestone Data ---------------------------------------------------- -->
       	<table class="data-table mt-4" >
			<thead>
	        	<tr>
	            	<th style="width: 30%;color: #055C9D;">Description</th>
	            	<th style="width: 10%;color: #055C9D;">Months</th>
	            	<th style="width: 10%;color: #055C9D;">EDP</th>
	            	<th style="width: 10%;color: #055C9D;">Amount (&#8377; )</th>
	            	<!-- <th style="color: #055C9D;">Progress</th> -->
	            	<th style="width: 20%;color: #055C9D;">Progress</th>
	            </tr>
            </thead>
		    <tbody>
		            	
               	<%if(milestones!=null && milestones.size()>0) { char a='a'; Object[] progressData = null;%>
		    		<tr>
		    			<td style="text-align : left;word-wrap: break-word;word-break: normal;vertical-align: top;">&nbsp;(a) Initial Advance &nbsp;&nbsp;(<%=milestones.get(0).getPaymentPercentage() %>%) </td>
		    			<td style="text-align : center;vertical-align: top;">T0*</td>
		    			<td style="text-align : center;vertical-align: top;">
		    				<%if(carsContract!=null && carsContract.getT0Date()!=null) {%><%=fc.SqlToRegularDate(carsContract.getT0Date()) %><%} %> 
		    			</td>
		    			<td style="text-align : right;vertical-align: top;">
		    				<%if(milestones.get(0).getActualAmount()!=null) {%>
		    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(0).getActualAmount())) %>
		    				<%} else{%>
		    					-
		    				<%} %>
		    				&nbsp;&nbsp;
		    			</td>
		    			
		    			<td class="center">
		    				<%
					        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(0).getMilestoneNo())).findFirst().orElse(null): null;
					        %>
					        <%if(progressData!=null) {%>
								<div class="progress" class="progress-bar">
									<div>
										<%=progressData[2] %>%
									</div> 
								</div>	
							<%}else{ %>
								<div class="progress" >
									<div class="progress-bar">
										0%
									</div>
								</div>
							<%} %>
		    			</td>
		    		</tr>
		    		<% for(int i=1;i<milestones.size()-1;i++) { 
		    			String milestoneNo = milestones.get(i).getMilestoneNo();
		    		%>
		    		<tr>
		    			<td style="text-align : left;vertical-align: top;">&nbsp;(<%=++a %>) Performance Milestone-<%=(i) %> of RSQR &nbsp;&nbsp;(<%=milestones.get(i).getPaymentPercentage() %>%) </td>
		    			<td style="text-align : center;vertical-align: top;">T0+<%=milestones.get((i)).getMonths() %> </td>
		    			<td style="text-align : center;vertical-align: top;">
		    				<%if(carsContract!=null && carsContract.getT0Date()!=null) {
		    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((i)).getMonths()));
		    				%>
		    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
		    				<%} %>	
		    			</td>
		    			<td style="text-align : right;vertical-align: top;">
		    				<%if(milestones.get(i).getActualAmount()!=null) {%>
		    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(i).getActualAmount())) %>
		    				<%} else{%>
		    					-
		    				<%} %>
		    				&nbsp;&nbsp;
		    			</td>
		    			<td class="center">
		    				<%
					        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestoneNo)).findFirst().orElse(null): null;
					        %>
					        <%if(progressData!=null) {%>
								<div class="progress" class="progress-bar">
									<div>
										<%=progressData[2] %>%
									</div> 
								</div>	
							<%}else{ %>
								<div class="progress" >
									<div class="progress-bar">
										0%
									</div>
								</div>
							<%} %>
		    			</td>
		    		</tr>
		    		<%}%>
		    		<%if(milestones.size()>1) {%>
		    		<tr>
		    			<td style="text-align : left;word-wrap: break-word;word-break: normal;vertical-align: top;">&nbsp;(<%=++a %>) on submission of final report &nbsp;&nbsp;(<%=milestones.get(milestones.size()-1).getPaymentPercentage() %>%) </td>
		    			<td style="text-align : center;vertical-align: top;">T0+<%=milestones.get(milestones.size()-1).getMonths() %> </td>
		    			<td style="text-align : center;vertical-align: top;">
		    				<%if(carsContract!=null && carsContract.getT0Date()!=null) {
		    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((milestones.size()-1)).getMonths()));
		    				%>
		    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
		    				<%} %>	
		    			</td>
		    			<td style="text-align : right;vertical-align: top;">
		    				<%if(milestones.get(milestones.size()-1).getActualAmount()!=null) {%>
		    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(milestones.size()-1).getActualAmount())) %>
		    				<%} else{%>
		    					-
		    				<%} %>
		    				&nbsp;&nbsp;
		    			</td>
		    			<td class="center">
		    				<%
					        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(milestones.size()-1).getMilestoneNo())).findFirst().orElse(null): null;
					        %>
					        <%if(progressData!=null) {%>
								<div class="progress" class="progress-bar">
									<div>
										<%=progressData[2] %>%
									</div> 
								</div>	
							<%}else{ %>
								<div class="progress" >
									<div class="progress-bar">
										0%
									</div>
								</div>
							<%} %>
		    			</td>
		    		</tr>
		    		<%} %>
    				<%} else{%>
  						<tr>
  							<td colspan="5" class="center">No Data Available</td>
  						</tr>
    				<%} %>
			</tbody>
		</table>
	<%} }%>	
			
	<!-- ----------------------------------------  Presentation of CARS Projects Div End----------------------------------------------------- -->
</body>
</html>