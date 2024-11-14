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

            display: flex;
            position: fixed;
            bottom: 0;
            right: 0;
            margin: 10px;  /* Ensures the div stretches across the entire width of the page */
}





</style>
</head>
<body>
<%
List<Object[]>systemList = (List<Object[]>)request.getAttribute("systemList");
List<Object[]>ProductTreeList = (List<Object[]>)request.getAttribute("ProductTreeList");
String sid=(String)request.getAttribute("sid");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");

%>

 <form class="form-inline"  method="POST" action="SystemProductTree.htm">
  <div class="row W-100" style="width: 100%;">

  
	
                                    <div class="col-md-2">
                            		<label class="control-label">System Name :</label>
                            		</div>
                            		<div class="col-md-2" style="margin-top: -7px;">
                              		<select class="form-control selectdee" id="sid" required="required" name="sid">
    									<option disabled selected value="">Choose...</option>
    										<% for (Object[] obj : systemList) {
    										
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(sid)){ %>selected="selected" <%} %>> <%=obj[2]%>  </option>
											<%} %>
  									</select>
  									</div>
  									<div class="col-md-4" style="margin-left: 75px;margin-top:-7px;">
  										<div align="center" class="mb-2">
	
	<button type="button" class="btn viewbtn" id="treeViewBtn" onclick="showDiv('treeView','listView')">Tree View</button>
	<button type="button" class="btn viewbtn" id="listViewBtn" onclick="showDiv('listView','treeView')">List view</button>
	</div>
  										
  						<%-- 				<% if(systemList!=null && systemList.size()>0){ %>
  										
		  										<button type="submit" class="btn btn-sm btn-link" name="view_mode" value="Y" formtarget="blank" title="Product Tree View" data-toggle="tooltip" data-placement="top"  >
												            <img src="view/images/tree.png">
												</button> 
												
												<button type="submit" class="btn btn-sm btn-link" name="view_mode" value="V" formtarget="blank" title="Product Tree View V" data-toggle="tooltip" data-placement="top"  >
												            <img src="view/images/tree.png">
												</button> 
												
												
		                                       
		                                       <button name="action" class="btn btn-sm back" name ="sid" value="<%=sid %>" formaction="ProductTreeRevise.htm" style="background-color: green;color: white; border: 0" type="submit" value="revise"  onclick="return confirm('Are You Sure To Submit')">SET BASE LINE  ( <%=RevisionCount.size()==0?0:String.valueOf(Integer.parseInt(RevisionCount.get(0)[0].toString())+1) %> )</button>
                                                   <input type="hidden" name="REVCount" value="<%=RevisionCount.size()==0?0:String.valueOf(Integer.parseInt(RevisionCount.get(0)[0].toString())+1)%>" >
                                              
                                           <button type="submit" name="sid" value="<%=sid %>" class="btn btn-sm add" formaction="ProductTreeEditDelete.htm" formmethod="get">LIST</button>
                                           
                                           <% if(RevisionCount.size()!=0){ %>
                                         <button type="submit" class="btn btn-sm edit" name="sid" value="<%=sid %>" formaction="ProductTreeRevisionData.htm" formmethod="get">Revision Data</button> 
                                           <input type="hidden" name="revCount" value="<%=RevisionCount.size()==0?0:String.valueOf(Integer.parseInt(RevisionCount.get(0)[0].toString()))%>" >
                                          <%} %>  
                                          
                                          
                                       <%} %> --%>
                                       
                                       <%-- <button  type="submit" class="btn btn-sm "  style="margin-left: 1rem;" name="sid" value="<%=sid %>"  formaction="ProductTreeDownload.htm" formtarget="_blank" ><i class="fa fa-download fa-lg" ></i></button>  --%>
                                      
                                       
                                   </div>
  									
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 </div>
 
