<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSOtherDocDetails"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
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

#socforwardtable, #milestonestable, #desctable{
	width : 98%;
	/* border : 1px solid black; */
	 margin-top : 1rem; 
	font-size: 14px;
}
#socforwardtable td, #milestonestable td, #desctable td{
	border : 1px solid black;
	text-align: left;
	padding : 3px;
}

#socforwardtable th, #milestonestable th, #desctable th{
	border : 1px solid black;
	text-align: center;
	padding : 3px;
}

#socforwardtable td:first-child {
    text-align: center;
    width: 5%;
}

#socforwardtable td:second-child {
    width: 23%;
}
#socforwardtable td:third-child {
    width: 70%;
}

#desctable td:first-child {
    text-align: center;
}

.soccontainer{
	text-align: left;
 
}
.socheading{
	font-weight: bold;
	margin-top: 1rem;
}
.soccontent{
	width: 96%;
	margin-left: 20px;
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

.externalapproval{
border : 1px solid #ced4da;
padding: 20px;
border-radius : 0.25rem;
width: 70%;
margin-left: -30%;
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
#alldocstable td{
	border : 1px solid black;
	text-align: left;
	padding : 3px;
}
#alldocstable td:first-child,#alldocstable td:nth-child(3){ 
	text-align: center; 
}

</style>

<style type="text/css">
.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
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
</head>
<body>
<%
String otherDocsTabId = (String)request.getAttribute("otherDocsTabId"); 

CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");


List<CARSOtherDocDetails> csdetailslist = otherdocdetails.stream().filter(e-> "C".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());
List<CARSOtherDocDetails> mpdetailslist = otherdocdetails.stream().filter(e-> "M".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());
List<CARSOtherDocDetails> iapdetailslist = otherdocdetails.stream().filter(e-> "I".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());
List<CARSOtherDocDetails> ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());

CARSOtherDocDetails csdetails = csdetailslist!=null && csdetailslist.size()>0?csdetailslist.get(0):null;
CARSOtherDocDetails mpdetails = mpdetailslist!=null && mpdetailslist.size()>0?mpdetailslist.get(0):null;
CARSOtherDocDetails iapdetails = iapdetailslist!=null && iapdetailslist.size()>0?iapdetailslist.get(0):null;
CARSOtherDocDetails ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0?ptcdetailslist.get(0):null;

String isApproval = (String)request.getAttribute("isApproval");

