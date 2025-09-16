<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>   
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/projectModule/projectRiskData.css" var="projectRiskDataCss"/>
<link rel="stylesheet" type="text/css" href="${projectRiskDataCss}">

<title>Briefing </title>

<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();

SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");

List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String)request.getAttribute("projectid");

List<Object[]> risktypelist=(List<Object[]>)request.getAttribute("risktypelist");
String logintype =(String)session.getAttribute("LoginType"); 
String actionassignid =(String)request.getAttribute("actionassignid");
Object[] riskdata=(Object[] )request.getAttribute("riskdata");
Object[] riskmatrixdata=(Object[])request.getAttribute("riskmatrixdata");
List<Object[]> projectriskmatrixrevlist=(List<Object[]>)request.getAttribute("projectriskmatrixrevlist");
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

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="col-md-12">
					<div class="row card-header ml13-width102">
			   			<div class="col-md-6">
			   			<%if(riskmatrixdata==null){ %>
							<h4>Add Risk Data (<%=riskdata[7]!=null?StringEscapeUtils.escapeHtml4(riskdata[7].toString()): " - " %>)</h4>
						<%}else{ %>
							<h4>Risk Data (<%=riskdata[7]!=null?StringEscapeUtils.escapeHtml4(riskdata[7].toString()): " - " %>)</h4>
						<%} %>
						</div>
						<div class="col-md-6 justify-content-end" >
						</div>
					 </div>
				</div>	 
				<%if(Long.parseLong(projectid)>=0){ %>
					<div class="card-body">	
						<div class="row">		
						   <div class="col-md-12" align="center">
							<%if(riskmatrixdata==null){ %>
							    <form method="post" action="ProjectRiskDataSubmit.htm" >
							    	<table  class="tbl-border">
							    		<tr>
								    		<td>	
								    				<label ><b>Project : </b></label> 	
								    				<%if(Long.parseLong(projectid)==0){ %>
								    					General
								    				<%}else if(Long.parseLong(projectid)>0){ 					    					
														for(Object[] obj : projectslist){ %>
															<%if(projectid!=null && projectid.equals(obj[0].toString())) { %><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %> <%} 
														} 
													}%>						    			
								    		</td>
								    		<td class="width60per">
							    					<label ><b>Description : </b></label> <%=riskdata[1]!=null?StringEscapeUtils.escapeHtml4(riskdata[1].toString()): " - " %> 
								    		</td>
								    		
								    		<%if(riskdata[5].toString().equalsIgnoreCase(riskdata[6].toString())){ %>
							    			<td >
							    					<label ><b>PDC : </b></label> <%=sdf2.format(riskdata[5])%> 
								    		</td>
								    		<%}else{ %>
								    		<td >
							    					<label ><b>PDC : </b></label> <%=sdf2.format(riskdata[6])%> 
								    		</td>
								    		<td >
							    					<label ><b>PDC Org : </b></label> <%=sdf2.format(riskdata[5])%> 
								    		</td>
								    		
								    		<%} %>
								    		
								    	</tr>
								    </table>
								    <br>
								    <br>
							    	<table  class="tbl-border2">
								    	<tr>
								    		<td class="width7per">
								    			<label class="txt-decoration"><b>Severity </b>  </label>
								    		</td> 
								    		<td class="width2per">
								    			<b>X</b>
								    		</td> 
								    		<td class="width7per">
								    			<label class="txt-decoration"><b>Probability </b>  </label>
								    		</td> 
								    		<td class="width2per">
								    			<b>=</b>
								    		</td> 
								    		<td class="width7per">
								    			<label class="txt-decoration"><b>RPN </b>  </label>
								    		</td> 
								    	</tr>
							    		<tr>
							    			
							    			<td >
									    		<!-- <input class="form-control" type="text" name="severity"  required maxlength="200" >	 -->
									    		 <!-- <input type="range" min="1" max="10" class="slider" id="myRange"> -->					
									    		 <select class="form-control" name="severity" id="severity" onchange="calculateRPN();" required="required" >
									    		 		<%for(int i=1;i<=10;i++){ %>
									    		 			<option value="<%=i%>"><%=i%></option>
									    		 		<%} %>
									    		 </select>
									    		 
							    			</td>
							    			<td >
								    			<b>X</b>
								    		</td> 
							    			 
							    			<td >
									    		<!-- <input class="form-control" type="text" name="probability"  required maxlength="200" >	 -->
									    		<select class="form-control" name="probability" id="probability" onchange="calculateRPN();" required="required" >
									    		 		<%for(int i=1;i<=10;i++){ %>
									    		 			<option value="<%=i%>"><%=i%></option>
									    		 		<%} %>
									    		 </select>						    				
							    			</td>
							    			<td >
							    				<b>=</b>
							    			</td> 
							    			
							    			<td >
									    		<span class="fw-600" id="RPN"></span>					    				
							    			</td>
							    		</tr>	
							    	</table>
							    	<br>	
							    	<br>
							    	<table class="tbl-border3">
							    		<tr>
							    			<td class="width20per">
							    				<label ><b>Mitigation Plans</b>  :<span class="mandatory red-color">*</span></label> 
							    			</td> 
							    			<td colspan="5" class="max-width-40">
									    		<input class="form-control lh4" type="text" name="mitigationplans"  required  maxlength="950">							    				
							    			</td>
							    		</tr>		
							    		<tr>
							    			<td class="width20per">
							    				<label ><b>Impact</b> : <span class="mandatory width20per">*</span></label> 
							    			</td> 
							    			<td colspan="5" class="max-width-40">
									    		<input class="form-control lh4" type="text" name="Impact"  required  maxlength="1000">							    				
							    			</td>
							    		</tr>	
							    		<tr>
							    			<td class="width20per">
							    				<label ><b>Category</b>  : <span class="mandatory red-color">*</span></label> 
							    			</td> 
							    			<td colspan="1" class="max-width-40">
									    		<select class="form-control width20per" name="category" required="required">
									    			<option value="I">Internal</option>
									    			<option value="E">External</option>
									    		</select>				    				
							    			</td>
							    		</tr>	
							    		<tr>
							    			<td class="width20per">
							    				<label ><b>Type</b>  : <span class="mandatory red-color">*</span></label> 
							    			</td> 
							    			<td colspan="1" class="max-width-40">
									    		<select class="form-control width20per" name="risk_type" required="required">
									    			<%for(Object[] risktpye : risktypelist){ %>
									    				<option value="<%=risktpye[0]%>"><%=risktpye[1]!=null?StringEscapeUtils.escapeHtml4(risktpye[1].toString()): " - "%></option>
									    			<%} %>
									    		</select>							    				
							    			</td>
							    		</tr>	
							    							
							    		<tr>
							    			<td colspan="2" class="center">
							    				<button type="submit" class="btn btn-sm submit mt15px">SUBMIT</button>
							    				<button type="button" class="btn btn-sm back mt15px" onclick="submitForm('backfrm');" >BACK</button>
							    			</td>
							    		</tr>	    		
									</table>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    	
							    	<input type="hidden" name="actionmainid" value="<%=riskdata[0]%>"/>
							    	<input type="hidden" name="actionassignid" value="<%=riskdata[8]%>"/>
							  </form>
							  
							  
							  <% }else{ %>
							  		 <form method="post" action="ProjectRiskDataEdit.htm" id="editrevform" >
											    
								    	<table  class="tbl-border">
								    		<tr>
									    		<td>	
									    				<label ><b>Project : </b></label> 	
									    				<%if(Long.parseLong(projectid)==0){ %>
									    					General
									    				<%}else if(Long.parseLong(projectid)>0){ 					    					
															for(Object[] obj : projectslist){ %>
																<%if(projectid!=null && projectid.equals(obj[0].toString())) { %><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %> <%} 
															} 
														}%>						    			
									    		</td>
									    		<td class="width60per">
								    					<label ><b>Description : </b></label> <%=riskdata[1]!=null?StringEscapeUtils.escapeHtml4(riskdata[1].toString()): " - " %> 
									    		</td>
									    		
									    		<%if(riskdata[5].toString().equalsIgnoreCase(riskdata[6].toString())){ %>
								    			<td >
								    					<label ><b>PDC : </b></label> <%=sdf2.format(riskdata[5])%> 
									    		</td>
									    		<%}else{ %>
									    		<td >
								    					<label ><b>PDC : </b></label> <%=sdf2.format(riskdata[6])%> 
									    		</td>
									    		<td >
								    					<label ><b>PDC Org : </b></label> <%=sdf2.format(riskdata[5])%> 
									    		</td>
									    		
									    		<%} %>
									    		
									    	</tr>
									    </table>
									    <br>
									    <br>
								    	<table  class="tbl-border2">
									    	<tr>
									    		<td class="width7per">
									    			<label class="txt-decoration"><b>Severity </b>  </label>
									    		</td> 
									    		<td class="width2per">
									    			<b>X</b>
									    		</td> 
									    		<td class="width7per">
									    			<label class="txt-decoration"><b>Probability </b>  </label>
									    		</td>
									    		<td class="width2per">
									    			<b>=</b>
									    		</td> 
									    		<td class="width7per">
									    			<label class="txt-decoration"><b>RPN </b>  </label>
									    		</td> 
									    	</tr>
								    		<tr>
								    			<td >
										    		 <select class="form-control" name="severity" id="severity" onchange="calculateRPN();" required="required" >
										    		 		<%for(int i=1;i<=10;i++){ %>
										    		 			<option value="<%=i%>" <%if(Integer.parseInt(riskmatrixdata[4].toString())==i){ %>selected <%} %> ><%=i%></option>
										    		 		<%} %>
										    		 </select>
								    			</td>
								    			<td >
									    			<b>X</b>
									    		</td> 
								    			 
								    			<td >
										    		<!-- <input class="form-control" type="text" name="probability"  required maxlength="200" >	 -->
										    		<select class="form-control" name="probability" id="probability" onchange="calculateRPN();" required="required" >
										    		 		<%for(int i=1;i<=10;i++){ %>
										    		 			<option value="<%=i%>" <%if(Integer.parseInt(riskmatrixdata[5].toString())==i){ %>selected <%} %>><%=i%></option>
										    		 		<%} %>
										    		 </select>						    				
								    			</td>
								    			<td >
								    				<b>=</b>
								    			</td> 
								    			
								    			<td >
										    		<span class="fw-600" id="RPN"></span>					    				
								    			</td>
								    		</tr>	
								    	</table>
								    	<br>	
								    	<br>
								    	<table class="tbl-border3">
								    		<tr>
								    			<td class="width12per">
								    				<label ><b>Mitigation Plans :</b> <span class="mandatory red-color">*</span> </label> 
								    			</td> 
								    			<td colspan="5" class="max-width-40">
										    		<input class="form-control lh4" type="text" name="mitigationplans" value="<%=riskmatrixdata[6]!=null?StringEscapeUtils.escapeHtml4(riskmatrixdata[6].toString()): "" %>" required  maxlength="950">							    				
								    			</td>
								    		</tr>		
								    		<tr>
								    			<td class="width12per">
								    				<label ><b>Impact :</b> <span class="mandatory red-color">*</span> </label> 
								    			</td> 
								    			<td colspan="5" class="max-width-40">
										    		<input class="form-control  lh4" type="text" name="Impact" value="<%=riskmatrixdata[10]!=null?StringEscapeUtils.escapeHtml4(riskmatrixdata[10].toString()): "" %>" required  maxlength="1000">							    				
								    			</td>
								    		</tr>	
								    		<tr>
								    			<td class="width20per">
								    				<label ><b>Category</b>: <span class="mandatory red-color">*</span></label> 
								    			</td> 
								    			<td colspan="1" class="max-width-40">
										    		<select class="form-control width20per" name="category" required="required">
										    			<option value="I" <%if(riskmatrixdata[11].toString().equalsIgnoreCase("I")){ %> selected <%} %> >Internal</option>
										    			<option value="E" <%if(riskmatrixdata[11].toString().equalsIgnoreCase("E")){ %> selected <%} %> >External</option>
										    		</select>				    				
								    			</td>
								    		</tr>	
								    		<tr>
								    			<td class="width20per">
								    				<label ><b>Type</b> : <span class="mandatory red-color">*</span></label> 
								    			</td> 
								    			<td colspan="1" class="max-width-40">
										    		<select class="form-control width20per" name="risk_type" required="required">
										    			<%for(Object[] risktpye : risktypelist){ %>
										    				<option value="<%=risktpye[0]%>" <%if(riskmatrixdata[12].toString().equalsIgnoreCase(risktpye[0].toString())){ %> selected <%} %>><%=risktpye[1]!=null?StringEscapeUtils.escapeHtml4(risktpye[1].toString()): " - "%></option>
										    			<%} %>
										    		</select>							    				
								    			</td>
								    		</tr>
								    <%if(riskmatrixdata!=null && riskmatrixdata[13]!=null && riskmatrixdata[13].toString().equalsIgnoreCase("C")){ %>
								    		<tr>
								    			<td class="width20per">
								    				<label ><b>Status</b> : </label> 
								    			</td> 
								    			<td colspan="1" class="max-width-40">Closed</td>
								    		</tr>
								    		
								    		<tr>
								    			<td class="width20per">
								    				<label ><b>Remarks</b> : </label> 
								    			</td> 
								    			<td colspan="1" class="max-width-40"><%=riskmatrixdata[14]!=null?StringEscapeUtils.escapeHtml4(riskmatrixdata[14].toString()): " - "%></td>
								    		</tr>	
								    	<%}%>						
								    		<tr>
								    			<td colspan="2" class="center" >
									    			<%if(riskmatrixdata[13]!=null && riskmatrixdata[13].toString().equalsIgnoreCase("O")){if(Long.parseLong(riskmatrixdata[7].toString())==0){ %>
									    				<button type="submit" class="btn btn-sm edit mt15px" onclick="return confirm('Are You Sure to Edit ?');">EDIT</button>
									    				<input type="hidden" name="actionassignid" value="<%=riskdata[8]%>"/>
									    			<%}%>
									    				<button type="button" class="btn btn-sm submit mt15px" onclick="return appendrev('editrevform');" >REVISE</button>
									    			<%}if(riskmatrixdata!=null && riskmatrixdata[13]!=null && riskmatrixdata[13].toString().equalsIgnoreCase("O") && logintype!=null && logintype.equalsIgnoreCase("A") || logintype.equalsIgnoreCase("P") || logintype.equalsIgnoreCase("Z") || logintype.equalsIgnoreCase("C")|| logintype.equalsIgnoreCase("I")  ){%>
									   <!--------------------------------- Close button Only for Admin , Director , project Director  ----------------------------->
									    				<button type="button" class="btn btn-danger btn-sm revoke mt15px" onclick="CloseRiskmodal('<%=riskmatrixdata[0]%>','<%=riskdata[0]%>');"  >CLOSE RISK </button>
									    			<%}%>	
									    				<button type="button" class="btn btn-sm back mt15px" onclick="submitForm('backfrm');"  >BACK</button>
									    		</td>
								    		</tr>	    		
										</table>
										
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="riskid" value="<%=riskmatrixdata[0]%>"/>
										<input type="hidden" name="revisionno" value="<%=riskmatrixdata[7]%>"/>
								    	<input type="hidden" name="actionmainid" value="<%=riskdata[0]%>"/>
								    	<input type="hidden" name="actionassignid" value="<%=riskdata[8]%>"/>
								  </form>
								  
							   <%} %>
							</div>
						</div>
					</div>
				<%} %>
				</div>
				
				<form action="ProjectRisk.htm" method="post" id="backfrm">
					<input type="hidden" name="projectid" value="<%=projectid%>"/>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				
