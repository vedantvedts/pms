<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/LoginTypeEdit.css" var="loginTypeEdit" />
<link href="${loginTypeEdit}" rel="stylesheet" />

<title>LOGIN TYPE Edit</title>
</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> LoginTypeList=(List<Object[]>) request.getAttribute("LoginTypeList");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
List<Object[]> RoleList=(List<Object[]>) request.getAttribute("RoleList");
DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
Object[] LoginTypeEditData=(Object[]) request.getAttribute("LoginTypeEditData");
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

<br>
	
<div class="container">
	<div class="row">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header bg-header" >
                    <b class="text-white">Login Type Edit</b>
        		</div>
        
        		<div class="card-body">
        			<form action="LoginTypeEditSubmit.htm" method="POST" name="myfrm" id="myfrm">
                		<div class="row">

                    		<div class="col-md-4 ">
                        		<div class="form-group">
                            		<label class="control-label">Username (Employee)</label>
                              		 <input  class="form-control form-control"  type="text"   readonly   value="<%=(LoginTypeEditData[0]) %> (<%=(LoginTypeEditData[1]!=null?StringEscapeUtils.escapeHtml4(LoginTypeEditData[1].toString()): " - ") %>)">
                        		</div>
                    		</div> 
               
         					<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Role</label>
    								<select class="custom-select" id="RoleId" required="required" name="RoleId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : RoleList) {%>
												<option value="<%=obj[0]%>" <%if(LoginTypeEditData[3].toString().equalsIgnoreCase(obj[1].toString())){ %> selected="selected" <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    
                    
                </div>

            
      	
         
        <div class="form-group" align="center" >
			
			
	 		<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  > 
			<!--  <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm"  >Back</a> -->
		
		</div>

	<input type="hidden" name="LoginId" value="<%=LoginTypeEditData[4] %>">
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 	</form>
        
     </div>`     
        




<div class="card-footer bg-footer">
         
       
        </div>
        </div>
</div>
</div>
</div>	
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
	
function Add(myfrm){
	
	event.preventDefault();
	
	bootbox.confirm({ 
 		
	    size: "small",
			message: "<center><i class='fa fa-trash-o fa-3x' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure ?</b></center>",
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
	         $("#myfrm").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}


$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})



</script>
</body>
</html>