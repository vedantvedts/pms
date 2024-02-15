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

body{
background-color: #f2edfa;
overflow-x:hidden !important; 
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

th
{

  text-align: left;
 	
}


.action-view-box {
    position: relative;
}

.actions {
    position: absolute;
    top: 0;
    right: -20px; /* initially hide the actions */
    visibility: hidden;
    transition: right 0.3s;
}

.action-view-box:hover .actions {
    right: 0; /* show the actions on hover */
    visibility: visible;
}

.update,
.delet {
    display: block; /* Change display to block to stack the icons and text */
    padding: 5px 5px;
    margin-right: -18px;
    text-align: left; /* Align text to the left */
    border: none; /* This line removes the border */
    cursor:pointer;
}

img{
width:18px;
height:18px;

}
/* .update i,
.delet i {
    margin-right: 20px; /* Add some space between the icon and text */
} */

/* .edit:hover,
.delete:hover {
    background-color: #ccc;
} */






.bottom-div {
    position: fixed;
    bottom: 0;
    left: -20px;
    width: 100%; /* Ensures the div stretches across the entire width of the page */
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
    									<option disabled selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {
    										String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>> <%=obj[4]+projectshortName%>  </option>
											<%} %>
  									</select>
  									</div>
  									<div class="col-md-2" style="margin-left: 75px;margin-top:-7px;">
  										
  									    <button type="submit" class="btn btn-sm btn-link" name="view_mode" value="Y" formtarget="blank" title="Product Tree View" data-toggle="tooltip" data-placement="top"  >
										
										     <img src="view/images/tree.png"  >
										               
                                       </button> 
                                       
                                       <%-- <button  type="submit" class="btn btn-sm "  style="margin-left: 1rem;" name="ProjectId" value="<%=ProjectId %>"  formaction="ProductTreeDownload.htm" formtarget="_blank" ><i class="fa fa-download fa-lg" ></i></button> --%>
                                       
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
	    
	    
	<%--    <% if(ProductTreeList!=null && ProductTreeList.size()>0){ %> 
	     <form action="ProductTreeEditDelete.htm" method="get">
	     
	                <button class="btn btn-sm add" type="submit" name="ProjectId" value="<%=ProjectId%>" >Update / Delete</button> 
		     </form>
		     
		     <%} %> --%>
	        
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
												<%} %> );" > 
												 
												 
												
										             <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
										           <%=level1[3] %>
										                
										             </span> 
										             
										             
										            
										               <div style="margin-top:-5px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
												         
			                          		   </div>
										</div> 
									 
												<div class="actions">
												       <button class="update" onclick="EditModal('<%=level1[0]%>','<%=level1[3]%>','<%=level1[6]%>','<%=level1[7]%>')" ><img src="view/images/edit.png" ></button>
												    <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
												         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
													     <input type="hidden" name="Action" value="D">
												            <button class="delet" name="Mainid" value="<%=level1[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
												      </form> 
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
															  
															       <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
			                          			                              <%=level2[3] %>
			                          			                   </span>
			                          			                   
			                          			                    <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													 
			                          			             </div>
													     </div>
													     
													      
													              <div class="actions">
																	       <button class="update" onclick="EditModal('<%=level2[0]%>','<%=level2[3]%>','<%=level2[6]%>','<%=level2[7]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																		         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																			     <input type="hidden" name="Action" value="D">
																		            <button class="delet" name="Mainid" value="<%=level2[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
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
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level3[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                            <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:2px;cursor: pointer ;"></i></div>
													                         			
													                 </div>
													              </div>
													              
													              <div class="actions">
																	       <button class="update" onclick="EditModal('<%=level3[0]%>','<%=level3[3]%>','<%=level3[6]%>','<%=level3[7]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																		         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																			     <input type="hidden" name="Action" value="D">
																		            <button class="delet" name="Mainid" value="<%=level3[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
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
																		
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level4[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                     
												                                              			
													                    </div>
													                                            
																</div>
																
																 
													              <div class="actions">
																	       <button class="update" onclick="EditModal('<%=level4[0]%>','<%=level4[3]%>','<%=level4[6]%>','<%=level4[7]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																		         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																			     <input type="hidden" name="Action" value="D">
																		            <button class="delet" name="Mainid" value="<%=level4[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
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
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level5[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
													                               <!-- <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:2px;cursor: pointer ;"></i></div> -->
													
													                    
												                                              			
													                        </div>
													                        
													                       </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level5[0]%>','<%=level5[3]%>','<%=level5[6]%>','<%=level5[7]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																						     <input type="hidden" name="Action" value="D">
																					            <button class="delet" name="Mainid" value="<%=level5[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div> 
																	
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	   
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
									          
									                
									        </span> 	
									    </div> 
                
                               </li>
                	        
                	          <%---------------------------------------Level 2 Add---------------------------------------------------------%>
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
						 		    
                		 </li>
                	   <% } %>
                	<% } %>
					
			<%----------------------------------------------------------------------Level 1 Add---------------------------------------------------------%>
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
	    
	 <!-- 	 <div class="bottom-div">  
	    <div align="right">
    
     
         <table style="border: 1px solid black;padding: 3px;">

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
  </div> -->
	        
	    
	    
	 	        
	</div>
	
	
	
	<div class="modal" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Level Name</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="ProductTreeEditDelete.htm" method="get">
        	<table style="width: 100%;">
        		<tr>
        			<th>Level Name : &nbsp; </th>
        			<td><input type="text" class="form-control" name="LevelName" id="levelname" required></td>
        		</tr>
        		
        		
        		<tr>
        			<th >Stage : &nbsp; </th>
        			<td >
        			
        			<select class="form select selectdee " name="Stage"  id="stage"  required style="width:100%;">
        			
        			        <option value="Design">Design</option>
		      				<option value="Realisation">Realisation</option>
		      				<option value="Testing & Evaluation">Testing & Evaluation</option>
		      				<option value="Ready for Closure">Ready for Closure</option>
        			
        			</select>
        			
        			</td>
        		</tr>
        		
        		
        		
        			<tr>
        			     <th >Module : &nbsp; </th>
        			<td >
        			
        			<select class="form select selectdee" id="Module" name="Module"  required style="width:100%;">
        			
        			        <option value="In-House-Development">In-House-Development</option>
		      				<option value="BTP">BTP</option>
		      				<option value="BTS">BTS</option>
		      				<option value="COTS">COTS</option>
        			
        			</select>
        			
        			</td>
        		</tr>
        		
        		
        		
        		
        		<tr>
        			<td colspan="2" style="text-align: center;">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
        			</td>
        		</tr>
        	</table>
        	
        	<input type="hidden" id="Mainid" name="Mainid" value="" >
        	<input type="hidden" id="" name="Action" value="E" >
        	<input type="hidden" id="" name="ProjectId" value="<%=ProjectId %>" >
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
        </form>
      </div>
     
    </div>
  </div>
</div>
	
	
	

	
	
	
	
	  
<!-- 	</form> -->


<!-- ------------------------------- tree script ------------------------------- -->
  <script type="text/javascript">

  

  
  
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

  
  function EditModal(mainid,levelname,stage,module)
  {
  	$('#Mainid').val(mainid);			
  	$('#levelname').val(levelname);

  	
  var selectedstage=stage	
  var selectedModule = module;



  $('#EditModal').modal('toggle');
  	
  var s='';
  $('#stage').html("");


  	
  	 if (selectedstage =='Design') {
  		 
  		 
  		    s +='<option value="Design" selected="selected">Design</option>';
  			s +='<option value="Realisation" >Realisation</option>';
  			s +='<option value="Testing & Evaluation">Testing & Evaluation</option>';
  			s +='<option value="Ready for Closure">Ready for Closure</option>'; 
  		 
  	       
      }  if (selectedstage == 'Realisation') {
  		
  		
  		 
      	    s +='<option value="Design" >Design</option>';
  			s +='<option value="Realisation" selected="selected">Realisation</option>';
  			s +='<option value="Testing & Evaluation">Testing & Evaluation</option>';
  			s +='<option value="Ready for Closure">Ready for Closure</option>'; 
        
         
      }   if (selectedstage == 'Testing & Evaluation') {
          
          
      	    s +='<option value="Design" >Design</option>';
  			s +='<option value="Realisation" >Realisation</option>';
  			s +='<option value="Testing & Evaluation" selected="selected" >Testing & Evaluation</option>';
  			s +='<option value="Ready for Closure">Ready for Closure</option>'; 
         
      }  if (selectedstage == 'Ready for Closure') {
         
          
             
      	    s +='<option value="Design" >Design</option>';
  			s +='<option value="Realisation" >Realisation</option>';
  			s +='<option value="Testing & Evaluation"  >Testing & Evaluation</option>';
  			s +='<option value="Ready for Closure" selected="selected" >Ready for Closure</option>'; 
         
      } 
      
      
      
      if (selectedstage == 'null') {
          
          
    	s +='<option value="" selected="eslected" disabled="disabled" >Select</option>'; 
  	    s +='<option value="Design" >Design</option>';
  		s +='<option value="Realisation" >Realisation</option>';
  		s +='<option value="Testing & Evaluation"  >Testing & Evaluation</option>';
  		s +='<option value="Ready for Closure" >Ready for Closure</option>'; 
     
  } 
  	
  	 $('#stage').html(s);		
  	
  var p='';
  $('#Module').html("");


  	
  	 if (selectedModule =='In-House Development') {
  		 
  		    p +='<option value="In-House Development" selected="selected">In-House Development</option>';
  			p +='<option value="BTP" >BTP</option>';
  			p +='<option value="BTS">BTS</option>';
  			p +='<option value="COTS">COTS</option>'; 
  		 
  	       
      }  if (selectedModule == 'BTP') {
  		
  		
  		 
  		p +='<option value="In-House Development">In-House Development</option>';
  		p +='<option value="BTP" selected="selected">BTP</option>';
  		p +='<option value="BTS">BTS</option>';
  		p +='<option value="COTS">COTS</option>';
  		
        
         
      }   if (selectedModule == 'BTS') {
          
          
      	p +='<option value="In-House Development">In-House Development</option>';
  		p +='<option value="BTP">BTP</option>';
  		p +='<option value="BTS" selected="selected" >BTS</option>';
  		p +='<option value="COTS" >COTS</option>';
         
      }  if (selectedModule == 'COTS') {
         
          
             
      	p +='<option value="In-House Development">In-House Development</option>';
  		p +='<option value="BTP">BTP</option>';
  		p +='<option value="BTS">BTS</option>';
  		p +='<option value="COTS" selected="selected" >COTS</option>';
         
      } 
      
      if (selectedModule == 'null') {
          
          
        p +='<option value="" selected="eslected" disabled="disabled" >Select</option>'; 
      	p +='<option value="In-House Development">In-House Development</option>';
  		p +='<option value="BTP">BTP</option>';
  		p +='<option value="BTS">BTS</option>';
  		p +='<option value="COTS" >COTS</option>';
     
       } 
  	
  	 $('#Module').html(p);	
  	 

  }
  
  
  
</script> 


</body>
</html>






   
   
