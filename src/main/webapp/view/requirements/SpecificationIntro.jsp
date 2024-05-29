<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<spring:url value="/resources/font/summernote.woff" var="Summernotewoff" />
<spring:url value="/resources/font/summernote.ttf" var="Summernotettf" />
<spring:url value="/resources/font/summernote.eot" var="Summernoteeot" />


<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<script src="${Summernotettf}"></script>
<script src="${Summernotettf}"></script>
<script src="${Summernoteeot}"></script>
<style>
.bs-example {
	margin: 20px;
}

.accordion .fa {
	margin-right: 0.5rem;
}
</style>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
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
	display: contents;
}
.buttonEd {
	float: right;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}
.note-editing-area{

   height:320px;
} 
.note-frame{
margin-left:2%;
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

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
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

.form-check {
	margin: 0px 2%;
}

.fa-thumbs-up {
	font-family: FontAwesome, 'Quicksand', Quicksand, sans-serif;
}

.form-inline {
	display: inline-block;
}
#adddoc{
font-weight: 600;
font-family: 'Montserrat', sans-serif;
float: right;
}

</style>
</head>
<body>
<%
	String projectId =(String)request.getAttribute("projectId");
	String initiationId =(String)request.getAttribute("initiationId");
	String attributes=(String)request.getAttribute("attributes");
	String productTreeMainId = (String)request.getAttribute("productTreeMainId");
	String SpecsInitiationId = (String)request.getAttribute("SpecsInitiationId");
	String Attributes = (String)request.getAttribute("Attributes");

	List<Object[]>SpecsIntro =(List<Object[]>)request.getAttribute("SpecsIntro");
	

	%>
	
		<nav class="navbar navbar-light bg-light justify-content-between" style="margin-top: -1%">
			<a class="navbar-brand"> 
			<b style="color: #585858; font-size: 19px; font-weight: bold; text-align: left; float: left">
			<span style="color: #31708f">Requirement Introduction for Project </span>
			<%-- <span style="color: #31708f; font-size: 19px">  <%=project.split("/")[1].toString() %></span> --%>
			</b>
			</a>
			<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="projectId" value="<%=projectId%>">
			<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
			<button class="btn btn-info btn-sm  back ml-2 mt-1" formaction="ProjectSpecificationDetails.htm" formmethod="get" formnovalidate="formnovalidate" style="float: right;">BACK</button>
			</form>
		</nav>
		<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center" class="mt-2">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center" class="mt-2">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
	<%}%>
		<div class="container-fluid">
		<div class="row">
			<div class="col-md-5">
				<div class="card" style="border-color: #00DADA; margin-top: 2%;">
					<div class="card-body" id="scrollclass" style="height: 30.5rem;">

						<div class="panel panel-info" style="margin-top: 10px;" >
							<div class="panel-heading ">
								<h4 class="panel-title">
									<span class="ml-2" style="font-size: 14px">
										1.System Identification</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor1" onclick="showEditor('System Identification')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button>
							</div>
						</div>

					
						<div class="panel panel-info" style="margin-top: 10px;">
							<div class="panel-heading ">
								<h4 class="panel-title">
									<span class="ml-2" style="font-size: 14px"> 2. System
										Overview</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor3"onclick="showEditor('System Overview')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button>
							</div>
						</div>
						<!--  -->
						<!--  -->
						<div class="panel panel-info" style="margin-top: 10px;">
							<div class="panel-heading ">
								<h4 class="panel-title">
									<span class="ml-2" style="font-size: 14px"> 3. Document Overview</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor4" onclick="showEditor('Document Overview')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button>
							</div>
						</div>
					
					</div>
				</div>
			</div>
						<!--div for Editor-->
			<div class="col-md-7" style="display: block" id="col1">
			  <form action="SpecIntroSubmit.htm" method="POST" id="Cform">
					<div class="card" style="border-color: #00DADA; margin-top: 2%;">
						<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight: 500; color: #31708f;"></h5>
						<hr>
						<div class="card-body" style="margin-top:-8px">
							<div class="row">
								<div class="col-md-12 " align="left"
									style="margin-left: 0px; width: 100%;">
							<div id="summernote" style="height: 500;">
					        
					           </div>
			   			
   						<textarea name="Details" style="display: none;"  id="ConclusionDetails"></textarea>	
									<div class="mt-2" align="center" id="detailsSubmit">
										<span id="EditorDetails"></span> 
										 <input type="hidden" name="projectId" value="<%=projectId%>">
										 <input type="hidden" name="initiationId" value="<%=initiationId%>">
								<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
										 <input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
											
											<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
											<input type="hidden" id="attributes" name="attributes" >
											<input type="hidden" name="IntroductionId" id="IntroductionId">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <span id="Editorspan">
											<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-success submit mt-2" onclick="return confirm('Are you sure you want to submit?')" name="action" value="add">SUBMIT</button></span>
											<span id="btn2" style="display: none;"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure you want to submit?')" name="action" value="edit">UPDATE</button></span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
				
			<!-- editor ends  -->
		</div>
		<hr class="mt-2">
