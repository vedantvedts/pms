<%@page import="com.vts.pfms.docs.model.PfmsDocTemplate"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>PFMS</title>

<jsp:include page="../static/header.jsp"></jsp:include>

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
<style>

.control-label{
	font-weight: bold !important;
}


.table thead th{
	
	vertical-align: middle !important;
}

.header{
        position:sticky;
        top: 0 ;
        background-color: #346691;
    }
    
    .table button{
    	background-color: background !important;
    	font-size: 12px;
    }
    
.col-form-label{
	font-weight: 600!important;
	
}
 
.title ul {
    -moz-column-count: 3;
    -moz-column-gap: 10px;
    -webkit-column-count: 3;
    -webkit-column-gap: 10px;
    column-count: 3;
    column-gap: 10px;
}
 
 .fa-upload{
 	color:#007bff;
 }
 
.documenttitle label{
	font-size: 15px;
	font-family: 'Lato',sans-serif;
}

.fa-file-text{
	color:green;
}

.version{
	color:#145374;
	font-size: 14px;
    font-weight: 600;
    font-family: 'Muli';

}

.noselect {
  -webkit-touch-callout: none; /* iOS Safari */
    -webkit-user-select: none; /* Safari */
     -khtml-user-select: none; /* Konqueror HTML */
       -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome and Opera */
}

 
</style>
<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested {
  display: none;
}

.active {
  display: block;
}





</style>

<!-- ---------------- tree ----------------- -->

</head>
<body style="background-color: #e2ebf0" >

<%

List<Object[]> parentlist=(List<Object[]>) request.getAttribute("parentlist");
List<Object[]> assignedlist=(List<Object[]>) request.getAttribute("assignedlist");
String projectid = (String) request.getAttribute("projectid");
List<Object[]> projectlist=(List<Object[]>) request.getAttribute("projectslist");
List<PfmsDocTemplate> doctemplatelist=(List<PfmsDocTemplate>) request.getAttribute("doctemplatelist");
String l1id = (String) request.getAttribute("l1id");
String l2id = (String) request.getAttribute("l2id");
String l3id = (String) request.getAttribute("l3id");
String projectdocid = (String) request.getAttribute("projectdocid");

Object[] docdata=(Object[]) request.getAttribute("docdata");

%>

<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>


	<div align="center">
	
		<div class="alert alert-danger" role="alert">
		
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
		
			<%=ses %>
		</div>

	</div>
	<%} %>


<div class="container-fluid">

	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-6">
							<h3 class="control-label" > Document Templates</h3>
						</div>
						<div class="col-md-6">
							<form  method="post" action="DocumentTemplate.htm" id="myform">	
								<table style="float: right;">
									<tr>
										<td><label class="control-label">Project :&nbsp;&nbsp; </label></td>
								    	<td>
								    		<select class="form-control selectdee" id="projectid" required="required"  name="projectid" onchange="$('#myform').submit();">
									    		<option disabled="disabled"   value="">Choose...</option>
									    		<option value="0"  <%if(projectid.equalsIgnoreCase("0")){  %>selected="selected" <%} %>>General</option>
									    			<% for (Object[] obj : projectlist) {%>
														<option value="<%=obj[0]%>"  <%if(projectid.equalsIgnoreCase(obj[0].toString())){  %>selected="selected" <%} %>> <%=obj[4]%> </option>
													<%} %>
								  			</select>
								  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
								  		</td>
								  	</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			<!-- card header -->

					<div class="card-body" style="min-height: 31rem; "> 	

						<div class="row" >
