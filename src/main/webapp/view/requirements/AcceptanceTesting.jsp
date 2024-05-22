<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />
<style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }
</style>

  	<style type="text/css">
		

label{
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
	margin:0px 2%;
}

.fa-thumbs-up {
  font-family: FontAwesome, 'Quicksand', Quicksand, sans-serif;
}

.form-inline{

display: inline-block;
}


.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}
.inputx{
width:50%;
display:inline;
}
.fa-plus{
color:green;
}
.fa-minus{
color:red;
}
.fa-pencil{
color:blue;
}
.fa-times{
color:red;
}
input[type=checkbox] {
	accent-color: green;
}
.spansub{
    width: 60px;
    height: 24px;
    font-size: 10px;
    font-weight: bold;
    text-align: justify;
    display: inline-block;
}
#ModalReq::after{
  content: "Other Requirements";
  display: none;
  opacity:0;
}
#ModalReq:hover::after{
display:inline-block;
animation: fade-in 1s ease forwards;
}

@keyframes fade-in {
  from {
    opacity: 0;
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

@keyframes jumpIn {
  0% {
    transform: scale(0.2);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

</style>
</head>
<body>
<%
String initiationId = (String)request.getAttribute("initiationId");
String projectId = (String)request.getAttribute("projectId");
String productTreeMainId = (String)request.getAttribute("productTreeMainId");
String testPlanInitiationId = (String)request.getAttribute("testPlanInitiationId");

String attributes=(String)request.getAttribute("attributes");
List<Object[]>AcceptanceTesting= (List<Object[]>)request.getAttribute("AcceptanceTesting");

/* String TestSetUp=null;
String TestSetUpDiagram=null;
String TestingTools=null;

String TestSetUpId=null;
String TestSetUpDiagramId=null;
String TestingToolsId=null;
if(AcceptanceTesting!=null &&AcceptanceTesting.size()>0 ){
	for(Object[] AT:AcceptanceTesting){
		String AcceptanceType=AT[0].toString();
		if("Test Set Up".equalsIgnoreCase(AcceptanceType)){
			TestSetUp=AT[1].toString();
			TestSetUpId=AT[2].toString();
		}
		else if("Test Set Up Diagram".equalsIgnoreCase(AcceptanceType)){
			TestSetUpDiagram=AT[1].toString();
			TestSetUpDiagramId=AT[2].toString();
		}
		else if("Testing tools".equalsIgnoreCase(AcceptanceType)){
			TestingTools=AT[1].toString();
			TestingToolsId=AT[2].toString();
		}
	}
} */

ObjectMapper objectMapper = new ObjectMapper();
String jsonArray = objectMapper.writeValueAsString(AcceptanceTesting);



%>
</head>
<body>
	<nav class="navbar navbar-light bg-light justify-content-between"  style="margin-top: -1%">
		<a class="navbar-brand">
			<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f">ACCEPTANCE TESTING </span> <span style="color:#31708f;font-size: 19px"> </span></b>
		</a>
		<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="projectId" value="<%=projectId%>">
			<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
			<input type="hidden" name="testPlanInitiationId" value="<%=testPlanInitiationId%>">
	     	<button class="btn btn-info btn-sm  back ml-2 mt-1" formaction="ProjectTestPlanDetails.htm" formmethod="get" formnovalidate="formnovalidate" style="float:right;">BACK</button>
		</form>
	</nav>
 	<%String ses=(String)request.getParameter("result"); 
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
			            <!-- <div class="panel panel-info" style="margin-top: 10px;">
			                <div class="panel-heading d-flex align-items-center justify-content-between">
			                    <h4 class="panel-title mb-0" style="font-size: 14px;">1. Test Set Up</h4>
			                    <div class="d-inline-flex">
			                        <button class="btn bg-transparent buttonEd" type="button" id="btnEditor1" onclick="showEditor('Test Set Up')">
			                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			                        </button>
			                        <form action="TestSetUp.htm" method="post" enctype="multipart/form-data">
			                            <button class="btn btn-sm ml-1 bg-transparent" type="submit" onclick="showEditor('Test Set Up')" style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;" name="Action" value="GenerateExcel" formaction="TestSetUp.htm" formmethod="GET" formnovalidate="formnovalidate" data-toggle="tooltip" title="TEST SET UP Excel Format">
			                                <i class="fa fa-file-excel-o" aria-hidden="true" style="color: green; font-size: 20px; padding-right: 5px;"></i>
			                            </button>
			                        </form>
			                    </div>
			                </div>
			            </div> -->
			            <!--  -->
			            <div class="panel panel-info" style="margin-top: 10px;">
			                <div class="panel-heading d-flex align-items-center justify-content-between">
			                    <h4 class="panel-title mb-0" style="font-size: 14px;">1. Test Set Up Diagram</h4>
			                    <div class="d-inline-flex">
			                        <button class="btn bg-transparent buttonEd" type="button" id="btnEditor2" onclick="showEditor('Test Set Up Diagram')">
			                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			                        </button>
			                         <form action="TestSetUp.htm" method="post" enctype="multipart/form-data">
			                        <button class="btn btn-sm ml-1 bg-transparent" type="submit" onclick="showEditor('Test Set Up Diagram')" style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;" name="Action" value="GenerateExcelDiagram" formaction="TestSetUp.htm" formmethod="GET" formnovalidate="formnovalidate" data-toggle="tooltip" title="TEST DIAGRAM Excel Format">
			                            <i class="fa fa-file-excel-o" aria-hidden="true" style="color: green; font-size: 20px; padding-right: 5px;"></i>
			                        </button>
			                        </form>
			                    </div>
			                </div>
			            </div>
            			<!--  -->
			            <!-- <div class="panel panel-info" style="margin-top: 10px;">
			                <div class="panel-heading d-flex align-items-center justify-content-between">
			                    <h4 class="panel-title mb-0" style="font-size: 14px;">3. Testing tools</h4>
			                    <div class="d-inline-flex">
			                        <button class="btn bg-transparent buttonEd" type="button" id="btnEditor3" onclick="showEditor('Testing tools')">
			                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			                        </button>
			                         <form action="TestSetUp.htm" method="post" enctype="multipart/form-data">
			                        <button class="btn btn-sm ml-1 bg-transparent" type="submit" onclick="showEditor('Test Set Up')" style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;" name="Action" value="GenerateExcelTestingTools" formaction="TestSetUp.htm" formmethod="GET" formnovalidate="formnovalidate" data-toggle="tooltip" title="TESTING TOOLS Format">
			                            <i class="fa fa-file-excel-o" aria-hidden="true" style="color: green; font-size: 20px; padding-right: 5px;"></i>
			                        </button>
			                        </form>
			                    </div>
			                </div>
			            </div> -->
			             <!--  -->
			            <!-- <div class="panel panel-info" style="margin-top: 10px;">
			                <div class="panel-heading d-flex align-items-center justify-content-between">
			                    <h4 class="panel-title mb-0" style="font-size: 14px;">2. Test Verification Table</h4>
			                    <div class="d-inline-flex">
			                        <button class="btn bg-transparent buttonEd" type="button" id="btnEditor4" onclick="showEditor('Test Verification')">
			                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			                        </button>
			                         <form action="TestSetUp.htm" method="post" enctype="multipart/form-data">
			                        <button class="btn btn-sm ml-1 bg-transparent" type="submit" onclick="showEditor('Test Verification')" style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;" name="Action" value="GenerateTestVerificationTable" formaction="TestSetUp.htm" formmethod="GET" formnovalidate="formnovalidate" data-toggle="tooltip" title="TEST VERIFICATION Excel Format">
			                            <i class="fa fa-file-excel-o" aria-hidden="true" style="color: green; font-size: 20px; padding-right: 5px;"></i>
			                        </button>
			                        </form>
			                    </div>
			                </div>
			            </div> -->
			            <!--  -->
            
			             <!--  -->
			            <div class="panel panel-info" style="margin-top: 10px;">
			                <div class="panel-heading d-flex align-items-center justify-content-between">
			                    <h4 class="panel-title mb-0" style="font-size: 14px;">2. Test Objective</h4>
			                    <div class="d-inline-flex">
			                        <button class="btn bg-transparent buttonEd" type="button" id="btnEditor5" onclick="showEditor('Test Objective')">
			                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			                        </button>
			                    </div>
			                </div>
			            </div>
			            <!--  -->
            
                		<div class="panel panel-info" style="margin-top: 10px;">
			                <div class="panel-heading d-flex align-items-center justify-content-between">
			                    <h4 class="panel-title mb-0" style="font-size: 14px;">3. Role & Responsibility</h4>
			                    <div class="d-inline-flex">
			                        <button class="btn bg-transparent buttonEd" type="button" id="btnEditor6" onclick="showEditor('Role & Responsibility')">
			                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			                        </button>
			                  <form action="TestSetUp.htm" method="post" enctype="multipart/form-data">
			                        <button class="btn btn-sm ml-1 bg-transparent" type="submit" onclick="showEditor('Role & Responsibility')" style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;" name="Action" value="GenerateTestRoleResponsibility" formaction="TestSetUp.htm" formmethod="GET" formnovalidate="formnovalidate" data-toggle="tooltip" title="Role & Responsibility Excel Format">
			                            <i class="fa fa-file-excel-o" aria-hidden="true" style="color: green; font-size: 20px; padding-right: 5px;"></i>
			                        </button>
			                        </form>
			                    </div>
			                </div>
           	 			</div>
        			</div>
    			</div>
			</div>


			<!--div for Editor-->
			<div class="col-md-7" style="display: block" id="col1">
				<form action="AcceptanceTestingUpload.htm" method="POST" id="myfrm" enctype="multipart/form-data">
					<div class="card" style="border-color: #00DADA; margin-top: 2%;">
						<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight: 500; color: #31708f;">Test Set Up Diagram</h5>
						
						<hr>
						
						<div class="card-body" style="margin-top:-8px">
							<div class="row">
								<div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
									<div id="Editor" class="center"></div>
									<textarea name="Details" style="display: none;"></textarea>
									<div class="mt-2" align="center" id="detailsSubmit">
										<div class="row">
											<div class="col-md-2">
												<label> Attachment:</label>
											</div>
											<div class="col-md-6"> 
												<!-- <div align="center" class="mt-2" id="uploadDivA" style="display:none;"> -->
												<input class="form-control" type="file" id="excel_files" name="filenameC" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" required="required">
											</div>
											<div class="col-md-4"><span class="text-primary">(Please add respective Excel Sheet.)</span></div>
										</div>
										<span id="EditorDetails"></span> 
										<input type="hidden" name="projectId" value="<%=projectId%>">
										<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
										<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
										<input type="hidden" name="testPlanInitiationId" value="<%=testPlanInitiationId%>">	
										<input type="hidden" id="attributes" name="attributes" value="Test Set Up Diagram">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<span id="Editorspan">
											<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-success submit mt-2" onclick="return confirm('Are you sure you want to submit?')" name="Action" value="add">SUBMIT</button></span>
											<span id="btn2" style="display: none;"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure you want to submit?')" name="Action" value="edit">UPDATE</button></span>
											<input type="hidden" name="UpdateActionid" id="UpdateActionid" value="">
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
			$('#editorHeading').html=a;
			document.getElementById('editorHeading').innerHTML=a;
			$('#attributes').val(a);
			var html =<%=jsonArray%>
			console.log(html)
			var details="";
			var UpdateActionid;
			if(html.length>0){
			for(var i=0;i<html.length;i++){
				if(html[i][1]===a){
					details=html[i][2];
					UpdateActionid=html[i][0];
				}
			}
			}
			
			if(details.length>0){
				CKEDITOR.instances['Editor'].setData(details);
				$('#UpdateActionid').val(UpdateActionid);
				$('#btn1').hide();
			    $('#btn2').show();
			    var input = document.getElementById('excel_files');
	            input.removeAttribute('required');
			    
			}else{
				CKEDITOR.instances['Editor'].setData('');
				$('#btn1').show();
			    $('#btn2').hide();
			    var input = document.getElementById('excel_files');
			    input.setAttribute('required', true);
			}
			
			}
		 $('#myfrm').submit(function() {
			 var data =CKEDITOR.instances['Editor'].getData();

			 $('textarea[name=Details]').val(data);
			 });
		 $(function () {
				$('[data-toggle="tooltip"]').tooltip()
				})
	</script>


	<script>
	/* const excel_fileB = document.getElementById('excel_files');
	excel_fileB.addEventListener('change', (event) => {
		/* var value="x"
		if(x){ */
		var reader = new FileReader();
		reader.readAsArrayBuffer(event.target.files[0]);
		reader.onload = function (event){
			var data = new Uint8Array(reader.result);
			var work_book = XLSX.read(data, {type:'array'});
			var sheet_name = work_book.SheetNames;
	    	var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]],{header:1});
	     	var checkExcel = 0;
	     	if(sheet_data.length > 0){
	     		for (var row =0; row <sheet_data.length;row++){
	     			for(var cell = 0;cell<3;cell++){
	     				if(row==0){
    						if(cell==1 && "Test Type" != sheet_data[row][cell]){  checkExcel++;}
            				if(cell==2 && "Test Setup Name" != sheet_data[row][cell]){  checkExcel++;}
            				console.log(sheet_data[row][cell]+cell)
            			}
	     			}
	     		}
	     	}
		}
	/* }); */
	var msg="";
 	if(checkExcel>0){
 		msg="Upload Test Document!";
 		alert(msg);
 		excel_fileA.value="";
 	}else{
 		$('#uploadDivA').show();	
 	} 
	/* } */
	</script>
	
</body>
</html>