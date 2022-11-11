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

</head>
<body>

<%

Object[] OfficerEditData=(Object[])request.getAttribute("OfficerEditData");
List<Object[]> DesignationList=(List<Object[]>)request.getAttribute("DesignationList");
List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("OfficerDivisionList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
String seslabid=(String)session.getAttribute("labid");


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
	
<div class="container-fluid">		
<div class="row"> 


<div class="col-sm-2"></div> 
	
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >
<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Officer Edit</b>
        		</div>
<div class="card-body">


<form name="myfrm" action="OfficerMasterEditSubmit.htm" method="POST" >
<div class="row">
<div class="col-md-3">
              <div class="form-group">
					<label >Employee No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" name="EmpNo" required="required" maxlength="255" style="font-size: 15px;" readonly	value="<%=OfficerEditData[1] %>">
			</div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Employee Name:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" name="EmpName" required="required" maxlength="255" style=" font-size: 15px;text-transform: capitalize; width: 80%;" onkeydown="return /[a-z ]/i.test(event.key)"	value="<%=OfficerEditData[2] %>">
				</div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Designation:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" name="Designation" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width: 80%;">
									<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>
										
											<%  for ( Object[]  obj :DesignationList) {%>			
											<option value="<%=obj[0] %>" <%if(OfficerEditData[3].toString().equalsIgnoreCase(obj[0].toString())) {%> selected="selected" <%} %>> <%=obj[2] %> </option>		
											<%} %>
					</select> 
			  </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Extension No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" name="ExtNo" required="required" maxlength="4" style="font-size: 15px;width: 80%;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" value="<%=OfficerEditData[4] %>">
				</div>
</div>
</div>

<div class="row">
<div class="col-md-3">
              <div class="form-group">
					<label >Mobile No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="text"  required="required" name="mobilenumber" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="font-size: 15px;width:100%" value="<%=OfficerEditData[9]%>" id="">
			   </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Lab Email: <span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="email" name="Email" required="required" maxlength="255" style="font-size: 15px;width: 80%;" value="<%=OfficerEditData[5] %>">
			  </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Drona Email: <span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="email" name="DronaEmail" required="required" maxlength="255" style="font-size: 15px;width:100%"  value="<%=OfficerEditData[7] %>" id="">
			  </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Internet Email:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="email" name="InternetEmail" required="required" maxlength="255" style="font-size: 15px;width:100%" value="<%=OfficerEditData[8] %>"  id="">
			  </div>
</div>
</div>

<div class="row">
<div class="col-md-3">
              <div class="form-group">
					<label >Division:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width: 80%;">
									<option value="" disabled="disabled" selected="selected" hidden="true">--Select--</option>
								<% for ( Object[]  obj :DivisionList) {%>
								<option value="<%=obj[0] %>" <%if(OfficerEditData[6].toString().equalsIgnoreCase(obj[0].toString())) {%> selected="selected" <%} %>> <%=obj[1] %></option>
								<%} %>
					</select> 
				</div>
</div>
</div>
<div class="row">
<div class="col-sm-5" ></div>
	<div id="OfficerMasterAdd" ><input type="submit"  class="btn btn-primary btn-sm submit" /></div>
	<button type="button" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" onclick="submitForm('backfrm');" >Back</button>
</div>

	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}"  />
	
	<input type="hidden" name="OfficerId" value="<%=OfficerEditData[0]%>">
	<input type="hidden" name="labId" value="<%=seslabid%>">	
</form>
	
	<form action="Officer.htm" method="get" id="backfrm">
	
		<%if(OfficerEditData.length==11){ %>	 
			<input type="hidden" name="empType" value="E">
		<%}else{ %>
			<input type="hidden" name="empType" value="I">
		<%} %>
	
	</form>
	
	
	  </div>
	  </div>
	  </div>
	 
	 <div class="col-sm-2"></div> 
	 
	  </div>
	
</div>	
	
	
	

<script type="text/javascript">
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 


function Edit(myfrm){
	
	 var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();	
	return false;
	}
	  var cnf=confirm("Are You Sure To Make Officer Inactive !");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}


</script>
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>