<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate,java.util.stream.Collectors"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Product Tree Revision </title>


 <style type="text/css">
 

  
/*  th
 {
 	border: 0;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 0;
 	padding: 5px;
 }
 
  }

 .border
 {
 	border: 1px solid black;
 } */

  
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

.genealogy-tree li::before, .genealogy-tree li::after{
    content: '';
    position: absolute; 
    top: 0; 
    right: 50%;
    border-top: 2px solid black;
    width: 50%; 
    height: 18px;
}
.genealogy-tree li::after{
    right: auto; 
    left: 50%;
    border-left: 2px solid black;
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
     border-right: 2px solid black;
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
    /*  width: fit-content ; 
     height: fit-content; */
     /* min-width:190px; */
   /*   min-width:190px; */
  
    border: 1px solid black;
    
    max-width:100px;
    /* max-height:110px; */
/*     display: block; */
    
   
    /* background: linear-gradient(to bottom right, #0B60B0 5%, #0B60B0 10%, white 10%, white 90%, #D24545 0%, #D24545 0%); */
    
}


.action-box-header
{


/*  max-width:120px; */
	padding:2px;
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
  
  
  
</style>


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

<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<center>
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>
	<%} %>

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
						<div class="row" style="">
						
							 <h4>Revision:</h4>
                            		
                            		<div class="col-md-3" style="margin-top: -7px;">
                            		
                              		   <select class="form-control selectdee" name="revCount"   style="width:220px;" data-live-search="true" data-container="body" onchange="this.form.submit();">
										
										<%for(Object[] obj : projectdatarevlist){ %>
											    <option  value="<%=obj[0] %>"  <% if(RevCount.toString().equals(obj[0].toString())) {%> selected <%} %> >REV - <%=obj[0] %> (<%=sdf.format(sdf1.parse(obj[1].toString()) )%>)</option>
										<%} %>
										</select>
										<input type="hidden" name="ProjectId" value="<%=projectid %>" >												
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                              		
  									</div>
  									<div class="col-md-2" style="margin-left:130px;">
  									       <input type="submit" class="btn btn-primary btn-sm back "  value="Back"  onclick="SubmitBack()"  formaction="ProductTree.htm"> 
  									</div>
  							    			
						</div>
						</form>
					</div>
						
						 
					 </div> 
					 
				
					<div class="">	
						<div style="background-color:#FFFFFF;" class="body genealogy-body genealogy-scroll">
						
						<div class="genealogy-tree"  >
	  
	 
			  		<ul>
						<li>      
			
						 <div class="member-view-box action-view-box" style=" padding:0px 15px;">
			                    
			                         <div class=" action-box" style="border:-1px;" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span style="cursor:pointer;font-weight: bold;font-size: 1.0em;">
	                          			         <%if(projectid!=null){	%>
	                          			        	<%=ProjectDetails.get(0)[1] %>
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
												<%} %>
												 
												 );" >  
												
										             <span  style="cursor:pointer;font-weight:bold;font-size: 1.0em;white-space:normal;"> 
										                  <%=level1[3] %>
										                
										             </span>  
										            
													          
											 <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													      
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
														
															       <span style="cursor:pointer;font-weight:bold;font-size: 1.0em;white-space:normal;"> 
			                          			                              <%=level2[3] %>
			                          			                   </span>
			                          			                   
			                          			                  <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													             
												             
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
																   <div class="line-top"></div>    
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
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level3[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                      <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
			                          			                          
												                                              			
													                 </div>
													              </div>
														   </div> 
															
															
															 <% List<Object[]> Level3 =ProductRevTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	                
										                	 <%for(Object[] level4 : ProductRevTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                     { %>    
																  <li> 
																   <div class="line-top"></div>     
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
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level4[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                     
												                                              			
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
																   <div class="line-top"></div>     
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
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level5[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
												                                              			
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
																   <div class="line-top"></div>     
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background: linear-gradient(to bottom right, 
																			<%if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level6[6]!=null && level6[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level6[7]!=null && level6[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level6[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
												                                              			
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
																   <div class="line-top"></div>     
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background: linear-gradient(to bottom right, 
																			<%if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level7[6]!=null && level7[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level7[7]!=null && level7[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level7[3] %>
			                          			                                
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