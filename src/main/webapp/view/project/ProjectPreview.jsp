<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/projectModule/projectPreview.css" var="projectPreview" />
<link href="${projectPreview}" rel="stylesheet" />

<title>PROJECT PREVIEW</title>

</head>
<body>

<%

Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailsPreview");  
/* Object[] ProjectDetailes=ProjectDetaileslist.get(0); */
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");  
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList"); 
List<Object[]> CostList=(List<Object[]>)request.getAttribute("CostList"); 
List<Object[]> IntiationAttachment=(List<Object[]>)request.getAttribute("IntiationAttachment"); 
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> AuthorityAttachments=(List<Object[]>)request.getAttribute("AuthorityAttachment");  
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");

%>



<section class="header">
    <div class="container-fluid">
     
     	 <header class=" pb-1">
     	 
     	 <%if(ProjectDetailes[16]!=null){%><%if(ProjectDetailes[16].toString().equalsIgnoreCase("N")) {%>
     	 
     	 	            <h4>Project Title : <%if(ProjectDetailes[7]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()) %><%}else{ %>-<%} %><span class="float-right"><%if(ProjectDetailes[16]!=null){%><%if(StringEscapeUtils.escapeHtml4(ProjectDetailes[16].toString()).equalsIgnoreCase("N")) {%>Main Project : <%=ProjectDetailes[17]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[17].toString()): " - "%><%}}else{ %>-<%} %></span> </h4>
     	 	
     	 <%} else{%>
     	 
     	 		<h4>Project Title : <%if(ProjectDetailes[7]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()) %> (<%=ProjectDetailes[6]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()): " - " %>)<%}else{ %>-<%} %><span class="float-right"><%if(ProjectDetailes[16]!=null){%><%if(StringEscapeUtils.escapeHtml4(ProjectDetailes[16].toString()).equalsIgnoreCase("N")) {%>Main Project : <%=ProjectDetailes[17]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[17].toString()): " - "%><%}}else{ %>-<%} %></span> </h4>
     	 				
     	 <%} }%>
     	 
        </header> 
     	
        <div class="row">
            <div class="col-md-2">
                <!-- Tabs nav -->
                <div class="nav flex-column nav-pills nav-pills-custom" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <a class="nav-link mb-3 shadow active custom_width" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
                        <i class="fa fa-user-circle-o mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Initiation</span></a>

					 <a class="nav-link mb-3 shadow custom_width" id="v-pills-authority-tab" data-toggle="pill" href="#v-pills-authority" role="tab" aria-controls="v-pills-authority" aria-selected="false">
                        <i class="fa fa-id-badge mr-2" ></i>
                        <span class="font-weight-bold large text-uppercase">Authority</span></a>

                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">
                        <i class="fa fa-check mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Details</span></a>
					
