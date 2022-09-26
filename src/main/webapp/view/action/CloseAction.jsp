<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 

<title>New Action</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}
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
	width:150px !important;
}
</style>
</head>
 
<body>
<%
  String ActionMainId=(String)request.getAttribute("ActionMainId");
  Object[] Assignee=(Object[])request.getAttribute("Assignee");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
%>
	
   
	<div class="container-fluid">
		<div class="container" style="margin-bottom:20px;">	
    		<div class="card">   	
	    		<div class="card-header" style="background-color: #055C9D;">
		    		<div class="row"> 
		                <div class="col-sm-5" align="left"  >
		      				<h6 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left">
			      				Action 
			      			</h6>
			  	        </div>     
			  	        <div class="col-sm-7" align="right" style="color: white;font-weight: bold;font-size: 1.2rem !important " >       
			  	        		Action Id : <%=Assignee[10] %>
						</div>
					</div>
      			</div>
      		
	      		<div class="card-body">
	      				<div class="row">
	      					<div class="col-md-12">
	      						<table style="width: 100%;">
	      							<tr>
	      								<td style="width: 15%;">
	      									<label style="font-size: medium; padding-top: 10px;  "> Action Item  :</label>
	      								</td>	      	
	      								<td >&nbsp;&nbsp;&nbsp;&nbsp;
	      									 <%=Assignee[5] %>
	      								</td>							
	      							</tr>
	      						</table>
	      						<table>
	      							<tr>
	      								<td>
	      									<label style="font-size: medium; padding-top: 10px;  "> Assignee  :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=Assignee[12] %>
	      								</td>
	      								<td style="padding-left: 50px;" >
	      									<label style="font-size: medium; padding-top: 10px;  "> Assigner :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=Assignee[1]%>
	      								</td>	
	      								<td style="padding-left: 50px;" >
	      									<label style="font-size: medium; padding-top: 10px;  "> PDC (Current) :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=sdf.format(Assignee[4])%>
	      								</td>	
	      							</tr>
	      							<tr>
	      								<td>
	      									<label style="font-size: medium; padding-top: 10px;  "> PDC Original :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=sdf.format(Assignee[14])%>
	      								</td>	
	      								     
	      							<% int revision=Integer.parseInt(Assignee[11].toString());
	      							for(int i=1;i<=revision;i++){ %>
	      							
	      								<td style="padding-left: 50px;" >
	      									<label style="font-size: medium; padding-top: 10px;  "> Revision - <%=i%> :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=sdf.format(Assignee[15+i-1])%>
	      								</td>	
	      							
	      							<%} %>
	      							</tr>	
	      						</table>      						      					
	      					</div>      				
	      				</div>      		
	      				<br>		
	      				<hr>
	      				<br>
	      			<form method="post"  action="ExtendPdc.htm" >
	          			<div class="row"> 
							<div class="col-md-2"><label style="font-size: medium; padding-top: 10px;  " >Remarks:</label></div>	
							<div class="col-md-7">
								<textarea rows="2" style="display:block; margin-top: -15px;" class="form-control"  id="Remarks" name="Remarks"  placeholder="Enter Remarks..!!"  ></textarea>
							</div>
							<div class="col-md-3">
								<button type="submit" class="btn btn-danger btn-sm revoke" name="sub" value="C"  onclick="return confirm('Are You Sure To Submit ?')" formaction="CloseSubmit.htm"> Close Action</button>
								<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" />	
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
							</div>
						</div>						
	      			</form>	      			      			      			
	    		
	    		<%if(Integer.parseInt(Assignee[11].toString())<2){ %> 
	    		<br>
	    		<hr><br>
	    		<form method="post"  action="ExtendPdc.htm" >
	          			<div class="row"> 
							
							<div class="col-sm-2" >
                            	<label>Extend PDC: <span class="mandatory" style="color: red;">* </span></label>
                            </div>
                            <div class="col-sm-2"  >
                            	<input class="form-control " name="ExtendPdc" id="DateCompletion" required="required"  value="<%=sdf.format(Assignee[4])%>" style=" margin-top: -4px;">
                            </div>
							<div class="col-md-4">
								<button type="submit" class="btn btn-danger btn-sm submit"   onclick="return confirm('Are You Sure To Submit ?')" > Extend PDC</button>
								<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" />	
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
							</div>
						</div>
	      			</form>
	      			<br>
	      			<hr>
	      			<%} %>
	    		
	    		</div>
	    		<div align="center" style="padding-bottom: 15px;" ><a  class="btn btn-primary btn-sm back"  href="ActionLaunch.htm">BACK</a></div>
    		</div>
    		<div class="card-header" style="background-color: #055C9D; height: 50px;">
		    	<div class="row"> 
		               
				</div>
      		</div>
  	 	</div>   
	</div>
   

<script>
var from ="<%=sdf.format(Assignee[4])%>".split("-");
var dt = new Date(from[2], from[1] - 1, from[0]);
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : dt,
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
</script>  


</body>
</html>