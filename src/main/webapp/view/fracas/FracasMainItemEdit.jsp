<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
 

<title>Edit FRACAS</title>

<title> Edit COMMITTEE</title>
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
  String filesize=(String) request.getAttribute("filesize");
  Object[] fracasitemdata=(Object[])request.getAttribute("fracasitemdata");
%>



<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>
  
    
    
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Edit FRACAS Item</h4>
				</div>
				<div class="card-body">
					<form method="post" action="FracasMainEditSubmit.htm" enctype="multipart/form-data" >
							<div class="row">							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Project</label>
										<%-- <%if(projectid==null || projectid.equals("null") ) {%>
											<select class="form-control selectdee" id="projectid" name="projectid" required >
												<option value="0">General</option>											
												<%for(Object[] obj:projectslist){ %>	
													<option value="<%=obj[0]%>"><%=obj[1]%></option>	
												<%} %>
											</select>
										<%}else if(Long.parseLong(projectid)>=0){%> --%>
											<select class="form-control selectdee" id="projectid" name="projectid" required >
												<%if(fracasitemdata[4].toString().equals("0")){ %>
												<option selected value="0">General</option>							
												<%} %>				
												<%for(Object[] obj:projectslist){ %>
													<%if(fracasitemdata[4].toString().equals(obj[0].toString())){
														String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
														%>	
														<option value="<%=obj[0]%>" selected><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "+projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName): " - "%></option>	
													<%} %>
												<%} %>
											</select>
										<%-- <%} %> --%>
									</div>
								</div>
										
										
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Type</label>
										<select class="form-control" id="fracastypeid" name="fracastypeid" required>
											<option selected disabled="disabled"> Choose...</option>
											<%for(Object[] obj:fracastypelist){ %>	
												<option <%if(fracasitemdata[1].toString().equals(obj[0].toString())){ %>selected <%} %> value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>	
											<%} %>
										</select>
									</div>
								</div>
								
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Attachment
										<%if(fracasitemdata[7]!=null){ %>
											<button type="button" class="btn btn-sm" style="align: center;margin-top: -5px; " onclick="submitForm('downloadfrm')" ><i class="fa fa-download"></i></button>
										<%} %>
										</label>
										<input type="file" class="form-control " name="attachment" id="attachment" onchange="Filevalidation('attachment');" >
									</div>
								</div>
							
							</div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Date</label>
										<input class="form-control " name="date" id="date" required value="<%= sdf.format(sdf1.parse( fracasitemdata[3].toString() ))%>" >
									</div>
								</div>
								<div class="col-md-8">
									<div class="form-group">
										<label class="control-label">FRACAS Item</label>
										<input class="form-control" type="text" name="fracasitem" id="fracasitem" required maxlength="150"  value="<%=fracasitemdata[2]!=null?StringEscapeUtils.escapeHtml4(fracasitemdata[2].toString()): "" %>" >
									</div>
								</div>
							</div>
						
							<div class="row">
								<div class="col-md-4"> </div>
								<div class="col-md-4" align="center">
									<button type="submit" class="btn btn-sm btn-primary submit"  onclick="return editcheck('attachment');">SUBMIT</button>
									<button type="button" class="btn btn-sm btn-primary back" onclick="submitForm('backfrm')" >BACK</button>
								 </div>
							</div>
							<%if(fracasitemdata[7]!=null){ %>
								<input type="hidden" name="fracasmainattachid" value="<%=fracasitemdata[7] %>" >
							<%} %>
							<input type="hidden" name="fracasmainid" value="<%=fracasitemdata[0] %>" >
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
 
	<%if(fracasitemdata[7]!=null){ %>
		<form action="FracasAttachDownload.htm" method="post" target="_blank" id="downloadfrm" >			
			<input type="hidden" name="fracasattachid" value="<%= fracasitemdata[7] %>">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
	<%}%>

 
 <form action="FracasMainItemsList.htm" method="post" id="backfrm">	
	<input type="hidden" name="projectid" value="<%=fracasitemdata[4] %>" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
</form>
 
 
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
    	return confirm('Are you Sure To Edit this FRACAS Item?');
    }
}



</script>
 
 <script type="text/javascript">
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
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
 
 
</body>
</html>