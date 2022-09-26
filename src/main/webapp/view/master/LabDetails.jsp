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
<title>GROUP MASTER EDIT</title>
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


List<Object[]> groupheadlist=(List<Object[]>)request.getAttribute("groupheadlist");


List<Object[]> labmasterdata=(List<Object[]>)request.getAttribute("labmasterdata");


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
	
<div class="container">		
<div class="row">


<div class="col-md-12">
  
 <div class="card shadow-nohover" >
<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <h5 class="text-white" ><b>Lab Details</b></h5>
</div>
<div class="card-body"> 
    <form action="#" method="POST" name="frm1">
    
    

<div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  
<%for(Object[] obj:labmasterdata){ %>

<tr>
  <th style="width:20%" colspan="3">
<label >Lab Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 
<input value=<%=obj[1]%>  readonly class="form-control form-control" type="text" name="LabCode" required="required" maxlength="10" style="font-size: 15px; "  id="LabCode" >

 
</td>

</tr>


<tr>
 <th colspan="3" >
<label >Lab Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5">
 
  	<input  class="form-control form-control" type="text" name="LabName" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;" value="<%=obj[2]%>" readonly >
 

</td>

</tr>


<tr>

<th colspan="3" >
<label >Lab Unit Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5">
 
 <input  value=<%=obj[3]%> readonly class="form-control form-control" type="text" name="" required="required" maxlength="100" style="font-size: 15px;text-transform:capitalize;"  id="LabAddress">

</td>
</tr>


<tr>
<th colspan="3" >
<label >Lab Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 
 <input  value="<%=obj[4]%>"  readonly class="form-control form-control"  type="text" name="LabAddress" required="required" min='1'   maxlength="255" style="font-size: 15px;"  id="LabAddress">

</td>


</tr>


<tr>

<th colspan="3" >
<label >Lab City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5">
 
<input  value=<%=obj[5]%>  readonly class="form-control form-control"  type="text" name="LabCity" required="required" maxlength="255" style="font-size: 15px;"  id="">

</td>

</tr>


<tr>
 <th colspan="3" >
<label >Lab Pin:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 
<input  value=<%=obj[6]%>  readonly class="form-control form-control" type="number" name="LabPin" required="required" maxlength="255" style="font-size: 15px;"  id="">
<input type="hidden" name="Did" value=<%=obj[0]%>  >
 <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}"  />
	 

</td>


</tr>
<tr>
<td colspan="7"  ><button type="submit" style="display: block; margin: auto;" class="btn btn-warning btn-sm edit"  name="sub" value="edit"   >EDIT</button></td>
</tr>

<%} %>

</thead> 
</table>

</div>


</form>
	</div></div></div></div>
</div>	
	
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
<script>
  $(document).ready(function(){
	  $('#ghempid').select2();
  });
</script>
</html>