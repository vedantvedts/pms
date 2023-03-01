<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Project Requirement List</title>
<style>
label{
font-weight: bold;
  font-size: 13px;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


/* icon styles */

/* .cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
} */

.width{
	width:270px !important;
}

label{
    font-weight: 800;
    font-size: 16px;
    color: #07689f;
}
#cardbody{
padding-bottom:0px;
}
#cardbody1{
padding-top:0px;
padding-bottom:0px;
}

.card-body{
background-color:white;
}
#reqdiv{
 display: flex;
  align-items: center;
  justify-content: center; 
  min-width:100%;
}

#reqlabel{
 display: flex;
  align-items: center;
  justify-content: center; 
}





</style>
</head>
<body>
<%List<Object[]>RequirementTypeList=(List<Object[]>)request.getAttribute("RequirementTypeList"); 
String InitiationId=(String)request.getAttribute("InititationId");
String projectshortName=(String)request.getAttribute("projectshortName");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
%>

	<form class="form-horizontal" role="form" action="ProjectRequirementAddSubmit.htm" method="POST" id="myform" >
	<div class="container-fluid" >		
	<div class="row" >
		<div class="col-md-12" id="reqdiv">
		
			<div class="card shadow-nohover" style="min-width: 60%; margin-top:2%;box-shadow: 10px 10px 5px lightgrey;" >
			 <div class="card-header" style=" background-color: #055C9D;margin-top: ;padding:5px;">
                    <h3 class="text-white" style="margin-left:15px; margin-top:5px; ">Requirements</h3>
        		</div>
        			<div class="card-body"  id="cardbody">
        			<div class="row">
        			<div class="col-md-3" style="margin-left:1%" >
      				  <label style="font-size: 16px;margin-top: 5%;  margin-left: 0.1rem">Type of Requirement:<span class="mandatory" style="color: red;">*</span></label>
        			</div>

								<div class="col-md-3" style="margin-top: 5px">
									<div class="form-group">
										<select required="required" id="select" name="reqtype" class="form-control selectpicker" data-width="80%" data-live-search="true">
							<option disabled="disabled" value="" selected="selected">Choose..</option>
							<%if(!RequirementTypeList.isEmpty()){
							for(Object[] obj:RequirementTypeList){ %>
							<option value="<%=obj[0]+" "+obj[1]+" "+obj[3]%>"><%=obj[3]+"-"+obj[2]%></option>
							<%}} %>
							</select>
									</div>
								</div>
								
								<!--line added  -->
								<div class="col-md-2" style="display: flex;justify-content: end;">
      				  <label style="margin:10px; font-size:16px;">Priority:<span class="mandatory" style="color: red;">*</span></label>
        			</div>

								<div class="col-md-3" style="margin-top: 5px">
									<div class="form-group">
										<select required="required" id="select" name="priority" class="form-control selectpicker" data-width="80%" data-live-search="true">
							<option disabled="disabled" value="" selected="selected">Choose..</option>
							<option value="Low">Low</option>
							<option  value="Medium">Medium</option>
							<option  value="High">High</option>
							</select>
									</div>
								</div>
							</div>
        		
			</div>
			<!-- Line added  -->
			<div class="card-body"  id="cardbody">
        			<div class="row">
        			<div class="col-md-3" style="margin-left:1%"  >
      				  <label style="font-size: 16px;margin-top: 5%;  margin-left: 0.1rem">Linked Requirements<span class="mandatory" style="color: red;">*</span></label>
        			</div>

								<div class="col-md-5" style="margin-top: 5px">
									<div class="form-group">
											 <select class="form-control selectdee" name="linkedRequirements" id="linkedRequirements"  data-live-search="true"   data-placeholder="Choose" multiple required>
					
							<%if(!RequirementList.isEmpty()){
							for(Object[] obj:RequirementList){ %>
							<option value="<%=obj[1]%>"><%=obj[1]%></option>
							<%}} %>
							</select>
									</div>
								</div>
								</div>
								</div>
			
			

				<div class="card-body"  id="cardbody1">
        			<div class="row">
        			<div class="col-md-3"  >
      				  <label style="margin:10px ;font-size:16px">Requirement Brief:<span class="mandatory" style="color: red;">*</span></label>
        			</div>

								<div class="col-md-8" style="margin-top: 10px">
									<div class="form-group">
										<input type="text" name="reqbrief"class="form-control" id="reqbrief" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
									</div>
								</div>
							</div>
        		
			</div>
				<div class="card-body" id="cardbody1">
        			<div class="row">
        			<div class="col-md-4"  >
      				  <label style="margin:0px ;padding-left: 10px;font-size:16px">Requirement Description:<span class="mandatory" style="color: red;">*</span></label>
        			</div>

								<div class="col-md-11" id="textarea" style="margin-left: 10px">
									<div class="form-group">
										<textarea required="required" name="description" class="form-control"  id="description" maxlength="4000"  rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
									</div>
								</div>
							</div>
							<%-- <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> --%>
												<input type="hidden" name="IntiationId" value="<%=InitiationId %>" /> 
												<input type="hidden" name="projectshortName" value="<%=projectshortName %>" /> 
        										<div class="form-group" align="center" >
        										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
												<button type="submit" class="btn btn-primary btn-sm submit" name="action" value="SUBMIT" onclick= "return reqCheck('myform1');">SUBMIT</button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate" name="action" value="BACK" >
											</div>
			</div>
			</div>
			</div>
			</div>
			</div>
			</form>
		
 <script type="text/javascript">
function reqCheck(frmid){

	var description=$('#description').val();
	var reqbrief=$('#reqbrief').val();
	
	
	console.log(description.length)

	if(description===null||description===""||reqbrief===null||reqbrief===""){
		window.alert('Please fill all the fields');
	}else if
		(description.length>4000){
			var extra=description.length-4000;
			window.alert('Description exceed 4000 characters, '+extra+'characters are extra')
			return false;
		} 
	else{

	if(window.confirm('Are you sure to save?')){
		document.getElementById(frmid).submit(); 
	}else{
		event.preventDefault();
		return false;
	}
	}
}
</script> 
			
</body>
</html>