<!--  ----------------------------------  revision data  ---------------------------------  -->
				<br>
			<%if(projectriskmatrixrevlist.size()>0){ %>
				<div class="card shadow-nohover">
					 <div class="col-md-12">
						<div class="row card-header">
				   			<div class="col-md-6">
								<h3>Revision History </h3>
							</div>
						</div>
					</div>
				<div class="card-body">					
						
						<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >		
							<thead>
								<tr>
									<th class="width5per" >No</th>
									<th class="w-25" >Description</th>
									<th class="width5per" >Severity</th> 
									<th class="width5per" >Probability</th>
									<th class="width5per" >RPN</th>	
									<th class="width15per" >Mitigation Plans</th>							
								 	<th class="w-25" > Impact</th>
								 	<th class="width10per" > Revised on</th>
								 	<th class="width5per" >Category</th>
								 	<th class="width5per" > Type</th>
								 	
								</tr>
							</thead>
							<tbody>
								<%for(Object[] obj : projectriskmatrixrevlist){ %>
									<tr>
										<td class="center"><%=Long.parseLong(StringEscapeUtils.escapeHtml4(obj[7].toString())) %></td>
										<td class=""><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
										<td class="center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
										<td class="center"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
										<td class="center"><%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %></td>
										<td class=""><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></td>
										<td class=""><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %></td>
										<td class="center"><%=sdf.format(sdf1.parse(StringEscapeUtils.escapeHtml4(obj[8].toString())) )%></td>
										<td class=""><%if(obj[11].toString().equalsIgnoreCase("I")){ %>Internal <%}else{ %> External<%} %></td>
										<td class=""><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - " %></td>
									</tr>
								<%} %>
							</tbody>
						</table>
					
				<%} %>
	<!--  ----------------------------------  revision data  ---------------------------------  -->	
					
					</div>
			</div>
		</div>
	
	</div>
	<div class="modal fade" id="Closefeedback" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered maxwidth53-height45" role="document">
				<div class="modal-content min-height-45">
				    <div class="modal-header modal-header-bg">
				    	<h4 class="modal-title close-risk" id="model-card-header">Close Risk </h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
					          <span aria-hidden="true">&times;</span>
				        </button>
				    </div>
				     <div class="modal-body">
  	      
  	      	<form action="CloseProjectRisk.htm" method="POST">
  	      		<div class="row">
	  	      		<div class="col-md-4">
	  	      			<label> <b>Project : </b> </label> &nbsp;&nbsp; <%if(Long.parseLong(projectid)==0){ %>
								    					General
								    				<%}else if(Long.parseLong(projectid)>0){ 					    					
														for(Object[] obj : projectslist){ %>
															<%if(projectid!=null && projectid.equals(obj[0].toString())) { %><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %> <%} 
														} 
													}%>
	  	      		</div>
	  	      		<div class="col-md-4">
	  	      		<%if(riskdata[5].toString().equalsIgnoreCase(riskdata[6].toString())){%>
								    <label ><b>PDC : </b></label> <%=sdf2.format(riskdata[5])%>
					<%}else{%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								    <label ><b>PDC : </b></label> <%=sdf2.format(riskdata[6])%> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								    <label ><b>PDC Org : </b></label> <%=sdf2.format(riskdata[5])%> 
					<%}%>
	  	      		</div>
	  	      		<div class="col-md-12">
	  	      			<label ><b>Description : </b></label> <%=riskdata[1]!=null?StringEscapeUtils.escapeHtml4(riskdata[1].toString()): " - " %>
	  	      		</div>
					<div class="col-md-12" > <label ><b>Remarks : </b></label><br>
  	      		    		<textarea rows="3" maxlength="999" class="form-control dis-block"  id="Remarks" name="Remarks"  placeholder="Enter Remarks..!!"  required="required"></textarea>
  	      		    </div>
  	      		</div>
  	      		<br>
  	      		<div align="center">
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		</div>
  	      		<input type="hidden" name="RiskId" id="RISKID">
  	      		<input type="hidden" name="ProjectId"  value="<%=projectid%>">
  	      		<input type="hidden" name="actionAssignId"  value="<%=actionassignid%>">
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      </div>
				</div>
			</div>
		</div>
</div>
<script type="text/javascript">

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 

function appendrev(frmid){
	 
	      $("<input />").attr("type", "hidden")
	          .attr("name", "rev")
	          .attr("value", "1")
	          .appendTo('#'+frmid);
	     if(confirm('Are You Sure To Revise?')){
	    	 $('#'+frmid).submit();
	     }
	}
	
	
	

		$(document).ready(function(){
			$("#myTable").DataTable({
				"lengthMenu": [  5,10,25, 50, 75, 100 ],
			 	"pagingType": "simple"
			});
		});

  		function calculateRPN()
  		{
  			var $sev = $('#severity').val();
  			var $pro = $('#probability').val();
  			$('#RPN').html( Number($sev) * Number($pro) );
  		}
  		$(document).ready(calculateRPN());
  		
  		function CloseRiskmodal(riskid ,actionid)
  		{
  			$("#RISKID").val(riskid);
  			$("#ACTIONID").val(actionid);
  			$('#Closefeedback').modal('toggle');
  		}

</script>


</body>
</html>