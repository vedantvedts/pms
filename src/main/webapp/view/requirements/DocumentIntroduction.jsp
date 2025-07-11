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
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />

<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>

<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
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

.note-editable{
height:450px;
}
</style>
</head>
<body>
<%

class Module{
	int id;
	String moduleName;
	
	public Module(int id,String moduleName){
		this.id=id;
		this.moduleName=moduleName;
	}
}

List<Module>listOfModules = new ArrayList<>();
int moduleCount=0;
listOfModules.add(new Module(++moduleCount,"Introduction"));
listOfModules.add(new Module(++moduleCount,"Description"));
listOfModules.add(new Module(++moduleCount,"Block Diagram"));
listOfModules.add(new Module(++moduleCount,"Operational Condition"));
listOfModules.add(new Module(++moduleCount,"States and Modes"));
listOfModules.add(new Module(++moduleCount,"Functions"));
String Mainid=(String)request.getAttribute("Mainid"); 
String btnId=(String)request.getAttribute("btnId"); 

if(btnId==null){
	btnId="1";
}


String ses=(String)request.getParameter("result"); 

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

						<%for(Module m:listOfModules) {%>
						<div class="panel panel-info" style="margin-top: 10px;" >
							<div class="panel-heading ">
								<h4 class="panel-title">
									<span class="ml-2" style="font-size: 14px">
										<%=m.id %>. <%=m.moduleName %></span>
								</h4>
								<button class="btn bg-transparent buttonEd" type="button"
									id="btnEditor<%=m.id %>" onclick="showEditor('<%=m.id %>','<%=m.moduleName %>')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button>
							</div>
						</div>
						<%} %>
					</div>
				</div>
			</div>
			
					<div class="col-md-7" style="display: block" id="col1">
			 <%if(Mainid!=null){ %>
			
					<div class="card" style="border-color: #00DADA; margin-top: 2%;">
						<h5 class="heading ml-4 mt-3" id="editorHeading"
							style="font-weight: 500; color: #31708f;"></h5>
						<hr>
						<div class="card-body" style="margin-top:-8px">
							<div class="row">
								<div class="col-md-12 " align="left"
									style="margin-left: 0px; width: 100%;">
									<div id="Editor" class="center"></div>
									<textarea name="Details" style="display: none;"></textarea>
									<div class="mt-2" align="center" id="detailsSubmit">
										<span id="EditorDetails"></span> 
										 <input type="hidden" name="Mainid" value="<%=Mainid%>">
											<span id="btn1" style="display: block;"><button type="button"class="btn btn-sm btn-success submit mt-2" onclick="submitData()">SUBMIT</button></span>
										 <span id="btn2" style="display: none;"><button type="button"class="btn btn-sm btn-warning edit mt-2" onclick="submitData()">UPDATE</button></span>
									
									</div>
								</div>
							</div>
						</div>
					</div>
			
				<%} %>
			</div>
			
			
			</div>
			</div>
			
	<script>
    var moduleNames="Introduction";
	$(document).ready(function() {
		$('#Editor').summernote({
			width: 900,
		     toolbar: [
	             // Adding font-size, font-family, and font-color options along with other features
	             ['style', ['bold', 'italic', 'underline', 'clear']],
	             ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
	             ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
	             ['para', ['ul', 'ol', 'paragraph']],
	             ['height', ['height']]
	         ],
	         fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
	         fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
	         buttons: {
	             // Custom superscript and subscript buttons
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
	 
		   	height:300
		    });

	
		    var btnId = '<%=btnId%>'; // e.g., "123"
		    
		
		    var btnSelector = "#btnEditor" + btnId;
		    if ($(btnSelector).length) {
		        $(btnSelector).click();
		    } else {
		        console.warn("Button not found: " + btnSelector);
		    }
		    
	
	});
	var introductionId = 0;
	function showEditor(mainId,moduleName){
		moduleNames=moduleName;
		console.log(moduleName)
		document.getElementById('editorHeading').innerHTML=moduleName;
		introductionId = 0;
		$('#btn1').show();
		$('#btn2').hide();
		
		$.ajax({
		
			type:'GET',
			url:'getSubsytemIntroduction.htm',
			datatype:"json",
			data:{
				MainId:<%=Mainid%>,
			},
			success:function(result){
				var html="";
				var ajaxresult = JSON.parse(result);
				console.log(ajaxresult);
				for(var i=0;i<ajaxresult.length;i++){
					if(ajaxresult[i].introduction===moduleName){
						console.log("HIiii")
						html=ajaxresult[i].Details;
						introductionId=ajaxresult[i].introductionId;
						$('#btn1').hide();
						$('#btn2').show();
					}
				
				}
				
				$('#Editor').summernote('code', html);
			}
			
			
		})
		
	}
	
	
	function submitData(){
		
		var html = $('#Editor').summernote('code');
		
		console.log(introductionId+"introductionId")
	
		if ($('#Editor').summernote('isEmpty')) {
		   alert("Please add some Data!")
		} else {
		  
			 Swal.fire({
		            title: 'Are you sure to submit Data?',
		            icon: 'question',
		            showCancelButton: true,
		            confirmButtonColor: 'green',
		            cancelButtonColor: '#d33',
		            confirmButtonText: 'Yes'
		        }).then((result) => {
		            if (result.isConfirmed) {
		            	$.ajax({
		            	type:'POST',
		            	url:'submitSubIntroDuction.htm',
		            	datatype:'json',
		            	data:{
		            		MainId:<%=Mainid%>,
		            		Details:html,
		            		moduleName:moduleNames,
		            		introductionId:introductionId,
		            		${_csrf.parameterName}:	"${_csrf.token}",
		            	},
		            	success:function (result){
		            		var ajaxresult = JSON.parse(result);
		            		console.log(typeof ajaxresult+" --"+ajaxresult);
		            		if(ajaxresult!==0){
		            			introductionId=ajaxresult;
		            			Swal.fire({
		            			
			            			  icon: "success",
			            			  title: "SUCCESS",
			            			  text:moduleNames +  " Data submitted  Successfully",
			            			  allowOutsideClick :false
			            			});
		            			$('#btn1').hide();
								$('#btn2').show();
		            		}else{
		            			Swal.fire({
		            				  icon: "warning",
		            				  title: "Sorry",
		            				  text: "Something went wrong!",
		            				  allowOutsideClick :false
		            				});
		            		}
		            		
		            		
		            	
		            	}
		            	})
		            	
		            } else {
		                // Optionally do something if cancelled
		                console.log("Action cancelled");
		            }
		        });
			
			
		}

	}
	
	
	</script>
</body>
</html>