<%@page import="com.vts.pfms.cars.model.CARSRSQRDeliverables"%>
<%@page import="com.vts.pfms.cars.model.CARSRSQRMajorRequirements"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@page import="java.util.List"%>
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

.modalbtn{
font-family: "Montserrat", "Helvetica Neue", Arial, sans-serif !important;
font-weight: 800 !important;
}
.nav-link{
	text-align: left;
}
.nav-tabs>.nav-item>.nav-link{
	padding: 11px 15px !important;
}
body { 
   overflow-x: hidden;
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

#scrollclass::-webkit-scrollbar {
    width:7px;
}
#scrollclass::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
#scrollclass::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}

#rsqrapprovaltable{
	width : 98%;
	border : 1px solid black;
	margin-top : 1.5rem;
	font-size: 15px;
}
#rsqrapprovaltable td{
	border : 1px solid black;
	text-align: left;
	padding : 5px;
}
</style>

</head>
<body>

<%
String TabId=(String)request.getAttribute("TabId"); 
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData"); 
String carsInitiationId =(String)request.getAttribute("carsInitiationId");
carsInitiationId = carsInitiationId!=null?carsInitiationId:"0";
List<Object[]> projectList =(List<Object[]>)request.getAttribute("ProjectList");

String attributes=(String)request.getAttribute("attributes");
List<CARSRSQRMajorRequirements> majorReqr = (List<CARSRSQRMajorRequirements>)request.getAttribute("RSQRMajorReqr");
List<CARSRSQRDeliverables> deliverables = (List<CARSRSQRDeliverables>)request.getAttribute("RSQRDeliverables");


List<String> rsqrforward = Arrays.asList("INI","RGD","RPD");