<!-- 					 <a class="nav-link mb-3 shadow custom_width" id="v-pills-requirement-tab" data-toggle="pill" href="#v-pills-requirement" role="tab" aria-controls="v-pills-messages" aria-selected="false">
                   <i class="fa fa-list-alt" aria-hidden="true"></i>
                     <span class="font-weight-bold large text-uppercase">Requirement</span></a> -->
                        
                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">
                        <i class="fa fa-star mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Cost</span></a>

                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">
                        <i class="fa fa-calendar-minus-o mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Schedule</span></a>
                     
                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-attachment-tab" data-toggle="pill" href="#v-pills-attachment" role="tab" aria-controls="v-pills-attachment" aria-selected="false">
                        <i class="fa fa-paperclip mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Attachment</span></a>    
                        
                     <a class="nav-link mb-3 shadow custom_width" id="v-pills-prints-tab" data-toggle="pill" href="#v-pills-prints" role="tab" aria-controls="v-pills-prints" aria-selected="false">
                        <i class="fa fa-print mr-2" aria-hidden="true"></i>
                        <span class="font-weight-bold large text-uppercase">Prints</span></a>   

                    </div>
            </div>


            <div class="col-md-10">
                <!-- Tabs content -->
                <div class="tab-content ml-n4p" id="v-pills-tabContent">
                
                
 <!--  **** INITIATION *********************     -->               
                
                
                    <div class="tab-pane fade shadow rounded bg-white show active p-3" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                        <!-- <h4 class="font-italic mb-4">Initiation</h4> -->
                        
                        <div class="row" >
	 		
			 			
			 			
			 			<div class="col-md-12 ml-43px">
			 			
							<div class="row details">
							  <div class="column a cs-col-a">
							    <h6>Project/Programme</h6>
							    <p><%if(ProjectDetailes[3]!=null){ if(ProjectDetailes[3].toString().equalsIgnoreCase("PRJ")){%> Project <%}if(ProjectDetailes[3].toString().equalsIgnoreCase("PGM")){ %>Program <% } }else{ %>-<%} %></p>
							  </div>
							   <div class="column b cs-col-b">
							    <h6>Category</h6>
							    <p><%if(ProjectDetailes[4]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[4].toString())%><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column a cs-col-a1">
							    <h6>Security Classification</h6>
							    <p><%if(ProjectDetailes[5]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[5].toString()) %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column b cs-col-b1">
							    <h6>Planned</h6>
							    <p><%if(ProjectDetailes[10]!=null){ if(ProjectDetailes[10].toString().equalsIgnoreCase("P")){%>Plan<%}if(ProjectDetailes[10].toString().equalsIgnoreCase("N")){%>Non-Plan<%}}else{ %>-<%} %></p>
							  </div>
							</div>
							
							<div class="row details">
								<div class="column b cs-col-b">
								    <h6>Short Name</h6>
								    <p><%if(ProjectDetailes[6]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()) %><%}else{ %>-<%} %></p>
							  	</div>
								
								<div class="column a cs-col-a2">
								    <h6>Title</h6>
								    <p><%if(ProjectDetailes[7]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()) %><%}else{ %>-<%} %></p>
							  	</div>		
							</div>
							
							<div class="row details">
							  <div class="column a cs-col-a">
							    <h6>Deliverable</h6>
							    <p><%if(ProjectDetailes[12]!=null){%>	<%=StringEscapeUtils.escapeHtml4(ProjectDetailes[12].toString()) %><%}else{ %>-<%} %></p>
							  </div>
							   <div class="column b cs-col-b">
							    <div class="row">
							   		<div class="col">
							   			<h6>Fe Cost</h6>
							    	<p><%if(ProjectDetailes[14]!=null){%> &#8377; <%=StringEscapeUtils.escapeHtml4(ProjectDetailes[14].toString()) %><%}else{ %>-<%} %></p>
							   	</div>
							   	<div class="col">
							   			<h6>Re Cost</h6>
							    	<p><%if(ProjectDetailes[15]!=null){%> &#8377; <%=StringEscapeUtils.escapeHtml4(ProjectDetailes[15].toString()) %><%}else{ %>-<%} %></p>
							   	</div>
							   </div>
							  </div>
							  <div class="column a cs-col-a1">
							    <h6>Duration (Months)</h6>
							    <p><%if(ProjectDetailes[9]!=null){%><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[9].toString()) %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column b cs-col-b1">
							    <h6>Multi Lab</h6>
							    <p><%if(ProjectDetailes[11]!=null){ if(ProjectDetailes[11].toString().equalsIgnoreCase("Y")){%>
							    	Yes 
							    	<%}if(ProjectDetailes[11].toString().equalsIgnoreCase("N")){%>No<%}}else{ %>-<%} %></p>
							  </div>
							</div>
			 		
			 			</div>
			 			
			 		
			 			
	 			</div>
                        
      		</div>
                    
                    
<!-- ********************AUTHORITY*********************************************** -->               
                    
                 
                <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-authority" role="tabpanel" aria-labelledby="v-pills-authority-tab">

                        <div class="row" >
	 					<%if(!AuthorityAttachments.isEmpty()) {%>
			 			<%for(Object[] AuthorityAttachment : AuthorityAttachments ){ %>
			 			
			 			<div class="col-md-12 ml-43px">
			 			
							<div class="row details">
							  <div class="column a cs-col-a">
							    <h6>Authority Name</h6>
							    <p><%if(AuthorityAttachment[2]!=null){%> 
							    
							    			<% if(AuthorityAttachment[2].toString().equals("1")) {%>DRDO-HQ <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("2")) {%>Secy DRDO <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("3")) {%>Director General <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("4")) {%>Director <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("5")) {%>Centre Head <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("6")) {%>User Army <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("7")) {%>User Airforce <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("8")) {%>User Navy <%} %> 
					   						<% if(AuthorityAttachment[2].toString().equals("9")) {%>ADA  <%} %>
							    
							    <%}else{ %> - <%}%>
							    </p>
							  </div>
							   <div class="column b cs-col-b">
							    <h6>Letter Date</h6>
							    <p><%if(AuthorityAttachment[3]!=null){%><%=sdf.format(AuthorityAttachment[3]) %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column a cs-col-b">
							    <h6>Letter Number</h6>
							    <p><%if(AuthorityAttachment[4]!=null){%> <%=StringEscapeUtils.escapeHtml4(AuthorityAttachment[4].toString()) %> <%}else{ %> - <%}%></p>
							  </div>
							   <div class="column b cs-col-b">
							    <h6>Letter</h6>
 										<a  href="ProjectAuthorityDownload.htm?AuthorityFileId=<%=AuthorityAttachment[7] %>" target="_blank"><i class="fa fa-download fa-2x cs-download"></i>
				                    </a>							 
				                </div>
				                </div>
			 			</div>
			 			<%}}else{ %>
			 			<div class="col-md-12 ml-43px">
			 			
							<div class="row details">
							  <div class="column a cs-col-a">
							    <h6>Authority Name</h6>
							    <p>- </p>
							  </div>
							   <div class="column b cs-col-b">
							    <h6>Letter Date</h6>
							    <p>-</p>
							  </div>
							  <div class="column a cs-col-b">
							    <h6>Letter Number</h6>
							    <p>-</p>
							  </div>
							   <div class="column b cs-col-b">
							    <h6>Letter</h6>
							    <P>-</P>				 	
				                </div>
				                </div>
			 					</div> 
			 					<% }%>
			 			
			 		

	 			</div>
      		</div>   
                    
<!--  **** DETAILS *********************     -->
                    
                    <div class="tab-pane fade shadow rounded bg-white p-2" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                        <!-- <h4 class="font-italic mb-4">Details</h4> -->
                        
                        
                        
                        <div class="container m-0 p-0">
						    <div class="col">
						    
						     <div class="tab-vertical">
						            <ul class="nav nav-tabs" id="myTab3" role="tablist">
						            	<li class="nav-item"> <a class="nav-link active" id="needofprj-vertical-tab" data-toggle="tab" href="#needofprj-vertical" role="tab" aria-controls="contact" aria-selected="false">Need Of Project</a> </li>
						                <li class="nav-item"> <a class="nav-link " id="req-vertical-tab" data-toggle="tab" href="#req-vertical" role="tab" aria-controls="home" aria-selected="true">Requirement</a> </li>
						                <li class="nav-item"> <a class="nav-link " id="worldscenario-vertical-tab" data-toggle="tab" href="#worldscenario-vertical" role="tab" aria-controls="home" aria-selected="true">World Scenario</a> </li>
						                <li class="nav-item"> <a class="nav-link" id="obj-vertical-tab" data-toggle="tab" href="#obj-vertical" role="tab" aria-controls="profile" aria-selected="false">Objective</a> </li>
						                <li class="nav-item"> <a class="nav-link" id="scope-vertical-tab" data-toggle="tab" href="#scope-vertical" role="tab" aria-controls="contact" aria-selected="false">Scope</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="multilab-vertical-tab" data-toggle="tab" href="#multilab-vertical" role="tab" aria-controls="contact" aria-selected="false">Multi Lab Work Share</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="earlierwork-vertical-tab" data-toggle="tab" href="#earlierwork-vertical" role="tab" aria-controls="contact" aria-selected="false">Earlier Work</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="competency-vertical-tab" data-toggle="tab" href="#competency-vertical" role="tab" aria-controls="contact" aria-selected="false">Competency Established</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="technology-vertical-tab" data-toggle="tab" href="#technology-vertical" role="tab" aria-controls="contact" aria-selected="false">Technology Challenges</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="risk-vertical-tab" data-toggle="tab" href="#risk-vertical" role="tab" aria-controls="contact" aria-selected="false">Risk Mitigation</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="proposal-vertical-tab" data-toggle="tab" href="#proposal-vertical" role="tab" aria-controls="contact" aria-selected="false">Proposal</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="realization-vertical-tab" data-toggle="tab" href="#realization-vertical" role="tab" aria-controls="contact" aria-selected="false">Realization Plan</a> </li> 
						            </ul>
						            
						            <%for(Object[] 	obj:DetailsList){ %>
						            
						            <div class="tab-content pt-0" id="myTabContent3">
						            	<div class="tab-pane fade " id="worldscenario-vertical" role="tabpanel" aria-labelledby="worldscenario-vertical-tab">
						                    <h3>World Scenario</h3>
						                    <hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[24]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[24].toString()) %><%}else{ %>-<%} %></p>
											<hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[12]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[12].toString()) %><%}else{ %>-<%} %></p></div>
						                </div>
						                <div class="tab-pane fade " id="req-vertical" role="tabpanel" aria-labelledby="req-vertical-tab">
						                    <h3>Requirement</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[13]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[13].toString()) %><%}else{ %>-<%} %></p><hr>				                
										
						                </div>
						                <div class="tab-pane fade" id="obj-vertical" role="tabpanel" aria-labelledby="obj-vertical-tab">
						                    <h3>Objective</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[14]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[14].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString()) %><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="scope-vertical" role="tabpanel" aria-labelledby="scope-vertical-tab">
						                    <h3>Scope</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[15]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[15].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="multilab-vertical" role="tabpanel" aria-labelledby="multilab-vertical-tab">
						                    <h3>Multi Lab Work Share</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[16]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[16].toString()) %><%}else{ %>-<%} %></p><hr>				                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[3].toString()) %><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="earlierwork-vertical" role="tabpanel" aria-labelledby="earlierwork-vertical-tab">
						                    <h3>Earlier Work</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[17]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[17].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[4]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[4].toString()) %><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="competency-vertical" role="tabpanel" aria-labelledby="competency-vertical-tab">
						                    <h3>Competency Established</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[18]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[18].toString()) %><%}else{ %>-<%} %></p><hr>				                
											<div >
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[5]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %><%}else{ %>-<%} %></p></div>						                
										</div>
						                <div class="tab-pane fade show active" id="needofprj-vertical" role="tabpanel" aria-labelledby="needofprj-vertical-tab">
						                    <h3>Need Of Project</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[19]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[19].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[6]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[6].toString()) %><%}else{ %>-<%} %></p></div>					                
											</div>
						                <div class="tab-pane fade" id="technology-vertical" role="tabpanel" aria-labelledby="technology-vertical-tab">
						                    <h3>Technology Challenges</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[20]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[20].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[7]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[7].toString())%><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="risk-vertical" role="tabpanel" aria-labelledby="risk-vertical-tab">
						                    <h3>Risk Mitigation</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[21]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[21].toString()) %><%}else{ %>-<%} %></p><hr>				                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[8]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[8].toString()) %><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="proposal-vertical" role="tabpanel" aria-labelledby="proposal-vertical-tab">
						                    <h3>Proposal</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[22]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[22].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label  class="cs-brief">Detailed</label>
											<p><%if(obj[9]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[9].toString()) %><%}else{ %>-<%} %></p></div>					                
										</div>
						                <div class="tab-pane fade" id="realization-vertical" role="tabpanel" aria-labelledby="realization-vertical-tab">
						                    <h3>Realization Plan</h3><hr>
											<label class="cs-brief">Brief</label>
											<p><%if(obj[23]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[23].toString()) %><%}else{ %>-<%} %></p><hr>					                
											<div>
											<label class="cs-brief">Detailed</label>
											<p><%if(obj[10]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[10].toString()) %><%}else{ %>-<%} %></p></div>						                
										</div>
						            </div>
						            
						            <%} %>
						            
						        </div>
						        
						    </div>
						</div>    
                    </div>
                    <!--****Requirements****-->
                    
                                 <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-requirement" role="tabpanel" aria-labelledby="v-pills-requirement-tab">

                    
	 				       
				               
				                <div class="table-responsive <%if(RequirementList !=null){%> cs-table <%}else{ %> h-63px <%} %>">
				                    <table class="table">
				                        <thead class="thead cs-thead">
				                            <tr>
				                                <th class="text-center w-15">ID</th>
				                                <th class="text-center w-55">Brief</th>
				                                <th class="text-center w-20">Description</th>
				                            </tr>
				                        </thead>
				                      <tbody class="customtable" >
				                        <%if(RequirementList !=null){
				                          for(Object []obj :RequirementList){%>
				                          <tr>
				                 						<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
				                 		          		<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
				                 		          		<td class="text-center">
				                 		          		<input type="hidden" id="Req<%=obj[0]%>" value ="<%=obj[4] %>" />
					<button type="button" class=""    id="reqbtn2" onclick="showdata('<%=obj[0]%>','<%=obj[1]%>')"   >
					<div class="cc-rockmenu">
					 <div class="rolling">
					<figure class="rolling_icon w-18px"><img src="view/images/preview3.png"></figure>
					</div> 
					</button>
				    </td>
				                           </tr>
				                           <%} }%>
				                        </tbody> 
				                    </table>
				                </div>
				                
				                
				                
				         
					<div class="modal fade  bd-example-modal-lg" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
 						 <div class="modal-dialog modal-lg" role="document">
    						<div class="modal-content" id="reqmodal">
      						<div class="modal-header cs-header-color">
     			  			 <h5 class="modal-title cs-title" id="exampleModalLongTitle">
     					  	<b>Requirement Description</b> </h5><span class="cs-span">(<b id="reqid"></b>)</span>
       					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        				  <span aria-hidden="true">&times;</span>
       						 </button>
    					  </div>
     						 <div class="modal-body cs-body">
     						        <div id="reqmodalbody" class="cs-reqdiv"> </div>
    								  </div>
  								  </div>
  									</div>
										</div>
					
	 		
                        
      		</div>  
                    
 <!--  **** COST *********************     -->                   
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                       <!--  <h4 class="font-italic mb-4">Cost</h4> -->
                        
                        <div class="row">
				        <div class="col-12">
				            <div class="card">
				               
				                <div class="table-responsive">
				                    <table class="table">
				                        <thead class="thead cs-thead">
				                            <tr>
				                                <th scope="col" >Budget Head</th>
				                                <th scope="col">Head of Accounts</th>
				                                <th scope="col">Item Detail</th>
				                                <th scope="col">Item Cost (In Lakhs)</th>
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:CostList){ %>
				                            <tr>				                                     
				                                <td><%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString()) %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString())%> (<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>)<%}else{ %>-<%} %></td>
				                                <td><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
				                                <td class="right">&#8377; <%if(obj[3]!=null && Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[3].toString()))>0){%><%=Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[3].toString()))/100000 %> Lakhs<%}else{ %>0.00<%} %></td>
				                    
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                </div>
				            </div>
				        </div>
				    </div>

                    </div>
                    
                    
     <!--  **** SCHEDULE *********************     -->           
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                       <!--  <h4 class="font-italic mb-4">Schedule</h4> -->
                        
                     
				               
				              
				                    <table class="table" id="scheduleTable">
				                        <thead class="thead cs-thead">
				                            <tr>
				                                <th scope="col" class="center w-12">Milestone No</th>
				                                <th scope="col " class="w-74">Milestone Activity</th>
				                                <th scope="col" class="center">Milestone Month</th>
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:ScheduleList){ %>
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox"> <input type="checkbox" class="listCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                                     
				                                <td class="center"><%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString()) %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString()) %><%}else{ %>-<%} %></td>
				                                <td class="center"><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
				                    
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                    


						</div>
                    
         
         <!-- ********* ATTACHMENT *****************  -->           
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-attachment" role="tabpanel" aria-labelledby="v-pills-attachment-tab">
                        <div class="row">
				        <div class="col-12">
				            <div class="card">
				                <div class="table-responsive">
				                    <table class="table">
				                        <thead class="thead cs-thead">
				                            <tr>
				                            <th scope="col" >File Name</th>
				                            <th scope="col" >Created By</th>
				                            <th scope="col" >Created Date</th>
				                            <th class="center" scope="col">Download</th>
				                            
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:IntiationAttachment){ %>
				                            <tr>
				                                     
				                                <td class="left"><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[4]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[4].toString()) %><%}else{ %>-<%} %></td>
				                                <td class="left"><%if(obj[5]!=null){%><%=sdf1.format(obj[5]) %><%}else{ %>-<%} %></td>
				                    			 <td class="center"><div ><a  href="ProjectAttachDownload.htm?InitiationAttachmentId=<%=obj[6]%>" target="_blank"><i class="fa fa-download"></i></a></div> </td>	
				                    			
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                </div>
				               
				            </div>
		
				        </div>
				    </div>
                        
                        
                    </div>
                    
                   
                     <!-- ********* PRINTS *****************  -->  
                    
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-prints" role="tabpanel" aria-labelledby="v-pills-print-tab">

                        <div class="row">
				        <div class="col-12">
				         
				                <form action="" method="POST" name="myfrm" id="myfrm">
			
				                	<button type="submit" class="btn btn-warning btn-sm prints" formmethod="GET" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
							 
							 		<button type="submit" class="btn btn-warning btn-sm prints" formmethod="GET" formaction="ProjectProposalDownload.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;
				                
				                	<button type="submit" class="btn border-0 w-53px" formaction="ProjectProposal.htm" formtarget="_blank" formmethod="POST" data-toggle="tooltip" data-placement="top" title="Project Presentation"><img alt="" src="view/images/presentation.png"></button>&nbsp;&nbsp;
				                		
									 <button type="submit" class="btn cs-trans" formmethod="GET" formtarget="_blank" formaction="ProposalPresentationDownload.htm" data-toggle="tooltip" data-placement="right" title="Project Presentation Download"><i class="fa fa-download fa-lg" aria-hidden="true"></i></button>
					  
				                	<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
				                	
				                	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				                	
				                </form>
		
				        </div>
				    </div>
                        
                        
                    </div>
                    
                    
                    
                    
                    
                    
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
function showdata(reqid,reqid1){
	console.log($('#Req'+reqid).val());
    $('#exampleModalLong').modal('show');
    document.getElementById('reqmodalbody').innerHTML =$('#Req'+reqid).val();
    document.getElementById('reqid').innerHTML =reqid1;
}
$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


</script>

</body>
</html>