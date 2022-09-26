<%@page import="com.vts.pfms.committee.dto.MeetingExcelDto"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
table.dataTable thead th,table.dataTable tbody th, table.dataTable tbody td {
    padding: 6px 7px; /* e.g. change 8x to 4px here */
}
label{
  font-weight: bold;
  font-size: 13px;
}
</style>
<spring:url value="/resources/js/dataTables.buttons.min.js"
	var="datatablejsbuttons" />
<script src="${datatablejsbuttons}"></script>

<spring:url value="/resources/js/buttons.flash.min.js"
	var="datatablejsflash" />
<script src="${datatablejsflash}"></script>

<spring:url value="/resources/js/jszip.min.js"
	var="datatablejszip" />
<script src="${datatablejszip}"></script>

<spring:url value="/resources/js/pdfmake.min.js"
	var="datatablejspdfmake" />
<script src="${datatablejspdfmake}"></script>

<spring:url value="/resources/js/vfs_fonts.js"
	var="datatablejsvfs" />
<script src="${datatablejsvfs}"></script>

<spring:url value="/resources/js/buttons.html5.min.js"
	var="datatablejshtml5" />
<script src="${datatablejshtml5}"></script>

<spring:url value="/resources/js/buttons.print.min.js"
	var="datatablejsprint" />
<script src="${datatablejsprint}"></script>


</head>
<body>

<%
List<MeetingExcelDto> MeetingList=(List<MeetingExcelDto>)request.getAttribute("MeetingList"); %>




<div class="row"> 
<div class="col-sm-2"></div>
<div class="col-sm-8"  style="top: 5px;">


          


  <table id="example" class="table table-hover  table-striped table-condensed table-bordered DataTableWithPdfandExcel"> 
<!--               <table class="table table-bordered table-hover table-striped table-condensed"  id="myTable"> -->
                             <thead>
                               <tr>            
                                  <th>Mobile No</th>
                                   <th>Meeting Details</th>
                                   <th>Meeting Venue</th>
                                   
                                   </tr>
                             </thead>
                          <tbody>
                          
                     <%if(MeetingList!=null&&MeetingList.size()>0){
                    	
                       for(MeetingExcelDto ls:MeetingList){
                    	
                       %>
                       <tr> 	
                        <td  style="width: 1%;"><%=ls.getMobileNo() %></td>
                        <td style="width: 5%;word-wrap: break-word;word-break: break-all;white-space: normal !important;"><%=ls.getMeetings().substring(0,ls.getMeetings().length()-3)%></td>
                        
                        <td style="width: 6%;"><%=ls.getVenue() %></td>
                     </tr> 
                     <%}}%>
                     
               </tbody> 
            </table>
         
</div>

	 
</div>

<script type="text/javascript">
$(document).ready(function() {

    $('.DataTableWithPdfandExcel').DataTable( {
    	paging: true,
        dom: 'Bfrtip',
        buttons: [

        	{
        		 
        		 extend: 'csv',
        	        text: 'Export csv',
        	        charset: 'utf-8',
        	        extension: '.csv',
        	        fieldBoundary: '',
        		className: "btn-sm btn-success",
        		title: 'Report',
        		text: '<i class="fa fa-file-excel-o" style="font-size:24px"></i>',
        		exportOptions: {
        	        columns: [0, 1, 2]
        	      }
        	      
        		
        	}
            
            
        ]
    } );
} );
</script>
</body>
</html>