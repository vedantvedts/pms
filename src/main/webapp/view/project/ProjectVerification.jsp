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

.form-check-input:checked ~ .form-check-label::before {
	color: #fff;
	border-color: #7B1FA2;
	background-color: red;
}

.inputx {
	width: 40%;
	display: inline;
}

.fa-plus {
	color: green;
}

.fa-minus {
	color: red;
}

.fa-pencil {
	color: blue;
}

.fa-times {
	color: red;
}

input[type=checkbox] {
	accent-color: green;
}

.spansub {
	width: 49px;
	height: 24px;
	font-size: 10px;
	font-weight: bold;
	text-align: justify;
	display: inline-block;
}

#ModalReq::after {
	content: "Other Requirements";
	display: none;
	opacity: 0;
}

#ModalReq:hover::after {
	display: inline-block;
	animation: fade-in 1s ease forwards;
}

@
keyframes fade-in {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

.modal-dialog-jump {
	animation: jumpIn 1.5s ease;
}

@
keyframes jumpIn { 0% {
	transform: scale(0.2);
	opacity: 0;
}

70
%
{
transform
:
scale(
1
);
}
100
%
{
transform
:
scale(
1
);
opacity
:
1;
}
}
.btns {
	width: 44px;
	height: 24px;
	font-size: 10px;
	font-weight: bold;
	text-align: justify;
	display: inline-block;
}
</style>
<%
String initiationId = (String)request.getAttribute("initiationId");
String reqInitiationId =(String)request.getAttribute("reqInitiationId");
String paracounts = (String) request.getAttribute("paracounts");
String project=(String)request.getAttribute("project");
String[]projectDetails=project!=null?project.split("/"):null;
List<Object[]>Verifications=(List<Object[]>)request.getAttribute("Verifications");
String selected="";
if(!Verifications.isEmpty()){
	 selected=Verifications.get(0)[0].toString();
}

String verificationId=(String)request.getAttribute("verificationId");

%>
</head>

<body>

	<nav class="navbar navbar-light bg-light justify-content-between"
		style="margin-top: -1%">
		<a class="navbar-brand"> <b
			style="color: #585858; font-size: 19px; font-weight: bold; text-align: left; float: left"><span
				style="color: #31708f">Verification Provisions for Project </span> <span
				style="color: #31708f; font-size: 19px"> <%=projectDetails!=null?projectDetails[1].toString():"-" %></span></b>
		</a>
		<form action="#">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}" /> 
				<input type="hidden" name="project" value="<%=project%>"> 
				<input type="hidden" name="initiationId" value="<%=initiationId%>">
				<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
			<!-- 		<button type="button" class="btn btn-sm btn-success font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq">Other Requirements</button> 
 -->
			<button class="btn btn-info btn-sm  back ml-2 mt-1"
				formaction="ProjectOverAllRequirement.htm" formmethod="get"
				formnovalidate="formnovalidate" style="float: right;">BACK</button>
		</form>
	</nav>
	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div class="mt-2" align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div class="mt-2" align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
	<%} %>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-5">
				<div class="card" style="border-color: #00DADA; margin-top: 2%;">
					<div class="card-body" id="scrollclass" style="height: 30.5rem;">

						<%
						if (!Verifications.isEmpty())  { 
							int count = 0;
							for (Object[] obj : Verifications) {
						%>
						<form action="#">
							<div class="panel panel-info" style="margin-top: 10px;">
								<div class="panel-heading ">

									<h4 class="panel-title">
										<span class="ml-2" style="font-size: 14px"> <%=++count%>.
											<input type="text" readonly class="form-control inputx inputs" id="input<%=obj[0].toString() %>" value="<%=obj[1].toString() %>">
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
										<button class="btn bg-transparent buttonEd" type="button"
											style="display: block; float: right"
											id="btnEditor<%=obj[0].toString() %>"
											onclick="showEditor(<%=obj[0].toString() %>,'<%=obj[1].toString() %>')"
											data-toggle="tooltip" data-placement="left"
											data-original-data="" title=""
											data-original-title="VIEW &amp; EDIT PARA DETAILS">
											<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
										</button>
									</h4>
									<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
									<input type="hidden" name="project" value="<%=project%>"> 
									<input type="hidden" name="initiationId" value="<%=initiationId%>">
									<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
									<input type="hidden" name="VerificationId" value=<%=obj[0].toString()%>>
									<input type="hidden" id="verificationcount<%=obj[0].toString()%>" name="verificationcount" value="<%=count%>"> 
								</div>
							</div>
						</form>
						<%
						}}
						%>
						<div class="panel panel-info" style="margin-top: 10px;">
							<div class="panel-heading ">
								<form action="RequirementVerificationAdd.htm" method="POST">
									<h4 class="panel-title">
										<span class="ml-2" style="font-size: 14px"> 
										<input type="text" class="form-control inputx" name="Provisions" maxlength="250 characters" placeholder="Enter Text" id="ParaNOid">
											<button class="btn btn-success btn-sm ml-3" type="submit"
												style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;"
												onclick="submitForm()">ADD</button>
										</span>
									</h4>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="project" value="<%=project%>"> 
									<input type="hidden" name="initiationId" value="<%=initiationId%>">
									<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
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
			<%-- <%if(!Verifications.isEmpty()){ %>
			<div class="col-md-7" style="display: block" id="col1">
				<form action="RequirementProvisionDetailsUpdate.htm" method="POST"
					id="myfrm">
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
										<input type="hidden" name="project" value="<%=project%>"> 
										<input type="hidden" name="initiationId" value="<%=initiationId%>">
										<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										<input type="hidden" id="verificationId" name="verificationId"
											value=""> <input type="hidden"
											name="${_csrf.parameterName}" value="${_csrf.token}" /> <span
											id="Editorspan"> <span id="btn1"
											style="display: none;">
												<button type="submit"
													class="btn btn-sm btn-success submit mt-2"
													onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button>
										</span> <span id="btn2" style="display: none;"><button
													type="submit" class="btn btn-sm btn-warning edit mt-2"
													onclick="return confirm('Are you sure you want to update?')">UPDATE</button></span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<%} %> --%>
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
										<input type="hidden" name="initiationId" value="<%=initiationId%>">
										<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										<input type="hidden" name="project" value="<%=project%>"> 
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
// var realValue;
//function updateData(a){
//	realValue=$('#inputs'+a).val();
//	document.getElementById("inputs"+a).readOnly=false
//	$('#btns'+a).hide();
//	$('#spans'+a).show();
//
//}