List<String> statesList  = Arrays.asList("Andaman and Nicobar Islands", "Andhra Pradesh", "Arunachal Pradesh", "Assam","Bihar", "Chandigarh", "Chhattisgarh",
		                                 "Dadra and Nagar Haveli and Daman and Diu", "Delhi", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu and Kashmir",
		                                 "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya",
		                                 "Mizoram", "Nagaland", "Ladakh", "Lakshadweep", "Odisha", "Punjab", "Puducherry",
		                                 "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal");
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
         <div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 130px;">
             <h3 class="category">Initiation Details <%if(carsIni!=null && carsIni.getCARSNo()!=null) {%>- <%=carsIni.getCARSNo() %> <%} %>
               <a class="btn btn-info btn-sm  shadow-nohover back" href="CARSInitiationList.htm" style="color: white!important; float: right;">BACK</a>
             </h3>
             <hr style=" margin: 0 !important;">
             <ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >
            	<li class="nav-item" id="nav">
             		<%if(TabId!=null&&TabId.equalsIgnoreCase("1")){ %> 
             		    <a class="nav-link active " data-toggle="tab" href="#home" id="nav" role="tab">
             		<%}else{ %>
              			 <a class="nav-link  " data-toggle="tab" href="#home" role="tab">
               		 <%} %>  
                	         INITIATION
              			 </a>
            	</li>
            	<li class="nav-item">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("2")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#rsqr" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#rsqr" role="tab" >
               		 <%} %>
                  		RSQR
              			</a>
            	</li>
            	<li class="nav-item">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#rsqrapproval" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#rsqrapproval" role="tab" >
               		 <%} %>
                  		RSQR Approval
              			</a>
            	</li>
              </ul>
         </div>
         <!-- This is for Tab Panes -->
         <div class="card">
         	<div class="tab-content text-center" style="margin-top : 0.2rem;">
         		<!-- *********** INITIATION  ***********      -->  
         		<%if(TabId!=null&&TabId.equalsIgnoreCase("1")){ %> 
         			<div class="tab-pane active" id="home" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="home" role="tabpanel">
               	<%} %>
               	    <%if(carsIni!=null) {%>
               		 <form action="CARSInitiationEdit.htm" method="POST" name="inieditform" id="inieditform">
               		<%} else {%>
               		 <form action="CARSInitiationAdd.htm" method="POST" name="iniaddform" id="iniaddform"> 
               		<%} %>
               		   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               			<div class="row">
               			    <div class="col-md-12" style="margin-left: 60px;margin-right: 60px;">
               			    <!-- First row of Initiation  -->
               			     <div class="row details">
                        		<div class="column b" style="width:50%;border-top-left-radius: 5px;">
                            		<label class="control-label">Title</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="initiationTitle" id="initiationTitle" maxlength="225" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getInitiationTitle()!=null){ %><%=carsIni.getInitiationTitle()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 44.5%;border-top-right-radius: 5px;">
                            		<label class="control-label">Aim</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="initiationAim" id="initiationAim" maxlength="500" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getInitiationAim()!=null){ %><%=carsIni.getInitiationAim()%><%} %>" required> 
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Second row of Initiation  -->
                    		 <div class="row details" >
                    		 	<div class="column b" style="width: 50%;border-top-left-radius: 5px;">
                            		<label class="control-label">Justification</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="justification" id="justification" maxlength="100" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getJustification()!=null){ %><%=carsIni.getJustification()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 30.5%;border-top-left-radius: 5px;">
                            		<label class="control-label">Funds From</label><span class="mandatory">*</span>
                              		<select class="form-control selectdee" name="fundsFrom" style="margin-left: 12px;"  id="fundsFrom">
			                			<option value="" disabled="disabled" selected="selected">--Select--</option>
			                			<option value="0" <%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>selected <%} %> >Buildup</option>
			               				 <%
			                				for(Object[] protype: projectList ){
			                					String projectshortName=(protype[17]!=null)?" ("+protype[17].toString()+") ":"";
			                			 %>
											<option value="<%=protype[0] %>" <%if(carsIni!=null && carsIni.getFundsFrom()!=null){ if(protype[0].toString().equalsIgnoreCase(carsIni.getFundsFrom())){%>selected="selected" <%}} %>><%=protype[4]+projectshortName %></option>
										<%} %>
									</select>
                        		</div>
                        		<div class="column b" style="width: 14%;border-top-left-radius: 5px;">
                            		<label class="control-label">Duration (In months)</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="duration" id="duration" maxlength="100" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getDuration()!=null){ %><%=carsIni.getDuration()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Third row of Initiation  -->
                    		 <div class="row details">
                    		    <div class="col-md-6" style="text-align: left;">
                    		    	<label class="control-label" style="color: black;">RSP Details :</label>
                    		    </div>
                    		 </div>
                    		 <div class="row details">
                        		<div class="column b" style="width:30%;border-top-left-radius: 5px;">
                            		<label class="control-label">Address</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspAddress" id="rspAddress" maxlength="1000" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getRSPAddress()!=null){ %><%=carsIni.getRSPAddress()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 20%;border-top-right-radius: 5px;">
                            		<label class="control-label">City</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspCity" id="rspCity" maxlength="500" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getRSPCity()!=null){ %><%=carsIni.getRSPCity()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 20%;border-top-right-radius: 5px;">
                            		<label class="control-label">Pin Code</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspPinCode" id="rspPinCode" maxlength="6" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getRSPPinCode()!=null){ %><%=carsIni.getRSPPinCode()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
                        		</div>
                        		<div class="column b" style="width: 24.5%;border-top-right-radius: 5px;">
                            		<label class="control-label">State</label><span class="mandatory">*</span>
                            		<select class="form-control selectdee" name="rspState" style="margin-left: 12px;"  id="rspState">
			                			<option value="" disabled="disabled" selected="selected">--Select--</option>
			               				 <%
			                				for(String state: statesList ){
			                			 %>
											<option value="<%=state%>" <%if(carsIni!=null && carsIni.getRSPState()!=null){ if(state.equalsIgnoreCase(carsIni.getRSPState())){%>selected="selected" <%}} %>><%=state %></option>
										<%} %>
									</select>
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Fourth row of Initiation  -->
                    		 <div class="row details">
                    		    <div class="col-md-6" style="text-align: left;">
                    		    	<label class="control-label" style="color: black;">Principal Investigator Details :</label>
                    		    </div>
                    		 </div>
                    		 <div class="row details">
                        		<div class="column b" style="width: 10%;border-top-right-radius: 5px;">
                            		<label class="control-label">Title</label><span class="mandatory">*</span>
                            		<%-- <select class="form-control selectdee" name="piTitle" required="required">
										<option value="Mr" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Mr")) {%>selected<%} %> >Mr</option>
										<option value="Ms" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Ms")) {%>selected<%} %> >Ms</option>
										<option value="Dr" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Dr")) {%>selected<%} %> >Dr</option>
									</select> --%>
                              		<input  class="form-control form-control" type="text" name="piTitle" id="piTitle" maxlength="100" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getPITitle()!=null){ %><%=carsIni.getPITitle()%><%} %>" required>  
                        		</div>
                        		<div class="column b" style="width: 20%;border-top-left-radius: 5px;">
                            		<label class="control-label">Name</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piName" id="piName" maxlength="100" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getPIName()!=null){ %><%=carsIni.getPIName()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 20%;border-top-right-radius: 5px;">
                            		<label class="control-label">Department</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piDept" id="piDept" maxlength="100" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getPIDept()!=null){ %><%=carsIni.getPIDept()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 20%;border-top-right-radius: 5px;">
                            		<label class="control-label">Mobile Number</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piMobileNo" id="piMobileNo" maxlength="10" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getPIMobileNo()!=null){ %><%=carsIni.getPIMobileNo()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
                        		</div>
                        		<div class="column b" style="width: 24.5%;border-top-right-radius: 5px;">
                            		<label class="control-label">Email</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piEmail" id="piEmail" maxlength="50" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getPIEmail()!=null){ %><%=carsIni.getPIEmail()%><%} %>" required> 
                        		</div>
                    		 </div>
                    		 
                    		</div>
               			</div>
               			<br>
               			<div align="center">
							<%if(carsIni!=null){ %>
							    <input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
								<button type="submit" class="btn btn-sm btn-warning edit" onclick="return confirm('Are you sure to submit?')" >UPDATE</button>
							<%}else{ %>
								<button type="submit" class="btn btn-sm btn-success submit" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
							<%} %>
						</div>
               		 <%if(carsIni!=null) {%>
               		  </form>
               		 <%}else {%>
               		  </form>
               		 <%} %>
               		<div class="navigation_btn"  style="text-align: right;">
            			<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSInitiationList.htm" style="color: white!important">Back</a>
						<button class="btn btn-info btn-sm next">Next</button>
					</div>
               	<%if(TabId==null){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** RSQR  ***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("2")){ %> 
         			<div class="tab-pane active" id="rsqr" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="rsqr" role="tabpanel">
               	<%} %>
               		<%int rsqrslno = 0; %>
               		
               		<div class="container-fluid">
						<div class="row">
							<div class="col-md-4">
								<div class="card" style="border-color: #00DADA; margin-top: 2%;">
									<div class="card-body" id="scrollclass" style="height: 30.5rem;">

										<div class="panel panel-info" style="margin-top: 10px;" >
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Introduction</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor1" onclick="showEditor('Introduction')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>

										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Research Overview</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor2" onclick="showEditor('Research Overview')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Objectives</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor3"onclick="showEditor('Objectives')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Major Requirements</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor4" onclick="showTableMajorReqr('<%=carsInitiationId%>')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Deliverables</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor5" onclick="showTableDeliverables('<%=carsInitiationId%>')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Proposed Milestones & Timelines</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor6" onclick="showEditor('Proposed Milestones Timelines')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Scope of RSP</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor7" onclick="showEditor('RSP Scope')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Scope of LRDE</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor8" onclick="showEditor('LRDE Scope')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Success Criterion</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor9" onclick="showEditor('Success Criterion')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 14px"> <%=++rsqrslno %>. Literature Reference if any</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor10" onclick="showEditor('Literature Reference')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
										
									</div>
								</div>
							</div>
							
							<!--div for Editor-->
							<div class="col-md-8" style="display: block" id="col1">
			  					<form action="RSQRDetailsSubmit.htm" method="POST" id="myfrm">
									<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
										<h5 class="heading ml-4 mt-3" id="editorHeading"style="font-weight: 500; color: #31708f;">Introduction</h5>
										<hr>
										<div class="card-body" style="margin-top:-8px">
											<div class="row">
												<div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
													<div id="Editor" class="center"></div>
													<textarea name="Details" style="display: none;"></textarea>
													<div class="mt-2" align="center" id="detailsSubmit">
														<span id="EditorDetails"></span>
														<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
														<input type="hidden" id="attributes" name="attributes" value="Introduction">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<span id="Editorspan">
														    <%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%> 
															<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-success submit mt-2" onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button></span>
															<span id="btn2" style="display: none;"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure you want to submit?')">UPDATE</button></span>
															<%} %>
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
							<!-- editor ends  -->
							
							<!-- Cloning table for Major Requirements -->
							<div class="col-md-8" style="display: none" id="col2">
								<div class="card-body bg-light mt-3">
									<form action="RSQRMajorReqrSubmit.htm" method="post">
										<table style="width:100% ; " id="majorReqrTable">
											<thead style = "background-color: #055C9D; color: white;text-align: center;">
												<tr>
													<th style="padding: 0px 5px 0px 5px;">Req Id</th>
											    	<th style="padding: 0px 5px 0px 5px;">Req Description</th>
											    	<th style="padding: 0px 5px 0px 5px;">Relevant Specification</th>
											    	<th style="padding: 0px 5px 0px 5px;">Validation Method</th>
											    	<th style="padding: 0px 5px 0px 5px;">Remarks</th>
													<td style="width:10%;">
														<button type="button" class=" btn btn_add_majorreqr "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
													</td>
												</tr>
											</thead>
							 				<tbody>
							 					<%if(majorReqr!=null && majorReqr.size()>0) {
							 					   for(CARSRSQRMajorRequirements mr :majorReqr) {%>
							 					<tr class="tr_clone_majorreqr">
													<td style="padding: 10px 5px 0px 5px;" >
														<input type="text" class="form-control item" name="reqId" value="<%if(mr.getReqId()!=null) {%><%=mr.getReqId() %><%} %>" maxlength="50" required="required" >
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="reqDescription" value="<%if(mr.getReqDescription()!=null) {%><%=mr.getReqDescription() %><%} %>" maxlength="100" required="required" >
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="relevantSpecs" value="<%if(mr.getRelevantSpecs()!=null) {%><%=mr.getRelevantSpecs() %><%} %>" maxlength="100">
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="validationMethod" value="<%if(mr.getValidationMethod()!=null) {%><%=mr.getValidationMethod() %><%} %>" maxlength="100" required="required" >
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="remarks" value="<%if(mr.getRemarks()!=null) {%><%=mr.getRemarks() %><%} %>" maxlength="100" >
													</td>	
													<td style="width:10% ; ">
														<button type="button" class=" btn btn_rem_majorreqr " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
													</td>									
												</tr>
							 					<%} }else{%>
												<tr class="tr_clone_majorreqr">
													<td style="padding: 10px 5px 0px 5px;" >
														<input type="text" class="form-control item" name="reqId" maxlength="50" required="required" >
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="reqDescription" maxlength="100" required="required" >
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="relevantSpecs" maxlength="100">
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="validationMethod" maxlength="100" required="required" >
													</td>	
													<td style="padding: 10px 5px 0px 5px;">
														<input type="text" class="form-control item" name="remarks" maxlength="100" >
													</td>	
													<td style="width:10% ; ">
														<button type="button" class=" btn btn_rem_majorreqr " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
													</td>									
												</tr>
												<%} %>
											</tbody> 
										</table>
										<div align="center" style="margin-top: 15px;">
											<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
												<%if(majorReqr!=null && majorReqr.size()>0) {%>
													<button type="submit" class="btn btn-sm btn-warning edit mt-2" name="submit" onclick="return confirm('Are you sure to submit?')">UPDATE</button>
												<%} else{%> 
													<button type="submit" class="btn btn-sm submit" name="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
												<%} %>
												<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
												<input type="hidden" id="attributes" name="attributes" value="Major Requirements">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<%} %>
										</div>
									</form>	
								</div>
							</div>
							
							<!-- Cloning table for Deliverables -->
							<div class="col-md-8" style="display: none" id="col3">
								<div class="card-body bg-light mt-3">
									<form action="RSQRDeliverablesSubmit.htm" method="post">
										<table style="width:100% ; " id="deliverablesTable">
											<thead style = "background-color: #055C9D; color: white;text-align: center;">
												<tr>
											    	<th style="width: 70%;padding: 0px 5px 0px 5px;">Description</th>
											    	<th style="width: 20%;padding: 0px 5px 0px 5px;">Type</th>
													<td style="width:10%;">
														<button type="button" class=" btn btn_add_deliverables "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
													</td>
												</tr>
											</thead>
							 				<tbody>
							 					<%if(deliverables!=null && deliverables.size()>0) {
							 					   for(CARSRSQRDeliverables del :deliverables) {%>
												<tr class="tr_clone_deliverables">
													<td style="width: 70%;padding: 10px 5px 0px 5px;" >
														<input type="text" class="form-control item" name="description" value="<%if(del.getDescription()!=null) {%><%=del.getDescription() %><%} %>" maxlength="200" required="required" >
													</td>	
													<td style="width: 20%;padding: 10px 5px 0px 5px;">
														<select class="form-control deliverabletype" name="deliverableType" required="required">
															<option value="H" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("H")) {%>selected<%} %> >Hardware</option>
															<option value="S" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("S")) {%>selected<%} %> >Software</option>
															<option value="R" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("R")) {%>selected<%} %> >Report</option>
														</select>
													</td>	
													<td style="width:10% ; ">
														<button type="button" class=" btn btn_rem_deliverables " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
													</td>									
												</tr>
												<%} }else{%>
												<tr class="tr_clone_deliverables">
													<td style="width: 70%;padding: 10px 5px 0px 5px;" >
														<input type="text" class="form-control item" name="description" maxlength="200" required="required" >
													</td>	
													<td style="width: 20%;padding: 10px 5px 0px 5px;">
														<select class="form-control deliverabletype" name="deliverableType" required="required">
															<option value="H">Hardware</option>
															<option value="S">Software</option>
															<option value="R">Report</option>
														</select>
													</td>	
													<td style="width:10% ; ">
														<button type="button" class=" btn btn_rem_deliverables " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
													</td>									
												</tr>
												<%} %>
											</tbody> 
										</table>
										<div align="center" style="margin-top: 15px;">
											<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
												<%if(deliverables!=null && deliverables.size()>0) {%>
													<button type="submit" class="btn btn-sm btn-warning edit mt-2" name="submit" onclick="return confirm('Are you sure to submit?')">UPDATE</button>
												<%} else{%> 
													<button type="submit" class="btn btn-sm submit" name="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
												<%} %>
												<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
												<input type="hidden" id="attributes" name="attributes" value="Deliverables">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<%} %>
										</div>
									</form>	
								</div>
							</div>
			
		                </div>
		     			<hr class="mt-2">
					</div>
               		
               		<div style="display: flex;justify-content: space-between;">
               			<div></div>
               			<div class="navigation_btn"  style="text-align: center;">
               				<form action="">
               					<button type="submit" class="btn btn-sm submit" formaction="CARSRSQRDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="RSQR Download" style="background-color: purple;border: none;">RSQR</button>
               					<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               				</form>
						</div>
               			<div class="navigation_btn" style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
							<button class="btn btn-info btn-sm next">Next</button>
						</div>
               		</div>
               		
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("2")){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** RSQR  Approval***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %> 
         			<div class="tab-pane active" id="rsqrapproval" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="rsqrapproval" role="tabpanel">
               	<%} %>
               			<%if(carsIni!=null && majorReqr!=null && majorReqr.size()>0 && deliverables!=null && deliverables.size()>0) {%>
               			<div class="col-md-8 mt-4">
               				<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;">
               					<div class="card-body mt-2 ml-4">
               						<form action="">
               							<div class="mt-2" align="center">
               								<h5 style="font-weight: bold;margin-top: 1.5rem;">RSQR Approval</h5>
               							</div>
               							<table id="rsqrapprovaltable">
               								<tr>
               									<td style="width: 5%;text-align: center;">1.</td>
               									<td style="width: 40%;">RSQR Title</td>
               									<td style="width: 53%;color: blue;">
               										Research Service Qualitative Requirement (RSQR) for <%=carsIni.getInitiationTitle() %>
               									</td>
               								</tr>
               								<tr>
               									<td style="width: 3%;text-align: center;">2.</td>
               									<td style="width: 40%;">Name of the address of the Academic Institution</td>
               									<td style="width: 53%;color: blue;">
               										<div style="width : 80% !important">
               										<%=carsIni.getRSPAddress()+", "+carsIni.getRSPCity()+", "+carsIni.getRSPState()+" - "+carsIni.getRSPPinCode() %>.
               										</div>
               									</td>
               								</tr>
               								<tr>
						    					<td style="width: 5%;text-align: center;" >3.</td>
						    					<td style="width: 40%;" >Name of the Principal Investigator</td>
						    					<td style="width: 53%;color: blue;" >
						    						<%=carsIni.getPITitle()+". "+carsIni.getPIName() %>,
						    						<%=carsIni.getPIDept() %> <br>
						    						<%=carsIni.getPIMobileNo() %> <br>
						    						<%=carsIni.getPIEmail() %>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" >4.</td>
						    					<td style="width: 40%;">Duration of the Contract (Months)</td>
						    					<td style="width: 53%;color: blue;"><%=carsIni.getDuration() %> </td>
						    				</tr>
						    				<tr>
						    					<td colspan="3" style="width: 100%;font-size: 14px;">
						    						&emsp;<input type="checkbox"  class="TCBox" >&nbsp;Necessary DRDO-owned equipment and Lab resources will be spared on need basis for execution of the CARS for the duration.
						    					</td>
						    				</tr>
               							</table>
               							<div class="row mt-4 mb-4">
											<div class="col-md-12" align="center">
												<%if(carsIni!=null && rsqrforward.contains(carsIni.getCARSStatusCode())) {%>
													<button type="submit" class="btn btn-sm submit" id="fwd-btn" name="Action" formaction="RSQRApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" disabled="disabled">Forward</button>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												<%} %>
											</div>
                   						</div>
               						</form>
               					</div>
               				</div>
               			</div>
               			<%} else{%>
               			<div style="display: flex;justify-content: center; align-items: center;">
               				<h4 style="font-weight: bold;color: red;">Please fill the Initiation and RSQR Details..!</h4>
               			</div>
               			<%} %>
               		<div class="navigation_btn"  style="text-align: right;">
            			<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
						<button class="btn btn-info btn-sm next">Next</button>
					</div>
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %> 
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

