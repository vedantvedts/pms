<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>LAB PMS EMPLOYEE </title>
<spring:url value="/resources/css/master/labpmsemployee.css" var="labpmsemployee" />     
<link href="${labpmsemployee}" rel="stylesheet" />

</head>
<body>
<div class="container-fluid">		
  <div class="col-md-12">
 	<div class="card shadow-nohover" >
	  	<div class="card-header">
	  	   <div class="row">
			  <div class="col-md-12"><h4><b>LAB-PMS EMPLOYEE</b></h4></div>
		   </div>
	    </div>
		<%List<Object[]> labPmsEmployeeList=(List<Object[]>)request.getAttribute("labPmsEmployeeList");
		String Status=(String)request.getParameter("status"); 
		String result1=(String)request.getParameter("failure"); 
		    if(Status!=null){%>
		   <div align="center">
		<div  class="text-center alert alert-success col-md-8 col-md-offset-2 dangerMsg"  role="alert">
		<%=StringEscapeUtils.escapeHtml4(Status) %>
		</div>
		</div>
		<%}else if(result1!=null){%>
		<div align="center">
		<div class="text-center alert alert-danger col-md-8 col-md-offset-2 dangerMsg"  role="alert" >
		<%=StringEscapeUtils.escapeHtml4(result1) %>
		        </div>
		</div><%} %>
		 <div class="page card dashboard-card">
       
				<div class="card-body">			
						<div class="table-responsive">					
				   		<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable1">
		                   <thead>
		                   <tr  class="table1tr">
		                       <th colspan="4" class="labth" >LAB</th>
		                       <th bgcolor="#c4ebf0" class="emptyth"  >&nbsp;&nbsp;&nbsp;</th>
		                       <th colspan="5"  class="pmsth">
			                       PMS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                       <i onclick="openlabPmsUpdateModal()" class="fa fa-refresh" id="LabPmsEmployeeSpan" data-toggle="tooltip" data-placement="top" title="Sync" ></i></th>
		                       </tr>
		                   
		                       <tr  class="trTbl">
		                       <th class="tblth">SN</th>
		                       <th  class="text-nowrap">Pc No</th>
		                       <th  class="text-nowrap tblth">Name</th>
		                       <th  class="text-nowrap tblth">Designation</th>
		                       <th bgcolor="#c4ebf0"  class="empty-thh">&nbsp;&nbsp;&nbsp;</th>
		                       <th  class="text-nowrap tblth">Emp No</th>
		                       <th  class="text-nowrap tblth">Emp Name</th>
		                       <th  class="text-nowrap tblth">Designation</th>
		                       </tr>
		                   </thead>
		                   <tbody>
		                   <%int sn=1;
		                   if(labPmsEmployeeList!=null && labPmsEmployeeList.size()>0){
		                     for(Object[] obj:labPmsEmployeeList){ 
		                   %>
		                       <tr> 
		                       <td align="center"><%=sn++%></td>
		                       <td align="center"><%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString())%><%}else{ %>--<%} %></td>
		                       <td align="left"><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString())%><%}else{ %>--<%} %></td> 
		                       <td align="left"><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())%><%}else{ %>--<%} %></td> 
		                       <td bgcolor="#c4ebf0"  class="emptytdData">&nbsp;&nbsp;&nbsp;</td>
		                       <td align="center" <%if(obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString())){%> bgcolor="#ffc7c7" class="blackColor"  <%}else{ %> class="basiccolor"  <%} %>><%if(obj[4]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[4].toString())%><%}else{ %>--<%} %></td> 
		                       <td align="left" <%if(obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString())){%> bgcolor="#ffc7c7" class="blackColor" <%}else{ %> class="basiccolor" <%} %>><%if(obj[5]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[5].toString())%><%}else{ %>--<%} %></td> 
		                       <td align="left" <%if(obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString())){%> bgcolor="#ffc7c7" class="blackColor" <%}else{ %> class="basiccolor" <%} %>><%if(obj[6]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[6].toString())%><%}else{ %>--<%} %></td> 
		                       </tr> 
		                       <%}} %>
	                    </tbody>
	                 </table>
	               </div>
	           </div>
            </div>
	  </div>
   </div>
