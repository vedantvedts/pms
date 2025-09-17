<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.print.model.ProjectSlides"%>
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

 <spring:url value="/resources/css/producttree/ProductTreeAdd.css" var="productTreeAdd" />
<link href="${productTreeAdd}" rel="stylesheet" />

<title>Product Tree</title>

</head>
 

  <%
  
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  List<Object[]> preProjectList=(List<Object[]>)request.getAttribute("preProjectList");
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  ProductTreeList=ProductTreeList==null?new ArrayList<>():ProductTreeList;
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String initiationId=(String)request.getAttribute("initiationId");
  String ProjectType=(String)request.getAttribute("ProjectType");
  List<Object[]> RevisionCount =(List<Object[]>)request.getAttribute("RevisionCount");
  List<Object[]> systemList =(List<Object[]>)request.getAttribute("systemList");
  ProjectSlides ps = (ProjectSlides)request.getAttribute("ps");
 	String systemId="1";
  if(ps!=null &&  ps.getSystemId()!=null && ps.getSystemId()!=0){
	  systemId=ps.getSystemId()+"";
 	}
	 Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails"); 
	 
     String ProjectName="";
	   
       if(ProjectDetail!=null && ProjectId!=null){	
    	   ProjectName=ProjectDetail[2].toString()+"("+ ProjectDetail[1].toString()  +")";
       }else{
    	   ProjectName=preProjectList.stream().filter(e->e[0].toString().equalsIgnoreCase(initiationId)).collect(Collectors.toList()).get(0)[3].toString();
       }
    
 %>
<body>
 <form class="form-inline"  method="POST" action="ProductTree.htm" id="myfrm">
  <div class="row w-100">

  
	
                                    <div class="col-md-2">
                            		<label class="control-label">Project Type :</label>
                            		</div>
                            		<div class="col-md-2 mt-minus-7" >
                              		<select class="form-control selectdee" id="ProjectType" required="required" name="ProjectType" onchange="submit(myfrm)">
                              			<option disabled selected value="">Choose...</option>
                              			<option value="M" <%if(ProjectType.equalsIgnoreCase("M")){ %>selected<%} %>>Main Project</option>
                              			<option value="I" <%if(ProjectType.equalsIgnoreCase("I")){ %>selected<%} %>>Initiation Project</option>
                              	
                              		</select>
                              		</div>
                              		
                              		<div class="col-md-7 text-right">
                              	      		<span class="software"></span><span>&nbsp; Software  </span>
                              		<span class="hardware"></span><span> &nbsp;Hardware </span>
                              		<span class="firmware"></span><span> &nbsp;Firmware  </span>
                              		</div>
                              		
                              		</div>
                              					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              					
                              		</form>
                            <br>
 <form class="form-inline"  method="POST" action="ProductTree.htm" id="myfrm1">
  <div class="row w-100" >

  
	
                                    <div class="col-md-2">
                            		<label class="control-label">Project Name :</label>
                            		</div>
                            		<%if(ProjectType.equalsIgnoreCase("M")) {%>
                            		<div class="col-md-2 mt-minus-7">
                              		<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    									<option disabled selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {
    										String projectshortName=(obj[17]!=null)?" ( "+StringEscapeUtils.escapeHtml4(obj[17].toString())+" ) ":"";
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>> <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-"%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):"-"%>  </option>
											<%} %>
  									</select>
  									</div>
  									 <input type="hidden" name="initiationId" value="<%=initiationId%>">
  									<%} %>
  									
  											<%if(ProjectType.equalsIgnoreCase("I")) {%>
                            		<div class="col-md-2 mt-minus-7" >
                              		<select class="form-control selectdee" id="initiationId" required="required" name="initiationId" onchange="submit(myfrm1)">
    									<option disabled selected value="">Choose...</option>
    									<%for(Object[]obj:preProjectList){ %>
    							<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(initiationId)){ %>selected="selected" <%} %>> <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%>  </option>
    									<%} %>
  									</select>
  									</div>
  									 <input type="hidden" name="ProjectId" value="<%=ProjectId%>">
  									<%} %>
  									
  									<div class="col-md-4 mt-minus-7" >
  										
  										
  										<% if(ProductTreeList!=null && ProductTreeList.size()>0 ){ %>
  										
		  										<button type="submit" class="btn btn-sm btn-link" name="view_mode" value="Y" formtarget="blank" title="Product Tree View" data-toggle="tooltip" data-placement="top"  >
												            <img src="view/images/tree.png">
												</button> 
												
												<!-- <button type="submit" class="btn btn-sm btn-link" name="view_mode" value="V" formtarget="blank" title="Product Tree View V" data-toggle="tooltip" data-placement="top"  >
												            <img src="view/images/tree.png">
												</button>  -->
														
												                                        <button type="submit" name="ProjectId" value="<%=ProjectId %>" class="btn btn-sm add" formaction="ProductTreeEditDelete.htm" formmethod="get">LIST</button>
		                                       
		                                       <%} %>
		                                      										<% if(ProductTreeList!=null && ProductTreeList.size()>0 && ProjectType.equalsIgnoreCase("M")){ %>   
		                                       
		                                       <button name="action" class="btn btn-sm back btn-add-pro" name ="ProjectId" value="<%=ProjectId %>" formaction="ProductTreeRevise.htm"   type="submit" value="revise"  onclick="return confirm('Are You Sure To Submit')">SET BASE LINE  ( <%=RevisionCount!=null &&  RevisionCount.size()==0?0:String.valueOf(Integer.parseInt(RevisionCount.get(0)[0].toString())+1) %> )</button>
                                                   <input type="hidden" name="REVCount" value="<%=RevisionCount.size()==0?0:String.valueOf(Integer.parseInt(RevisionCount.get(0)[0].toString())+1)%>" >
                                              
   
                                           
                                           <% if(RevisionCount.size()!=0){ %>
                                         <button type="submit" class="btn btn-sm edit" name="ProjectId" value="<%=ProjectId %>" formaction="ProductTreeRevisionData.htm" formmethod="get">Revision Data</button> 
                                           <input type="hidden" name="revCount" value="<%= RevisionCount!=null && RevisionCount.size()==0?0:String.valueOf(Integer.parseInt(RevisionCount.get(0)[0].toString()))%>" >
                                          <%} %>  
                                          
                                          
                                       <%} %>
                                       
                                      
                                       
                                   </div>

			<div class="col-md-2">
				<label class="control-label">Choose System Name :</label>
			</div>
			<div class="col-md-2 mt-minus-7">
				<select class="form-control selectdee" id="sid" 
					name="sid" onchange="showSystemValue()">
					<option disabled selected value="">Choose...</option>
					<%
					for (Object[] obj : systemList) {
					%>
					<option value="<%=obj[0]%>"  <%if(systemId.equalsIgnoreCase(obj[0].toString())) {%>  selected <%} %>>
					<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%>
					</option>
					<%
					}
					%>
				</select>
			</div>
			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 <input type="hidden" name="ProjectType" value="<%=ProjectType%>">

 </div>
 
