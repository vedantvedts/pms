<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="org.apache.logging.log4j.core.pattern.EqualsIgnoreCaseReplacementConverter"%>
<%@page import="java.math.BigDecimal"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List , java.util.stream.Collectors, java.text.DecimalFormat,java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Tree </title>

 

<!-- ------------------------------- tree css ------------------------------- -->
<style type="text/css">



@page {
	size: 1300px 790px;
	
	/* border: 1px solid black;  */
	
   }



</style>

</head>

  <%
  
  
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");

  String ProjectId=(String)request.getAttribute("ProjectId");
  List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails");
 

 %>

<body style="background-color:#FFFFFF;white-space: nowrap;padding: 0px;min-height: 0px;padding-top: 0px;text-align: center;" 
class="body genealogy-body">
  

	<br>

	    <div class="genealogy-tree" style="display: inline-block;">
	  
	        
	  	<ul style="padding-top: 20px;position: relative;padding-left: 0px;display: flex;justify-content: center;">
	  	
	  	    <li style="float: left;text-align: center;list-style-type: none; position: relative;padding: 17px 0px 0 0px;">      
	
						    <div class="member-view-box action-view-box" 
						    
						    style="text-decoration: none;
									 /* font-family: arial, verdana, tahoma; */
									 font-size: 11px;
									 display: inline-block;
									 border-radius: 5px;
									-webkit-border-radius: 5px;
									-moz-border-radius: 5px;"> 
											
			                    
			                         <div class="action-box" style=" border: 1px solid black;max-width:100px;" > 
			                         	
			                         	<div class="action-box-header" style="padding:2px;" >
			                         	
			                         	 <span style="cursor:pointer;font-weight: 600;font-size: 1.0em;white-space:normal;"> 
	                          			       
			                                              <%=ProjectDetail.get(0)[1]!=null?StringEscapeUtils.escapeHtml4(ProjectDetail.get(0)[1].toString()): " - " %>
			                                              
	                          			  </span>            
	                          			   
			                          		 
			                         			 
										</div>
									</div>
			             
			           </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul style="content: '';" >
			           	                
			                <% for(Object[] level1 : ProductTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			               <li style="content: '';"> 
			                    
									    <div class="member-view-box action-view-box" >
											 <div class="action-box" style=" border: 1px solid black;max-width:100px;"> 
												
												<div  class="action-box-header"
												
												style="padding:2px;background: linear-gradient(to bottom right, 
												<%if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
												<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
												<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
												<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
												
												<%}else { %> white 5%, white 10% 
												<%} %>
												, white 10%, white 90%,
												
											    <%if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
												<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
												<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
												<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
												
												<%}else { %> white 5%, white 10% 
												<%} %>
												 
												 );" > 
												
										             <span style="cursor:pointer;font-weight: 600;font-size: 1.0em;white-space:normal;"> 
										           <%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()): " - " %>
										                
										             </span> 
										             
										            <div style="margin-top:-5px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
												
										             
										                
			                          		   </div>
			                          	 </div> 
									</div> 
											<% List<Object[]> Level1 =ProductTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="" <%}%> >	
						                <%for(Object[] level2 : ProductTreeList){
						                  if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString()))
							                { %>
							             
									<li>
													
													<div class="member-view-box action-view-box" >
													
													
															<div class=" action-box" >
															  <div class="action-box-header" 
															  
															      style="background: linear-gradient(to bottom right, 
																<%if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																
																<%}else { %> white 5%, white 10% 
																<%} %>
																, white 10%, white 90%,
																
															    <%if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																
																<%}else { %> white 5%, white 10% 
																<%} %>
																 
																 );" >
														
															       <span style="cursor:pointer;font-weight: 600;font-size: 1.0em;white-space:normal;"> 
			                          			                              <%=level2[3]!=null?StringEscapeUtils.escapeHtml4(level2[3].toString()): " - " %>
			                          			                   </span>
			                          			                   
			                          			                   <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													           
												             
			                          			             </div>
													     </div>
												   </div> 
												   
												   
												   <% List<Object[]> Level2 =ProductTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										             <ul <% if(Level2!=null && Level2.size()>0){%> class="" <%}%> >	                
										                	  <%for(Object[] level3 : ProductTreeList){
										                 if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) )
										                
										                  { %>
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		  style="background: linear-gradient(to bottom right, 
																			<%if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level3[3]!=null?StringEscapeUtils.escapeHtml4(level3[3].toString()): " - " %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
			                          			                          
												                                              			
													                 </div>
													              </div>
														   </div> 
															
															
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="" <%}%> >	                
										                	 <%for(Object[] level4 : ProductTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                     { %>    
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 
																		  style="background: linear-gradient(to bottom right, 
																			<%if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level4[3]!=null?StringEscapeUtils.escapeHtml4(level4[3].toString()): " - " %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
												                                              			
													                    </div>
													                                            
																</div>
														</div> 
																	
																	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="" <%}%> >	                
										                	<%for(Object[] level5 : ProductTreeList){%>
								                        	  <% if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) )
								                             {%> 
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background: linear-gradient(to bottom right, 
																			<%if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level5[3]!=null?StringEscapeUtils.escapeHtml4(level5[3].toString()): " - " %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                      
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																	
																	
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
	        		
		        </ul>
		        
		  
	
	    </div>



<!-- ------------------------------- tree script ------------------------------- -->






</body>
</html>