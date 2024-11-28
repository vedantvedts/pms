<%@page import="com.vts.pfms.requirements.model.SpecificationMaster"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />



<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<style>

label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 20px;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
}
h6 {
	text-decoration: none !important;
}
.multiselect-view>li>a>label {
	padding: 4px 20px 3px 20px;
}
.width {
	width: 210px !important;
}
.bootstrap-select {
	width: 400px !important;
}
#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}
#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}
select:-webkit-scrollbar { /*For WebKit Browsers*/
	width: 0;
	height: 0;
}
.requirementid {
	border-radius: 5px;
	box-shadow: 10px 10px 5px lightgrey;
	margin: 1% 0% 3% 2%;
	padding: 5px;
	padding-bottom: 10px;
	display: inline-grid;
	width: 15%;
	background-color: antiquewhite;
	float: left;
	align-items: center;
	justify-content: center;
	overflow: auto;
	position: stickey;
}

.requirementid::-webkit-scrollbar {
	display: none;
}

.requirementid:hover {
	padding: 13px;
}

.viewbtn {
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

/* .viewbtn:hover {
	cursor: pointer !important;
	background-color: #22c8e5 !important;
	border: none !important;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19) !important;
} */

.viewbtn1 {
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

.viewbtn1:hover {
	background: green;
}

#view {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
	box-shadow: 8px 8px 5px lightgrey;
	max-width: 85%;
}

hr {
	margin-left: 0px !important;
	margin-bottom: 0px;
	!
	important;
}
.note-editing-area{

} 
#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 20px;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
}
.addreq {
	margin-left: -20%;
	margin-top: 5%;
}

#modalreqheader {
	background: #145374;
	height: 44px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}

#code {
	padding: 0px;
	width: 64%;
	font-size: 12px;
	margin-left: 2%;
	margin-bottom: 7%;
}

#addReqButton {
	display: flex;
	align-items: center;
	justify-content: end;
}

#modaal-A {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	font-family: sans-serif;
}

#editreq {
	margin-bottom: 5px;
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

#reqbtns {
	box-shadow: 2px 2px 2px;
	font-size: 15px;
	font-weight: 500;
}

#attachadd, #viewattach {
	margin-left: 1%;
	box-shadow: 2px 2px 2px black;
	font-size: 15px;
	font-weight: 500;
}

#reqName {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
}
#reqName1 {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
	margin-bottom: 20px;
}

@
keyframes blinker { 20% {
	opacity: 0.65;
}

}
#attachmentadd, #attachmentaddedit {
	display: flex;
	margin-top: 2%;
}

#download, #deletedownload {
	box-shadow: 2px 2px 2px grey;
	margin-left: 1%;
	margin-top: 1%;
	margin-right: 1%;
}

#headerid, #headeridedit {
	margin-top: 1%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1%;
}

#reqdiv:hover {

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

.multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
}
.modal-dialog-jump-pop {
	animation: jumpIn .5s ease;
}
.modal-dialog-jump {
	animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.3);
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





#container {
    background-color: white;
    display: inline-block;
    margin-left: 2%;
    margin-top: 1%;
 
}

.note-editing-area{


}

</style>
</head>
<body>

<%
SpecificationMaster sp = (SpecificationMaster)request.getAttribute("SpecificationMaster");
%>


			<div class="container" id="container" style="max-width:95%">
			<form action="specificationMasterAddSubmit.htm" method="POST">
			<div class="row" id="row1">
			
				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
							<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Name: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								
								<div class="col-md-9">
								
								<input type="text" name="SpecificationName" class="form-control" value="<%=sp.getSpecificationName()!=null?sp.getSpecificationName():"" %>" placeholder="maximum 255 characters" required>
								</div>
								</div>
								
							<br>
							<div class="row" id ="specsDiv" style="display: none;">
								<div class="col-md-3">
									<label id="specsId" style="font-size: 17px; margin-top: 5%; color: #07689f">
											
										</label>
										
								</div>
								
							</div>
					
								
									<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Description: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-9" id="Editor">
			   					<%=sp.getDescription()!=null?sp.getDescription():"" %>

<!-- 								<textarea required="required" name="description" class="form-control" id="descriptionadd" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
 -->								</div>
    								<textarea name="description" style="display: none;"  id="ConclusionDetails"></textarea>	
								</div>
								<div class="row mt-2">
								 
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Parameter: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specParameter" id="specParameter" required="required" value="<%=sp.getSpecsParameter()!=null?sp.getSpecsParameter():"" %>">
								</div>
								
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%;float:right; color: #07689f">Specification Unit: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specUnit" id="specUnit" required="required" value="<%=sp.getSpecsUnit()!=null?sp.getSpecsUnit():"" %>">
								</div>
								
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%;float:right; color: #07689f">Specification Value: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specValue" id="specValue" required="required" value="<%=sp.getSpecValue()!=null?sp.getSpecValue():"" %>">
								</div>
								
								</div>
								
								<div align="center" class="mt-2">
								<%if(sp.getSpecsMasterId()!=null){ %>
								<button id="editbtn" type="submit" class="btn btn-sm edit"  onclick="submitData()" name="action" value="update">UPDATE </button>
								<input type="hidden" name="SpecsMasterId" value="<%=sp.getSpecsMasterId()%>">
								<%}else{ %>
								<button id="submitbtn" type="submit" class="btn btn-sm submit" onclick="submitData()" name="action" value="add">SUBMIT </button>
								<%} %>
								<a class="btn btn-info btn-sm back" href="SpecificationMasters.htm">Back</a>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								</div>
								</div>
								</div>
								</form>	
								</div>
								
	<script>
	$('#Editor').summernote({
		width: 1000,
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
	function submitData(){
		console.log($('#Editor').summernote('code'))
		   $('textarea[name=description]').val($('#Editor').summernote('code'));
		   if(confirm('Are you sure to submit?')){
			   
		   }else{
			   event.preventDefault();
			   return false;
		   }
	}						
	</script>

</body>
</html>