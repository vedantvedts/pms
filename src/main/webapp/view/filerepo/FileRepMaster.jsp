<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>File Master</title>

  <style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }

label{
  font-weight: bold;
  font-size: 20px;
}
 
.note-editable {
  line-height: 1.0;
}
.panel-info {
    border-color: #bce8f1;
}
.panel {
    margin-bottom: 10px;
    background-color: #fff;
    border: 1px solid transparent;
    border-radius: 4px;
    -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
    box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}
 .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
    color: #1d5987;
}
.panel-title {
    margin-top: 0;
    margin-bottom: 0;
    font-size: 13px;
    color: inherit;
    font-weight: bold;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
div {
    display: block;
}

element.style {
}
.olre-body .panel-info .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
   
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info>.panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.p-5 {
    padding: 5px;
}
.panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
user agent stylesheet
div {
    display: block;
}

.panel-info {
    border-color: #bce8f1;
}

.form-check{
	margin:0px 4%;
}

.editbtn
{
	background-color: green;
	width:auto; 
	height: 22px; 
	font-size:10px;
	font-weight: bold;
	text-align: justify; 
	margin-top : -9px;
	padding: 0px 3px 1px 3px; 
}

.hiddeninput
{
	width:50%;
	height: 25px;
	
	font-size: 1rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 2px;
	
}

 .btnx
{
	width:22px; 
	height: 22px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	
}

.fa-lg
{
	margin-left: -5px;
	vertical-align: 0%;
	font-size: 1.4rem;
} 

</style>
</head>
<body>
  <%
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("projectslist");
  String ProjectId= (String) request.getAttribute("projectid");
  
  List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");
 %>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></div>
                    <%} %>

    

