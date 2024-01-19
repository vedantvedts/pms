<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
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

#rsqrapprovaltable,#socforwardtable{
	width : 98%;
	/* border : 1px solid black; */
	margin-top : 1.5rem;
	font-size: 15px;
}
#rsqrapprovaltable td,#socforwardtable td,#alldocstable td{
	border : 1px solid black;
	text-align: left;
	padding : 3px;
}
#alldocstable {
	width : 70%;
	/* border : 1px solid black; */
	margin-top : 1.5rem;
	font-size: 15px;
	margin-left: 10rem;
}
#alldocstable th{
	border : 1px solid black;
	text-align: center;
	padding : 5px;
}

#alldocstable td:first-child,#alldocstable td:nth-child(3){ 
	text-align: center; 
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

</style>

</head>
<body>

<%

String TabId=(String)request.getAttribute("TabId"); 
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC =(CARSSoC)request.getAttribute("CARSSoCData"); 
String carsInitiationId =(String)request.getAttribute("carsInitiationId");
carsInitiationId = carsInitiationId!=null?carsInitiationId:"0";
String carsSoCId = carsSoC!=null?carsSoC.getCARSSoCId()+"":"0";
List<Object[]> projectList =(List<Object[]>)request.getAttribute("ProjectList");

List<Object[]> rsqrApprovalEmpData = (List<Object[]>)request.getAttribute("RSQRApprovalEmpData");
List<Object[]> socApprovalEmpData = (List<Object[]>)request.getAttribute("SoCApprovalEmpData");
List<Object[]> rsqrRemarksHistory = (List<Object[]>)request.getAttribute("CARSRSQRRemarksHistory");
List<Object[]> socRemarksHistory = (List<Object[]>)request.getAttribute("CARSSoCRemarksHistory");

String attributes=(String)request.getAttribute("attributes");
Object[] rsqrDetails = (Object[])request.getAttribute("RSQRDetails");
List<CARSRSQRMajorRequirements> majorReqr = (List<CARSRSQRMajorRequirements>)request.getAttribute("RSQRMajorReqr");
List<CARSRSQRDeliverables> deliverables = (List<CARSRSQRDeliverables>)request.getAttribute("RSQRDeliverables");
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");


List<String> rsqrforward = Arrays.asList("INI","RGD","RPD","REV");
List<String> socforward = Arrays.asList("AGD","APD","SRG","SRP","SRV");

