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
<title>Product Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/producttree/ProductTreeViewH.css" var="productTreeViewH" />
<link href="${productTreeViewH}" rel="stylesheet" />


<script src="./resources/js/html2canvas.min.js"></script>

   



</head>

  <%
  
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");

   

 %>

<body class="bg-white">

	

     <button  type="button" class="btn btn-sm ml-3"  id="generatePdfBtn"   onclick="downloadPDF()"> <i class="fa fa-download fa-lg" ></i></button> 

		
	    <div class="genealogy-tree"  >
	  
	 <ul>
	  	<li> 
			 <div class="member-view-box action-view-box p-15" >
			                    
			                         <div class="action-box" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span class="span-font cursor" >
	                          			        <%if(ProjectId!=null){	
				                                       Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");%>  
			                                              <%=ProjectDetail[1]!=null?StringEscapeUtils.escapeHtml4(ProjectDetail[1].toString()):"-" %>
	                          			               <%} %>
			                          		 </span>
			                         			 
										</div>
										
			                           
			                </div>
			          </div>
			         
			             
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	          
			           	           <div class="firstchildafter"></div>      
			                <%int i=1; for(Object[] level1 : ProductTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li >
			                	<% List<Object[]> L1 =ProductTreeList.stream().filter(e-> e[2].toString().equalsIgnoreCase("1") ).collect(Collectors.toList());%>	
			                	
			                	<%
									String topClass1 = "";
									if(level1[6] != null){
									    String val = level1[6].toString();
									    if(val.equalsIgnoreCase("Design")) topClass1 = "status-design";
									    else if(val.equalsIgnoreCase("Realisation")) topClass1 = "status-realisation";
									    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass1 = "status-testing";
									    else if(val.equalsIgnoreCase("Ready for Closure")) topClass1 = "status-ready";
									    else topClass1 = "status-default";
									}
									
									String bottomClass1 = "";
									if(level1[7] != null){
									    String val = level1[7].toString();
									    if(val.equalsIgnoreCase("In-House Development")) bottomClass1 = "type-inhouse";
									    else if(val.equalsIgnoreCase("BTP")) bottomClass1 = "type-btp";
									    else if(val.equalsIgnoreCase("BTS")) bottomClass1 = "type-bts";
									    else if(val.equalsIgnoreCase("COTS")) bottomClass1 = "type-cots";
									    else bottomClass1 = "type-default";
									}
									%>
			                	
			                	  <div  <%if(i==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>  
			                	
									    <div class="member-view-box action-view-box">
											 <div class="action-box" > 
												
												<div  class="action-box-header gradient-box <%=topClass1%> <%=bottomClass1%>" >
												
										             <span class="cursor span-font-2" > 
										                  <%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()):"-" %>
										                
										             </span>  
										            
													          
													      
			                          		    </div> 
			                          	 </div> 
									</div>
									
									
									
											<% List<Object[]> Level1 =ProductTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="active" <%}%> >	
						                  <div class="firstchildafter"></div>     
						                <% int j=1;for(Object[] level2 : ProductTreeList){
						                  if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString()))
							                { %>
							             
												<li>
												<%
													String topClass2 = "";
													if(level2[6] != null){
													    String val = level2[6].toString();
													    if(val.equalsIgnoreCase("Design")) topClass2 = "status-design";
													    else if(val.equalsIgnoreCase("Realisation")) topClass2 = "status-realisation";
													    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass2 = "status-testing";
													    else if(val.equalsIgnoreCase("Ready for Closure")) topClass2 = "status-ready";
													    else topClass2 = "status-default";
													}
													
													String bottomClass2 = "";
													if(level2[7] != null){
													    String val = level2[7].toString();
													    if(val.equalsIgnoreCase("In-House Development")) bottomClass2 = "type-inhouse";
													    else if(val.equalsIgnoreCase("BTP")) bottomClass2 = "type-btp";
													    else if(val.equalsIgnoreCase("BTS")) bottomClass2 = "type-bts";
													    else if(val.equalsIgnoreCase("COTS")) bottomClass2 = "type-cots";
													    else bottomClass2 = "type-default";
													}
													%>
												<div  <%if(j==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>  
												
													<div class="member-view-box action-view-box">
															<div class=" action-box" >
															  <div class="action-box-header gradient-box <%=topClass2%> <%=bottomClass2%>" >
														
															       <span class="cursor span-font-2" >  
			                          			                              <%=level2[3]!=null?StringEscapeUtils.escapeHtml4(level2[3].toString()):"-" %>
			                          			                   </span>
			                          			                   
													
													             
												             
			                          			             </div>
													     </div>
												   </div> 
												   
												  
												   <% List<Object[]> Level2 =ProductTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										             <ul <% if(Level2!=null && Level2.size()>0){%> class="active" <%}%> >
										              <div class="firstchildafter"></div>    	                
										                	  <% int k=1;for(Object[] level3 : ProductTreeList){
										                 if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) )
										                
										                  { %>
																  <li> 
																  
																<%
																		String topClass3 = "";
																		if(level3[6] != null){
																		    String val = level3[6].toString();
																		    if(val.equalsIgnoreCase("Design")) topClass3 = "status-design";
																		    else if(val.equalsIgnoreCase("Realisation")) topClass3 = "status-realisation";
																		    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass3 = "status-testing";
																		    else if(val.equalsIgnoreCase("Ready for Closure")) topClass3 = "status-ready";
																		    else topClass3 = "status-default";
																		}
																		
																		String bottomClass3 = "";
																		if(level3[7] != null){
																		    String val = level3[7].toString();
																		    if(val.equalsIgnoreCase("In-House Development")) bottomClass3 = "type-inhouse";
																		    else if(val.equalsIgnoreCase("BTP")) bottomClass3 = "type-btp";
																		    else if(val.equalsIgnoreCase("BTS")) bottomClass3 = "type-bts";
																		    else if(val.equalsIgnoreCase("COTS")) bottomClass3 = "type-cots";
																		    else bottomClass3 = "type-default";
																		}
																		%>
																 
																   <div  <%if(k==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>  
																   
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=topClass3%> <%=bottomClass3%>">
																		
                                                                      
																			 
																		
																		<span class="cursor span-font-2" > 
			                          			                             
			                          			                                <%=level3[3]!=null?StringEscapeUtils.escapeHtml4(level3[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
													
													                   
			                          			                          
												                                              			
													                 </div>
													              </div>
														   </div> 
															
															 
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	
										                <div class="firstchildafter"></div>                    
										                	 <% int l=1;for(Object[] level4 : ProductTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                     { %>    
																  <li> 
																  
																  <%
																		String topClass4 = "";
																		if(level4[6] != null){
																		    String val = level4[6].toString();
																		    if(val.equalsIgnoreCase("Design")) topClass4 = "status-design";
																		    else if(val.equalsIgnoreCase("Realisation")) topClass4 = "status-realisation";
																		    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass4 = "status-testing";
																		    else if(val.equalsIgnoreCase("Ready for Closure")) topClass4 = "status-ready";
																		    else topClass4 = "status-default";
																		}
																		
																		String bottomClass4 = "";
																		if(level4[7] != null){
																		    String val = level4[7].toString();
																		    if(val.equalsIgnoreCase("In-House Development")) bottomClass4 = "type-inhouse";
																		    else if(val.equalsIgnoreCase("BTP")) bottomClass4 = "type-btp";
																		    else if(val.equalsIgnoreCase("BTS")) bottomClass4 = "type-bts";
																		    else if(val.equalsIgnoreCase("COTS")) bottomClass4 = "type-cots";
																		    else bottomClass4 = "type-default";
																		}
																		%>
																  
																 
																   <div  <%if(l==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>   
																   
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=topClass4%> <%=bottomClass4%>" >
																		 
																		
																		<span class="cursor span-font-2" > 
			                          			                             
			                          			                                <%=level4[3]!=null?StringEscapeUtils.escapeHtml4(level4[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
													
													                     
												                                              			
													                    </div>
													                                            
																</div>
														</div> 
																	
															 	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="active" <%}%> >	
														  <div class="firstchildafter"></div>                    
										                	<% int m=1;for(Object[] level5 : ProductTreeList){%>
								                        	  <% if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) )
								                             {%> 
																  <li> 
																  <%
																		String topClass5 = "";
																		if(level5[6] != null){
																		    String val = level5[6].toString();
																		    if(val.equalsIgnoreCase("Design")) topClass5 = "status-design";
																		    else if(val.equalsIgnoreCase("Realisation")) topClass5 = "status-realisation";
																		    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass5 = "status-testing";
																		    else if(val.equalsIgnoreCase("Ready for Closure")) topClass5 = "status-ready";
																		    else topClass5 = "status-default";
																		}
																		
																		String bottomClass5 = "";
																		if(level5[7] != null){
																		    String val = level5[7].toString();
																		    if(val.equalsIgnoreCase("In-House Development")) bottomClass5 = "type-inhouse";
																		    else if(val.equalsIgnoreCase("BTP")) bottomClass5 = "type-btp";
																		    else if(val.equalsIgnoreCase("BTS")) bottomClass5 = "type-bts";
																		    else if(val.equalsIgnoreCase("COTS")) bottomClass5 = "type-cots";
																		    else bottomClass5 = "type-default";
																		}
																		%>
																    
																 
																   <div  <%if(m==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>  
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=topClass5%> <%=bottomClass5%>">
																		
																		
																		<span class="cursor span-font-2" > 
			                          			                             
			                          			                                <%=level5[3]!=null?StringEscapeUtils.escapeHtml4(level5[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																	
																		<% List<Object[]> Level5 =ProductTreeList.stream().filter(e-> level5[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																		
																		<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																		 <ul <% if(Level5!=null && Level5.size()>0){%> class="active" <%}%> >	
														  <div class="firstchildafter"></div>                    
										                	<% int n=1;for(Object[] level6 : ProductTreeList){%>
								                        	  <% if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString()) )
								                             {%> 
																  <li> 
																  
																    <%
																		String topClass6 = "";
																		if(level6[6] != null){
																		    String val = level6[6].toString();
																		    if(val.equalsIgnoreCase("Design")) topClass6 = "status-design";
																		    else if(val.equalsIgnoreCase("Realisation")) topClass6 = "status-realisation";
																		    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass6 = "status-testing";
																		    else if(val.equalsIgnoreCase("Ready for Closure")) topClass6 = "status-ready";
																		    else topClass6 = "status-default";
																		}
																		
																		String bottomClass6 = "";
																		if(level6[7] != null){
																		    String val = level6[7].toString();
																		    if(val.equalsIgnoreCase("In-House Development")) bottomClass6 = "type-inhouse";
																		    else if(val.equalsIgnoreCase("BTP")) bottomClass6 = "type-btp";
																		    else if(val.equalsIgnoreCase("BTS")) bottomClass6 = "type-bts";
																		    else if(val.equalsIgnoreCase("COTS")) bottomClass6 = "type-cots";
																		    else bottomClass6 = "type-default";
																		}
																		%>
																 
																   <div  <%if(n==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>  
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=topClass6%> <%=bottomClass6%>" >
																		
																		
																		<span class="cursor span-font-2" > 
			                          			                             
			                          			                                <%=level6[3]!=null?StringEscapeUtils.escapeHtml4(level6[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 	
																		
																		
																		<% List<Object[]> Level6 =ProductTreeList.stream().filter(e-> level6[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																		<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>
																		
																		 <ul <% if(Level6!=null && Level6.size()>0){%> class="active" <%}%> >	
														  <div class="firstchildafter"></div>                    
										                	<% int o=1;for(Object[] level7: ProductTreeList){%>
								                        	  <% if(level7[2].toString().equalsIgnoreCase("7") && level6[0].toString().equalsIgnoreCase(level7[1].toString()) )
								                             {%> 
																  <li> 
																  
																    <%
																		String topClass7 = "";
																		if(level7[6] != null){
																		    String val = level6[6].toString();
																		    if(val.equalsIgnoreCase("Design")) topClass7 = "status-design";
																		    else if(val.equalsIgnoreCase("Realisation")) topClass7 = "status-realisation";
																		    else if(val.equalsIgnoreCase("Testing & Evaluation")) topClass7 = "status-testing";
																		    else if(val.equalsIgnoreCase("Ready for Closure")) topClass7 = "status-ready";
																		    else topClass7 = "status-default";
																		}
																		
																		String bottomClass7 = "";
																		if(level7[7] != null){
																		    String val = level6[7].toString();
																		    if(val.equalsIgnoreCase("In-House Development")) bottomClass7 = "type-inhouse";
																		    else if(val.equalsIgnoreCase("BTP")) bottomClass7 = "type-btp";
																		    else if(val.equalsIgnoreCase("BTS")) bottomClass7 = "type-bts";
																		    else if(val.equalsIgnoreCase("COTS")) bottomClass7 = "type-cots";
																		    else bottomClass7 = "type-default";
																		}
																		%>
																 
																   <div  <%if(o==1) {%> class="before border-0" <%} else{ %> class="before" <%} %>></div>  
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=topClass7%> <%=bottomClass7%>">
																		
																		
																		<span class="cursor span-font-2" > 
			                          			                             
			                          			                                <%=level7[3]!=null?StringEscapeUtils.escapeHtml4(level7[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 	
																		
																		<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>
																	
																<div  <%if(o==Level6.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div>  	
																	   
																   </li>
															
														    <%o++; } %>
														<% } %>
														
														
													</ul>      
																		
																		
																		
																		<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	
																<div  <%if(n==Level5.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div>	
																	   
																   </li>
															
														    <%n++; } %>
														<% } %>
														
														
													</ul>      
																		
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
																<div  <%if(m==Level4.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div>	
																	   
																   </li>
															
														    <%m++; } %>
														<% } %>
														
														
													</ul>      
																	
														<%--------------------------------------------------------------------------------LEVEL 4 ---------------------------------------------%> 
															<div  <%if(l==Level3.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div>	    
														 </li>
															
												    <%l++; } %>
												<% } %>
														
													 </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  		    														    
														<div  <%if(k==Level2.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div> 			    
															 
							                		    </li>
												
													    <%k++; } %>
													<% } %>
											
											
											 
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->  
										<div  <%if(j==Level1.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div>	  	
								 	 </li>
								 <%j++; } %>
                	        <% } %>
                	        
                	       
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->    
						 	 <div  <%if(i==L1.size()) {%> class="after border-top-0" <%} else{ %> class="after" <%} %>></div>			
                		 </li>
                	   <%i++; } %>
                	<% } %>
					
			
                	
				 </ul> 
                
                         
			          
			         
						
	        		</li>
	        		
		        </ul>
		        
			  
	
	    </div>
	    
	    
	   <div class="bottom-div">  
	    <div align="right">
    
     
         <table >

                  <tr>
						<td class="font-weight-bold">Stage (Upper)</td>
						<td class="design">Design</td>
						<td class="realisation">Realisation</td>
						<td class="testing">Testing & Evaluation</td>
						<td class="closure">Ready for Closure</td>
                  </tr>



                 <tr>
						<td class="font-weight-bold">Module (Lower)</td>
						<td class="house">In-House Development</td>
						<td class="btp">BTP</td>
						<td class="bts">BTS</td>
						<td class="cots">COTS</td>
                 </tr>

       </table>     
           
     
    
   </div> 
  </div>
	    
	    
	    



<!-- ------------------------------- tree script ------------------------------- -->
  <script type="text/javascript">

  $(function () {
	    $('.genealogy-tree ul').hide();
	    $('.genealogy-tree>ul').show();
	    $('.genealogy-tree ul.active').show();
	    
	    $('.genealogy-tree li .action-box-header').on('click', function (e) {
			
	    	 /* var children = $(this).parent().parent().parent().find('> ul');
		        if (children.is(":visible")) children.hide('fast').removeClass('active');
		        else children.show('fast').addClass('active');
		        e.stopPropagation(); */
	        
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



 <script>
/*  function downloadPDF() {
	    var body = document.body;
	    var downloadButton = document.getElementById('generatePdfBtn'); // Assuming your download button has an ID

	    // Store the current display style of the download button
	    var originalDisplayStyle = downloadButton.style.display;

	    // Hide the download button during rendering
	    downloadButton.style.display = 'none';

	    var originalBackgroundColor = body.style.backgroundColor;
	    body.style.backgroundColor = 'white';
	    
	    body.style.background = 'url(data:image/svg+xml;base64,' + btoa('<svg xmlns="http://www.w3.org/2000/svg"><rect width="100%" height="100%" fill="url(#gradient)"/></svg>');
	    
	    html2canvas(body, {
	        scrollX: 0,
	        scrollY: 0,
	        backgroundColor: 'white', // Set background color to white explicitly
	        useCORS: true
	    })
	        .then(function(canvas) {
	            downloadButton.style.display = originalDisplayStyle;

	            // Convert canvas to base64 image data
	            var imageData = canvas.toDataURL('image/jpeg');

	            // Create a download link for the image
	            var link = document.createElement('a');
	            link.href = imageData;
	            link.download = 'ProductTree.jpg'; // Set the filename for the downloaded image
	            link.click();
	        });
	    
	    body.style.backgroundColor = originalBackgroundColor;
	} */


	function downloadPDF() {
			var body = document.body;
			
			var downloadButton = document.getElementById('generatePdfBtn'); // Assuming your download button has an ID
			
			// Store the current display style of the download button
			var originalDisplayStyle = downloadButton.style.display;
			
			// Hide the download button during rendering
			downloadButton.style.display = 'none';
			
			
		
			
			
			html2canvas(body, {
			    onrendered: function(canvas) {
			        
			    	
			    	  
			    	 downloadButton.style.display = originalDisplayStyle;
			
			        // Convert canvas to base64 image data
			        var imageData = canvas.toDataURL('image/jpeg');
			
			        // Create a download link for the image
			        var link = document.createElement('a');
			        link.href = imageData;
			        link.download = 'ProductTree.jpg'; // Set the filename for the downloaded image
			        link.click();
			    }
			});
 
	}





</script> 





</body>
</html>