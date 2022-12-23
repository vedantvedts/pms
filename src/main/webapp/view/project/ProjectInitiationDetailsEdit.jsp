<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>

<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />


<title>PROJECT INT  LIST</title>


<style type="text/css">
.container-fluid  {
overflow-x: hidden;
}

.control-label{
	font-size: 24px;
    font-family: Muli;
    margin-left: 4px;
    color:black;
    text-transform: uppercase;

}

.card-body{
	background-color: #e2ebf0;
}

.card{
	border: 1px solid grey;
	
	}
	
small{
	margin-top: 7px;
    color: green;
    font-weight: 500;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

.card-body{
	background-color: #e2ebf0;
	padding-left:30px;
	padding-right:0px;
	padding-top:0px;
	padding-bottom:0px;
}

.card{
	border: 1px solid grey;
	
	}
	
small{
	margin-top: 7px;
    color: green;
    font-weight: 500;
}


</style>
</head>
<body>

<%
	List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
	String Details=(String)request.getAttribute("Details");
	Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");

%>

<div class="container-fluid"> 
<div class="row">
<div class="col-md-12 ">

		<%for(Object[] obj : DetailsList) {%>

			<%if(Details.equalsIgnoreCase("requirement")){ %>

                <form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Requirements
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	<div class="row">
						  					
		                               <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        		</div>
		                   					
										<div class="col-md-11" >
		                                     <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Brief" name="ReqBrief" maxlength="250" value="<%if(obj[13]!=null){%><%=obj[13]%><%}else{%><%}%> "placeholde="maximum 250 characters" >  
		                        			 </div>
		                   				</div> 
		                   							
		                   			</div>
							</div>
						<div class="card-body">
									    		<label >Detailed: </label>
						  	<div id="content">
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										<div  id="summernote" class="center"><%if(obj[0]!=null){%><%=obj[0]%><%}else{%><%}%></div>
									</div>
									<textarea name="Requirements" style="display:none;" ></textarea>
									<input type="hidden" name="details" value="requirement" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   	
								</div>		

								<br>
									 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                			
            <%} %> 
            

            <%if(Details.equalsIgnoreCase("objective")){ %>

				<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm1"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Objective
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
							<div class="row">
									<div class="form-group">
		                                 <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        	</div>
		                   					 
									<div class="col-md-11">
		                                 <div class="form-group">
		                                   <input style="margin-top:25px;"  type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Brief" name="ObjBrief" maxlength="250" value="<%if(obj[14]!=null){%><%=obj[14]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        		</div>
		                   			</div>
		                   		</div>
						</div>
						<div class="card-body">
								<label class="control-label">Detailed: </label>
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom:10px; margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[1]!=null){%><%=obj[1]%><%}else{%><%}%></div>
												
									</div>
									 
									<textarea name="objective" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="objective" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>
								
								<br>
									 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		
            <%} %> 
            
            
            <%if(Details.equalsIgnoreCase("scope")){ %>

               <form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm2"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Scope
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	
						  	<div class="row">
											   <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="ScopeBrief" maxlength="250" value="<%if(obj[15]!=null){%><%=obj[15]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   	</div>
												</div>
								<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[2]!=null){%><%=obj[2]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="scope" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="scope" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>		
									 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form> 
                		
            <%} %> 
            
            <%if(Details.equalsIgnoreCase("multilab")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm3"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Multi-Lab Work Share
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	<div class="row">
									<div class="form-group">
		                                 <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        	</div>
		                   					 
									<div class="col-md-11">
		                                   <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="MultiLabBrief" maxlength="250" value="<%if(obj[16]!=null){%><%=obj[16]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			</div>
		                   			</div> 
		                   	</div>
						</div>
						<div class="card-body">
							<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[3]!=null){%><%=obj[3]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="multilab" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="multilab" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>	
									 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form> 
                		
            <%} %> 
            
            <%if(Details.equalsIgnoreCase("earlierwork")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm4"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Earlier Work
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	
						  	<div class="row">
									<div class="form-group">
		                                  <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        	</div>
		                   					 
									<div class="col-md-11">
		                                <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" name="EarlierWorkBrief" maxlength="250" value="<%if(obj[17]!=null){%><%=obj[17]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        		</div>
		                   			</div> 
		                   					  
		                   	</div>
					</div>
					<div class="card-body">
							<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[4]!=null){%><%=obj[4]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="earlierwork" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="earlierwork" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>	 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		 
            <%} %> 
            
             <%if(Details.equalsIgnoreCase("competency")){ %>

             	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm5"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Competency Established
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  
						  
						  	<div class="row">
												 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="CompentencyBrief" maxlength="250" value="<%if(obj[18]!=null){%><%=obj[18]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					  
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[5]!=null){%><%=obj[5]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="competency" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="competency" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		 
            <%} %> 
            
            <%if(Details.equalsIgnoreCase("needofproject")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm6"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Need Of Project
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	
						  
						  	<div class="row">
												 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="NeedOfProjectBrief" maxlength="250" value="<%if(obj[19]!=null){%><%=obj[19]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					   
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[6]!=null){%><%=obj[6]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="needofproject" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="needofproject" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>	
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		  
            <%} %>  
            
            
             <%if(Details.equalsIgnoreCase("technology")){ %>

             	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm7"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Technology Challenges
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	
						  
						  	<div class="row">
												 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" name="TechnologyBrief" id="Brief" maxlength="250" value="<%if(obj[20]!=null){%><%=obj[20]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					 
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[7]!=null){%><%=obj[7]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="technology" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="technology" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>		
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		  
            <%} %>  
            
            <%if(Details.equalsIgnoreCase("riskmitigation")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm8"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Risk Mitigation
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  
						  
						  	<div class="row">
											 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="RiskMitigationBrief" maxlength="250" value="<%if(obj[21]!=null){%><%=obj[21]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[8]!=null){%><%=obj[8]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="riskmitigation" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="riskmitigation" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		  
            <%} %>
            
            <%if(Details.equalsIgnoreCase("proposal")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm9"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Proposal
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	
						  	<div class="row">
											 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="ProposalBrief" maxlength="250" value="<%if(obj[22]!=null){%><%=obj[22]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[9]!=null){%><%=obj[9]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="proposal" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="proposal" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>
									
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		  
            <%} %> 
            
            <%if(Details.equalsIgnoreCase("realization")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm10"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	Realization Plan
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	<div class="row">
										 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="RealizationBrief" maxlength="250" value="<%if(obj[23]!=null){%><%=obj[23]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					   
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  
						  	<div id="content">
						  	
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[10]!=null){%><%=obj[10]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="realization" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="realization" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>
									 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		  
            <%} %> 
                
                
              <%if(Details.equalsIgnoreCase("worldscenario")){ %>

            	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myForm" id="myfrm11"> 
                		
                	<div class="card" >
						<h3 class="card-header " > 
						 	World Scenario
						 <small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						 </h3>
						  
						  <div class="card-body" >
						  	
						   
						  	<div class="row">
								 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="WorldScenarioBrief" maxlength="250" value="<%if(obj[24]!=null){%><%=obj[24]%><%}else{%><%}%>" placeholde="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
						  					<div id="content">
						  	
								
								<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
									
									
									<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
									
										<div  id="summernote" class="center"><%if(obj[12]!=null){%><%=obj[12]%><%}else{%><%}%></div>
												
									</div>
									  
									<textarea name="worldscenario" style="display:none;"></textarea>
									
									<input type="hidden" name="details" value="worldscenario" />
                					<input type="hidden" name="IntiationId"	value="<%=obj[11]%>" /> 
                					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
												
								</div>
									 			
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
								  
  							</div>	
  							
						  </div>
					</div>
						
					<div class="form-group" align="center" style="margin-top: 15px">
						<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
						<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
					</div>
                		
                </form>
                		  
            <%} %>   
                
                
                
                
                  <%} %> <!-- end of main for loop -->
                
       
                       
                        
        </div>

</div>
</div>

<script>

$('#myfrm').submit(function() {
    
	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=Requirements]').val(data);

 });
 
$('#myfrm1').submit(function() {
    
	  
	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=objective]').val(data);
	  

});

$('#myfrm2').submit(function() {
 
	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=scope]').val(data);

});

$('#myfrm3').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=multilab]').val(data);

});

$('#myfrm4').submit(function() {
	 
	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=earlierwork]').val(data);

});

$('#myfrm5').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=competency]').val(data);

});

$('#myfrm6').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=needofproject]').val(data);

});

$('#myfrm7').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=technology]').val(data);

});

$('#myfrm8').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=riskmitigation]').val(data);

});

$('#myfrm9').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=proposal]').val(data);

});

$('#myfrm10').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=realization]').val(data);

});

$('#myfrm11').submit(function() {

	  var data =CKEDITOR.instances['summernote'].getData();
	  $('textarea[name=worldscenario]').val(data);

});


CKEDITOR.replace( 'summernote', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>


</body>
</html>
