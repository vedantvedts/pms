<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
    <%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>DIVISION MASTER ADD</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	width:30%;
}

.table thead tr td {

	text-align: left;
}

label{
	font-size: 15px;
}


table{
	box-shadow: 0 4px 6px -2px gray;
}


 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}





/* icon styles */

.cc-rockmenu {
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
}

.width{
	width:270px !important;
}





</style>
</head>
<body>

<%

List<Object[]> DivisionGroupListAdd=(List<Object[]>)request.getAttribute("DivisionGroupListAdd");
List<Object[]> DivisionHeadListAdd=(List<Object[]>)request.getAttribute("DivisionHeadListAdd");


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
<div class="card shadow-nohover" >
<div class="card-header" style=" background-color: #055C9D;margin-top: "> <b class="text-white">Division Add </b></div>

<div class="card-body">

<form name="myfrm" action="DivisionMasterAddSubmit.htm" id="divisionAdd" method="POST" >

<div class="row">

<div class="col-md-3">
         <div class="form-group">
				<label >Division Code:<span class="mandatory" style="color: red;">*</span></label>
				<input  class="form-control form-control"  type="text" name="dCode" id="divisionCode" required="required" maxlength="3" style="font-size: 15px;"> 
	     </div>
</div>		

<div class="col-md-3">
		<div class="form-group">
                 <label>Division Name:<span class="mandatory" style="color: red;">*</span></label>
                  <input  class="form-control form-control"  type="text" name="dName" id="divisionName" required="required" maxlength="100" style=" font-size: 15px;text-transform: capitalize; width: 80%;" > 
		</div>
</div>

<div class="col-md-3">
		<div class="form-group">
				<label >Group Name:<span class="mandatory" style="color: red;">*</span></label>
				<select class="custom-select" id="grpId" required="required" name="grpId">
								<option selected value="">Choose...</option>
								
								<% for (  Object[] obj : DivisionGroupListAdd){ %>
						
								<option value=<%=obj[0]%>><%=obj[1]%> </option>
							
								<%} %>
				</select>
		</div>
</div>
   
<div class="col-md-3">
		<div class="form-group">
				<label >Division Head Name:<span class="mandatory" style="color: red;">*</span></label>
				<select class="custom-select" id="dHName" required="required" name="dHName">
								<option  selected value="">---Select---</option>
								
								<% for (  Object[] obj : DivisionHeadListAdd){ %>
						
								<option value=<%=obj[0]%>><%=obj[1]%>, <%=obj[3] %> </option>
							
								<%} %>
				</select>
		</div>
</div>
   
</div><!-- row closed -->

<!-- srikant code start -->
<div class="row">
<div class="col-md-3">
		<div class="form-group">
                 <label>Division Short Name:<span class="mandatory" style="color: red;">*</span></label>
                  <input  class="form-control form-control"  type="text" name="divisionShortName" id="divisionShortName" placeholder="Division Short Name" id="divisionShortName" required="required" maxlength="100" style=" font-size: 15px;text-transform: capitalize;" > 
		</div>
</div>
</div>
<!-- srikant code end -->
   
	<div align="center">
		<button type="button" class="btn btn-sm submit" style="align-self: center;" onclick="Divisioncheck('divisionAdd');" >SUBMIT</button>
		<a class="btn  btn-sm  back"    href="DivisionMaster.htm">BACK</a>
	</div>

	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
	  </div>
	  </div>
	  </div>
	 <div class="col-sm-2"></div> 
	  </div>
</div>	
	
					
<script type='text/javascript'> 
$(document).ready(function() {
    $('#grpId').select2();
    $('#dHName').select2();
});
</script>
</body>

<script type="text/javascript">


function Divisioncheck(frmid){
	
	var count=0;
	var divisionCode=$('#divisionCode').val();
	
	if(divisionCode.trim()=="")
	{
		alert('Please fill all the fields !');	
		return false;
	}
	
	
	
	$.ajax({

		type : "GET",
		url : "DivisionAddCheck.htm",
		data : {
			
			dcode:divisionCode.trim(),
			
		},
		datatype : 'json',
		success : function(result) {
			var ajaxresult = JSON.parse(result);
			if(ajaxresult[0]>=1){							
				alert('Division Code Already Exists');		
				event.preventDefault();
				return false;
			}
			else if(count===0){	
				/* console.log($('#grpId').val());
				console.log($('#dHName').val()); */
				if(	$('#divisionCode').val().trim()=="" ||
						$('#divisionName').val().trim()=="" || 
						$('#grpId').val().trim()=="" ||
						$('#divisionShortName').val().trim()=="" || //srikant
						$('#dHName').val().trim()=="" )
					{
						alert('Please fill all the fields !');	
						return false;
					}
				
				
				if(confirm('Are you Sure To Submit ?'))
				{
					$('#'+frmid).submit();
				}	
			} 
			
			
		}
	});	
	
	
}



</script>


</html>