List<String> statesList  = Arrays.asList("Andaman and Nicobar Islands", "Andhra Pradesh", "Arunachal Pradesh", "Assam","Bihar", "Chandigarh", "Chhattisgarh",
		                                 "Dadra and Nagar Haveli and Daman and Diu", "Delhi", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu and Kashmir",
		                                 "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya",
		                                 "Mizoram", "Nagaland", "Ladakh", "Lakshadweep", "Odisha", "Punjab", "Puducherry",
		                                 "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

String isApproval = (String)request.getAttribute("isApproval");

Object[] emp = (Object[])request.getAttribute("EmpData");
Object[] GDs = (Object[])request.getAttribute("GDEmpIds");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

String statuscode = carsIni!=null?carsIni.getCARSStatusCode():null;
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
               <a class="btn btn-info btn-sm  shadow-nohover back" 
               <%if(isApproval!=null && (isApproval.equalsIgnoreCase("Y") || isApproval.equalsIgnoreCase("S") )) {%>
               		href="CARSRSQRApprovals.htm"
               <%} else if(isApproval!=null && ( isApproval.equalsIgnoreCase("N") || isApproval.equalsIgnoreCase("T") )) {%>
               		href="CARSRSQRApprovals.htm?val=app"
               	<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("A")) {%>  
               		href="CARSRSQRApprovedList.htm"
               	<%} else{%> 
               		href="CARSInitiationList.htm"
               	<%} %>
               	 style="color: white!important; float: right;">BACK</a>
             </h3>
             <hr style=" margin: 0 !important;">
             <ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >
            	<li class="nav-item" id="nav-ini">
             		<%if(TabId!=null&&TabId.equalsIgnoreCase("1")){ %> 
             		    <a class="nav-link active " data-toggle="tab" href="#home" id="nav" role="tab">
             		<%}else{ %>
              			 <a class="nav-link  " data-toggle="tab" href="#home" role="tab">
               		<%} %>  
                	         INITIATION
              			 </a>
            	</li>
            	
            	<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
            	
            	<li class="nav-item" id="nav-rsqrdownload">
            		<a class="nav-link" href="CARSRSQRDownload.htm?carsInitiationId=<%=carsInitiationId%>" target="_blank" >RSQR</a>
            		<%-- <form class="nav-link" action="">
               			<button type="submit" class="btn btn-sm submit" formaction="CARSRSQRDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="RSQR Download" style="background-color: purple;border: none;">RSQR</button>
               			<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               		</form> --%>
            	</li>
            	
            	<%} else {%>
            	
            	<li class="nav-item" id="nav-rsqr">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("2")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#rsqr" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#rsqr" role="tab" >
               		<%} %>
                  		RSQR
              			</a>
            	</li>
            	
            	<%} %>
            	
            	<li class="nav-item" id="nav-rsqrapproval">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#rsqrapproval" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#rsqrapproval" role="tab" >
               		<%} %>
                  		RSQR Approval
              			</a>
            	</li>
            	<li class="nav-item" id="nav-soc">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("4")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#soc" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#soc" role="tab" >
               		<%} %>
                  		SoC
              			</a>
            	</li>
            	<li class="nav-item" id="nav-finalrsqr">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("5")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#finalrsqr" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#finalrsqr" role="tab" >
               		<%} %>
                  		Final RSQR
              			</a>
            	</li>
            	<li class="nav-item" id="nav-socmilestones">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("6")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#socmilestones" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#socmilestones" role="tab" >
               		<%} %>
                  		Milestones
              			</a>
            	</li>
            	<li class="nav-item" id="nav-socforward">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("7")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#socforward" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#socforward" role="tab" >
               		<%} %>
                  		SoC Forward
              			</a>
            	</li>
            	<li class="nav-item" id="nav-momupload">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("8")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#momupload" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#momupload" role="tab" >
               		<%} %>
                  		MOM Upload
              			</a>
            	</li>
            	<li class="nav-item" id="nav-alldocs">
            	     <%if(TabId!=null&&TabId.equalsIgnoreCase("9")){ %>
              			<a class="nav-link active" data-toggle="tab" href="#alldocs" id="nav"role="tab" >
              		<%}else{ %>
              			<a class="nav-link" data-toggle="tab" href="#alldocs" role="tab" >
               		<%} %>
                  		All Docs
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
                            		<label class="control-label">CARS Title</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="initiationTitle" id="initiationTitle" maxlength="1000" style="font-size: 15px;"
                              		 placeholder="Enter CARS Title" value="<%if(carsIni!=null && carsIni.getInitiationTitle()!=null){ %><%=carsIni.getInitiationTitle()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 17%;">
                            		<label class="control-label">Funds From</label><span class="mandatory">*</span>
                              		<select class="form-control selectdee" name="fundsFrom" style="margin-left: 12px;"  id="fundsFrom" required>
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
                        		<div class="column b" style="width: 14%;">
                            		<label class="control-label">Amount (In Lakhs, &#8377;)</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="number" name="amount" id="amount" maxlength="16" style="font-size: 15px;"
                              		 placeholder="Enter Amount" value="<%if(carsIni!=null && carsIni.getAmount()!=null){ %><%=Double.parseDouble(carsIni.getAmount())/100000%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
                        		</div>
                        		<div class="column b" style="width: 13.5%;border-top-right-radius: 5px;">
                            		<label class="control-label">Duration (In months)</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="duration" id="duration" maxlength="100" style="font-size: 15px;"
                              		 placeholder="Enter Duration" value="<%if(carsIni!=null && carsIni.getDuration()!=null){ %><%=carsIni.getDuration()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Second row of Initiation  -->
                    		 <div class="row details" >
                        		<div class="column b" style="width: 94.5%;">
                            		<label class="control-label">Aim</label><span class="mandatory">*</span>
                              		<%-- <input  class="form-control form-control" type="text" name="initiationAim" id="initiationAim" maxlength="2000" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getInitiationAim()!=null){ %><%=carsIni.getInitiationAim()%><%} %>" required>  --%>
                              		<%--  <textarea class="form-control form-control" name="initiationAim" id="initiationAim" maxlength="2000" style="font-size: 15px;" rows="3" cols="50" required>
                              		 	<%if(carsIni!=null && carsIni.getInitiationAim()!=null){ %><%=carsIni.getInitiationAim()%><%} %>
                              		 </textarea> --%>
                              		 <textarea class="form-control form-control" name="initiationAim" id="initiationAim" maxlength="2000" rows="2" cols="65" style="font-size: 15px;" 
                              		  placeholder="Enter CARS Aim" required><%if(carsIni!=null && carsIni.getInitiationAim()!=null){ %><%=carsIni.getInitiationAim()%><%} %></textarea>
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Third row of Initiation  -->
                    		 <div class="row details" >
                    		 	<div class="column b" style="width: 94.5%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                            		<label class="control-label">Justification</label><span class="mandatory">*</span>
                              		<textarea  class="form-control form-control" name="justification" id="justification" maxlength="3000" rows="3" cols="65" style="font-size: 15px;"
                              		 placeholder="Enter CARS Justification" required><%if(carsIni!=null && carsIni.getJustification()!=null){ %><%=carsIni.getJustification()%><%} %></textarea>
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Fourth row of Initiation  -->
                    		 <div class="row details">
                    		    <div class="col-md-6" style="text-align: left;">
                    		    	<label class="control-label" style="color: black;">RSP Details :</label>
                    		    </div>
                    		 </div>
                    		 <div class="row details">
                        		<div class="column b" style="width: 25%;border-top-left-radius: 5px;border-bottom-left-radius: 5px;">
                            		<label class="control-label">Name of Institute</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspInstitute" id="rspInstitute" maxlength="1000" style="font-size: 15px;"
                              		 placeholder="Enter Name of Institute" value="<%if(carsIni!=null && carsIni.getRSPInstitute()!=null){ %><%=carsIni.getRSPInstitute()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 25%;border-top-left-radius: 5px;">
                            		<label class="control-label">Address</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspAddress" id="rspAddress" maxlength="1000" style="font-size: 15px;"
                              		 placeholder="Enter Address" value="<%if(carsIni!=null && carsIni.getRSPAddress()!=null){ %><%=carsIni.getRSPAddress()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 15%;">
                            		<label class="control-label">City</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspCity" id="rspCity" maxlength="500" style="font-size: 15px;"
                              		 placeholder="Enter City" value="<%if(carsIni!=null && carsIni.getRSPCity()!=null){ %><%=carsIni.getRSPCity()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 10%;">
                            		<label class="control-label">Pin Code</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="rspPinCode" id="rspPinCode" maxlength="6" style="font-size: 15px;"
                              		 placeholder="Enter Pin Code" value="<%if(carsIni!=null && carsIni.getRSPPinCode()!=null){ %><%=carsIni.getRSPPinCode()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" onchange="validatePinCodeInput(this);" required> 
                        		</div>
                        		<div class="column b" style="width: 19.4%;border-top-right-radius: 5px;border-bottom-right-radius: 5px;">
                            		<label class="control-label">State</label><span class="mandatory">*</span>
                            		<select class="form-control selectdee" name="rspState" style="margin-left: 12px;"  id="rspState" required>
			                			<option value="" disabled="disabled" selected="selected">--Select--</option>
			               				 <%
			                				for(String state: statesList ){
			                			 %>
											<option value="<%=state%>" <%if(carsIni!=null && carsIni.getRSPState()!=null){ if(state.equalsIgnoreCase(carsIni.getRSPState())){%>selected="selected" <%}} %>><%=state %></option>
										<%} %>
									</select>
                        		</div>
                    		 </div>
                    		 
                    		 <!-- Fifth row of Initiation  -->
                    		 <div class="row details">
                    		    <div class="col-md-6" style="text-align: left;">
                    		    	<label class="control-label" style="color: black;">Principal Investigator Details :</label>
                    		    </div>
                    		 </div>
                    		 <div class="row details">
                        		<div class="column b" style="width: 5%;border-top-left-radius: 5px;border-bottom-left-radius: 5px;">
                            		<label class="control-label">Title</label><span class="mandatory">*</span>
                            		<select class="form-control selectdee" name="piTitle" required="required">
										<option value="Mr" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Mr")) {%>selected<%} %> >Mr</option>
										<option value="Ms" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Ms")) {%>selected<%} %> >Ms</option>
										<option value="Dr" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Dr")) {%>selected<%} %> >Dr</option>
										<option value="Prof" <%if(carsIni!=null && carsIni.getPITitle()!=null && carsIni.getPITitle().equalsIgnoreCase("Prof")) {%>selected<%} %> >Prof</option>
									</select>
                              		<%-- <input  class="form-control form-control" type="text" name="piTitle" id="piTitle" maxlength="100" style="font-size: 15px;"
                              		 value="<%if(carsIni!=null && carsIni.getPITitle()!=null){ %><%=carsIni.getPITitle()%><%} %>" required>   --%>
                        		</div>
                        		<div class="column b" style="width: 20%;">
                            		<label class="control-label">Name</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piName" id="piName" maxlength="500" style="font-size: 15px;"
                              		 placeholder="Enter Name of PI" value="<%if(carsIni!=null && carsIni.getPIName()!=null){ %><%=carsIni.getPIName()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 18%;">
                            		<label class="control-label">Designation</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piDesig" id="piDesig" maxlength="500" style="font-size: 15px;"
                              		 placeholder="Enter Designation of PI" value="<%if(carsIni!=null && carsIni.getPIDesig()!=null){ %><%=carsIni.getPIDesig()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 18%;">
                            		<label class="control-label">Department</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piDept" id="piDept" maxlength="500" style="font-size: 15px;"
                              		 placeholder="Enter Department of PI" value="<%if(carsIni!=null && carsIni.getPIDept()!=null){ %><%=carsIni.getPIDept()%><%} %>" required> 
                        		</div>
                        		<div class="column b" style="width: 12%;">
                            		<label class="control-label">Mobile Number</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piMobileNo" id="piMobileNo" min="10" max="10" style="font-size: 15px;"
                              		 placeholder="Enter Mobile No of PI" value="<%if(carsIni!=null && carsIni.getPIMobileNo()!=null){ %><%=carsIni.getPIMobileNo()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" onchange="validateMobileNoInput(this);" required> 
                        		</div>
                        		<div class="column b" style="width: 12%;">
                            		<label class="control-label">Email</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control" type="text" name="piEmail" id="piEmail" maxlength="50" style="font-size: 15px;"
                              		 placeholder="Enter Email of PI" value="<%if(carsIni!=null && carsIni.getPIEmail()!=null){ %><%=carsIni.getPIEmail()%><%} %>" onchange="validateEmailInput(this);" required> 
                        		</div>
                        		<div class="column b" style="width: 9.5%;border-top-right-radius: 5px;border-bottom-right-radius: 5px;">
                            		<label class="control-label">Fax No</label>
                              		<input  class="form-control form-control" type="text" name="piFaxNo" id="piFaxNo" maxlength="50" style="font-size: 15px;" 
                              		 placeholder="Enter Fax No of PI" value="<%if(carsIni!=null && carsIni.getPIFaxNo()!=null){ %><%=carsIni.getPIFaxNo()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"> 
                        		</div>
                    		 </div>
                    		 
                    		</div>
               			</div>
               			<br>
               			<div align="center">
							<%if(carsIni!=null){ %>
							    <input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
								<button type="submit" class="btn btn-sm btn-warning edit btn-cars" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
							<%}else{ %>
								<button type="submit" class="btn btn-sm btn-success submit btn-cars" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
							<%} %>
						</div>
               		 <%if(carsIni!=null) {%>
               		  </form>
               		 <%}else {%>
               		  </form>
               		 <%} %>
               		<div style="display: flex;justify-content: space-between;">
               			<div></div>
               			<div style="text-align: center;">
						</div>
               			<div class="navigation_btn"  style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSInitiationList.htm" style="color: white!important">Back</a>
						<button class="btn btn-info btn-sm next">Next</button>
					</div>
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
									<div class="card-body scrollclass" id="scrollclass" style="height: 30.5rem;">

										<div class="panel panel-info" style="margin-top: 10px;" >
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Introduction</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Research Overview</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Objectives</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Major Requirements</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Deliverables</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Proposed Milestones & Timelines</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Scope of RSP</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Scope of LRDE</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Success Criterion</span>
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
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++rsqrslno %>. Literature Reference if any</span>
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
															<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-success submit mt-2 btn-cars" onclick="return confirm('Are you sure to submit?')">SUBMIT</button></span>
															<span id="btn2" style="display: none;"><button type="submit"class="btn btn-sm btn-warning edit mt-2 btn-cars" onclick="return confirm('Are you sure update?')">UPDATE</button></span>
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
								<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
									<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight: 500; color: #31708f;">Major Requirements</h5>
									<hr>
									<div class="card-body bg-light mt-1">
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
														<td style="padding: 10px 5px 0px 5px;width: 10%;">
															<input type="text" class="form-control item" name="reqId" id="reqId" value="<%if(mr.getReqId()!=null) {%><%=mr.getReqId() %><%} %>" maxlength="50" style="text-align: center;" readonly>
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 30%;">
															<input type="text" class="form-control item" name="reqDescription" value="<%if(mr.getReqDescription()!=null) {%><%=mr.getReqDescription() %><%} %>" maxlength="1000" required="required" >
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="relevantSpecs" value="<%if(mr.getRelevantSpecs()!=null) {%><%=mr.getRelevantSpecs() %><%} %>" maxlength="1000">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="validationMethod" value="<%if(mr.getValidationMethod()!=null) {%><%=mr.getValidationMethod() %><%} %>" maxlength="1000">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 15%;">
															<input type="text" class="form-control item" name="remarks" value="<%if(mr.getRemarks()!=null) {%><%=mr.getRemarks() %><%} %>" maxlength="1000" >
														</td>	
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_majorreqr " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
							 						<%} }else{%>
													<tr class="tr_clone_majorreqr">
														<td style="padding: 10px 5px 0px 5px;width: 10%;" >
															<input type="text" class="form-control item" name="reqId" id="reqId" value="RTD-1" maxlength="50" readonly="readonly" style="text-align: center;">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 30%;">
															<input type="text" class="form-control item" name="reqDescription" maxlength="1000" required="required" >
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="relevantSpecs" maxlength="1000">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="validationMethod" maxlength="1000" >
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 15%;">
															<input type="text" class="form-control item" name="remarks" maxlength="1000" >
														</td>	
														<td style="width:5% ; ">
															<button type="button" class=" btn btn_rem_majorreqr " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} %>
												</tbody> 
											</table>
											<div align="center" style="margin-top: 15px;">
												<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
													<%if(majorReqr!=null && majorReqr.size()>0) {%>
														<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-cars" name="submit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
													<%} else{%> 
														<button type="submit" class="btn btn-sm submit" name="submit btn-cars" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
													<%} %>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
													<input type="hidden" id="attributes" name="attributes" value="Major Requirements">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<%} %>
											</div>
										</form>	
									</div>
								</div>
							</div>
							
							<!-- Cloning table for Deliverables -->
							<div class="col-md-8" style="display: none" id="col3">
								<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
									<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight: 500; color: #31708f;">Deliverables</h5>
									<hr>
									<div class="card-body bg-light mt-1">
										<form action="RSQRDeliverablesSubmit.htm" method="post">
											<table style="width:100% ; " id="deliverablesTable">
												<thead style = "background-color: #055C9D; color: white;text-align: center;">
													<tr>
												    	<th style="width: 80%;padding: 0px 5px 0px 5px;">Description</th>
												    	<th style="width: 10%;padding: 0px 5px 0px 5px;">Type</th>
														<td style="width: 5%;">
															<button type="button" class=" btn btn_add_deliverables "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
														</td>
													</tr>
												</thead>
								 				<tbody>
								 					<%if(deliverables!=null && deliverables.size()>0) {
								 					   for(CARSRSQRDeliverables del :deliverables) {%>
													<tr class="tr_clone_deliverables">
														<td style="width: 80%;padding: 10px 5px 0px 5px;" >
															<input type="text" class="form-control item" name="description" value="<%if(del.getDescription()!=null) {%><%=del.getDescription() %><%} %>" maxlength="1000" required="required" >
														</td>	
														<td style="width: 10%;padding: 10px 5px 0px 5px;">
															<select class="form-control deliverabletype" name="deliverableType" required="required">
																<option value="H" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("H")) {%>selected<%} %> >Hardware</option>
																<option value="S" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("S")) {%>selected<%} %> >Software</option>
																<option value="R" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("R")) {%>selected<%} %> >Report</option>
															</select>
														</td>	
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_deliverables " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} }else{%>
													<tr class="tr_clone_deliverables">
														<td style="width: 80%;padding: 10px 5px 0px 5px;" >
															<input type="text" class="form-control item" name="description" maxlength="1000" required="required" >
														</td>	
														<td style="width: 10%;padding: 10px 5px 0px 5px;">
															<select class="form-control deliverabletype" name="deliverableType" required="required">
																<option value="H">Hardware</option>
																<option value="S">Software</option>
																<option value="R">Report</option>
															</select>
														</td>	
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_deliverables" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} %>
												</tbody> 
											</table>
											<div align="center" style="margin-top: 15px;">
												<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
													<%if(deliverables!=null && deliverables.size()>0) {%>
														<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-cars" name="submit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
													<%} else{%> 
														<button type="submit" class="btn btn-sm submit btn-cars" name="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
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
			
		                </div>
		     			<hr class="mt-2">
					</div>
               		
               		<div style="display: flex;justify-content: space-between;">
               			<div></div>
               			<div class="navigation_btn"  style="text-align: center;">
               				<form action="">
               					<button type="submit" class="btn btn-sm submit" formaction="CARSRSQRDownloadBeforeFreeze.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="RSQR Download" style="background-color: purple;border: none;">RSQR</button>
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
               			<%if(carsIni!=null && rsqrDetails!=null && majorReqr!=null && majorReqr.size()>0 && deliverables!=null && deliverables.size()>0) {%>
               			<div class="col-md-8 mt-4">
               				<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;">
               					<div class="card-body mt-2 ml-4">
               						<form action="">
               							<div class="mt-2" align="center">
               								<h5 style="font-weight: bold;margin-top: 1.5rem;">RSQR Approval
               									&emsp;<button type="submit" class="btn btn-sm" formaction="CARSRSQRApprovalDownload.htm" name="carsInitiationId" value="<%=carsInitiationId%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 				<i class="fa fa-download" aria-hidden="true"></i>
												</button>
											</h5>
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
               									<td style="width: 40%;">Name and address of the Academic Institution</td>
               									<td style="width: 53%;color: blue;">
               										<%=carsIni.getRSPInstitute() %> <br>
               										<%=carsIni.getRSPAddress()+", "+carsIni.getRSPCity()+", "+carsIni.getRSPState()+" - "+carsIni.getRSPPinCode() %>.
               									</td>
               								</tr>
               								<tr>
						    					<td style="width: 5%;text-align: center;" >3.</td>
						    					<td style="width: 40%;" >Name of the Principal Investigator</td>
						    					<td style="width: 53%;color: blue;" >
						    						<%=carsIni.getPITitle()+". "+carsIni.getPIName() %>,
						    						<%=carsIni.getPIDesig() %> <br>
						    						<%=carsIni.getPIDept() %> <br>
						    						<%=carsIni.getPIMobileNo() %> <br>
						    						<%=carsIni.getPIEmail() %> <br>
						    						<%if(carsIni.getPIFaxNo()!=null && !carsIni.getPIFaxNo().isEmpty()){ %>
														<br> <%=carsIni.getPIFaxNo() %>
													<%} %>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" >4.</td>
						    					<td style="width: 40%;">Duration of the Contract (Months)</td>
						    					<td style="width: 53%;color: blue;"><%=carsIni.getDuration() %> </td>
						    				</tr>
						    				<tr>
						    					<td colspan="3" style="width: 100%;font-size: 14px;">
						    						&emsp;<input type="checkbox"  class="TCBox" <%if(statuscode!=null && !rsqrforward.contains(statuscode)) {%>checked<%} %> >&nbsp;Necessary DRDO-owned equipment and Lab resources will be spared on need basis for execution of the CARS for the duration.
						    					</td>
						    				</tr>
               							</table>
               							
               							<br><br>
               							
               							<div style="display: flex;justify-content: space-between;width: 98%;">
               							    <div style="width: 49%;text-align: left;margin-left: 10px;line-height: 10px;">
               							    	<div style="font-size: 15px;">Signature of the initiating officer</div>
												<label style="text-transform: capitalize;margin-top: 15px !important;">
													<%if(emp!=null && emp[1]!=null){%> <%=emp[1]%><%} %>,
												</label><!-- <br> -->
												<label style="text-transform: capitalize;">
													<%if(emp!=null && emp[2]!=null){%> <%=emp[2]%><%} %>
												</label><br>
												<label style="font-size: 12px;">
													Date&nbsp;:&nbsp;<%if(carsIni.getInitiationDate()!=null) {%> <%=fc.SqlToRegularDate(carsIni.getInitiationDate()) %><%} else{%><%=rdf.format(new Date()) %> <%} %>
												</label>
               							    </div>
               								
               								 <div style="width: 49%;text-align: right;margin-right: 10px;line-height: 10px;">
               								 	<div style="font-size: 15px;"> Signature of the <%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>GD<%} else{%>PD<%} %></div>
				               					<%for(Object[] apprInfo : rsqrApprovalEmpData){ %>
				   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("AGD") || apprInfo[8].toString().equalsIgnoreCase("APD")){ %>
				   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				   			    				<%break;}} %>  
				            			 	</div>	
										
										</div>
               							
               							<div class="row mt-2">
											<%if(rsqrRemarksHistory.size()>0){ %>
												<div class="col-md-8" align="left" style="margin: 10px 0px 5px 25px; padding:0px;border: 1px solid black;border-radius: 5px;">
													<%if(rsqrRemarksHistory.size()>0){ %>
														<table style="margin: 3px;padding: 0px">
															<tr>
																<td style="border:none;padding: 0px">
																<h6 style="text-decoration: underline;">Remarks :</h6> 
																</td>											
															</tr>
															<%for(Object[] obj : rsqrRemarksHistory){%>
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
               							
               							<div class="row mt-2 mb-4">
											<div class="col-md-12" align="center">
												<%if(statuscode!=null && rsqrforward.contains(statuscode)) {%>
													<div class="ml-2" align="left">
						   								<b >Remarks :</b><br>
						   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
					         						</div>
													<button type="submit" class="btn btn-sm submit" id="fwd-btn" name="Action" formaction="RSQRApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" disabled="disabled">Forward</button>
												<%} %>
												<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y")) {%>
													<div class="ml-2" align="left">
						   								<b >Remarks :</b><br>
						   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
					         						</div>
													<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="RSQRApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
							    						Approve	
						      						</button>
						      						
						      						<!-- <button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="RSQRApprovalSubmit.htm" name="Action" value="D" onclick="return disapprove();" style="font-weight: 600;">
							   	 						Not Approve	
						      						</button> -->
						      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="RSQRApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
							 							Return
													</button>
												<%} %>
											</div>
                   						</div>
                   						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   						<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
               						</form>
               					</div>
               				</div>
               			</div>
               			<%} else{%>
               			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               				<h4 style="font-weight: bold;color: red;">Please fill the Initiation and RSQR Details..!</h4>
               			</div>
               			<%} %>
               			
               			<div style="display: flex;justify-content: space-between;">
               				<div></div>
               				<div>
               					<%if(carsIni!=null && isApproval==null) {%>
               					<div class="row"  >
		 		  					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For RSQR Approval</b></div>
		 	    				</div>
		 	    				<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
	              					<table align="center"  >
	               						<tr>
	               							<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
	                							Initiator -  <%=emp[1] %>
	                						</td>
	                		
                        					<td rowspan="2">
	                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
	                						</td>
	                						
	                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
	                							<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
	                								GD - <%if(GDs!=null) {%><%=GDs[2] %><%} else{%>GD<%} %>
	                							<%} else{%>
	                								PD - <%if(PDs!=null) {%><%=PDs[2] %><%} else{%>PD<%} %>
	                							<%} %>
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
               			
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** Statement of Case (SoC) ***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("4")){ %> 
         			<div class="tab-pane active" id="soc" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane" id="soc" role="tabpanel">
              	<%} %>
              			<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
              				<%if(carsSoC!=null) {%>
               		 			<form action="CARSSoCEdit.htm" method="POST" name="soceditform" id="soceditform" enctype="multipart/form-data">
               				<%} else {%>
               		 			<form action="CARSSoCAdd.htm" method="POST" name="socaddform" id="socaddform" enctype="multipart/form-data"> 
               				<%} %>
               		   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               		   				<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
               						<div class="row">
               			    			<div class="col-md-12" style="margin-left: 60px;margin-right: 60px;">
               			    				<!-- First row of SoC  -->
               			     				<div class="row details">
                        						<div class="column b" style="width: 25%;border-top-left-radius: 5px;">
                            					 	<label class="control-label">Upload SoO</label><span class="mandatory">*</span> 
                            					 	<%if(carsSoC!=null && carsSoC.getSoOUpload()!=null) {%>
                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-left: -20rem;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  value="soofile" formaction="CARSSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SoO Download">
                            					 			<i class="fa fa-download fa-lg"></i>
                            					 		</button>
                            					 	<%} %>
                              		      			<input type="file" class="form-control modals" name="SoOUpload" <%if(carsSoC==null) {%>required<%} %> accept=".pdf">
                        						</div>
                        						<div class="column b" style="width: 25%;">
                            						<label class="control-label">Upload Feasibility Report</label><span class="mandatory">*</span>
                            						<%if(carsSoC!=null && carsSoC.getFRUpload()!=null) {%>
                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-left: -14rem;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  value="frfile" formaction="CARSSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Feasibility Report Download">
                            					 			<i class="fa fa-download fa-lg"></i>
                            					 		</button>
                            					 	<%} %>
                              						<input type="file" class="form-control modals" name="FRUpload" <%if(carsSoC==null) {%>required<%} %> accept=".pdf">
                        						</div>
                        						<div class="column b" style="width: 20%;">
                            						<label class="control-label">Execution Plan</label><span class="mandatory">*</span>
                            						<%if(carsSoC!=null && carsSoC.getExecutionPlan()!=null) {%>
                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-left: -12rem;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  value="exeplanfile" formaction="CARSSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Execution Plan Download">
                            					 			<i class="fa fa-download fa-lg"></i>
                            					 		</button>
                            					 	<%} %>
                              						<input type="file" class="form-control modals" name="ExecutionPlan" <%if(carsSoC==null) {%>required<%} %> accept=".pdf">
                        						</div>
                        						<div class="column b" style="width: 14%;">
                            						<label class="control-label">Duration (In months)</label><span class="mandatory">*</span>
                              						<input  class="form-control form-control" type="text" name="socDuration" id="socDuration" maxlength="20" style="font-size: 15px;"
                              		 					placeholder="Enter Duration" value="<%if(carsSoC!=null && carsSoC.getSoCDuration()!=null){ %><%=carsSoC.getSoCDuration()%><%} %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
                        						</div>
                        						<div class="column b" style="width: 10.5%;border-top-right-radius: 5px;">
                            					 	<label class="control-label">Alignment with</label><span class="mandatory">*</span>
                            					 	<select class="form-control" name="alignment" required>
                            					 		<option value="L" <%if(carsSoC!=null && carsSoC.getAlignment()!=null && carsSoC.getAlignment().equalsIgnoreCase("L")) {%>selected<%} %>>Lab charter</option>
                            					 		<option value="P" <%if(carsSoC!=null && carsSoC.getAlignment()!=null && carsSoC.getAlignment().equalsIgnoreCase("P")) {%>selected<%} %>>Project charter</option>
                            					 	</select>
                        						</div>
                    		 				</div>
                    		 				
                    		 				<!-- Second row of SoC  -->
                    		 				<div class="row details">
                    		 					<div class="column b" style="width: 94.5%;">
                            					 	<label class="control-label">Justification for time reasonability</label><span class="mandatory">*</span>
                              		      			<textarea class="form-control" name="timeReasonability" placeholder="Enter Justification for time reasonability" cols="" rows="2" required><%if(carsSoC!=null && carsSoC.getTimeReasonability()!=null) {%><%=carsSoC.getTimeReasonability() %><%} %></textarea>
                        						</div>
                    		 				</div>
                    		 				
                    		 				<!-- Third row of SoC  -->
                    		 				<div class="row details">
                    		 					<div class="column b" style="width: 94.5%;">
                            					 	<label class="control-label">Justification for cost reasonability</label><span class="mandatory">*</span>
                              		      			<textarea class="form-control" name="costReasonability" placeholder="Enter Justification for cost reasonability" cols="" rows="2" required><%if(carsSoC!=null && carsSoC.getCostReasonability()!=null) {%><%=carsSoC.getCostReasonability() %><%} %></textarea>
                        						</div>
                    		 				</div>
                    		 				
                    		 				<!-- Fourth row of SoC  -->
                    		 				<div class="row details">
                    		 					<div class="column b" style="width: 94.5%;">
                            					 	<label class="control-label">Justification for selection of RSP</label><span class="mandatory">*</span>
                              		      			<textarea class="form-control" name="rspSelection" placeholder="Enter Justification for selection of RSP" cols="" rows="2" required><%if(carsSoC!=null && carsSoC.getRSPSelection()!=null) {%><%=carsSoC.getRSPSelection() %><%} %></textarea>
                        						</div>
                    		 				</div>
                    		 				
                    		 				<!-- Fifth row of SoC  -->
                    		 				<div class="row details">
                    		 					<div class="column b" style="width: 94.5%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                            					 	<label class="control-label">Success / Acceptance Criterion</label><span class="mandatory">*</span>
                              		      			<textarea class="form-control" name="socCriterion" placeholder="Enter Success / Acceptance Criterion" cols="" rows="2" required><%if(carsSoC!=null && carsSoC.getSoCCriterion()!=null) {%><%=carsSoC.getSoCCriterion() %><%} %></textarea>
                        						</div>
                    		 				</div>
                    					</div>
               						</div>
               						<br>
               						<div align="center">
										<%if(carsSoC!=null){ %>
							    			<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
											<button type="submit" class="btn btn-sm btn-warning edit btn-soc" formmethod="post" formnovalidate="formnovalidate" onclick="return confirm('Are you sure to Update?')" >UPDATE</button>
										<%}else{ %>
											<button type="submit" class="btn btn-sm btn-success submit btn-soc" formmethod="post" formnovalidate="formnovalidate" onclick="return confirm('Are you sure to Submit?')" >SUBMIT</button>
										<%} %>
									</div>
               		 		<%if(carsSoC!=null) {%>
               		  			</form>
               		 		<%}else {%>
               		  			</form>
               		 		<%} %>	    	
              			<%} else{%>
              			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               				<h4 style="font-weight: bold;color: red;">This window will open after RSQR Approval..!</h4>
               			</div>
              			<%} %>
              			
              			<div class="navigation_btn"  style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
							<button class="btn btn-info btn-sm next">Next</button>
						</div>
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("4")){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** Final RSQR ***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("5")){ %> 
         			<div class="tab-pane active" id="finalrsqr" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="finalrsqr" role="tabpanel">
               	<%} %>
               		<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
               		<%int finalrsqrslno = 0; %>
               		
               		<div class="container-fluid">
						<div class="row">
							<div class="col-md-4">
								<div class="card" style="border-color: #00DADA; margin-top: 2%;">
									<div class="card-body scrollclass" style="height: 30.5rem;">

										<div class="panel panel-info" style="margin-top: 10px;" >
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Introduction</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor11" onclick="showEditor2('Introduction')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>

										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Research Overview</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor12" onclick="showEditor2('Research Overview')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Objectives</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor13"onclick="showEditor2('Objectives')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Major Requirements</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor14" onclick="showTableMajorReqr2('<%=carsInitiationId%>')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Deliverables</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor15" onclick="showTableDeliverables2('<%=carsInitiationId%>')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Proposed Milestones & Timelines</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor16" onclick="showEditor2('Proposed Milestones Timelines')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Scope of RSP</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor17" onclick="showEditor2('RSP Scope')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Scope of LRDE</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor18" onclick="showEditor2('LRDE Scope')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Success Criterion</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor19" onclick="showEditor2('Success Criterion')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
						
										<!--  -->
										<div class="panel panel-info" style="margin-top: 10px;">
											<div class="panel-heading ">
												<h4 class="panel-title">
													<span class="ml-2 rsqr-column" style="font-size: 15px"> <%=++finalrsqrslno %>. Literature Reference if any</span>
												</h4>
												<button class="btn bg-transparent buttonEd" type="button"
												id="btnEditor20" onclick="showEditor2('Literature Reference')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
												</button>
											</div>
										</div>
										
									</div>
								</div>
							</div>
							
							<!--div for Editor2-->
							<div class="col-md-8" style="display: block" id="col4">
			  					<form action="RSQRDetailsSubmit.htm" method="POST" id="myfrm2">
									<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
										<h5 class="heading ml-4 mt-3" id="editorHeading2"style="font-weight: 500; color: #31708f;">Introduction</h5>
										<hr>
										<div class="card-body" style="margin-top:-8px">
											<div class="row">
												<div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
													<div id="Editor2" class="center"></div>
													<textarea name="Details2" style="display: none;"></textarea>
													<div class="mt-2" align="center" id="detailsSubmit">
														<span id="EditorDetails2"></span>
														<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
														<input type="hidden" id="attributes2" name="attributes" value="Introduction">
														<input type="hidden" name="tab" value="5">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<span id="Editorspan">
														    <%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%> 
															<span id="btn3" style="display: block;"><button type="submit"class="btn btn-sm btn-success submit mt-2 btn-soc" onclick="return confirm('Are you sure to submit?')">SUBMIT</button></span>
															<span id="btn4" style="display: none;"><button type="submit"class="btn btn-sm btn-warning edit mt-2 btn-soc" onclick="return confirm('Are you sure update?')">UPDATE</button></span>
															<%} %>
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
							<!-- editor2 ends  -->
							
							<!-- Cloning table for Major Requirements2 (Final)-->
							<div class="col-md-8" style="display: none" id="col5">
								<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
									<h5 class="heading ml-4 mt-3" id="editorHeading2" style="font-weight: 500; color: #31708f;">Major Requirements</h5>
									<hr>
									<div class="card-body bg-light mt-1">
										<form action="RSQRMajorReqrSubmit.htm" method="post">
											<table style="width:100% ; " id="majorReqrTable2">
												<thead style = "background-color: #055C9D; color: white;text-align: center;">
													<tr>
														<th style="padding: 0px 5px 0px 5px;">Req Id</th>
											    		<th style="padding: 0px 5px 0px 5px;">Req Description</th>
											    		<th style="padding: 0px 5px 0px 5px;">Relevant Specification</th>
											    		<th style="padding: 0px 5px 0px 5px;">Validation Method</th>
											    		<th style="padding: 0px 5px 0px 5px;">Remarks</th>
														<td style="width:10%;">
															<button type="button" class=" btn btn_add_majorreqr2 "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
														</td>
													</tr>
												</thead>
							 					<tbody>
							 						<%if(majorReqr!=null && majorReqr.size()>0) {
							 					   	for(CARSRSQRMajorRequirements mr :majorReqr) {%>
							 						<tr class="tr_clone_majorreqr2">
														<td style="padding: 10px 5px 0px 5px;width: 10%;">
															<input type="text" class="form-control item" name="reqId" id="reqId2" value="<%if(mr.getReqId()!=null) {%><%=mr.getReqId() %><%} %>" maxlength="50" style="text-align: center;" readonly>
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 30%;">
															<input type="text" class="form-control item" name="reqDescription" value="<%if(mr.getReqDescription()!=null) {%><%=mr.getReqDescription() %><%} %>" maxlength="1000" required="required" >
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="relevantSpecs" value="<%if(mr.getRelevantSpecs()!=null) {%><%=mr.getRelevantSpecs() %><%} %>" maxlength="1000">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="validationMethod" value="<%if(mr.getValidationMethod()!=null) {%><%=mr.getValidationMethod() %><%} %>" maxlength="1000">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 15%;">
															<input type="text" class="form-control item" name="remarks" value="<%if(mr.getRemarks()!=null) {%><%=mr.getRemarks() %><%} %>" maxlength="1000" >
														</td>	
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_majorreqr2 " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
							 						<%} }else{%>
													<tr class="tr_clone_majorreqr2">
														<td style="padding: 10px 5px 0px 5px;width: 10%;" >
															<input type="text" class="form-control item" name="reqId" id="reqId2" value="RTD-1" maxlength="50" readonly="readonly" style="text-align: center;">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 30%;">
															<input type="text" class="form-control item" name="reqDescription" maxlength="1000" required="required" >
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="relevantSpecs" maxlength="1000">
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 20%;">
															<input type="text" class="form-control item" name="validationMethod" maxlength="1000" >
														</td>	
														<td style="padding: 10px 5px 0px 5px;width: 15%;">
															<input type="text" class="form-control item" name="remarks" maxlength="1000" >
														</td>	
														<td style="width:5% ; ">
															<button type="button" class=" btn btn_rem_majorreqr2 " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} %>
												</tbody> 
											</table>
											<div align="center" style="margin-top: 15px;">
												<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
													<%if(majorReqr!=null && majorReqr.size()>0) {%>
														<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-soc" name="submit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
													<%} else{%> 
														<button type="submit" class="btn btn-sm submit" name="submit btn-soc" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
													<%} %>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
													<input type="hidden" id="attributes2" name="attributes" value="Major Requirements">
													<input type="hidden" name="tab" value="5">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<%} %>
											</div>
										</form>	
									</div>
								</div>
							</div>
							
							<!-- Cloning table for Deliverables2 (Final) -->
							<div class="col-md-8" style="display: none" id="col6">
								<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
									<h5 class="heading ml-4 mt-3" id="editorHeading2" style="font-weight: 500; color: #31708f;">Deliverables</h5>
									<hr>
									<div class="card-body bg-light mt-1">
										<form action="RSQRDeliverablesSubmit.htm" method="post">
											<table style="width:100% ; " id="deliverablesTable2">
												<thead style = "background-color: #055C9D; color: white;text-align: center;">
													<tr>
												    	<th style="width: 80%;padding: 0px 5px 0px 5px;">Description</th>
												    	<th style="width: 10%;padding: 0px 5px 0px 5px;">Type</th>
														<td style="width: 5%;">
															<button type="button" class=" btn btn_add_deliverables2 "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
														</td>
													</tr>
												</thead>
								 				<tbody>
								 					<%if(deliverables!=null && deliverables.size()>0) {
								 					   for(CARSRSQRDeliverables del :deliverables) {%>
													<tr class="tr_clone_deliverables2">
														<td style="width: 80%;padding: 10px 5px 0px 5px;" >
															<input type="text" class="form-control item" name="description" value="<%if(del.getDescription()!=null) {%><%=del.getDescription() %><%} %>" maxlength="1000" required="required" >
														</td>	
														<td style="width: 10%;padding: 10px 5px 0px 5px;">
															<select class="form-control deliverabletype" name="deliverableType" required="required">
																<option value="H" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("H")) {%>selected<%} %> >Hardware</option>
																<option value="S" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("S")) {%>selected<%} %> >Software</option>
																<option value="R" <%if(del.getDeliverableType()!=null && del.getDeliverableType().equalsIgnoreCase("R")) {%>selected<%} %> >Report</option>
															</select>
														</td>	
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_deliverables2 " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} }else{%>
													<tr class="tr_clone_deliverables2">
														<td style="width: 80%;padding: 10px 5px 0px 5px;" >
															<input type="text" class="form-control item" name="description" maxlength="1000" required="required" >
														</td>	
														<td style="width: 10%;padding: 10px 5px 0px 5px;">
															<select class="form-control deliverabletype" name="deliverableType" required="required">
																<option value="H">Hardware</option>
																<option value="S">Software</option>
																<option value="R">Report</option>
															</select>
														</td>	
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_deliverables2" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} %>
												</tbody> 
											</table>
											<div align="center" style="margin-top: 15px;">
												<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
													<%if(deliverables!=null && deliverables.size()>0) {%>
														<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-soc" name="submit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
													<%} else{%> 
														<button type="submit" class="btn btn-sm submit btn-soc" name="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
													<%} %>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
													<input type="hidden" id="attributes2" name="attributes" value="Deliverables">
													<input type="hidden" name="tab" value="5">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												<%} %>
											</div>
										</form>	
									</div>
								</div>
							</div>
			
		                </div>
		     			<hr class="mt-2">
					</div>
               		<%} else{%>
              			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               				<h4 style="font-weight: bold;color: red;">This window will open after RSQR Approval..!</h4>
               			</div>
              		<%} %>
               		<div style="display: flex;justify-content: space-between;">
               			<div></div>
               			<div class="navigation_btn"  style="text-align: center;">
               				<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
               				<form action="">
               					<button type="submit" class="btn btn-sm submit" formaction="CARSFinalRSQRDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Final RSQR Download" style="background-color: purple;border: none;">Final RSQR</button>
               					<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               				</form>
               				<%} %>
						</div>
               			<div class="navigation_btn" style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
							<button class="btn btn-info btn-sm next">Next</button>
						</div>
               		</div>
               	
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("5")){ %>
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** Milestones &  Deliverables ***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("6")){ %> 
         			<div class="tab-pane active" id="socmilestones" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="socmilestones" role="tabpanel">
               	<%} %>
               		<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
               			<!-- Cloning table for Milestones -->
							<div class="col-md-12" style="" >
								<div class="card" style="border-color: #00DADA; margin-top: 2%;max-height: 700px;">
									<h5 class="heading ml-4 mt-3" id="" style="font-weight: 500; color: #31708f;">Milestones & Deliverables</h5>
									<hr>
									<div class="card-body bg-light mt-1">
										<form action="CARSSoCMilestoneSubmit.htm" method="post">
											<table style="width:100% ; " id="milestones">
												<thead style = "background-color: #055C9D; color: white;text-align: center;">
													<tr>
												    	<th style="width: 10%;padding: 0px 5px 0px 5px;">Milestone No.</th>
												    	<th style="width: 30%;padding: 0px 5px 0px 5px;">Task Description</th>
												    	<th style="width: 5%;padding: 0px 5px 0px 5px;">T0 + Months</th>
												    	<th style="width: 25%;padding: 0px 5px 0px 5px;">Deliverables</th>
												    	<th style="width: 5%;padding: 0px 5px 0px 5px;">Payment <br> ( In % )</th>
												    	<th style="width: 20%;padding: 0px 5px 0px 5px;">Payment Terms</th>
														<td style="width: 5%;">
															<button type="button" class=" btn btn_add_milestones "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
														</td>
													</tr>
												</thead>
								 				<tbody>
								 					<%if(milestones!=null && milestones.size()>0) {
								 					   for(CARSSoCMilestones mil :milestones) {%>
													<tr class="tr_clone_milestones">
														<td style="width: 10%;padding: 10px 5px 0px 5px;" >
															<input type="text" class="form-control item" name="milestoneno" id="milestoneno" value="<%if(mil.getMilestoneNo()!=null) {%><%=mil.getMilestoneNo() %><%} %>" style="text-align: center;" required="required"  readonly="readonly">
														</td>	
														<td style="width: 25%;padding: 10px 5px 0px 5px;">
															<textarea class="form-control" name="taskDesc" rows="3" cols="" style="width: 100%;" maxlength="2000" required="required" ><%if(mil.getTaskDesc()!=null) {%><%=mil.getTaskDesc() %><%} %></textarea>
														</td>	
														<td style="width: 5%;padding: 10px 5px 0px 5px;">
															<input type="number" class="form-control " name="months" min="0" max="<%=carsSoC.getSoCDuration() %>" value="<%if(mil.getMonths()!=null) {%><%=mil.getMonths() %><%} %>" required="required">
														</td>	
														<td style="width: 25%;padding: 10px 5px 0px 5px;">
															<textarea class="form-control" name="deliverables" rows="3" cols="" style="width: 100%;" maxlength="2000" required="required"><%if(mil.getDeliverables()!=null) {%><%=mil.getDeliverables() %><%} %></textarea>
														</td>
														<td style="width: 5%;padding: 10px 5px 0px 5px;">
															<input type="number" class="form-control" name="paymentPercentage" min="0" max="100" value="<%if(mil.getPaymentPercentage()!=null) {%><%=mil.getPaymentPercentage() %><%} %>" required="required" oninput="return checkPaymentPercentage(this)">
														</td>
														<td style="width: 20%;padding: 10px 5px 0px 5px;">
															<textarea class="form-control" name="paymentTerms" rows="3" cols="" style="width: 100%;" maxlength="2000" required="required"><%if(mil.getPaymentTerms()!=null) {%><%=mil.getPaymentTerms() %><%} %></textarea>
														</td>
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_milestones " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} }else{%>
													<tr class="tr_clone_milestones">
														<td style="width: 10%;padding: 10px 5px 0px 5px;" >
															<input type="text" class="form-control item" name="milestoneno" id="milestoneno" value="MIL-1" style="text-align: center;" required="required" readonly="readonly">
														</td>	
														<td style="width: 30%;padding: 10px 5px 0px 5px;">
															<textarea class="form-control" name="taskDesc" rows="3" cols="" maxlength="2000" style="width: 100%;" required="required"></textarea>
														</td>	
														<td style="width: 5%;padding: 10px 5px 0px 5px;">
															<input type="number" class="form-control" name="months" min="0" max="<%=carsSoC.getSoCDuration() %>" required="required">
														</td>	
														<td style="width: 25%;padding: 10px 5px 0px 5px;">
															<textarea class="form-control" name="deliverables" rows="3" cols="" style="width: 100%;" maxlength="2000" required="required"></textarea>
														</td>
														<td style="width: 5%;padding: 10px 5px 0px 5px;">
															<input type="number" class="form-control" name="paymentPercentage" id="paymentPercentage" min="0" max="100" required="required" oninput="return checkPaymentPercentage(this)">
														</td>
														<td style="width: 20%;padding: 10px 5px 0px 5px;">
															<textarea class="form-control" name="paymentTerms" rows="3" cols="" style="width: 100%;" maxlength="2000" required="required"></textarea>
														</td>
														<td style="width: 5% ; ">
															<button type="button" class=" btn btn_rem_milestones" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
													<%} %>
												</tbody> 
											</table>
											<div align="center" style="margin-top: 15px;">
												<%if(carsInitiationId!=null && !carsInitiationId.equals("0")) {%>
													<%if(milestones!=null && milestones.size()>0) {%>
														<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-soc" name="submit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
													<%} else{%> 
														<button type="submit" class="btn btn-sm submit btn-soc" name="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
													<%} %>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
													<input type="hidden" name="tab" value="6">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												<%} %>
											</div>
										</form>	
									</div>
								</div>
							</div>
               		
               		<%} else{%>
               			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               				<h4 style="font-weight: bold;color: red;">This window will open after RSQR Approval..!</h4>
               			</div>
               		<%} %>
               		<div style="display: flex;justify-content: space-between;">
               			<div></div>
               			<div class="navigation_btn"  style="text-align: center;">
               				<%if(milestones!=null && milestones.size()>0) {%>
               				<form action="">
               					<button type="submit" class="btn btn-sm submit" formaction="CARSSoCMilestonesDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Milestones Download" style="background-color: purple;border: none;">Milestones</button>
               					<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               				</form>
               				<%} %>
						</div>
               			<div class="navigation_btn" style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
							<button class="btn btn-info btn-sm next">Next</button>
						</div>
               		</div>
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("6")){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	
               	
               	<!-- *********** SoC  Forward***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("7")){ %> 
         			<div class="tab-pane active" id="socforward" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="socforward" role="tabpanel">
               	<%} %>
               		<%if(carsSoC!=null && rsqrDetails!=null && majorReqr!=null && majorReqr.size()>0 && deliverables!=null && deliverables.size()>0 && milestones!=null && milestones.size()>0) {%>
               			<%int socforwardslno=0; %>
               			<div class="col-md-8 mt-4">
               				<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;max-height: 500px;overflow-y: auto;">
               					<div class="card-body mt-2 ml-4">
               						<form action="">
               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               		   					<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
               		   					<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
               							<div class="mt-2" align="center">
               								<h5 style="font-weight: bold;margin-top: 1.5rem;">Statement of Case for availing CARS
               								&emsp;<button type="submit" class="btn btn-sm" formaction="CARSSoCDownload.htm" name="carsInitiationId" value="<%=carsInitiationId%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 				<i class="fa fa-download" aria-hidden="true"></i>
												</button>
               								</h5>
               							</div>
               							<table id="socforwardtable">
	               							<tr>
	               								<td colspan="2" style="text-align: left;border:none;">No. <span><%=carsIni.getCARSNo() %></span> </td>
	               								<td style="text-align: right;border:none;">Date : 
	               									<span><%if(carsSoC.getSoCDate()!=null) {%> <%=fc.SqlToRegularDate(carsSoC.getSoCDate()) %><%} else{%><%=rdf.format(new Date()) %> <%} %></span> 
	               								</td>
	               							</tr>
               								<tr>
               									<td style="width: 5%;text-align: center;"><%=++socforwardslno %>.</td>
               									<td style="width: 20%;">Title</td>
               									<td style="width: 73%;color: blue;"><%=carsIni.getInitiationTitle() %></td>
               								</tr>
               								<tr>
               									<td style="width: 5%;text-align: center;"><%=++socforwardslno %>.</td>
               									<td style="width: 20%;">Aim</td>
               									<td style="width: 73%;color: blue;"><%=carsIni.getInitiationAim() %></td>
               								</tr>
               								<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;" >Scope</td>
						    					<td style="width: 73%;color: blue;"><%if(rsqrDetails[6]!=null) {%> <%=rsqrDetails[6] %><%} else{%>-<%} %></td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Duration (Months)</td>
						    					<td style="width: 73%;color: blue;"><%=carsSoC.getSoCDuration() %> </td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Project Name & No., for which the CARS will be used</td>
						    					<td style="width: 73%;color: blue;">
						    						<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
						    							Build-up
						    						<%} else {%>
						    							<%if(PDs!=null) {%><%=PDs[4]+" ("+PDs[0]+")" %> <%} %>
						    						<%} %>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Alignment with Lab / Project charter</td>
						    					<td style="width: 73%;color: blue;">
						    						<%if(carsSoC.getAlignment()!=null && carsSoC.getAlignment().equalsIgnoreCase("L")) {%>
						    							Lab
						    						<%} else {%>
						    							Project charter
						    						<%} %>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">RSQR</td>
						    					<td style="width: 73%;color: blue;">
						    						Annexure - I &emsp;<button type="submit" class="btn btn-sm" formaction="CARSFinalRSQRDownload.htm" formtarget="_blank" 
						    						 style="padding: 5px 8px;" data-toggle="tooltip" data-placement="top" title="Final RSQR Download">
						    							<i class="fa fa-download fa-lg"></i>
						    						</button>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Milestones & Deliverables</td>
						    					<td style="width: 73%;color: blue;">
						    						Annexure - II &emsp;<button type="submit" class="btn btn-sm" formaction="CARSSoCMilestonesDownload.htm" formtarget="_blank" 
						    						 style="padding: 5px 8px;" data-toggle="tooltip" data-placement="top" title="Milestones Download">
						    							<i class="fa fa-download fa-lg"></i>
						    						</button>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Justification for raising CARS</td>
						    					<td style="width: 73%;color: blue;"><%=carsIni.getJustification() %> </td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Justification for time reasonability</td>
						    					<td style="width: 73%;color: blue;"><%=carsSoC.getTimeReasonability() %> </td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Justification for cost reasonability</td>
						    					<td style="width: 73%;color: blue;"><%=carsSoC.getCostReasonability() %> </td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Justification for selection of RSP</td>
						    					<td style="width: 73%;color: blue;"><%=carsSoC.getRSPSelection() %> </td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Research Service Provider</td>
						    					<td style="width: 73%;color: blue;">
						    						<%=carsIni.getPITitle()+". "+carsIni.getPIName() %>,
						    						<%=carsIni.getPIDesig() %> <br>
						    						<%=carsIni.getPIDept() %> <br>
						    						<%=carsIni.getPIMobileNo() %> <br>
						    						<%=carsIni.getPIEmail() %> <br>
						    						<%if(carsIni.getPIFaxNo()!=null && !carsIni.getPIFaxNo().isEmpty()){ %>
														<br> <%=carsIni.getPIFaxNo() %>
													<%} %>
						    						
						    						<span style="color: black;">From</span> <br>
						    						<%=carsIni.getRSPInstitute() %> <br>
               										<%=carsIni.getRSPAddress()+", "+carsIni.getRSPCity()+", "+carsIni.getRSPState()+" - "+carsIni.getRSPPinCode() %>.
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Execution Plan</td>
						    					<td style="width: 73%;">
						    						Annexure - IV &emsp;<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 value="exeplanfile" formaction="CARSSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Exection Plan Download">
                            					 		<i class="fa fa-download fa-lg"></i>
                            					 	</button>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Success / Acceptance Criterion</td>
						    					<td style="width: 73%;color: blue;"><%=carsSoC.getSoCCriterion() %> </td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Summary of Offer (SoO)</td>
						    					<td style="width: 73%;">
						    						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 value="soofile" formaction="CARSSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="SoO Download">
                            					 		<i class="fa fa-download fa-lg"></i>
                            					 	</button>
						    					</td>
						    				</tr>
						    				<tr>
						    					<td style="width: 5%;text-align: center;" ><%=++socforwardslno %>.</td>
						    					<td style="width: 20%;">Feasibility Report</td>
						    					<td style="width: 73%;">
						    						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 value="frfile" formaction="CARSSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="SoO Download">
                            					 		<i class="fa fa-download fa-lg"></i>
                            					 	</button>
						    					</td>
						    				</tr>
               							</table>
               							
               							<!-- <br>
               							
               							<div class="row">
               								<div class="col-md-2">Summary of Offer (SoO)</div>
               								<div class="col-md-1" style="text-align: left;">
               									<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 value="soofile" formaction="CARSSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SoO Download">
                            					 		<i class="fa fa-download fa-lg"></i>
                            					 </button>
               								</div>
               								<div class="col-md-2">Feasibility Report</div>
               								<div class="col-md-1" style="text-align: left;">
               									<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 value="frfile" formaction="CARSSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SoO Download">
                            					 		<i class="fa fa-download fa-lg"></i>
                            					 </button>
               								</div>
               							</div> -->
               							
               							<br><br>
               							
               							<div style="display: flex;justify-content: space-between;width: 98%;">
               							    <div style="width: 49%;text-align: left;margin-left: 10px;line-height: 10px;">
               							    	<div style="font-size: 15px;">Signature of the initiating officer</div>
												<label style="text-transform: capitalize;margin-top: 15px !important;">
													<%if(emp!=null && emp[1]!=null){%> <%=emp[1]%><%} %>,
												</label><!-- <br> -->
												<label style="text-transform: capitalize;">
													<%if(emp!=null && emp[2]!=null){%> <%=emp[2]%><%} %>
												</label><br>
												<label style="font-size: 12px;">
													Date&nbsp;:&nbsp;<%if(carsSoC.getSoCDate()!=null) {%> <%=fc.SqlToRegularDate(carsSoC.getSoCDate()) %><%} else{%><%=rdf.format(new Date()) %> <%} %>
												</label>
               							    </div>
               								
               								 <div style="width: 49%;text-align: right;margin-right: 10px;line-height: 10px;">
               								 	<div style="font-size: 15px;"> Signature of the <%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>GD<%} else{%>PD<%} %></div>
				               					<%for(Object[] apprInfo : socApprovalEmpData){ %>
				   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("SFG") || apprInfo[8].toString().equalsIgnoreCase("SFP")){ %>
				   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
				   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
				   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				   			    				<%break;}} %>  
				            			 	</div>	
										
										</div>
               							
               							<div class="row mt-2">
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
               							
               							<div class="row mt-2 mb-4">
											<div class="col-md-12" align="center">
												<%if(statuscode!=null && socforward.contains(statuscode)) {%>
													<div class="ml-2" align="left">
						   								<b >Remarks :</b><br>
						   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
					         						</div>
													<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="SoCApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
												<%} %>
												<%if(isApproval!=null && isApproval.equalsIgnoreCase("S")) {%>
													<div class="ml-2" align="left">
						   								<b >Remarks :</b><br>
						   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
					         						</div>
													<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="SoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
							    						Forward	
						      						</button>
						      						
						      						<!-- <button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="SoCApprovalSubmit.htm" name="Action" value="D" onclick="return disapprove();" style="font-weight: 600;">
							   	 						Not Forward	
						      						</button> -->
						      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="SoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
							 							Return
													</button>
												<%} %>
											</div>
                   						</div>
                   						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   						<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
               						</form>
               					</div>
               				</div>
               			</div>
               			<%} else{%>
               			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               				<h4 style="font-weight: bold;color: red;">Please fill the SoC, Final RSQR and Milestone Details..!</h4>
               			</div>
               			<%} %>
               			
               			<div style="display: flex;justify-content: space-between;">
               				<div></div>
               				<div>
               					<%if(carsIni!=null && isApproval==null) {%>
               					<div class="row"  >
		 		  					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For RSQR Approval</b></div>
		 	    				</div>
		 	    				<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
	              					<table align="center"  >
	               						<tr>
	               							<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
	                							Initiator -  <%=emp[1] %>
	                						</td>
	                		
                        					<td rowspan="2">
	                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
	                						</td>
	                						
	                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
	                							<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
	                								GD - <%if(GDs!=null) {%><%=GDs[2] %><%} else{%>GD<%} %>
	                							<%} else{%>
	                								PD - <%if(PDs!=null) {%><%=PDs[2] %><%} else{%>PD<%} %>
	                							<%} %>
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
               	
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("7")){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** MOM Upload ***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("8")){ %> 
         			<div class="tab-pane active" id="momupload" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="momupload" role="tabpanel">
               	<%} %>
               			<%if( (statuscode!=null && (statuscode.equalsIgnoreCase("SFG") || statuscode.equalsIgnoreCase("SFP") )) || (carsSoC!=null && carsSoC.getMoMUpload()!=null)) {%>
               				<form action="CARSSoCMoMUpload.htm" method="post" enctype="multipart/form-data">
               					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               		   			<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
               		   			<%if(carsSoC!=null && carsSoC.getMoMUpload()==null) {%>
               		   				<input type="hidden" name="MoMFlag" value="F">
               		   			<%} %>
               		   			<br>
               					<div class="row">
               						<div class="col-md-3"></div>
               			    		<div class="col-md-4" style="margin-left: 60px;">
               			     			<div class="row details">
                        					<div class="" style="width: 90%;border-top-left-radius: 5px;">
                            					 <label class="control-label">Upload MOM</label><span class="mandatory">*</span> 
                            					 <%if(carsSoC!=null && carsSoC.getMoMUpload()!=null) {%>
                            					 	<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-left: -20rem;" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	value="momfile" formaction="CARSSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="MoM Download">
                            					 		<i class="fa fa-download fa-lg"></i>
                            					 	</button>
                            					 	<input type="hidden" name="MoMFlag" value="N">
                            					 <%} %>
                              		      		<input type="file" class="form-control modals" name="MoMUpload" required accept=".pdf" >
                        					</div>
                        				</div>
                        			</div>
                        			<div class="col-md-4">
                        				<div align="left" style="margin-top: 2.2rem;">
											<%if(carsSoC!=null){ %>
							    				<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
												<button type="submit" class="btn btn-sm btn-success submit btn-momupload" formmethod="post" formnovalidate="formnovalidate" onclick="return confirm('Are you sure to Upload?')" >UPLOAD</button>
											<%} %>
									</div>
                        			</div>
                        		</div>
                        		<br>
               				</form>

						<%} else{%>
               				<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               					<h4 style="font-weight: bold;color: red;">Please get approval for SoC..!</h4>
               				</div>
               			<%} %>
               			<div class="navigation_btn"  style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
							<button class="btn btn-info btn-sm next">Next</button>
						</div>
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("8")){ %> 
         			</div>
         		<%}else{ %>
              		</div>
               	<%} %>
               	
               	<!-- *********** All Documents ***********      --> 
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("9")){ %> 
         			<div class="tab-pane active" id="alldocs" role="tabpanel">
         		<%}else{ %>
              		<div class="tab-pane " id="alldocs" role="tabpanel">
               	<%} %>
               			<%if(carsIni!=null) {%>
               				<div class="col-md-8 mt-4">
               					<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;">
               						<div class="card-body mt-2 ml-4">
	               						<form action="#">
	               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	               							<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
	               							<input type="hidden" name="carsSocId" value="<%=carsSoCId%>">
	               							<table id="alldocstable">
	               								<thead>
	               									<tr>
	               										<th style="width: 10%;">SN</th>
	               										<th>Subject</th>
	               										<th style="width: 10%;">Action</th>
	               									</tr>
	               								</thead>
	               								<tbody>
	               									<%int docsslno=0; %>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>RSQR</td>
	               										<td>
	               											<%if(carsIni!=null && rsqrDetails!=null && majorReqr!=null && majorReqr.size()>0 && deliverables!=null && deliverables.size()>0) {%>
		               											<button type="submit" class="btn btn-sm" <%if(carsIni.getInitiationApprDate()!=null) {%>formaction="CARSRSQRDownload.htm"<%} else {%>formaction="CARSRSQRDownloadBeforeFreeze.htm"<%} %>  formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="RSQR Download" >
																	<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																</button>
															<%} else {%>
                            					 				-
                            					 			<%} %>	
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>RSQR Approval Download</td>
	               										<td>
	               											<%if(carsIni!=null && rsqrDetails!=null && majorReqr!=null && majorReqr.size()>0 && deliverables!=null && deliverables.size()>0) {%>
		               											<button type="submit" class="btn btn-sm" formaction="CARSRSQRApprovalDownload.htm" formmethod="post" formnovalidate="formnovalidate" 
		               											 formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="RSQR Approval Download">
									  	 							<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																</button>
															<%} else {%>
                            					 				-
                            					 			<%} %>	
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Summary of Offer</td>
	               										<td>
	               											<%if(carsSoC!=null && carsSoC.getSoOUpload()!=null) {%>
		                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
		                            					 		  value="soofile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SoO Download">
		                            					 			<i class="fa fa-download fa-lg"></i>
		                            					 		</button>
                            					 			<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Feasibility Report</td>
	               										<td>
	               											<%if(carsSoC!=null && carsSoC.getFRUpload()!=null) {%>
		                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
		                            					 		  value="frfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Feasibility Report Download">
		                            					 			<i class="fa fa-download fa-lg"></i>
		                            					 		</button>
                            					 			<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Final RSQR ( Annexure-I )</td>
	               										<td>
	               											<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
               													<button type="submit" class="btn btn-sm" formaction="CARSFinalRSQRDownload.htm" formnovalidate="formnovalidate" 
               													formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Final RSQR Download" >
               														<i class="fa fa-download fa-lg"></i>
               													</button>
               												<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Milestones & Deliverables ( Annexure-II )</td>
	               										<td>
	               											<%if(milestones!=null && milestones.size()>0) {%>
               													<button type="submit" class="btn btn-sm" formaction="CARSSoCMilestonesDownload.htm" formnovalidate="formnovalidate" 
               													formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Milestones Download">
               														<i class="fa fa-download fa-lg"></i>
               													</button>
               												<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Execution Plan ( Annexure-IV )</td>
	               										<td>
	               											<%if(carsSoC!=null && carsSoC.getExecutionPlan()!=null) {%>
		                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formnovalidate="formnovalidate" formmethod="post"
		                            					 		  value="exeplanfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Execution Plan Download">
		                            					 			<i class="fa fa-download fa-lg"></i>
		                            					 		</button>
                            					 			<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Statement of Case ( SoC )</td>
	               										<td>
	               											<%if(carsSoC!=null && rsqrDetails!=null && majorReqr!=null && majorReqr.size()>0 && deliverables!=null && deliverables.size()>0 && milestones!=null && milestones.size()>0) {%>
	               												<button type="submit" class="btn btn-sm" formaction="CARSSoCDownload.htm" formnovalidate="formnovalidate" formmethod="post"
	               												  formtarget="blank" data-toggle="tooltip" data-placement="top" title="SoC Download">
								  	 								<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																</button>
	               											<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<tr>
	               										<td><%=++docsslno %></td>
	               										<td>Minutes of Meeting ( MoM )</td>
	               										<td>
	               											<%if(carsSoC!=null && carsSoC.getMoMUpload()!=null) {%>
                            					 				<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
                            					 				value="momfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="MoM Download">
                            					 					<i class="fa fa-download fa-lg"></i>
                            					 				</button>
                            					 			<%} else {%>
                            					 				-
                            					 			<%} %>
	               										</td>
	               									</tr>
	               									<%-- <tr>
	               										<td><%=++docsslno %></td>
	               										<td></td>
	               										<td></td>
	               									</tr> --%>
	               									
	               								</tbody>
	               							</table>
	               							<br>
	               						</form>
               						</div>
               					</div>
               				</div>
               			<%} else{%>
               				<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               					<h4 style="font-weight: bold;color: red;">Please complete atleast initiation and RSQR..!</h4>
               				</div>
               			<%} %>
               			<div class="navigation_btn"  style="text-align: right;">
            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
							<button class="btn btn-info btn-sm next">Next</button>
						</div>
               	<%if(TabId!=null&&TabId.equalsIgnoreCase("9")){ %> 
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
		
		// This is for RSQR
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
	
	var reqId = $clone.find("#reqId").val();
	var splitValues = reqId.split("-");
	var lastValue = splitValues[splitValues.length - 1];
	
	$clone.find("input").val("").end();
	$clone.find("#reqId").val("RTD-"+(Number(lastValue)+1));
});

/* Cloning (Removing) the table body rows for Major Requirements */
$("#majorReqrTable").on('click', '.btn_rem_majorreqr', function () {
    var $rows = $('.tr_clone_majorreqr');

    if ($rows.length > 1) {
        var $rowToRemove = $(this).closest('.tr_clone_majorreqr');
        var indexToRemove = $rows.index($rowToRemove);

        // Remove the row
        $rowToRemove.remove();

        // Update the reqId values for the remaining rows
        $('.tr_clone_majorreqr').each(function (index, row) {
            var $currentRow = $(row);
            var newReqId = "RTD-" + (index + 1);
            $currentRow.find("#reqId").val(newReqId);
        });
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

<!-- Tab and buttond hiding. Navigation button handle -->
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
    
    /* button disabling for RSQR Approval */
    <%if((carsIni!=null && rsqrforward.contains(statuscode)) || carsIni==null) {%>
    $('.btn-cars').prop('disabled',false);
    <%} else{%>
    $('.btn-cars').prop('disabled',true);
    <%} %>
    
    /* button disabling for SoC Approval */
    <%if((carsSoC!=null && socforward.contains(carsIni.getCARSStatusCode())) || carsSoC==null) {%>
    $('.btn-soc').prop('disabled',false);
    <%} else{%>
    $('.btn-soc').prop('disabled',true);
    <%} %>
    
    /* tabs hiding for RSQR approval */
    <%if(isApproval!=null && (isApproval.equalsIgnoreCase("Y") || isApproval.equalsIgnoreCase("N") || isApproval.equalsIgnoreCase("A"))) {%>
       $('.navigation_btn').hide();
       $('#nav-ini').hide();
       $('#nav-rsqr').hide();
       $('#nav-soc').hide();
       $('#nav-finalrsqr').hide();
       $('#nav-socforward').hide();
       $('#nav-rsqrdownload').hide();
       $('#nav-socmilestones').hide();
       $('#nav-momupload').hide();
       $('#nav-alldocs').hide();
    <%} %>
    
    /* tabs hiding for SoC approval */
    <%if(isApproval!=null && (isApproval.equalsIgnoreCase("S") || isApproval.equalsIgnoreCase("T") || isApproval.equalsIgnoreCase("U"))) {%>
       $('.navigation_btn').hide();
       $('#nav-ini').hide();
       $('#nav-rsqr').hide();
       $('#nav-rsqrapproval').hide();
       $('#nav-soc').hide();
       $('#nav-finalrsqr').hide();
       $('#nav-rsqrdownload').hide();
       $('#nav-socmilestones').hide();
       $('#nav-momupload').hide();
       $('#nav-alldocs').hide();
    <%} %>
})


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

<!-- Validations -->
<script type="text/javascript">
function validateEmailInput(emailInput) {
	  var email = emailInput.value.trim();
	  var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	  if (!emailPattern.test(email)) {
	    alert('Please Enter Valid Email');
	    emailInput.value="";
	    event.preventDefault();
	    return false;
	  } else {
	    return true;
	  }
	}

function validateMobileNoInput(mobileInput){
	var mobile = mobileInput.value.trim();
	if (mobile.length!=10) {
	    alert('Please Enter Valid Mobile Number');
	    mobileInput.value="";
	    event.preventDefault();
	    return false;
	  } else {
	    return true;
	  }
	
}

function validatePinCodeInput(pincodeInput){
	var pincode = pincodeInput.value.trim();
	if (pincode.length!=6) {
	    alert('Please Enter Valid PinCode');
	    pincodeInput.value="";
	    event.preventDefault();
	    return false;
	  } else {
	    return true;
	  }
	
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
});	
</script>

<script type="text/javascript">
//This is for final RSQR
CKEDITOR.replace('Editor2', editor_config);

function showEditor2(a){
	var x=a.toLowerCase();
	$('#col4').show();
	$('#col5').hide();
	$('#col6').hide();
	$('#editorHeading2').html=a;
	document.getElementById('editorHeading2').innerHTML=a;
	$('#attributes2').val(a);
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
				$('#btn3').show();
				$('#btn4').hide();
			if(x==="introduction" && ajaxresult[2]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[2];
			}
			else if(x==="research overview" && ajaxresult[3]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[3];
			}
			else if(x==="objectives" && ajaxresult[4]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[4];
			}
			else if(x==="proposed milestones timelines" && ajaxresult[5]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[5];
			}
			else if(x==="rsp scope" && ajaxresult[6]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[6];
			}
			else if(x==="lrde scope" && ajaxresult[7]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[7];
			}
			else if(x==="success criterion" && ajaxresult[8]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[8];
			}
			else if(x==="literature reference" && ajaxresult[9]!=null){
				$('#btn4').show();
				$('#btn3').hide();
				html=ajaxresult[9];
			}
			}else{
				$('#btn4').show();
				$('#btn3').hide();
			}
			CKEDITOR.instances['Editor2'].setData(html);
		}
	}); 
	
}
  
  $('#myfrm2').submit(function() {
		 var data =CKEDITOR.instances['Editor2'].getData();
		 $('textarea[name=Details2]').val(data);
		 });
  
  		$(document).ready(function() {
 		var a='<%=attributes%>';
 		var b='<%=carsInitiationId%>';
 		
		if(a==="Introduction"){
			showEditor(a);
	  	$('#btnEditor11').click();
		}else if(a==="Research Overview"){
			showEditor(a);
		$('#btnEditor12').click();
		}else if(a==="Objectives"){
			showEditor(a);
		$('#btnEditor13').click();
		}
		else if(a==="Major Requirements"){
			showTableMajorReqr2(b);
		$('#btnEditor14').click();
		}else if(a==="Deliverables") {
			showTableDeliverables2(b);
		$('#btnEditor15').click();
		} 
		else if(a==="Proposed Milestones Timelines") {
			showEditor(a);
		$('#btnEditor16').click();
		}else if(a==="RSP Scope") {
			showEditor(a);
			$('#btnEditor17').click();
		}else if(a==="LRDE Scope") {
			showEditor(a);
			$('#btnEditor18').click();
		}else if(a==="Success Criterion") {
			showEditor(a);
			$('#btnEditor19').click();
		}else if(a==="Literature Reference") {
			showEditor(a);
			$('#btnEditor20').click();
		}
		});
  		
  		function showTableMajorReqr2(b){
  			$('#col4').hide();
			$('#col5').show();
			$('#col6').hide();
  		}
  		
  		function showTableDeliverables2(b){
  			$('#col4').hide();
			$('#col5').hide();
			$('#col6').show();
  		}
  		
  		/* Cloning (Adding) the table body rows for Major Requirements */
  		$("#majorReqrTable2").on('click','.btn_add_majorreqr2' ,function() {
  			
  			var $tr = $('.tr_clone_majorreqr2').last('.tr_clone_majorreqr2');
  			var $clone = $tr.clone();
  			
  			$tr.after($clone);
  			
  			var reqId2 = $clone.find("#reqId2").val();
  			var splitValues = reqId2.split("-");
  			var lastValue = splitValues[splitValues.length - 1];
  			
  			$clone.find("input").val("").end();
  			$clone.find("#reqId2").val("RTD-"+(Number(lastValue)+1));
  		});

  		/* Cloning (Removing) the table body rows for Major Requirements */
  		$("#majorReqrTable2").on('click', '.btn_rem_majorreqr2', function () {
  		    var $rows = $('.tr_clone_majorreqr2');

  		    if ($rows.length > 1) {
  		        var $rowToRemove = $(this).closest('.tr_clone_majorreqr2');
  		        var indexToRemove = $rows.index($rowToRemove);

  		        // Remove the row
  		        $rowToRemove.remove();

  		        // Update the reqId2 values for the remaining rows
  		        $('.tr_clone_majorreqr2').each(function (index, row) {
  		            var $currentRow = $(row);
  		            var newReqId = "RTD-" + (index + 1);
  		            $currentRow.find("#reqId2").val(newReqId);
  		        });
  		    }
  		});



  		/* Cloning (Adding) the table body rows for Deliverables */
  		$("#deliverablesTable2").on('click','.btn_add_deliverables2' ,function() {
  			
  			var $tr = $('.tr_clone_deliverables2').last('.tr_clone_deliverables2');
  			var $clone = $tr.clone();
  			$tr.after($clone);
  			
  			$clone.find("input").val("").end();
  			
  		});


  		/* Cloning (Removing) the table body rows for Deliverables */
  		$("#deliverablesTable2").on('click','.btn_rem_deliverables2' ,function() {
  			
  		var cl=$('.tr_clone_deliverables2').length;
  			
  		if(cl>1){
  		   var $tr = $(this).closest('.tr_clone_deliverables2');
  		  
  		   var $clone = $tr.remove();
  		   $tr.after($clone);
  		   
  		}
  		   
  		}); 		
