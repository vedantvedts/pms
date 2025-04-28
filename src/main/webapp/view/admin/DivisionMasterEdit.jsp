<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>OFFICER MASTER EDIT</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}



label{
	font-size: 15px;
}


</style>
</head>
<body>

<%

List<Object[]> DivisionGroupList=(List<Object[]>)request.getAttribute("DivisionGroupList");

List<Object[]> DivisionHeadList=(List<Object[]>)request.getAttribute("DivisionHeadList");


Object[] DivisionMasterEditData=(Object[])request.getAttribute("DivisionMasterEditData");


%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	
<br>	
	
<div class="container-fluid">		
<div class="row"> 


<div class="col-sm-2"></div> 
	
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >
<div class="card-header" style=" background-color: #055C9D;margin-top: "> <b class="text-white">Division Master Edit</b></div>
<div class="card-body">


<form name="myfrm" action="DivisionMasterEditSubmit.htm" id="editCheck" method="POST" >
<div class="row">

<div class="col-3">
       <div  class="form-group">	
				<label >Division Code: <span class="mandatory" style="color: red;">*</span></label>
				<input  class="form-control alphanum-only" type="text" name="DivisionCode" required="required" maxlength="3" style="font-size: 18px;"  readonly	 value="<%=DivisionMasterEditData[1]%>" >
       </div>
</div>


<div class="col-3">	
       <div class="form-group"> 
				<label >Division Name:<span class="mandatory" style="color: red;">*</span></label>
				<input  class="form-control form-control alphanum-no-leading-space" type="text" name="DivisionName" required="required" maxlength="255" style="font-size: 18px;" value="<%=DivisionMasterEditData[2]%>">
		</div>
</div>


<div class="col-3">
       <div  class="form-group">
					<label >Group Name:<span class="mandatory" style="color: red;">*</span></label>
					 <select class="custom-select " name="GroupId"  required="required" id="GroupId" style="font-size: 18px;">
									<option value="" disabled="true" selected="selected" hidden="true">--Select--</option>
									
									<% for (  Object[] obj : DivisionGroupList){ %>
									<option value=<%=obj[0]%> <%if(obj[0].toString().equalsIgnoreCase(DivisionMasterEditData[4].toString())) {%> selected="selected"  <%} %>><%=obj[1]%> </option>
									<%} %>
					</select> 
		</div>
</div>



<div class="col-3">
       <div  class="form-group">	
					<label >Division Head Name:<span class="mandatory" style="color: red;">*</span></label>
					<select class="custom-select" name="DivisionHeadName"  required="required" id ="DivisionHeadName" style="font-size: 18px;">
						<option value="" disabled selected="selected">--Select--</option>
									
			<% for (  Object[] obj : DivisionHeadList){ %>							
			<option value=<%=obj[0]%> <%if(obj[0].toString().equalsIgnoreCase(DivisionMasterEditData[3].toString())) {%> selected="selected" <%} %>><%=obj[1]%>, <%=obj[3]%> </option><%}%>
					</select> 
		</div>
</div>
</div>
<div class="row">
<div class="col-3">
       <div  class="form-group">		
				<label >isActive:<span class="mandatory" style="color: red;">*</span></label>
				<select  class="form-control selectpicker"  name="isActive" required="required" maxlength="255" style="font-size: 18px;" > 
				                     <option value="1" <%if(DivisionMasterEditData[5].toString().equalsIgnoreCase("1")) {%> selected="selected" <%} %> >YES</option>                      
									 <option value="0" <%if(DivisionMasterEditData[5].toString().equalsIgnoreCase("0")) {%> selected="selected" <%} %> >NO</option>                     
				</select>                 
		</div>
</div> 
<!-- srikant code start -->
<div class="col-3">
        <div class="form-group"> 
				<label >Division Short Name:<span class="mandatory" style="color: red;">*</span></label>
				<input class="form-control form-control alphanum-no-leading-space" type="text" name="DivisionShortName" id="DivisionShortName" required="required" maxlength="255" style="font-size: 18px;" 
       value="<%= DivisionMasterEditData[6] != null ? DivisionMasterEditData[6] : "" %>">


		</div>
</div>
<!-- srikant code end -->
</div>


<div align="center">
		<button type="submit" class="btn btn-sm submit" style="align-self: center;" onclick="return confirm('Are you Sure To Submit ?');" >SUBMIT</button>&nbsp;&nbsp;
		<a class="btn  btn-sm  back"    href="DivisionMaster.htm">BACK</a>
</div>

<input type="hidden" name="DivisionId"                  value="<%=DivisionMasterEditData[0]%>" />
<input type="hidden" name="${_csrf.parameterName}" 	value="${_csrf.token}"  />
	
	
</form>
	
	
	      </div>
	    </div>
	  </div>
    </div>
</div>
	
	
	

</body>
<script>
  $(document).ready(function(){
	  $('#DivisionHeadName').select2();
	  $('#GroupId').select2();
  });
</script>
</html>