<!----------------------------------- tree Start ---------------------------------------------- -->						
							<div class="col-md-5">		
								<ul>	
								<%for(Object[] obj :parentlist)
								{ 
									if(Long.parseLong(obj[2].toString())==1)
									{%>  
									<li >
										<span class="caret" id="l1-<%=obj[0]%>" onclick="onclickchange(this);" >
							            		<%=obj[3] %>
							            	</span>
										 <ul  class="nested">
											<li>
							<!-- ----------------------------------------level 1------------------------------------- -->	
												<%for(Object[] obj1 :parentlist)
												{ 
												if(Long.parseLong(obj1[2].toString())==2 && Long.parseLong(obj1[1].toString())==Long.parseLong(obj[0].toString()) )
												{%>  
												<li>
														<span class="caret" id="l2-<%=obj1[0]%>" onclick="onclickchange(this);" >
						             						<%=obj1[3] %>
						             					</span>
														
													<ul  class="nested">
														<li>
										<!-- ----------------------------------------level 2------------------------------------- -->	
												 		<%for(Object[] obj2 : assignedlist)
															{ %>
																<%if( Long.parseLong(obj2[2].toString())==3 && Long.parseLong(obj2[1].toString())==Long.parseLong(obj1[0].toString())) 
																
																{%>
																	<li>
																		<span class="caret-last noselect" id="l3-<%=obj2[0]%>" style="cursor: pointer;" onclick="submitform('<%=obj[0]%>','<%=obj1[0]%>','<%=obj2[0]%>','<%=obj2[0]%>'); " >
																			<%=obj2[3] %>(<%=obj2[4] %>)
																		</span>
																	</li>	
																<%}
															} %>			
										<!-- ----------------------------------------level 2------------------------------------- -->
														</li>
													</ul>
											<%}
											} %>
											</li>	
							<!-- ----------------------------------------level 1------------------------------------- -->
											</li>
										</ul> 
									</li>	
								<%}
								} %>
								</ul>							
							</div>
