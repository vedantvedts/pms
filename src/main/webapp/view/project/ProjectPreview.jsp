<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/dependancy.jsp"></jsp:include>



<title>PROJECT PREVIEW</title>
<style type="text/css">

.container-fluid  {
overflow-x: hidden;
}

.nav-pills-custom .nav-link {
    color: #aaa;
    background: #fff;
    position: relative;
}

.nav-pills-custom .nav-link.active {
    color: #45b649;
    background: #fff;
    border:2px solid #45b649;
}


/* Add indicator arrow for the active tab */
@media (min-width: 992px) {
    .nav-pills-custom .nav-link::before {
        content: '';
        display: block;
        border-top: 8px solid transparent;
        border-left: 10px solid #fff;
        border-bottom: 8px solid transparent;
        position: absolute;
        top: 50%;
        right: -10px;
        transform: translateY(-50%);
        opacity: 0;
        border-color: transparent transparent transparent green;
        
    }
}

.nav-pills-custom .nav-link.active::before {
    opacity: 1;
}

.nav-link{
	font-family: 'Muli',sans-serif;
}

.p-3{
	padding: 2rem !important;
}

/* inside tabs */

p {
    margin: 0px 0px 20px 0px
}

p:last-child {
    margin: 0px
}

a {
    color: #71748d
}

a:hover {
    color: #ff407b;
    text-decoration: none
}

a:active,
a:hover {
    outline: 0;
    text-decoration: none
}

.btn-secondary {
    color: #fff;
    background-color: #ff407b;
    border-color: #ff407b
}

.btn {
    font-size: 14px;
    padding: 9px 16px;
    border-radius: 2px
}

.tab-vertical .nav.nav-tabs {
    float: left;
    display: block;
    margin-right: 0px;
    border-bottom: 0
}

.tab-vertical .nav.nav-tabs .nav-item {
    margin-bottom: 3px
}

.tab-vertical .nav-tabs .nav-link {
    border: 1px solid transparent;
    border-top-left-radius: .25rem;
    border-top-right-radius: .25rem;
    background: #fff;
    padding: 6px 13px;
    color: #71748d;
    background-color: #dddde8;
    -webkit-border-radius: 4px 0px 0px 4px;
    -moz-border-radius: 4px 0px 0px 4px;
    border-radius: 4px 0px 0px 4px
}

.tab-vertical .nav-tabs .nav-link.active {
    color: white;
    background-color: #055C9D !important;
    border-color: transparent !important
}

.tab-vertical .nav-tabs .nav-link {
    border: 1px solid transparent;
    border-top-left-radius: 4px !important;
    border-top-right-radius: 0px !important
}

.tab-vertical .tab-content {
    overflow: auto;
    -webkit-border-radius: 0px 4px 4px 4px;
    -moz-border-radius: 0px 4px 4px 4px;
    border-radius: 0px 4px 4px 4px;
    background: aliceblue;
    padding: 30px;
    font-size: 17px;
}


/* initiation */

.column{
	padding: 10px;
}

.tab-pane p{
	text-align: justify;
}

.tab-pane {
	min-height: 27rem !important;
}



.custom_width{
	padding: 1rem 1rem !important;
	width: 83%;
}

.b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}
body{
	margin-top: 1rem;
	background-color: #e2ebf0;
}

</style>
</head>
<body>

<%

Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailsPreview");  
/* Object[] ProjectDetailes=ProjectDetaileslist.get(0); */
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");  
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList"); 
List<Object[]> CostList=(List<Object[]>)request.getAttribute("CostList"); 
List<Object[]> IntiationAttachment=(List<Object[]>)request.getAttribute("IntiationAttachment"); 
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> AuthorityAttachments=(List<Object[]>)request.getAttribute("AuthorityAttachment");  


%>