<!-- Script tag for Initiation -->
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

<!-- Script tag for RSQR -->
<script>
		var editor_config = {
			toolbar : [
					{
						name : 'clipboard',
						items : [ 'PasteFromWord', '-', 'Undo', 'Redo' ]
					},
					{
						name : 'basicstyles',
						items : [ 'Bold', 'Italic', 'Underline', 'Strike',
								'RemoveFormat', 'Subscript', 'Superscript' ]
					},
					{
						name : 'links',
						items : [ 'Link', 'Unlink' ]
					},
					{
						name : 'paragraph',
						items : [ 'NumberedList', 'BulletedList', '-',
								'Outdent', 'Indent', '-', 'Blockquote' ]
					},
					{
						name : 'insert',
						items : [ 'Image', 'Table' ]
					},
					{
						name : 'editing',
						items : [ 'Scayt' ]
					},
					'/',

					{
						name : 'styles',
						items : [ 'Format', 'Font', 'FontSize' ]
					},
					{
						name : 'colors',
						items : [ 'TextColor', 'BGColor', 'CopyFormatting' ]
					},
					{
						name : 'align',
						items : [ 'JustifyLeft', 'JustifyCenter',
								'JustifyRight', 'JustifyBlock' ]
					}, {
						name : 'document',
						items : [ 'Print', 'PageBreak', 'Source' ]
					} ],

			removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

			customConfig : '',

			disallowedContent : 'img{width,height,float}',
			extraAllowedContent : 'img[width,height,align]',

			height : 300,

			contentsCss : [ CKEDITOR.basePath + 'mystyles.css' ],

			bodyClass : 'document-editor',

			format_tags : 'p;h1;h2;h3;pre',

			removeDialogTabs : 'image:advanced;link:advanced',

			stylesSet : [

			{
				name : 'Marker',
				element : 'span',
				attributes : {
					'class' : 'marker'
				}
			}, {
				name : 'Cited Work',
				element : 'cite'
			}, {
				name : 'Inline Quotation',
				element : 'q'
			},

			{
				name : 'Special Container',
				element : 'div',
				styles : {
					padding : '5px 10px',
					background : '#eee',
					border : '1px solid #ccc'
				}
			}, {
				name : 'Compact table',
				element : 'table',
				attributes : {
					cellpadding : '6',
					cellspacing : '0',
					border : '1',
					bordercolor : '#ccc'
				},
				styles : {
					'border-collapse' : 'collapse'
				}
			}, {
				name : 'Borderless Table',
				element : 'table',
				styles : {
					'border-style' : 'hidden',
					'background-color' : '#E6E6FA'
				}
			}, {
				name : 'Square Bulleted List',
				element : 'ul',
				styles : {
					'list-style-type' : 'square'
				}
			}, {
				filebrowserUploadUrl : '/path/to/upload-handler'
			}, ]
		};
		CKEDITOR.replace('Editor', editor_config);
	
		function showEditor(a){
			var x=a.toLowerCase();
			$('#col1').show();
			$('#col2').hide();
			$('#col3').hide();
			$('#editorHeading').html=a;
			document.getElementById('editorHeading').innerHTML=a;
			$('#attributes').val(a);
			var html="";
			 $.ajax({
				Type:'GET',
				url:'RSQRDetailsByAjax.htm',
				datatype:'json',
				data:{
					carsinitiationid :<%=carsInitiationId%>,
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					
					if(ajaxresult!=null){
						$('#btn1').show();
						$('#btn2').hide();
					if(x==="introduction" && ajaxresult[2]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[2];
					}
					else if(x==="research overview" && ajaxresult[3]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[3];
					}
					else if(x==="objectives" && ajaxresult[4]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[4];
					}
					else if(x==="proposed milestones timelines" && ajaxresult[5]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[5];
					}
					else if(x==="rsp scope" && ajaxresult[6]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[6];
					}
					else if(x==="lrde scope" && ajaxresult[7]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[7];
					}
					else if(x==="success criterion" && ajaxresult[8]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[8];
					}
					else if(x==="literature reference" && ajaxresult[9]!=null){
						$('#btn2').show();
						$('#btn1').hide();
						html=ajaxresult[9];
					}
					}else{
						$('#btn1').show();
						$('#btn2').hide();
					}
					CKEDITOR.instances['Editor'].setData(html);
				}
			}); 
			
		}
		  
		  $('#myfrm').submit(function() {
				 var data =CKEDITOR.instances['Editor'].getData();
				 $('textarea[name=Details]').val(data);
				 });
		  
		  		$(document).ready(function() {
		 		var a='<%=attributes%>';
		 		var b='<%=carsInitiationId%>';
		 		
				if(a==="Introduction"){
					showEditor(a);
			  	$('#btnEditor1').click();
				}else if(a==="Research Overview"){
					showEditor(a);
				$('#btnEditor2').click();
				}else if(a==="Objectives"){
					showEditor(a);
				$('#btnEditor3').click();
				}
				else if(a==="Major Requirements"){
					showTableMajorReqr(b);
				$('#btnEditor4').click();
				}else if(a==="Deliverables") {
					showTableDeliverables(b);
				$('#btnEditor5').click();
				} 
				else if(a==="Proposed Milestones Timelines") {
					showEditor(a);
				$('#btnEditor6').click();
				}else if(a==="RSP Scope") {
					showEditor(a);
					$('#btnEditor7').click();
				}else if(a==="LRDE Scope") {
					showEditor(a);
					$('#btnEditor8').click();
				}else if(a==="Success Criterion") {
					showEditor(a);
					$('#btnEditor9').click();
				}else if(a==="Literature Reference") {
					showEditor(a);
					$('#btnEditor10').click();
				}
				});
		  		
		  		function showTableMajorReqr(b){
		  			$('#col1').hide();
					$('#col2').show();
					$('#col3').hide();
		  		}
		  		
		  		function showTableDeliverables(b){
		  			$('#col1').hide();
					$('#col2').hide();
					$('#col3').show();
		  		}
