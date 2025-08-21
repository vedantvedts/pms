<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIDocumentIntroduction"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

	<!-- Summer Note -->
	<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
	<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
	<script src="${SummernoteJs}"></script>
	<link href="${SummernoteCss}" rel="stylesheet" />
	
<style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }

label{
  font-weight: bold;
  font-size: 20px;
}
 
.note-editable {
  line-height: 1.0;
}
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
}
.panel-info > .panel-heading {
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

element.style {
}
.olre-body .panel-info .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
   
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info>.panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.p-5 {
    padding: 5px;
}
.panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
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

.form-check{
	margin:0px 4%;
}

.editbtn
{
	background-color: green;
	width:auto; 
	height: 22px; 
	font-size:10px;
	font-weight: bold;
	text-align: justify; 
	margin-top : -9px;
	padding: 0px 3px 1px 3px; 
}

.hiddeninput
{
	width:50%;
	height: 25px;
	
	font-size: 1rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 2px;
	
}

 .btnx
{
	width:22px; 
	height: 22px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	
}

.fa-lg
{
	margin-left: -5px;
	vertical-align: 0%;
	font-size: 1.4rem;
} 

</style>

<style type="text/css">
.left {
	text-align: left;
}
.center {
	text-align: center;
}
.right {
	text-align: right;
}
	
.customtable{
	border-collapse: collapse;
	width: 100%;
	margin: 1.5rem 0.5rem 0.5rem 0.5rem;
	overflow-y: auto; 
	overflow-x: auto;  
}
.customtable th{
	border: 1px solid #0000002b; 
	padding: 10px;
		background-color: #2883c0;
}
.customtable td{
	border: 1px solid #0000002b; 
	padding: 5px;
}

.customtable thead {
	text-align: center;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
}

.table-wrapper {
    max-height: 600px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}
.note-editor {
	width: 100% !important;
	margin-top: 0.5rem;
} 
</style>
</head>
<body>
<%
	String docId = (String)request.getAttribute("docId");
	String docType = (String)request.getAttribute("docType");
	String documentNo = (String)request.getAttribute("documentNo");
	String introductionId = (String)request.getAttribute("introductionId");
	List<IGIDocumentIntroduction> igiDocumentIntroductionList = (List<IGIDocumentIntroduction>)request.getAttribute("igiDocumentIntroductionList");
	igiDocumentIntroductionList = igiDocumentIntroductionList.stream().filter(e -> e.getDocId()==Long.parseLong(docId) && e.getDocType().equalsIgnoreCase(docType))
																	  .collect(Collectors.toList());
	IGIDocumentIntroduction igiIntroduction = igiDocumentIntroductionList.stream().filter(e -> e.getIntroductionId()==Long.parseLong(introductionId)).findFirst().orElse(null);
%>

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
    
    <div class="container-fluid">
       
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-9" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Introduction Details - <%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
               			
                	</div>
                    <div class="col-md-1" align="right">
                        <a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;"
                        <%if(docType.equalsIgnoreCase("A")) {%>
                        	href="IGIDocumentDetails.htm?igiDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("B")) {%>
                        	href="ICDDocumentDetails.htm?icdDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("C")) {%>
                        	href="IRSDocumentDetails.htm?irsDocId=<%=docId %>"
                        <%} else if(docType.equalsIgnoreCase("D")) {%>
                        	href="IDDDocumentDetails.htm?iddDocId=<%=docId %>"
                        <%} %>
                         >Back</a>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        		<div class="row">
        			<div class="col-md-6">
        				<div class="panel panel-info" style="margin-top: 10px;" >
		         			<!-- panel-heading start -->
		      				<div class="panel-heading " style="display: flex; justify-content: space-between;">
		        				<h4 class="panel-title">
		          					<span  style="font-size:16px">Introduction</span>  
		        				</h4>
		      
								<div style="display: flex; gap: 30px;">  
									<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" style="display: none;" > 
										<i class="fa fa-plus faplus" aria-hidden="true" id="Clk1" style="font-size: 20px;"></i>
									</a>
		   						</div>
		     				</div>
		     				<!-- panel-heading end -->
		  	
		  					<div id="collapse1" class="panel-collapse collapse in">
		  						<%
		  							int Sub0Count = 1;
		  							if(igiDocumentIntroductionList!=null && igiDocumentIntroductionList.size()>0) {
		  								for(IGIDocumentIntroduction intro : igiDocumentIntroductionList) {
		  									if(intro.getLevelId()==1) {
		  										if(Sub0Count==1 && igiIntroduction==null) {
		  											igiIntroduction = intro;
		  										}
		  										
		  						%>
		  						<div class="row">  
									<div class="col-md-11"  align="left"  style="margin-left: 20px;">
										<div class="panel panel-info">
											<div class="panel-heading" style="display: flex; justify-content: space-between;">
												<h4 class="panel-title">
										        	<div>
											        	<form  id="myForm<%=Sub0Count %>" action="IGIIntroductionChapterAdd.htm" method="post">
											 
															<div style="display: flex; align-items: center; gap: 10px;">
																<span style="font-size:14px"><%=Sub0Count %>. </span>
																<span  style="font-size:14px" id="span_<%=intro.getIntroductionId()%>"> 
																	<%=intro.getChapterName()!=null?StringEscapeUtils.escapeHtml4(intro.getChapterName()): " - " %> 
																	&emsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=intro.getIntroductionId() %>')"></i> 
																</span>	
												          		<input type="text" class="hiddeninput" name="chapterName" pattern="^(?!\s)[\w\W]*?(?<!\s)$" title="Spaces allowed between characters but not at the start or end." maxlength="255" id="input_<%=intro.getIntroductionId()%>" value="<%=intro.getChapterName() %>" style="display: none;width: 350px;height: 25px;" required="required">
												          		<button type="submit" class="btn btn-sm edit" id="btn_<%=intro.getIntroductionId()%>" onclick="return confirm('Are you sure to Edit?')" style="width: 42px;height: 25px;font-size: 10px;font-weight: bold;display: none;">Edit</button>
																<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=intro.getIntroductionId() %>" onclick="moduleeditdisable('<%=intro.getIntroductionId()%>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
															</div>
												          	
												          	<input type="hidden" name="introductionId" value="<%=intro.getIntroductionId()%>">
												          	<input type="hidden" name="docId" value="<%=docId%>">
															<input type="hidden" name="docType" value="<%=docType%>">
															<input type="hidden" name="documentNo" value="<%=documentNo%>">
												          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											          		<textarea id="chapterContentEdit<%=intro.getIntroductionId()%>" style="display: none;"><%=intro.getChapterContent()!=null?StringEscapeUtils.escapeHtml4(intro.getChapterContent()):""%></textarea>
											          	</form>
										       		</div>
										        </h4>
										        <div style="display: flex; gap: 30px;">  
													<a data-toggle="collapse" data-parent="#accordion" href="#collapse55<%=Sub0Count %>" > 
														<i class="fa fa-plus faplus " id="Clk55<%=Sub0Count %>" style="font-size: 20px;"></i>
													</a>

													<span class="btn btn-sm p-0" id="editorbtn<%=Sub0Count %>" onclick="openEditor('<%=intro.getIntroductionId()%>', '<%=intro.getChapterName() %>')">
														<i class="fa fa-list-alt" aria-hidden="true" style="font-size: 20px;"></i>
													</span>
													<span class="btn btn-sm p-0" id="deletebtn<%=Sub0Count %>" onclick="deleteChapterName('<%=intro.getIntroductionId()%>')">
														<i class="fa fa-trash" aria-hidden="true" style="font-size: 20px;"></i>
													</span>
						   						</div>
											</div>
											<div id="collapse55<%=Sub0Count %>" class="panel-collapse collapse in">
									  			<%	int Sub1Count=1; 
						  								for(IGIDocumentIntroduction intro1 : igiDocumentIntroductionList) {
						  									if(intro1.getLevelId()==2 && intro1.getParentId().equals(intro.getIntroductionId())) {
									  			%>
									  			
									  			<div class="row">  
				   									<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     									<div class="panel panel-info">
					      									<div class="panel-heading" style="display: flex; justify-content: space-between;">
					       	 									<h4 class="panel-title">
					        										<div>
						           										<form  id="myFormB<%=Sub0Count %><%=Sub1Count %>" action="IGIIntroductionChapterAdd.htm" method="post">
						 
																			<input type="hidden" name="introductionId" value="<%=intro1.getIntroductionId()%>">
																          	<input type="hidden" name="docId" value="<%=docId%>">
																			<input type="hidden" name="docType" value="<%=docType%>">
																			<input type="hidden" name="documentNo" value="<%=documentNo%>">									
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																			
																			<div style="display: flex; align-items: center; gap: 10px;">
																				<span style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>. </span>
																				<span  style="font-size:14px" id="span_<%=intro1.getIntroductionId()%>"> 
																					<%=intro1.getChapterName()!=null?StringEscapeUtils.escapeHtml4(intro1.getChapterName()): " - " %> 
																					&emsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=intro1.getIntroductionId() %>')"></i> 
																				</span>	
																          		<input type="text" class="hiddeninput" name="chapterName" pattern="^(?!\s)[\w\W]*?(?<!\s)$" title="Spaces allowed between characters but not at the start or end." maxlength="255" id="input_<%=intro1.getIntroductionId()%>" value="<%=intro1.getChapterName() %>" style="display: none;width: 350px;height: 25px;" required="required">
																          		<button type="submit" class="btn btn-sm edit" id="btn_<%=intro1.getIntroductionId()%>" onclick="return confirm('Are you sure to Edit?')" style="width: 42px;height: 25px;font-size: 10px;font-weight: bold;display: none;">Edit</button>
																				<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=intro1.getIntroductionId() %>" onclick="moduleeditdisable('<%=intro1.getIntroductionId()%>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
																			</div>
																			<textarea id="chapterContentEdit<%=intro1.getIntroductionId()%>" style="display: none;"><%=intro1.getChapterContent()!=null?StringEscapeUtils.escapeHtml4(intro1.getChapterContent()):""%></textarea>
						          		
						          										</form>
					       											</div>
					        									</h4>
					        									 <div style="display: flex; gap: 30px;">  
																	<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %>" ></a>
				
																	<span class="btn btn-sm p-0" id="editorbtnB<%=Sub0Count %><%=Sub1Count %>" onclick="openEditor('<%=intro1.getIntroductionId()%>', '<%=intro1.getChapterName() %>')">
																		<i class="fa fa-list-alt" aria-hidden="true" style="font-size: 20px;"></i>
																	</span>
																	<span class="btn btn-sm p-0" id="deletebtnB<%=Sub0Count %><%=Sub1Count %>" onclick="deleteChapterName('<%=intro1.getIntroductionId()%>')">
																		<i class="fa fa-trash" aria-hidden="true" style="font-size: 20px;"></i>
																	</span>
										   						</div>
					      									</div>
					 									</div>
													</div>
									  			</div>
									  			<% ++Sub1Count;}} %>
									  			
									  			<div class="row">  
				   									<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     									<div class="panel panel-info">
					      									<div class="panel-heading">
					        									<h4 class="panel-title">
					        										<div>
															           <form  id="myFormB<%=Sub0Count %>" action="IGIIntroductionChapterAdd.htm" method="post">
															 
																			<input type="hidden" name="introductionId" value="0">
																          	<input type="hidden" name="docId" value="<%=docId%>">
																			<input type="hidden" name="docType" value="<%=docType%>">
																			<input type="hidden" name="documentNo" value="<%=documentNo%>">									
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																			<input type="hidden" name="levelId" value="2">
																			<input type="hidden" name="parentId" value="<%=intro.getIntroductionId()%>">
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																			
															          		<div style="display: flex; align-items: center; gap: 10px;">
																				<span style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>. </span>
																          		<input class="form-control" type="text" name="chapterName" pattern="^(?!\s)[\w\W]*?(?<!\s)$" title="Spaces allowed between characters but not at the start or end." required="required" maxlength="255" style="width: 350px;height: 25px;"> 
																          		<button type="submit" class="btn btn-info btn-sm" onclick="return confirm('Are you sure to Add?')" style="width: 42px;height: 25px;font-size: 10px;font-weight: bold;text-align: justify;">ADD</button>
																			</div>
															          	</form>
					       											</div>
					        									</h4>
					       		
					      									</div>
					  										<div >
					  			
					  										</div>
					 									</div>
					 
				  									</div>
	  											</div>		
									  			
									  		</div>	
										</div>
									</div>
								</div>		
								<% ++Sub0Count;}} }%>
								<div class="row">  
				   					<div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     					<div class="panel panel-info">
					      					<div class="panel-heading">
					        					<h4 class="panel-title">
					        						<div>
						           						<form id="myForm" action="IGIIntroductionChapterAdd.htm" method="post">
						 
															<input type="hidden" name="docId" value="<%=docId%>">
															<input type="hidden" name="docType" value="<%=docType%>">
															<input type="hidden" name="documentNo" value="<%=documentNo%>">
															<input type="hidden" name="introductionId" value="0">
															<input type="hidden" name="levelId" value="1">
															<input type="hidden" name="parentId" value="0">
															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
															<div style="display: flex; align-items: center; gap: 10px;">
																<span style="font-size:14px"><%=Sub0Count %>. </span>
												          		<input class="form-control" type="text" name="chapterName" pattern="^(?!\s)[\w\W]*?(?<!\s)$" title="Spaces allowed between characters but not at the start or end." required="required" maxlength="255" style="width: 350px;height: 25px;"> 
												          		<button type="submit" class="btn btn-info btn-sm" onclick="return confirm('Are you sure to Add?')" style="width: 42px;height: 25px;font-size: 10px;font-weight: bold;text-align: justify;">ADD</button>
															</div>
						          						</form>
					       							</div>
					        					</h4>
					      					</div>
											<div>
						  					</div>
					 					</div>
				  					</div>
	  							</div>
									
		  					</div>
			  			</div>
        			</div>
        			<div class="col-md-6">
        				<%if(igiDocumentIntroductionList!=null && igiDocumentIntroductionList.size()>0) { %>
        					<div class="card mt-3">
        						<div class="card-body">
        							<form action="IGIIntroductionDetailsSubmit.htm" method="POST" id="myform">
        								<span class="btn edit" id="editorHeading" style="border-radius: 1rem;"><%=igiIntroduction!=null && igiIntroduction.getChapterName()!=null?StringEscapeUtils.escapeHtml4(igiIntroduction.getChapterName()):"-" %></span>
										<div id="introductionEditor" class="center"></div>
										<textarea id="chapterContent" name="chapterContent" style="display: none;"></textarea>
										<div class="mt-2" align="center" id="detailsSubmit">
											<span id="EditorDetails"></span>
											<input type="hidden" name="docId" value="<%=docId%>">
											<input type="hidden" name="docType" value="<%=docType%>">
											<input type="hidden" name="documentNo" value="<%=documentNo%>">
											<input type="hidden" name="introductionId" id="introductionId" value="<%=igiIntroduction!=null && igiIntroduction.getIntroductionId()!=null?igiIntroduction.getIntroductionId():introductionId %>">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<span id="Editorspan">
												<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure to Update?')">UPDATE</button></span>
											</span>
										</div>
									</form>
        						</div>
        					</div>
			        				
						<%} else{%>
							<div class="card mt-3">
								<div class="card-body btn-info">
									<h4 class="center">Please Add Chapter Name..!</h4>
								</div>
							</div>
						<%} %>	
        			</div>
        		</div>
        		
        	</div>
        </div>
	</div> 	
	
	<form action="IGIIntroductionChapterDelete.htm" method="post">
		<input type="hidden" name="docId" value="<%=docId%>">
		<input type="hidden" name="docType" value="<%=docType%>">
		<input type="hidden" name="documentNo" value="<%=documentNo%>">
		<input type="hidden" name="introductionId" id="introductionIdD" value="0">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<button type="submit" id="deleteChapterbtn" onclick="return confirm('Are you sure to delete?')" style="display:none;">
		</button>
	</form>
<script type="text/javascript">
function moduleeditenable(moduleid) {
	$('#span_'+moduleid).hide();
	$('#input_'+moduleid).show();
	$('#btn_'+moduleid).show();	
	$('#btnx_'+moduleid).show();
}

function moduleeditdisable(moduleid) {
	$('#span_'+moduleid).show();
	$('#input_'+moduleid).hide();
	$('#btn_'+moduleid).hide();	
	$('#btnx_'+moduleid).hide();
}



$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".faplus").addClass("fa-minus").removeClass("fa-plus");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-minus").addClass("fa-plus");
    });
    
    $('#Clk1').click();
});



