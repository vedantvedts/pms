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



<script src="./resources/js/html2canvas.min.js"></script>

   

<!-- ------------------------------- tree css ------------------------------- -->
<style type="text/css">



/*----------------genealogy-tree----------*/
 .genealogy-body{
    white-space: nowrap;
    overflow-y: hidden;
    padding: 50px;
    min-height: 500px;
    padding-top: 0px;
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
    padding: 17px 0px 0 0px;
}


 
 

.genealogy-tree li .before, .genealogy-tree li .after{
  
    position: absolute; 
    top: 0; 
    right: 50%;
    border-top: 1px solid black;
    width: 50%; 
    height: 18px;
}

  .genealogy-tree li .after{
    right: auto; 
    left: 50%;
     border-left: 2px solid black; 
   
} 
  

   .genealogy-tree li:only-child{ 
    padding-top: 0;
}  
 
 
 
 
  .genealogy-tree ul ul .firstchildafter{
    
    position: absolute;
     top: 0; 
     left: 50%;
    border-left: 2px solid black;
    width: 0;
     height: 20px;
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


/*--------------memeber-card-design----------*/
.member-view-box{
    padding:0px 15px;
    text-align: center;
    border-radius: 4px;
    position: relative;
}




</style>
 <!-- ------------------------------- tree css ------------------------------- -->


<style type="text/css">
.action-box
{

    border: 1px solid black;
    max-width:100px;
    
    
}


.action-box-header
{

	padding:2px;
 	text-align: center;
 	 
 	
}
.corner {
  position: absolute;
  width: 20px; /* Adjust the width of the corner */
  height: 20px; /* Adjust the height of the corner */
  background-color: red; /* Adjust the color as needed */
}

.top-left {
  top: -2px; /* Adjust position from top */
  left: -2px; /* Adjust position from left */
}

.top-right {
  top: -2px; /* Adjust position from top */
  right: -2px; /* Adjust position from right */
}

.bottom-left {
  bottom: -2px; /* Adjust position from bottom */
  left: -2px; /* Adjust position from left */
}

.bottom-right {
  bottom: -2px; /* Adjust position from bottom */
  right: -2px; /* Adjust position from right */
}


.gradient-background{

 


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
      padding:2px;
       width:43%;
       font-size:12px;

}

.bottom-div {
    position: fixed;
    bottom: 50px;
    left: -20px;
    width: 100%; 
}



</style>

</head>

  <%
  
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  List<Object[]> preProjectList=(List<Object[]>)request.getAttribute("preProjectList");
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String initiationId=(String)request.getAttribute("initiationId");
  Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
  
  String ProjectName="";
  
  if(ProjectDetail!=null && ProjectId!=null){	
	   ProjectName=ProjectDetail[1].toString();
  }else{
	   ProjectName=preProjectList.stream().filter(e->e[0].toString().equalsIgnoreCase(initiationId)).collect(Collectors.toList()).get(0)[2].toString();
  }

 %>

<body style="background-color:#FFFFFF;overflow-y:auto ;" class="body genealogy-body genealogy-scroll">

	

     <button  type="button" class="btn btn-sm "  id="generatePdfBtn" style="margin-left: 1rem;"  onclick="downloadPDF()"> <i class="fa fa-download fa-lg" ></i></button> 

		
	    <div class="genealogy-tree"  >
	  
	 <ul>
	  	<li> 
			 <div class="member-view-box action-view-box" style=" padding:0px 15px;">
			                    
			                         <div class="action-box" style="border:-1px;" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span style="cursor:pointer;font-weight: bold;font-size: 1.0em;color:#40A2E3;">
	                          			      <%=StringEscapeUtils.escapeHtml4(ProjectName) %>
			                          		 </span>
			                         			 
										</div>
										
			                           
			                </div>
			          </div>
			         
			             
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	          
			           	           <div class="firstchildafter"></div>      
			                <%int i=1; 
			                
			                int count=1;
			                for(Object[] level1 : ProductTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li >
			                	<% List<Object[]> L1 =ProductTreeList.stream().filter(e-> e[2].toString().equalsIgnoreCase("1") ).collect(Collectors.toList());%>	
			                	
			                	
			                	
			                	  <div class="before" <%if(i==1) {%> style="border:none;" <%} %> ></div>  
			                	
									    <div class="member-view-box action-view-box">
											 <div class="action-box" > 
												
												 <div  class="action-box-header" 
												
												  style="background-image: -webkit-linear-gradient(top,
																			<%if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 95%,
																			
																		    <%if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
												
										             <span  style="cursor:pointer;font-weight:bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;"> 
										                <%=count%> <br> <%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()):"-" %>
										                
										             </span>  
										            
													          
											<!--  <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													      
			                          		    </div> 
			                          	 </div> 
									</div>
									
									
									
											<% List<Object[]> Level1 =ProductTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="active" <%}%> >	
						                  <div class="firstchildafter"></div>     
						                <% int j=1;
						                int countA=1;
						                
						                for(Object[] level2 : ProductTreeList){
						                  if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString()))
							                { %>
							             
												<li>
												<div class="before" <%if(j==1) {%> style="border:none;" <%} %> ></div>  
												
													<div class="member-view-box action-view-box">
															<div class=" action-box" >
															  <div class="action-box-header" 
															  
															      style="background-image: -webkit-linear-gradient(top,
																			<%if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 95%,
																			
																		    <%if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
														
															       <span style="cursor:pointer;font-weight:bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;"> 
			                          			                         <%=count%>.<%=countA%> <br> <%=level2[3]!=null?StringEscapeUtils.escapeHtml4(level2[3].toString()):"-" %>
			                          			                   </span>
			                          			                   
			                          			                <!--   <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													
													             
												             
			                          			             </div>
													     </div>
												   </div> 
												   
												  
												   <% List<Object[]> Level2 =ProductTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										             <ul <% if(Level2!=null && Level2.size()>0){%> class="active" <%}%> >
										              <div class="firstchildafter"></div>    	                
										                	  <% int k=1;
										                	  int countB=1;	    
										                	  for(Object[] level3 : ProductTreeList){
										                 if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) )
										                
										                  { %>
																  <li> 
																  
																
																 
																   <div class="before" <%if(k==1) {%> style="border:none;" <%} %> ></div>  
																   
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
							                                                   style="background-image: -webkit-linear-gradient(top,
																			<%if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 95%,
																			
																		    <%if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
																		
                                                                      
																			 
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;" >
			                          			                             
			                          			                                <%=count%>.<%=countA%>.<%=countB%>  <br><%=level3[3]!=null?StringEscapeUtils.escapeHtml4(level3[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                     <!--  <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													
													                   
			                          			                          
												                                              			
													                 </div>
													              </div>
														   </div> 
															
															 
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	
										                <div class="firstchildafter"></div>                    
										                	 <% int l=1;
										                	 int countC=1;
										                	 for(Object[] level4 : ProductTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                     { %>    
																  <li> 
																  
																   <div class="before" <%if(l==1) {%> style="border:none;" <%} %> ></div> 
																   
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header" 
																		
																		
																		 style="background-image: -webkit-linear-gradient(top,
																			<%if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 90%,
																			
																		    <%if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
																		 
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;" >
			                          			                             
			                          			                                <%=count%>.<%=countA%>.<%=countB%>.<%=countC%> <br><%=level4[3]!=null?StringEscapeUtils.escapeHtml4(level4[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                         <!--  <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													
													                     
												                                              			
													                    </div>
													                                            
																</div>
														</div> 
																	
															 	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="active" <%}%> >	
														  <div class="firstchildafter"></div>                    
										                	<% int m=1;
										                	int countD=1;
										                	for(Object[] level5 : ProductTreeList){%>
								                        	  <% if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) )
								                             {%> 
																  <li> 
																  
																    
																 
																   <div class="before" <%if(m==1) {%> style="border:none;" <%} %> ></div>  
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background-image: -webkit-linear-gradient(top,
																			<%if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 90%,
																			
																		    <%if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;" >
			                          			                             
			                          			                               <%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%> <br> <%=level5[3]!=null?StringEscapeUtils.escapeHtml4(level5[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                        <!--   <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																	
																		<% List<Object[]> Level5 =ProductTreeList.stream().filter(e-> level5[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																		
																		<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																		 <ul <% if(Level5!=null && Level5.size()>0){%> class="active" <%}%> >	
														  <div class="firstchildafter"></div>                    
										                	<% int n=1;
										                	int countE=1;
										                	for(Object[] level6 : ProductTreeList){%>
								                        	  <% if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString()) )
								                             {%> 
																  <li> 
																  
																    
																 
																   <div class="before" <%if(n==1) {%> style="border:none;" <%} %> ></div>  
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background-image: -webkit-linear-gradient(top,
																			<%if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 90%,
																			
																		    <%if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;" >
			                          			                             
			                          			                               <%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%> <br> <%=level6[3]!=null?StringEscapeUtils.escapeHtml4(level6[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                        <!--   <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 	
																		
																		
																		<% List<Object[]> Level6 =ProductTreeList.stream().filter(e-> level6[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																		<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>
																		
																		 <ul <% if(Level6!=null && Level6.size()>0){%> class="active" <%}%> >	
														  <div class="firstchildafter"></div>                    
										                	<% int o=1;
										                	int countF=1;
										                	for(Object[] level7: ProductTreeList){%>
								                        	  <% if(level7[2].toString().equalsIgnoreCase("7") && level6[0].toString().equalsIgnoreCase(level7[1].toString()) )
								                             {%> 
																  <li> 
																  
																    
																 
																   <div class="before" <%if(o==1) {%> style="border:none;" <%} %> ></div>  
																  
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background-image: -webkit-linear-gradient(top,
																			<%if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, 
																			<%}else if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%,
																			<%}else if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%,
																			<%}else if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%,
																			
																			<%}else { %> white 5%,
																			<%} %>
																			 white 5%, white 90%,
																			
																		    <%if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 95% 
																			<%}else if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 95% 
																			<%}else if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 95%
																			<%}else if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 95%
																			
																			<%}else { %> white 95%
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;word-wrap: break-word;" >
			                          			                             
			                          			                                <%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>.<%=countF%> <br><%=level7[3]!=null?StringEscapeUtils.escapeHtml4(level7[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                        <!--   <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div> -->
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 	
																		
																		<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>
																	
																<div class="after"   <% if(o==Level6.size()) {%> style="border-top:none;" <%} %>></div> 	
																	   
																   </li>
															
														    <%o++; 
														    
														    countF++;} %>
														<% } %>
														
														
													</ul>      
																		
																		
																		
																		<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	
																<div class="after"   <% if(n==Level5.size()) {%> style="border-top:none;" <%} %>></div> 	
																	   
																   </li>
															
														    <%n++; 
														    countE++;} %>
														<% } %>
														
														
													</ul>      
																		
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
																<div class="after"   <% if(m==Level4.size()) {%> style="border-top:none;" <%} %>></div> 	
																	   
																   </li>
															
														    <%m++; 
														    
														    countD++;} %>
														<% } %>
														
														
													</ul>      
																	
														<%--------------------------------------------------------------------------------LEVEL 4 ---------------------------------------------%> 
															<div class="after" <% if(l==Level3.size()) {%> style="border-top:none;" <%} %> ></div> 		    
														 </li>
															
												    <%l++;
												    countC++;} %>
												<% } %>
														
													 </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  		    														    
														<div class="after" <% if(k==Level2.size()) {%> style="border-top:none;" <%} %>></div> 			    
															 
							                		    </li>
												
													    <%k++;
													    countB++;
													    } %>
													<% } %>
											
											
											 
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->  
										<div class="after" <% if(j==Level1.size()) {%> style="border-top:none;" <%} %> ></div> 	  	
								 	 </li>
								 <%j++;
								 countA++;} %>
                	        <% } %>
                	        
                	       
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->    
						 	 <div class="after" <% if(i==L1.size()) {%> style="border-top:none;" <%} %> ></div>  			
                		 </li>
                	   <%i++;
                	   count++; } %>
                	<% } %>
					
			
                	
				 </ul> 
                
                         
			          
			         
						
	        		</li>
	        		
		        </ul>
		        
			  
	
	    </div>
	    
	    
	   <div class="bottom-div">  
	    <div align="right">
    
     
         <table >

                  <tr>
						<td style="font-weight:bold;">Stage (Upper)</td>
						<td style="background-color:#D24545;color:#FFFFFF">Design</td>
						<td style="background-color:#E9B824;color:black">Realisation</td>
						<td style="background-color:#0B60B0;color:#FFFFFF">Testing & Evaluation</td>
						<td style="background-color:green;color:#FFFFFF">Ready for Closure</td>
                  </tr>



                 <tr>
						<td style="font-weight:bold;">Module (Lower)</td>
						<td style="background-color:#FF8911;color:black">In-House Development</td>
						<td style="background-color:#FDE767;color:black">BTP</td>
						<td style="background-color:#B67352;color:black">BTS</td>
						<td style="background-color:#492E87;color:#FFFFFF">COTS</td>
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