</script>

<script type="text/javascript">
/* Cloning (Adding) the table body rows for Milestones & Deliverables */
	$("#milestones").on('click','.btn_add_milestones' ,function() {
		
		var $tr = $('.tr_clone_milestones').last('.tr_clone_milestones');
		var $clone = $tr.clone();
		
		$tr.after($clone);
		
		var milestoneno = $clone.find("#milestoneno").val();
		var splitValues = milestoneno.split("-");
		var lastValue = splitValues[splitValues.length - 1];
		
		$clone.find("input").val("").end();
		$clone.find("textarea").val("").end();
		$clone.find("#milestoneno").val("MIL-"+(Number(lastValue)+1));
	});

	/* Cloning (Removing) the table body rows for Milestones & Deliverables */
	$("#milestones").on('click', '.btn_rem_milestones', function () {
	    var $rows = $('.tr_clone_milestones');

	    if ($rows.length > 1) {
	        var $rowToRemove = $(this).closest('.tr_clone_milestones');
	        var indexToRemove = $rows.index($rowToRemove);

	        // Remove the row
	        $rowToRemove.remove();

	        // Update the reqId2 values for the remaining rows
	        $('.tr_clone_milestones').each(function (index, row) {
	            var $currentRow = $(row);
	            var newReqId = "MIL-" + (index + 1);
	            $currentRow.find("#milestoneno").val(newReqId);
	        });
	    }
	});
	
	function checkPaymentPercentage(inputElement){
		
		// Traverse up the DOM to find the parent row
	    var row = $(inputElement).closest('tr');
		
		var percentage = 0;
		
		$("input[name='paymentPercentage']").each(function() {
			percentage = percentage+Number($(this).val());
		});
		
		if(percentage>100){
			alert('Percentage should not exceed more than 100');
			
			// Set the value of the specific input in the same row to 0
	        $(inputElement).val('0');
	        
			return false;
		}else{
			return true;
		}
	}
	
	
	
</script>

</body>
</html>