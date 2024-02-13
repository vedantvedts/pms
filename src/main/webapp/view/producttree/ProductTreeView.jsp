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
 

<!-- ------------------------------- tree css ------------------------------- -->
<style type="text/css">



/*----------------genealogy-tree----------*/
 .genealogy-body{
    white-space: nowrap;
    overflow-y: hidden;
    padding: 50px;
    min-height: 500px;
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
    /* background: linear-gradient(to bottom right, #0B60B0 5%, #0B60B0 10%, white 10%, white 90%, #D24545 0%, #D24545 0%); */
    
}


.action-box-header
{
	padding:3px;
 	text-align: center;
 	/* color: #3468C0; */
	 /* background: linear-gradient(to bottom right, #0B60B0 5%, #0B60B0 10%, white 10%, white 90%, #D24545 0%, #D24545 0%);  */
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


table,td{


      border: 1px solid black;
      border-collapse:collapse;
      padding: 5px;

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

<body style="background-color:#FFFFFF;overflow-y:auto ;" class="body genealogy-body genealogy-scroll">

	<div style="margin-left:-19rem;">
		<h3>PRODUCT TREE</h3>
	</div>	
	
<div align="right">
     <div style="float: right;padding:0px;margin-top:-46px;">
     
         <table style="margin: 0 auto;" >

                  <tr>
						<td style="font-weight:bold;">Stage (Upper corner)</td>
						<td style="background-color:#D24545;color:#FFFFFF">Design</td>
						<td style="background-color:#E9B824;color:black">Realisation</td>
						<td style="background-color:#0B60B0;color:#FFFFFF">Testing & Evaluation</td>
						<td style="background-color:green;color:#FFFFFF">Ready for Closure</td>
                  </tr>



                 <tr>
						<td style="font-weight:bold;">Module (Lower corner)</td>
						<td style="background-color:#FF8911;color:black">In-House Development</td>
						<td style="background-color:#FDE767;color:black">BTP</td>
						<td style="background-color:#B67352;color:black">BTS</td>
						<td style="background-color:#492E87;color:#FFFFFF">COTS</td>
                 </tr>

       </table>     
           
     
     </div>
   

</div>


<br>
<br>
<br>

		
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
										
			                           
			                </div>
			          </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	                
			                <% for(Object[] level1 : ProductTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li>	 		    
									    <div class="member-view-box action-view-box">
											 <div class="action-box" > 
												
												<div  class="action-box-header" 
												
												style="background: linear-gradient(to bottom right, 
												<%if(level1[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
												<%}else if(level1[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
												
												<%}else if(level1[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
												<%}else if(level1[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
												
												<%}else if(level1[6]==null){ %> white 5%, white 10% 
												<%} %>
												
												, white 10%, white 90%, #D24545 0%, #D24545 0%); "
												
												
												> 
												
										             <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
										           <%=level1[3] %>
										                
										             </span> 
										            
										             
										             
										             <!--   <div class="action-box-body" align="center" style="cursor: pointer ;" >  -->
													
													      
													          <div style="margin-top:-5px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													<!-- </div> -->  
										             
										                
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
			                          			                   
			                          			                   
			                          			                   <!--  <div class="action-box-body" align="center" style="cursor: pointer ;" >  -->
													
													      
													                           <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													              <!--   </div>  -->
												             
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
			                          			                          
			                          			                       <!--     <div class="action-box-body" align="center" style="cursor: pointer ;" >  -->
													
													      
													                             <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                       <!--  </div>  -->
			                          			                          
												                                              			
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
			                          			                          
			                          			                          
			                          			                         <!--   <div class="action-box-body" align="center" style="cursor: pointer ;" >  -->
													
													      
													                              <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                     <!--   </div>  -->
												                                              			
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
			                          			                          
			                          			                          
			                          			                          <!--  <div class="action-box-body" align="center" style="cursor: pointer ;" >  -->
													
													      
													                               <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                      <!--  </div>  -->
												                                              			
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



</body>
</html>