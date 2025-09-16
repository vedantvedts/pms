<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.project.model.ProjectMaster"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>Technical Closure List</title>

<spring:url value="/resources/css/projectModule/techClosure.css" var="techClosureCss"/>
<link rel="stylesheet" type="text/css" href="${techClosureCss}">

</head>
<body>

<%
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	FormatConverter fc = new FormatConverter();
	
	List<Object[]> list=(List<Object[]>)request.getAttribute("TechnicalClosureRecord");
	
	List<Object[]>DocumentSummaryList=(List<Object[]>)request.getAttribute("DocumentSummary");
	
	Object[]  DocumentSummary =(null);
	
	List<Object[]> TotalEmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");
	
	List<Object[]> MemberList=(List<Object[]>)request.getAttribute("DocSharingMemberList");
	
	List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");
	
	String closureId=(String)request.getAttribute("closureId");
	
	if(DocumentSummaryList!=null && DocumentSummaryList.size()>0){
		DocumentSummary=DocumentSummaryList.get(0);
	}
	
	List<String> status = Arrays.asList("TIN","TRG","TRA","TRP","TRD","TGD","TRV");

	
	Object[] PDData = (Object[])request.getAttribute("PDData");
	Object[] AD = (Object[])request.getAttribute("AD");
	Object[] GD = (Object[])request.getAttribute("GDDetails");
	Object[] Director = (Object[])request.getAttribute("Director");
	Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
	
	ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
	
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
	 
