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

<spring:url value="/resources/css/admin/UserManagerAdd.css" var="userManagerAdd" />
<link href="${userManagerAdd}" rel="stylesheet" />
<title>LOGIN TYPE ADD</title>
</head>
<body>

<%List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("DivisionList");
List<Object[]> RoleList=(List<Object[]>)request.getAttribute("RoleList");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmpList");
List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList");
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
	

	
<div class="container">
	<div class="row" >

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" >
                    <b class="text-white">User Credentials Add</b>
        		</div>
        
        		<div class="card-body">


  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  
   <tr>
  <th>
<label >User Name:
<span class="mandatory" >*</span>
</label>
</th>
 <td >
<input  class="form-control form-control alphanum-no-leading-space input-font" placeholder="UserName" type="text" name="UserName" required="required" maxlength="255"  id="UserNameCheck">
<div id="UserNameMsg" class="mandatory"></div>
<div id="UserNameSuccessMsg" class="text-green"></div>

</td>
<td><input type="submit"  class="btn btn-primary btn-sm" value="CHECK" id="check"/></td>
</tr> 
  </thead>
  </table>
  </div>
  </div>


<form name="myfrm" action="UserManagerAddSubmit.htm" method="POST" >
  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed w-70" >
  <thead>
   <tr>
  <th>
<label >User Name:
<span class="mandatory" >*</span>
</label>
</th>
 <td >
<input  class="form-control form-control alphanum-no-leading-space input-font" placeholder="UserName" type="text" name="UserName" required="required" maxlength="255"   id="UserName" readonly="readonly">

	 
</td>


</tr>

<tr>
  <th>
<label >Login Type:
<span class="mandatory" >*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee font-5" name="LoginType" id="LoginType" data-container="body" data-live-search="true"  required="required">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : LoginTypeList) {
				%>
				<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
				<%
					}
				%>

			</select> 
 
</td></tr>
<tr>
 <th>
<label >Employee:
<span class="mandatory">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee font-5" name="Employee" id="Employee" data-container="body" data-live-search="true"  >
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : EmpList) {
				%>
				<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
				<%
					}
				%>

			</select> 
</td>
</tr>



</thead> 
</table>

</div>
</div>

	  <div class="row ml-47"  align="center"> 
	  <div id="UsernameSubmit" ><button type="submit"  class="btn btn-primary btn-sm submit"   onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button></div>
	  <a class="btn btn-info btn-sm shadow-nohover back ml-2"   href="UserManagerList.htm">Back</a>
	  </div> 
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
</div>
</div>
</div>	
	
</div>
<script type="text/javascript">

$(document).ready(function(){
	  $("#check").click(function(){
	  
	  });
	});
$("#UsernameSubmit").hide();
$(document).ready(function() {
    $("#check").click(function() {
        // Clear any previous messages
        $('#UserNameSuccessMsg').html("");    
        $('#UserNameMsg').html("");    
        $('#UserName').val("");  // Reset the username field
        $("#UsernameSubmit").hide();  // Hide the submit button initially

        var $UserName = $("#UserNameCheck").val();

        // Check if username is not empty and has minimum 4 characters
        if ($UserName !== "" && $UserName.length >= 4) {
            
            // Regular expression to check for special characters
            var regex = /^[a-zA-Z0-9]+$/;  // Allows only Alphabets and Numbers
            
            // Check if username contains only alphabets and numbers (No special characters)
            if (!regex.test($UserName)) {
                var s = "Username must only contain alphabets and numbers (No special characters allowed).";    
                $('#UserNameMsg').html(s);  // Show error message
                $("#UsernameSubmit").hide();  // Hide the submit button
                return;  // Exit function if username is invalid
            }

            // Proceed with the AJAX call if username is valid
            $.ajax({
                type: "GET",
                url: "UserNamePresentCount.htm",
                data: {
                    UserName: $UserName
                },
                datatype: 'json',
                success: function(result) {
                    var result = JSON.parse(result);

                    var s = '';
                    if (result > 0) {
                        s = "UserName Not Available";    
                        $('#UserNameMsg').html(s);  // Show the not available message
                        $("#UsernameSubmit").hide();  // Hide the submit button
                    } else {
                        $('#UserName').val($UserName);  // Set the valid username
                        s = "UserName Available";    
                        $('#UserNameSuccessMsg').html(s);  // Show the available message
                        $("#UsernameSubmit").show();  // Show the submit button
                    }
                }
            });

        } else {
            var s = "Username Too Short (Minimum 4 characters required)";    
            $('#UserNameMsg').html(s);  // Show the too short message
            $("#UsernameSubmit").hide();  // Hide the submit button
        }
    });
});



$(document)
.on(
		"change",
		"#LoginType",

		function() {
			// SUBMIT FORM

	
			var $LoginType = this.value;

		
		
			if($LoginType=="D"||$LoginType=="G"||$LoginType=="T"||$LoginType=="O"||$LoginType=="B"||$LoginType=="S"||$LoginType=="C"||$LoginType=="P"||$LoginType=="U"){
			
				$("#Employee").prop('required',true);
			}
			else{
				$("#Employee").prop('required',false);
			}
	
		});

</script>
</body>
</html>