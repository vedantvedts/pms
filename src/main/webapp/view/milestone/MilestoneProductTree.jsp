<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@page import="java.util.stream.Collectors"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Product Tree</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 14px;
}
.table thead tr,tbody tr{
    font-size: 14px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}

.genealogy-body{
    white-space: nowrap;
    overflow-y: hidden;
    padding: 50px;
     min-height: 800px; 
    padding-top: 10px;
    text-align: center;
}
.genealogy-tree{
  display: inline-block;
} 
.genealogy-tree ul {
    padding-top: 20px; 
    position: relative;
    padding-left: 0px;
    display: flex;
    justify-content: center;
}
.genealogy-tree li {
    float: left; text-align: center;
    list-style-type: none;
    position: relative;
    padding: 20px 26px 0 12px;
}
.genealogy-tree li::before, .genealogy-tree li::after{
    content: '';
    position: absolute; 
    top: 0; 
    right: 50%;
    border-top: 2px solid #ccc;
    width: 50%; 
    height: 18px;
}
.genealogy-tree li::after{
    right: auto; left: 50%;
    border-left: 2px solid #ccc;
}
.genealogy-tree li:only-child::after, .genealogy-tree li:only-child::before {
    display: none;
}
.genealogy-tree li:only-child{ 
    padding-top: 0;
}
.genealogy-tree li:first-child::before, .genealogy-tree li:last-child::after{
    border: 0 none;
}
.genealogy-tree li:last-child::before{
     border-right: 2px solid #ccc;
     border-radius: 0 5px 0 0;
    -webkit-border-radius: 0 5px 0 0;
    -moz-border-radius: 0 5px 0 0;
}
.genealogy-tree li:first-child::after{
    border-radius: 5px 0 0 0;
    -webkit-border-radius: 5px 0 0 0;
    -moz-border-radius: 5px 0 0 0;
}
.genealogy-tree ul ul::before{
    content: '';
    position: absolute; top: 0; left: 50%;
    border-left: 2px solid #ccc;
    width: 0; height: 20px;
}
.genealogy-tree li .action-view-box{
     text-decoration: none;
     /* font-family: arial, verdana, tahoma; */
     font-size: 11px;
     display: inline-block;
     border-radius: 5px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
}

.genealogy-tree li a:hover+ul li::after, 
.genealogy-tree li a:hover+ul li::before, 
.genealogy-tree li a:hover+ul::before, 
.genealogy-tree li a:hover+ul ul::before{
    border-color:  #fbba00;
}

/*--------------memeber-card-design----------*/
.member-view-box{
    padding:0px 15px;
    text-align: center;
    border-radius: 4px;
    position: relative;
}
.member-image{
    width: 60px;
    position: relative;
}
.member-image img{
    width: 60px;
    height: 60px;
    border-radius: 6px;
    background-color :#000;
    z-index: 1;
}


</style>
 <!-- ------------------------------- tree css ------------------------------- -->


<style type="text/css">
.action-box
{
     width: fit-content ; 
     height: fit-content;
     /* min-width:190px; */
   /*   min-width:190px; */
    border: 1px solid black;
}

