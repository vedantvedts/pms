<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
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
 

<title>FRACAS</title>

<title> ADD COMMITTEE</title>
	<style type="text/css">
		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
	</style>
<style type="text/css">

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
  width: 120px;
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
 	FormatConverter fc=new FormatConverter(); 
	SimpleDateFormat sdf=fc.getRegularDateFormat();
	SimpleDateFormat sdf1=fc.getSqlDateFormat();
	
  List<Object[]>  projectslist=(List<Object[]>)request.getAttribute("projectlist");
  List<Object[]>  fracastypelist=(List<Object[]>)request.getAttribute("fracastypelist");
  String projectid=(String)request.getAttribute("projectid");
  String filesize=(String) request.getAttribute("filesize");
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>
  
    
    
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Add FRACAS Item</h4>
				</div>
				<div class="card-body">
					<form method="post" action="FracasMainAddSubmit.htm" enctype="multipart/form-data" >
							<div class="row">							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Project</label>
										<%if(projectid==null || projectid.equals("null") ) {%>
											<select class="form-control selectdee" id="projectid" name="projectid" required >
												<option value="0">General</option>											
												<%for(Object[] obj:projectslist){ %>	
													<option value="<%=obj[0]%>"><%=obj[1]%></option>	
												<%} %>
											</select>
										<%}else if(Long.parseLong(projectid)>=0){%>
											<select class="form-control selectdee" id="projectid" name="projectid" required >
												<%for(Object[] obj:projectslist){ %>
													<%if(projectid.equals(obj[0].toString())){ %>	
														<option value="<%=obj[0]%>" selected><%=obj[1]%></option>	
													<%} %>
												<%} %>
											</select>
										<%} %>
									</div>
								</div>
										
										
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Type</label>
										<select class="form-control" id="fracastypeid" name="fracastypeid" required>
											<option selected disabled="disabled"> Choose...</option>
											<%for(Object[] obj:fracastypelist){ %>	
												<option value="<%=obj[0]%>"><%=obj[1]%></option>	
											<%} %>
										</select>
									</div>
								</div>
								
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Attachment</label>
										<input type="file" class="form-control " name="attachment" id="attachment"  onchange="Filevalidation('attachment');" >
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Date</label>
										<input class="form-control " name="date" id="date" required >
									</div>
								</div>
								<div class="col-md-8">
									<div class="form-group">
										<label class="control-label">FRACAS Item</label>
										<input class="form-control" type="text" name="fracasitem" id="fracasitem" required maxlength="150"  >
									</div>
								</div>
							</div>
						
							<div class="row">
								<div class="col-md-4"> </div>
								<div class="col-md-4" align="center">
									<button type="submit" class="btn btn-sm btn-primary submit"  onclick="return editcheck('attachment');">SUBMIT</button>
									<button type="button" class="btn btn-sm btn-primary back" onclick="submitForm()" >BACK</button>
								 </div>
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
				<div class="card-footer"><br>
				</div>
			</div>
		</div>	
	</div>
</div>
 <br>
 
<!--  <div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Add FRACAS Item</h4>
				</div>
				<div class="card-body">
					<div class="row" >
						<table  class="table table-bordered table-hover table-striped table-condensed "  id="myTable">
							<tr>
								<th>SN.</th>
								<th>Project</th>
								<th>Type</th>
								<th>Item</th>
								<th>Assignee</th>
								<th>PDC</th>
							</tr>
						
						</table>											
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
  -->
 
 
 <%=projectid %>
 
 <%if(projectid!=null){ %>
 <form action="FracasMainItemsList.htm" method="post" id="backfrm">	
	<input type="hidden" name="projectid" value="<%=projectid %>" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
</form>
 <%}else{ %>
  <form action="MainDashBoard.htm" method="get" id="backfrm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
</form>
<%} %>
 
 
 
 
<script type="text/javascript">
function editcheck(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(editfileid).files.length !=0 && file >= <%=filesize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=filesize%> mb");
    } else
    {
    	return confirm('Are you Sure To Add this FRACAS Item?');
    }
}
</script>
 
 
 
 <script type="text/javascript">
function submitForm()
{ 
  document.getElementById('backfrm').submit(); 
} 
</script>
 
 
 
 <script type="text/javascript">
 
	$('#date').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
 
 </script>
 
 <script type="text/javascript">
						
			    Filevalidation = (fileid) => 
			    {
			        const fi = $('#'+fileid )[0].files[0].size;							 	
			        const file = Math.round((fi / 1024/1024));
			        if (file >= <%=filesize%>) 
			        {
			        	alert("File too Big, please select a file less than <%=filesize%> mb");
			        } 
			    }
						
</script>
 
 
</body>
</html>