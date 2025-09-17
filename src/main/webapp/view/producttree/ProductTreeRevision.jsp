<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate,java.util.stream.Collectors"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Product Tree Revision </title>

<spring:url value="/resources/css/producttree/ProductTreeRevision.css" var="productTreeRevision" />
<link href="${productTreeRevision}" rel="stylesheet" />


<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); 
int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> ProjectDetails=(List<Object[]>)request.getAttribute("ProjectDetails");
String projectid=(String)request.getAttribute("projectid");


List<Object[]> projectdatarevlist=(List<Object[]>)request.getAttribute("RevisionCount");
String projectdatarevid=(String)request.getAttribute("projectdatarevid");
String RevCount=(String)request.getAttribute("RevCount");

List<Object[]> ProductRevTreeList=(List<Object[]>)request.getAttribute("ProductRevTreeList");


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
					 <div class="row card-header">
			   			<div class="col-md-7">
							<h3>Product Tree Revision Data </h3>
						</div>
						<!-- <div class="col-md-2"></div> -->	
					<div class="col-md-4">	
					<form method="post" action="ProductTreeRevisionData.htm" id="" >				
						<div class="row" >
						
							 <h4>Revision:</h4>
                            		
                            		<div class="col-md-3 mt-minus-7">
                            		
                              		   <select class="form-control selectdee w-220" name="revCount" data-live-search="true" data-container="body" onchange="this.form.submit();">
										
										<%for(Object[] obj : projectdatarevlist){ %>
											    <option  value="<%=obj[0] %>"  <% if(RevCount.toString().equals(obj[0].toString())) {%> selected <%} %> >REV - <%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"-" %> (<%=obj[1]!=null?sdf.format(sdf1.parse(obj[1].toString()) ):"-" %>)</option>
										<%} %>
										</select>
										<input type="hidden" name="ProjectId" value="<%=projectid %>" >												
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                              		
  									</div>
  									<div class="col-md-2 ml-130">
  									       <input type="submit" class="btn btn-primary btn-sm back "  value="Back"  onclick="SubmitBack()"  formaction="ProductTree.htm"> 
  									</div>
  							    			
						</div>
						</form>
					</div>
						
						 
					 </div> 
					 
				
					<div class="">	
						<div class="body genealogy-body genealogy-scroll bg-white">
						
						<div class="genealogy-tree"  >
	  
	 
			  		<ul>
						<li>      
			
						 <div class="member-view-box action-view-box p-15">
			                    
			                         <div class=" action-box" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span class="cursor span-font" >
	                          			         <%if(projectid!=null){	%>
	                          			        	<%=ProjectDetails.get(0)[1]!=null?StringEscapeUtils.escapeHtml4(ProjectDetails.get(0)[1].toString()):"-" %>
	                          			               <%} %> 
			                          		 </span>
			                         			 
										</div>
										
			                           
			                </div>
			          </div>
			          
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	                
			                <% for(Object[] level1 : ProductRevTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li >	 
			                	<%
									String statusClass1 = "status-default";
									if(level1[6] != null) {
									    String status = level1[6].toString();
									    if(status.equalsIgnoreCase("Design")) statusClass1 = "status-design";
									    else if(status.equalsIgnoreCase("Realisation")) statusClass1 = "status-realisation";
									    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass1 = "status-testing";
									    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass1 = "status-ready";
									}
									
									String typeClass1 = "type-default";
									if(level1[7] != null) {
									    String type = level1[7].toString();
									    if(type.equalsIgnoreCase("In-House Development")) typeClass1 = "type-inhouse";
									    else if(type.equalsIgnoreCase("BTP")) typeClass1 = "type-btp";
									    else if(type.equalsIgnoreCase("BTS")) typeClass1 = "type-bts";
									    else if(type.equalsIgnoreCase("COTS")) typeClass1 = "type-cots";
									}
									%>
			                	
									    <div class="member-view-box action-view-box">
											 <div class="action-box" > 
												
												 <div  class="action-box-header gradient-box level1 <%=statusClass1%> <%=typeClass1%>" >
												
										             <span class="cursor span-font-1"> 
										                  <%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()):"-" %>
										                
										             </span>  
										            
													          
											 <div class="mt-minus-2"><i class="fa fa-caret-down i-font cursor" aria-hidden="true" ></i></div>
													      
			                          		    </div> 
			                          	 </div> 
									</div>
									
											<% List<Object[]> Level1 =ProductRevTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="active" <%}%> >	
						                <%for(Object[] level2 : ProductRevTreeList){
						                  if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString()))
							                { %>
							             
												<li>
												<%
													String statusClass2 = "status-default";
													if(level2[6] != null) {
													    String status = level2[6].toString();
													    if(status.equalsIgnoreCase("Design")) statusClass2 = "status-design";
													    else if(status.equalsIgnoreCase("Realisation")) statusClass2 = "status-realisation";
													    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass2 = "status-testing";
													    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass2  = "status-ready";
													}
													
													String typeClass2 = "type-default";
													if(level2[7] != null) {
													    String type = level2[7].toString();
													    if(type.equalsIgnoreCase("In-House Development")) typeClass2 = "type-inhouse";
													    else if(type.equalsIgnoreCase("BTP")) typeClass2 = "type-btp";
													    else if(type.equalsIgnoreCase("BTS")) typeClass2 = "type-bts";
													    else if(type.equalsIgnoreCase("COTS")) typeClass2 = "type-cots";
													}
													%>
												
													<div class="member-view-box action-view-box">
															<div class=" action-box" >
															  <div  class="action-box-header gradient-box level1 <%=statusClass2%> <%=typeClass2%>" >
														
															       <span class="cursor span-font-1"> 
			                          			                              <%=level2[3]!=null?StringEscapeUtils.escapeHtml4(level2[3].toString()):"-" %>
			                          			                   </span>
			                          			                   
			                          			                  <div class="mt-minus-2"><i class="fa fa-caret-down i-font cursor" aria-hidden="true" ></i></div>
													
													             
												             
			                          			             </div>
													     </div>
												   </div> 
												   
												   
												   <% List<Object[]> Level2 =ProductRevTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										             <ul <% if(Level2!=null && Level2.size()>0){%> class="active" <%}%> >	                
										                	  <%for(Object[] level3 : ProductRevTreeList){
										                 if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) )
										                
										                  { %>
																  <li>  
																  <%
																	String statusClass3 = "status-default";
																	if(level3[6] != null) {
																	    String status = level3[6].toString();
																	    if(status.equalsIgnoreCase("Design")) statusClass3 = "status-design";
																	    else if(status.equalsIgnoreCase("Realisation")) statusClass3 = "status-realisation";
																	    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass3 = "status-testing";
																	    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass3  = "status-ready";
																	}
																	
																	String typeClass3 = "type-default";
																	if(level3[7] != null) {
																	    String type = level3[7].toString();
																	    if(type.equalsIgnoreCase("In-House Development")) typeClass3 = "type-inhouse";
																	    else if(type.equalsIgnoreCase("BTP")) typeClass3 = "type-btp";
																	    else if(type.equalsIgnoreCase("BTS")) typeClass3 = "type-bts";
																	    else if(type.equalsIgnoreCase("COTS")) typeClass3 = "type-cots";
																	}
																	%>
																   <div class="line-top"></div>    
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div  class="action-box-header gradient-box level1 <%=statusClass3%> <%=typeClass3%>" >
																		
																		<span class="cursor span-font-1" >
			                          			                             
			                          			                                <%=level3[3]!=null?StringEscapeUtils.escapeHtml4(level3[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                      <div class="mt-minus-2"><i class="fa fa-caret-down i-font cursor" aria-hidden="true" ></i></div>
													
													                   
			                          			                          
												                                              			
													                 </div>
													              </div>
														   </div> 
															
															
															 <% List<Object[]> Level3 =ProductRevTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	                
										                	 <%for(Object[] level4 : ProductRevTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                     { %>    
																  <li> <%
																		String statusClass4 = "status-default";
																		if(level4[6] != null) {
																		    String status = level4[6].toString();
																		    if(status.equalsIgnoreCase("Design")) statusClass4 = "status-design";
																		    else if(status.equalsIgnoreCase("Realisation")) statusClass4 = "status-realisation";
																		    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass4 = "status-testing";
																		    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass4 = "status-ready";
																		}
																		
																		String typeClass4 = "type-default";
																		if(level4[7] != null) {
																		    String type = level4[7].toString();
																		    if(type.equalsIgnoreCase("In-House Development")) typeClass4 = "type-inhouse";
																		    else if(type.equalsIgnoreCase("BTP")) typeClass4 = "type-btp";
																		    else if(type.equalsIgnoreCase("BTS")) typeClass4 = "type-bts";
																		    else if(type.equalsIgnoreCase("COTS")) typeClass4 = "type-cots";
																		}
																		%>
																  
																   <div class="line-top"></div>     
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div  class="action-box-header gradient-box level1 <%=statusClass4%> <%=typeClass4%>" >
																		
																		
																		<span class="cursor span-font-1" >
			                          			                             
			                          			                                <%=level4[3]!=null?StringEscapeUtils.escapeHtml4(level4[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div class="mt-minus-2"><i class="fa fa-caret-down i-font cursor" aria-hidden="true" ></i></div>
													
													                     
												                                              			
													                    </div>
													                                            
																</div>
														</div> 
																	
																	
																	<% List<Object[]> Level4 =ProductRevTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="active" <%}%> >	                
										                	<%for(Object[] level5 : ProductRevTreeList){%>
								                        	  <% if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) )
								                             { %> 
																  <li> 
																  <%
																	String statusClass5 = "status-default";
																	if(level5[6] != null) {
																	    String status = level5[6].toString();
																	    if(status.equalsIgnoreCase("Design")) statusClass5 = "status-design";
																	    else if(status.equalsIgnoreCase("Realisation")) statusClass5 = "status-realisation";
																	    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass5 = "status-testing";
																	    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass5 = "status-ready";
																	}
																	
																	String typeClass5 = "type-default";
																	if(level5[7] != null) {
																	    String type = level5[7].toString();
																	    if(type.equalsIgnoreCase("In-House Development")) typeClass5 = "type-inhouse";
																	    else if(type.equalsIgnoreCase("BTP")) typeClass5 = "type-btp";
																	    else if(type.equalsIgnoreCase("BTS")) typeClass5 = "type-bts";
																	    else if(type.equalsIgnoreCase("COTS")) typeClass5 = "type-cots";
																	}
																	%>
																																	  
																   <div class="line-top"></div>     
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div  class="action-box-header gradient-box level1 <%=statusClass5%> <%=typeClass5%>" >
																		
																		
																		<span class="cursor span-font-1" >
			                          			                             
			                          			                                <%=level5[3]!=null?StringEscapeUtils.escapeHtml4(level5[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                          <div class="mt-minus-2"><i class="fa fa-caret-down i-font cursor" aria-hidden="true" ></i></div>
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																	
																	
		
																	
																	<% List<Object[]> Level5 =ProductRevTreeList.stream().filter(e-> level5[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	
														 <ul <% if(Level5!=null && Level5.size()>0){%> class="active" <%}%> >	                
										                	<%for(Object[] level6 : ProductRevTreeList){%>
								                        	  <% if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString()) )
								                             {%> 
																  <li> 
																  <%
																	String statusClass6 = "status-default";
																	if(level6[6] != null) {
																	    String status = level6[6].toString();
																	    if(status.equalsIgnoreCase("Design")) statusClass6 = "status-design";
																	    else if(status.equalsIgnoreCase("Realisation")) statusClass6 = "status-realisation";
																	    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass6 = "status-testing";
																	    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass6 = "status-ready";
																	}
																	
																	String typeClass6 = "type-default";
																	if(level6[7] != null) {
																	    String type = level6[7].toString();
																	    if(type.equalsIgnoreCase("In-House Development")) typeClass6 = "type-inhouse";
																	    else if(type.equalsIgnoreCase("BTP")) typeClass6 = "type-btp";
																	    else if(type.equalsIgnoreCase("BTS")) typeClass6 = "type-bts";
																	    else if(type.equalsIgnoreCase("COTS")) typeClass6 = "type-cots";
																	}
																	%>
																																	  
																																	  
																   <div class="line-top"></div>     
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div  class="action-box-header gradient-box level1 <%=statusClass6%> <%=typeClass6%>" >
																		
																		
																		<span class="cursor span-font-1" >
			                          			                             
			                          			                                <%=level6[3]!=null?StringEscapeUtils.escapeHtml4(level6[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                          <div class="mt-minus-2"><i class="fa fa-caret-down i-font cursor" aria-hidden="true" ></i></div>
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																
																
													
													
													
													<% List<Object[]> Level6 =ProductRevTreeList.stream().filter(e-> level6[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>
																	
														 <ul <% if(Level6!=null && Level6.size()>0){%> class="active" <%}%> >	                
										                	<%for(Object[] level7 : ProductRevTreeList){ %>
								                        	  <% if(level7[2].toString().equalsIgnoreCase("7") && level6[0].toString().equalsIgnoreCase(level7[1].toString()) )
								                             { %> 
																  <li> 
																  <%
																	String statusClass7 = "status-default";
																	if(level7[6] != null) {
																	    String status = level7[6].toString();
																	    if(status.equalsIgnoreCase("Design")) statusClass7 = "status-design";
																	    else if(status.equalsIgnoreCase("Realisation")) statusClass7 = "status-realisation";
																	    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass7 = "status-testing";
																	    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass7 = "status-ready";
																	}
																	
																	String typeClass7 = "type-default";
																	if(level7[7] != null) {
																	    String type = level7[7].toString();
																	    if(type.equalsIgnoreCase("In-House Development")) typeClass7 = "type-inhouse";
																	    else if(type.equalsIgnoreCase("BTP")) typeClass7 = "type-btp";
																	    else if(type.equalsIgnoreCase("BTS")) typeClass7 = "type-bts";
																	    else if(type.equalsIgnoreCase("COTS")) typeClass7 = "type-cots";
																	}
																	%>
																  
																   <div class="line-top"></div>     
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div  class="action-box-header gradient-box level1 <%=statusClass7%> <%=typeClass7%>" >
																		
																		
																		<span class="cursor span-font-1" >
			                          			                             
			                          			                                <%=level7[3]!=null?StringEscapeUtils.escapeHtml4(level7[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                                             			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>		
																
																 </li>
															
														    <% } %>
														<% } %>
														
														
													</ul>    
													
													
													      
													<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>		
																
																	   
																   </li>
															
														    <% } %>
														<% } %>
														
														
													</ul>      
																	
														<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%> 
																    
														 </li>
															
												    <% } %>
												<% } %>
														
													 </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->  		    														    
																    
															 
							                		    </li>
												
													    <% } %>
													<% } %>
											
											
											 
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  
												
								 	 </li>
								 <% } %>
                	        <% } %>
                	        
                	       
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
						 		    
                		 </li>
                	   <% } %>
                	<% } %>
					
			
                	
				 </ul> 
                
                         
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->        
			           		
						
	        		</li>
	        		  <% } %>
                	<% } %>
		        </ul>
		        
		        
		        </li>
		        </ul>
		        
			  
	
	    </div>
						
		</div>				
						
						
					</div>
					
				
				
				
					
					
				</div>
			</div>
		</div>
	</div>


<script type="text/javascript">

	
$(function () {
    $('.genealogy-tree ul').hide();
    $('.genealogy-tree>ul').show();
    $('.genealogy-tree ul.active').show();
    
    $('.genealogy-tree li .action-box-header').on('click', function (e) {
	
        
     var children = $(this).parent().parent().parent().find('> ul');
        if (children.is(":visible")) {
        	children.hide('fast').removeClass('active');
        	$(this).find('i').removeClass('fa fa-caret-down');
        	$(this).find('i').addClass('fa fa-caret-up');
        } else {
        	children.show('fast').addClass('active');
        	$(this).find('i').removeClass('fa fa-caret-up');
        	$(this).find('i').addClass('fa fa-caret-down');
    	}
        e.stopPropagation(); 
    });
});
	
	
	
</script>

</body>
</html>