.action-box-header
{
	
 	padding:3px;
 	text-align: center;
 	/* color: #3468C0; */
	background: linear-gradient(to bottom right, #0B60B0 5%, #0B60B0 10%, white 10%, white 90%, #D24545 0%, #D24545 0%);
	
}



.action-box-body
{
	padding:0px;
	text-align: center;
	background-color:#FFFFFF ;
	display: block;
    flex-wrap: wrap;
    border-bottom-right-radius : 9px;
	border-bottom-left-radius: 7px;
}





.card-body-table
{
	width:100%;
}

.card-body-table  td
{
	border:0px;
	text-align: left;
}	
	
.card-body-table th
{
	border:0px;
}

.Q1
{
	background-color: #428bca;
	color: #FFFFFF;
}

.Q2
{
	background-color: #EA5455;
	color: #FFFFFF;
}

.Q3
{
	background-color: #116D6E;
	color: #000000;
}

.Q4
{
	background-color: #643A6B;
	color: #FFFFFF;
}

th
{
 	text-align: left;
 	overflow-wrap: break-word;
}

td
{
 	text-align: justify;
  	text-justify: inter-word;
    
}

.tabledata
{
 	white-space: -o-pre-wrap; 
    word-wrap: break-word;
    white-space: pre-wrap; 
    white-space: -moz-pre-wrap; 
    white-space: -pre-wrap; 
}

.h3{
font-size:2rem;
}


</style>
</head>
 

  <%
  
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");

  
  
 %>

<body>

 <form class="form-inline"  method="POST" action="ProductTree.htm">
  <div class="row W-100" style="width: 100%;">

  
	
                                    <div class="col-md-2">
                            		<label class="control-label">Project Name :</label>
                            		</div>
                            		<div class="col-md-2" style="margin-top: -7px;">
                              		<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {
    										String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>> <%=obj[4]+projectshortName%>  </option>
											<%} %>
  									</select>
  									</div>
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 </div>
</form>


	
	<%---------------------------------------- Main Level -------------------------------------------------%>

<!-- <form  method="GET" action="LevelNameAdd.htm" id="myForm"> -->
	<div style="background-color:#FFFFFF;overflow-y:auto ;" class="body genealogy-body genealogy-scroll">
	
	
	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){	%>
	<div align="center">
		<div class="alert alert-danger" role="alert" >
	    <%=ses1 %>
	     <br />
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert"  >
	    	<%=ses %>
	    	 <br />
	    </div>
	</div>
<%} %>
	
	
	    <div class="genealogy-tree">
	        
	  		<ul>
				<li>      
	
						 <div class="member-view-box action-view-box">
			                    
			                         <div class=" action-box" style="border:-1px;" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;">
	                          			        <%if(ProjectId!=null){	
				                                       Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");%>  
			                                              <%=ProjectDetail[1] %>
	                          			               <%} %>
			                          		 </span>
			                         			 
										</div>
										
			                    <!--    <div class="action-box-body" style="cursor: pointer;background-color:#FFFF;color: #FFFFFF;font-size: 1.0em;"> -->
			                          	
			                          	<%-- <span style="font-weight: 600;color:black;"> 
							                <%=Director[0] %>,&nbsp;<%=Director[1] %>	
							                		
									    </span > 
			                          	<% if(dgmlist!=null && dgmlist.size()>0) {%>
			                          	 <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:#428bca;;padding-top:0px;padding-bottom:2px;cursor: pointer ;"></i></div>
			                          	 <%}%>	 --%>
			                          	 
			                   <!-- </div> -->
			                         
			                </div>
			          </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">	                
			                <% for(Object[] level1 : ProductTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li>	 		    
									    <div class="member-view-box action-view-box">
											 <div class="action-box" > 
												
												<div  class="action-box-header" > 
												
										             <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
										           <%=level1[3] %>
										                
										             </span> 	
										                
			                          		   </div>
													
													
													
												 </div> 
											</div> 
											<% List<Object[]> Level1 =ProductTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="active" <%}%> >	
						                <%for(Object[] level2 : ProductTreeList){
						                  if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString()))
							                { %>
							             
												<li>	
													<div class="member-view-box action-view-box">
															<div class=" action-box" >
															  <div class="action-box-header" >
														
															       <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
			                          			                              <%=level2[3] %>
			                          			                   </span>
												             
			                          			             </div>
													     </div>
												   </div> 
												   
												   
												   <% List<Object[]> Level2 =ProductTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										                  <ul <% if(Level2!=null && Level2.size()>0){%> class="active" <%}%> >	                
										                	  <%for(Object[] level3 : ProductTreeList){
										                 if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) )
										                
										                  { %>
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header">
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level3[3] %>
			                          			                                
			                          			                          </span>
												                                              			
													                        </div>
													                       
																			
																			                     
																			</div>
																	</div> 
															
															
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	                
										                	 <%for(Object[] level4 : ProductTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                 { %>    
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header">
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level4[3] %>
			                          			                                
			                          			                          </span>
												                                              			
													                        </div>
													                                            
																			</div>
																	</div> 
																	
																	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="active" <%}%> >	                
										                	<%for(Object[] level5 : ProductTreeList){%>
								                        	  <% if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) )
								                          {%> 
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header">
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level5[3] %>
			                          			                                
			                          			                          </span>
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																	
																	
																	<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	
																	
																	<%-- <ul class="">	                
										                	 <% int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){ %>
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header">
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=objE[4] %>
			                          			                                
			                          			                          </span>
												                                              			
													                        </div>
													                       
																				<div class="action-box-body"  align="center" style="cursor: pointer ;">
																				
																					<span style="font-weight: 600;color:black;" ><%=group[4] %>,<br><%=group[5] %></span>
																					
																				 </div>
																			                     
																			</div>
																	</div>
																	
																	
																	</li>
															
														    <% countE++;} %>
														<% } %>
										                </ul>  --%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	   
																   </li>
															
														    <% } %>
														<% } %>
														
														
														 <%---------------------------------------Level 5 Add---------------------------------------------------------%>
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#5#<%=level4[0]%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 <%---------------------------------------Level 5 Add---------------------------------------------------------%>		
														
													</ul>      
																	
														<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%> 
																    
														 </li>
															
												    <% } %>
												<% } %>
														
														
														 <%---------------------------------------Level 4 Add---------------------------------------------------------%>
														
														  <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#4#<%=level3[0]%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													             
													                 <%-- <input type="hidden" name="LevelId" value="2">
													                 <input type="hidden" name="ProjectId" value="<%=ProjectId%>">
													                 <input type="hidden" name="ParentLevelId" value="<%=level1[0]%>"> --%>
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 <%---------------------------------------Level 4 Add---------------------------------------------------------%>		
										                </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->  		    														    
																    
															 
							                		    </li>
												
													    <% } %>
													<% } %>
											
											
											 <%---------------------------------------Level 3 Add---------------------------------------------------------%>
                	        
				                	            <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#3#<%=level2[0]%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													             
													                 <%-- <input type="hidden" name="LevelId" value="2">
													                 <input type="hidden" name="ProjectId" value="<%=ProjectId%>">
													                 <input type="hidden" name="ParentLevelId" value="<%=level1[0]%>"> --%>
													                
													        </span> 	
													    </div> 
				                
				                               </li>
                	        
                	          <%---------------------------------------Level 3 Add---------------------------------------------------------%>
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  
												
								 	 </li>
								 <% } %>
                	        <% } %>
                	        
                	        <%---------------------------------------Level 2 Add---------------------------------------------------------%>
                	        
                	            <li>
                                       <div class="member-view-box action-view-box">
											<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
											
											<form action="LevelNameAdd.htm" method="get">
									            <input type="text" name="LevelName" required >
									            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#2#<%=level1[0]%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									             
									         </form>    
									             
									             
									                 <%-- <input type="hidden" name="LevelId" value="2">
									                 <input type="hidden" name="ProjectId" value="<%=ProjectId%>">
									                 <input type="hidden" name="ParentLevelId" value="<%=level1[0]%>"> --%>
									                
									        </span> 	
									    </div> 
                
                               </li>
                	        
                	          <%---------------------------------------Level 2 Add---------------------------------------------------------%>
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
						 		    
                		 </li>
                	   <% } %>
                	<% } %>
					
					
					<%---------------------------------------Level 1 Add---------------------------------------------------------%>
                    <li>
                
                         <div class="member-view-box action-view-box">
							<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
					            <form action="LevelNameAdd.htm" method="get">
						            <input type="text" name="LevelName" required>
						            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#1#0" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									             
							   </form>    
					             
					               
					                
					        </span> 	
					    </div> 
                
                    </li>
                	<%---------------------------------------Level 1 Add------------------------------------------------------------%>
				 </ul> 
                
                         
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->        
			           		
						
	        		</li>
	        		
		        </ul>
	
	    </div>
	</div>
<!-- 	</form> -->


<!-- ------------------------------- tree script ------------------------------- -->
  <script type="text/javascript">

  
  
  function setValueAndSubmit() {
      // Get the value of the input field
      var levelName = document.getElementById("levelNameInput").value;
      
      // Set the value of the button
      var button = document.querySelector('button[name="Split"]');
      button.value = '<%=ProjectId%>#2#' + levelName;
      
      // Ask for confirmation
      if (confirm('Are You Sure To Submit')) {
          // Submit the form
          document.getElementById("myForm").submit();
      }
  }
  
  
  
  $(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
  
  
  
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


</body>
</html>






   
   
