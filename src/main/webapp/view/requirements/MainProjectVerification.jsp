<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<style>
.bs-example {
	margin: 20px;
}

.accordion .fa {
	margin-right: 0.5rem;
}

.spansub {
	width: 49px;
	height: 24px;
	font-size: 10px;
	font-weight: bold;
	text-align: justify;
	display: inline-block;
}

.fa-times {
	color: red;
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

#MyTable1>thead {
	background: #055C9D;
	color: white;
	font-weight: 800;
	font-size: 1rem;
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

#adddoc {
	font-weight: 600;
	font-family: 'Montserrat', sans-serif;
	float: right;
}

.inputx {
	width: 50%;
	display: inline;
	padding: 0px;
	line-height: 20px;
}

.close>span:hover {
	border: 1px solid black;
	padding: 0px 2px 0px 2px;
}

#noSqr {
	border: 5px solid gray;
	padding: 20px;
	width: 50%;
	margin: 10rem 0rem 0rem 30%;
	box-shadow: 5px 5px 5px gray;
	color: red;
	animation: blinker 1s linear infinite;
	top: -3px !important;
}

@
keyframes blinker { 50% {
	opacity: 0.5;
}
}
</style>
</head>
<body>
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	String projectId = (String) request.getAttribute("projectId");
	String paracounts = (String) request.getAttribute("paracounts");
	List<Object[]>Verifications=(List<Object[]>)request.getAttribute("Verifications");
	String selected="";

	String verificationId=(String)request.getAttribute("verificationId");
	String reqInitiationId = (String)request.getAttribute("reqInitiationId");
	String productTreeMainId = (String)request.getAttribute("productTreeMainId");
	
	Object[] projectDetails = (Object[]) request.getAttribute("projectDetails");
	%>
	<nav class="navbar navbar-light bg-light justify-content-between"
		style="margin-top: -1%">
		<a class="navbar-brand"> 
			<b style="color: #585858; font-size: 19px; font-weight: bold; text-align: left; float: left">
				<span style="color: #31708f">
					Verification Provisions 
				</span> 
				<span style="color: #31708f; font-size: 19px">
					<%if(projectDetails!=null) {%>
						<%=projectDetails[2]!=null?projectDetails[2]:"-" %>
						(<%=projectDetails[1]!=null?projectDetails[1]:"-" %>)
					<%} %>
				</span>
			</b>
		</a>
		<form action="#">
	<!-- 		<button class="btn bg-transparent"
				formaction="RequirementParaDownload.htm" formmethod="get"
				formnovalidate="formnovalidate" formtarget="_blank">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button> -->