<div class="container-fluid">   
<div class="row"> 
<div class="col-md-12" >
	<div class="card" >
		<div class="card-header">
				<div class="row" style="margin-top:-10px;">
					<div class="col-md-6">
						<h4>Project System</h4>
					</div>
					<div class="col-md-6">
						<form action="FileRepMaster.htm" method="post" id="myprojectform">
		        			<table style="float: right;">
								<tr>
									<td><label >Project Name :&nbsp;&nbsp; </label></td>
								   	<td>
								   		<select class="form-control selectdee" id="projectid" required="required"  name="projectid" onchange="$('#myprojectform').submit();">
								    		<option    value="">Choose...</option>
								    	<%-- 	<option value="0"  <%if(ProjectId.split("_")[0].equalsIgnoreCase("0")){ %>selected="selected" <%} %>>General</option> --%>
								    		<% for (Object[] obj : ProjectList) {
								    			String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
								    		%>
												<option value="<%=obj[0]%>"  <%if(ProjectId.equalsIgnoreCase(obj[0].toString())){ %>selected="selected" <%} %>><%=obj[4]+projectshortName%> </option>
											<%} %>
											<option value="0"  <%if(ProjectId.split("_")[0].equalsIgnoreCase("0")){ %>selected="selected" <%} %>>General</option>
										</select>
										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
        	</div>  
    	<div class="card-body" style="margin-top: -8px ;border-color:#00DADA ;">
    	
         <div class="panel panel-info" style="margin-top: 10px;" >
         
      		<div class="panel-heading ">
        		<h4 class="panel-title">
          			<span  style="font-size:14px">Main System</span>  
        		</h4>
         	<div   style="float: right !important; margin-top:-23px; ">
		 		
	
       	</div>
      
      
		<div   style="float: right !important; margin-top:-20px; ">  
		<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" > <i class="fa fa-plus faplus " id="Clk"></i></a>

   		</div>
     </div>
     <!-- panel-heading end -->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
	  	<%
		  	int Sub0Count=1;
		  	for(Object[] obj:filerepmasterlistall){
		  	if(obj[2].toString().equalsIgnoreCase("1")){
	  	%>
	  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myForm<%=Sub0Count %>" action="FileProjectSubAdd.htm" method="post">
						 
									<span  style="font-size:14px" ><%=Sub0Count %>.</span>
									<span  style="font-size:14px" id="span_<%=obj[0]%>"> <%=obj[3] %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj[0] %>')"></i> </span>	
						          	<input type="text" name="levelname" class="hiddeninput" id="input_<%=obj[0]%>" value="<%=obj[3] %>" style="display: none;" maxlength="255">
						          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj[0]%>" formaction="ProjectModuleNameEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
						          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj[0] %>" onclick="moduleeditdisable('<%=obj[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
						          	<input type="hidden" name="filerepmasterid" value="<%=obj[0]%>">
						          	<input type="hidden" name="projectid" value="<%=ProjectId%>">
						          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          		
						          	</form>
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       			<a data-toggle="collapse" data-parent="#accordion" href="#collapse55<%=Sub0Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %>"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55<%=Sub0Count %>" class="panel-collapse collapse in">
					  			<%	int Sub1Count=1; 
						  	  	    for(Object[] obj1:filerepmasterlistall){
						  	  	    if(obj1[2].toString().equalsIgnoreCase("2") && obj[0].toString().equalsIgnoreCase(obj1[1].toString()) ){
						  	  	    	
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %>" action="FileMasterSubAdd.htm" method="post">
						 
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="specname" value="Agenda-Presentation">
									    <input type="hidden" name="FileId" value="<%=obj1[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj1[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>" />										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          		<span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %> </span><span  style="font-size:14px" id="span_<%=obj1[0]%>"> <%=obj1[3] %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj1[0] %>')"></i> </span>
						          		<input type="text" name="levelname" class="hiddeninput" id="input_<%=obj1[0]%>" value="<%=obj1[3] %>" style="display: none;" maxlength="255" >
							          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj1[0]%>" formaction="ProjectModuleNameEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
							          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj1[0] %>" onclick="moduleeditdisable('<%=obj1[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
							          	<input type="hidden" name="filerepmasterid" value="<%=obj1[0]%>">
						          	
						          	
						          		
						          	</form>
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %>"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=Sub0Count %><%=Sub1Count %>" class="panel-collapse collapse in">
					  			
					  			<%
						  			int Sub2Count=1; 
						  	  	 	for(Object[] obj2:filerepmasterlistall){
						  	  		if(obj2[2].toString().equalsIgnoreCase("3") && obj1[0].toString().equalsIgnoreCase(obj2[1].toString()) ){
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										 <input type="hidden" name="FileId" value="<%=obj2[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj2[3] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>/<%=Sub2Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %> </span><span  style="font-size:14px" id="span_<%=obj2[0]%>"> <%=obj2[3] %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj2[0] %>')"></i> </span>
						          		<input type="text" name="levelname" class="hiddeninput" id="input_<%=obj2[0]%>" value="<%=obj2[3] %>" style="display: none;" maxlength="255">
							          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj2[0]%>" formaction="ProjectModuleNameEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
							          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj2[0] %>" onclick="moduleeditdisable('<%=obj2[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
							          	<input type="hidden" name="filerepmasterid" value="<%=obj2[0]%>">
						          				
						          	
						          		
						          	</form>
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" class="panel-collapse collapse in">
					  			<%
					  				int Sub3Count=1; 
						  	  	  	for(Object[] obj3:filerepmasterlistall){
						  	  		if(obj3[2].toString().equalsIgnoreCase("4") && obj2[0].toString().equalsIgnoreCase(obj3[1].toString()) ){
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="FileId" value="<%=obj3[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj3[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %> </span><span  style="font-size:14px" id="span_<%=obj3[0]%>"> <%=obj3[3] %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj3[0] %>')"></i> </span>
						          		<input type="text" name="levelname" class="hiddeninput" id="input_<%=obj3[0]%>" value="<%=obj3[3] %>" style="display: none;" maxlength="255">
							          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj3[0]%>" formaction="ProjectModuleNameEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
							          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj3[0] %>" onclick="moduleeditdisable('<%=obj3[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
							          	<input type="hidden" name="filerepmasterid" value="<%=obj3[0]%>">
						          	
						          		
						          	</form>
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" class="panel-collapse collapse in">
					  			
					  			
					  			<%
						  			int Sub4Count=1; 
						  	  	 	for(Object[] obj4:filerepmasterlistall){
						  	  		if(obj4[2].toString().equalsIgnoreCase("5") && obj3[0].toString().equalsIgnoreCase(obj4[1].toString()) ){
						  		%>
					  			
					  			<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
									    <input type="hidden" name="FileId" value="<%=obj4[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj4[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %> </span><span  style="font-size:14px" id="span_<%=obj4[0]%>"> <%=obj4[3] %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj4[0] %>')"></i> </span>
						          		<input type="text" name="levelname" class="hiddeninput" id="input_<%=obj4[0]%>" value="<%=obj4[3] %>" style="display: none;" maxlength="255">
							          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj4[0]%>" formaction="ProjectModuleNameEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
							          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj4[0] %>" onclick="moduleeditdisable('<%=obj4[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
							          	<input type="hidden" name="filerepmasterid" value="<%=obj4[0]%>">
						          	
						          		
						          	</form>
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" class="panel-collapse collapse in">
					  			
					  			
					  			<%int 
					  				Sub5Count=1; 
					  	  	  		for(Object[] obj5:filerepmasterlistall){
					  	  			if(obj5[2].toString().equalsIgnoreCase("6") && obj4[0].toString().equalsIgnoreCase(obj5[1].toString()) ){
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
									    <input type="hidden" name="FileId" value="<%=obj5[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj5[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>/<%=Sub5Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>.<%=Sub5Count %> <%=obj5[3] %> </span>
						          				
						          	
						          		
						          	</form>
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" class="panel-collapse collapse in">
					  		
					  			
					  			
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>
					 <%Sub5Count++;}} %> 			
		
					 <!-- end five --> 
					  			
					  			
					  			
					  			
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>
					 <%Sub4Count++;}} %> 			
				<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" action="FileRepMasterSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="FileMasterId" value="<%=obj3[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj3[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						  			<span  style="font-size:14px">
						          		
						          		<%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>
						          		
						          		 </span>
						          		
						          		<div style="margin-top:-20px; margin-left:55px;">
						          		
						          			<input class="form-control" type="text" name="MasterSubName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
						          		</div>
						          		<div style="margin-top:-22px; margin-left: 220px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  	<div >
					  </div>
					 </div>
				  </div>
	  			</div>	
 <!-- end four --> 
						
					  			
			</div>
		</div>
	</div>
</div>
					 <%Sub3Count++;}} %> 			
					  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" action="FileRepMasterSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="FileMasterId" value="<%=obj2[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj2[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>/<%=Sub2Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          	     			<span  style="font-size:14px">
						          		
						          		<%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>
						          		
						          		 </span>
						          
						          		<div style="margin-top:-20px; margin-left:45px;">
						          		
						          			<input class="form-control" type="text" name="MasterSubName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
						          		</div>
						          		<div style="margin-top:-22px; margin-left: 210px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>	
					 <!-- end three --> 			
					  			
					  			
					  			
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>
					 <%Sub2Count++;}} %> 			
					  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" action="FileRepMasterSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="FileMasterId" value="<%=obj1[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj1[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>/<%=Sub1Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          			<span  style="font-size:14px">
						          		
						          		<%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %>
						          		
						          		 </span>
						          		
						          		<div style="margin-top:-20px; margin-left:35px;">
						          		
						          			<input class="form-control" type="text" name="MasterSubName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
						          		</div>
						          		<div style="margin-top:-22px; margin-left: 200px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          	
						          		
						          		
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>	
					<!-- end two	 -->		
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>
					 <%Sub1Count++;}} %> 			
					  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=Sub0Count %>" action="FileRepMasterSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="FileMasterId" value="<%=obj[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj[2] %>" >
										<input type="hidden" name="formname" value="<%=Sub0Count %>" />
										<input type="hidden" name="projectid" value="<%=ProjectId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:14px">
						          		
						          		<%=Sub0Count %>.<%=Sub1Count %>
						          		
						          		 </span>
						          		
						          		<div style="margin-top:-20px; margin-left:25px;">
						          		
						          			<input class="form-control" type="text" name="MasterSubName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
						          		</div>
						          		<div style="margin-top:-22px; margin-left: 190px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>		
					  </div>
					 </div>
					 
				  </div>
	  			</div>
	  	
	  	
	  	<%Sub0Count++;}} %>
	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myForm" action="FileRepMasterAdd.htm" method="post">
						 
										<input type="hidden" name="projectid" value="<%=ProjectId%>">				
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="formname" value="rm" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          		<span  style="font-size:14px"><%=Sub0Count %>. </span>
						          		
						          		<div style="margin-top:-20px; margin-left:15px;">
						          			<input class="form-control" type="text" name="MasterName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
						          		</div>
						          		<div style="margin-top:-22px; margin-left: 180px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myForm" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		
						          	</form>
					       		</div>
					        </h4>
					      </div>
						<div >
					  </div>
					 </div>
				  </div>
	  			</div>
		     </div>      
 		  </div>
   <!-- panel end -->   
		</div><!-- Big card-body end -->
	</div><!-- Card End  -->
</div> <!-- col-md-5 end -->
</div>
</div>





<script type="text/javascript">
function moduleeditenable(moduleid)
{
	$('#span_'+moduleid).hide();
	$('#input_'+moduleid).show();
	$('#btn_'+moduleid).show();	
	$('#btnx_'+moduleid).show();
}

function moduleeditdisable(moduleid)
{
	$('#span_'+moduleid).show();
	$('#input_'+moduleid).hide();
	$('#btn_'+moduleid).hide();	
	$('#btnx_'+moduleid).hide();
}
</script>







<script type="text/javascript">
$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".faplus").addClass("fa-minus").removeClass("fa-plus");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-minus").addClass("fa-plus");
    });
});

$('#Clk').click();

<%String FormName=(String)request.getAttribute("FromName");
if(FormName!=null){
	String [] id=FormName.split("/");
	String IdName="Clk";
	for(int i=0;i<id.length;i++){
		IdName=IdName.concat(id[i]);
%>
      $('#<%=IdName%>').click();
<%}}%>
</script>
</body>
</html>