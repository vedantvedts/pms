<%@page import="java.text.DecimalFormat"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosure"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureCheckList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.project.model.ProjectMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectdetails.css" var="projetdetailscss" />
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<link href="${projetdetailscss}" rel="stylesheet" />

<style type="text/css">

.tab-pane p{
	text-align: justify;
	
}

.card-body{
	padding: 0rem !important;
}
.navigation_btn{
	margin: 1%;
}

.checklistpage {

   margin: 1%;

}
 .b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}

.nav-link{
	text-align: left;
}
.nav-tabs>.nav-item>.nav-link{
	padding: 11px 15px !important;
}
body { 
   font-family : "Lato", Arial, sans-serif !important;
   overflow-x: hidden;
}

input,select,table,div,label,span {
font-family : "Lato", Arial, sans-serif !important;
}
.text-center{
	text-align: left !imporatant;
}

.control-label,.mandatory{
float: left;
font-weight: bold;
font-size: 1rem;
}
.control-label{
color: purple;
}
</style>

<style type="text/css">

.panel-info {
	border-color: #bce8f1;
}
.panel {
	margin-bottom: 10px;
	background-color: #fff;
	border: 1px solid transparent;
	border-radius: 4px;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}
.panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
	color: #1d5987;
}
.panel-title {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 13px;
	color: inherit;
	font-weight: bold;
	display: contents;
}
.buttonEd {
	float: right;
	margin-top: -0.5rem;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

div {
	display: block;
}


.olre-body .panel-info .panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-heading {
	padding: 18px 15px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.p-5 {
	padding: 5px;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

user agent stylesheet
div {
	display: block;
}

.panel-info {
	border-color: #bce8f1;
}

.rsqr-column{
 float : left;
}

.scrollclass::-webkit-scrollbar {
    width:7px;
}
.scrollclass::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
.scrollclass::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
.scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}


.trup{
	padding:6px 10px 6px 10px ;			
	border-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}
.trdown{
	padding:0px 10px 5px 10px ;			
	border-bottom-left-radius : 5px; 
	border-bottom-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}



p
{
	text-align: justify !important;
  	text-justify: inter-word;
}
p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}

.textunderline{
	text-decoration: underline;
}


</style>

<style type="text/css">
.input-group-text{
font-weight: bold;
}

label{
	/* font-weight: 800; */
	font-size: 16px;
	/* color:#07689f; */
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}

</style>

<style type="text/css">

#tabledata{
 margin-left : 30px;
 border-collapse : collapse;
 /* border : 1px solid black; */
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
}
#tabledata td{
 text-align : left;
 vertical-align: top;
 word-wrap: break-word;
 word-break: normal;
}
#tabledata td,th{
 /* border : 1px solid black; */
 padding : 5px;
}

#select2-LabCode-container,#select2-approverEmpId-container{
	text-align: left;
}
</style>
</head>
<body>

<%

ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
ProjectClosure closure = (ProjectClosure)request.getAttribute("ProjectClosureDetails");
ProjectClosureCheckList chlist = (ProjectClosureCheckList)request.getAttribute("ProjectClosureCheckListData");

Object[] potherdetails = (Object[])request.getAttribute("ProjectOriginalRevDetails");
Object[] expndDetails = (Object[])request.getAttribute("ProjectExpenditureDetails");



List<Object[]> labList = (List<Object[]>)request.getAttribute("LabList");

String chlistTabId = (String)request.getAttribute("chlistTabId");
String checklistId = (String)request.getAttribute("checklistId");
String closureId=(String)request.getAttribute("closureId");
String isApproval = (String)request.getAttribute("isApproval");

List<String> chlistforward = Arrays.asList("SIN","SRG","SRA","SRP","SRD","SRC","SRV");

List<String> closurecategory = Arrays.asList("Completed Successfully","Partial Success","Stage Closure","Cancellation");
List<String> dmcdirection = Arrays.asList("Recommended","Not Recommended","Not Applicable");

Object[] Director = (Object[])request.getAttribute("Director");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] AD = (Object[])request.getAttribute("AD");
Object[] GD = (Object[])request.getAttribute("GDDetails");
Object[] PDData = (Object[])request.getAttribute("PDData");
Object[] emp = (Object[])request.getAttribute("EmpData");


String labcode = (String)session.getAttribute("labcode");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

DecimalFormat df = new DecimalFormat("#.####");
df.setMinimumFractionDigits(4); 
String statuscode = closure!=null?closure.getClosureStatusCode():null;
%>

<% String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