<%--  <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}" />  <input
				type="hidden" name="projectId" value="<%=projectId%>"> --%>
			<%-- <button type="button" class="btn btn-sm btn-success font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq">Other Requirements</button> 
 -->	
 		 <%if(SQRFile==null){ %>
 		<button class="btn btn-sm btn-success mt-1" formaction="ProjectIntiationListSubmit.htm" formmethod="post" formnovalidate="formnovalidate" name="sub" value="Details">ADD SQR</button>
 		
 		<%} %> --%>
			<button class="btn btn-info btn-sm  back ml-2 mt-1"
				formaction="ProjectRequirementDetails.htm" formmethod="get"
				formnovalidate="formnovalidate" style="float: right;">BACK</button>
			<input type="hidden" name="projectId" value=<%=projectId%>> 
			<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
			<input type="hidden" name="projectShortName">

		</form>
	</nav>
	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div class="mt-2" align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div class="mt-2" align="center">
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>
	</div>
	<%
	}
	%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-5">
				<div class="card" style="border-color: #00DADA; margin-top: 2%;">
					<div class="card-body" id="scrollclass" style="height: 30.5rem;overflow: auto;">

						<%
						if (Verifications!=null &&  !Verifications.isEmpty()) {
							int count = 0;
							for (Object[] obj : Verifications) {
						%>
						<form action="#">
							<div class="panel panel-info" style="margin-top: 10px;">
								<div class="panel-heading ">
									<h4 class="panel-title">
										<span class="ml-2" style="font-size: 14px">
											<%=++count%>&nbsp;&nbsp;&nbsp; 
											<input type="hidden" id="verificationcount<%=obj[0].toString()%>" name="verificationcount" value="<%=count%>"> 
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
											<input type="hidden" name="projectId" value="<%=projectId%>">
											<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
											<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
											<input type="text" class="form-control inputx" id="input<%=obj[0].toString()%>" name="Provisions" maxlength="250 characters" placeholder="Enter Text" value="<%=obj[1].toString()%>" readonly style="width: 40%">
											<input type="hidden" name="VerificationId" value=<%=obj[0].toString()%>>
											<button class="btn btn-sm ml-1 bg-transparent" type="button"
												id="btns<%=obj[0].toString()%>"
												style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;"
												onclick="showSpan(<%=obj[0].toString()%>)"
												data-toggle="tooltip" data-placement="right"
												data-original-data="" title=""
												data-original-title="EDIT Provisions">
												<i class="fa fa-lg fa-pencil" aria-hidden="true"
													style="color: blue;"></i>
											</button> 
											<span id="spans<%=obj[0].toString()%>" style="display: none">
												<button class="btn btn-sm btn-info spansub" type="submit"
													formaction="VerificationProvisionEdit.htm" formmethod="POST" formnovalidate="formnovalidate"
													onclick="return confirm('Are you sure you want to update?')">Update</button>
												<button class="btn bg-transparent" type="button"
													onclick="hideUpdateSpan(<%=obj[0].toString()%>)">
													<i class="fa fa-times" aria-hidden="true"></i>
												</button>
										</span>


										</span>
									</h4>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />   
									<input type="hidden" name="projectId" value="<%=projectId%>">
									<button class="btn bg-transparent buttonEd" type="button"
										style="display: block;" id="btnEditor<%=count%>"
										onclick="showEditor(<%=obj[0].toString()%>,'<%=obj[1].toString()%>')"
										data-toggle="tooltip" data-placement="left"
										data-original-data="" title=""
										data-original-title="VIEW & EDIT PROVISIONS DETAILS">
										<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
									</button>

								</div>
							</div>
						</form>
						<%
						}
						}
						%>
						<div class="panel panel-info" style="margin-top: 10px;">
							<div class="panel-heading ">
								<form action="#">
									<h4 class="panel-title">
										<span class="ml-2" style="font-size: 14px"> 
											<input type="text" class="form-control inputx" name="Provisions" maxlength="250 characters" placeholder="Enter Text" id="ParaNOid">
											<button class="btn btn-success btn-sm ml-3" type="submit"
												formaction="RequirementVerificationAdd.htm" formmethod="POST"
												formnovalidate="formnovalidate"
												style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;"
												onclick="submitForm()">ADD
											</button>
										</span>
									</h4>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
									<input type="hidden" name="projectId" value="<%=projectId%>">
									<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
									<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
									<button class="btn bg-transparent buttonEd" type="button"
										style="display: none;" id="btnEditor1" onclick="">
										<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
									</button>
								</form>
							</div>
						</div>

					</div>
				</div>
			</div>

			<!-- Editor -->
			<div class="col-md-7" style="display: block" id="col1">
				<form action="VerificationProvisionEdit.htm" method="POST" id="myfrm">
					<div class="card" style="border-color: #00DADA; margin-top: 2%;">
						<h5 class="heading ml-4 mt-3" id="editorHeading"
							style="font-weight: 500; color: #31708f;"></h5>
						<hr>
						<div class="card-body" style="margin-top: -8px">
							<div class="row">
								<div class="col-md-12 " align="left"
									style="margin-left: 0px; width: 100%;">
									<div id="Editor" class="center"></div>
									<textarea name="Details" style="display: none;"></textarea>
									<div class="mt-2" align="center" id="detailsSubmit">
										<span id="EditorDetails"></span>
										<input type="hidden" id="verificationcountDetails " name="verificationcount" value=""> 
										<input type="hidden" name="Provisions" id="Provisionss" value="">
										<input type="hidden" name="VerificationId" id="VerificationIds" value="">  
										<input type="hidden" name="projectId" value=<%=projectId%>> 
										<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<span id="Editorspan"> 
											<span id="btn1" style="display:none;">
												<button type="submit" class="btn btn-sm btn-success submit mt-2" onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button>
											</span>
											<span id="btn2" style="display: none;">
												<button type="submit" class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure you want to update?')">UPDATE</button>
											</span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	


	<script>
	var inputValue; 
	function showSpan(a){
		console.log(a+"***********");
		$('#btns'+a).hide();
		$('#spans'+a).show();
		inputValue=document.getElementById("input"+a).value;
		document.getElementById("input"+a).readOnly=false;
	}
	function hideUpdateSpan(a){
		$('#btns'+a).show();
		$('#spans'+a).hide();
		document.getElementById("input"+a).value=inputValue;
		document.getElementById("input"+a).readOnly=true;
	}
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

			height : 280,

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
					cellpadding : '5',
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
		
		$( document ).ready(function() {
			
			var paracounts=<%=paracounts%>;
			$('#btnEditor'+paracounts).click();
			var editorHeading=document.getElementById('editorHeading').innerHTML;
			if(editorHeading.length>0){
			console.log("---")
			}		
			});
		function showEditor(VerificationId,Provisions){
		document.getElementById('VerificationIds').value=VerificationId;
		document.getElementById('Provisionss').value=Provisions;
		var verificationcount=$('#verificationcount'+VerificationId).val();
		document.getElementById('verificationcountDetails ').value=verificationcount;
		document.getElementById('editorHeading').innerHTML=Provisions;
		$.ajax({
			type:'GET',
			url:'VerificationProvisionDetails.htm',
			datatype:'json',
			data:{
				reqInitiationId:<%=reqInitiationId%>,
			},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				console.log(ajaxresult+"------")
				var html="";
				for(var i=0;i<ajaxresult.length;i++){
					if(ajaxresult[i][0]===VerificationId && ajaxresult[i][3]!=null){
						html=ajaxresult[i][3];
					}
				}
				CKEDITOR.instances['Editor'].setData(html);
				
				if(html.length>1){ // if list [i][5] is empty show update button else submit button
				$('#btn1').hide();
				$('#btn2').show();
				}else{
					$('#btn2').hide();
					$('#btn1').show();
				}
			}
		})
		}
	   $('#myfrm').submit(function() {
		 var data =CKEDITOR.instances['Editor'].getData();
		 $('textarea[name=Details]').val(data);
		});
		$(function () {
		$('[data-toggle="tooltip"]').tooltip()
		})
			function submitForm(){
			var ParaNOid=$('#ParaNOid').val().trim();
			console.log(ParaNOid+"---")
			if(ParaNOid.length==0){
				alert("The field is empty!")
				event.preventDefault();
				return false;
			}else{
				if(confirm("Are you sure you want to submit?")){
					return true;
					}else{
					event.preventDefault();
					return false;	
					}
			}
			}
	
</script>
</body>
</html>