<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>LOGIN TYPE ADD</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}
.card b{
	font-size: 20px;
}


</style>
</head>
<body>

<%List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("DivisionList");
List<Object[]> RoleList=(List<Object[]>)request.getAttribute("RoleList");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmpList");
List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList");
%>




<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	
	
<div align="center">	

	<div class="alert alert-danger" role="alert">
           <%=ses1 %>
    </div>
    
	<%}if(ses!=null){ %>
	
	<div class="alert alert-success" role="alert" >
          <%=ses %>
    </div>
            
</div>
    
  <%} %>
	

	
<div class="container">
	<div class="row" style="">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Login Type Add</b>
        		</div>
        
        		<div class="card-body">


  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  
   <tr>
  <th>
<label >User Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="UserName" type="text" name="UserName" required="required" maxlength="255" style="font-size: 15px;"  id="UserNameCheck">
<div id="UserNameMsg" style="color: red;"></div>
<div id="UserNameSuccessMsg" style="color: green;"></div>

</td>
<td><input type="submit"  class="btn btn-primary btn-sm"        value="CHECK" id="check"/></td>
</tr> 
  </thead>
  </table>
  </div>
  </div>


<form name="myfrm" action="UserManagerAddSubmit.htm" method="POST" >
  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  style="width: 70%;">
  <thead>
   <tr>
  <th>
<label >User Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="UserName" type="text" name="UserName" required="required" maxlength="255" style="font-size: 15px;"  id="UserName" readonly="readonly">

	 
</td>

 <!--  <th >
<label >DIVISION:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : DivisionList) {
				%>
				<option value="<%=obj[0]%>"><%=obj[1]%></option>
				<%
					}
				%>

			</select> 
 
</td> -->
 <%-- <th>
<label >ROLE:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee" name="Role" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : RoleList) {
				%>
				<option value="<%=obj[0]%>"><%=obj[1]%></option>
				<%
					}
				%>

			</select> 
</td> --%>
</tr>

<tr>
  <th>
<label >Login Type:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee" name="LoginType" id="LoginType" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : LoginTypeList) {
				%>
				<option value="<%=obj[0]%>"><%=obj[1]%></option>
				<%
					}
				%>

			</select> 
 
</td></tr>
<tr>
 <th>
<label >Employee:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee" name="Employee" id="Employee" data-container="body" data-live-search="true"   style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : EmpList) {
				%>
				<option value="<%=obj[0]%>"><%=obj[1]%></option>
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

	  <div class="row" style="margin-left: 47%;" align="center"> 
	  <div id="UsernameSubmit" ><button type="submit"  class="btn btn-primary btn-sm submit"   onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button></div>
	  <a class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 0.5rem;"  href="UserManagerList.htm">Back</a>
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
$(document)
.ready(function(){
	 $("#check").click(function(){
			// SUBMIT FORM
		
		$('#UserNameSuccessMsg').html("");	
		$('#UserNameMsg').html("");	
		$('#UserName').val("");
		 $("#UsernameSubmit").hide();
			var $UserName = $("#UserNameCheck").val();
			if($UserName!=""&&$UserName.length>=4){
			
			$
					.ajax({

						type : "GET",
						url : "UserNamePresentCount.htm",
						data : {
							UserName : $UserName
						},
						datatype : 'json',
						success : function(result) {

							var result = JSON.parse(result);
						
							var s = '';
							if(result>0){
								s = "UserName Not Available";	
								$('#UserNameMsg').html(s);
							
								 $("#UsernameSubmit").hide();
							}else{
								$('#UserName').val($UserName);
								
								s = "UserName Available";	
								$('#UserNameSuccessMsg').html(s);
								
								 $("#UsernameSubmit").show();
							}
							
							
							
							
						}
					});

}else{
	
	var s = "Username Too Short";	
	$('#UserNameMsg').html(s);
	
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