</form>
<div style="background-color:#FFFFFF;" class="body genealogy-body genealogy-scroll">
	
	
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
	
	
	    <div class="genealogy-tree" id="treeView" style="">
	    
	    
	<%--    <% if(ProductTreeList!=null && ProductTreeList.size()>0){ %> 
	     <form action="ProductTreeEditDelete.htm" method="get">
	     
	                <button class="btn btn-sm add" type="submit" name="sid" value="<%=sid%>" >Update / Delete</button> 
		     </form>
		     
		     <%} %> --%>
	        
	  		<ul>
				<li>      
	           
						 <div class="member-view-box action-view-box">
			                    
			                         <div class="action-box" style="border:-1px;" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span style="cursor:pointer;font-weight: 600;font-size: 1.7em;">
	                          			        <%if(sid!=null){	
				                                       Object[] systemListDetail=systemList.stream().filter(e->e[0].toString().equalsIgnoreCase(sid)).collect(Collectors.toList()).get(0);%>  
			                                              <%=systemListDetail[2] %>(<%=systemListDetail[1]!=null?systemListDetail[1].toString():"" %>)
	                          			               <%} %>
			                          		 </span>
			                         			 
										</div>
										
			                           
			                </div>
			          </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	                
			                <% 
			                
			                
			                int count=1;
		                	 //int countA=1;
		                	 if(ProductTreeList!=null)
			                for(Object[] level1 : ProductTreeList){
			                	
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
												         <input type="hidden" name="sid" value="<%=sid %>" >
													     <input type="hidden" name="Action" value="TD">
												            <button class="delet" name="Mainid" value="<%=level1[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
												      </form> 
												   </div>
									</div>
									
									
											<% List<Object[]> Level1 =ProductTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="active" <%}%> >	
						                <%
						                
						                int countA=1;
						                for(Object[] level2 : ProductTreeList){
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
																		         <input type="hidden" name="sid" value="<%=sid %>" >
																			     <input type="hidden" name="Action" value="TD">
																		            <button class="delet" name="Mainid" value="<%=level2[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
												                     </div>
												   </div> 
												   
												   
												   <% List<Object[]> Level2 =ProductTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										             <ul <% if(Level2!=null && Level2.size()>0){%> class="active" <%}%> >
										             
										              <%
										                  int countB=1;	        
										                	  
										                	  for(Object[] level3 : ProductTreeList){
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
																		         <input type="hidden" name="sid" value="<%=sid %>" >
																			     <input type="hidden" name="Action" value="TD">
																		            <button class="delet" name="Mainid" value="<%=level3[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
												                     </div>
													              
													              
														   </div> 
															
															
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	                
										                	 <%
										                	 
										                	 int countC=1;
										                	 
										                	 for(Object[] level4 : ProductTreeList){
															                 
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
																		         <input type="hidden" name="sid" value="<%=sid %>" >
																			     <input type="hidden" name="Action" value="TD">
																		            <button class="delet" name="Mainid" value="<%=level4[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
												                     </div>
																
														</div> 
																	
																	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="active" <%}%> >	                
										                	<%
										                	
										                	 int countD=1;
										                	for(Object[] level5 : ProductTreeList){%>
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
			                          			                          
													                                <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:2px;cursor: pointer ;"></i></div> 
													
													                    
												                                              			
													                        </div>
													                        
													                       </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level5[0]%>','<%=level5[3]%>','<%=level5[6]%>','<%=level5[7]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="sid" value="<%=sid %>" >
																						     <input type="hidden" name="Action" value="TD">
																					            <button class="delet" name="Mainid" value="<%=level5[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div> 
																		<% List<Object[]> Level5 =ProductTreeList.stream().filter(e-> level5[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	
																	 <ul <% if(Level5!=null && Level5.size()>0){%> class="active" <%}%> >	                
													                	<%
													                	
													                	 int countE=1;
													                	for(Object[] level6 : ProductTreeList){%>
											                        	  <% if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString()) )
											                             { %> 
																  <li>      
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
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level6[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                           <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 1.2rem;color:black;padding-top:0px;padding-bottom:2px;cursor: pointer ;"></i></div> 
			                          			                            			
													                    </div>
													                        
													                </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level6[0]%>','<%=level6[3]%>','<%=level6[6]%>','<%=level6[7]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="sid" value="<%=sid %>" >
																						     <input type="hidden" name="Action" value="TD">
																					            <button class="delet" name="Mainid" value="<%=level6[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div>
																	
																	
																		<% List<Object[]> Level6 =ProductTreeList.stream().filter(e-> level6[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	<%--------------------------------------------------------------------------------LEVEL 7 ---------------------------------------------%>
																	
																	 <ul <% if(Level6!=null && Level6.size()>0){%> class="active" <%}%> >	                
													                	<%
													                	
													                	int countF=1;
													                	for(Object[] level7 : ProductTreeList){ %>
											                        	  <% if(level7[2].toString().equalsIgnoreCase("7") && level6[0].toString().equalsIgnoreCase(level7[1].toString()) )
											                             { %> 
																  <li>      
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
																		
																		<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;" >
			                          			                             
			                          			                                <%=level7[3] %>
			                          			                                
			                          			                          </span>
			                          			                            			
													                    </div>
													                        
													                </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level7[0]%>','<%=level7[3]%>','<%=level7[6]%>','<%=level7[7]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="sid" value="<%=sid %>" >
																						     <input type="hidden" name="Action" value="TD">
																					            <button class="delet" name="Mainid" value="<%=level7[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div>
																	
																</li>
															<%  countF++;} %>
														<%} %>	
														
															 <%---------------------------------------Level 7 Add---------------------------------------------------------%>
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#7#<%=level6[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>.<%=countF%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 <%---------------------------------------Level 7 Add---------------------------------------------------------%>		
														
														</ul>	  
														
														  <%---------------------------------------Level 7 ---------------------------------------------------------%>		
																   </li>
															
														    <%  countE++;} %>
														<% } %>
														
														
														
																	 <%---------------------------------------Level 6 Add---------------------------------------------------------%>
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#6#<%=level5[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 <%---------------------------------------Level 6 Add---------------------------------------------------------%>		
																	
															</ul>			
																	<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																   
																   </li>
															
														    <%  countD++;} %>
														<% } %>
														
														
														 <%---------------------------------------Level 5 Add---------------------------------------------------------%>
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#5#<%=level4[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 <%---------------------------------------Level 5 Add---------------------------------------------------------%>		
														
													</ul>      
																	
														<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%> 
																    
														 </li>
															
												    <% countC++;} %>
												<% } %>
														
														
														 <%---------------------------------------Level 4 Add---------------------------------------------------------%>
														
														  <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#4#<%=level3[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													                  
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 <%---------------------------------------Level 4 Add---------------------------------------------------------%>		
										                </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->  		    														    
																    
															 
							                		    </li>
												
													    <% countB++;} %>
													<% } %>
											
											
											 <%---------------------------------------Level 3 Add---------------------------------------------------------%>
                	        
				                	            <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#3#<%=level2[0]%>#<%=count%>.<%=countA%>.<%=countB%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													          
													                
													        </span> 	
													    </div> 
				                
				                               </li>
                	        
                	          <%---------------------------------------Level 3 Add---------------------------------------------------------%>
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  
												
								 	 </li>
								 <% countA++;} %>
                	        <% } %>
                	        
                	        <%---------------------------------------Level 2 Add---------------------------------------------------------%>
                	        
                	            <li>
                                       <div class="member-view-box action-view-box">
											<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
											
											<form action="SystemLevelNameAdd.htm" method="get">
									            <input type="text" name="LevelName" required >
									            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#2#<%=level1[0]%>#<%=count%>.<%=countA%>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									             
									         </form>    
									          
									                
									        </span> 	
									    </div> 
                
                               </li>
                	        
                	          <%---------------------------------------Level 2 Add---------------------------------------------------------%>
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
						 		    
                		 </li>
                	    <%  
                	   count++;} %>
                	
					<% } %>
			<%----------------------------------------------------------------------Level 1 Add---------------------------------------------------------%>
                    <li>
                
                         <div class="member-view-box action-view-box">
							<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
					            <form action="SystemLevelNameAdd.htm" method="get">
						            <input type="text" name="LevelName" required>
						            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#1#0#<%=count %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									             
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
        
        <div id="listView">
 <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				
				<div class="card shadow-nohover" style="margin-top: -0px;">
			
		
				<div class="row card-header">
			     <div class="col-md-11">
					<h5 ><%if(sid!=null){	
				        Object[] systemListDetail=systemList.stream().filter(e->e[0].toString().equalsIgnoreCase(sid)).collect(Collectors.toList()).get(0);%>  
			           <%=systemListDetail[2] %>(<%=systemListDetail[1]!=null?systemListDetail[1].toString():"" %>)
	                      <%} %>
					</h5>
					</div>
					<%-- <form>
					      <input type="hidden"  value="<%=sid %>" name="sid"> 
					      <input type="submit" class="btn btn-primary btn-sm back "  value="Back"  onclick="SubmitBack()"  formaction="ProductTree.htm"> 
					</form> --%>
					 </div>
				
					<div class="card-body">
                        <div class="table-responsive"> 
									<table class="table  table-hover table-bordered">
													<thead>

														<tr>
															<th>Expand</th>
															
															<th style="text-align: left;width:200px;">Level </th> 
															<th style="text-align: left;width:100px;">Level Id </th> 
															 <th style="text-align: left;">Level Name</th> 
															
															<th style="" >Stage</th>	
															<th style="" >Module</th>											
														 	<th style=";" >Action</th>
														 		
														 	
														</tr>
													</thead>
													<tbody>
														<% int  countx=1;
															
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level1: ProductTreeList){
																 if(level1[2].toString().equalsIgnoreCase("1")) { %>	
																
														<tr>
															<td style="width:2% !important;" class="center"><span class="clickable" data-toggle="collapse" id="row<%=countx %>" data-target=".row<%=countx %>"><button class="btn btn-sm btn-success" id="btn<%=countx %>"  onclick="ChangeButton('<%=countx %>')"><i class="fa fa-plus"  id="fa<%=countx%>"></i> </button></span></td> 
															 <td style="">Sub-System-L<%=level1[2] %></td>
															 <td style="text-align: left;"><%=countx %></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level1[3] %></td>
															
															<td><% if(level1[6]!=null){%><%=level1[6] %><%}else { %> -- <%} %></td>
															<td><% if(level1[7]!=null){%><%=level1[7] %><%}else { %> -- <%} %></td>
															
															<td  style="width:20% !important; text-align: center;">		
																	
																	
														<%-- 	
		                                                              <button  class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level1[0]%>','<%=level1[3]%>','<%=level1[6]%>','<%=level1[7]%>','0')">  
		                                                              
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													             
													           <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													               <input type="hidden" name="sid" value="<%=sid %>" >
																    <input type="hidden" name="Action" value="D"/>
																    <input type="hidden" name="buttonid" value="<%=countx %>">
													                  <button  class="editable-click" name="Mainid" value="<%=level1[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')">
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button> 
													               </form> --%>
													                 
		                                                   	 
															 	
															</td>
														</tr>
														
														  <tr class="collapse row<%=countx %>"  id="rowcollapse<%=countx%>" style="font-weight: bold;">
                                                         <td></td>
                                                         <td style="width:200px;">Sub -Level</td>
                                                         <td style="width:100px;">Sub -Level Id</td>
                                                         <td>Level Name</td>
                                                         <td >Stage</td>	
														 <td >Module</td>	
                                                         <td>Action</td>
                                                         
                                                         </tr>
                                                         
                                                         <% int countA=1;
                                                          
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level2: ProductTreeList){
																 if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString())){ %>
	
																
														<tr class="collapse row<%=countx %>" id="rowcollapse<%=countx%>" >
															<td style="width:2% !important; " class="center"> </td>
																		 <td style="">Sub-System-L<%=level2[2] %></td>
															<td style="text-align: left;">&nbsp;&nbsp; &nbsp;&nbsp;<%=countx %>.<%=countA%></td>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level2[3] %></td>
															<td><% if(level2[6]!=null){%><%=level2[6] %><%}else { %> -- <%} %></td>
															<td><% if(level2[7]!=null){%><%=level2[7] %><%}else { %> -- <%} %></td>
														 	<td class="width-30px" style="text-align: center;">
														 	
														 	
														<%--  	 <button class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level2[0]%>','<%=level2[3]%>','<%=level2[6]%>','<%=level2[7]%>','<%=countx %>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													             </button> 
													                  
													            <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="sid" value="<%=sid %>" >
																    <input type="hidden" name="Action" value="D"/>
																      <input type="hidden" name="buttonid" value="<%=countx %>">
													                  <button class="editable-click" name="Mainid" value="<%=level2[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
													                  
													               </form> --%>
														 	
														 	
														 	
														 	
														 	</td>
                                                         </tr>
                                                         <% int countB=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level3: ProductTreeList){
																  if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) ){
	
																%>
														<tr class="collapse row<%=countx %>" id="rowcollapse<%=countx%>">
															<td style="width:2% !important; " class="center"> </td>
															 <td style="">Sub-System-L<%=level3[2] %></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<%=countx %>.<%=countA%>.<%=countB%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level3[3] %></td>
															<td><% if(level3[6]!=null){%><%=level3[6] %><%} else { %> -- <%} %></td>
															<td><% if(level3[7]!=null){%><%=level3[7] %><%} else { %> -- <%} %></td>
															
															<td class="width-30px"  style="text-align: center;">
															
															
												<%-- 			 <button  class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level3[0]%>','<%=level3[3]%>','<%=level3[6]%>','<%=level3[7]%>','<%=countx %>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  
													             <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="sid" value="<%=sid %>" >
																    <input type="hidden" name="Action" value="D"/>
																    <input type="hidden" name="buttonid" value="<%=countx %>">
													                 <button class="editable-click" name="Mainid" value="<%=level3[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															     </form> --%>
															
															
															</td>
															
                                                         </tr>
                                                         <% int countC=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level4: ProductTreeList){
																  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) {
																%>
														<tr class="collapse row<%=countx %>"  id="rowcollapse<%=countx%>" >
															<td style="width:2% !important; " class="center"> </td>
															<td style="">Sub-System-L<%=level4[2] %></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=countx %>.<%=countA%>.<%=countB%>.<%=countC%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level4[3] %></td>
															<td><% if(level4[6]!=null){%><%=level4[6] %><%} else { %> -- <%} %></td>
															<td><% if(level4[7]!=null){%><%=level4[7] %><%} else { %> -- <%} %></td>
															
															<td class="width-30px"  style="text-align: center;">
															
															
												<%-- 		 <button  class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level4[0]%>','<%=level4[3]%>','<%=level4[6]%>','<%=level4[7]%>','<%=countx %>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													              <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="sid" value="<%=sid %>" >
																    <input type="hidden" name="Action" value="D"/>
																    <input type="hidden" name="buttonid" value="<%=countx %>">
													                 <button class="editable-click" name="Mainid" value="<%=level4[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															      </form> --%>
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countD=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level5: ProductTreeList){
															if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) ){%>
	
																
														<tr class="collapse row<%=countx %>"  id="rowcollapse<%=countx%>" >
															<td style="width:2% !important; " class="center"> </td>
															<td style="">Sub-System-L<%=level5[2] %></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=countx %>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%></td>
														
														
														  
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level5[3] %></td>
															 <td><% if(level5[6]!=null){%><%=level5[6] %><%} else { %> -- <%} %></td>
															<td><% if(level5[7]!=null){%><%=level5[7] %><%} else { %> -- <%} %></td>
															
																<td class="width-30px" style="text-align: center;">
															
															
															<%-- 	 <button  class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level5[0]%>','<%=level5[3]%>','<%=level5[6]%>','<%=level5[7]%>','<%=countx %>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
														
													                  
													                  
													               <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                  <input type="hidden" name="sid" value="<%=sid %>" >
																      <input type="hidden" name="Action" value="D"/>
																      <input type="hidden" name="buttonid" value="<%=countx %>">
													                  <button class="editable-click" name="Mainid" value="<%=level5[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
													                </form> --%>
															
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countE=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level6: ProductTreeList){ 
																if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString())) {
																	
																%>
															
														<tr class="collapse row<%=countx %>"  id="rowcollapse<%=countx%>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="">Sub-System-L<%=level6[2] %></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=countx %>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level6[3] %></td>
															<td><% if(level6[6]!=null){%><%=level6[6] %><%} else { %> -- <%} %></td>
															<td><% if(level6[7]!=null){%><%=level6[7] %><%} else { %> -- <%} %></td>
															 
														    <td class="width-30px" style="text-align: center;">
															
															
														<%-- 		 <button  class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level6[0]%>','<%=level6[3]%>','<%=level6[6]%>','<%=level6[7]%>','<%=countx %>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
														
													                  
													                  
													              <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="sid" value="<%=sid %>" >
																    <input type="hidden" name="Action" value="D"/>
																    <input type="hidden" name="buttonid" value="<%=countx %>">
													                 <button class="editable-click" name="Mainid" value="<%=level6[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															     </form> --%>
															
															
															
															</td>
															
															
                                                         </tr>
                                                         
                                                         <% int countF=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level7: ProductTreeList){ 
																if(level7[2].toString().equalsIgnoreCase("7") && level6[0].toString().equalsIgnoreCase(level7[1].toString())) {
																	
																%>
															
														<tr class="collapse row<%=countx %>"  id="rowcollapse<%=countx%>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="">Sub-System-L<%=level7[2] %></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=countx %>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>.<%=countF%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level7[3] %></td>
															<td><% if(level7[6]!=null){%><%=level7[6] %><%} else { %> -- <%} %></td>
															<td><% if(level7[7]!=null){%><%=level7[7] %><%} else { %> -- <%} %></td>
															 
														    <td class="width-30px" style="text-align: center;">
															
															
													<%-- 			 <button  class="editable-click" name="buttonid" value="<%=countx %>" onclick="EditModal('<%=level7[0]%>','<%=level7[3]%>','<%=level7[6]%>','<%=level7[7]%>','<%=countx %>')">  
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
														
													                  
													                  
													              <form action="ProductTreeEditDelete.htm"  method="get" style="display: inline">
													                <input type="hidden" name="sid" value="<%=sid %>" >
																    <input type="hidden" name="Action" value="D"/>
																    <input type="hidden" name="buttonid" value="<%=countx %>">
													                 <button class="editable-click" name="Mainid" value="<%=level7[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"> 
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															     </form> --%>
															
															
															
															</td>
															
															
                                                         </tr>
                                                <% countF++;} }}%>         
												<% countE++;} }}%>
												<% countD++;} }}%>
												<% countC++;} }}%>
												<% countB++;} }}%>
												<% countA++;} }}else{%>
												<tr class="collapse row<%=countx %>">
													<td colspan="9" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
												<%} %> 
												<% countx++; }} }else{%>
												<tr >
													<td colspan="9" style="text-align: center" class="center">No List Found</td>
												</tr>
												<%} %>
												
												</tbody>
												</table>
											</div>
							   </div>
							   
							  
							
						</div>
					
						
						
                  
					</div>
					
		
				</div>
        </div>
        </div>
      
        
       

	    
	</div>   


<script>
$(document).ready(function() {
	   $('#sid').on('change', function() {
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
showDiv('treeView','listView')
function showDiv(a,b){
	
	
	$('#'+a).show();
	$('#'+b).hide();
	
	
	$('#'+a+'Btn').css('background-color','green');
	$('#'+a+'Btn').css('color','white');
	$('#'+b+'Btn').css('background-color','grey');
	$('#'+b+'Btn').css('color','black');
	$(".genealogy-body").css("white-space", "normal");
}

function ChangeButton(id) {
	  
	//console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
	$( ".row"+id).show();
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
	$( ".row"+id).hide();
    }
}
</script>
</body>
</html>