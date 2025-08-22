<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!--JQUERY JS  -->
<script src="./webjars/jquery/3.4.0/jquery.min.js"></script>

<!--BootStrap Bundle JS  -->
<script src="./webjars/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

<!--BootStrap JS  -->
<!-- <script src="./webjars/bootstrap/4.0.0/js/*.js"></script> -->

<!--BootStrap CSS  -->
<link rel="stylesheet" href="./webjars/bootstrap/4.0.0/css/bootstrap.min.css" />

<link rel="stylesheet" href="./webjars/font-awesome/4.7.0/css/font-awesome.min.css" />


<spring:url value="/resources/css/jquery-confirm.min.css" var="jqueryconfirmcss" />
<link href="${jqueryconfirmcss}" rel="stylesheet" />

<spring:url value="/resources/js/jquery-confirm.min.js" var="jqueryconfirmjs" />
<script src="${jqueryconfirmjs}"></script>

<!-- Anychart -->

<spring:url value="/resources/js/anychart-base.min.js" var="anychartbase" />
<script src="${anychartbase}"></script>

<spring:url value="/resources/js/anychart-pie.min.js" var="anychart" />
<script src="${anychart}"></script>

<spring:url value="/resources/js/anychart-core.min.js" var="anychartjs" />
<script src="${anychartjs}"></script>

<spring:url value="/resources/js/anychart-cartesian.min.js" var="cartesian" />
<script src="${cartesian}"></script>

<spring:url value="/resources/js/anychart-gantt.min.js" var="anyganttjs" />
<script src="${anyganttjs}"></script>

<spring:url value="/resources/js/anychart-bundle.min.js" var="anybundlejs" />
<script src="${anybundlejs}"></script>

<spring:url value="/resources/js/anychart-ui.min.js" var="anychartuijs" />
<script src="${anychartuijs}"></script>

<spring:url value="/resources/js/anychart-exports.min.js" var="anychartexportjs" />
<script src="${anychartexportjs}"></script>

<%-- <spring:url value="/resources/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script> --%>


<%-- <spring:url value="/resources/js/jspdf.umd.min.js" var="jspdf" />
<script src="${jspdf}"></script>  --%>

<%-- <spring:url value="" var="" />
<script src="${}"></script> --%>



<spring:url value="/resources/css/anychart-font.min.css" var="anyfontcss" />
<link href="${anyfontcss}" rel="stylesheet" />

<spring:url value="/resources/css/anychart-ui.min.css" var="anyuimincss" />
<link href="${anyuimincss}" rel="stylesheet" />


<!-- Font Awesome Animation -->

<spring:url value="/resources/css/fontanimationawesome.css" var="anyfontanimation" />
<link href="${anyfontanimation}" rel="stylesheet" />




<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />

<!-- New Data Table -->

 <spring:url value="/resources/js/bootstrap-editable.js" var="bootstrapeditablejs"/>
<script src="${bootstrapeditablejs}"></script>

<spring:url value="/resources/js/bootstrap-table.js" var="bootstraptablejs" />
<script src="${bootstraptablejs}"></script>

<spring:url value="/resources/js/bootstrap-table-editable.js" var="bootstraptableeditablejs" />
<script src="${bootstraptableeditablejs}"></script>

<spring:url value="/resources/js/bootstrap-table-export.js" var="bootstraptableexportjs" />
<script src="${bootstraptableexportjs}"></script>

<spring:url value="/resources/js/bootstrap-table-resizable.js" var="bootstraptableresizablejs" />
<script src="${bootstraptableresizablejs}"></script>

<spring:url value="/resources/js/colResizable-1.5.source.js" var="colresizable" />
<script src="${colresizable}"></script>

<spring:url value="/resources/js/data-table-active.js" var="datatableactivejs" />
<script src="${datatableactivejs}"></script>

<spring:url value="/resources/js/tableExport.js" var="tableexportjs" />
<script src="${tableexportjs}"></script> 

<!-- Time range picker -->

<spring:url value="/resources/jquery.timepicker.css" var="timepickerCss" />
<link href="${timepickerCss}" rel="stylesheet" />

<spring:url value="/resources/jquery.timepicker.min.css" var="timepickerMinCss" />
<link href="${timepickerMinCss}" rel="stylesheet" />

<spring:url value="/resources/jquery.timepicker.js" var="timepickerJs" />
<script src="${timepickerJs}"></script>

<spring:url value="/resources/jquery.timepicker.min.js" var="timepickerMinJs" />
<script src="${timepickerMinJs}"></script>



<!-- Calendar -->

<spring:url value="/resources/js/evo-calendar.js" var="evocalendarjs" />
<script src="${evocalendarjs}"></script>

<spring:url value="/resources/css/evo-calendar.css" var="evocalendarcss" />
<link href="${evocalendarcss}" rel="stylesheet" />



<spring:url value="/resources/css/evo-calendar.royal-navy.css" var="evocalendarroyalnavycss" />
<link href="${evocalendarroyalnavycss}" rel="stylesheet" />

<spring:url value="/resources/css/evo-calendar.royal-navy.min.css" var="evocalendarroyalnavymincss" />
<link href="${evocalendarroyalnavymincss}" rel="stylesheet" />