<!-- 		<div class="row mt-2">
		<div class="col-md-12">
		<button class="btn btn-sm btn-info" style="float:right; width:5%; font-weight: 600">Next</button>
		</div>
		</div> -->
	</div>
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		 $('#summernote').summernote({
			  width: 800,   //don't use px
			
			  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
			 
		      lineHeights: ['0.5']
		
		 });

	$('#summernote').summernote({
	     
	      tabsize: 5,
	      height: 1000
	    });
	    
	});
	
	
	function showEditor(a){
		var x=a.toLowerCase();
		$('#editorHeading').html=a;
		document.getElementById('editorHeading').innerHTML=a;
		$('#attributes').val(a);
		var ajaxeresult=[];
		$.ajax({
			type:'GET',
			url:'specIntro.htm',
			data:{
				SpecsInitiationId:<%=SpecsInitiationId%>,
			},
			datatype:'json',
			success:function(result){
				ajaxeresult=JSON.parse(result);
				console.log("ajaxeresult1 ", ajaxeresult);
				var html="";
				var IntroductionId="";
				if(x==="system identification"){
					for(var i=0;i<ajaxeresult.length;i++){
						if(ajaxeresult[i][1]===a){
							html=ajaxeresult[i][2];
							IntroductionId=ajaxeresult[i][0];
						}
					}
					
					if(html.length>0){
						$('#summernote').summernote('code', html);
						$('#IntroductionId').val(IntroductionId);
						$('#btn1').hide();
						$('#btn2').show();
					}else{
					
					$('#summernote').summernote('code', "Guidance:This paragraph contains a full identification of the system or subsystem and associated software to which this document applies, including as applicable, identification number(s), title(s), abbreviation(s), and release number(s) where known.");
					$('#btn2').hide();
					$('#btn1').show();
					
					
					}
					}
				
				else if(x==="system overview"){
					for(var i=0;i<ajaxeresult.length;i++){
						if(ajaxeresult[i][1]===a){
							html=ajaxeresult[i][2];
							IntroductionId=ajaxeresult[i][0];
						}
					}
					if(html.length>0){
						$('#summernote').summernote('code', html);
						$('#IntroductionId').val(IntroductionId);
						$('#btn1').hide();
						$('#btn2').show();
					}else{
					$('#summernote').summernote('code', "Guidance:This paragraph briefly states the purpose of the system or subsystem and    associated software to which this document applies.  It describes the general nature of the system or subsystem and software; summarizes history of system development, operation, and maintenance; identifies project sponsor, acquirer, war fighter, developer, and support agencies; identifies current and planned operating sites; and lists other relevant documents.");
					$('#btn2').hide();
					$('#btn1').show();
					}
					}
				
				else if(x==="document overview"){
					for(var i=0;i<ajaxeresult.length;i++){
						if(ajaxeresult[i][1]===a){
							html=ajaxeresult[i][2];
							IntroductionId=ajaxeresult[i][0];
						}
					}
					if(html.length>0){
						$('#summernote').summernote('code', html);
						$('#IntroductionId').val(IntroductionId);
						$('#btn1').hide();
						$('#btn2').show();
					}else{
					$('#summernote').summernote('code', "Guidance:This paragraph summarizes the purpose and contents of this document and describes any security or privacy considerations associated with its use.");
					$('#btn2').hide();
					$('#btn1').show();
					}
				}
				
				
			}
		})
	
	

		
	}
	
	
	$('#Cform').submit(function() {
	    
		  var codeee=$('#summernote').summernote('code');
		  $('textarea[name=Details]').val($('#summernote').summernote('code'));
	});
	
	
	$(document).ready(function() {
		showEditor('<%=Attributes%>')
	});
	
	</script>
</body>
</html>