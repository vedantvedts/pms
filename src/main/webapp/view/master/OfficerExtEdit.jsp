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
<title>EXTERNAL OFFICER EDIT</title>

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
                    <b class="text-white">External Officer Edit</b>
        		</div>
<div class="card-body">


<form name="myfrm" action="OfficerExtEditSubmit.htm" method="POST" autocomplete="off">
<div class="row"> 
 
<div class="col-md-3">
              <div class="form-group">
					<label >Lab Name: <span class="mandatory" style="color: red;">*</span></label>
				    <select class="form-control selectdee" name="labId" data-container="body" data-live-search="true"  required="required"  style="font-size: 5px;"> 
							<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>
								<%  for ( Object[]  obj :LabList) {%>
								<%if(OfficerEditData.length==11){ %>
								<option value="<%=obj[2] %>" <%if(obj[2].equals(OfficerEditData[10])) {%> selected="selected"  <%} %>> <%=obj[2] %></option>
								<%}else{ %>
								<option value="<%=obj[2] %>" <%if(obj[2].toString().equalsIgnoreCase(seslabid)) {%> selected="selected" <%} %>> <%=obj[2] %></option>
								<%} %>
								<%} %>
				     </select> 
				</div>
</div> 
	
	 
<div class="col-md-2">
              <div class="form-group">
						<label >Employee No:<span class="mandatory" style="color: red;">*</span></label>
						<input  class="form-control form-control"  type="text" name="EmpNo" required="required" maxlength="255" style="font-size: 15px;" readonly	value="<%=OfficerEditData[1] %>">
				</div>
</div>



<div class="col-md-4">
              <div class="form-group">
						<label >Employee Name:<span class="mandatory" style="color: red;">*</span></label>
						<input  class="form-control form-control"  type="text" name="EmpName" required="required" maxlength="255" style=" font-size: 15px;text-transform: capitalize; width: 100%;" 	value="<%=OfficerEditData[2] %>">
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

</div>
<div class="row">

<div class="col-md-3">
              <div class="form-group">
					<label >Extension No:</label>
					<input  class="form-control form-control"  type="number" name="ExtNo" maxlength="5" style="font-size: 15px;width: 80%;" value="<%=OfficerEditData[4] %>">
				</div>
</div>


<div class="col-md-3">
              <div class="form-group">
					<label >Mobile No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="tex"   name="mobilenumber" required maxlength="10" style="font-size: 15px;width:100%" value="<%=OfficerEditData[9]%>" id="">
			  </div>
</div>


<div class="col-md-3">
              <div class="form-group">
					<label >Lab Email:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" name="Email" required="required" maxlength="255" style="font-size: 15px;width: 80%;" value="<%=OfficerEditData[5] %>">
			  </div>
</div>


<div class="col-md-3">
              <div class="form-group">
					<label >Drona Email:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="email" name="DronaEmail" required="required" maxlength="255" style="font-size: 15px;width:100%"  value="<%=OfficerEditData[7] %>" id="">
			</div>
</div>
</div>

<div class="row">

<div class="col-md-3">
              <div class="form-group">
					<label >Internet Email:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="email" name="InternetEmail" required="required" maxlength="255" style="font-size: 15px;width:100%" value="<%=OfficerEditData[8] %>"  id="">
			</div>
</div>


<div class="col-md-3">
              <div class="form-group">
					<label >Division:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width: 80%;">
									<option value="" disabled="disabled" selected="selected" hidden="true">--Select--</option>
										<%  for ( Object[]  obj :DivisionList) {%>
								     <option value="<%=obj[0] %>" <%if(OfficerEditData[6].toString().equalsIgnoreCase(obj[0].toString())) {%> selected="selected" <%} %>> <%=obj[1] %></option>
								     <%} %>
					</select> 
			  </div>
</div>
</div>

<div class="row">
<div class="col-sm-5" ></div>
	<div id="OfficerMasterAdd" ><input type="submit" onclick="return confirm('Are you Sure To Submit ?')" class="btn btn-primary btn-sm submit" /></div>
	<button type="button" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" onclick="submitForm('backfrm');" >Back</button>
</div>

	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}"  />
	
	<input type="hidden" name="OfficerId" value="<%=OfficerEditData[0]%>">
	<input type="hidden" name="labId" value="<%=seslabid%>">	
</form>
	
	<form action="OfficerExtList.htm" method="get" id="backfrm"></form>
	
	
	  </div>
	  </div>
	  </div>
	 
	
	 
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

<script type="text/javascript">
setPatternFilter($("#mobilenumber"), /^-?\d*$/);

function setPatternFilter(obj, pattern) {
	  setInputFilter(obj, function(value) { return pattern.test(value); });
	}

function setInputFilter(obj, inputFilter) {
	  obj.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
	    if (inputFilter(this.value)) {
	      this.oldValue = this.value;
	      this.oldSelectionStart = this.selectionStart;
	      this.oldSelectionEnd = this.selectionEnd;
	    } else if (this.hasOwnProperty("oldValue")) {
	      this.value = this.oldValue;
	      this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
	    }
	  });
	}

</script>

</body>
</html>