<div class="container-fluid">
	<div class="row">
   		<div class="col-md-12">
       		<div class="card slider">
       			<!-- This is for Slider Headers -->
         		<div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 0%;">
             		<h4 class="category">Project Closure Check List - <%if(projectMaster!=null) {%><%=projectMaster.getProjectShortName()+" ("+projectMaster.getProjectCode()+")" %> <%} %>

             			<a class="btn btn-info btn-sm  shadow-nohover back"
             				<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y") ) {%>
               					href="ProjectClosureApprovals.htm"
               				<%} else if(isApproval!=null &&  isApproval.equalsIgnoreCase("N") ) {%>
               					href="ProjectClosureApprovals.htm?val=app"
               				<%} else{%> 
               					href="ProjectClosureList.htm"
               				<%} %>
             		
             			  style="color: white!important;float: right;">Back</a>
             		</h4>
             		<hr style="margin: -8px 0px !important;">
             		<ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >

            			<li class="nav-item" id="nav-chlistdetails">
             				<%if(chlistTabId!=null && chlistTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#chlistdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#chlistdetails" role="tab">
               				<%} %>  
               					
                	         	Check List
              			 		</a>
            			</li>

            			<%-- <li class="nav-item" id="nav-chlistforward">
            	     		<%if(chlistTabId!=null && chlistTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#chlistforward" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#chlistforward" role="tab" >
               				<%} %>
                  				Check List Forward
              					</a>
            			</li> --%>
            			
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center" style="margin-top : 0.2rem;">
         				<!-- *********** checklist Details ***********      --> 
               			<%if(chlistTabId!=null && chlistTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="chlistdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="chlistdetails" role="tabpanel">
               			<%} %>
               					<div class="container">
									<div class="row" style="width: 140%; margin-left: -15rem;margin-top: 1rem;">
										<div class="col-md-12">
											<div class="card shadow-nohover" >
											<form>
												<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
								                    <b class="text-white" style="">Check List Details : 
								                    <button type="submit" class="btn btn-sm" style="" name="closureId" formmethod="get" formnovalidate="formnovalidate"
                  					 		  				 	value="<%=closureId %>" formaction="ProjectClosureCheckListDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="CheckList Download">
                  					 							<i class="fa fa-download fa-lg"></i>
                  					 						</button>
                  					 						</b> 
								                    <hr>
								                    <span class="text-white" style="float:right;font-weight: 600"> </span>
							        			</div> 
							        	</form>	
							        		
												<div class="card-body" style="overflow:auto;max-height:25rem;">
								        		
								        		
								        		<div class="" id="firstpage" >
													<form action="ProjectClosureCheckListDetailsSubmit.htm" method="POST" enctype="multipart/form-data" id="firstpagesubmit">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="closureId" value="<%=closureId%>">
												    	
												     	
												    	 <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">1. Project Appraisal Letter (QAR)</label>
												                    
												                </div>
												            </div>
												            
												    	<br>
												    	<br>
												    	
												  
												   
												    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
												    		
												        	<div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Sent by the Lab to HQrs :</label><span class="mandatory">*</span>
												                    <input  class="form-control form-control" type="text" name="QARHQrsSentDate" id="HQrsSentDate" 
												                     value="<%if(chlist!=null && chlist.getQARHQrsSentDate()!=null) {%><%=chlist.getQARHQrsSentDate() %><%} %>" > 
												                </div>
												            </div>
												            
												            <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">When sent to the CFA :</label><span class="mandatory">*</span>
												                	 <input  class="form-control form-control" type="text" name="QARSentDate" id="CFASendDate"  
												                     value="<%if(chlist!=null && chlist.getQARSentDate()!=null) {%><%=chlist.getQARSentDate() %><%} %>" > 
												                    
												                </div>
												            </div>
												            
												            <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label">Objective  of the  Project mentioned in the QAR :</label><span class="mandatory">*</span>
												                	 <input  class="form-control form-control" type="text" name="QARObjective" placeholder="Enter Objective  of the  Project mentioned in the QAR" 
												                     value="<%if(chlist!=null && chlist.getQARObjective()!=null) {%><%=chlist.getQARObjective() %><%} %>" > 
												                   
												                </div>
												            </div>
												            
												            
												            
												            <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label">Milestones :</label><span class="mandatory">*</span>
												                	<%if(chlist!=null && chlist.getQARMilestone()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="QARMilestonefile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="QARMilestone Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="QARMilestone" <%if(chlist==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												            
												        </div>
												        
												        
												   <div class="row" style="margin-left: 2%;margin-right: 2%;">
												        
												        
												        <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">PDC</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="QARPDCDate" id="PDCDate"
												                     value="<%if(chlist!=null && chlist.getQARPDCDate()!=null) {%><%=fc.SqlToRegularDate(chlist.getQARPDCDate()) %><%} %>" > 
												                </div>
												            </div>
												            
												           <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Proposed Cost</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="QARProposedCost" id="ProposedDate" 
												                     value="<%if(chlist!=null && chlist.getQARProposedCost()!=null) {%><%=fc.SqlToRegularDate(chlist.getQARProposedCost()) %><%} %>" > 
												                </div>
												            </div> 
												            
												            
												            <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label">Cost Break-up (Activity wise, Period wise) </label><span class="mandatory">*</span>
												                   <%if(chlist!=null && chlist.getQARCostBreakup()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="QARCostBreakupfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="QARCostBreakup" <%if(chlist==null) {%>required<%} %> accept=".pdf">
												                   
												                </div>
												            </div>
												            
												            <div class="col-md-5" style="">
												        		<div class="form-group">
												                	<label class="control-label">List of non-consumable items required (at least costing more than Rs. 10 lakhs) </label><span class="mandatory">*</span>
												                   <%if(chlist!=null && chlist.getQARNCItems()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="QARNCItemsfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="QARNCItems" <%if(chlist==null) {%>required<%} %> accept=".pdf">
												                   
												                </div>
												            </div>
												            
												     </div>
												        
												    <hr>
												        
												       <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">2. Revision in sanctioned cost if any</label>
												                    
												                </div>
												            </div>
												         <br>
												         <br>  
												          
												      <div class="row" style="margin-left: 2%;margin-right: 2%;">      
												          <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">When requested</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="SCRequested" id="SCRequested" placeholder="Enter Requested Date" 
												                     value="<%if(chlist!=null && chlist.getSCRequested()!=null) {%><%=fc.SqlToRegularDate(chlist.getSCRequested()) %><%} %>" > 
												                </div>
												            </div> 
												            
												             <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">When granted</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="SCGranted" id="SCGranted" placeholder="Enter Granted Date" 
												                     value="<%if(chlist!=null && chlist.getSCGranted()!=null) {%><%=fc.SqlToRegularDate(chlist.getSCGranted()) %><%} %>" > 
												                </div>
												            </div> 
												            
												            
												            
												             <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">How much/ revised cost</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="SCRevisionCost" id="" placeholder="Enter Revision Cost" 
												                     value="<%if(chlist!=null && chlist.getSCRevisionCost()>=0){%><%=chlist.getSCRevisionCost() %><%} %>" >
												                </div>
												            </div> 
												            
												            
												              <div class="col-md-5" style="">
												        		<div class="form-group">
												                	<label class="control-label">Any reason specified</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="SCReason" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" ><%if(chlist!=null && chlist.getSCReason()!=null){ %><%=chlist.getSCReason() %><%} %></textarea>  
												                </div>
												            </div> 
												            
												          </div>  
												          
												          <hr>
												          
												          
												           <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">3. Revision in PDC if any</label>
												                    
												                </div>
												            </div>
												           
												         <br>
												         <br>   
												            
												          
												          <div class="row" style="margin-left: 2%;margin-right: 2%;">      
												          <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">When requested</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="PDCRequested" id="PDCRequested"
												                     value="<%if(chlist!=null && chlist.getPDCRequested()!=null) {%><%=fc.SqlToRegularDate(chlist.getPDCRequested()) %><%} %>" > 
												                </div>
												            </div> 
												            
												             <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">When granted</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="PDCGranted" id="PDCGranted" 
												                     value="<%if(chlist!=null && chlist.getPDCGranted()!=null) {%><%=fc.SqlToRegularDate(chlist.getPDCGranted()) %><%} %>" > 
												                </div>
												            </div> 
												            
												            
												            
												             <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Quantum/ revised PDC</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="PDCRevised" id="" placeholder="Enter revised PDC" 
												                     value="<%if(chlist!=null && chlist.getPDCRevised()>0) {%><%=chlist.getPDCRevised() %><%} %>" > 
												                </div>
												            </div> 
												            
												            
												              <div class="col-md-5" style="">
												        		<div class="form-group">
												                	<label class="control-label">Any reason specified</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="PDCReason" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" ><%if(chlist!=null && chlist.getPDCReason()!=null){ %><%=chlist.getPDCReason() %><%} %></textarea>  
												                </div>
												            </div>
												             
												           </div> 
												          
												          
												        <hr>
												          
												          
												      <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">4. Project Register</label>
												                    
												                </div>
												            </div>
												           
												         <br>
												              
												          
												     <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												          <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label">Maintained in proper format</label><span class="mandatory">*</span>
												                    <input value="Yes" name="PRMaintained"  type="checkbox"  <% if(chlist!=null &&  chlist.getPRMaintained() !=null && chlist.getPRMaintained().equalsIgnoreCase("Yes")){ %> checked <%} %>  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												            </div> 
												            
												            
												              <div class="col-md-5" style="">
												        		<div class="form-group">
												                	<label class="control-label">Sanctioned projects entered (including sub-projects)</label><span class="mandatory">*</span>
												                    <input value="Yes" name="PRSanctioned"  type="checkbox"  <% if(chlist!=null &&  chlist.getPRSanctioned() !=null && chlist.getPRSanctioned().equalsIgnoreCase("Yes")){ %> checked <%} %> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												            </div> 
												        </div>     
												        
												       
												 <hr>
												       
												    <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">5. Project expenditure Card</label>
												                    
												                </div>
												            </div>
												           
												         <br> 
												      
												       <div class="row" style="margin-left: 2%;margin-right: 2%;"> 
												               
												          <div class="col-md-5" style="">
												        		<div class="form-group">
												                	<label class="control-label">Expenditure verified by Project Director/ In-charge</label><span class="mandatory">*</span>
												                    <input value="Yes" name="PECVerified"  type="checkbox"   <% if(chlist!=null &&  chlist.getPECVerified() !=null && chlist.getPECVerified().equalsIgnoreCase("Yes")){ %> checked <%} %> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												            </div> 
												            
												        </div> 
												        
												         <div class="checklistpage"  style="text-align: center;">
												        
												        <% if(chlist!=null && chlist.getQARObjective()!=null) { %>
												        
            							                         <button class="btn-warning edit btn" type="submit" id="firstpagechange" name="Action" value="Edit" onclick="return confirm('Are You Sure To Update')">UPDATE</button>
            							                    
            							                    
            							                    <%}else{ %>
            							                    
            							                        <button class="btn btn-info btn-sm success submit" type="submit" id="firstpagechange" name="Action" value="Add" onclick="return confirm('Are You Sure To Submit')">SUBMIT</button>
            							                        
            							                    
            							                    <%} %>
														</div> 
											<!-- </form> --> 
											   
												   
												   <div class="pagin" style="display: flex; justify-content: right;padding-bottom:10px;"> 
																
																	
																	<div class="pagination">
																			<div class="page-item">
																				
																					<input class="page-link" type="submit"  value="Previous" />
																					
																						<input type="hidden" value="" name="search" />
																					
																					<input type="hidden" id="pagination" name="pagination" value="" />
																				
																			</div>
																			<div class="page-item">
																				<input class="page-link" type="button" value="1" disabled/>
																			</div>
																			<div class="page-item">
																				
																					   <button type="button" class="page-link" id="firstpagechanges" >Next</button>
																						<!-- <input type="hidden" name="pagination" value=/> -->
																				
																			</div>
																		</div>
																 </div>  
												    
												    </div>	
												    
												    
												    
											  <div class="" id="secondpage">	    
												    <!--  <form action="ProjectClosureCheckListDetailsSubmit.htm" method="POST" enctype="multipart/form-data">  -->
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="closureId" value="<%=closureId%>">
												   
												         
												  
												            <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">6. Subsidiary register</label>
												                    
												                </div>
												            </div> 
												            
												            <br>
												          
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												          <div class="col-md-5" style="">
												        		<div class="form-group">
												                	<label class="control-label">Maintained Properly</label><span class="mandatory">*</span>
												                    <input value="Yes" name="SRMaintained"  type="checkbox"   <% if(chlist!=null &&  chlist.getSRMaintained() !=null && chlist.getSRMaintained().equalsIgnoreCase("Yes")){ %> checked <%} %>  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												            </div> 
												            
												        </div>
												        
												        <hr>
												        
												        
												        <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">7. Procurement/ Accounting Procedure (consumable Stores)</label>
												                    
												                </div>
												            </div> 
												        <br>
												        <br>
												        
												      <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												          <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Procedure followed </label><span class="mandatory">*</span>
												                    <select name="CSProcedure"  class="form-control" data-width="100%" data-live-search="true"  id="select1" required>
			                											<option value="0" disabled="disabled" selected="selected">--Select--</option>
												               			
												               			<option value="PurchasedDirectly" <%if(chlist!=null && chlist.getCSProcedure()!=null && chlist.getCSProcedure().equalsIgnoreCase("PurchasedDirectly")){ %> selected <%} %> >Purchased Directly </option>
												               			<option value="ThroughMainStream"  <%if(chlist!=null && chlist.getCSProcedure()!=null && chlist.getCSProcedure().equalsIgnoreCase("ThroughMainStream")){ %> selected <%} %> >Through Main Stream </option>
												               			
																	</select>
												                    
												                </div>
												              </div> 
												               
												               <div class="col-md-6" style="" id="CSDrawn" >
												                 <div class="form-group">
												                	<label class="control-label">If through main stores, drawn from main Stock Register through Demand-cum-issue voucher </label><span class="mandatory">*</span>
												                    <input value="Yes" name="CSDrawn"  type="checkbox"  <% if(chlist!=null && chlist.getCSDrawn()!=null && chlist.getCSDrawn().equalsIgnoreCase("Yes")) {%> checked <%} %> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												              <div class="col-md-3" style="" id="CSReason">
												                 <div class="form-group">
												                	<label class="control-label">If not through main stores, reason thereof </label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="CSReason" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" ><% if(chlist!=null && chlist.getCSReason()!=null) {%><%=chlist.getCSReason() %><%} %></textarea> 
												                    
												                </div>
												              </div>
												               
												                
												               <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">Amount is debited to Project Expenditure card </label><span class="mandatory">*</span>
												                    <input value="Yes" name="CSamountdebited"  type="checkbox" <% if(chlist!=null && chlist.getCSamountdebited()!=null && chlist.getCSamountdebited().equalsIgnoreCase("Yes")) {%> checked <%} %>  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												                 
												        </div>
												        
												        <hr>
												        
												        
												       <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">8. Procurement/ Accounting Procedure (Non-consumable Stores)</label>
												                    
												                </div>
												        </div> 
												            
												        <br>
												        <br> 
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												          <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Procedure followed </label><span class="mandatory">*</span>
												                    <select name="NCSProcedure" id="select2" class="form-control" data-width="100%" data-live-search="true" required>
			                											<option value="0" disabled="disabled" selected="selected">--Select--</option>
												               			
												               			<option value="PurchasedDirectly" <%if(chlist!=null && chlist.getNCSProcedure()!=null && chlist.getNCSProcedure().equalsIgnoreCase("PurchasedDirectly")){ %> selected <%} %> >Purchased Directly </option>
												               			<option value="ThroughMainStream" <%if(chlist!=null && chlist.getNCSProcedure()!=null && chlist.getNCSProcedure().equalsIgnoreCase("ThroughMainStream")){ %> selected <%} %> >Through Main Stream </option>
												               			
																	</select>
												                    
												                </div>
												              </div> 
												              
												              <div class="col-md-6" style="" id="NCSDrawn" >
												                 <div class="form-group">
												                	<label class="control-label">If through main stores, drawn from main Stock Register through Demand-cum-issue voucher </label><span class="mandatory">*</span>
												                    <input value="Yes" name="NCSDrawn"  <% if(chlist!=null && chlist.getNCSDrawn()!=null && chlist.getNCSDrawn().equalsIgnoreCase("Yes")) {%> checked <%} %>  type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												              <div class="col-md-3" style="" id="NCSReason">
												                 <div class="form-group">
												                	<label class="control-label">If not through main stores, reason thereof </label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="NCSReason" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" ><% if(chlist!=null && chlist.getNCSReason()!=null) {%><%=chlist.getNCSReason() %><%} %></textarea> 
												                    
												                </div>
												              </div>
												              
												               
												                
												               <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">Amount is debited to Project Expenditure card </label><span class="mandatory">*</span>
												                    <input value="Yes" name="NCSamountdebited"  <% if(chlist!=null && chlist.getNCSamountdebited()!=null && chlist.getNCSamountdebited().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												                   
												        </div>
												        
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												         
													         <div class="col-md-9" style="">
													                 <div class="form-group">
													                	<label class="control-label">In main stores ledger, item shown as distributed to Project Inventory of non-consumables being maintained in project group </label><span class="mandatory">*</span>
													                    <input value="Yes" name="NCSDistributed" <% if(chlist!=null && chlist.getNCSDistributed()!=null && chlist.getNCSDistributed().equalsIgnoreCase("Yes")) {%> checked <%} %>   type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
													                    
													                </div>
													          </div>
													          
													          
													          
													           <div class="col-md-9" style="">
													                 <div class="form-group">
													                	<label class="control-label">Any non-consumable item incorporated in any prototype stores are received and SIR is prepared before closure of project </label><span class="mandatory">*</span>
													                    <input value="Yes" name="NCSIncorporated"  <% if(chlist!=null && chlist.getNCSIncorporated()!=null && chlist.getNCSIncorporated().equalsIgnoreCase("Yes")) {%> checked <%} %>  type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
													                    
													                </div>
													          </div>
												              
												        </div>
												        
												        <hr>
												        
												       <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">9. Equipment</label>
												                </div>
												        </div> 
												            
												        <br>
												        <br>
												        
												        
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												          <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label">List out major non-consumable/ equipment procured</label><span class="mandatory">*</span>
												                     <%if(chlist!=null && chlist.getEquipProcured()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="EquipProcuredfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Equipment Procured Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="EquipProcuredAttach"  <%if(chlist==null) {%>required<%} %>  accept=".pdf">
												                    
												                </div>
												              </div> 
												               
												                
												               <div class="col-md-5" style="">
												                 <div class="form-group">
												                	<label class="control-label">Any major equipment not listed in Q.P.R has been purchased? </label><span class="mandatory">*</span>
												                    <input value="Yes" name="EquipPurchased"  <% if(chlist!=null && chlist.getEquipPurchased()!=null && chlist.getEquipPurchased().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  id="checkbox" data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              <div class="col-md-3" style="" id="EquipReason">
												                 <div class="form-group">
												                	<label class="control-label">If yes, reason assigned </label><span class="mandatory">*</span>
												                     <textarea class="form-control form-control" name="EquipReason" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" > <% if(chlist!=null && chlist.getEquipReason()!=null ) {%><%=chlist.getEquipReason() %> <%} %></textarea> 
												                </div>
												              </div>
												              
												                     
												        </div>
												        
												        
												      <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												         <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">Any major equipment procured within one month before the PDC (give details and reason thereof) </label><span class="mandatory">*</span>
												                    <input value="Yes" name="EquipProcuredBeforePDC" <% if(chlist!=null && chlist.getEquipProcuredBeforePDC()!=null  && chlist.getEquipProcuredBeforePDC().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  id="checkbox1" data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												              <div class="col-md-3" style="" id="EquipProcuredBeforePDCAttach">
												                 <div class="form-group">
												                	<label class="control-label">Attach if yes</label><span class="mandatory">*</span>
												                     <%if(chlist!=null && chlist.getEquipProcuredBeforePDCAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="EquipProcuredBeforePDCfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="EquipProcuredBeforePDC Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="EquipProcuredBeforePDCAttach" <%if(chlist==null) {%>required<%} %> accept=".pdf">
												                </div>
												              </div>
												               
												        </div>
												        
												    <div class="row" style="margin-left: 2%;margin-right: 2%;">              
												        <div class="col-md-8" style="">
												                 <div class="form-group">
												                	<label class="control-label">Any equipment bought on charge within one month before the PDC or after PDC (Give details and reasons thereof) </label><span class="mandatory">*</span>
												                    <input value="Yes" name="EquipBoughtOnCharge"  <% if(chlist!=null && chlist.getEquipBoughtOnCharge()!=null  && chlist.getEquipBoughtOnCharge().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  id="checkbox2" data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												              <div class="col-md-3" style="" id="EquipBoughtOnChargeAttach">
												                 <div class="form-group">
												                	<label class="control-label">Attach if yes </label><span class="mandatory">*</span>
												                     <%if(chlist!=null && chlist.getEquipBoughtOnChargeAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="EquipBoughtOnChargefile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="EquipBoughtOnCharge Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="EquipBoughtOnChargeAttach" <%if(chlist==null) {%>required<%} %> accept=".pdf">
												                </div>
												              </div>
												              
												        </div>
												        
												  <hr>
												        
												        
												      <div class="col-md-4" style="">
												        		<div class="form-group">
												                	   <label class="control-label" style="color:black">10. Budget</label>
												                </div>
												        </div>
												            
												        <br>
												        <br>   
												          
												         <div class="row" style="margin-left: 2%;margin-right: 2%;">         
												          
												               <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">The reviewing officer should  see  the allocation  w.r.t demands  and  also  the  projections  in  the Q.P.R </label><span class="mandatory">*</span>
												                    <input value="Yes" name="BudgetAllocation"  <% if(chlist!=null && chlist.getBudgetAllocation()!=null && chlist.getBudgetAllocation().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												              <div class="col-md-5" style="">
												                 <div class="form-group">
												                	<label class="control-label">What is the mechanism for monitoring/ control of head-wise expenditure? </label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="BudgetMechanism" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" ><% if(chlist!=null && chlist.getBudgetMechanism()!=null) {%><%=chlist.getBudgetMechanism() %><%} %></textarea> 
												                    
												                </div>
												              </div>
												              
												              
												              <div class="col-md-5" style="">
												                 <div class="form-group">
												                	<label class="control-label">Mention, if expenditure under any head exceeded the respective allocation</label><span class="mandatory">*</span>
												                    <%if(chlist!=null && chlist.getBudgetExpenditureAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="BudgetExpenditurefile" formaction="ProjectClosurechlistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="BudgetExpenditure Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="BudgetExpenditureAttach"  <%if(chlist==null) {%>required<%} %>  accept=".pdf">
												                </div>
												              </div>
												              
												              
												               <div class="col-md-6" style="">
												                 <div class="form-group">
												                	<label class="control-label">Whether financial progress is in consonance with Tech. progress.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="BudgetFinancialProgress"  <% if(chlist!=null && chlist.getBudgetFinancialProgress()!=null  && chlist.getBudgetFinancialProgress().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												              
												              
												               <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">Monthly/ Quarterly expenditure Reports are rendered to R&D HQrs and copy sent to local CDA</label><span class="mandatory">*</span>
												                    <input value="Yes" name="BudgetexpenditureReports"  <% if(chlist!=null && chlist.getBudgetexpenditureReports()!=null  && chlist.getBudgetexpenditureReports().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												              
												               <div class="col-md-5" style="">
												                 <div class="form-group">
												                	<label class="control-label">Any expenditure incurred after Project PDC (Give details and reasons thereof)</label><span class="mandatory">*</span>
												                    <input value="Yes" name="BudgetexpenditureIncurred"  <% if(chlist!=null && chlist.getBudgetexpenditureIncurred()!=null  && chlist.getBudgetexpenditureIncurred().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>
												              
												             
												              
												              
												              <div class="checklistpage"  style="text-align: center;">
												             
												             <!--  <button class="btn btn-info btn-sm" id="backtofirstpage" >Previous</button> -->
												             
												             <% if(chlist!=null && chlist.getCSProcedure()!=null) {%>
												                    
												                    <button class="btn-warning edit btn" type="submit" id="" name="Action" value="Edit" onclick="return confirm('Are You Sure To Update')">UPDATE</button>
												             <%}else{ %>
													                <button class="btn btn-info btn-sm success submit" id="secondpagechange" name="Action"  <% if(chlist!=null){ %> value="Edit" <%} else {%> value="Add" <%} %>onclick="return confirm('Are You Sure To Submit')">SUBMIT</button>
													                
													                <%} %>
	            							                </div>
	            							                 
	            							             </div>
	            							        
												   <!--   </form>  -->
												    
												     <div class="pagin" style="display: flex;justify-content: right;padding-bottom:10px;"> 
																
																	
																	<div class="pagination">
																			<div class="page-item">
																				
																					<button type="button" class="page-link" id="backtofirstpages">Previous</button>
																					
																						
																				
																			</div>
																			<div class="page-item">
																				<input class="page-link" type="button" value="2" disabled/>
																			</div>
																			<div class="page-item">
																				
																					
																						<button type="button" class="page-link" id="secondpagechanges">Next</button>
																						
																				
																			</div>
																			
																	</div>
																
															 </div> 
												    
												    
												    
												    </div> 
												    
												    
												     <div class="" id="thirdpage">  
												    
												    
												    <!-- <form action="ProjectClosureCheckListDetailsSubmit.htm" method="POST" enctype="multipart/form-data"> -->
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="closureId" value="<%=closureId%>">    
												      
												       
												   
												    
												         <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">11. Utilization of Equipment</label>
												                </div>
												        </div>
												            
												        <br>
												        <br> 
												        
												      <div class="row" style="margin-left: 2%;margin-right: 2%;">
												          
												          <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">Log book maintained in r/o high cost equipment</label><span class="mandatory">*</span>
												                    <input value="Yes" name="LogBookMaintained"  <% if(chlist!=null && chlist.getLogBookMaintained()!=null  && chlist.getLogBookMaintained().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>   
												              
												              <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">Job cards maintained</label><span class="mandatory">*</span>
												                    <input value="Yes" name="JobCardsMaintained" <% if(chlist!=null && chlist.getJobCardsMaintained()!=null  && chlist.getJobCardsMaintained().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												              </div>    
												          
												          </div>
												          
												          <hr>
												          
												          <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">12. Staff Position</label>
												                </div>
												        </div> 
												            
												        <br>
												        <br> 
												          
												     <div class="row" style="margin-left: 2%;margin-right: 2%;">      
												         <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">Demanded as per Q.P.R</label><span class="mandatory">*</span>
												                    <input value="Yes" name="SPdemand"  <% if(chlist!=null && chlist.getSPdemand()!=null  && chlist.getSPdemand().equalsIgnoreCase("Yes")) {%> checked <%} %>  type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												           <div class="col-md-2" style="">
												                 <div class="form-group">
												                	<label class="control-label">Actual position-held</label><span class="mandatory">*</span>
												                    <%if(chlist!=null && chlist.getSPActualpositionAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="SPActualpositionfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SPActualposition Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="SPActualposition" <%if(chlist==null) {%>required<%} %>  accept=".pdf">
												                </div>
												          </div> 
												          
												          
												          
												           <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">General Specific (Category wise)</label><span class="mandatory">*</span>
												                    <%if(chlist!=null && chlist.getSPGeneralSpecificAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="SPGeneralSpecificfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SPGeneralSpecific Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="SPGeneralSpecific"  <%if(chlist==null) {%>required<%} %>  accept=".pdf">
												                </div>
												          </div> 
												          
												          
												      </div> 
												      
												      <hr>
												      
												       <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">13.Civil Works</label>
												                </div>
												        </div> 
												            
												        <br>
												        <br> 
												          
												         <div class="row" style="margin-left: 2%;margin-right: 2%;">      
												         <div class="col-md-6" style="">
												                 <div class="form-group">
												                	<label class="control-label">Civil works are included in the estimated prepared before project sanction.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="CWIncluded"  <% if(chlist!=null && chlist.getCWIncluded()!=null  && chlist.getCWIncluded().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												           <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">Admin approval is accorded for the work.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="CWAdminApp"  <% if(chlist!=null && chlist.getCWAdminApp()!=null  && chlist.getCWAdminApp().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												          
												          
												          <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">Minor works are completed within the financial year and not costing more than one lakh.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="CWMinorWorks"  <% if(chlist!=null && chlist.getCWMinorWorks()!=null  && chlist.getCWMinorWorks().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												          
												           <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">Revenue major works are completed within the financial year and not costing more than two lakhs.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="CWRevenueWorks"  <% if(chlist!=null && chlist.getCWRevenueWorks()!=null  && chlist.getCWRevenueWorks().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												          
												           <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">There are no deviations from the  admin   approval.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="CWDeviation"  <% if(chlist!=null && chlist.getCWDeviation()!=null  && chlist.getCWDeviation().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												         
												          <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">Expenditure is not incurred just for the sake of exhausting funds at the end of Project.</label><span class="mandatory">*</span>
												                    <input value="Yes" name="CWExpenditure"  <% if(chlist!=null && chlist.getCWExpenditure()!=null  && chlist.getCWExpenditure().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												      </div>   
												      
												      <hr>
												      
												      <div class="col-md-4" style="">
												        		<div class="form-group">
												                	<label class="control-label" style="color:black">14.Vehicles</label>
												                </div>
												        </div> 
												            
												        <br>
												        <br> 
												      
												         <div class="row" style="margin-left: 2%;margin-right: 2%;">      
												          <div class="col-md-5" style="">
												                 <div class="form-group">
												                	<label class="control-label">No. of vehicles sanctioned in the project (With types).</label><span class="mandatory">*</span>
												                    <input value="Yes" name="NoOfVehicleSanctioned"  <% if(chlist!=null && chlist.getNoOfVehicleSanctioned()!=null  && chlist.getNoOfVehicleSanctioned().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
												                    
												                </div>
												          </div> 
												          
												          <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">Average monthly run of each vehicle.</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="VehicleAvgRun"  placeholder="Enter Average monthly run of each vehicle" 
												                     value="<% if(chlist!=null && chlist.getVehicleAvgRun()!=null){ %> <%=chlist.getVehicleAvgRun() %><%} %>" >
												                    
												                </div>
												          </div> 
												          
												          
												          <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">Average monthly fuel consumption of each vehicle.</label><span class="mandatory">*</span>
                                                                     <input  class="form-control " type="text" name="VehicleAvgFuel" id="" placeholder="Enter Average monthly fuel consumption of each vehicle" 
												                     value="<% if(chlist!=null && chlist.getVehicleAvgFuel()!=null){ %> <%=chlist.getVehicleAvgFuel() %><%} %>" >
										                    
												                </div>
												          </div> 
												          
												         </div>
												         
												         <hr>
												         
												         <div class="col-md-4" style="">
											        		<div class="form-group">
											                	<label class="control-label" style="color:black">15. If the project is closed</label>
											                </div>
												        </div> 
												            
												        <br>
												        <br>
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">      
												          <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">When the project finally closed</label><span class="mandatory">*</span>
												                     <input  class="form-control" type="text" name="ProjectClosedDate" id="ProjectClosedDate" placeholder="Enter Project Closed Date" 
												                     value="<% if(chlist!=null && chlist.getProjectClosedDate()!=null){ %> <%=chlist.getProjectClosedDate() %><%} %>" >
												                     
												                </div>
												          </div> 
												          
												          <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">Project closures Report send to R&D HQrs.(Mention Dated)</label><span class="mandatory">*</span>
												                    <input  class="form-control " type="text" name="ReportDate" id="ClosureReportDate" placeholder="" 
												                    value="<% if(chlist!=null && chlist.getReportDate()!=null){ %> <%=chlist.getReportDate() %><%} %>" >

												                    
												                </div>
												          </div> 
												          
												          
												          <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">If undue delay in sending the Closure Report, reasons thereof.</label><span class="mandatory">*</span>
                                                                     <input  class="form-control " type="text" name="ProjectDelayReason" id="" placeholder="If undue delay in sending the Closure Report, reasons thereof" 
												                     value="<% if(chlist!=null && chlist.getDelayReason()!=null){ %> <%=chlist.getDelayReason() %><%} %>" >												                    
												                </div>
												          </div> 
												          
												           <div class="col-md-4" style="">
												                 <div class="form-group">
												                	<label class="control-label">Whether  the  stated  objectives achieved.</label><span class="mandatory">*</span>
                                                                    <input value="Yes" name="CRObjective" <% if(chlist!=null && chlist.getCRObjective()!=null  && chlist.getCRObjective().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
                                                                    											                    
												                </div>
												           </div>
												                
												            <div class="col-md-3" style="">
												                 <div class="form-group">
												                	<label class="control-label">Any other spin-off achieved.</label><span class="mandatory">*</span>
                                                                    <input value="Yes" name="CRspinoff"  <% if(chlist!=null && chlist.getCRspinoff()!=null  && chlist.getCRspinoff().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
                                                                    											                    
												                </div>
												           </div>  
												           
												           
												           <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">Reason, if PDC not  meet (Delay in  convening of TPC or  delayed placement of indent by the user)</label><span class="mandatory">*</span>
                                                                    <input value="Yes" name="PDCNotMeetReason"  <% if(chlist!=null && chlist.getCRReason()!=null  && chlist.getCRReason().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
                                                                    											                    
												                </div>
												           </div>  
												             
												              
												              
												               <div class="col-md-5" style="">
												                 <div class="form-group">
												                	<label class="control-label">Reason, if Cost Over-run</label><span class="mandatory">*</span>
                                                                    <textarea class="form-control form-control" name="CRcostoverin" maxlength="5000" rows="1" cols="100" style="font-size: 15px;" 
                              		  								 placeholder="Enter Reason" ><% if(chlist!=null && chlist.getCRcostoverin()!=null) {%><%=chlist.getCRcostoverin() %><%} %></textarea> 											                    
												                </div>
												           </div>  
												           
												           
												           <div class="col-md-8" style="">
												                 <div class="form-group">
												                	<label class="control-label">Non-consumable items returned to main stores on nominal voucher (No credit to be given in Project expenditure  card)</label><span class="mandatory">*</span>
                                                                     <input value="Yes" name="NonConsumableItemsReturned"  <% if(chlist!=null && chlist.getNonConsumableItemsReturned()!=null  && chlist.getNonConsumableItemsReturned().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
                                                                    
                                                                    											                    
												                </div>
												           </div> 
												           
												            
												            <div class="col-md-8" style="">
												                 <div class="form-group">
												                	<label class="control-label">Consumable (non-consumed) returned to main store on Issue voucher (Credit to be given in Project Expenditure Card)</label><span class="mandatory">*</span>
                                                                     <input value="Yes" name="ConsumableItemsReturned"   <% if(chlist!=null && chlist.getConsumableItemsReturned()!=null  && chlist.getConsumableItemsReturned().equalsIgnoreCase("Yes")) {%> checked <%} %> type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
                                                                    
                                                                    											                    
												                </div>
												           </div> 
												           
												           
												           <%-- <div class="col-md-8" style="">
												                 <div class="form-group">
												                	<label class="control-label">Consumable (non-consumed) returned to main store on Issue voucher (Credit to be given in Project Expenditure Card)</label><span class="mandatory">*</span>
                                                                     <input name="ConsumableItemsReturned"  type="checkbox"  data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="80" data-height="10" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
                                                                    
                                                                    											                    
												                </div>
												           </div>  --%>
												                
												              <div class="col-md-7" style="">
												                 <div class="form-group">
												                	<label class="control-label">How the manpower sanctioned in the Project has been disposed of (Permanent as well as temporary)</label><span class="mandatory">*</span>
                                                                    <%if(chlist!=null && chlist.getCRAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="CRAttachfile" formaction="ProjectClosureChecklistFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="CRAttach Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="CRAttach"  <%if(chlist==null) {%>required<%} %>  accept=".pdf">
                                                                    											                    
												                </div>
												           </div>  
												    </div> 
												    
														     <div class="checklistpage"  style="text-align: center;">
														     
														            <!-- <button class="btn btn-info btn-sm" id="backtosecondpage" >Previous</button> -->
														            
														             <% if(chlist!=null && chlist.getSPActualpositionAttach()!=null) { %>
												                    
												                    <button class="btn-warning edit btn" type="submit" id="" name="Action" value="Edit" onclick="return confirm('Are You Sure To Update')">UPDATE</button>
												                    
												             <%} else{ %>
												             
													                <button class="btn btn-info btn-sm success submit" id="secondpagechange" name="Action"  <% if(chlist!=null){ %> value="Edit" <%} else {%> value="Add" <%} %>onclick="return confirm('Are You Sure To Submit')">SUBMIT</button>
													                
													                <%} %>
														            
														           
															 </div> 
															 
															 
															
													
										         
												        
												         
								               			<%-- <div align="center" style="margin-top: 1rem; margin-bottom: 1rem;">
															<%if(chlist!=null){ %>
															    <input type="hidden" name="closureId" value="<%=chlist.getClosureId()%>">
																<button type="submit" class="btn btn-sm btn-warning edit btn-chlist" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
															<%}else{ %>
																<button type="submit" class="btn btn-sm btn-success submit btn-chlist" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?')" >SUBMIT</button>
															<%} %>
														</div> --%>
						
												    </form> 
												    
												    
												    <div class="pagin" style="display: flex; justify-content: right;padding-bottom:10px;"> 
																
																	
																	<div class="pagination">
																			<div class="page-item">
																				
																					<button class="page-link"   id="backtosecondpages" >Previous</button>
																					
																					
																				
																			</div>
																			
																			<div class="page-item">
																				<input class="page-link" type="button" value="3" disabled/>
																			</div>
																			<div class="page-item">
																				   <button class="page-link"  id="" >Next</button>
																			</div>
																			
																	</div>
															</div> 
												    
												    
												    </div> 
												</div>
											</div>
               							</div>
               						</div>
               					</div>
               					<div style="display: flex;justify-content: space-between;">
               						<div></div>
		               				<%-- <div class="navigation_btn"  style="text-align: center;">
		               					<%if(chlist!=null){ %>
				               				<form action="">
				               					<button type="submit" class="btn btn-sm " formaction="ProjectClosurechlistDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="chlist Download" style="background-color: purple;border: none;color: white;font-weight: bold;">chlist</button>
				               					<input type="hidden" name="closureId" value="<%=closureId%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				               				</form>
			               				<%} %>
									</div> --%>
		               				<div class="navigation_btn"  style="text-align: right;">
            							<a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectClosureList.htm" style="color: white!important">Back</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               					
               			<%if(chlistTabId!=null && chlistTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** chlist Forward ***********      --> 
               			<%if(chlistTabId!=null && chlistTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="chlistforward" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="chlistforward" role="tabpanel">
               			<%} %>
               					<%if(chlist!=null) { %>
               						<div class="col-md-8 mt-2">
               							<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%; <%if(isApproval==null) {%>max-height: 600px;<%} else{%>max-height: 700px;<%} %>  overflow-y: auto;">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   									<%-- <input type="hidden" name="closureId" value="<%=closureId%>"> --%>
                   									<%-- <input type="hidden" name="closurechlistId" value="<%=chlist.getClosurechlistId()%>"> --%>
			               							<div class="mt-2" align="center">
			               								<h5 style="font-weight: bold;margin-top: 1.5rem;">STATEMENT OF CASE FOR PROJECT COMPLETED WITH
				               								<%if(closure!=null) {
				               								 String category = closure.getClosureCategory();
				               								%>
				               									<%if(category.equalsIgnoreCase("Partial Success")){%>
				               									PARTIAL SUCCESS
				               									<%} else if(category.equalsIgnoreCase("Stage Closure")){%>
				               									STAGE CLOSURE
				               									<%} else if(category.equalsIgnoreCase("Cancellation")){%>
				               									CANCELLATION
				               									<%} %>
				               								<%} %>
			               								 </h5>
			               							</div>
			               							<%int slno=0; %>
    												<table id="tabledata">
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Name of Lab/Est</td>
												    		<td>: <%=labcode %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Title of the Project/Programme</td>
												    		<td>: <%=projectMaster.getProjectName() %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Project/Programme No.</td>
												    		<td>: <%=projectMaster.getSanctionNo() %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Category of Project</td>
												    		<td>: <%if(potherdetails!=null && potherdetails[0]!=null) {%><%=potherdetails[0] %><%} %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Sponsoring Agency and QR No.</td>
<%-- 												    		<td>: <%if(projectMaster.getEndUser()!=null) {%> <%=projectMaster.getEndUser() %><%} else{%>--<%} %> and <%if(chlist.getQRNo()!=null && !chlist.getQRNo().isEmpty()) {%> <%=chlist.getQRNo() %><%} else{%>NA<%} %> </td>
 --%>												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Date of Sanction</td>
												    		<td>: <%if(projectMaster.getSanctionDate()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getSanctionDate()+"") %><%} %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">PDC original given and <br> Subsequent amendment, if any </td>
												    		<td>: <%if(projectMaster.getPDC()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getPDC()+"") %><%} %>
												    		
												    		<br>: <%if(potherdetails!=null && potherdetails[8]!=null) {%><%=fc.SqlToRegularDate(potherdetails[8].toString()) %><%} else{%>--<%} %>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Sanctioned Cost ( <span style="font-size: 12px;">&#x20B9;</span> Cr) </td>
												    		<td style="">: Total 
												    			<span style="text-decoration: underline;">
												    				<%=df.format(projectMaster.getTotalSanctionCost()/10000000) %>
												    			</span> Cr (FE 
												    			<span style="text-decoration: underline;">
												    				<%=df.format(projectMaster.getSanctionCostRE()/10000000 ) %>
												    			</span> Cr)
												    		</td>
												    	</tr> 
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Statement of Accounts ( as on <%-- <%if(chlist.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(chlist.getExpndAsOn()) %><%} %> --%> )</td>
												    		<td>: Expenditure incurred (<span style="font-size: 12px;">&#x20B9;</span> Cr) 
												    		: Total <span style="text-decoration: underline;">
												    			<%-- <%=String.format("%.2f", Double.parseDouble(chlist.getTotalExpnd())/10000000 ) %> --%>
												    			<%if(expndDetails!=null && expndDetails[0]!=null) {%>
												    				<%=df.format(Double.parseDouble(expndDetails[0].toString())/10000000 ) %> 
												    			<%} %>
												    		</span> Cr 
												    		(FE <span style="text-decoration: underline;">
												    			<%-- <%=String.format("%.2f", Double.parseDouble(chlist.getTotalExpndFE())/10000000 ) %> --%>
												    			<%if(expndDetails!=null && expndDetails[1]!=null) {%>
												    				<%=df.format(Double.parseDouble(expndDetails[1].toString())/10000000 ) %> 
												    			<%} %>
												    			</span> Cr)
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<!-- <td style="width: 39.2%;">Present Status</td>
												    		<td style="width: 55.3%;">:</td> -->
												    		<td style="width: 40%;">Present Status</td>
												    		<%-- <td style="">: <%=chlist.getPresentStatus() %> </td> --%>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Detailed reasons/considerations for Project <%=closure.getClosureCategory() %> </td>
												    		<%-- <td style="">: <%if(chlist.getReason()!=null) {%><%=chlist.getReason() %> <%} else{%>-<%} %> </td> --%>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Recommendation of Review Committee for Project success (as applicable)</td>
<%-- 												    		<td style="">: <%if(chlist.getRecommendation()!=null && !chlist.getRecommendation().isEmpty()) {%><%=chlist.getRecommendation() %> <%} else{%>NA<%} %> </td>
 --%>												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">
												    			Minutes of Monitoring Committee Meetings held so far and recommendations 
												 				of the highest monitoring committee for closure of the project/programme
												 			</td>
												    		<%-- <td style="">: <%=chlist.getMonitoringCommittee() %> --%>
												    			<!-- <button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 		     value="monitoringcommitteefile" formaction="ProjectClosurechlistFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Download">
                            					 				 	<i class="fa fa-download fa-lg"></i>
                            					 				</button>
												    		</td> -->
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Direction of DMC</td>
												    		<%-- <td style="">: <%=chlist.getDMCDirection() %> </td> --%>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Lessons Learnt</td>
												    		<td style="">: 
												    		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 		 value="lessonslearntfile" formaction="ProjectClosurechlistFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Lessons learnt Download">
                            					 				<i class="fa fa-download fa-lg"></i>
                            					 			</button>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Other relevant details</td>
<%-- 												    		<td style="">: <%if(chlist.getOtherRelevant()!=null && !chlist.getOtherRelevant().isEmpty()) {%><%=chlist.getOtherRelevant() %> <%} else{%>--<%} %></td>
 --%>												    	</tr>
   	 												</table>
   	 												
   	 												<br>
			               		   					
			               		   					<!-- Signatures and timestamps -->
			               		   					
							            			<%-- <div class="row mt-2 mb-4" style="margin-left: 18px;">
														<div class="col-md-12" align="center">
															<%if(statuscode!=null && chlistforward.contains(statuscode)) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" name="Action" formaction="ProjectClosurechlistApprovalSubmit.htm" value="A" onclick="return confirm('Are you Sure to Submit ?');">Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y")) {%>
																<%if(statuscode!=null && statuscode.contains("SAD")  ) {%>
																	<div class="row externalapproval" style="">
																		<div class="col-md-3">
																			<label class="control-label">Lab</label><span class="mandatory">*</span>
																			<select class="form-control selectdee" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (labList != null && labList.size() > 0) {
																						for (Object[] obj : labList) {
																					%>
																						<option value=<%=obj[2].toString()%>><%=obj[2].toString()%></option>
																					<%}}%>
																					<option value="@EXP">Expert</option>
																			</select>
																		</div>
																		<div class="col-md-3">
																			<label class="control-label">Approval Officer</label><span class="mandatory">*</span>
				  															<select class="form-control selectdee" id="approverEmpId" name="approverEmpId" data-live-search="true" required>
				  																<option disabled="disabled" value="" selected="selected"> Select</option>
				  															</select>
																		</div>
																		<div class="col-md-2">
																			<label class="control-label" >Approval Date</label><span class="mandatory">*</span>
			          														<input type="text" class="form-control" id="approvalDate" name="approvalDate">
																		</div>
																		<div class="col-md-4"></div>
																		
																	</div>
																<%} %>
																
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(statuscode!=null && (statuscode.contains("SAP") || statuscode.contains("SAD"))) {%>
								         						<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="ProjectClosurechlistApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
										    						Approve	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="ProjectClosurechlistApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="ProjectClosurechlistApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" style="font-weight: 600;">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="ProjectClosurechlistApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
															<%} }%>
														</div>
                   									</div> --%>
                   						 
			               						</form>
			               					</div>
			               				</div>
			               			</div>
			               							
               					
               					<%} else{%>
			               			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
			               				<h4 style="font-weight: bold;color: red;">Please Fill Check List Details..!</h4>
			               			</div>
               					<%} %>
               					
               					<div style="display: flex;justify-content: space-between;">
	               				
		               				<div class="navigation_btn"  style="text-align: right;">
		            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               			
               			<%if(chlistTabId!=null && chlistTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               		</div>
               	</div>
         		
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$('#expndAsOn').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	


$('#PDCDate,#ProposedDate,#CFASendDate,#SCRequested,#SCGranted,#ProjectClosedDate,#ClosureReportDate,#HQrsSentDate,#PDCRequested,#PDCGranted').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 //"maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	


$(document).ready(function() {
	
	 $('#CSReason').hide();
	 $('#CSDrawn').hide();
	 
    $('#select1').on('change', function() {
    var selectedValue = $(this).val();
    if(selectedValue=="PurchasedDirectly"){
    	
    	 $('#CSDrawn').hide();
    	 $('#CSReason').show();
    	
    }
    else{
    	 $('#CSReason').hide();
    	 $('#CSDrawn').show();
    	 
    	
    }
     if(selectedValue=="PurchasedDirectly"){
    	
    	
    	$('#CSReason').attr('required', true);
    } 
    
    
    });
  });


$(document).ready(function() {
	
	 $('#NCSReason').hide();
	 $('#NCSDrawn').hide();
	 
   $('#select2').on('change', function() {
   var selectedValue = $(this).val();
   if(selectedValue=="PurchasedDirectly"){
   	
   	 $('#NCSDrawn').hide();
   	 $('#NCSReason').show();
   	
   }
   else{
	   	 $('#NCSReason').hide();
	   	 $('#NCSDrawn').show();
   		
   }
    if(selectedValue=="PurchasedDirectly"){
   	  $('#NCSReason').attr('required', true);
    } 
   
   });
   
 });
 
 
$(document).ready(function() {
	
	$('#EquipReason').hide();
	
$("#checkbox").on('change', function() {
	
	
	
    if($(this).prop("checked") == true){
    	
    	 $('#EquipReason').show();
     
    	 //pono.setAttribute('required', '');
    	 
    }else{
    	
    	$('#EquipReason').hide();
    }
    
   });
  
});


$(document).ready(function() {
	
	$('#EquipProcuredBeforePDCAttach').hide();
	
$("#checkbox1").on('change', function() {
	
	
	
    if($(this).prop("checked") == true){
    	
    	 $('#EquipProcuredBeforePDCAttach').show();
     
    	 //pono.setAttribute('required', '');
    	 
    }else{
    	
    	$('#EquipProcuredBeforePDCAttach').hide();
    }
    
   });
  
});



$(document).ready(function() {
	
	$('#EquipBoughtOnChargeAttach').hide();
	
$("#checkbox2").on('change', function() {
	
    if($(this).prop("checked") == true){
    	
    	 $('#EquipBoughtOnChargeAttach').show();
     
    	 //pono.setAttribute('required', '');
    	 
    }else{
    	
    	$('#EquipBoughtOnChargeAttach').hide();
    }
    
   });
  
});


$(document).ready(function() {
	
	
	$('#secondpage').hide();
	$('#thirdpage').hide();
	
/* 	$("#firstpagechange,#firstpagechanges").on('click', function() {
		
		
		$('#firstpage').hide();
		$('#secondpage').show();
		$('#thirdpage').hide();
		
		$('#firstpagesubmit').submit();
		
	}); */
	
	
$("#firstpagechanges").on('click', function() {
		
		
		$('#firstpage').hide();
		$('#secondpage').show();
		$('#thirdpage').hide();
		
		
	});
	
     $("#secondpagechanges").on('click', function() {
		
			$('#firstpage').hide();
			$('#secondpage').hide();
			$('#thirdpage').show();
		
	});
     
     
     $("#backtofirstpage,#backtofirstpages").on('click', function() {
    	 
    	 
		   	    $('#firstpage').show();
				$('#secondpage').hide();
				$('#thirdpage').hide();
    	 
    	 
 	}); 
	
	
     $("#backtosecondpage,#backtosecondpages").on('click', function() {
    	 
    	 
	   	    $('#firstpage').hide();
			$('#secondpage').show();
			$('#thirdpage').hide();
	 
	 
}); 
     
     
	
});




</script>

<script type="text/javascript">

 function bootstrapTabControl(){
	  var i, items = $('.nav-link'), pane = $('.tab-pane');
	  // next
	  $('.next').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i < items.length - 1){
	          $(items[i+1]).trigger('click');
	      }

	  });
	  // Prev
	  $('.previous').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i != 0){
	          $(items[i-1]).trigger('click');
	      }
	  });
	}
	bootstrapTabControl(); 

</script>



<script type="text/javascript">
/* button disabling for chlist Approval */
<%if((chlist!=null && chlistforward.contains(closure.getClosureStatusCode())) || chlist==null) {%>
$('.btn-chlist').prop('disabled',false);
<%} else{%>
$('.btn-chlist').prop('disabled',true);
<%} %>

/* tabs hiding for chlist approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("Y") || isApproval.equalsIgnoreCase("N"))) {%>
   $('.navigation_btn').hide();
   $('#nav-chlistdetails').hide();
<%} %>
</script>

<!-- Remarks Handling -->
<script type="text/javascript">
function validateTextBox() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Return?');
    	
    } else {
        alert("Please enter Remarks to Return");
        return false;
    }
}
function disapprove() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Disappove?');
    	
    } else {
        alert("Please enter Remarks to Disapprove");
        return false;
    }
}
</script>

<script type="text/javascript">

	
	
$('#approvalDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	


</script>
</body>
</html>