</form>


	
	<%---------------------------------------- Main Level -------------------------------------------------%>

<!-- <form  method="GET" action="LevelNameAdd.htm" id="myForm"> -->
	<div class="body genealogy-body bg-white genealogy-scroll">
	
	
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
	
	
	    <div class="genealogy-tree">
	    
	    
	<%--    <% if(ProductTreeList!=null && ProductTreeList.size()>0){ %> 
	     <form action="ProductTreeEditDelete.htm" method="get">
	     
	                <button class="btn btn-sm add" type="submit" name="ProjectId" value="<%=ProjectId%>" >Update / Delete</button> 
		     </form>
		     
		     <%} %> --%>
	        
	  		<ul>
				<li>      
	           
						 <div class="member-view-box action-view-box">
			                    
			                         <div class="action-box" > 
			                         	
			                         	<div  class="action-box-header" >
			                         	
			                         	 <span class="cursor span-font" >
	                          			 <%=ProjectName!=null?StringEscapeUtils.escapeHtml4(ProjectName):"-" %>
			                          		 </span>
			                         			 
										</div>
										
			                           
			                </div>
			          </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	                
			                <% 
			                
			                
			                int count=1;
		                	 //int countA=1;
			                for(Object[] level1 : ProductTreeList){
			                	
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li>	 		    
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
												
												<div class="action-box-header gradient-box <%=statusClass1%> <%=typeClass1%>">
												 
												 
												
										             <span  class="cursor span-font <%=level1[12].toString()%>"    <%if(!level1[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level1[13].toString() %>, <%=level1[10] %>"  <%} %>> 
										           <%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()):"-" %>
										                
										             </span> 
										             
										             
										            
										               <div class="mt-minus-5"><i class="fa fa-caret-down i-col cursor" aria-hidden="true"  ></i></div>
												         
			                          		   </div>
										</div> 
									 
												<div class="actions">
												       <button class="update" onclick="EditModal('<%=level1[0]%>','<%=level1[3]%>','<%=level1[6]%>','<%=level1[7]%>','1','<%=level1[9] %>','<%=level1[10] %>')" ><img src="view/images/edit.png" ></button>
												    <form action="ProductTreeEditDelete.htm"  method="get" class="d-inline">
												         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
													     <input type="hidden" name="Action" value="TD">
													      <input type="hidden" name="initiationId" value="<%=initiationId%>">
													       <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
												<%
													String statusClass2 = "status-default";
													if(level2[6] != null) {
													    String status = level2[6].toString();
													    if(status.equalsIgnoreCase("Design")) statusClass2 = "status-design";
													    else if(status.equalsIgnoreCase("Realisation")) statusClass2 = "status-realisation";
													    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass2 = "status-testing";
													    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass2 = "status-ready";
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
															  <div class="action-box-header gradient-box <%=statusClass2%> <%=typeClass2%>">
															  
															       <span class="cursor span-font <%=level2[12].toString()%>"    <%if(!level2[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level2[13].toString() %>, <%=level2[10] %>"  <%} %>> 
			                          			                              <%=level2[3]!=null?StringEscapeUtils.escapeHtml4(level2[3].toString()):"-" %>
			                          			                   </span>
			                          			                   
			                          			                    <div class="mt-minus-2"><i class="fa fa-caret-down i-col cursor" aria-hidden="true"  ></i></div>
													 
			                          			             </div>
													     </div>
													     
													      
													              <div class="actions">
																	       <button class="update" onclick="EditModal('<%=level2[0]%>','<%=level2[3]%>','<%=level2[6]%>','<%=level2[7]%>','2','<%=level2[9] %>','<%=level2[10] %>')" ><img src="view/images/edit.png" ></button>
																	          <form action="ProductTreeEditDelete.htm"  method="get" class="d-inline">
																		         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																			     <input type="hidden" name="Action" value="TD">
																			      <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
																			      <input type="hidden" name="initiationId" value="<%=initiationId%>">
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
																  <%
																			String statusClass3 = "status-default";
																			if(level3[6] != null) {
																			    String status = level3[6].toString();
																			    if(status.equalsIgnoreCase("Design")) statusClass3 = "status-design";
																			    else if(status.equalsIgnoreCase("Realisation")) statusClass3 = "status-realisation";
																			    else if(status.equalsIgnoreCase("Testing & Evaluation")) statusClass3 = "status-testing";
																			    else if(status.equalsIgnoreCase("Ready for Closure")) statusClass3 = "status-ready";
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
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=statusClass3%> <%=typeClass3%>">							
																		
																		
																		<span  class="cursor span-font <%=level3[12].toString()%>"     <%if(!level3[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level3[13].toString() %>, <%=level3[10] %>"  <%} %>>
			                          			                             
			                          			                                <%=level3[3]!=null?StringEscapeUtils.escapeHtml4(level3[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                            <div class="mt-minus-2"><i class="fa fa-caret-down i-col cursor" aria-hidden="true"></i></div>
													                         			
													                 </div>
													              </div>
													              
													              <div class="actions">
																	       <button class="update" onclick="EditModal('<%=level3[0]%>','<%=level3[3]%>','<%=level3[6]%>','<%=level3[7]%>','3','<%=level3[9]%>','<%=level3[10]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="ProductTreeEditDelete.htm"  method="get" class="d-inline">
																		         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																			     <input type="hidden" name="Action" value="TD">
																			      <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
																			      <input type="hidden" name="initiationId" value="<%=initiationId%>">
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
																  <%
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
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=statusClass4%> <%=typeClass4%>">
																		
																		
																		<span class="cursor span-font <%=level4[12].toString()%>"    <%if(!level4[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level4[13].toString() %>, <%=level4[10] %>"  <%} %>>
			                          			                             
			                          			                                <%=level4[3]!=null?StringEscapeUtils.escapeHtml4(level4[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div class="mt-minus-2"><i class="fa fa-caret-down i-col cursor" aria-hidden="true"  ></i></div>
													
													                     
												                                              			
													                    </div>
													                                            
																</div>
																
																 
													              <div class="actions">
																	       <button class="update" onclick="EditModal('<%=level4[0]%>','<%=level4[3]%>','<%=level4[6]%>','<%=level4[7]%>','4','<%=level4[9]%>','<%=level4[10]%>')" ><img src="view/images/edit.png" ></button>
																	          <form action="ProductTreeEditDelete.htm"  method="get" class="d-inline">
																		         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																			     <input type="hidden" name="Action" value="TD">
																			      <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
																			      <input type="hidden" name="initiationId" value="<%=initiationId%>">
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
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=statusClass5%> <%=typeClass5%>">
																		
																		<span class="cursor span-font <%=level5[12].toString()%>"    <%if(!level5[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level5[13].toString() %>, <%=level5[10] %>"  <%} %>>
			                          			                             
			                          			                                <%=level5[3]!=null?StringEscapeUtils.escapeHtml4(level5[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
													                                <div class="mt-minus-2"><i class="fa fa-caret-down i-col cursor" aria-hidden="true"></i></div> 
													
													                    
												                                              			
													                        </div>
													                        
													                       </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level5[0]%>','<%=level5[3]%>','<%=level5[6]%>','<%=level5[7]%>','5','<%=level5[9]%>','<%=level5[10]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get"  class="d-inline">
																					         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																						     <input type="hidden" name="Action" value="TD">
																						      <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
																						      <input type="hidden" name="initiationId" value="<%=initiationId%>">
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
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=statusClass6%> <%=typeClass6%>">
																		
																		<span  class="cursor span-font <%=level6[12].toString()%>"  <%if(!level6[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level6[13].toString() %>, <%=level6[10] %>"  <%} %>>
			                          			                             
			                          			                                <%=level6[3]!=null?StringEscapeUtils.escapeHtml4(level6[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                           <div class="mt-minus-2"><i class="fa fa-caret-down i-col cursor" aria-hidden="true"></i></div> 
			                          			                            			
													                    </div>
													                        
													                </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level6[0]%>','<%=level6[3]%>','<%=level6[6]%>','<%=level6[7]%>','6','<%=level6[9]%>','<%=level6[10]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get" class="d-inline">
																					         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																						     <input type="hidden" name="Action" value="TD">
																						      <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
																						      <input type="hidden" name="initiationId" value="<%=initiationId%>">
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
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header gradient-box <%=statusClass7%> <%=typeClass7%>">
																		
																		<span class="cursor span-font <%=level7[12].toString()%>" <%if(!level7[13].toString().equals("N")) {%> data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="<%=level7[13].toString() %>, <%=level7[10] %>"  <%} %> >
			                          			                             
			                          			                                <%=level7[3]!=null?StringEscapeUtils.escapeHtml4(level7[3].toString()):"-" %>
			                          			                                
			                          			                          </span>
			                          			                            			
													                    </div>
													                        
													                </div>
													                       
													                        
																              <div class="actions">
																				       <button class="update" onclick="EditModal('<%=level7[0]%>','<%=level7[3]%>','<%=level7[6]%>','<%=level7[7]%>','7','<%=level7[9]%>','<%=level7[10]%>')" ><img src="view/images/edit.png" ></button>
																				          <form action="ProductTreeEditDelete.htm"  method="get" class="d-inline">
																					         <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																						     <input type="hidden" name="Action" value="TD">
																						      <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
																						      <input type="hidden" name="initiationId" value="<%=initiationId%>">
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
															<span class="cursor span-font"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#7#<%=level6[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>.<%=countF%>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													              <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
															<span class="cursor span-font"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#6#<%=level5[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>.<%=countE%>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													              <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
															<span class="cursor span-font"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#5#<%=level4[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>.<%=countD%>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													              <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
															<span class="cursor span-font"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#4#<%=level3[0]%>#<%=count%>.<%=countA%>.<%=countB%>.<%=countC%>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													              <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
															<span class="cursor span-font"> 
															
															<form action="LevelNameAdd.htm" method="get">
													            <input type="text" name="LevelName" required >
													            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#3#<%=level2[0]%>#<%=count%>.<%=countA%>.<%=countB%>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
													              <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
											<span class="cursor span-font"> 
											
											<form action="LevelNameAdd.htm" method="get">
									            <input type="text" name="LevelName" required >
									            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#2#<%=level1[0]%>#<%=count%>.<%=countA%>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									              <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
							<span class="cursor span-font"> 
					            <form action="LevelNameAdd.htm" method="get">
						            <input type="text" name="LevelName" required>
						            <button type="submit" class="btn btn-sm btn-success" name="Split"  value="<%=ProjectId%>#1#0#<%=count %>#<%=initiationId %>" onclick="return confirm('Are You Sure To Submit')"> Add</button>
									           <input type="hidden" name="ProjectType" value="<%=ProjectType!=null?StringEscapeUtils.escapeHtml4(ProjectType):""%>">   
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
        	<table class="w-100" >
        		<tr>
        			<th>Level Name : &nbsp; </th>
        			<td><input type="text" class="form-control" name="LevelName" id="levelname" required></td>
        		</tr>
        		
        		
        		<tr>
        			<th >Stage : &nbsp; </th>
        			<td >
        			
        			<select class="form select selectdee w-100" name="Stage"  id="stage"  >
        			
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
        			
        			<select class="form select selectdee w-100" id="Module" name="Module" >
        					
        			        <option value="In-House-Development">In-House-Development</option>
		      				<option value="BTP">BTP</option>
		      				<option value="BTS">BTS</option>
		      				<option value="COTS">COTS</option>
        			
        			</select>
        			
        			</td>
        		</tr>
        		<tr id="subsystemTr">
        		<th >Sub-Sytem Linked : &nbsp; </th>
        		<td>
        		<select class="form select selectdee w-100" id="subSystem" name="subSystem"  >
        			
        			     
        			
        			</select>
        		</td>
        		</tr>
        		<tr>
        			<td colspan="2" class="text-center">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
        			</td>
        		</tr>
        	</table>
        	
        	<input type="hidden" id="Mainid" name="Mainid" value="" >
        	 <input type="hidden" id="" name="Action" value="TE" > 
        	<input type="hidden" id="" name="ProjectId" value="<%=ProjectId%>" >
            <input type="hidden" name="initiationId" value="<%=initiationId%>">
			 <input type="hidden" name="ProjectType" value="<%=ProjectType%>">
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
	   $('#initiationId').on('change', function() {
	     $('#submit').click();

	   });
	   
	   showSystemValue();
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

  
  function EditModal(mainid,levelname,stage,module,level,sytemid,levelCode)
  {
  	$('#Mainid').val(mainid);			
  	$('#levelname').val(levelname);
  	
  	/* $('select[name="IsSoftware"]').val(IsSoftware).trigger('change');
  	
  	if(IsSoftware==='Y' && IsSoftwareMain==='Y'){
  		$('#issoftwareTr').hide();
  	}else{
  		$('#issoftwareTr').show();
  	} */
  	
    var sid = $('#sid').val();
	  
	  
	  $.ajax({
		  type:'GET',
		  url:'setSystemIdForProject.htm',
		  data:{
			  sid:sid,
			  projectId:<%=ProjectId%>,
			  level:level
		 	 },
	  		datatype:'json',
			success:function (result){
		 	subSyestem =JSON.parse(result)
		 	var html ='<option value="" disabled selected>SELECT</option>';
		 	
		 	for(var i=0;i<subSyestem.length;i++){
		 		html= html+'<option value="'+subSyestem[i][0]+"#"+subSyestem[i][10]+ '">'+subSyestem[i][3]+'( '+subSyestem[i][10]+' )'  +'</option>'
		 	}
			
		 	$('#subSystem').html(html);
	
				$('#subsystemTr').show();
			
				var code = sytemid+"#"+levelCode
				console.log("codeInside"+code)
			  	$('#subSystem').val(code).trigger('change');
		
		}
	  })
  	
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
  
  var subSyestem = [];
  
  
  function showSystemValue(){
	  
	<%--   var sid = $('#sid').val();
	  
	  
	  $.ajax({
		  type:'GET',
		  url:'setSystemIdForProject.htm',
		  data:{
			  sid:sid,
			  projectId:<%=ProjectId%>,
			  level:level
		 	 },
	  		datatype:'json',
			success:function (result){
		 	subSyestem =JSON.parse(result)
				  console.log("Previous --->>>",subSyestem)
		 	var html ='<option value="" disabled selected>SELECT</option>';
		 	
		 	for(var i=0;i<subSyestem.length;i++){
		 		html= html+'<option value="'+subSyestem[i][0]+"#"+subSyestem[i][10]+ '">'+subSyestem[i][3]+'</option>'
		 	}
			
		 	$('#subSystem').html(html);
		}
	  }) --%>
	  
	  
  } 
  
  
</script> 
<script>

function submit(myfrm){
	$('#'+myfrm).submit();
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})

</script>

</body>
</html>






   
   