<!----------------------------------- tree end ---------------------------------------------- -->
							
							<div class="col-md-7">
							<%if(docdata!=null){ %>
								<div class="col-12" style="margin-left: -10px;margin-top: -10px" >																		
								    <div class="panel panel-info" >
								    	<div class="panel-heading " >
								        	<div class="panel-title" style="font-size: 15px; margin: -3px -3px 0px -3px;color: #4FBD45"> 
									        		<form action="DocTemplatePDF.htm" method="post" target="_blank">
										        		<%=docdata[2] %>(<%=docdata[4] %>)
										        		<%if(doctemplatelist.size()>0){ %>
											        		<span style="float:right;font-size:14px;" >
													   			<button type="submit" class="btn btn-sm" >
													   				<i class="fa fa-download" aria-hidden="true" style="color: green"></i>
													   			</button>&nbsp;&nbsp;&nbsp;
												   				<button type="submit" class="btn btn-sm"  formaction="DocTemplateExcel.htm"><i class="fa fa-file-excel-o" style="color: blue" aria-hidden="true"></i></button>
												   			</span>
											   			<%} %>
											   			<input type="hidden" name="projectid" value="<%=projectid%>">
											   			<input type="hidden" name="fileuploadmasterid"  value="<%=docdata[0] %>" />
											   			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
										   			</form>
												</div> 	
											</div>     
										
										<div id="collapse0" class="panel-collapse  collapse in show">
								         	<%	int count = 1;
								         		for(PfmsDocTemplate item : doctemplatelist){
								         		if(item.getLevelNo()==1){	%>
								         	<div class="panel panel-info" >
									      		<div class="panel-heading ">
									        		<div class="panel-title">
									        			
										        		<span  style="font-size:14px" id="span-text-<%=item.getTemplateItemId() %>" >
										        			<%=count %> ) <%=item.getItemName() %>
											        		<i class="btn btn-sm fa fa-pencil-square-o " aria-hidden="true" onclick="itemeditenable(<%=item.getTemplateItemId()%>);"></i>
											        		<%-- <i class="btn btn-sm fa fa-trash " aria-hidden="true" onclick="itemeditsubmit('<%=item.getTemplateItemId()%>','D');"></i> --%>
										        		</span>
										        		<span style="font-size:14px;display: none;"  id="span-edit-<%=item.getTemplateItemId() %>"  >								        				
										        			<%=count %> . <input type="text" id="edit-itemname-<%=item.getTemplateItemId() %>" class="hiddeninput" value="<%=item.getItemName()  %>" required="required" maxlength="255">
												       		<button type="button" class="btn btn-sm btn-info editbtn"  onclick="itemeditsubmit('<%=item.getTemplateItemId()%>','E');">UPDATE</button>
												       		<button type="button" class="btnx" style="color: red;" id="btnx_<%=item.getTemplateItemId() %>" onclick="itemeditdisable('<%=item.getTemplateItemId() %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
										        		</span>
									        			
									        		</div>									         	
													<div   style="float: right !important; margin-top:-20px; ">  
														<a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=item.getTemplateItemId() %>" > <i class="fa fa-plus faplus " ></i></a>
											   		</div>
											    </div>
										    
											    <div id="collapse<%=item.getTemplateItemId() %>" class="panel-collapse collapse in ">
					<!-- ---------------------------------------------------------------------------------------------------- --> 
												<div class="row">  
													<%	int count1 = 1;
													for(PfmsDocTemplate item1 : doctemplatelist){
									         		if(item1.getLevelNo()==2 && item1.getParentLevelId()==item.getTemplateItemId()){	%>
													<div class="col-md-11"  align="left"  style="margin-left: 20px;">
														<div class="panel panel-info">
															<div class="panel-heading">
																<h4 class="panel-title">
																
																	<span  style="font-size:14px" id="span-text-<%=item1.getTemplateItemId() %>" >
													        			<%=count %>.<%=count1 %>) <%=item1.getItemName() %>
														        		<i class="fa fa-pencil-square-o " aria-hidden="true" onclick="itemeditenable(<%=item1.getTemplateItemId()%>);"></i>							
													        		</span>
													        		<span style="font-size:14px;display: none;"  id="span-edit-<%=item1.getTemplateItemId() %>"  >								        				
													        			<%=count %>.<%=count1 %>) <input type="text" id="edit-itemname-<%=item1.getTemplateItemId() %>" class="hiddeninput" value="<%=item1.getItemName()  %>" required="required" maxlength="255">
															       		<button type="button" class="btn btn-sm btn-info editbtn"  onclick="itemeditsubmit('<%=item1.getTemplateItemId()%>','E');">UPDATE</button>
															       		<button type="button" class="btnx" style="color: red;" id="btnx_<%=item1.getTemplateItemId() %>" onclick="itemeditdisable('<%=item1.getTemplateItemId() %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
													        		</span>																	

																</h4>
																<div style="float: right !important; margin-top:-20px; " > 
														       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=item1.getTemplateItemId() %>" > <i class="fa fa-plus faplus " ></i></a>
														       	</div>
															</div>
															
															<div id="collapse<%=item1.getTemplateItemId() %>" class="panel-collapse collapse in ">
								    <!-- ---------------------------------------------------------------------------------------------------- -->
																<div class="row"> 
																	<%	int count2 = 1;
																		for(PfmsDocTemplate item2 : doctemplatelist){
									         							if(item2.getLevelNo()==3 && item2.getParentLevelId()==item1.getTemplateItemId()){	%> 
																	<div class="col-md-11"  align="left"  style="margin-left: 20px;">
																		<div class="panel panel-info">
																			<div class="panel-heading">
																				<h4 class="panel-title">
																					
																					<span  style="font-size:14px" id="span-text-<%=item2.getTemplateItemId() %>" >
																	        			<%=count %>.<%=count1 %>.<%=count2 %> ) <%=item2.getItemName() %>
																		        		<i class="fa fa-pencil-square-o " aria-hidden="true" onclick="itemeditenable(<%=item2.getTemplateItemId()%>);"></i>							
																	        		</span>
																	        		<span style="font-size:14px;display: none;"  id="span-edit-<%=item2.getTemplateItemId() %>"  >								        				
																	        			<%=count %>.<%=count1 %>.<%=count2 %> )<input type="text" id="edit-itemname-<%=item2.getTemplateItemId() %>" class="hiddeninput" value="<%=item2.getItemName()  %>" required="required" maxlength="255">
																			       		<button type="button" class="btn btn-sm btn-info editbtn"  onclick="itemeditsubmit('<%=item2.getTemplateItemId()%>','E');">UPDATE</button>
																			       		<button type="button" class="btnx" style="color: red;" id="btnx_<%=item2.getTemplateItemId() %>" onclick="itemeditdisable('<%=item2.getTemplateItemId() %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
																	        		</span>		
																					
																				</h4>
																			</div>
																		
																		</div>
																	</div>
																	<%count2++;}} %>
																	<div class="col-md-11"  align="left"  style="margin-left: 20px;">
																		<div class="panel panel-info">
																			<div class="panel-heading ">
																	        	<form method="post" action="TemplateItemAdd.htm" autocomplete="off" >
																		        	<h4 class="panel-title"> 
																		        		<span  style="font-size:14px"><%=count %>.<%=count1 %>.<%=count2 %>)</span>
																		        		<input type="text" class="" style="width:70%; " maxlength="255" required="required" name="itemname" value="" > 
																		        		<button type="submit" class="btn btn-sm btn-success" style="width:40px; height: 24px; font-size:10px; font-weight: bold; text-align: justify; margin-top: -4px; " name="submit" value="add" onclick="return confirm('Are You Sure to Submit?');">ADD</button>
																		        		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																		        		<input type="hidden" name="l1id" value="<%=l1id %>" />
																						<input type="hidden" name="l2id" value="<%=l2id %>" />
																						<input type="hidden" name="l3id" value="<%=l3id %>" />
																						<input type="hidden" name="levelno" value="3" />
																						<input type="hidden" name="parentlevelid" value="<%=item1.getTemplateItemId() %>" />
																						<input type="hidden" name="fileuploadmasterid"  value="<%=docdata[0] %>" />
																						<input type="hidden" name="projectdocid"  value="<%=projectdocid %>" />
																						<input type="hidden" name="projectid"  value="<%=projectid %>" />
																		        	</h4>									         	
																			   	</form>
																			</div>
																		</div>
																	</div>
																	
																</div>
									<!-- ---------------------------------------------------------------------------------------------------- -->					  	
															</div>      
															
														</div>
													</div>
													<% count1++;
														}
									         		} %>
													<div class="col-md-11"  align="left"  style="margin-left: 20px;">
														<div class="panel panel-info">
															<div class="panel-heading ">
													        	<form method="post" action="TemplateItemAdd.htm" autocomplete="off" >
														        	<h4 class="panel-title"> 
														        		<span  style="font-size:14px"><%=count %>.<%=count1 %>)</span>
														        		<input type="text" class="" style="width:70%; " maxlength="255" required="required" name="itemname" value="" > 
														        		<button type="submit" class="btn btn-sm btn-success" style="width:40px; height: 24px; font-size:10px; font-weight: bold; text-align: justify; margin-top: -4px; " name="submit" value="add" onclick="return confirm('Are You Sure to Submit?');">ADD</button>
														        		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														        		<input type="hidden" name="l1id" value="<%=l1id %>" />
																		<input type="hidden" name="l2id" value="<%=l2id %>" />
																		<input type="hidden" name="l3id" value="<%=l3id %>" />
																		<input type="hidden" name="levelno" value="2" />
																		<input type="hidden" name="parentlevelid" value="<%=item.getTemplateItemId() %>" />
																		<input type="hidden" name="fileuploadmasterid"  value="<%=docdata[0] %>" />
																		<input type="hidden" name="projectdocid"  value="<%=projectdocid %>" />
																		<input type="hidden" name="projectid"  value="<%=projectid %>" />
														        	</h4>									         	
															   	</form>
															</div>
														</div>
													</div>
												</div>
										
					<!-- ---------------------------------------------------------------------------------------------------- --> 
												</div> 
												</div>
											
											<%count++ ;}
									        }%>
									        
									        <div class="panel-heading ">
									        	<form method="post" action="TemplateItemAdd.htm" autocomplete="off" >
										        	<h4 class="panel-title"> 
										        		<span  style="font-size:14px"><%=count %>)</span>
										        		<input type="text" class="" style="width:70%; " maxlength="255" required="required" name="itemname" value="" > 
										        		<button type="submit" class="btn btn-sm btn-success" style="width:40px; height: 24px; font-size:10px; font-weight: bold; text-align: justify; margin-top: -4px; " name="submit" value="add" onclick="return confirm('Are You Sure to Submit?');">ADD</button>
										        		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
										        		<input type="hidden" name="l1id" value="<%=l1id %>" />
														<input type="hidden" name="l2id" value="<%=l2id %>" />
														<input type="hidden" name="l3id" value="<%=l3id %>" />
														<input type="hidden" name="levelno" value="1" />
														<input type="hidden" name="parentlevelid" value="0" />
														<input type="hidden" name="fileuploadmasterid"  value="<%=docdata[0] %>" />
														<input type="hidden" name="projectdocid"  value="<%=projectdocid %>" />
														<input type="hidden" name="projectid"  value="<%=projectid %>" />
										        	</h4>									         	
											   	</form>
											</div>
										 	
										</div>
									</div>
								</div>
								<%} %>
							</div>
													
						</div>
					</div> 
				</div> 
			
			</div>
		</div>

	</div>
