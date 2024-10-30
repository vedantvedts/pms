<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>LAB PMS EMPLOYEE </title>
<style>
  .checkbox-wrapper-12 {
    position: relative;
  }

  .checkbox-wrapper-12 > svg {
    position: absolute;
    top: -130%;
    left: -170%;
    width: 110px;
    pointer-events: none;
  }

  .checkbox-wrapper-12 * {
    box-sizing: border-box;
  }

  .checkbox-wrapper-12 input[type="checkbox"] {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    -webkit-tap-highlight-color: transparent;
    cursor: pointer;
    margin: 0;
  }

  .checkbox-wrapper-12 input[type="checkbox"]:focus {
    outline: 0;
  }

  .checkbox-wrapper-12 .cbx {
    width: 24px;
    height: 24px;
    top: calc(50vh - 12px);
    left: calc(50vw - 12px);
  }

  .checkbox-wrapper-12 .cbx input {
    position: absolute;
    width: 24px;
    height: 24px;
    border: 2px solid #bfbfc0;
    /* border-radius: 50%; */
  }

  .checkbox-wrapper-12 .cbx label {
    width: 24px;
    height: 24px;
    background: none;
   /*  border-radius: 50%; */
    position: absolute;
    -webkit-filter: url("#goo-12");
    filter: url("#goo-12");
    transform: translate3d(0, 0, 0);
    pointer-events: none;
  }

  .checkbox-wrapper-12 .cbx svg {
    position: absolute;
    top: 5px;
    left: 5px;
    z-index: 1;
    pointer-events: none;
  }

  .checkbox-wrapper-12 .cbx svg path {
    stroke: #fff;
    stroke-width: 3;
    stroke-linecap: round;
    stroke-linejoin: round;
    stroke-dasharray: 19;
    stroke-dashoffset: 19;
    transition: stroke-dashoffset 0.3s ease;
    transition-delay: 0.2s;
  }

  .checkbox-wrapper-12 .cbx input:checked + label {
    animation: splash-12 0.6s ease forwards;
  }

  .checkbox-wrapper-12 .cbx input:checked + label + svg path {
    stroke-dashoffset: 0;
  }

  .checkbox-wrapper-12 .cbx input:not(:checked) + label {
    animation: unsplash-12 0.6s ease forwards;
  }

  .checkbox-wrapper-12 .cbx input:not(:checked) + label + svg path {
    stroke-dashoffset: 19;
  }
  
  #selectall:checked
  {
 	 box-shadow: 0px 0px 9px green;
  }
  
  #selectall:not(:checked) 
  {
  	box-shadow: 0px 0px 9px red; 
  }
  
  @keyframes splash-12 {
    40% {
      border-radius: 50%;
      background: green;
      box-shadow: 0 -18px 0 -8px green, 16px -8px 0 -8px green, 16px 8px 0 -8px green, 0 18px 0 -8px green, -16px 8px 0 -8px green, -16px -8px 0 -8px green;
    }

    100% {
      border-radius: 0;
      background: green;
      box-shadow: 0 -36px 0 -10px transparent, 32px -16px 0 -10px transparent, 32px 16px 0 -10px transparent, 0 36px 0 -10px transparent, -32px 16px 0 -10px transparent, -32px -16px 0 -10px transparent;
    }
  }

  @keyframes unsplash-12 {
    40% {
      border-radius: 50%;
      background: red;
      box-shadow: 0 -18px 0 -8px red, 16px -8px 0 -8px red, 16px 8px 0 -8px red, 0 18px 0 -8px red, -16px 8px 0 -8px red, -16px -8px 0 -8px red;
    }

    100% {
      border-radius: 0;
      background: none;
      box-shadow: 0 -36px 0 -10px transparent, 32px -16px 0 -10px transparent, 32px 16px 0 -10px transparent, 0 36px 0 -10px transparent, -32px 16px 0 -10px transparent, -32px -16px 0 -10px transparent;
    }
  }
  
  .modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
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
		<div  class="text-center alert alert-success col-md-8 col-md-offset-2" style="margin-top: 1rem" role="alert">
		<%=Status %>
		</div>
		</div>
		<%}else if(result1!=null){%>
		<div align="center">
		<div class="text-center alert alert-danger col-md-8 col-md-offset-2" style="margin-top: 1rem" role="alert" >
		<%=result1 %>
		        </div>
		</div><%} %>
		 <div class="page card dashboard-card">
       
				<div class="card-body">			
						<div class="table-responsive">					
				   		<table class="table table-bordered table-hover table-striped table-condensed" style="font-weight: 600;" id="myTable1">
		                   <thead>
		                   <tr style="background-color: #fdffe9 !important;color:#034189;">
		                       <th colspan="4" style="text-align: center;">LAB</th>
		                       <th bgcolor="#c4ebf0" style="border-color: #c4ebf0 !important;">&nbsp;&nbsp;&nbsp;</th>
		                       <th colspan="5" style="text-align: center;">
			                       PMS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                       <i onclick="openlabPmsUpdateModal()" class="fa fa-refresh" id="LabPmsEmployeeSpan" data-toggle="tooltip" data-placement="top" title="Sync" style="color:green;font-size: 19px;"></i></th>
		                       </tr>
		                   
		                       <tr style="background-color:#edab33;color:#034189;">
		                       <th style="text-align: center;">SN</th>
		                       <th style="text-align: center;" class="text-nowrap">Pc No</th>
		                       <th style="text-align: center;" class="text-nowrap">Name</th>
		                       <th style="text-align: center;" class="text-nowrap">Designation</th>
		                       <th bgcolor="#c4ebf0" style="border-color: #c4ebf0 !important;">&nbsp;&nbsp;&nbsp;</th>
		                       <th style="text-align: center;" class="text-nowrap">Emp No</th>
		                       <th style="text-align: center;" class="text-nowrap">Emp Name</th>
		                       <th style="text-align: center;" class="text-nowrap">Designation</th>
		                       </tr>
		                   </thead>
		                   <tbody>
		                   <%int sn=1;
		                   if(labPmsEmployeeList!=null && labPmsEmployeeList.size()>0){
		                     for(Object[] obj:labPmsEmployeeList){ 
		                   %>
		                       <tr> 
		                       <td align="center"><%=sn++%></td>
		                       <td align="center"><%if(obj[0]!=null){%><%=obj[0]%><%}else{ %>--<%} %></td>
		                       <td align="left"><%if(obj[1]!=null){%><%=obj[1].toString()%><%}else{ %>--<%} %></td> 
		                       <td align="left"><%if(obj[2]!=null){%><%=obj[2].toString()%><%}else{ %>--<%} %></td> 
		                       <td bgcolor="#c4ebf0" style="border-color: #c4ebf0 !important;">&nbsp;&nbsp;&nbsp;</td>
		                       <td align="center" <%if(obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString())){%> bgcolor="#ffc7c7" style="color:black;" <%}else{ %> style="color:#086408;" <%} %>><%if(obj[4]!=null){ %><%=obj[4].toString()%><%}else{ %>--<%} %></td> 
		                       <td align="left" <%if(obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString())){%> bgcolor="#ffc7c7" style="color:black;" <%}else{ %> style="color:#086408;" <%} %>><%if(obj[5]!=null){ %><%=obj[5].toString()%><%}else{ %>--<%} %></td> 
		                       <td align="left" <%if(obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString())){%> bgcolor="#ffc7c7" style="color:black;" <%}else{ %> style="color:#086408;" <%} %>><%if(obj[6]!=null){ %><%=obj[6].toString()%><%}else{ %>--<%} %></td> 
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
		  <div class="modal-dialog modal-dialog-jump" role="document" style="min-width: 90% !important;min-height: 50% !important;">
		    <div class="modal-content">
		    <div class="modal-header" style="background-color: #114A86;color:white;">
		      <span style="font-weight: 600;font-size: larger;font-family: 'Lato';letter-spacing: 1px;">Lab Pms Employee Update&nbsp;</span> 
		       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			    <i class="fa-solid fa-xmark" aria-hidden="true" ></i>
			</button>
		    </div>
		     <div class="modal-body">
		     <form action="LabPmsEmployeeUpdate.htm" id="LabPmsEmployeeForm">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		         <div class="table-responsive">					
				   		<table class="table table-bordered table-hover table-striped table-condensed" style="font-weight: 600;width: 100%;" id="modalTable">
		                   <thead>
		                   <tr style="background-color: #fdffe9;color:#034189;">
		                       <th style="background: #ffffff;border-left: none;border-top: none;border-bottom: none;">&nbsp;&nbsp;&nbsp;</th>
		                       <th colspan="3" style="text-align: center;">LAB</th>
		                       <th style="background: #ffffff;border-top: none;border-bottom: none;">&nbsp;&nbsp;&nbsp;</th>
		                       <th colspan="4" style="text-align: center;">PMS </tr>
		                   
		                       <tr style="background-color:#edab33;color:#034189;">
		                       <th style="background: #ffffff;border-left: none;border-top: none;border-bottom: none;">
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
		                       <th style="text-align: center;" class="text-nowrap">Pc No</th>
		                       <th style="text-align: center;" class="text-nowrap">Name</th>
		                       <th style="text-align: center;" class="text-nowrap">Designation</th>
		                       <th style="background: #ffffff;border-top: none;border-bottom: none;">&nbsp;&nbsp;&nbsp;</th>
		                       <th style="text-align: center;" class="text-nowrap">Emp No</th>
		                       <th style="text-align: center;" class="text-nowrap">Emp Name</th>
		                       <th style="text-align: center;" class="text-nowrap">Designation</th>
		                       </tr>
		                   </thead>
		                   <tbody>
		                   <%int sNo=1,count=0;
		                   if(labPmsEmployeeList!=null && labPmsEmployeeList.size()>0){
		                     for(Object[] obj:labPmsEmployeeList){
		                    	 if((obj[4]==null && obj[5]==null && obj[6]==null) || (obj[2]!=null && obj[6]!=null && !obj[2].toString().equalsIgnoreCase(obj[6].toString()))){count++;%>
		                       <tr> 
		                       <td align="center" style="background: #ffffff;border-left: none;border-top: none;border-bottom: none;"><input type="checkbox" class="checkbox" id="LabPmsEmpId" name="LabPmsEmpId" value="<%=obj[8]%>#<%=obj[9]!=null?obj[9]:" "%>#<%=obj[4]!=null?obj[4]:" "%>"></td>
		                       <td align="center"><%if(obj[0]!=null){%><%=obj[0]%><%}else{ %>--<%} %></td>
		                       <td align="left"><%if(obj[1]!=null){%><%=obj[1].toString()%><%}else{ %>--<%} %></td> 
		                       <td align="left"><%if(obj[2]!=null){%><%=obj[2].toString()%><%}else{ %>--<%} %></td> 
		                       <td style="background: #ffffff;border-top: none;border-bottom: none;">&nbsp;&nbsp;&nbsp;</td>
		                       <td align="center"><%if(obj[4]!=null){ %><%=obj[4].toString()%><%}else{ %>--<%} %></td> 
		                       <td align="left"><%if(obj[5]!=null){ %><%=obj[5].toString()%><%}else{ %>--<%} %></td> 
		                       <td align="left" style="background-color:#ffc7c7;"><%if(obj[6]!=null){ %><%=obj[6].toString()%><%}else{ %>--<%} %></td> 
		                       </tr> 
		                       <%}} if(count==0){%>
		                       
		                        <tr>
		                            <td style="background: #ffffff;border-top: none;border-bottom: none;border-left: none;">&nbsp;&nbsp;&nbsp;</td>
		                        	<td colspan="3" align="center" style="font-weight: 600;color:red;">No Record Found</td>
		                        	<td style="background: #ffffff;border-top: none;border-bottom: none;">&nbsp;&nbsp;&nbsp;</td>
		                        	<td colspan="4" align="center" style="font-weight: 600;color:red;">No Record Found</td>
		                        </tr>
		                     
		                      <%}}else{ %>
		                        <tr>
		                        	<td colspan="3" style="font-weight: 600;color:red;">No Record Found</td>
		                        	<td style="background: #ffffff;border-top: none;border-bottom: none;">&nbsp;&nbsp;&nbsp;</td>
		                        	<td colspan="4" style="font-weight: 600;color:red;">No Record Found</td>
		                        </tr>
		                       <%} %>
	                    </tbody>
	                 </table>
	               </div>
			      </form>
			      
			      <div class="row" style="justify-content: center;">
			              <span class="zoom-in-zoom-out" style="font-size:14px;font-weight:bold;color:#6000ff;"> Click Submit Button To Update Lab Employee To Pms </span></div>
		         </div>
		     
		       
		       
		       <div class="modal-footer" style="justify-content: center;background-color: #f0f5ff;box-shadow: 0 0 0px black, 0 0 5px #e5e5e5;border-radius: 3px;">
		        <button type="button" class="btn btn-success btn-sm submit"  onclick="SubmitLabPmsEmployeeDetails()">Submit</button>
		        <button type="button" class="btn btn-danger btn-sm delete" data-dismiss="modal" style="background-color: darkred;color:white;">CLOSE</button>
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