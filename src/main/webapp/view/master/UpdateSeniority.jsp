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
<title>OFFICER DETAILS</title>
<style type="text/css">

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
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] officerData=(Object[])request.getAttribute("officersDetalis");
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
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header"style="background-color: #055C9D; margin-top:">
					<b class="text-white">Update Seniority</b>
				</div>
				
				<form action="UpdateSenioritySubmit" method="post">
				  				<div class="card-body">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-1">
							<label class="control-label">SrNo :</label> 
							<input class="form-control " type="number" min="0" name="UpdatedSrNo"  onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" id="SrNo" value="<%=officerData[9]%>">
							<input type="hidden" name="empid" value="<%=officerData[0]%>" >					
						</div>
						<div class="col-md-2">
							<label class="control-label">Employee No :</label> 
							<input class="form-control " value="<%=officerData[1]%>"  readonly="readonly">
						</div>
						<div class="col-md-3">
							<label class="control-label">Employee Name :</label> 
							<input class="form-control " value="<%=officerData[2]%>"  readonly="readonly">
						</div>
						<div class="col-md-2">
							<label class="control-label">Designation  :</label> 
							<input class="form-control " value="<%=officerData[3]%>" readonly="readonly">
						</div>
						

                        <div class="col-md-2">
							<label class="control-label">Division :</label> 
							<input class="form-control " value="<%=officerData[6]%>" readonly="readonly">
						</div>
				
						
					</div>
                   <div class="row" style="margin-top:1.5rem;" >
                       <div class="col-md-5"></div>
                         <div class="col-md-2">
                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                      <button class="btn btn-sm submit" type="submit" id="UpdateSenioritySubmit" style="margin-left: 10%"   onclick="return confirm('Are You Sure To Submit!')"> Submit</button>
                      <a class="btn btn-sm back" href="Officer.htm" >Back</a>
                      </div>
                   </div>
				</div>
				</form>
			</div>
		</div>

	</div>
<script type="text/javascript">
$(document).ready(function(){
    $("#SrNo").numeric();
})
</script>
</body>
</html>