<%if(docdata!=null){ %>
<form method="POST" action="TempItemNameEdit.htm"  id="f2" > 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="l1id"  value="<%=l1id %>" />
	<input type="hidden" name="l2id"  value="<%=l2id %>" />
	<input type="hidden" name="l3id"  value="<%=l3id %>" />
	<input type="hidden" name="projectdocid"  value="<%=projectdocid %>" />
	<input type="hidden" name="projectid"  value="<%=projectid %>" />
	<input type="hidden" name="fileuploadmasterid"  value="<%=docdata[0] %>" />
	<input type="hidden" name="itemname" id="f2-itemname" value="" />
	<input type="hidden" name="templateid" id="f2-templateid" value="" />
	<input type="hidden" name="action" id="f2-action" value="" />
</form>
<%} %>
<form method="POST" action="DocumentTemplate.htm"  id="f1" > 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="l1id" id="f1-l1id" value="" />
	<input type="hidden" name="l2id" id="f1-l2id" value="" />
	<input type="hidden" name="l3id" id="f1-l3id" value="" />
	<input type="hidden" name="fileuploadmasterid" id="f1-fileuploadmasterid" value="" />
	<input type="hidden" name="projectid" value="<%=projectid %>" />
</form>
	
<script type="text/javascript">

function submitform(l1id,l2id,l3id,fileuploadmasterid)
{
	$('#f1-l1id').val(l1id);
	$('#f1-l2id').val(l2id);
	$('#f1-l3id').val(l3id);
	$('#f1-fileuploadmasterid').val(fileuploadmasterid);
	$('#f1').submit();
}