<br>	
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
		
			<div class="card shadow-nohover" >
			<div class="card-header">
			<div class="row">
			   <div class="col-md-10"><h4>Technical Project Closure Record Of Amendments -  <%if(projectMaster!=null) {%><%=StringEscapeUtils.escapeHtml4(projectMaster.getProjectShortName())+" ("+projectMaster.getProjectCode()+")" %> <%} %></h4></div>
			   <div class="col-md-2" align="right">
			   <a class="btn btn-info btn-sm  back"   href="ProjectClosureList.htm">Back</a>
				</div>
			</div>
			</div>
				<div class="card-body"> 
		              
					 <div class="data-table-area mg-b-15">
			            <div class="container-fluid">
			                <form action="##" method="get" >
			                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      <thead>
			                                         
			                           	<tr>
			                           	
				                            <th class="text-center" >SN</th>
				                            <th class="text-center" >Particulars </th>
		                                    <th class="text-center" >Revision No</th>
		                                    <th class="text-center" >Issue Date </th>
		                                    <th class="text-center" >Status</th>
		                                    <th class="text-center" >Action</th>
		                                    
		                                 </tr>      
			        
			                          </thead>
			                    <tbody>
			                    
			                    <% 
			                    int count=0;
			                    for(Object[] obj:list) {%>
			                    
			                    <tr>
			                            <td><%=++count%></td>
			                            <td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
			                           
			                            <td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></td>
			                            <td><%=obj[3]!=null?fc.SqlToRegularDate(obj[3].toString()):" - "%></td>
			                            
			                            <td >
			                            <button type="submit" class="btn btn-sm btn-link  btn-status fw-600" formaction="ProjectTechClosureTransStatus.htm" value="<%=obj[0] %>" name="TechClosureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
							    				<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> <i class="fa fa-telegram mt-03rem" aria-hidden="true"></i>
							    			</button>
			                            </td>
			                            
			                            <td>
			                            
			                            <input type="hidden" name="ClosureId" value="<%=closureId %>">
			                            
			                            
			                             <%if (obj[4]!=null  && status.contains(obj[4].toString())){ %>
			                             
			                              
			                            <button class="editable-clicko" name="TechnicalClosureId" value="<%=obj[0] %>" formaction="TechClosureContent.htm" formmethod="get" data-toggle="tooltip" data-placement="top" title="Content Add">
											<div class="cc-rockmenu">
												<div class="rolling">
													<figure class="rolling_icon">
														<img src="view/images/documentedit.png" class="icon-width-25">
													</figure>
													<span>Content</span>
												</div>
											</div>
						    			</button>
						    			
						    			
						    			 <button type="button" class="editable-clicko" name="TechnicalClosureId" value="<%=obj[0] %>"  onclick="DocSummary()" data-toggle="tooltip" data-placement="top" title="Document Summary">
											<div class="cc-rockmenu">
												<div class="rolling" >
													<figure class="rolling_icon">
														<img src="view/images/docpaper.png" class="icon-width-25">
													</figure>
													<span>Doc Summary</span>
												</div>
											</div>
						    			</button>
						    			
						    			
						    	
						    			<button type="button" class="editable-clicko" name="" value=""  onclick="DocumentDistribution('<%=obj[0]%>','<%=closureId %>')" data-toggle="tooltip" data-placement="top" title="Document Distribution" >
											<div class="cc-rockmenu">
												<div class="rolling" >
													<figure class="rolling_icon">
														<img src="view/images/docdistrib.png" class="icon-width-25">
													</figure>
													<span>Doc Distrib</span>
												</div>
											</div>
						    			</button>
						    			
						    			
						    		
						    			 
						    			
						    			 <button type="submit" class="editable-clicko" name="TechAndClosureId" value="<%=closureId%>/<%=obj[0]%>/A"  formaction="projectTechClosureApprovalSubmit.htm" formmethod="get" data-toggle="tooltip" data-placement="top" title="Forward" onclick="return confirm('Are You Sure To Submit')">
											<div class="cc-rockmenu">
												<div class="rolling" >
													<figure class="rolling_icon">
														<img src="view/images/forward1.png" class="icon-width-25">
													</figure>
													<span>Forward</span>
												</div>
											</div>
						    			</button>
						    			
						    			
						    			
						    			<%}else{ 
						    			
						    			if(obj[4].toString().equalsIgnoreCase("TDG")){ %>
						    				
						    				<button type="submit" class="btn btn-sm fw-600" formaction="TechnicalClosureReportFreezeDownload.htm" formtarget="blank" name="TechClosureId" value="<%=obj[0] %>" data-toggle="tooltip" data-placement="top" title="Download">
  										            <i class="fa fa-download"></i>
  									             </button>
  									             &nbsp;
  									           
  									             
  									       <button type="submit" class="btn btn-warning btn-sm edit" name="Amend" value="<%=obj[1]%>//<%=Integer.parseInt(StringEscapeUtils.escapeHtml4(obj[2].toString())) + 1%>//<%=closureId!=null?StringEscapeUtils.escapeHtml4(closureId): " - "%>//<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%>" formaction="AmendTechClosureList.htm" onclick="return confirm('Are You Sure To Amend')" >AMEND</button>
						                 	
						    			<%}else if(obj[4].toString().equalsIgnoreCase("TAM")) { %>
  									        
  									        
  									        <button type="submit" class="btn btn-sm fw-600" formaction="TechnicalClosureReportFreezeDownload.htm" formtarget="blank" name="TechClosureId" value="<%=obj[0] %>" data-toggle="tooltip" data-placement="top" title="Download">
  										            <i class="fa fa-download"></i>
  									             </button>	
						    			
						    			
						    			<% }else{%>
						    				
						    				<button type="submit" class="btn btn-sm fw-600" formaction="TechnicalClosureReportDownload.htm" formtarget="blank" name="TechAndClosureId" value="<%=closureId%>/<%=obj[0]%>" data-toggle="tooltip" data-placement="top" title="Download">
									            <i class="fa fa-download"></i>
								        </button>
						    			
						    			<%}} %>
						    			
						    			
						    			
						    		</td>
			                    </tr>
			               <%}%>
	                                
	                         </tbody>
				    		</table>
			               </div>
			             </div>
			           </div>
			         </div>
			       </form>
			      </div>
			    </div>
			      
			    <% if(list!=null && list.size()==0){ %>    
					 <div align="center">
					     <button type="submit" class="btn btn-primary btn-sm add" onclick="AddIssue()" >ADD ISSUE</button>&nbsp;&nbsp;  
						  
					</div>
		        <%}%>	
		        
		        <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />

             </div>
		  
		     
		     <%---------------------------------------------------------------------------Approval Flow Start------------------------------------------------------------------------------------------%>
                            
                                        <div class="row">
				 		  					<div class="col-md-12 text-center"><b>Approval Flow For Technical Closure</b></div>
				 	    				</div>
				 	    				<div class="row apr-flow">
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup pd-bg">
			                							PD -  <%=PDData[2]!=null?StringEscapeUtils.escapeHtml4(PDData[2].toString()): " - "%>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup gd-bg">
			                							GD - <%if(GD!=null) {%><%=GD[1]!=null?StringEscapeUtils.escapeHtml4(GD[1].toString()): " - " %> <%} else{%>GD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup ad-bg">
			                							AD - <%if(AD!=null) {%><%=AD[1]!=null?StringEscapeUtils.escapeHtml4(AD[1].toString()): " - " %> <%} else{%>AD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup dpnc-bg">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=GDDPandC[1]!=null?StringEscapeUtils.escapeHtml4(GDDPandC[1].toString()): " - " %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup director-bg">
			                							Director - <%if(Director!=null) {%><%=Director[1]!=null?StringEscapeUtils.escapeHtml4(Director[1].toString()): " - " %> <%} else{%>Director<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup dg-bg">
			                							Director General
			                	    				</td>
			               						</tr> 	
			               	    			</table>			             
					 					</div>        
	                    			
		     <%------------------------------------------------------------Approval Flow End ------------------------------------------------------------------------%>
		     
			  </div>
			</div>		 					
		  </div>
	   </div>              				
	   
	   	

	
	
	
<div class="modal" id="AddIsuueModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add Version/Release</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="TechClosureList.htm" method="get">
        	<table class="w-100">
        		
        		<tr>
        			<th >Particulars : &nbsp; </th>
        			<td><input type="text" class="form-control" name="Particulars" id="" title="Enter Particulars" required></td>
        		</tr>
        		
        		
        		<tr>
        			<td colspan="2" class="text-center">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" onclick="return confirm('Are You Sure to Submit?');">Amend Document</button>
        			</td>
        		</tr>
        		
        	</table>
        	
        	<input type="hidden" name="Action" value="Add">
        	<input type="hidden" name="closureId" value="<%=closureId%>">
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
        </form>
      </div>
     
    </div>
  </div>
</div>




<%------------------------------------------------------------------Document Summary -------------------------------------------------%>
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="SummaryModal">
  <div class="modal-dialog modal-dialog-jump modal-lg ">
    <div class="modal-content ds-modal">
         <div class="modal-header" id="ModalHeader">
            <h5 class="modal-title" id="exampleModalLabel">Document Summary</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
               </button>
          </div>
      
      
   		<div class="modal-body">
   		 <form action="DocSummaryAdd.htm" method="post">
   		   <div class="row">
   			  <div class="col-md-4">
   			       <label class="ds-field">Additional Information:</label>
   			  </div>
   			 <div class="col-md-8">
   				<textarea required="required" name="information"class="form-control" id="additionalReq" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[0]!=null){%><%=DocumentSummary[0].toString()%><%}else{%><%}%></textarea>
   			 </div> 
   			</div>
   			
   			<div class="row mt-2">
   			   <div class="col-md-4">
   			       <label class="ds-field">Abstract:</label>
   			   </div>
	   			<div class="col-md-8">
	   				<textarea required="required" name="abstract" class="form-control" id="" maxlength="4000"
					rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[1]!=null){%><%=DocumentSummary[1].toString()%><%}else{%><%}%></textarea>
	   			</div> 
   			</div>
   			
   		<div class="row mt-2">
   			<div class="col-md-4">
   			      <label class="ds-field">Keywords:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="keywords"
				class="form-control" id="" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[2]!=null){%><%=DocumentSummary[2].toString()%><%}else{%><%}%></textarea>
   			</div> 
   		</div>
   			
   		<div class="row mt-2">
   			   <div class="col-md-4">
   			         <label class="ds-field">Distribution:</label>
   			   </div>
   			<div class="col-md-8">
   				<input required="required" name="distribution" class="form-control" id="" maxlength="255"
				 placeholder="Maximum 255 Chararcters" required value="<%if(DocumentSummary!=null && DocumentSummary[3]!=null){%><%=StringEscapeUtils.escapeHtml4(DocumentSummary[3].toString())%><%}else{%><%}%>">
   			</div> 
   		</div>
   				<div class="row mt-2">
   			       <div class="col-md-2">
			   	       <label class="ds-field">Prepared By:</label>
			   	   </div>
				   <div class="col-md-4">
		   		       <select class="form-control selectdee"name="preparer" id=""data-width="100%" data-live-search="true"  required>
				          <option value="" selected>--SELECT--</option>
				           <%for(Object[]obj:TotalEmployeeList){ %>
				            <option value="<%=obj[0].toString()%>"
				                <%if(DocumentSummary!=null && DocumentSummary[9]!=null && DocumentSummary[9].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
				                      <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %></option>
				                <%} %> 
		                 </select>
	   				</div>
   			     </div>
   			<div class="row mt-2">
			   <div class="col-md-2">
			   	        <label class="ds-field">Reviewer:</label>
			   </div>
			 <div class="col-md-4">
	   		     <select class="form-control selectdee"name="Reviewer" id=""data-width="100%" data-live-search="true"  required>
			          <option value="" selected>--SELECT--</option>
				        <%for(Object[]obj:TotalEmployeeList){ %>
				        <option value="<%=obj[0].toString()%>"
				        <%if(DocumentSummary!=null && DocumentSummary[4]!=null && DocumentSummary[4].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
				        <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %></option>
			           <%} %> 
	             </select>
   				
   			</div>
   				
   				<div class="col-md-2">
			   	      <label class="ds-field">Approver:</label>
			   	</div>	
   				<div class="col-md-4">
		   			<select class="form-control selectdee"name="Approver" id=""data-width="100%" data-live-search="true"  required>
				       <option value="" selected>--SELECT--</option>
					        <%for(Object[]obj:TotalEmployeeList){ %>
					        <option value="<%=obj[0].toString()%>"
					        <%if(DocumentSummary!=null && DocumentSummary[5]!=null && DocumentSummary[5].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
					        <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %></option>
				        <%} %> 
		            </select>
   				</div>
   			</div>
   			
		   	<div class="mt-2" align="center">
		      <%if(DocumentSummaryList!=null && DocumentSummaryList.size()>0) {%>
		           <button class="btn btn-sm edit" value="edit" name="btn" onclick="return confirm ('Are you sure to submit?')">UPDATE</button>
		   	       <input type="hidden" name="summaryid" value="<%=DocumentSummary[8]%>"> 
		   <%}else{ %>
		   	<button class="btn btn-sm submit" name="btn" value="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
		   <%} %> 
		   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="closureId" value="<%=closureId%>">
		  </div>
      </form>
     </div>
    </div>
  </div>
</div> 



<!--------------------------------------------------------------------------------- modal Open for Document Distribution --------------------------------------------------------------->
<div class="modal fade" id="DistributionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
    <div class="modal-content tbl-width">
      <div class="modal-header doc-dist-modal" id="ModalHeader">
        <h5 class="modal-title" >Document Sent to</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" class="text-light">&times;</span>
          </button>
      </div>
      <div class="modal-body">
        
            <div class="row mb-2">
		       <div class="col-md-12">
				<table class="table table-bordered" id="myTables">
					<thead>
						<tr>
							<th class="text-center">SN</th>
							<th class="text-center">Name</th>
							<th class="text-center">Designation</th>
						</tr>
					</thead>
					<tbody id="modal_table_body">
					
					</tbody>
				</table>
		   </div>      
      </div>
     
					<form action="DocDistribMemberSubmit.htm" method="post">
						<div class="row">
							<div class="col-md-9">
								<select class="form-control selectdee" name="Assignee"
									id="Assignee" data-width="100%" data-live-search="true"
									multiple required>
									<% for (Object[] obj : EmployeeList) { %>
									    <option value="<%=obj[0].toString()%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ")%></option>
									<%}%>
								</select>
							</div>
							<div class="col-md-1" >
								<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
								<!-- <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden"> -->

								<button type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')">SUBMIT</button>
							</div>
						</div>
							<input type="hidden" name="TechClosureId" id="techclosureid" value="">
						<input type="hidden" name="ClosureId" value="<%=closureId%>">
					</form>
				</div>
		    </div>
		  </div>
		</div>
		<%----------------------------------------------------------Modal Close for Document Distribution ----------------------------------------------------%>







<script type="text/javascript">

function AddIssue(){
	
$('#AddIsuueModal').modal('toggle');

}
function DocSummary(techclosureid,closureid){

     $('#SummaryModal').modal('toggle');

}


function DocumentDistribution(techclosureid,closureid){
	
	$('#techclosureid').val(techclosureid);
	
	$.ajax({
		type:'GET',
		url:'DocDistributionList.htm',
		datatype:'json',
		data:{
			TechClosureId:techclosureid,
		},
		success:function(result){
		var result=JSON.parse(result);
		var htmlStr='';
		
		if(result.length>0){
			
		for(var v=0;v<result.length;v++)
	    {
		
		
		htmlStr += '<tr>';
		
		htmlStr += '<td class="tabledata text-center">'+ (v+1) +  '</td>';
		htmlStr += '<td class="tabledata text-left">'+ result[v][1] + '</td>';
		htmlStr += '<td class="tabledata text-left">'+ result[v][2] + ' </td>';
		
		htmlStr += '</tr>';
		}

		
		}
		else
		{
			
		htmlStr += '<tr>';
		
		htmlStr += '<td colspan="3" class="text-center"> No Record Found </td>';
		
		htmlStr += '</tr>';
		
		}
		
		
		$('#modal_table_body').html(htmlStr);
		    
		$('#DistributionModal').modal('toggle'); 
		   
		}
	 });
	
}



$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
 });
$(document).ready(function(){
	  $("#myTable1").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
});

function showSummaryModal(){
	$('#SummaryModal').modal('show');
}


</script>

</body>
</html>