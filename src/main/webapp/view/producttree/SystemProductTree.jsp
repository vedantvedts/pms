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
	
<!-- 	<button type="button" class="btn viewbtn" id="treeViewBtn" onclick="showDiv('treeView','listView')">Tree View</button>
	<button type="button" class="btn viewbtn" id="listViewBtn" onclick="showDiv('listView','treeView')">List view</button> -->
	</div>
  	</div>
  									
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 <button type="submit" class="btn btn-sm" formaction="ProductreeDownload.htm" formmethod="GET">
 <i class="fa fa-download" aria-hidden="true"></i>
  </button>
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
	
	
<%-- 	    <div class="genealogy-tree" id="treeView" style="">
	    
	    

	        
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
												       <button class="update" onclick="EditModal('<%=level1[0]%>','<%=level1[3]%>','<%=level1[10]%>','<%=level1[11]%>','<%=level1[12]%>')" ><img src="view/images/edit.png" ></button>
												    <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
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
																	       <button class="update" onclick="EditModal('<%=level2[0]%>','<%=level2[3]%>','<%=level2[10]%>','<%=level2[11]%>','<%=level2[12]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
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
																	       <button class="update" onclick="EditModal('<%=level3[0]%>','<%=level3[3]%>','<%=level3[10]%>','<%=level3[11]%>','<%=level3[12]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
																		         <input type="hidden" name="sid" value="<%=sid %>" >
																			     <input type="hidden" name="Action" value="TD">
																		            <button class="delet" name="Mainid" value="<%=level3[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
												                     </div>
													              
													              
														   </div> 
															
															
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                ----------------------------------------------------LEVEL 4 -----------------------------------------------------
										                
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
																	       <button class="update" onclick="EditModal('<%=level4[0]%>','<%=level4[3]%>','<%=level4[10]%>','<%=level4[11]%>','<%=level4[12]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
																		         <input type="hidden" name="sid" value="<%=sid %>" >
																			     <input type="hidden" name="Action" value="TD">
																		            <button class="delet" name="Mainid" value="<%=level4[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																	        </form> 
												                     </div>
																
														</div> 
																	
																	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	------------------------------------------------------------------------------LEVEL 5 -------------------------------------------
																	
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
																				       <button class="update" onclick="EditModal('<%=level5[0]%>','<%=level5[3]%>','<%=level5[10]%>','<%=level5[11]%>','<%=level5[12]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="sid" value="<%=sid %>" >
																						     <input type="hidden" name="Action" value="TD">
																					            <button class="delet" name="Mainid" value="<%=level5[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div> 
																		<% List<Object[]> Level5 =ProductTreeList.stream().filter(e-> level5[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	------------------------------------------------------------------------------LEVEL 6 -------------------------------------------
																	
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
																				       <button class="update" onclick="EditModal('<%=level6[0]%>','<%=level6[3]%>','<%=level6[10]%>','<%=level6[11]%>','<%=level6[12]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="sid" value="<%=sid %>" >
																						     <input type="hidden" name="Action" value="TD">
																					            <button class="delet" name="Mainid" value="<%=level6[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div>
																	
																	
																		<% List<Object[]> Level6 =ProductTreeList.stream().filter(e-> level6[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	------------------------------------------------------------------------------LEVEL 7 -------------------------------------------
																	
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
																				       <button class="update" onclick="EditModal('<%=level7[0]%>','<%=level7[3]%>','<%=level7[10]%>',,'<%=level7[11]%>','<%=level7[12]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="SystemProductTreeEditDelete.htm"  method="get" style="display: inline">
																					         <input type="hidden" name="sid" value="<%=sid %>" >
																						     <input type="hidden" name="Action" value="TD">
																					            <button class="delet" name="Mainid" value="<%=level7[0]%>"  onclick="return confirm ('Are you sure you want to delete? Once deleted, all sub-levels will be deleted as well.')"><img src="view/images/delete.png" ></button>
																				        </form> 
															                     </div>
													                       
													                       
																	</div>
																	
																</li>
															<%  countF++;} %>
														<%} %>	
														
															 -------------------------------------Level 7 Add-------------------------------------------------------
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													              <input type="text" name="LevelCode"   maxlength="3" style="width:35%" placeholder="CODE" required="required">
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#7#<%=level6[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>.<%=countF%>#<%=level6[11] %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 -------------------------------------Level 7 Add-------------------------------------------------------		
														
														</ul>	  
														
														  -------------------------------------Level 7 -------------------------------------------------------		
																   </li>
															
														    <%  countE++;} %>
														<% } %>
														
														
														
																	 -------------------------------------Level 6 Add-------------------------------------------------------
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													                <input type="text" name="LevelCode"   maxlength="3" style="width:35%" placeholder="CODE" required="required">
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#6#<%=level5[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>#<%=level5[11] %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 -------------------------------------Level 6 Add-------------------------------------------------------		
																	
															</ul>			
																	------------------------------------------------------------------------------LEVEL 6 -------------------------------------------
																   
																   </li>
															
														    <%  countD++;} %>
														<% } %>
														
														
														 -------------------------------------Level 5 Add-------------------------------------------------------
														
												   <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													              <input type="text" name="LevelCode"   maxlength="3" style="width:35%" placeholder="CODE"  required="required">
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#5#<%=level4[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>#<%=level4[11] %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													             
													                
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 -------------------------------------Level 5 Add-------------------------------------------------------		
														
													</ul>      
																	
														------------------------------------------------------------------------------LEVEL 5 ------------------------------------------- 
																    
														 </li>
															
												    <% countC++;} %>
												<% } %>
														
														
														 -------------------------------------Level 4 Add-------------------------------------------------------
														
														  <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <input type="text" name="LevelCode"   maxlength="3" style="width:35%" placeholder="CODE"  required="required">
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#4#<%=level3[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>#<%=level3[11] %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													                  
													        </span> 	
													    </div> 
				                
				                               </li>
														
												 -------------------------------------Level 4 Add-------------------------------------------------------		
										                </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->  		    														    
																    
															 
							                		    </li>
												
													    <% countB++;} %>
													<% } %>
											
											
											 -------------------------------------Level 3 Add-------------------------------------------------------
                	        
				                	            <li>
				                                       <div class="member-view-box action-view-box">
															<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
															
															<form action="SystemLevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <input type="text" name="LevelCode"   maxlength="3" style="width:35%" placeholder="CODE"  required="required">
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#3#<%=level2[0]%>#<%=count%>.<%=countA%>.<%=countB%>#<%=level2[11] %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													             
													         </form>    
													          
													                
													        </span> 	
													    </div> 
				                
				                               </li>
                	        
                	          -------------------------------------Level 3 Add-------------------------------------------------------
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  
												
								 	 </li>
								 <% countA++;} %>
                	        <% } %>
                	        
                	        -------------------------------------Level 2 Add-------------------------------------------------------
                	        
                	            <li>
                                       <div class="member-view-box action-view-box">
											<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
											
											<form action="SystemLevelNameAdd.htm" method="get">
									            <input type="text" name="LevelName" required >
									             <input type="text" name="LevelCode" required  maxlength="3" style="width:35%" placeholder="CODE"  >
									            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#2#<%=level1[0]%>#<%=count%>.<%=countA%>#<%=level1[11] %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									             
									         </form>    
									          
									                
									        </span> 	
									    </div> 
                
                               </li>
                	        
                	          -------------------------------------Level 2 Add-------------------------------------------------------
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
						 		    
                		 </li>
                	    <%  
                	   count++;} %>
                	
					<% } %>
			--------------------------------------------------------------------Level 1 Add-------------------------------------------------------
                    <li>
                
                         <div class="member-view-box action-view-box">
							<span style="cursor:pointer;font-weight: 600;font-size: 1.7em;"> 
					            <form action="SystemLevelNameAdd.htm" method="get">
						            <input type="text" name="LevelName" required>
						            <input type="text" name="LevelCode" required  maxlength="3" style="width:35%" placeholder="CODE">
						            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=sid%>#1#0#<%=count %>#N" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									             
							   </form>    
					                 
					        </span> 	
					    </div> 
                
                    </li>
                    
                   
                	-------------------------------------Level 1 Add----------------------------------------------------------
				 </ul> 
                
                         
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->        
			   	
						
	        		</li>
	        		
		        </ul>
	    
        </div> --%>	
        
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
					<div class="col-md-1" >
					<button class="btn add" style="margin-top: -8px;" onclick="EditModal('0')">ADD </button>
					</div>
				
					 </div>
				
					<div class="card-body">
                       
                       	<div class="col-md-12 mb-2" style="text-align: right;">
                              	      		<span style="background-color: #72cd23;padding: 0px 15px;border-radius: 3px;"></span><span>&nbsp; Software  </span>
                              		<span style="background-color: #FF8C00;padding: 0px 15px;border-radius: 3px;"></span><span> &nbsp;Hardware </span>
                              		<span style="background-color: #FF69B4;padding: 0px 15px;border-radius: 3px;"></span><span> &nbsp;Firmware  </span>
                              		</div>
                       
                        <div  align="center">
									<table class="table  table-hover table-bordered" style="width: 50%" id="modal_progress_table">
													<thead>

													<tr>
														<th style="text-align: center;">SN</th> 
														<th style="text-align: center;">Level Name</th> 
														<th style="text-align: center;width:20%;">Level Code</th> 
														<th style="text-align: center;width:20%;">Level Type</th> 
														<th style="text-align: center;width:40%;" >Action</th>
														</tr>
													</thead>
													<tbody>
														<% int  countx=0;
															
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
														 		for(Object[]obj:ProductTreeList){%>
														 		<tr>
														 		<td style="text-align: center" ><%=++countx %>. </td>
														 		<td> <%=obj[3] %></td>
														 		<td><%=obj[10]!=null?obj[10]:"-" %> </td>
														 		
														 		<%if(obj[11]!=null){ %>
														 		<%if(obj[11].toString().equalsIgnoreCase("S")) {%>
														 		<td style="background: #72cd23; color: white;">Software</td>
														 		<%}else if(obj[11].toString().equalsIgnoreCase("F")) {%>
														 		<td style="background: #FF69B4; color: white;">Firmware </td>
														 		<%}else if(obj[11].toString().equalsIgnoreCase("H")){ %>
														 		<td style="background: #FF8C00; color: white;">Hardware</td>
														 		<%}else{ %>
														 		<td>-</td>
														 		<%} %>
														 		<%}else{ %>
														 		<td>-</td>
														 		<%} %>
														 		
														 		<td>
													<div style="display: flex;    justify-content: space-evenly;">
														<button class="btn btn-sm"
															onclick="EditModal('<%=obj[0]%>','<%=obj[3]%>','<%=obj[10]%>','<%=obj[11]%>','<%=obj[12]%>')"   data-toggle="tooltip" data-placement="right"
								title="Edit">
															<img src="view/images/edit.png">
														</button>
														<div>
														<form action="SystemProductTreeEditDelete.htm"
															method="get" style="display: inline">
															<input type="hidden" name="sid" value="<%=sid%>">
															<input type="hidden" name="Action" value="TD">
															<button   class="btn btn-sm" name="Mainid"
																value="<%=obj[0]%>" data-toggle="tooltip" data-placement="right"
								title="Delete"
																onclick="return confirm ('Are you sure you want to delete? ')">
																<img src="view/images/delete.png">
															</button>
														</form>
														</div>
													</div>

												</td>
														 		</tr>
														 		<% }}else{%>
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

 <div class="modal" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 720px;">
    <div class="modal-content">
      <div class="modal-header">
<!--         <h5 class="modal-title" id="exampleModalLongTitle">Edit Level Name</h5> -->
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="SystemProductTreeEditDelete.htm" method="get" id="myform">
        	<table style="width: 100%;">
        		<tr>
        			<th>Level Name : &nbsp; </th>
        			<td><input type="text" class="form-control" name="LevelName" id="levelname" required></td>
        		</tr>
        		<tr></tr>
        		<tr>
        			<th>Level Code : &nbsp; </th>
        			<td ><input type="text" class="form-control" name="LevelCode" id="levelCode" maxlength="3" required style="width: 50%"></td>
        			
        		</tr>
        		<tr></tr>
        		<tr id="issoftwareTr">
        		<th>
        		Level Type:
        		</th>
        		<td>
        		<!-- <select class="form select selectdee IsSoftware"  name="LevelType"   style="width:100%;">
        		<option value="N" selected="selected" >Not Specified</option>
        		<option value="S">Software</option>
        		<option value="H">Hardware</option>
        		<option value="F">Firmware</option>
        		</select> -->
        		
        		<input type="radio" name="LevelType" checked="checked" value="N">&nbsp;  Not Specified &nbsp;
        		<input type="radio" name="LevelType"  value="S">&nbsp; Software &nbsp;
        		<input type="radio" name="LevelType"  value="F"> &nbsp; Firmware &nbsp;
        		<input type="radio" name="LevelType"  value="H">  &nbsp; Hardware &nbsp;

        		</td>
        		</tr>
        		<tr>
        			<td colspan="2" style="text-align: center;">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" formaction="SystemProductTreeEditDelete.htm" id="editbtn"   onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
        				<button class="btn btn-sm submit" formaction="SystemLevelNameAdd.htm" id="addbtn"   onclick="return confirm('Are You Sure to Add?');">SUBMIT</button>
        			</td>
        		</tr>
        	</table>
        	
        	<input type="hidden" id="Mainid" name="Mainid" value="" >
          <input type="hidden" id="" name="Action" value="TE" > 
          <input type="hidden" name="sid" value="<%=sid %>">
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        </form>
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
/* showDiv('treeView','listView')
function showDiv(a,b){
	
	
	$('#'+a).show();
	$('#'+b).hide();
	
	
	$('#'+a+'Btn').css('background-color','green');
	$('#'+a+'Btn').css('color','white');
	$('#'+b+'Btn').css('background-color','grey');
	$('#'+b+'Btn').css('color','black');
	$(".genealogy-body").css("white-space", "normal");
} */

/* function ChangeButton(id) {
	  
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
} */

	function EditModal(mainid,levelname,levelCode,IsSoftware,IsSoftwareMain){
	if(mainid!=='0'){
	$('#Mainid').val(mainid);			
	$('#levelname').val(levelname);
	$('#levelCode').val(levelCode);
	//console.log(mainid,levelname,levelCode,IsSoftware);

	$('input[name="LevelType"][value="' + IsSoftware + '"]').prop('checked', true).trigger('change');
  /*if(IsSoftware!=='N' && (IsSoftware===IsSoftwareMain)){
  		$('#issoftwareTr').hide();
  	}else{
  		$('#issoftwareTr').show();
  	} */
  	
  	if(IsSoftwareMain==='N'){
  		$('#issoftwareTr').show();
  	}else{
  		$('#issoftwareTr').hide();
  	}
		
  	var sid = $('#sid').val();
  $('#editbtn').show();
  $('#addbtn').hide();
	}else{
		 $('#editbtn').hide();
		  $('#addbtn').show();
		$('#levelname').val('');
		$('#levelCode').val('');
		$('input[name="LevelType"][value="N"]').prop('checked', true).trigger('change');
	}
	$('#EditModal').modal('toggle');

	
} 

$("#modal_progress_table").DataTable({
	"lengthMenu": [ 25, 50, 75, 100 ],
	"pagingType": "simple",
	"pageLength": 25
});


$(function () {
$('[data-toggle="tooltip"]').tooltip()
})



</script>
</body>
</html>