function itemeditenable(itemid)
{
	$('#span-text-'+itemid).hide();
	$('#span-edit-'+itemid).show();
}
function itemeditdisable(itemid)
{
	$('#span-text-'+itemid).show();
	$('#span-edit-'+itemid).hide();
}


function itemeditsubmit(itemid,editdelete)
{
	if(editdelete==='E' && confirm('Are You Sure To Update?')){
		$('#f2-templateid').val(itemid);
		$('#f2-itemname').val($('#edit-itemname-'+itemid).val());
		$('#f2-action').val(editdelete);
		$('#f2').submit();
	}else if(editdelete==='D'){
		
		 $.ajax({
				
				type : 'GET',
				url : 'ItemContentCheckAjax.htm',
				data : {
					templateitemid : itemid,						
				},
				datatype: 'json',
				success : function(result){
					result = Number(result);
					console.log(result);
					if(result==0 && confirm('Are You Sure To Delete?') )
					{
						$('#f2-templateid').val(itemid);
						$('#f2-action').val(editdelete);
						$('#f2').submit(); 
					}
					if(result>0)
					{
						alert('Cannot Delete This Item');
					}
				},error : function(result){
					
					alert('Internal Error Occured !!');
				}
		 });
		
	}
}


</script>
<script type="text/javascript">
var l1id= <%=l1id %>;
var l2id= <%=l2id %>;
var l3id= <%=l3id %>;
var projectdocid= <%=projectdocid %>;

<%if(l3id!=null){ %>
$( document ).ready(function() {
$('#l1-'+l1id).click();
$('#l2-'+l2id).click();
$('#l3-'+l3id).css('font-weight','700');
});

<%} %>
</script>

<script type="text/javascript">

var toggler = document.getElementsByClassName("caret");
var i;
for (i = 0; i <toggler.length; i++) {
  toggler[i].addEventListener("click", function() {	
	this.parentElement.querySelector(".nested").classList.toggle("active");   
    this.classList.toggle("caret-down");
  });
}


function onclickchange(ele)
{
	elements = document.getElementsByClassName('caret');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");

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



</script>

</body>
</html>