//function showEdit(a){
//	$('#btns'+a).show();
//	$('#spans'+a).hide();
//	document.getElementById("inputs"+a).value=realValue;
//	document.getElementById("inputs"+a).readOnly=true;
//} 

var inputValue; 
function showSpan(a){
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


/* function Edit(a){
var value=$('#inputs'+a).val();
	

	var isUpdate=true;
	if(value===inputValue){
		alert("previous and new values both are same");
		isUpdate=false;
	}
	if(value.length==0){
		alert("Field can not be empty");
		isUpdate=false;
	}
	if(	isUpdate){
		if(confirm('Are you sure to submit?')){
			$.ajax({
				type:'GET',
				url:'RequirementProvisionUpdate.htm',
				datatype:'json',
				data:{
					value:value,
					VerificationId:a
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					var num=Number(ajaxresult);
					if(!isNaN(num) &&  num>0){
						alert("Provision updated successfully")
						location.reload();
					}
					
				}
			})
		}
		else{
			return false;
			event.preventDefault();
		}
	}
	
	console.log(value);
	console.log(inputValue)
} */

/*for Editor  */

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
		
		<%-- function showEditor(VerificationId,Provisions){
			document.getElementById('verificationId').value=VerificationId;
			var Verification=<%=request.getAttribute("Verifications")%>;
			$('#editorHeading').text(Provisions);
		var html;
		 for(var i=0;i<Verification.length;i++){
				if(Verification[i][0]==VerificationId){
					html=Verification[i][3];
				}
			}
		 if(html===null){
			 CKEDITOR.instances['Editor'].setData("");
			 $('#btn1').show();
			 $('#btn2').hide();
		 }else{
			 CKEDITOR.instances['Editor'].setData(html);
			 $('#btn2').show();
			 $('#btn1').hide();
		 }
		}
		   $('#myfrm').submit(function() {
				 var data =CKEDITOR.instances['Editor'].getData();
				 $('textarea[name=Details]').val(data);
				});
		   $( document ).ready(function() {
			  var id=<%=verificationId  %>;
			  if(id===null){
			 var selected = <%=	selected%>;
			$('#btnEditor'+selected).click();
			  }else{
			  $('#btnEditor'+id).click();
			  }
			}); --%>
		   
		   
		
		   
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