//Define a common Summernote configuration
var summernoteConfig = {
    width: 900,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
        ['insert', ['picture', 'table']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['height', ['height']]
    ],
    fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],
    fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana','Segoe UI','Segoe UI Emoji','Segoe UI Symbol'],
    buttons: {
        superscript: function() {
            return $.summernote.ui.button({
                contents: '<sup>S</sup>',
                tooltip: 'Superscript',
                click: function() {
                    document.execCommand('superscript');
                }
            }).render();
        },
        subscript: function() {
            return $.summernote.ui.button({
                contents: '<sub>S</sub>',
                tooltip: 'Subscript',
                click: function() {
                    document.execCommand('subscript');
                }
            }).render();
        }
    },
    height: 300
};


$('#introductionEditor').summernote(summernoteConfig);

//Update the values of Editors
var html1 = '<%=igiIntroduction!=null && igiIntroduction.getChapterContent()!=null?StringEscapeUtils.escapeHtml4(igiIntroduction.getChapterContent()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):""%>';
$('#introductionEditor').summernote('code', html1);

//Set the values to the form when submitting.
$('#myform').submit(function() {

	 var data1 = $('#introductionEditor').summernote('code');
	 $('textarea[name=chapterContent]').val(data1);
	 
});

function openEditor(introId, chapterName) {
	$('#editorHeading').text(chapterName);
	$('#introductionId').val(introId);
	var contenthtml = $('#chapterContentEdit'+introId).val();
	$('#introductionEditor').summernote('code', contenthtml);
}

function deleteChapterName(introId) {
	$('#introductionIdD').val(introId);
	$('#deleteChapterbtn').click();
}
</script>	
</body>
</html>