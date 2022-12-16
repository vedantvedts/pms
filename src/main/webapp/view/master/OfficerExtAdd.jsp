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
<title>OFFICER MASTER ADD</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}




</style>
</head>
<body>

<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");


List<Object[]> DesignationList=(List<Object[]>)request.getAttribute("DesignationList");
List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("OfficerDivisionList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
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
	
 <div class="col-sm-8"  style="top:0px;">
<div class="card shadow-nohover"  >
<div class="card-header" style=" background-color: #055C9D;margin-top: ">
	<h4><b class="text-white">External Officer Add</b></h4>
</div>
<div class="card-body">


<form name="myfrm" id="myfrm" action="OfficerExtAddSubmit.htm" method="POST" >
<div class="row">

<div class="col-md-3">
              <div class="form-group">
					<label >Lab Name:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" id="labId" name="labId" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
									<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>
										<% for ( Object[]  obj :LabList) {%>
								<option value="<%=obj[2] %>"  > <%=obj[2] %></option><%} %>
					</select> 
			</div>
</div>
	
<div class="col-md-3">
              <div class="form-group">
					<label >Employee No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" id="EmpNo" name="EmpNo" required="required" maxlength="255" style="font-size: 15px;width:100%;text-transform: uppercase;"  >
			</div>
</div>


<div class="col-md-3">
              <div class="form-group">
					<label >Employee Name:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" id="EmpName" name="EmpName" required="required" maxlength="255" style="font-size: 15px;width:100%;text-transform: capitalize;" >
				</div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Designation:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" id="Designation" name="Designation" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
								<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>
								<%  for ( Object[]  obj :DesignationList) {%>
								<option value="<%=obj[0] %>"> <%=obj[2] %></option><%} %>
					</select> 
		</div>
</div>
</div>
<div class="row">

<div class="col-md-3">
              <div class="form-group">
					<label >Extension No:</label>
					<input  class="form-control form-control" type="number" id="ExtNo" name="ExtNo"  maxlength="4" style="font-size: 15px;width:100%"  >
			 </div>
</div>


<div class="col-md-3">
              <div class="form-group">
						<label >Mobile No: <span class="mandatory" style="color: red;">*</span></label>
						<input  class="form-control form-control" type="text" id="mobilenumber"   name="mobilenumber" required maxlength="10" style="font-size: 15px;width:100%"  >
				</div>
</div>


<div class="col-md-3">
              <div class="form-group">
						<label >Lab Email:<span class="mandatory" style="color: red;">*</span></label>
						<input  class="form-control form-control" type="email" id="Email" name="Email" required="required" maxlength="255" style="font-size: 15px;width:100%"  >
			  </div>
</div>

<div class="col-md-3">
              <div class="form-group">
						<label >Drona Email:</label>
						<input  class="form-control form-control" type="email" id="DronaEmail" name="DronaEmail"  maxlength="255" style="font-size: 15px;width:100%"  >
			  </div>
</div>
</div>

<div class="row">
<div class="col-md-3">
              <div class="form-group">
						<label >Internet Email:</label>
						<input  class="form-control form-control" type="email" id="InternetEmail"  name="InternetEmail"  maxlength="255" style="font-size: 15px;width:100%"  >
			 </div>
</div>

<div class="col-md-3">
              <div class="form-group">
						<label >Division:<span class="mandatory" style="color: red;">*</span></label>
						 <select class="form-control selectdee" id="Division" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
											<%  for ( Object[]  obj :DivisionList) {%>
									          <option value="<%=obj[0] %>"> <%=obj[1] %></option><%} %>
						</select> 
			 </div>
</div>

</div>
<div class="row">
<div class="col-sm-5" ></div>
	<div>
		<input type="button" value="SUBMIT" onclick="return empNoCheck('myfrm');" class="btn btn-primary btn-sm submit" /></div>
		<button type="submit" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" formaction="OfficerExtList.htm" formnovalidate="formnovalidate"  >BACK</button>
	</div>

	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	 
	 <div class="col-sm-2"></div> 
	 
	  </div>
	
</div>	

	 <form  method="get" id="backfrm">
	
		
	
	</form>
	

<script type="text/javascript">
	

function empNoCheck(frmid)
{
	var labId=$('#labId').val();
	var EmpName=$('#EmpName').val().trim();
	var Designation=$('#Designation').val();
	var ExtNo=$('#ExtNo').val().trim();
	var mobilenumber=$('#mobilenumber').val().trim();
	var Email=$('#Email').val().trim();	
	var DronaEmail=$('#DronaEmail').val().trim();
	var InternetEmail=$('#InternetEmail').val().trim();
	var Division=$('#Division').val();
	var $empno=$('#EmpNo').val().trim();
	
	if(labId=== "" || $empno==="" ||EmpName==="" ||Designation==="" ||  mobilenumber==="" || Email==="" || Division==="" ) /* ExtNo===null || DronaEmail==="" || InternetEmail==="" || */ 
	{
		alert('Please Fill All Mandatory Fields.');
		
	}else
	{
			$.ajax({
				
				type : "GET",
				url : "ExpEmpNoCheck.htm",
				data : {
					
					empno : $empno
					
				},
				datatype : 'json',
				success : function(result) {
					console.log(result);
					var count=0;
					
					if(Number(result) >= 1 ){
						
						alert('Employee No Already Exists');
						count++;
						return false;
					}
					if(count==0)
					{
						if(confirm('Are you Sure To Save ?'))
						{
							$('#'+frmid).submit();
						}
						else
						{
							return false;
						}
					}
				}
			});
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