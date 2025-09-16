<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/admin/RoleFormAccess.css" var="roleFormAccess" />
<link href="${roleFormAccess}" rel="stylesheet" />


</head>
<body>


<%

List<Object[]> LoginTypeRoles=(List<Object[]>) request.getAttribute("LoginTypeRoles");
List<Object[]> FormDetailsList=(List<Object[]>) request.getAttribute("FormDetailsList");
List<Object[]> FormModulesList=(List<Object[]>) request.getAttribute("FormModulesList");
List<Object[]> AllLabsList=(List<Object[]>) request.getAttribute("AllLabsList");
String logintype=(String)request.getAttribute("logintype");
String moduleid=(String)request.getAttribute("moduleid");
String labCode=(String)session.getAttribute("labcode");
if(!logintype.equalsIgnoreCase("A")) {
	FormModulesList.removeIf(e -> e[1]!=null && e[1].toString().equalsIgnoreCase("Admin"));
}
%>

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>



<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				
				<div class="card-header">
					
					<form class="" method="post" action="Role.htm" id="myform">
					
						<div class="row">
		
							<div class="col-sm-6">
								<h4 class="control-label" > Forms List</h4>
							</div>
						<!-- 	<div class="col-sm-1 half">
								<h6 class="control-label" > Lab :</h6>
							</div> -->
							
							<%-- <div class="col-sm-2">			
										 <select class="form-control" id="logintype" required="required" name="labCode" onchange='submitForm();' >
						   						<% for (Object[] obj : AllLabsList) {%>
												<option value="<%=obj[3]%>" <%if(obj[3].toString().equalsIgnoreCase(labCode)){ %>selected<% } %> ><%=obj[3] %> </option>
												<%} %>
						  				</select>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								
							</div> --%>
		
							<div class="col-sm-1half">	
								<h6 class="control-label" > Role : </h6>
							</div>		
								
							<div class="col-sm-2">			
										 <select class="form-control m-minus" id="logintype" required="required" name="logintype"  onchange='submitForm();' >
						   						<% for (Object[] obj : LoginTypeRoles) {%>
												<option value="<%=obj[1]%>" <%if(obj[1].toString().equalsIgnoreCase(logintype)){ %>selected<% } %> ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>
												<%} %>
						  				</select>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								
							</div>
							
							<div class="col-sm-1half">	
								<h6 class="control-label" > Module : </h6> 						
							</div>
							
							<div class="col-sm-2">	
	
										 <select class="form-control m-minus" id="moduleid" required="required" name="moduleid" onchange='submitForm();' >
										 		<option value="A" >All </option>
						   						<% for (Object[] obj : FormModulesList) {%>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(moduleid)){ %>selected<% } %> ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
												<%} %>
						  				</select>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
						
							</div>
							
						</div>
					
					</form>
					
				</div>
			
			<!-- card header -->
				

				<div class="card-body"> 

			           
			         <div class="table-responsive-sm hei-over" >
						<table	class=" scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm ">
					        <thead >
					          <tr>
			                	<th >SN</th>
			                    <th >Form Name</th>
			                    <th >Access</th>
			                    <th> Lab/ HQ </th>
			                </tr>
					        </thead>
        
					         <tbody>
							<% 
								if(FormDetailsList.size()>0){
									int count=1;
										for(Object[] 	obj:FormDetailsList){ %>
													   
								<tr>
									<td ><%=count %></td>
									<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
									<td>
											<input name="access"  value="<%=obj[0]%>"  onchange="UpdateIsActive('<%=obj[0]%>','<%=obj[5]%>','<%=obj[3]%>','<%=moduleid%>','<%=logintype%>');"  type="checkbox"  <%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("A")){ %> disabled <%} %> <%if(obj[3]!=null && obj[3].toString().equalsIgnoreCase("1")){ %>checked<%}%> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="105" data-height="15" data-on="<i class='fa fa-check' aria-hidden='true'></i> Active" data-off="<i class='fa fa-times' aria-hidden='true'></i> Inactive" >
											<input type="hidden" name="sample" value="attendance<%=count %>" >	
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									</td>
									<td>
											<div class="form-check form-check-inline">
											  <input class="form-check-input" type="radio" name="inlineRadioOptions<%=obj[0]%>"  onchange="radioChange(this,<%=obj[0] %>)" id="RadioL<%=obj[0]%>" value="L" <%if(obj[4]!=null && obj[4].toString().equalsIgnoreCase("L")){ %> checked <%} %>>
											  <label class="form-check-label" for="RadioL<%=obj[0]%>">Lab</label>
											</div>
											<div class="form-check form-check-inline">
											  <input class="form-check-input" type="radio" name="inlineRadioOptions<%=obj[0]%>" onchange="radioChange(this,<%=obj[0] %>)"  id="RadioH<%=obj[0]%>" value="H" <%if(obj[4]!=null && obj[4].toString().equalsIgnoreCase("H")){ %> checked <%} %> >
											  <label class="form-check-label" for="RadioB<%=obj[0]%>">HQ</label>
											</div>
											<div class="form-check form-check-inline">
											  <input class="form-check-input" type="radio" name="inlineRadioOptions<%=obj[0]%>" onchange="radioChange(this,<%=obj[0] %>)"  id="RadioB<%=obj[0]%>" value="B" <%if(obj[4]!=null && obj[4].toString().equalsIgnoreCase("B")){ %> checked <%} %> >
											  <label class="form-check-label" for="RadioB<%=obj[0]%>">Both</label>
											</div>
									</td>

								</tr>
 												
 								<%count++;}}else{ %>
 												
 								<tr>
 									<td colspan="3" class="text-center">No Forms Assigned</td>
 																						
 								</tr>
 												
 								<%} %>
 												
							</tbody>
      				
      				</table>
	           
			      </div>
			     
			    </div> 

			</div> <!-- card end -->
			
			

			
		</div>
	</div>
	
