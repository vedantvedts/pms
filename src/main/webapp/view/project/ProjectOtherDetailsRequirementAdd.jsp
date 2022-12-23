<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>


<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />


<title>PROJECT OTHER  DETAILS REQUIREMENT ADD</title>
<style type="text/css">

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
.card{
border:1px solid black;
background-color: #e2ebf0;
}

.card-body{
	background-color: #e2ebf0;
	padding-left:30px;
	padding-right:0px;
	padding-top:0px;
	padding-bottom:0px;
}
</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList"); 
String Parameter=(String) request.getAttribute("details_param");

%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>



<div class="container-fluid">
	<div class="row" >
		<div class="col-md-12">
	

		<%if(Parameter!=null){ %>
				
					<%if(Parameter.equalsIgnoreCase("objective")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm1" id="myfrm1" >	
		
							<div class="row"> 
								<div class="col-md-12" >
									
										<div class="card" >
											
											<h3 class="card-header">
												Objective
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 			<div class="row">
													 <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="ObjBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   				
		                   					   </div>
												</div>
												<div class="card-body">
												 <label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
														 <div  id="summernote" class="center">		</div> 
												
													</div>
													
									  
									  				<textarea name="objective" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="objective"> 
									 			</div>  
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
					
					<%if(Parameter.equalsIgnoreCase("scope")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm2" id="myfrm2" >	
		
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												Scope
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 		<div class="row">
											   <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="Brief" name="ScopeBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   				
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="scope" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="scope"> 
									 			
									 			</div>  
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
					
					<%if(Parameter.equalsIgnoreCase("multilab")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm3" id="myfrm3" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
											
											<h3 class="card-header">
												Multi-Lab Work Share
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 				<div class="row">
										   <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="MultiLabBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					 
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="multilab" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="multilab"> 
									 			
									 			</div>  
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
		
					<%if(Parameter.equalsIgnoreCase("earlierwork")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm4" id="myfrm4" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												Earlier Work
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
											
										
											<div class="card-body">
									    		
									 			<div class="row">
											   <div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="EarlierWorkBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					 
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="earlierwork" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="earlierwork"> 
									 			
									 			</div>  
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
		
					<%if(Parameter.equalsIgnoreCase("competency")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm5" id="myfrm5" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
											
											<h3 class="card-header">
												Competency Established
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 <div class="row">
											<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Brief" name="CompentencyBrief" maxlength="250"  placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="competency" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="competency"> 
									 			
									 			</div>  
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
					
					<%if(Parameter.equalsIgnoreCase("requirement")){%>

					  	<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm" id="myfrm" >	

					<div class="row"> 
							<div class="col-md-12"  >
									
							<div class="card" >
					
								<h3 class="card-header">
							Requirements
						<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
						</h3>				
											
						<div class="card-body">
						
											<div class="card-body">
									    		
									    		<div class="row">
												<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="Brief" name="ReqBrief" maxlength="250" placeholder="maximum 250 characters" >  
		                        			   </div>
		                   					   </div> 
		                   					
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									    			  
							<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
								<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
									<div  id="summernote" class="center">		</div>
												
								</div>
									  
								<textarea name="Requirements" style="display:none;"></textarea>
									  
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
								<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
								<input type="hidden" name="details" value="requirement"> 	
							</div>  
						
								<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
						</div>
									 		
							<div class="form-group" align="center"  style=" margin-top:10px;">
								<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
								<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
							</div>
									 		
							</div>		 		
									 		
					</div>
				</div>
			</div>
								
		</form>



					<%}%>
					
					<%if(Parameter.equalsIgnoreCase("technology")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm7" id="myfrm7" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
											
											<h3 class="card-header">
												Technology Challenges
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 			<div class="row">
											<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="TechnologyBrief" maxlength="250" placeholder="maximum 250 characters" >  
		                        			   </div>
		                   					   </div> 
		                   					
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="technology" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="technology"> 
									 			
									 			</div>  
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
					
					<%if(Parameter.equalsIgnoreCase("riskmitigation")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm8" id="myfrm8" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												Risk Mitigation
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    			<div class="row">
												<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Brief" name="RiskMitigationBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					  
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="riskmitigation" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="riskmitigation"> 
									 			
									 			</div>  
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
					
					<%if(Parameter.equalsIgnoreCase("proposal")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm9" id="myfrm9" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												Proposal
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		<div class="row">
													<div class="form-group">
			                                     	  <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
			                        			   </div>
		                   					 
												<div class="col-md-11">
			                                        <div class="form-group">
			                                       	 <input style="margin-top:25px;"  type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Brief" name="ProposalBrief" maxlength="250" placeholder="maximum 250 characters">  
			                        			   </div>
		                   					   </div> 
		                   					
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="proposal" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="proposal"> 
									 			
									 			</div>  
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
				
					<%if(Parameter.equalsIgnoreCase("realization")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm10" id="myfrm10" >	

							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												Realization Plan
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 			<div class="row">
												<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="Brief" name="RealizationBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   					  
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="realization" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="realization"> 
									 			
									 			</div>  
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
					
					
					<%if(Parameter.equalsIgnoreCase("worldscenario")){%>
		
						<form action="ProjectInitiationDetailsSubmit.htm" method="POST" name="myfrm11" id="myfrm11" >	

							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												World Scenario
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
									    		
									 			<div class="row">
												<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="WorldScenarioBrief" maxlength="250"  placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 
		                   				
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="worldscenario" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													<input type="hidden" name="details" value="worldscenario"> 
									 			
									 			</div>  
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>

					<%}%>
			
			
				
		<%}else{ %>
		
		
		<form action="ProjectOtherDetailsAddSubmit.htm" method="POST" name="myfrm6" id="myfrm6" >	
		
							<div class="row"> 
								<div class="col-md-12"  >
									
										<div class="card" >
										
											<h3 class="card-header">
												Need of Project
											<small class="float-md-right" style="font-size: 18px;">Project Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)</small>
											</h3>
										
											<div class="card-body">
											
											<div class="row">
											<div class="form-group">
		                                       <label  style="margin-top:25px; margin-left:15px;">Brief : </label>
		                        			   </div>
		                   					 
												<div class="col-md-11">
		                                        <div class="form-group">
		                                        <input style="margin-top:25px;"  type="text" class="form-control"   aria-describedby="inputGroup-sizing-sm" id="Brief" name="NeedOfProjectBrief" maxlength="250" placeholder="maximum 250 characters">  
		                        			   </div>
		                   					   </div> 		     
		                   					   </div>
												</div>
												<div class="card-body">
									    		<label class="control-label">Detailed: </label>
									 			<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
													<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote" class="center">		</div>
												
													</div>
									  
									  				<textarea name="needofproject" style="display:none;"></textarea>
									  
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
													 <input type="hidden" name="details" value="needofproject"> 
									 			
									 			</div>  
												
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
									 		
									 		<div class="form-group" align="center" style=" margin-top:10px;" >
												<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
												<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
											</div>
									 		
										</div>
										
								</div>
							</div>
					</form>
			
	<%} %>
								
								
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