</div>	

 <!--Commitment Revise -->
		<div class="modal LabPmsEmployee" tabindex="-1" role="dialog">
		  <div class="modal-dialog modal-dialog-jump labpmsEmployeeDialog" role="document" >
		    <div class="modal-content">
		    <div class="modal-header headerModal" >
		      <span  class="spanHeading">Lab Pms Employee Update&nbsp;</span> 
		       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			    <i class="fa-solid fa-xmark" aria-hidden="true" ></i>
			</button>
		    </div>
		     <div class="modal-body">
		     <form action="LabPmsEmployeeUpdate.htm" id="LabPmsEmployeeForm">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		         <div class="table-responsive">					
				   		<table class="table table-bordered table-hover table-striped table-condensed"  id="modalTable">
		                   <thead>
		                   <tr  class="thedtr">
		                       <th class="emptyth" >&nbsp;&nbsp;&nbsp;</th>
		                       <th colspan="3"  class="labth">LAB</th>
		                       <th  class="emptyth1">&nbsp;&nbsp;&nbsp;</th>
		                       <th colspan="4"  class="pmsth1">PMS </tr>
		                   
		                       <tr  class="trbetween">
		                       <th  class="thbet">
		                       <!-- <input type="checkbox" id="selectall" name="all"> -->
		                      <div class="checkbox-wrapper-12">
								  <div class="cbx">
								    <input id="selectall" type="checkbox"/>
								    <label for="selectall"></label>
								    <svg width="15" height="14" viewbox="0 0 15 14" fill="none">
								      <path d="M2 8.36364L6.23077 12L13 2"></path>
								    </svg>
								  </div>
								</div>

		                       </th>
		                       <th  class="text-nowrap pmsth1">Pc No</th>
		                       <th  class="text-nowrap pmsth1">Name</th>
		                       <th  class="text-nowrap pmsth1">Designation</th>
		                       <th class="emptyth1">&nbsp;&nbsp;&nbsp;</th>
		                       <th  class="text-nowrap pmsth1">Emp No</th>
		                       <th  class="text-nowrap pmsth1">Emp Name</th>
		                       <th  class="text-nowrap pmsth1">Designation</th>
		                       </tr>
		                   </thead>
		                   <tbody>
		                   <%int sNo=1,count=0;
		                   if(labPmsEmployeeList!=null && labPmsEmployeeList.size()>0){
		                     for(Object[] obj:labPmsEmployeeList){
		                    	 if((obj[4]==null && obj[5]==null && obj[6]==null) || (obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString()))){count++;%>
		                       <tr> 
		                       <td align="center" class="emptyth"><input type="checkbox" class="checkbox" id="LabPmsEmpId" name="LabPmsEmpId" value="<%=obj[8]%>#<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()):" "%>#<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" "%>"></td>
		                       <td align="center"><%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString())%><%}else{ %>--<%} %></td>
		                       <td align="left"><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString())%><%}else{ %>--<%} %></td> 
		                       <td align="left"><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())%><%}else{ %>--<%} %></td> 
		                       <td class="emptyth1">&nbsp;&nbsp;&nbsp;</td>
		                       <td align="center" class="modaltd"><%if(obj[4]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[4].toString())%><%}else{ %>--<%} %></td> 
		                       <td align="left" class="modaltd"><%if(obj[5]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[5].toString())%><%}else{ %>--<%} %></td> 
		                       <td align="left" class="modaltd"><%if(obj[6]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[6].toString())%><%}else{ %>--<%} %></td> 
		                       </tr> 
		                       <%}} if(count==0){%>
		                       
		                        <tr>
		                            <td class="thbet">&nbsp;&nbsp;&nbsp;</td>
		                        	<td colspan="3" align="center" class="NRF" >No Record Found</td>
		                        	<td class="emptyth1">&nbsp;&nbsp;&nbsp;</td>
		                        	<td colspan="4" align="center"  class="NRF">No Record Found</td>
		                        </tr>
		                     
		                      <%}}else{ %>
		                        <tr>
		                        	<td colspan="3" class="NRF">No Record Found</td>
		                        	<td class="emptyth1">&nbsp;&nbsp;&nbsp;</td>
		                        	<td colspan="4" class="NRF">No Record Found</td>
		                        </tr>
		                       <%} %>
	                    </tbody>
	                 </table>
	               </div>
			      </form>
			      
			      <div class="row btmdiv" >
			              <span class="zoom-in-zoom-out notespan" > Click Submit Button To Update Lab Employee To Pms </span></div>
		         </div>
		     
		       
		       
		       <div class="modal-footer buttondiv" >
		        <button type="button" class="btn btn-success btn-sm submit"  onclick="SubmitLabPmsEmployeeDetails()">Submit</button>
		        <button type="button" class="btn btn-danger btn-sm delete closebtn" data-dismiss="modal" >CLOSE</button>
			   </div>
		   </div>
		 </div>
	   </div>
</body>
<script type="text/javascript">
$(document).ready(function(){
$('#selectall').on('click',function(){
    if(this.checked){
        $('.checkbox').each(function(){
            this.checked = true;
        });
    }else{
         $('.checkbox').each(function(){
            this.checked = false;
        });
    }
});

$('.checkbox').on('click',function(){
    if($('.checkbox:checked').length == $('.checkbox').length){
        $('#selectall').prop('checked',true);
    }else{
        $('#selectall').prop('checked',false);
    }
});
});	
function openlabPmsUpdateModal() {
$(".LabPmsEmployee").modal('show');
$('#selectall').prop('checked', true);
if ($('#selectall').is(':checked')) {
    $('.checkbox').each(function() {
        this.checked = true;
    });
} else {
    $('.checkbox').each(function() {
        this.checked = false;
    });
}
}

$("#myTable1").DataTable({
    "lengthMenu": [[15, 25, 50, 75, 100,-1],[10, 25, 50, 75, 100,"All"]],
    "pagingType": "simple",
      "ordering": false
});

function SubmitLabPmsEmployeeDetails(){
    var checkboxs=document.getElementsByName("LabPmsEmpId");
    var okay=false;
    for(var i=0,l=checkboxs.length;i<l;i++){
        if(checkboxs[i].checked){
            okay=true;
            break;
        }
    }
    if(!okay) {	
    	alert("Please select at least one checkbox");
    	return false;	
    }else{
    	var form=$("#LabPmsEmployeeForm");
	 	if(form){
 			if(confirm("Are You Sure To Update the Employee ?")){
 			 	form.submit();
 			 	return true;
	 		}else{
	 			return false;
	 		}
	 	}else{
	 		return false;
	 	}
    }
}
</script>
</html>