</script>	

<script type="text/javascript">

/* Cloning (Adding) the table body rows for Major Requirements */
$("#majorReqrTable").on('click','.btn_add_majorreqr' ,function() {
	
	var $tr = $('.tr_clone_majorreqr').last('.tr_clone_majorreqr');
	var $clone = $tr.clone();
	$tr.after($clone);
	
	$clone.find("input").val("").end();
});


/* Cloning (Removing) the table body rows for Major Requirements */
$("#majorReqrTable").on('click','.btn_rem_majorreqr' ,function() {
	
var cl=$('.tr_clone_majorreqr').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_clone_majorreqr');
  
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});


/* Cloning (Adding) the table body rows for Deliverables */
$("#deliverablesTable").on('click','.btn_add_deliverables' ,function() {
	
	var $tr = $('.tr_clone_deliverables').last('.tr_clone_deliverables');
	var $clone = $tr.clone();
	$tr.after($clone);
	
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Deliverables */
$("#deliverablesTable").on('click','.btn_rem_deliverables' ,function() {
	
var cl=$('.tr_clone_deliverables').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_deliverables');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});
</script>

<script type="text/javascript">


$(document).ready(function(){
    
    $('.TCBox').on('click',function(){
        if($('.TCBox:checked').length == $('.TCBox').length)
        {
        	  $('#fwd-btn').prop('disabled',false);
        }
        else{
        	  $('#fwd-btn').prop('disabled',true);
        }
    });
})


</script>
</body>
</html>