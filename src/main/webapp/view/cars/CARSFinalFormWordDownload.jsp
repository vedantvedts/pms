<%@page import="com.vts.pfms.cars.model.CARSContractEquipment"%>
<%@page import="com.vts.pfms.cars.model.CARSContractConsultants"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CARS-03</title>
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
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSContract carsContract =(CARSContract)request.getAttribute("CARSContractData"); 
List<CARSContractConsultants> consultants = (List<CARSContractConsultants>)request.getAttribute("CARSContractConsultants");
List<CARSContractEquipment> equipment = (List<CARSContractEquipment>)request.getAttribute("CARSContractEquipment");

String lablogo=(String)request.getAttribute("lablogo");
LabMaster labMaster = (LabMaster)request.getAttribute("LabMasterData");

FormatConverter fc = new FormatConverter();

%>
	<div  align="center" ><button class="btn btn-lg bg-transparent" id="btn-export" onclick=exportHTML() ><i class="fa fa-lg fa-download" aria-hidden="true"style="color:green"></i></button></div>
	<div id="source-html">
		<div id="container pageborder" align="center"  class="firstpage" id="firstpage">
			<div class="firstpage" id="firstpage"> 	
				<div style="text-align: right;">
					<h5 style="font-weight: bold;margin-right: 2rem;"><%=labMaster.getLabCode() %>: CARS-02</h5>
				</div>
				
		    	<table style="margin-left : 10px;border-collapse : collapse;width : 98.5%;">
			    	<tbody>
			    		<tr>
			    			<td rowspan="2" style="text-align: center;padding : 3px;word-wrap: break-word;word-break: normal;font-size: 40px;font-style: italic;">
			    				<img style="width: 70px; height: 70px;" <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuraton"<%}else{ %> alt="File Not Found" <%} %>>
			    			</td>
			    			<td>
			    				<h4 style="font-weight: bold;text-align: center;padding : 3px;word-wrap: break-word;word-break: normal;">CONTRACT FOR ACQISITION OF RESEARCH SERVICES (CARS)</h4>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" style="text-align: left;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				By signature of authority identified at (12) below, DRDO hereby Contracts on the Research Service Provider identified at (3), the provision of the Research Services described at (7),
			    				 within the Time stated, Payments and subject to other conditions overleaf, as follows:
			    			</td>
			    		</tr>
			    	</tbody>
			    </table>
			    
			    <table style="margin-left : 10px;border-collapse : collapse;width : 98.5%;">
			    	<tbody>
			    		<tr>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				1) Short title of Research Service to be provided: <br>
			    				&nbsp;<%if(carsIni!=null) {%><%=carsIni.getInitiationTitle() %> <%} %>
			    				<br>
			    			</td>
			    			<td colspan="1" style="text-align : left;border : 1px solid black;padding : 3px;word-wrap: break-word;word-break: normal;">
			    				Contract No.: &nbsp;<%if(carsContract!=null && carsContract.getContractNo()!=null) {%><%=carsContract.getContractNo() %><%} else{%>LRDE/CARS/1/2024<%} %>
			    				<br> <br>
			    				Date: &nbsp;<%if(carsContract!=null && carsContract.getContractDate()!=null) {%><%=fc.SqlToRegularDate(carsContract.getContractDate()) %><%} else{%>-<%} %>
			    			</td>
			    		</tr>
			    	</tbody>
			    </table>
		    </div>
		</div>
	</div>
<script>
  jQuery(document).ready(function($) {
   	  $("#btn-export").click(function(event) {
   	    $("#source-html").wordExport("CARS-03");
   	  });
   	});
   
</script>		
</body>
</html>