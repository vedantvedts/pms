<%@page import="java.text.DecimalFormat"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosure"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureSoC"%>
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
ProjectClosureSoC soc = (ProjectClosureSoC)request.getAttribute("ProjectClosureSoCData");

Object[] potherdetails = (Object[])request.getAttribute("ProjectOriginalRevDetails");
Object[] expndDetails = (Object[])request.getAttribute("ProjectExpenditureDetails");

List<Object[]> socApprovalEmpData = (List<Object[]>)request.getAttribute("SoCApprovalEmpData");
List<Object[]> socRemarksHistory = (List<Object[]>)request.getAttribute("SoCRemarksHistory");

List<Object[]> labList = (List<Object[]>)request.getAttribute("LabList");

String socTabId = (String)request.getAttribute("socTabId");
String closureId = (String)request.getAttribute("closureId");
String isApproval = (String)request.getAttribute("isApproval");

List<String> socforward = Arrays.asList("SIN","SRG","SRA","SRP","SRD","SRC","SRV");

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
             		<h4 class="category">Project Closure SoC - <%if(projectMaster!=null) {%><%=projectMaster.getProjectShortName()+" ("+projectMaster.getProjectCode()+")" %> <%} %>

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

            			<li class="nav-item" id="nav-socdetails">
             				<%if(socTabId!=null && socTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#socdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#socdetails" role="tab">
               				<%} %>  
               					
                	         	SoC Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-socforward">
            	     		<%if(socTabId!=null && socTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#socforward" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#socforward" role="tab" >
               				<%} %>
                  				SoC Forward
              					</a>
            			</li>
            			
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center" style="margin-top : 0.2rem;">
         				<!-- *********** SoC Details ***********      --> 
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="socdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socdetails" role="tabpanel">
               			<%} %>
               					<div class="container">
									<div class="row" style="width: 140%; margin-left: -15rem;margin-top: 1rem;">
										<div class="col-md-12">
											<div class="card shadow-nohover" >
												<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
								                    <b class="text-white" style="">SoC Details: </b> 
								                    <hr>
								                    <span class="text-white" style="float:right;font-weight: 600"> </span>
							        			</div> 
												<div class="card-body">
								        		
													<form action="ProjectClosureSoCDetailsSubmit.htm" method="POST" enctype="multipart/form-data">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="closureId" value="<%=closureId%>">
												    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
												    		
												        	<%-- <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Closure Category:</label><span class="mandatory">*</span>
												                    <select name="closureCategory" id="closureCategory" class="form-control  form-control selectdee" onchange="closurecategorychange()" data-width="100%" data-live-search="true" required>
			                											<option value="-1" disabled="disabled" selected="selected">--Select--</option>
												               			<%
												                			for(String category: closurecategory ){
												                		%>
																			<option value="<%=category%>" <%if(soc!=null && soc.getClosureCategory()!=null){ if(category.equalsIgnoreCase(soc.getClosureCategory())){%>selected="selected" <%}} %>  style="text-align: left;"><%=category %></option>
																		<%} %>
																	</select>
												                </div>
												            </div> --%>
												        	<div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">QR No:</label>
												                    <input  class="form-control form-control" type="text" name="qrNo" placeholder="Enter QRNo" 
												                     value="<%if(soc!=null && soc.getQRNo()!=null) {%><%=soc.getQRNo() %><%} %>" > 
												                </div>
												            </div>
												            <%-- <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Expnd as on :</label><span class="mandatory">*</span>
												                    <input  class="form-control form-control" type="text" name="expndAsOn" id="expndAsOn"
												                     value="<%if(soc!=null && soc.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(soc.getExpndAsOn()) %><%} %>" required> 
												                </div>
												            </div>
												        	<div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Total Expnd (<span style="font-size: 14px;">&#x20B9;</span> Cr):</label><span class="mandatory">*</span>
												                    <input  class="form-control form-control" type="number" step="0.1" name="totalExpnd" placeholder="Enter Total Expenditure" maxlength="6"
												                     value="<%if(soc!=null && soc.getTotalExpnd()!=null) {%><%=String.format("%.2f", Double.parseDouble(soc.getTotalExpnd())/10000000) %><%} %>" required> 
												                </div>
												            </div>
												        	<div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Total FE Expnd (<span style="font-size: 14px;">&#x20B9;</span> Cr):</label><span class="mandatory">*</span>
												                    <input  class="form-control form-control" type="number" step="0.1" name="totalExpndFE" placeholder="Enter Total Expenditure FE" maxlength="6"
												                     value="<%if(soc!=null && soc.getTotalExpndFE()!=null) {%><%=String.format("%.2f", Double.parseDouble(soc.getTotalExpndFE())/10000000) %><%} %>" required> 
												                </div>
												            </div> --%>
												            <div class="col-md-2" style="">
												        		<div class="form-group">
												                	<label class="control-label">Direction of DMC:</label><span class="mandatory">*</span>
												                	<select name="dmcDirection" id="dmcDirection" class="form-control  form-control selectdee" data-width="100%" data-live-search="true" required>
			                											<option value="0" disabled="disabled" selected="selected">--Select--</option>
												               			<%
												                			for(String direction: dmcdirection ){
												                		%>
																			<option value="<%=direction%>" <%if(soc!=null && soc.getDMCDirection()!=null){ if(direction.equalsIgnoreCase(soc.getDMCDirection())){%>selected="selected" <%}} %>  style="text-align: left;"><%=direction %></option>
																		<%} %>
																	</select>
												                    <%-- <textarea class="form-control form-control" name="dmcDirection" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
                              		  								 placeholder="Enter Direction of DMC" required><%if(soc!=null && soc.getDMCDirection()!=null){ %><%=soc.getDMCDirection() %><%} %></textarea>  --%>
												                </div>
												            </div>
												            
												        </div>
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">
												        	<div class="col-md-6" style="">
												        		<div class="form-group">
												                	<label class="control-label">Present Status:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="presentStatus" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
                              		  								 placeholder="Enter Present Status" required><%if(soc!=null && soc.getPresentStatus()!=null){ %><%=soc.getPresentStatus() %><%} %></textarea> 
												                </div>
												            </div>
												            <div class="col-md-6" style="">
												        		<div class="form-group">
												                	<label class="control-label">Detailed reasons/considerations for closure:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="reason" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
                              		  								 placeholder="Enter Detailed reasons/considerations for closure" required><%if(soc!=null && soc.getReason()!=null){ %><%=soc.getReason() %><%} %></textarea> 
												                </div>
												            </div>
												        </div>
												        
												        <div class="row" id="recommendationdiv" style="margin-left: 2%;margin-right: 2%;">
												        	<div class="col-md-12" style="">
												        		<div class="form-group">
												                	<label class="control-label">Recommendation of Review Committee for Project success:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="recommendation" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
                              		  								 placeholder="Enter Recommendation of Review Committee for Project success"><%if(soc!=null && soc.getRecommendation()!=null){ %><%=soc.getRecommendation() %><%} %></textarea> 
												                </div>
												            </div>
												        </div>
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">
												        	<div class="col-md-6" style="">
												        		<div class="form-group">
												                	<label class="control-label">Recommendations of the highest monitoring committee for closure:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control" name="monitoringCommittee" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
                              		  								 placeholder="Enter Minutes of Monitoring Committee Meetings held so far and recommendations of the highest monitoring committee for closure of the project/programme" required><%if(soc!=null && soc.getMonitoringCommittee()!=null){ %><%=soc.getMonitoringCommittee() %><%} %></textarea> 
												                </div>
												            </div>
												            <div class="col-md-6" style="">
												        		<div class="form-group">
												                	<label class="control-label">Other relevant details:</label>
												                    <textarea class="form-control form-control" name="otherRelevant" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
                              		  								 placeholder="Enter Other relevant details" ><%if(soc!=null && soc.getOtherRelevant()!=null){ %><%=soc.getOtherRelevant() %><%} %></textarea> 
												                </div>
												            </div>
												        </div>
												        
												        <div class="row" style="margin-left: 2%;margin-right: 2%;">
												        	<div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label">Monitoring Committee:</label><span class="mandatory">*</span>
												                	<%if(soc!=null && soc.getMonitoringCommitteeAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="monitoringcommitteefile" formaction="ProjectClosureSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="monitoringCommitteeAttach" <%if(soc==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												            <div class="col-md-3" style="">
												        		<div class="form-group">
												                	<label class="control-label">Lessons Learnt:</label><span class="mandatory">*</span>
												                    <%if(soc!=null && soc.getLessonsLearnt()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="lessonslearntfile" formaction="ProjectClosureSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Lessons Learnt Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="lessonsLearnt" <%if(soc==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												            
												        </div>
												        
								               			<div align="center" style="margin-top: 1rem; margin-bottom: 1rem;">
															<%if(soc!=null){ %>
															    <input type="hidden" name="closureId" value="<%=soc.getClosureId()%>">
																<button type="submit" class="btn btn-sm btn-warning edit btn-soc" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
															<%}else{ %>
																<button type="submit" class="btn btn-sm btn-success submit btn-soc" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
															<%} %>
														</div>
						
												    </form>
												</div>
											</div>
               							</div>
               						</div>
               					</div>
               					<div style="display: flex;justify-content: space-between;">
               						<div></div>
		               				<div class="navigation_btn"  style="text-align: center;">
		               					<%if(soc!=null){ %>
				               				<form action="">
				               					<button type="submit" class="btn btn-sm " formaction="ProjectClosureSoCDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="SoC Download" style="background-color: purple;border: none;color: white;font-weight: bold;">SoC</button>
				               					<input type="hidden" name="closureId" value="<%=closureId%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				               				</form>
			               				<%} %>
									</div>
		               				<div class="navigation_btn"  style="text-align: right;">
            							<a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectClosureList.htm" style="color: white!important">Back</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               					
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** SoC Forward ***********      --> 
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="socforward" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socforward" role="tabpanel">
               			<%} %>
               					<%if(soc!=null) {%>
               						<div class="col-md-8 mt-2">
               							<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%; <%if(isApproval==null) {%>max-height: 600px;<%} else{%>max-height: 700px;<%} %>  overflow-y: auto;">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   									<input type="hidden" name="closureId" value="<%=closureId%>">
                   									<input type="hidden" name="closureSoCId" value="<%=soc.getClosureSoCId()%>">
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
												    		<td>: <%if(projectMaster.getEndUser()!=null) {%> <%=projectMaster.getEndUser() %><%} else{%>--<%} %> and <%if(soc.getQRNo()!=null && !soc.getQRNo().isEmpty()) {%> <%=soc.getQRNo() %><%} else{%>NA<%} %> </td>
												    	</tr>
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
												    		<td style="width: 40%;">Statement of Accounts ( as on <%-- <%if(soc.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(soc.getExpndAsOn()) %><%} %> --%> )</td>
												    		<td>: Expenditure incurred (<span style="font-size: 12px;">&#x20B9;</span> Cr) 
												    		: Total <span style="text-decoration: underline;">
												    			<%-- <%=String.format("%.2f", Double.parseDouble(soc.getTotalExpnd())/10000000 ) %> --%>
												    			<%if(expndDetails!=null && expndDetails[0]!=null) {%>
												    				<%=df.format(Double.parseDouble(expndDetails[0].toString())/10000000 ) %> 
												    			<%} %>
												    		</span> Cr 
												    		(FE <span style="text-decoration: underline;">
												    			<%-- <%=String.format("%.2f", Double.parseDouble(soc.getTotalExpndFE())/10000000 ) %> --%>
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
												    		<td style="">: <%=soc.getPresentStatus() %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Detailed reasons/considerations for Project <%=closure.getClosureCategory() %> </td>
												    		<td style="">: <%if(soc.getReason()!=null) {%><%=soc.getReason() %> <%} else{%>-<%} %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Recommendation of Review Committee for Project success (as applicable)</td>
												    		<td style="">: <%if(soc.getRecommendation()!=null && !soc.getRecommendation().isEmpty()) {%><%=soc.getRecommendation() %> <%} else{%>NA<%} %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">
												    			Minutes of Monitoring Committee Meetings held so far and recommendations 
												 				of the highest monitoring committee for closure of the project/programme
												 			</td>
												    		<td style="">: <%=soc.getMonitoringCommittee() %>
												    			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 		     value="monitoringcommitteefile" formaction="ProjectClosureSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Download">
                            					 				 	<i class="fa fa-download fa-lg"></i>
                            					 				</button>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Direction of DMC</td>
												    		<td style="">: <%=soc.getDMCDirection() %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Lessons Learnt</td>
												    		<td style="">: 
												    		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 		 value="lessonslearntfile" formaction="ProjectClosureSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Lessons learnt Download">
                            					 				<i class="fa fa-download fa-lg"></i>
                            					 			</button>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Other relevant details</td>
												    		<td style="">: <%if(soc.getOtherRelevant()!=null && !soc.getOtherRelevant().isEmpty()) {%><%=soc.getOtherRelevant() %> <%} else{%>--<%} %></td>
												    	</tr>
   	 												</table>
   	 												
   	 												<br>
			               		   					
			               		   					<!-- Signatures and timestamps -->
			               		   					
													<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
		               								 	<div style="font-size: 15px;">Project Director</div>
						               					<%for(Object[] apprInfo : socApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("SFW")){ %>
						   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
						   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
						   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
						   			    				<%break;}} %>  
							            			 </div>
							            			 
							            			 <%for(Object[] apprInfo : socApprovalEmpData) {%>
							            			 	<div style="width: 96%;text-align: left;margin-left: 40px;line-height: 10px;margin-top: 50px;">
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("SAG")){ %>
							            			 			<div style="font-size: 15px;"> Signature of GD</div>
								   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAA")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of AD</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAP")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of GD-DP&C</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of Director</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAC")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of Competent Authority</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>
							   			    			
							   			    				<%} %>
							            			 	</div>	
							            			 <%} %>
							            			 
							            			 <!-- Remarks History -->
							            			 <div class="row mt-2" style="margin-left: 18px;">
														<%if(socRemarksHistory.size()>0){ %>
															<div class="col-md-8" align="left" style="margin: 10px 0px 5px 25px; padding:0px;border: 1px solid black;border-radius: 5px;">
																<%if(socRemarksHistory.size()>0){ %>
																	<table style="margin: 3px;padding: 0px">
																		<tr>
																			<td style="border:none;padding: 0px">
																			<h6 style="text-decoration: underline;">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : socRemarksHistory){%>
																		<tr>
																			<td style="border:none;width: 80%;overflow-wrap: anywhere;padding: 0px">
																				<%=obj[3]%>&nbsp; :
																				<span style="border:none; color: blue;">	<%=obj[1] %></span>
																			</td>
																		</tr>
																		<%} %>
																	</table>
																<%} %>
															</div>
														<%} %>
					   								</div>
							            			
							            			<div class="row mt-2 mb-4" style="margin-left: 18px;">
														<div class="col-md-12" align="center">
															<%if(statuscode!=null && socforward.contains(statuscode)) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" name="Action" formaction="ProjectClosureSoCApprovalSubmit.htm" value="A" onclick="return confirm('Are you Sure to Submit ?');">Forward</button>
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
								         						<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
										    						Approve	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" style="font-weight: 600;">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
															<%} }%>
														</div>
                   									</div>
                   						 
			               						</form>
			               					</div>
			               				</div>
			               			</div>
			               							
               					
               					<%} else{%>
			               			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
			               				<h4 style="font-weight: bold;color: red;">Please fill SoC Details..!</h4>
			               			</div>
               					<%} %>
               					
               					<div style="display: flex;justify-content: space-between;">
	               					<div></div>
		               				<div>
		               					<%if(isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For SoC Approval</b></div>
				 	    				</div>
				 	    				<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
			                							PD -  <%=PDData[2] %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
			                							GD - <%if(GD!=null) {%><%=GD[1] %> <%} else{%>GD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #9b999a 10%, transparent 115%);">
			                							AD - <%if(AD!=null) {%><%=AD[1] %> <%} else{%>AD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #76ebcb 10%, transparent 115%);">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=GDDPandC[1] %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #13f816 10%, transparent 115%);">
			                							Director - <%if(Director!=null) {%><%=Director[1] %> <%} else{%>Director<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #00c7e4 10%, transparent 115%);">
			                							Competent Authority - Competent Authority
			                	    				</td>
			               						</tr> 	
			               	    			</table>			             
					 					</div>
					 					<%} %>
		               				</div>
		               				<div class="navigation_btn"  style="text-align: right;">
		            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               			
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("2")){ %> 
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

<!-- <script type="text/javascript">
$(document).ready(function(){
	closurecategorychange();
});

function closurecategorychange(){
	var closureCategory = $('#closureCategory').val();
	
	if(closureCategory=='Completed Successfully' || closureCategory=='Partial Success'){
		$('#recommendationdiv').show();
		$('#recommendation').prop('required', true);
	}else{
		$('#recommendationdiv').hide();
		$('#recommendation').prop('required', false);
	}
}
</script> -->

<script type="text/javascript">
/* button disabling for SoC Approval */
<%if((soc!=null && socforward.contains(closure.getClosureStatusCode())) || soc==null) {%>
$('.btn-soc').prop('disabled',false);
<%} else{%>
$('.btn-soc').prop('disabled',true);
<%} %>

/* tabs hiding for SoC approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("Y") || isApproval.equalsIgnoreCase("N"))) {%>
   $('.navigation_btn').hide();
   $('#nav-socdetails').hide();
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
function LabcodeSubmit() {
	   var LabCode = document.getElementById("LabCode").value;
	   $('#approverEmpId').empty();
	   $.ajax({
	       type: "GET",
	       url: "GetLabcodeEmpList.htm",
	       data: {
	       	LabCode: LabCode
	       },
	       dataType: 'json',
	       success: function(result) {
	    	   if (result != null && LabCode!='@EXP') {
	    	   for (var i = 0; i < result.length; i++) {
                   var data = result[i];
                   var optionValue = data[0];
                   var optionText = data[1].trim() + ", " + data[3]; 
                   var option = $("<option></option>").attr("value", optionValue).text(optionText);
                   $('#approverEmpId').append(option); 
               }
	    	   $('#approverEmpId').select2();
               }else{
               	for (var i = 0; i < result.length; i++) {
                       var data = result[i];
                       var optionValue = data[0];
                       var optionText = data[1].trim() + ", " + data[3]; 
                       var option = $("<option></option>").attr("value", optionValue).text(optionText);
                       $('#approverEmpId').append(option); 
                   }
               	$('#approverEmpId').select2();
               }
	               
	           }
	   });
	}
	
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