<!-- Datatable css -->

 <%-- <spring:url value="/resources/css/bootstrap-editable.css" var="bootstrapeditablecss" />
<link href="${bootstrapeditablecss}" rel="stylesheet" /> --%>

<spring:url value="/resources/css/bootstrap-table.css" var="bootstraptablecss" />
<link href="${bootstraptablecss}" rel="stylesheet" /> 

<spring:url value="/resources/dataTables.bootstrap4.min.css" var="DataTableCss1" />
<link href="${DataTableCss1}" rel="stylesheet" />

<spring:url value="/resources/jquery.dataTables.min.js" var="DataTableJjs1" /> 
<script src="${DataTableJjs1}"></script>
        
<spring:url value="/resources/dataTables.bootstrap4.min.js" var="DataTablejs1" />   
<script src="${DataTablejs1}"></script> 

<%-- 
<spring:url value="/resources/js/master.js" var="Masterjs" />
<script src="${Masterjs}"></script> --%>


<%--  <spring:url value="/resources/dataTables.bootstrap4.min.css" var="DataTableCss" />
     <spring:url value="/resources/jquery.dataTables.min.js" var="DataTableJjs" />    
     <spring:url value="/resources/dataTables.bootstrap4.min.js" var="DataTablejs" />   
      --%>
     
     
<%--  <spring:url value="/resources/bootstrap-select.min.css" var="select2Css" />
 <spring:url value="/resources/bootstrap-select.min.js" var="select2js" /> --%>
 
 <spring:url value="/resources/css/select2.min.css" var="selectCss" />
 <link href="${selectCss}" rel="stylesheet" />
 
 <spring:url value="/resources/js/select2.min.js" var="selectjs" /> 
 <script src="${selectjs}"></script>
 
 
     <!--DATE PICKER -->
     
 <spring:url value="/resources/bootstrap-datepicker.min.css" var="DatepickerCss" />
 <link href="${DatepickerCss}" rel="stylesheet" />
 <spring:url value="/resources/bootstrap-datepicker.min.js" var="Datepickerjs" />
    <script src="${Datepickerjs}"></script> 
    
     <spring:url value="/resources/daterangepicker.min.js" var="daterangepickerjs" />  
    <spring:url value="/resources/daterangepicker.min.css" var="daterangepickerCss" />     
     <spring:url value="/resources/moment.min.js" var="momentjs" />  
      <script src="${momentjs}"></script> 
                   <script src="${daterangepickerjs}"></script> 
          <link href="${daterangepickerCss}" rel="stylesheet" />
          
         <spring:url value="/resources/bootbox.all.min.js" var="bootboxjs" />
          <script src="${bootboxjs}"></script> 
         
         <spring:url value="/resources/bootstrap-toggle.min.css" var="ToggleCss" />
         <link href="${ToggleCss}" rel="stylesheet" />
     <spring:url value="/resources/bootstrap-toggle.min.js" var="Togglejs" />
   
          <script src="${Togglejs}"></script> 
         
         
     <!-- Add font.css dependancy -->
<%-- <spring:url value="/resources/css/font.css" var="FontCss" /> --%>

      <%-- <spring:url value="/resources/normalize.css" var="normalizeCss" /> --%>
         
           
    <link href="${DataTableCss}" rel="stylesheet" />
          <script src="${DataTableJjs}"></script>
          <script src="${DataTablejs}"></script> 
           <link href="${select2Css}" rel="stylesheet" />
          <script src="${select2js}"></script>
          
        <%--   <link href="${FontCss}" rel="stylesheet" /> --%>
             <%--   <link href="${normalizeCss}" rel="stylesheet" /> --%>


<spring:url value="/resources/js/jquery.canvasjs.min.js" var="fbegraph" />
<script src="${fbegraph}"></script>

<spring:url value="/resources/js/highcharts-gantt.js" var="highchartsgantt" />
	<script src="${highchartsgantt}"></script>
<%-- <spring:url value="/resources/js/highcharts.js" var="highcharts" />
<script src="${highcharts}"></script>  --%>
<spring:url value="/resources/js/no-data-to-display.js" var="NoDatajs" />  
<script src="${NoDatajs}"></script>  
<spring:url value="/resources/js/exporting.js" var="exporting" />
<script src="${exporting}"></script> 
<spring:url value="/resources/js/export-data.js" var="export" />
<script src="${export}"></script>
<spring:url value="/resources/js/accessibility.js" var="Accessbilityjs" />  
<script src="${Accessbilityjs}"></script>
<spring:url value="/resources/js/accessibility.src.js" var="Accessbilitysrcjs" />  
<script src="${Accessbilitysrcjs}"></script>
<spring:url value="/resources/js/highcharts-3d.js" var="HighChartsJs" />  
<script src="${HighChartsJs}"></script>   
<spring:url value="/resources/js/highcharts-3d.src.js" var="HighCharts3dJs" />  
<script src="${HighCharts3dJs}"></script>
<spring:url value="/resources/js/variable-pie.js" var="VariablePieJs" />  
<script src="${VariablePieJs}"></script>      

<spring:url value="/resources/js/crypto-js.min.js" var="cryptoexportjs" />
<script src="${cryptoexportjs}"></script>
 


</head>

</html>