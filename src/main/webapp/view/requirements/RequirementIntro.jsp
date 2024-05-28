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
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<title>PMS</title>
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
	String attributes=(String)request.getAttribute("attributes");
	String reqInitiationId = (String)request.getAttribute("reqInitiationId");
	String productTreeMainId = (String)request.getAttribute("productTreeMainId");
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
			<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
			<button class="btn btn-info btn-sm  back ml-2 mt-1" formaction="ProjectRequirementDetails.htm" formmethod="get" formnovalidate="formnovalidate" style="float: right;">BACK</button>
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
										1.Introduction</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor1" onclick="showEditor('Introduction')">
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
									<span class="ml-2" style="font-size: 14px"> 3. Document
										Overview</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor4" onclick="showEditor('Document Overview')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button>
							</div>
						</div>
						
						<!--  -->
							<!-- 	<div class="panel panel-info" style="margin-top: 10px;">
								<div class="panel-heading ">
								<h4 class="panel-title">
								<span class="ml-2" style="font-size: 14px">5. Applicable Standards</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor5" onclick="showEditor('Applicable Standards')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button>
								</div>
								</div> -->
								<!--  -->
					<%-- 			<div class="panel panel-info" style="margin-top: 10px;">
								<div class="panel-heading ">
								<h4 class="panel-title">
								<span class="ml-2" style="font-size: 14px">6. Referenced Documents</span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button" id="btnEditor" onclick="showTable(<%=projectId %>)" style="margin-top:-2%;"><i class="fa fa-eye" aria-hidden="true" style="color:dodgerblue"></i></button>
								</div>
								</div>  --%>
					<!--  -->
					</div>
				</div>
			</div>
						<!--div for Editor-->
			<div class="col-md-7" style="display: block" id="col1">
			  <form action="RequiremnetIntroSubmit.htm" method="POST" id="myfrm">
					<div class="card" style="border-color: #00DADA; margin-top: 2%;">
						<h5 class="heading ml-4 mt-3" id="editorHeading"
							style="font-weight: 500; color: #31708f;">Introduction</h5>
						<hr>
						<div class="card-body" style="margin-top:-8px">
							<div class="row">
								<div class="col-md-12 " align="left"
									style="margin-left: 0px; width: 100%;">
									<div id="Editor" class="center"></div>
									<textarea name="Details" style="display: none;"></textarea>
									<div class="mt-2" align="center" id="detailsSubmit">
										<span id="EditorDetails"></span> 
										 <input type="hidden" name="projectId" value="<%=projectId%>">
										 <input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										 <input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
											<input type="hidden" id="attributes" name="attributes" value="Introduction">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <span id="Editorspan">
											<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-success submit mt-2" onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button></span>
											<span id="btn2" style="display: none;"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure you want to submit?')">UPDATE</button></span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
						<div class="col-md-7" style="display: none" id="col2">
			<div class="card-body bg-light mt-3">
							<div class="table-responsive ">
												<table class="table table-bordered " style="width: 100%;"
													id="myTable">
													<thead>
														<tr>
															<th style="width: 0%; text-align: center;">SN</th>
															<th style="width: 40%; text-align: center;">Name</th>
															<th style="width: 22%; text-align: center;">UpdateOn</th>
															<th style="width: 5%; text-align: center;">Ver</th>
															<th style="text-align: center;">Action</th>
														</tr>
													</thead>
													<tbody id="listtbody">

													</tbody>
												</table>
											</div>
											</div>
											<form action="PreProjectFileUpload.htm">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
											<input type="hidden" name="projectId" value="<%=projectId%>" /> 
											<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>" /> 
											<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>" /> 
											<button type="submit"class="btn btn-sm btn-info mt-2" id="adddoc">Add Documents</button>
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

			height : 250,

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
	
		function showEditor(a){
			var x=a.toLowerCase();
			$('#col1').show();
			$('#col2').hide();
			$('#editorHeading').html=a;
			document.getElementById('editorHeading').innerHTML=a;
			$('#attributes').val(a);
			var html="";
			$.ajax({
				Type:'GET',
				url:'RequirementIntro.htm',
				datatype:'json',
				data:{
					projectId:<%=projectId%>,
					reqInitiationId:<%=reqInitiationId%>,
				},
				success:function(result){
		var ajaxresult=JSON.parse(result);
					
					if(ajaxresult!=null){
						$('#btn1').show();
						$('#btn2').hide();
					if(x==="introduction"){
						if(ajaxresult[1]!=null){
						$('#btn2').show();$('#btn1').hide();
						html=ajaxresult[1];
						}else{
						html="Guidance:This paragraph should contain a full identification of the system to which this document applies.";	
						}
		
					}
					else if(x==="block diagram" && ajaxresult[2]!=null){
						$('#btn2').show();$('#btn1').hide();
						html=ajaxresult[2];
						
					}
					else if(x==="system overview" ){
						if(ajaxresult[3]!=null){
						$('#btn2').show();$('#btn1').hide();
						html=ajaxresult[3];
						}else{
						html="Guidance:This paragraph should briefly describe the general nature of the system required. It summarizes the objectives of the system from various perspectives (Operational, Maintenance, Deployment, Technological, Environmental and so on...), should give a brief description of the operating scenario and desired configuration of the system. It should also state the identified project sponsor, acquirer, developer, and support agencies; along with current and planned operating sites."	
						}
						
					}
					else if(x==="document overview" ){
						if(ajaxresult[4]!=null){
						$('#btn2').show();$('#btn1').hide();
						html=ajaxresult[4];
						}else{
							html="This document brings out the system requirements of the radar system. The document gives a brief overview of the system, states the modes of operation of the radar (operational, maintenance, training and so on..) along with types of operational modes. All requirements are classified under various categories and stated in a brief unambiguous manner after resolving all conflicts and identifying derived requirements. The various design and construction constraints imposed on the system either by the User or by the designer are clearly brought out. This document also brings out the precedence and criticality of the requirements. Verification methodologies such as Demonstration /Test / Analysis / Inspection / Special verification methods employed to validate the system requirements are clearly listed. This document also contains a tabularized verification matrix for every system requirement, Requirements Traceability matrix and states the key performance parameters/key system attributes";
						}
					
					}
					else if(x==="applicable standards" && ajaxresult[5]!=null){
						$('#btn2').show();$('#btn1').hide();
						html=ajaxresult[5];
						
					}
					}else{
						if(x==="introduction"){
							html="Guidance:This paragraph should contain a full identification of the system to which this document applies.";	
						}
						else if(x==="system overview" ){
							html="Guidance:This paragraph should briefly describe the general nature of the system required. It summarizes the objectives of the system from various perspectives (Operational, Maintenance, Deployment, Technological, Environmental and so on...), should give a brief description of the operating scenario and desired configuration of the system. It should also state the identified project sponsor, acquirer, developer, and support agencies; along with current and planned operating sites."	
						}
						else if(x==="document overview" ){
							html="This document brings out the system requirements of the radar system. The document gives a brief overview of the system, states the modes of operation of the radar (operational, maintenance, training and so on..) along with types of operational modes. All requirements are classified under various categories and stated in a brief unambiguous manner after resolving all conflicts and identifying derived requirements. The various design and construction constraints imposed on the system either by the User or by the designer are clearly brought out. This document also brings out the precedence and criticality of the requirements. Verification methodologies such as Demonstration /Test / Analysis / Inspection / Special verification methods employed to validate the system requirements are clearly listed. This document also contains a tabularized verification matrix for every system requirement, Requirements Traceability matrix and states the key performance parameters/key system attributes";
						}
						
						$('#btn1').show();
						$('#btn2').hide();
					}
					CKEDITOR.instances['Editor'].setData(html);
				}
			});
			
		}
		  var table1=$("#myTable").DataTable({		 
				 "lengthMenu": [5,10,25, 50, 75, 100 ],
				 "pagingType": "simple",
				 "pageLength": 5,
				 "language": {
				      "emptyTable": "Files not Found"
				    }
			});
		function showTable() { 
			$('#col1').hide();
			$('#col2').show();
			table1.destroy();
			  $.ajax({
			  Type:'GET',
			  url:'ProjectStepFiles.htm',
			  datatype:'json',
			  data:{
				  stepid:1,
				  projectId:<%=projectId%>,
				  reqInitiationId:<%=reqInitiationId%>,
			  },
			  success:function(result){
				  var ajaxresult=JSON.parse(result);
				  var html="";
				  for(var i=0;i<ajaxresult.length;i++){
					  const date = new Date(ajaxresult[i][1]);
					   const formattedDate = date.toLocaleDateString('en-GB', {
                      day: '2-digit',
                      month: '2-digit',
                      year: 'numeric',
                      }).replace(/\//g, '-');
					  html=html+"<tr><td align='center'>"+(i+1)+"</td><td>"+ajaxresult[i][0]+"</td><td align='center'>"+formattedDate+"</td><td align='center'>"+ajaxresult[i][2]+"</td><td align='center'><button type='submit' class='btn bg-transparent' id='download'  name='DocId'  formaction='ProjectRequirementAttachmentDownload.htm' formtarget='_blank' formmethod='GET' value='"+ajaxresult[i][6]+","+ajaxresult[i][2]+","+ajaxresult[i][4]+","+ajaxresult[i][5]+"'><i class='fa fa-download' ></i></button></td></tr>"
				  }
				  $('#filestable').css("display","block");
				  $('#listtbody').html(html);
				  table1=$("#myTable").DataTable({		 
						 "lengthMenu": [5,10,25, 50, 75, 100 ],
						 "pagingType": "simple",
						 "pageLength": 5,
						 "language": {
						      "emptyTable": "Files not Found"
						    }
					}); 
			  }
		  })
	}

		  $('#myfrm').submit(function() {
				 var data =CKEDITOR.instances['Editor'].getData();
				 console.log(data);
				 $('textarea[name=Details]').val(data);
				 });
		  		$(document).ready(function() {
		 		var a=<%='"'+attributes+'"'%> 
				if(a==="Introduction"){
					showEditor(a);
			  	$('#btnEditor1').click();
				}else if(a==="Block Diagram"){
					showEditor(a);
				$('#btnEditor2').click();
				}else if(a==="System Overview"){
					showEditor(a);
				$('#btnEditor3').click();
				}else if(a==="Document Overview"){
					showEditor(a);
				$('#btnEditor4').click();
				}else if(a==="Applicable Standards") {
					showEditor(a);
				$('#btnEditor5').click();
					showEditor(a);
				}
				});

	</script>
</body>
</html>