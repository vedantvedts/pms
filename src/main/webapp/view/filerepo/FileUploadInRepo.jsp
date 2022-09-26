<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Upload File</title>

  <style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }
</style>

  	<style type="text/css">
		

label{
  font-weight: bold;
  font-size: 13px;
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

		</style>
</head>

<body>
  <%
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String ProjectName=(String)request.getAttribute("ProjectName");
 %>

<nav class="navbar navbar-light bg-light" style="margin-top: -1%;">
	<a class="navbar-brand"></a>
		<form class="form-inline"  method="POST" action="FileUploadInRepo.htm">
			<label class="control-label">Project Name :  </label>
		    	<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
		    		<option disabled="true"  selected value="">Choose...</option>
		    			<% for (Object[] obj : ProjectList) {%>
							<option value="<%=obj[0]%>"  <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[2]%>( <%=obj[1]%> ) </option>
						<%} %>
		  		</select>
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
				<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
		</form>
</nav>

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

    

<div class="container-fluid">   
        
	<div class="row"> 
		<div class="col-md-12" >
			
			<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    			<div class="card-body" style="margin-top: -8px" >

         			<div class="panel panel-info" style="margin-top: 10px;" >
         
			      		<div class="panel-heading ">
			        		<h4 class="panel-title">
			          			<span  style="font-size:14px"><%=ProjectName%></span>  
			        		</h4>
			         	
			         		<div style="float: right !important; margin-top:-23px;">  </div>
			      
							<div   style="float: right !important; margin-top:-20px; ">  
								<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" > <i class="fa fa-plus" id="Clk"></i></a>
			   				</div>
			    		</div>
			    		
     				<!---------------------------- panel-heading end ----------------------------------->
     				
     				
  	
  		<!---------------------------------------------------- Main Collapse Start----------------------------------------------- ----------------------------------->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
			  	
			  	<%List<Object[]> ProjectSubList=(List<Object[]>)request.getAttribute("ProjectSubList");
			      List<Object[]> MainSystemList=(List<Object[]>)request.getAttribute("MainSystemList");
		
			  	  int ProjectSubCount=1;
			  	  if(ProjectSubList!=null&&ProjectSubList.size()>0){
			  	  for(Object[] obj:ProjectSubList){
			  	%>
			  	
			  	
	  	<div class="row">  
			<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      
					 	<div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						          	<form  id="myForm<%=ProjectSubCount %>" action="FileProjectSubAdd.htm" method="post">
										<span  style="font-size:14px"><%=ProjectSubCount %>. <%=obj[4] %></span>
						          	</form>
					       		</div>
					        </h4>
					        
					       	<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55<%=ProjectSubCount %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %>"></i></a>
					       	</div>
					  	</div>
					      
					      
					   <!---------------------------------------------------- First Collapse Start----------------------------------------------- ----------------------------------->
					      
						<div id="collapse55<%=ProjectSubCount %>" class="panel-collapse collapse in">
					  			
					  			<%int Sub1Count=1; 
					  			List<Object[]> FileSub1=(List<Object[]>)request.getAttribute("FileSub"+ProjectSubCount);				  	 
					  			List<Object[]> SubSystemList1=(List<Object[]>)request.getAttribute("SubSystemList"+ProjectSubCount);				  	 

					  			if(FileSub1!=null&&FileSub1.size()>0){
					  	  	  	for(Object[] obj1:FileSub1){
					  			%>
					  			
					  		<div class="row">  
				   				<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     				<div class="panel panel-info">
								      
									      <div class="panel-heading">
										        <h4 class="panel-title">
										        	<div>
											           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %>" action="FileSubAdd.htm" method="post">		
															<input type="hidden" name="specname" value="Agenda-Presentation">
															<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
															<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
					                                        <input type="hidden" name="FileId" value="<%=obj1[0] %>" >
					                                        <input type="hidden" name="LevelId" value="<%=obj1[3] %>" >
															<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>" />
															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											          		<span  style="font-size:14px"><%=ProjectSubCount %>.<%=Sub1Count %> <%=obj1[4] %></span>
											          	</form>
										       		</div>
										        </h4>
									       		<div style="float: right !important; margin-top:-20px; " > 
									       			<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %>"></i></a>
									       		</div>
									      </div>
					  			
					  							 <!---------------------------------------------------- Second Collapse Start----------------------------------------------- ----------------------------------->
					  			
					  							<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %>" class="panel-collapse collapse in">
					  			
										  			<%int Sub2Count=1; 
										  			List<Object[]> FileSub2=(List<Object[]>)request.getAttribute("FileSub"+ProjectSubCount+Sub1Count);				  	 
										  			List<Object[]> SubSystemList2=(List<Object[]>)request.getAttribute("SubSystemList"+ProjectSubCount+Sub1Count);				  	 
					
										  			if(FileSub2!=null&&FileSub2.size()>0){
										  	  	  for(Object[] obj2:FileSub2){
										  			%>
					  			
									  				<div class="row">  
								   						<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     										<div class="panel panel-info">
				     										
															      <div class="panel-heading">
																        <h4 class="panel-title">
																        	<div>
																	           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" action="FileSubAdd.htm" method="post">
																					<input type="hidden" name="specname" value="Agenda-Presentation">
																					<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																					<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
											                                        <input type="hidden" name="FileId" value="<%=obj2[0] %>" >
											                                        <input type="hidden" name="LevelId" value="<%=obj2[3] %>" >
																					<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>" />
																					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	          		<span  style="font-size:14px"><%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %> <%=obj2[4] %> </span>
																	          	</form>
																       		</div>
																        </h4>
																       	<div style="float: right !important; margin-top:-20px; " > 
																       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>"></i></a>
																       	</div>
															      </div>
															      
															      	 <!---------------------------------------------------- Third Collapse Start----------------------------------------------- ----------------------------------->
															      
														  			<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" class="panel-collapse collapse in">
															  			<%int Sub3Count=1; 
															  			List<Object[]> FileSub3=(List<Object[]>)request.getAttribute("FileSub"+ProjectSubCount+Sub1Count+Sub2Count);				  	 
															  			List<Object[]> SubSystemList3=(List<Object[]>)request.getAttribute("SubSystemList"+ProjectSubCount+Sub1Count+Sub2Count);				  	 
										
															  			if(FileSub3!=null&&FileSub3.size()>0){
															  	  	  for(Object[] obj3:FileSub3){
															  			%>
					  			
																  			<div class="row">  
															   					<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     																<div class="panel panel-info">
				     																
																					      <div class="panel-heading">
																					        <h4 class="panel-title">
																					        	<div>
																						           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" action="FileSubAdd.htm" method="post">
																						 
																														
																										<input type="hidden" name="specname" value="Agenda-Presentation">
																										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																                                        <input type="hidden" name="FileId" value="<%=obj3[0] %>" >
																                                        <input type="hidden" name="LevelId" value="<%=obj3[3] %>" >
																										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>" />
																										
																										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																						
																						          		<span  style="font-size:14px"><%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %> <%=obj3[4] %> </span>
																						          				
																						          	
																						          		
																						          	</form>
																					       		</div>
																					        </h4>
																					       		<div style="float: right !important; margin-top:-20px; " > 
																					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>"></i></a>
																					       		    </div>
																					      </div>
																					      
																					      
																					      	<!---------------------------------------------------- Fourth Collapse Start----------------------------------------------- ----------------------------------->
																					      
					  																		<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" class="panel-collapse collapse in">
					  			
																					  			<%int Sub4Count=1; 
																					  			List<Object[]> FileSub4=(List<Object[]>)request.getAttribute("FileSub"+ProjectSubCount+Sub1Count+Sub2Count+Sub3Count);				  	 
																					  			List<Object[]> SubSystemList4=(List<Object[]>)request.getAttribute("SubSystemList"+ProjectSubCount+Sub1Count+Sub2Count+Sub3Count);				  	 
																
																					  			if(FileSub4!=null&&FileSub4.size()>0){
																					  	  	  for(Object[] obj4:FileSub4){
																					  			%>
					  			
																						  			<div class="row">  
																					   					<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     																						<div class="panel panel-info">
																										      
																										      <div class="panel-heading">
																										        <h4 class="panel-title">
																										        	<div>
																											           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" action="FileSubAdd.htm" method="post">
																															<input type="hidden" name="specname" value="Agenda-Presentation">
																															<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																															<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																					                                        <input type="hidden" name="FileId" value="<%=obj4[0] %>" >
																					                                        <input type="hidden" name="LevelId" value="<%=obj4[3] %>" >
																															<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>" />
																															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																											          		<span  style="font-size:14px"><%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %> <%=obj4[4] %> </span>
																											          	</form>
																										       		</div>
																										        </h4>
																										       	<div style="float: right !important; margin-top:-20px; " > 
																										       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>"></i></a>
																										       	</div>
																										      </div>
																										      
																										      <!---------------------------------------------------- Fifth Collapse Start----------------------------------------------- ----------------------------------->
																										      
					  																						<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" class="panel-collapse collapse in">
					  			
																									  			<%int Sub5Count=1; 
																									  			List<Object[]> FileSub5=(List<Object[]>)request.getAttribute("FileSub"+ProjectSubCount+Sub1Count+Sub2Count+Sub3Count+Sub4Count);				  	 
																									  			if(FileSub5!=null&&FileSub5.size()>0){
																									  	  	  for(Object[] obj5:FileSub5){
																									  			%>
					  			
					  																							<div class="row">  
				   																									<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     																									<div class="panel panel-info">
																														      <div class="panel-heading">
																														        <h4 class="panel-title">
																														        	<div>
																															           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" action="FileSubAdd.htm" method="post">
																															 
																																							
																																			<input type="hidden" name="specname" value="Agenda-Presentation">
																																			<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																																			<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																									                                        <input type="hidden" name="FileId" value="<%=obj5[0] %>" >
																									                                        <input type="hidden" name="LevelId" value="<%=obj5[3] %>" >
																																			<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>/<%=Sub5Count %>" />
																																			
																																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																															
																															          		<span  style="font-size:14px"><%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>.<%=Sub5Count %> <%=obj5[4] %> </span>
																															          				
																															          	
																															          		
																															          	</form>
																														       		</div>
																														        </h4>
																														       		<div style="float: right !important; margin-top:-20px; " > 
																														       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>"></i></a>
																														       		    </div>
																														      </div>
																														      
<!-----------------------------------Sixth Collapse Start----------------------------------------------------------------------------------------------------- ----------------------------------------------- ----------------------------------->	
																														      
					  																										  <div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" class="panel-collapse collapse in">
					  			
																														  			<%int Sub6Count=1; 
																														  			List<Object[]> FileSub6=(List<Object[]>)request.getAttribute("FileSub"+ProjectSubCount+Sub1Count+Sub2Count+Sub3Count+Sub4Count+Sub5Count);				  	 
																														  			if(FileSub6!=null&&FileSub6.size()>0){
																														  	  	  for(Object[] obj6:FileSub6){
																														  			%>
					  			
																														  			<div class="row">  
																													   					<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     																														<div class="panel panel-info">
																																			      <div class="panel-heading">
																																			        <h4 class="panel-title">
																																			        	<div>
																																			        	    <form  id="myForm<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" action="FileSubAdd.htm" method="post">
																																				 
																																								<input type="hidden" name="specname" value="Agenda-Presentation">
																																								<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																																								<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																														                                         <input type="hidden" name="FileId" value="<%=obj6[0] %>" >
																														                                        <input type="hidden" name="LevelId" value="<%=obj6[3] %>" >
																																								<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>/<%=Sub5Count %>/<%=Sub6Count %>" />
																																								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																																				                  
																															                                    <span  style="font-size:14px">
																																					          		<%if(!obj6[5].toString().equalsIgnoreCase("0")){ %>
																																					          		<%=obj6[6] %> Ver.<%=Integer.parseInt(obj6[5].toString()) %>
																																					          			
																																					          			<button type="submit" name="sub" class="btn btn-light btn-sm"  form="myForm<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
																																					          		
																																					          		<%}else{ %>
																																					          		<%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>.<%=Sub5Count %>.<%=Sub6Count %>
																																					          		<%} %>
																																					          	</span>
																																				          	</form>
																																				        </div>
																																			        </h4>
																																			       	<div style="float: right !important; margin-top:-20px; " > 
																																			       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>"></i></a>
																																			       	</div>
																																			      </div>
																																			      
																																			      
<!-----------------------------------Final Fill Name Collapse Start ----------------------------------------------------------------------------------------------------- ----------------------------------------------- ----------------------------------->	
					      
					      
																																		  			<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" class="panel-collapse collapse in">
																																		  			
																																			  			<form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
																																				 
																																								<input type="hidden" name="specname" value="Agenda-Presentation">
																																								<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																																								<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																														                                        <input type="hidden" name="FileId" value="<%=obj6[0] %>" >
																														                                        <input type="hidden" name="LevelId" value="<%=obj6[3] %>" >
																														                                        <input type="hidden" name="Path" value="<%=obj[4] %>/<%=obj1[4] %>/<%=obj2[4] %>/<%=obj3[4] %>/<%=obj4[4] %>/<%=obj5[4] %>/<%=obj6[4] %>" >
																																								<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj6[5].toString())+1 %>" />
																																								<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>/<%=Sub5Count %>/<%=Sub6Count %>" />
																																								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																																				          		
																																				          		<div>
																																				          			<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
																																				          		</div>	
																																				          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; ">
																																				          			<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;"  />
																																				          		</div>		
																																				          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; ">
																																				          			<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" value="Upload Ver.<%=Integer.parseInt(obj5[5].toString())+1 %>"  />
																																				          		</div>
																																				          		
																																				          </form>
																																
																																		  			</div>
					 																														</div>
					 
																																		 </div>
																															  		</div>
																																			 <%Sub6Count++;}} %> 
																																	<div class="row">  
																																		   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
																																		   
																																		     <div class="panel panel-info">
																																			      <div class="panel-heading">
																																			        <h4 class="panel-title">
																																			        	<div>
																																				           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" action="FileSubAdd.htm" method="post">
																																								<input type="hidden" name="specname" value="Agenda-Presentation">
																																								<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																																								<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																														                                         <input type="hidden" name="FileId" value="<%=obj5[0] %>" >
																														                                        <input type="hidden" name="LevelId" value="<%=obj5[3] %>" >
																																								<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>/<%=Sub5Count %>" />
																																								
																																								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																																				                      <span  style="font-size:14px">
																																				          		<%if(!obj5[5].toString().equalsIgnoreCase("0")){ %>
																																				          		<%=obj5[6] %> Ver.<%=Integer.parseInt(obj5[5].toString()) %>
																																				          		<%}else{ %>
																																				          		<%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>.<%=Sub5Count %>.<%=Sub6Count %>
																																				          		<%} %>
																																				          		 </span>
																																				          		<%if(obj5[5].toString().equalsIgnoreCase("0")){ %>
																																				          		<div style="margin-top:-20px; margin-left:75px;">
																																				          		
																																				          			<input class="form-control" type="text" name="SubName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
																																				          		</div>
																																				          		<div style="margin-top:-22px; margin-left: 240px;">
																																				          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
																																				          		</div>
																																				          		<% }else{%>
																																				          		
																																				          		<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
																																				          		
																																				          		<%} %>
																																				          	</form>
																																			       		</div>
																																			        </h4>
																																			       		
																																			      </div>
																																			  			<div >
																																			  			<%int count6=0;
																																			  			if(FileSub6!=null){
																																			  				count6=FileSub6.size();
																																			  			}
																																			  			if(count6==0){
																																			  				%>
																																			  			<form  id="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
																																				 
																																												
																																								<input type="hidden" name="specname" value="Agenda-Presentation">
																																								<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																																								<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
																														                                        <input type="hidden" name="FileId" value="<%=obj5[0] %>" >
																														                                        <input type="hidden" name="LevelId" value="<%=obj5[3] %>" >
																														                                        <input type="hidden" name="Path" value="<%=obj[4] %>/<%=obj1[4] %>/<%=obj2[4] %>/<%=obj3[4] %>/<%=obj4[4] %>/<%=obj5[4] %>" >
																																								<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>/<%=Sub5Count %>" />
																																								<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj5[5].toString())+1 %>" />
																																								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																																				
																																				          		
																																				          		<div>
																																				          		<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
																																				          		
																																				          		</div>	
																																				          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; " >
																																				          		
																																				          		<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;" 
																																				          		<%if(!obj5[5].toString().equalsIgnoreCase("0")){ %> value="<%=obj5[6] %>"  readonly="readonly" <%} %>
																																				          		 />
																																				          		
																																				          		</div>		
																																				          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; " >
																																				          		<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %><%=Sub6Count %>" value="Upload Ver.<%=Integer.parseInt(obj5[5].toString())+1 %>"  />
																																				          		
																																				          		</div>	
																																				          		
																																				          	</form>
																																			  			<% }%>
																																			  </div>
																																			 </div>
																																			 
																																		  </div>
																															  		</div>	
																															  			
<!-----------------------------------Final Fill Name Collapse End ----------------------------------------------------------------------------------------------------- ----------------------------------------------- ----------------------------------->	
																																				
																														 </div>
					  
<!-----------------------------------Sixth Collapse End ----------------------------------------------------------------------------------------------------- ----------------------------------------------- ----------------------------------->	
					  
					  
					 </div>
					 
				  </div>
	  			</div>
					 <%Sub5Count++;}} %> 			
					  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                         <input type="hidden" name="FileId" value="<%=obj4[0] %>" >
                                         <input type="hidden" name="FileUploadId" value="<%=obj4[8] %>">
                                         
                                        <input type="hidden" name="LevelId" value="<%=obj4[3] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>" />
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							              <span  style="font-size:14px">
						          		<%if(!obj4[5].toString().equalsIgnoreCase("0")){ %>
						          		<%=obj4[6] %> Ver.<%=Integer.parseInt(obj4[5].toString()) %>
						          		<%}else{ %>
						          		<%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>.<%=Sub5Count %>
						          		<%} %>
						          		 </span>
						          		<%if(obj4[5].toString().equalsIgnoreCase("0")){ %>
						          		<%-- <div style="margin-top:-20px; margin-left:65px;">
						          		
						          			<input class="form-control" type="text" name="SubName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
						          		</div>
						          		<div style="margin-top:-22px; margin-left: 230px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
						          		</div> --%>
						          		<% }else{%>
						          		
						          		<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
						          		
						          		<%} %>
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			<%int count5=0;
					  			if(FileSub5!=null){
					  				count5=FileSub5.size();
					  			}
					  			if(count5==0){%>
					  			<form  id="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj4[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj4[3] %>" >
                                        <input type="hidden" name="Path" value="<%=obj[4] %>/<%=obj1[4] %>/<%=obj2[4] %>/<%=obj3[4] %>/<%=obj4[4] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>"/>
										<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj4[5].toString())+1 %>" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		
						          		<div>
						          		<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
						          		
						          		</div>	
						          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; " >
						          		
						          		<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;" 
						          		<%if(!obj4[5].toString().equalsIgnoreCase("0")){ %> value="<%=obj4[6] %>"  readonly="readonly" <%} %>
						          		 />
						          		
						          		</div>		
						          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; " >
						          		<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %><%=Sub5Count %>" value="Upload Ver.<%=Integer.parseInt(obj4[5].toString())+1 %>"  />
						          		
						          		</div>	
						          		
						          	</form>
					  			<% }%>
					  </div>
					 </div>
					 
				  </div>
	  			</div>	
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
						           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                         <input type="hidden" name="FileId" value="<%=obj3[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj3[3] %>" >
                                        <input type="hidden" name="FileUploadId" value="<%=obj3[8] %>">
                                        
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>" />
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						  			<span  style="font-size:14px">
						          		<%if(!obj3[5].toString().equalsIgnoreCase("0")){ %>
						          		<%=obj3[6] %> Ver.<%=Integer.parseInt(obj3[5].toString()) %>
						          		<%}else{ %>
						          		<%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>.<%=Sub4Count %>
						          		<%} %>
						          		 </span>
						          		<%if(obj3[5].toString().equalsIgnoreCase("0")){ %>
						          		<div style="margin-top:-25px; margin-left:54px;">
						          		<select class="form-control selectdee" id="ProjectId" required="required" name="MasterId" style="width: 500px; ">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] sublist4 : SubSystemList4) {%>
										<option value="<%=sublist4[0]%>"  ><%=sublist4[3]%> </option>
											<%} %>
  									</select>
						          		</div>
						          		<div style="margin-top:-30px; margin-left:556px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" value="ADD"  style="width:42px; height: 26px; font-size:11px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		<% }else{%>
						          		
						          		<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
						          		
						          		<%} %>
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			<%int count4=0;
					  			if(FileSub4!=null){
					  				count4=FileSub4.size();
					  			}
					  			if(count4==0){%>
					  			<form  id="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj3[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj3[3] %>" >
                                       <input type="hidden" name="Path" value="<%=obj[4] %>/<%=obj1[4] %>/<%=obj2[4] %>/<%=obj3[4] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>" />
										<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj3[5].toString())+1 %>" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		
						          		<div>
						          		<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
						          		
						          		</div>	
						          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; " >
						          		
						          		<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;" 
						          		<%if(!obj3[5].toString().equalsIgnoreCase("0")){ %> value="<%=obj3[6] %>"  readonly="readonly" <%} %>
						          		 />
						          		
						          		</div>		
						          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; " >
						          		<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" value="Upload Ver.<%=Integer.parseInt(obj3[5].toString())+1 %>"  />
						          		
						          		</div>	
						          		
						          	</form>
					  			<% }%>
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
						           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                         <input type="hidden" name="FileId" value="<%=obj2[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj2[3] %>" >
                                        <input type="hidden" name="FileUploadId" value="<%=obj2[8] %>">
                                        
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>" />
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          	     			<span  style="font-size:14px">
						          		<%if(!obj2[5].toString().equalsIgnoreCase("0")){ %>
						          		<%=obj2[6] %> Ver.<%=Integer.parseInt(obj2[5].toString()) %>
						          		<%}else{ %>
						          		<%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>.<%=Sub3Count %>
						          		<%} %>
						          		 </span>
						          		<%if(obj2[5].toString().equalsIgnoreCase("0")){ %>
						          		<div style="margin-top:-25px; margin-left:44px;">
						          		<select class="form-control selectdee" id="ProjectId" required="required" name="MasterId" style="width: 500px; ">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] sublist3 : SubSystemList3) {%>
										<option value="<%=sublist3[0]%>"  ><%=sublist3[3]%> </option>
											<%} %>
  									</select>
						          		</div>
						          		<div style="margin-top:-30px; margin-left:546px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" value="ADD"  style="width:42px; height: 26px; font-size:11px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		<% }else{%>
						          		
						          		<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
						          		
						          		<%} %>
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			<%int count3=0;
					  			if(FileSub3!=null){
					  				count3=FileSub3.size();
					  			}
					  			if(count3==0){%>
					  			<form  id="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj2[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj2[3] %>" >
                                        <input type="hidden" name="Path" value="<%=obj[4] %>/<%=obj1[4] %>/<%=obj2[4] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>" />
										<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj2[5].toString())+1 %>" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		
						          		<div>
						          		<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
						          		
						          		</div>	
						          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; " >
						          		
						          		<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;" 
						          		<%if(!obj2[5].toString().equalsIgnoreCase("0")){ %> value="<%=obj2[6] %>"  readonly="readonly" <%} %>
						          		 />
						          		
						          		</div>		
						          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; " >
						          		<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" value="Upload Ver.<%=Integer.parseInt(obj2[5].toString())+1 %>"  />
						          		
						          		</div>	
						          		
						          	</form>
					  			<% }%>
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
						           <form  id="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                         <input type="hidden" name="FileId" value="<%=obj1[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj1[3] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>" />
										<input type="hidden" name="FileUploadId" value="<%=obj1[8] %>">
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          			<span  style="font-size:14px">
						          		<%if(!obj1[5].toString().equalsIgnoreCase("0")){ %>
						          		<%=obj1[6] %> Ver.<%=Integer.parseInt(obj1[5].toString()) %>
						          		<%}else{ %>
						          		<%=ProjectSubCount %>.<%=Sub1Count %>.<%=Sub2Count %>
						          		<%} %>
						          		 </span>
						          		<%if(obj1[5].toString().equalsIgnoreCase("0")){

						          			%>
						          		<div style="margin-top:-25px; margin-left:34px;">
						          		<select class="form-control selectdee" id="ProjectId" required="required" name="MasterId" style="width: 500px; ">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] sublist2 : SubSystemList2) {%>
										<option value="<%=sublist2[0]%>"  ><%=sublist2[3]%> </option>
											<%} %>
  									</select>
						          		</div>
						          		<div style="margin-top:-30px; margin-left:536px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" value="ADD"  style="width:42px; height: 26px; font-size:11px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		<% }else{%>
						          		
						          		<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myFormB<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
						          		
						          		<%} %>
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			<%int count2=0;
					  			if(FileSub2!=null){
					  				count2=FileSub2.size();
					  			}
					  			if(count2==0){ %>
					  			<form  id="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj1[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj1[3] %>" >
                                        <input type="hidden" name="Path" value="<%=obj[4] %>/<%=obj1[4] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>" />
										<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj1[5].toString())+1 %>" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		
						          		<div>
						          		<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
						          		
						          		</div>	
						          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; " >
						          		
						          		<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;" 
						          		<%if(!obj1[5].toString().equalsIgnoreCase("0")){ %> value="<%=obj1[6] %>"  readonly="readonly" <%} %>
						          		 />
						          		
						          		</div>		
						          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; " >
						          		<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormBA<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" value="Upload Ver.<%=Integer.parseInt(obj1[5].toString())+1 %>"  />
						          		
						          		</div>	
						          		
						          	</form>
					  			<% }%>
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
						           <form  id="myFormB<%=ProjectSubCount %>" action="FileSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj[3] %>" >
                                       <input type="hidden" name="FileUploadId" value="<%=obj[8] %>">
                                        
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>" />
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:14px">
						          		<%if(!obj[5].toString().equalsIgnoreCase("0")){ %>
						          		<%=obj[6] %> Ver.<%=Integer.parseInt(obj[5].toString()) %>
						          		<%}else{ %>
						          		<%=ProjectSubCount %>.<%=Sub1Count %>
						          		<%} %>
						          		 </span>
						          		<%if(obj[5].toString().equalsIgnoreCase("0")){ 
						          		%>
						          		<div style="margin-top:-25px; margin-left:24px;">
						          		<select class="form-control selectdee" id="ProjectId" required="required" name="MasterId" style="width: 500px; ">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] sublist1 : SubSystemList1) {%>
										<option value="<%=sublist1[0]%>"  ><%=sublist1[3]%> </option>
											<%} %>
  									</select>
						          		</div>
						          		<div style="margin-top:-30px; margin-left:526px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=ProjectSubCount %>" value="ADD"  style="width:42px; height: 26px; font-size:11px; font-weight: bold; text-align: justify; "/>
						          		</div>
						          		<% }else{%>
						          		
						          		<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myFormB<%=ProjectSubCount %>" formaction="FileUnpack.htm"  style="margin-top:-10px;width:30px; height: 22px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
						          		
						          		<%} %>
						          	</form>
					       		</div>
					        </h4>
					       		
					      </div>
					  			<div >
					  			<%int count1=0;
					  			if(FileSub1!=null){
					  				count1=FileSub1.size();
					  			}
					  			if(count1==0){ %>
					  			<form  id="myFormBA<%=ProjectSubCount %><%=Sub1Count %>" action="FileSubUpload.htm" method="post" enctype="multipart/form-data">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj[0] %>" >
                                        <input type="hidden" name="LevelId" value="<%=obj[3] %>" >
                                        <input type="hidden" name="Path" value="<%=obj[4] %>" >
										<input type="hidden" name="formname" value="<%=ProjectSubCount %>" />
										<input type="hidden" name="Rev" value="<%=Integer.parseInt(obj[5].toString())+1 %>" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		
						          		<div>
						          		<input type="file" name="FileAttach" id="FileAttach"  class="form-control " aria-describedby="inputGroup-sizing-sm" required="required" maxlength="255" style="width:260px;" />
						          		
						          		</div>	
						          		<div style="margin-left: 270px;margin-top: -38px;margin-bottom:9px; " >
						          		
						          		<input type="text" name="FileName"   class="form-control " placeholder="Fill File Name" required="required" maxlength="255" style="width:260px;" 
						          		<%if(!obj[5].toString().equalsIgnoreCase("0")){ %> value="<%=obj[6] %>"  readonly="readonly" <%} %>
						          		 />
						          		
						          		</div>		
						          	    <div style="margin-left: 540px;margin-top: -42px;margin-bottom:9px; " >
						          		<input type="submit" name="sub" class="btn btn-success btn-sm"  form="myFormBA<%=ProjectSubCount %><%=Sub1Count %>" value="Upload Ver.<%=Integer.parseInt(obj[5].toString())+1 %>"  />
						          		
						          		</div>	
						          		
						          	</form>
					  			<% }%>
					  			
					  </div>
					 </div>
					 
				  </div>
	  			</div>		
					  </div>
					 </div>
					 
				  </div>
	  			</div>
	  	
	  	
	  	<%ProjectSubCount++;}} %>
	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						           <form  id="myForm" action="FileProjectSubAdd.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">

										<input type="hidden" name="formname" value="rm" />
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						          		<span  style="font-size:16px"><%=ProjectSubCount %>. </span>
						          		
						          		<div style="margin-top:-25px; margin-left:15px;">
						          		<select class="form-control selectdee" id="ProjectId" required="required" name="MasterId" style="width: 500px; ">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : MainSystemList) {%>
										<option value="<%=obj[0]%>"  ><%=obj[3]%> </option>
											<%} %>
  									</select>
						          		</div>
						          		<div style="margin-top:-30px; margin-left:520px;">
						          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myForm" value="ADD"  style="width:42px; height: 26px; font-size:11px; font-weight: bold; text-align: justify; "/>
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
$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".fa").addClass("fa-minus").removeClass("fa-plus");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".fa").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".fa").removeClass("fa-minus").addClass("fa-plus");
    });
});

$('#Clk').click();

$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
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