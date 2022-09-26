<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Briefing </title>


 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 
  
 th
 {
 	border: 0;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 0;
 	padding: 5px;
 }
 
  
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}

details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

  label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

</style>


<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String)request.getAttribute("projectid");
List<Object[]> projectstagelist=(List<Object[]>)request.getAttribute("projectstagelist");
String filesize=(String) request.getAttribute("filesize"); 


%>
<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<center>
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>
	<%} %>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h3>Add Project Data </h3>
						</div>
						<div class="col-md-6 justify-content-end" >
							<table style="float: right;" >
								<tr>
									<td ><h4>Project :</h4></td>
									<td >
										<form method="post" action="ProjectData.htm" id="projectchange">
											<select class="form-control items" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
												<option disabled  selected value="">Choose...</option>
												<%for(Object[] obj : projectslist){ %>
												<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value=<%=obj[0]%> ><%=obj[4] %></option>
												<%} %>
											</select>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</td>
								</tr>
							</table>							
						</div>
					 </div>
					 
				<%if(Long.parseLong(projectid)>0){ %>
					<div class="card-body">	
						<div class="row">		
						   <div class="col-md-12">
						   		
							    <form method="post" action="ProjectDataSubmit.htm" enctype="multipart/form-data"  >
							    	<table  style="border-collapse: collapse; border: 0px; width:100%; ">
							    		<tr>
									    	<td>
									    		<label ><b>1. System Configuration </b>  </label> 
									    		<input class="form-control" type="file" name="systemconfig"  id="systemconfig" accept="application/pdf , image/* "  onchange=" editcheck('systemconfig',1)" >
									    	</td>
									    	<td>
									    		<label ><b>2. Product Tree</b>  </label>
									    		<input class="form-control" type="file" name="producttreeimg" id="producttreeimg" accept="application/pdf , image/* "  onchange=" editcheck('producttreeimg',1)" >
									    	</td>
									    	<td>
												<label ><b>3. PEARL/TRL </b>  </label>
												<input class="form-control" type="file" name="pearlimg" id="pearlimg" accept="application/pdf , image/* "  onchange=" editcheck('pearlimg',1)" >
											</td>
									    </tr>
										<tr>
											 <td>
										    	<label><b>4. System Specification </b>  </label>
										    	<input class="form-control" type="file" name="systemspecsfile"   id="sysspec" accept="application/pdf , image/* " onchange=" editcheck('sysspec',1)" > 
										    </td>
											
											<td>
												<label ><b>5. Project Stage</b>  </label><br>
												<select class="form-control items" name="projectstageid"  required="required" style="width: 100%"  data-live-search="true" data-container="body" >
													<option disabled  selected value="">Choose...</option>
												<%for(Object[] obj : projectstagelist){ %>
													<option <%-- <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %> --%> value=<%=obj[0]%> ><%=obj[2] %></option>
												<%} %>
												</select>
											</td>
											<td>
										    	<label ><b>6. Procurement Limit </b></label>
										    	<input class="form-control" type="number" name="proclimit" placeholder="Add Limit" min="500000" value="500000.00" step="0.01" >
										    </td>
										</tr>
										
										<tr>
											<td colspan="3">
												<span><b style="color: red">Note :</b> &nbsp; Please Upload Files in PDF and Image Files Only</span>
											</td>
										</tr>
										<tr>
											<td colspan="3" align="center">
												<button type="submit" class="btn  btn-sm submit" onclick="return validate(); ">SUBMIT</button>
												<a class="btn  btn-sm  back"  href="MainDashBoard.htm"  >BACK</a>
											</td>
										</tr>
									</table>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    	<input type="hidden" name="projectid" value="<%=projectid%>"/>
							  </form>
							</div>
						</div>
					</div>
				<%} %>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">

var count=0;
function editcheck(editfileid,alertn)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
   
    
    if (document.getElementById(editfileid).files.length!=0 && file >= <%=filesize%> ) 
    {
    	if(alertn==1){
	    	
	     	alert("File too Big, please select a file less than <%=filesize%> mb");
    	}else
    	{
    		count++;
    	}
     	
    }
}


function validate()
{
	editcheck('systemconfig',0);
	editcheck('producttreeimg',0);
	editcheck('pearlimg',0);
	editcheck('sysspec',0);
	
	
	if(count==0){
		return confirm('Are you Sure to Add this Data?');
	}else
	{
		event.preventDefault();
		alert('one of your files is more then <%=filesize%> MB ');	
		count=0;
	}
	
	
}

</script>	
	
	


	
<script type="text/javascript">
$('.items').select2();
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>





</body>
</html>