</div>




<script type='text/javascript'> 
function submitForm()
{ 
  document.getElementById('myform').submit(); 
} 

function UpdateIsActive(formroleaccsid, detailsid,isactive,moduleid,logintype)
{
	 $.ajax({

			type : "GET",
			url : "UpdateRoleAcess.htm",
			data : {
						formroleaccessid : formroleaccsid,
						detailsid        : detailsid,
						isactive         : isactive,
						moduleid         : moduleid,
						logintype        : logintype
				   },
			datatype : 'json',
			success : function(result) {

			var result = JSON.parse(result);
	
			var values = Object.keys(result).map(function(e) {
		 				 return result[e]
		  
							});
				}
				   
			});
}



/* function FormNameEdit(id){
		 $.ajax({

			type : "GET",
			url : "FormRoleActive.htm",
			data : {
						formroleaccessid : id
				   },
			datatype : 'json',
			success : function(result) {

			var result = JSON.parse(result);
	
			var values = Object.keys(result).map(function(e) {
		 				 return result[e]
		  
							});
				}
				   
			});
	 
} */



function radioChange(value,id){
	
	console.log(value.value );
	console.log(id);
	
 	$.ajax({
	
		type : "GET",
		url : "LabHqChange.htm",
		data : {
			
			labhqvalue : value.value,
			formroleaccessid : id
			
		},
		datatype : 'json',
		success : function(result) {

			var result = JSON.parse(result);
	
			var values = Object.keys(result).map(function(e) {
		 				 return result[e]
		  
							});
				}
	
		
	}); 
	
	
	
}


</script>





<script>
function deleteConfirm() {
var checkedValue=$("input[name='committeedivisionid']:checked").val();	

  if(checkedValue>0){
	  var txt;
	  var r = confirm("Are You Sure To Remove ?");
	  if (r == true) {
	    return true;
	  } else {
	    return false;
	  }  
  }else{
	  alert("Please Select Checkbox");
	  return false;
  }
  
}


function submitChecked() {
	var checkedValue=$("input[name='committeeid']:checked").val();	
	  if(checkedValue>0){
		  var txt;
		  var r = confirm("Are You Sure To Add !");
		  if (r == true) {
		    return true;
		  } else {
		    return false;
		  } 
		  
		 
	  }else{
		  alert("Please Select Checkbox");
		  return false;
	  }
	  
	}


</script>



<script type="text/javascript">

function Add(myfrm1){
	
	event.preventDefault();
	
	var date=$("#startdate").val();
	var time=$("#starttime").val();
	
	bootbox.confirm({ 
 		
	    size: "large",
		message: "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Add Schedule on "+date+" &nbsp;("+ time +") ?</b></center>",
	    buttons: {
	        confirm: {
	            label: 'Yes',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'No',
	            className: 'btn-danger'
	        }
	    },
	    callback: function(result){ 
	 
	    	if(result){
	    	
	    		$("sub").value;
	         $("#myfrm1").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}	
   
</script>


</body>
</html>