FormatConverter fc = new FormatConverter();
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
         		<div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 120px;">
             		<h3 class="category">Other Docs Details
             			<a class="btn btn-info btn-sm  shadow-nohover back"
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("P") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("Q") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSRSQRApprovedList.htm?AllListTabId=3"
             			<%} %> 
             			  style="color: white!important;float: right;">Back</a>
             		</h3>
             		<hr style="margin: -8px 0px !important;">
             		<ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >
             		
            			<li class="nav-item" id="nav-othersdetails">
             				<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#otherdoclist" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#otherdoclist" role="tab">
               				<%} %>  
               					
                	         	Other Doc List
              			 		</a>
            			</li>
            			
            			<li class="nav-item" id="nav-othersdetails">
             				<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("2")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#othersdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#othersdetails" role="tab">
               				<%} %>  
               					
                	         	Doc Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-csapproval">
            	     		<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("3")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#csapproval" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#csapproval" role="tab" >
               				<%} %>
                  				Contract Approval
              					</a>
            			</li>
            			
            			<li class="nav-item" id="nav-mpapproval">
		            	     <%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("4")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#mpapproval" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#mpapproval" role="tab" >
		               		<%} %>
                  				Payment Approval
              					</a>
            			</li>
            			
            			<%-- <li class="nav-item" id="nav-iapforward">
		            	     <%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("4")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#iapapproval" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#iapapproval" role="tab" >
		               		<%} %>
                  				Initial Advance Payment Approval
              					</a>
            			</li> --%>
            			
            			<li class="nav-item" id="nav-ptcletter">
		            	     <%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("5")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#ptcletter" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#ptcletter" role="tab" >
		               		<%} %>
                  				Payment towards CARS
              					</a>
            			</li>
            			
            			<li class="nav-item" id="nav-alldocs">
		            	     <%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("6")){ %>
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
         				<!-- *********** Others Details ***********      --> 
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="othersdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="othersdetails" role="tabpanel">
               			<%} %>
               					<div class="row">
               						<!-- ************************** CARS Contract Signature Details ************************** -->
               						<div class="col-md-6">
               							<div class="container">
											<div class="row" style="">
												<div class="col-md-12">
													<div class="card shadow-nohover" >
														<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
										                    <b class="text-white" style="">CARS Contract Signature Details: </b> 
										                    <hr>
										                    <span class="text-white" style="float:right;font-weight: 600"> </span>
									        			</div> 
														<div class="card-body">
										        		
															<form action="" method="POST">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
														    	<input type="hidden" name="otherDocType" value="C">
														    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
														    		
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="csOtherDocDate" id="csOtherDocDate"
														                     value="<%if(csdetails!=null && csdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(csdetails.getOtherDocDate()) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
														                    <%if(csdetails!=null && csdetails.getAttachFlagA()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagA" <%if(csdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
														                    <%if(csdetails!=null && csdetails.getAttachFlagB()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagB" <%if(csdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
														                    <%if(csdetails!=null && csdetails.getAttachFlagC()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagC" <%if(csdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        </div>
														        
														        <div class="row" style="margin-left: 2%;margin-right: 2%;">
														        	<div class="col-md-2">
														        		<div class="form-group">
														        			<label class="control-label">Info <button type="button" id="csInfo" value="0" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;background: blueviolet;border: blueviolet;"><i class="fa fa-info-circle" aria-hidden="true"></i></button></label>
														        		</div>
														        	</div>
														        	<div class="col-md-10" id="csInfoContent" style="text-align: left;margin-left: -10%;">
														        		<div class="form-group" style="width: 110%;">
														        			<span style="color: crimson;">Flag-A : </span> <span>SoC from for CARS collaboration with Institute/ University has been approved by CFA.</span> <br>
														        			<span style="color: fuchsia;">Flag-B : </span> <span>The final RSQR, Milestones and payment terms are attached. </span> <br>
														        			<span style="color: blue;">Flag-C : </span> <span>The contract signed by competent authority of the RSP is placed opposite for CFA's signature please.</span> 
														        		</div>
														        	</div>
														        </div>
														        
														    	<div align="center">
																	<%if(csdetails!=null){ %>
																		<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
																	<%}else{ %>
																		<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
																	<%} %>
																</div>
														    </form>
										    				<br>
														    
														</div>
													</div>
												</div>
											</div>
										</div>
               						</div>
               						<!-- ************************** Initial Advance Payment Details ************************** -->
               						<div class="col-md-6">
               							<div class="container">
											<div class="row" style="">
												<div class="col-md-12">
													<div class="card shadow-nohover" >
														<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
										                    <b class="text-white" style="">Initial Advance Payment Details: </b> 
										                    <hr>
										                    <span class="text-white" style="float:right;font-weight: 600"> </span>
									        			</div> 
														<div class="card-body">
										        		
															<form action="" method="POST">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
														    	<input type="hidden" name="otherDocType" value="I">
														    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
														    		
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="iapOtherDocDate" id="iapOtherDocDate"
														                     value="<%if(iapdetails!=null && iapdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(iapdetails.getOtherDocDate()) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
														                    <%if(iapdetails!=null && iapdetails.getAttachFlagA()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagA" <%if(iapdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
														                    <%if(iapdetails!=null && iapdetails.getAttachFlagB()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagB" <%if(iapdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<%-- <div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
														                    <%if(iapdetails!=null && iapdetails.getAttachFlagC()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagC" <%if(iapdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div> --%>
														        </div>
														        
														         <div class="row" style="margin-left: 2%;margin-right: 2%;">
														        	<div class="col-md-2">
														        		<div class="form-group">
														        			<label class="control-label">Info <button type="button" id="iapInfo" value="0" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;background: blueviolet;"><i class="fa fa-info-circle" aria-hidden="true"></i></button></label>
														        		</div>
														        	</div>
														        	<div class="col-md-10" id="iapInfoContent" style="text-align: left;margin-left: -10%;">
														        		<div class="form-group" style="width: 110%;">
														        			<span style="color: crimson;">Flag-A : </span> <span>Reference is made to the CARS .</span> <br>
														        			<span style="color: fuchsia;">Flag-B : </span> <span>Invoice. </span> <br>
														        		</div>
														        	</div>
														        </div>
														        
														    	<div align="center">
																	<%if(iapdetails!=null){ %>
																		<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
																	<%}else{ %>
																		<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
																	<%} %>
																</div>
														    </form>
										    				<br>
														</div>
													</div>
												</div>
											</div>
										</div>
               						</div>
               					</div>
               					<div class="row">
               						<!-- ************************** Milestone Payment Details ************************** -->
               						<div class="col-md-6">
               							<div class="container">
											<div class="row" style="">
												<div class="col-md-12">
													<div class="card shadow-nohover" >
														<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
										                    <b class="text-white" style="">Milestone Payment Details: </b> 
										                    <hr>
										                    <span class="text-white" style="float:right;font-weight: 600"> </span>
									        			</div> 
														<div class="card-body">
										        		
															<form action="" method="POST">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
														    	<input type="hidden" name="otherDocType" value="M">
														    	
														    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
														    		
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="mpOtherDocDate" id="mpOtherDocDate"
														                     value="<%if(mpdetails!=null && mpdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(mpdetails.getOtherDocDate()) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagA" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagB" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagC" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        </div>
														        
														        <div class="row" style="margin-left: 2%;margin-right: 2%;">
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Invoice No:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="invoiceNo" id="invoiceNo" maxlength="50" placeholder="Enter Inovice No"
														                     value="<%if(mpdetails!=null) {%><%=mpdetails.getInvoiceNo() %><%} %>" oninput="this.value=this.value.replace(/[^a-zA-Z0-9]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Invoice Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="invoiceDate" id="invoiceDate"
														                     value="<%if(mpdetails!=null) {%><%=mpdetails.getInvoiceDate() %><%} %>" required readonly> 
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Milestone No:</label><span class="mandatory">*</span>
														                     <select class="form-control selectdee" id="milestoneNo" name="milestoneNo" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (milestones != null && milestones.size() > 0) {
																						for (CARSSoCMilestones mil : milestones) {
																					%>
																						<option value=<%=mil.getMilestoneNo()%> <%if(mpdetails!=null && mpdetails.getMilestoneNo()!=null && mpdetails.getMilestoneNo().equalsIgnoreCase(mil.getMilestoneNo())) {%>selected<%} %> ><%=mil.getMilestoneNo()%></option>
																					<%}}%>
																			</select>
														                </div>
														            </div>
														        </div>
														        
														         <div class="row" style="margin-left: 2%;margin-right: 2%;">
														        	<div class="col-md-2">
														        		<div class="form-group">
														        			<label class="control-label">Info <button type="button" id="mpInfo" value="0" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;background: blueviolet;"><i class="fa fa-info-circle" aria-hidden="true"></i></button></label>
														        		</div>
														        	</div>
														        	<div class="col-md-10" id="mpInfoContent" style="text-align: left;margin-left: -10%;">
														        		<div class="form-group" style="width: 110%;">
														        			<span style="color: crimson;">Flag-A : </span> <span>Reference is made to the CARS .</span> <br>
														        			<span style="color: fuchsia;">Flag-B : </span> <span>Invoice. </span> <br>
														        			<span style="color: blue;">Flag-C : </span> <span>Recommendation of CARS Review committee for releasing the proposed milestone payment is placed.</span> 
														        		</div>
														        	</div>
														        </div>
														        
														    	<div align="center">
																	<%if(mpdetails!=null){ %>
																		<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
																	<%}else{ %>
																		<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
																	<%} %>
																</div>
														    </form>
										    				<br>
														</div>
													</div>
												</div>
											</div>
										</div>
               						</div>
               						
               						<!-- ************************** Payment towards CARS Details ************************** -->
               						<div class="col-md-6">
               							<div class="container">
											<div class="row" style="">
												<div class="col-md-12">
													<div class="card shadow-nohover" >
														<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
										                    <b class="text-white" style="">Payment towards CARS Details: </b> 
										                    <hr>
										                    <span class="text-white" style="float:right;font-weight: 600"> </span>
									        			</div> 
														<div class="card-body">
										        		
															<form action="" method="POST">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
														    	<input type="hidden" name="otherDocType" value="P">
														    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
														    		
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="ptcOtherDocDate" id="ptcOtherDocDate"
														                     value="<%if(ptcdetails!=null && ptcdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(ptcdetails.getOtherDocDate()) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Milestone No:</label><span class="mandatory">*</span>
														                     <select class="form-control selectdee" id="milestoneNoP" name="milestoneNoP" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (milestones != null && milestones.size() > 0) {
																						for (CARSSoCMilestones mil : milestones) {
																					%>
																						<option value=<%=mil.getMilestoneNo()%> <%if(mpdetails!=null && mpdetails.getMilestoneNo()!=null && mpdetails.getMilestoneNo().equalsIgnoreCase(mil.getMilestoneNo())) {%>selected<%} %> ><%=mil.getMilestoneNo()%></option>
																					<%}}%>
																			</select>
														                </div>
														            </div>
														        	<%-- <div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
														                    <%if(ptcdetails!=null && ptcdetails.getAttachFlagA()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagA" <%if(ptcdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
														                    <%if(ptcdetails!=null && ptcdetails.getAttachFlagB()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagB" <%if(ptcdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
														                    <%if(ptcdetails!=null && ptcdetails.getAttachFlagC()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagC" <%if(ptcdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div> --%>
														        </div>
														        
														    	<div align="center">
																	<%if(ptcdetails!=null){ %>
																		<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
																	<%}else{ %>
																		<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
																	<%} %>
																</div>
														    </form>
										    				<br>
														    
														</div>
													</div>
												</div>
											</div>
										</div>
               						</div>
               					</div>
               					
               					<div class="navigation_btn"  style="text-align: right;">
            						<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSRSQRApprovedList.htm?AllListTabId=3" style="color: white!important">Back</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
         				<!-- *********** Contract Signature Approval ***********      --> 
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("3")){ %> 
         					<div class="tab-pane active" id="csapproval" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="csapproval" role="tabpanel">
               			<%} %>
               					<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("3")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
         				<!-- *********** Milestone Payment Approval ***********      --> 
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("4")){ %> 
         					<div class="tab-pane active" id="mpapproval" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="mpapproval" role="tabpanel">
               			<%} %>
               					<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("4")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
         				<%-- <!-- *********** Initial Advance Payment Approval ***********      --> 
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("4")){ %> 
         					<div class="tab-pane active" id="iapapproval" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="iapapproval" role="tabpanel">
               			<%} %>
               					<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("4")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %> --%>
               			
         				<!-- *********** Payment towards CARS ***********      --> 
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("5")){ %> 
         					<div class="tab-pane active" id="ptcletter" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="ptcletter" role="tabpanel">
               			<%} %>
               					<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("5")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
         				<!-- *********** All Docs ***********      --> 
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("6")){ %> 
         					<div class="tab-pane active" id="alldocs" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="alldocs" role="tabpanel">
               			<%} %>
               					<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(otherDocsTabId!=null && otherDocsTabId.equalsIgnoreCase("6")){ %> 
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
$('#csOtherDocDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#mpOtherDocDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#iapOtherDocDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#ptcOtherDocDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#invoiceDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script>     

<script type="text/javascript">
//On page load hiding all the content of info
$(document).ready(function(){
	
	$('#csInfoContent').hide();
	$('#mpInfoContent').hide();
	$('#iapInfoContent').hide();
	
});

//Onclick showing / Closing the info content

/* For CS Details Content */
$( "#csInfo" ).on( "click", function() {
	var csInfo = $('#csInfo').val();
	if(csInfo=="0"){
		$('#csInfo').val('1');
		$('#csInfoContent').show();
	
	}else{
		$('#csInfo').val('0');
		$('#csInfoContent').hide();
		}
} );

/* For MP Details Content */
$( "#mpInfo" ).on( "click", function() {
	var mpInfo = $('#mpInfo').val();
	if(mpInfo=="0"){
		$('#mpInfo').val('1');
		$('#mpInfoContent').show();
	
	}else{
		$('#mpInfo').val('0');
		$('#mpInfoContent').hide();
		}
} );

/* For IAP Details Content */
$( "#iapInfo" ).on( "click", function() {
	var iapInfo = $('#iapInfo').val();
	if(iapInfo=="0"){
		$('#iapInfo').val('1');
		$('#iapInfoContent').show();
	
	}else{
		$('#iapInfo').val('0');
		$('#iapInfoContent').hide();
		}
} );
</script>  		
</body>
</html>