<section class="header">
    <div class="container-fluid">
     
     	 <header class=" pb-1">
     	 
     	 <%if(ProjectDetailes[16]!=null){%><%if(ProjectDetailes[16].toString().equalsIgnoreCase("N")) {%>
     	 
     	 	            <h4>Project Title : <%if(ProjectDetailes[7]!=null){%><%=ProjectDetailes[6] %><%}else{ %>-<%} %><span style="float: right"><%if(ProjectDetailes[16]!=null){%><%if(ProjectDetailes[16].toString().equalsIgnoreCase("N")) {%>Main Project : <%=ProjectDetailes[17]%><%}}else{ %>-<%} %></span> </h4>
     	 	
     	 <%} else{%>
     	 
     	 		<h4>Project Title : <%if(ProjectDetailes[7]!=null){%><%=ProjectDetailes[7] %> (<%=ProjectDetailes[6] %>)<%}else{ %>-<%} %><span style="float: right"><%if(ProjectDetailes[16]!=null){%><%if(ProjectDetailes[16].toString().equalsIgnoreCase("N")) {%>Main Project : <%=ProjectDetailes[17]%><%}}else{ %>-<%} %></span> </h4>
     	 				
     	 <%} }%>
     	 
        </header> 
     	
        <div class="row">
            <div class="col-md-2">
                <!-- Tabs nav -->
                <div class="nav flex-column nav-pills nav-pills-custom" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <a class="nav-link mb-3 shadow active custom_width" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
                        <i class="fa fa-user-circle-o mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Initiation</span></a>

					 <a class="nav-link mb-3 shadow custom_width" id="v-pills-authority-tab" data-toggle="pill" href="#v-pills-authority" role="tab" aria-controls="v-pills-authority" aria-selected="false">
                        <i class="fa fa-id-badge mr-2" ></i>
                        <span class="font-weight-bold large text-uppercase">Authority</span></a>

                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">
                        <i class="fa fa-check mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Details</span></a>

                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">
                        <i class="fa fa-star mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Cost</span></a>

                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">
                        <i class="fa fa-calendar-minus-o mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Schedule</span></a>
                     
                    <a class="nav-link mb-3 shadow custom_width" id="v-pills-attachment-tab" data-toggle="pill" href="#v-pills-attachment" role="tab" aria-controls="v-pills-attachment" aria-selected="false">
                        <i class="fa fa-paperclip mr-2"></i>
                        <span class="font-weight-bold large text-uppercase">Attachment</span></a>    
                        
                     <a class="nav-link mb-3 shadow custom_width" id="v-pills-prints-tab" data-toggle="pill" href="#v-pills-prints" role="tab" aria-controls="v-pills-prints" aria-selected="false">
                        <i class="fa fa-print mr-2" aria-hidden="true"></i>
                        <span class="font-weight-bold large text-uppercase">Prints</span></a>   

                    </div>
            </div>


            <div class="col-md-10">
                <!-- Tabs content -->
                <div class="tab-content" id="v-pills-tabContent" style="margin-left: -4%">
                
                
 <!--  **** INITIATION *********************     -->               
                
                
                    <div class="tab-pane fade shadow rounded bg-white show active p-3" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                        <!-- <h4 class="font-italic mb-4">Initiation</h4> -->
                        
                        <div class="row" >
	 		
			 			
			 			
			 			<div class="col-md-12" style="margin-left: 43px">
			 			
							<div class="row details">
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;border-top-left-radius: 5px">
							    <h6>Project/Programme</h6>
							    <p><%if(ProjectDetailes[3]!=null){ if(ProjectDetailes[3].toString().equalsIgnoreCase("PRJ")){%> Project <%}if(ProjectDetailes[3].toString().equalsIgnoreCase("PGM")){ %>Program <% } }else{ %>-<%} %></p>
							  </div>
							   <div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Category</h6>
							    <p><%if(ProjectDetailes[4]!=null){%><%=ProjectDetailes[4] %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Security Classification</h6>
							    <p><%if(ProjectDetailes[5]!=null){%><%=ProjectDetailes[5] %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column b" style="width:23%;border-bottom: 2px solid #394989;border-top-right-radius: 5px">
							    <h6>Planned</h6>
							    <p><%if(ProjectDetailes[10]!=null){ if(ProjectDetailes[10].toString().equalsIgnoreCase("P")){%>Plan<%}if(ProjectDetailes[10].toString().equalsIgnoreCase("N")){%>Non-Plan<%}}else{ %>-<%} %></p>
							  </div>
							</div>
							
							<div class="row details">
								<div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
								    <h6>Short Name</h6>
								    <p><%if(ProjectDetailes[6]!=null){%><%=ProjectDetailes[6] %><%}else{ %>-<%} %></p>
							  	</div>
								
								<div class="column a" style="width:69%;border-bottom: 2px solid #394989;">
								    <h6>Title</h6>
								    <p><%if(ProjectDetailes[7]!=null){%><%=ProjectDetailes[7] %><%}else{ %>-<%} %></p>
							  	</div>		
							</div>
							
							<div class="row details">
							  <div class="column a" style="width:23%;border-bottom: 4px solid #394989;border-bottom-left-radius: 5px">
							    <h6>Deliverable</h6>
							    <p><%if(ProjectDetailes[12]!=null){%>	<%=ProjectDetailes[12] %><%}else{ %>-<%} %></p>
							  </div>
							   <div class="column b" style="width:23%;border-bottom: 4px solid #394989;">
							    <div class="row">
							   		<div class="col">
							   			<h6>Fe Cost</h6>
							    	<p><%if(ProjectDetailes[14]!=null){%> &#8377; <%=ProjectDetailes[14] %><%}else{ %>-<%} %></p>
							   	</div>
							   	<div class="col">
							   			<h6>Re Cost</h6>
							    	<p><%if(ProjectDetailes[15]!=null){%> &#8377; <%=ProjectDetailes[15] %><%}else{ %>-<%} %></p>
							   	</div>
							   </div>
							  </div>
							  <div class="column a" style="width:23%;border-bottom: 4px solid #394989;">
							    <h6>Duration (Months)</h6>
							    <p><%if(ProjectDetailes[9]!=null){%><%=ProjectDetailes[9] %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column b" style="width:23%;border-bottom: 4px solid #394989;border-bottom-right-radius: 5px">
							    <h6>Multi Lab</h6>
							    <p><%if(ProjectDetailes[11]!=null){ if(ProjectDetailes[11].toString().equalsIgnoreCase("Y")){%>
							    	Yes 
							    	<%}if(ProjectDetailes[11].toString().equalsIgnoreCase("N")){%>No<%}}else{ %>-<%} %></p>
							  </div>
							</div>
			 		
			 			</div>
			 			
			 		
			 			
	 			</div>
                        
      		</div>
                    
                    
<!-- ********************AUTHORITY*********************************************** -->               
                    
                 
                <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-authority" role="tabpanel" aria-labelledby="v-pills-authority-tab">

                        <div class="row" >
	 		
			 			<%for(Object[] AuthorityAttachment : AuthorityAttachments ){ %>
			 			
			 			<div class="col-md-12" style="margin-left: 43px">
			 			
							<div class="row details">
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;border-top-left-radius: 5px">
							    <h6>Authority Name</h6>
							    <p><%if(AuthorityAttachment[6]!=null){%> <%=AuthorityAttachment[6] %> <%}else{ %> - <%}%></p>
							  </div>
							   <div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Letter Date</h6>
							    <p><%if(AuthorityAttachment[3]!=null){%><%=sdf.format(AuthorityAttachment[3]) %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Letter Number</h6>
							    <p><%if(AuthorityAttachment[4]!=null){%> <%=AuthorityAttachment[4] %> <%}else{ %> - <%}%></p>
							  </div>
							   <div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Letter</h6>
 										<a  href="ProjectAuthorityDownload.htm?AuthorityFileId=<%=AuthorityAttachment[7] %>" target="_blank"><i class="fa fa-download fa-2x" style="padding: 0px 25px; margin-top: 5px"></i>
				                    </a>							 
				                </div>
							
							  
							</div>

			 			</div>
			 			
			 			<%} %>
	
	 			</div>
                        
      		</div>   
                         
                    
                    
<!--  **** DETAILS *********************     -->
                    
                    <div class="tab-pane fade shadow rounded bg-white p-2" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                        <!-- <h4 class="font-italic mb-4">Details</h4> -->
                        
                        
                        
                        <div class="container " style="margin: 0px !important;padding: 0px !important">
						    <div class="col">
						    
						        <div class="tab-vertical">
						            <ul class="nav nav-tabs" id="myTab3" role="tablist">
						            	<li class="nav-item"> <a class="nav-link active" id="needofprj-vertical-tab" data-toggle="tab" href="#needofprj-vertical" role="tab" aria-controls="contact" aria-selected="false">Need Of Project</a> </li>
						                <li class="nav-item"> <a class="nav-link " id="req-vertical-tab" data-toggle="tab" href="#req-vertical" role="tab" aria-controls="home" aria-selected="true">Requirement</a> </li>
						                <li class="nav-item"> <a class="nav-link " id="worldscenario-vertical-tab" data-toggle="tab" href="#worldscenario-vertical" role="tab" aria-controls="home" aria-selected="true">World Scenario</a> </li>
						                <li class="nav-item"> <a class="nav-link" id="obj-vertical-tab" data-toggle="tab" href="#obj-vertical" role="tab" aria-controls="profile" aria-selected="false">Objective</a> </li>
						                <li class="nav-item"> <a class="nav-link" id="scope-vertical-tab" data-toggle="tab" href="#scope-vertical" role="tab" aria-controls="contact" aria-selected="false">Scope</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="multilab-vertical-tab" data-toggle="tab" href="#multilab-vertical" role="tab" aria-controls="contact" aria-selected="false">Multi Lab Work Share</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="earlierwork-vertical-tab" data-toggle="tab" href="#earlierwork-vertical" role="tab" aria-controls="contact" aria-selected="false">Earlier Work</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="competency-vertical-tab" data-toggle="tab" href="#competency-vertical" role="tab" aria-controls="contact" aria-selected="false">Competency Established</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="technology-vertical-tab" data-toggle="tab" href="#technology-vertical" role="tab" aria-controls="contact" aria-selected="false">Technology Challenges</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="risk-vertical-tab" data-toggle="tab" href="#risk-vertical" role="tab" aria-controls="contact" aria-selected="false">Risk Mitigation</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="proposal-vertical-tab" data-toggle="tab" href="#proposal-vertical" role="tab" aria-controls="contact" aria-selected="false">Proposal</a> </li>
						            	<li class="nav-item"> <a class="nav-link" id="realization-vertical-tab" data-toggle="tab" href="#realization-vertical" role="tab" aria-controls="contact" aria-selected="false">Realization Plan</a> </li> 
						            </ul>
						            
						            <%for(Object[] 	obj:DetailsList){ %>
						            
						            <div class="tab-content" id="myTabContent3">
						            	<div class="tab-pane fade " id="worldscenario-vertical" role="tabpanel" aria-labelledby="worldscenario-vertical-tab">
						                    <h3>World Scenario</h3>
						                    <p><%if(obj[12]!=null){%><%=obj[12] %><%}else{ %>-<%} %></p>
						                </div>
						                <div class="tab-pane fade " id="req-vertical" role="tabpanel" aria-labelledby="req-vertical-tab">
						                    <h3>Requirement</h3>
						                    <p><%if(obj[0]!=null){%><%=obj[0] %><%}else{ %>-<%} %></p>
						                </div>
						                <div class="tab-pane fade" id="obj-vertical" role="tabpanel" aria-labelledby="obj-vertical-tab">
						                    <h3>Objective</h3>
											<p><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="scope-vertical" role="tabpanel" aria-labelledby="scope-vertical-tab">
						                    <h3>Scope</h3>
											<p><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="multilab-vertical" role="tabpanel" aria-labelledby="multilab-vertical-tab">
						                    <h3>Multi Lab Work Share</h3>
											<p><%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="earlierwork-vertical" role="tabpanel" aria-labelledby="earlierwork-vertical-tab">
						                    <h3>Earlier Work</h3>
											<p><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="competency-vertical" role="tabpanel" aria-labelledby="competency-vertical-tab">
						                    <h3>Competency Established</h3>
											<p><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade show active" id="needofprj-vertical" role="tabpanel" aria-labelledby="needofprj-vertical-tab">
						                    <h3>Need Of Project</h3>
											<p><%if(obj[6]!=null){%><%=obj[6] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="technology-vertical" role="tabpanel" aria-labelledby="technology-vertical-tab">
						                    <h3>Technology Challenges</h3>
											<p><%if(obj[7]!=null){%><%=obj[7] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="risk-vertical" role="tabpanel" aria-labelledby="risk-vertical-tab">
						                    <h3>Risk Mitigation</h3>
											<p><%if(obj[8]!=null){%><%=obj[8] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="proposal-vertical" role="tabpanel" aria-labelledby="proposal-vertical-tab">
						                    <h3>Proposal</h3>
											<p><%if(obj[9]!=null){%><%=obj[9] %><%}else{ %>-<%} %></p>						                
										</div>
						                <div class="tab-pane fade" id="realization-vertical" role="tabpanel" aria-labelledby="realization-vertical-tab">
						                    <h3>Realization Plan</h3>
											<p><%if(obj[10]!=null){%><%=obj[10] %><%}else{ %>-<%} %></p>						                
										</div>
						            </div>
						            
						            <%} %>
						            
						        </div>
						        
						    </div>
						</div>    
                    </div>
                    
                    
 <!--  **** COST *********************     -->                   
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                       <!--  <h4 class="font-italic mb-4">Cost</h4> -->
                        
                        <div class="row">
				        <div class="col-12">
				            <div class="card">
				               
				                <div class="table-responsive">
				                    <table class="table">
				                        <thead class="thead" style="color:white!important;background-color: #055C9D">
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox m-b-20"> <input type="checkbox" id="mainCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                            <th scope="col" >Budget Head</th>
				                                <th scope="col">Head of Accounts</th>
				                                <th scope="col">Item Detail</th>
				                                <th scope="col">Item Cost (In Lakhs)</th>
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:CostList){ %>
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox"> <input type="checkbox" class="listCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                                     
				                                <td><%if(obj[0]!=null){%><%=obj[0] %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
				                                <td class="right">&#8377; <%if(obj[3]!=null && Double.parseDouble(obj[3].toString())>0){%><%=Double.parseDouble(obj[3].toString())/100000 %> Lakhs<%}else{ %>0.00<%} %></td>
				                    
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                </div>
				            </div>
				        </div>
				    </div>

                    </div>
                    
                    
     <!--  **** SCHEDULE *********************     -->           
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                       <!--  <h4 class="font-italic mb-4">Schedule</h4> -->
                        
                        <div class="row">
				        <div class="col-12">
				            <div class="card">
				               
				                <div class="table-responsive">
				                    <table class="table">
				                        <thead class="thead" style="color:white!important;background-color: #055C9D">
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox m-b-20"> <input type="checkbox" id="mainCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                            <th scope="col" class="center">Milestone No</th>
				                                <th scope="col">Milestone Activity</th>
				                                <th scope="col" class="center">Milestone Month</th>
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:ScheduleList){ %>
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox"> <input type="checkbox" class="listCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                                     
				                                <td class="center"><%if(obj[0]!=null){%><%=obj[0] %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></td>
				                                <td class="center"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
				                    
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                </div>
				            </div>
				        </div>
				    </div>
                        
                        
                    </div>
                    
         
         <!-- ********* ATTACHMENT *****************  -->           
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-attachment" role="tabpanel" aria-labelledby="v-pills-attachment-tab">
                       <!--  <h4 class="font-italic mb-4">Schedule</h4> -->
                        
                        <div class="row">
				        <div class="col-12">
				            <div class="card">
				               
				                <div class="table-responsive">
				                    <table class="table">
				                        <thead class="thead" style="color:white!important;background-color: #055C9D">
				                            <tr>
				                            <th scope="col" >File Name</th>
				                            <th scope="col" >Created By</th>
				                            <th scope="col" >Created Date</th>
				                            <th class="center" scope="col">Download</th>
				                            
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:IntiationAttachment){ %>
				                            <tr>
				                                     
				                                <td class="left"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></td>
				                                <td class="left"><%if(obj[5]!=null){%><%=sdf1.format(obj[5]) %><%}else{ %>-<%} %></td>
				                    			 <td class="center"><div ><a  href="ProjectAttachDownload.htm?InitiationAttachmentId=<%=obj[6]%>" target="_blank"><i class="fa fa-download"></i></a></div> </td>	
				                    			
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                </div>
				               
				            </div>
		
				        </div>
				    </div>
                        
                        
                    </div>
                    
                   
                     <!-- ********* PRINTS *****************  -->  
                    
                    
                    <div class="tab-pane fade shadow rounded bg-white p-3" id="v-pills-prints" role="tabpanel" aria-labelledby="v-pills-print-tab">

                        <div class="row">
				        <div class="col-12">
				         
				                <form action="" method="POST" name="myfrm" id="myfrm">
				                
				                	<button type="submit" class="btn btn-warning btn-sm prints" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
							 
							 		<button type="submit" class="btn btn-warning btn-sm prints" formaction="ProjectProposalDownload.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;
				                
				                	<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
				                	
				                	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				                	
				                </form>
		
				        </div>
				    </div>
                        
                        
                    </div>
                    
                    
                    
                    
                    
                    
                </div>
            </div>
        </div>
    </div>
</section>


</body>
</html>