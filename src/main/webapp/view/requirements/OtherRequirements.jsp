<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/richtexteditor/richtexteditor.js" var="richtexteditorjs" />
<spring:url value="/resources/richtexteditor/richtexteditor.css" var="richtexteditorcss" />
<spring:url value="/resources/richtexteditor/plugins/all_plugins.js" var="allpluginsjs" />

<script src="${ckeditor}"></script>
<script src="${richtexteditorjs}"></script>
<script src="${allpluginsjs}"></script>
<link href="${contentCss}" rel="stylesheet" />
<link href="${richtexteditorcss}" rel="stylesheet" />
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
    width: 49px;
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
String projectId = (String)request.getAttribute("projectId");
List<Object[]>Otherrequirements=(List<Object[]>)request.getAttribute("Otherrequirements");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");

String MainId=(String)request.getAttribute("MainId");
%>
<nav class="navbar navbar-light bg-light justify-content-between"  style="margin-top: -1%">
		<a class="navbar-brand">
		<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f">Additional Requirements </span></b>
		</a>
		<form action="#">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="projectId" value="<%=projectId%>"> 
<!-- 		<button type="button" class="btn btn-sm btn-success font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq">Other Requirements</button> 
 -->		<button class="btn btn-info btn-sm  back ml-2 mt-1" formaction="Requirements.htm" formmethod="get" formnovalidate="formnovalidate" style="float:right;">BACK</button>
		</form>
</nav>
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
<%if(!RequirementList.isEmpty()){ %>
<div class="container-fluid">          
<div class="row"> 
<div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    <div class="card-body" id="scrollclass" <%if(RequirementList.size()>7) {%>style="height:500px;overflow-y:scroll "<%} %> >
    <%	int i=0;
    for(Object[]obj:RequirementList) {%>
    <form action="#">
      <div class="panel panel-info" style="margin-top: 10px;" id="<%="div"+obj[0].toString()%>">
      	<div class="panel-heading ">
        <h4 class="panel-title">
        <span class="ml-2" style="font-size:14px"> <%=++i+" . "+(obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - ")%></span>  
        </h4>
         	<div   style="float: right !important; margin-top:-32px; ;" id="tablediv<%=obj[0]%>" >
		 		<table style="text-align: right;" >
     				<thead>
	             		<tr>
	                 		<th ><input type="hidden" id="subspan<%=obj[0].toString() %>" value="<%=i%>"></th>
	             		</tr>
	         		</thead>
	         		
	         		<tbody>
	         		<tr>
         		<td>
	         		<span id="<%="span"+obj[0].toString() %>">
	         		<button class="btn btn-sm bg-transparent"  id="<%="btn"+obj[0].toString()%>" onclick="showSubpoint(<%=obj[0]%>)"><i class="fa fa-plus" aria-hidden="true"></</button>
	         		</span>
	         		</td><td>
	         		<!-- <input class="btn btn-success btn-sm ml-3" type="submit"  value="ADD" style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;margin-top: -10%;display:inline-block;"> -->
	         		<button class="btn bg-transparent buttuonEd<%=i %>"  type="button" id="btnEditor<%=obj[0].toString() %>" onclick="showEditor('<%=obj[1].toString() %>',<%=obj[0].toString()%>,0,<%=obj[2].toString()%>)"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
	         		</td> 
	         		</tr>
	         		</tbody>
	         		</table>
	         		</div>
	         		</div>
	         		<div id="<%="subdiv"+obj[0].toString()%>" style="display: none;">
	         		<!--  -->
	         		<!--  -->
	         		</div>
	         	    <div class="row" id="inputDiv<%=obj[0].toString()%>" style="display: none;">  
   					<div class="col-md-11 mt-1"  align="left"  style="margin-left: 10px;">
					<div class="panel panel-info">
					<div class="panel-heading">
	    			<h4 class="panel-title">
	    			<input type="hidden" id="Mainid<%=obj[0].toString() %>" name="Mainid" value="<%=obj[0].toString()%>">
	    			<input type="hidden" id="ReqName<%=obj[0].toString() %>" name="ReqName" value="<%=obj[1].toString() %>">
	    			
	    			<input type="hidden" name="projectId" value="<%=projectId%>">
	    			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	           		<input class="form-control inputx" id="inputx<%=obj[0].toString() %>" name="subreqName" style="padding:0px; line-height: 0px;" maxlength="255 characters">
	           		<button class="btn btn-success btn-sm ml-3" type="submit"  onclick="subPointSubmit(<%=obj[0].toString() %>)"
	           		formaction="ProjectOtherReqAdd.htm" formmethod="POST" formnovalidate="formnovalidate" 
	           		style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;display:inline-block;"
	           		>ADD</button>
	       		    </h4>
	        		</div>
	        		</div>
	        		</div>
	        		</div>
	         		</div>
	         		</form>
	    			<%}} %>
			<br>
	    			<button type="button"  class="btn btn-sm  ml-2 font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq" style="color:#31708f;"><i class="fa fa-arrow-right text-primary" aria-hidden="true"></i>&nbsp; </button>
</div>
	         		</div>
	         		</div>

	         	<div class="col-md-7" <%if(RequirementList.isEmpty()) {%>style="display:none;"<%} %>>
	         	<form action="OtherRequirementDetailsAdd.htm" method="POST" id="myfrm">
	      		 <div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
	      			<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight:500;color: #31708f;"></h5><hr>
					<div class="card-body" style="margin-top: -8px" >
					<div class="row">	
					<div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
					<!-- <div id="Editor" class="center"></div> -->
					<div id="div_editor1">
		
					</div>
					
					<textarea name="Details" style="display: none;"></textarea>
					<div class="mt-2" align="center" id="detailsSubmit">
					<span id="EditorDetails">
					<input type='hidden' name='MainId' value=>
					<input type='hidden' name='ReqName' value=>
					<input type='hidden' name='ReqParentId' value=>
					<input type='hidden' id='RequirementId' name='RequirementId' value=>
					</span>
				    
	    			<input type="hidden" name="projectId" value="<%=projectId%>">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					<span id="Editorspan">
					<button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=EditorValueSubmit()>SUBMIT</button></span>
					</div>
					</div>
					</div>
					</div>
	         		</div> 
         		</form>
	         	</div>

			</div>
			</div>



<form action="AddProjectOtherReq.htm" method="POST">	         	  	
  <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-jump" role="document">
    <div class="modal-content mt-5" style="width:120%; margin-left:-10%;">
      <div class="modal-header p-1 pl-3" style="background: #C4DDFF">
        <h5 class="modal-title font-weight-bold" id="exampleModalLongTitle" style="color: #31708f">Choose Additional Requirements</h5>
        <button type="button" class="close text-danger mr-1" data-dismiss="modal" aria-label="Close">
          <span class="font-weight-bolder" aria-hidden="true" style="opacity:1;">&times;</span>
        </button>
      </div>
         <hr class="mt-2">
      <%if(!Otherrequirements.isEmpty()){ %>
       <div class="modal-body" style="display:flex;justify-content: center;align-items:center;"><div>
    <%for(Object[]obj:Otherrequirements){ %>
       <input name="ReqValue" type="checkbox" value="<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%> <%="/"+(obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - ")%>">
       <input name="ReqNames" type="hidden" value="<%=obj[1].toString()%>">
       <span class="ml-1 mt-2 text-primary" style="font-weight: 600"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span><br>
       <%}%>
       
       <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
  		ADD NEW
		</button>
       </div>
    	</div>
   		<%}else{ %>
        <div class="modal-body" style="display:flex;justify-content: center;align-items:center;">
       <span class="text-primary">No system requirements to Add</span>
         </div>
       <%} %>
      <hr class="mb-2">
      <div class="p-2" align="center">
      		
	    			<input type="hidden" name="projectId" value="<%=projectId%>"> 
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        		<%if(!Otherrequirements.isEmpty()){ %>	<button type="submit" class="btn btn-sm btn-success submit" onclick="EditorValueSubmit()">SUBMIT</button><%} %>
      </div>
    </div>
  </div>
</div>   	
  </form> 


</body>
<script type="text/javascript">

function showSubpoint(a) { 
	 $('#subdiv'+a).css("display","block");
	 $('#inputDiv'+a).css("display","block");
	 $('#span'+a).html('<button class="btn btn-sm bg-transparent" id="btn'+a+'" onclick="hideSubpoint('+a+')"><i class="fa fa-minus" aria-hidden="true"></</button>');
	// to disabled the checkbox when subdivs are open
	 var checkboxes = document.getElementsByName('check-1');
	
	var subspan = $('#subspan'+a).val();
	
	 var Mainid=$('#Mainid'+a).val();
	 document.getElementById('subdiv'+a).innerHTML="";
	 $.ajax({
		 type:'GET',
		 url:'OtherSubRequirements.htm', //
		 datatype:'json',
		 data:{
			 Mainid:Mainid,
			 projectId:<%=projectId%>,
		 },
		 success:function(result){
			 var ajaxresult=JSON.parse(result);
			 console.log("ajaxresult"+ajaxresult.length)
			  var x=document.getElementById('subdiv'+a).innerHTML
			  console.log(x)
			 var html="";
			 for(var i=1;i<ajaxresult.length;i++){
			 //onclick to get edit button
			  var spanHidden='<span id="subSpan'+ajaxresult[i][0]+'" style="display:none;"><button class="btn btn-sm btn-info spansub" type="submit" formaction="ProjectOtherReqNameEdit.htm" formmethod="POST" formnovalidate="formnovalidate" onclick="reqNameUpdate('+ajaxresult[i][0]+')">Update</button><button class="btn bg-transparent" type="button" onclick="hideUpdateSpan('+ajaxresult[i][0]+')"><i class="fa fa-times" aria-hidden="true"></i></button></span>';
			  var inputHidden="<input type='hidden' name='Mainid' value='"+ajaxresult[i][2]+"'><input type='hidden' name='projectId' value='"+<%=projectId%>+"'><input type='hidden' name='RequirementId' value='"+ajaxresult[i][0]+"'><input type='hidden' name='${_csrf.parameterName}'	value='${_csrf.token}' />"
			  var inputHeading="<input type='text' class='form-control' readonly value='"+ajaxresult[i][4]+"' name='RequirementName' id='inputSub"+ajaxresult[i][0]+"'style='width:50%;display:inline; padding:0px;' maxlength='255 charecters'>"
			 html=html+'<div class="row"><div class="col-md-11 mt-1"  align="left"  style="margin-left: 10px;"><div class="panel panel-info"><div class="panel-heading"><form action="#"><h4 class="panel-title">'+subspan+"."+''+(i+".")+'&nbsp;'+inputHeading+''+inputHidden+'<button class="btn btn-sm bg-transparent" type="button" onclick="EditSubRequirement('+ajaxresult[i][0]+')" id="subbtn'+ajaxresult[i][0]+'"><i class="fa fa-pencil" aria-hidden="true"></i></button>'+spanHidden+'<button class="btn bg-transparent" onclick="showEditor('+"'"+''+ajaxresult[i][4]+''+"'"+','+ajaxresult[i][2]+','+ajaxresult[i][3]+','+ajaxresult[i][0]+')"style="float:right" type="button" "><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></h4></form></div></div></div> </div>'; 
			 }
			 html=html+x;
			 $('#subdiv'+a).html(html);
		 }
	 });
}

function hideSubpoint(a) { 
	 $('#subdiv'+a).css("display","none");
	 $('#inputDiv'+a).css("display","none");
	 $('#span'+a).html('<button class="btn btn-sm bg-transparent" id="btn'+a+'" onclick="showSubpoint('+a+')"><i class="fa fa-plus" aria-hidden="true"></</button>');
	// to enabled the checkbox when subdivs are open
	 	 var checkboxes = document.getElementsByName('check-1');
/* 		 for(var i=0;i<checkboxes.length;i++){
		 if(Number(i+1)===Number(a)){
			  checkboxes[i].disabled = false;
		 }
	 	}  */
	}
	
var inputValues; // declared as var so get the value before updated
function EditSubRequirement(a){
  inputValues= document.getElementById("inputSub"+a).value;
  document.getElementById("inputSub"+a).readOnly = false;
  $('#subbtn'+a).css("display","none");
  $('#subSpan'+a).css("display","inline-block");
}
function hideUpdateSpan(a){
	  document.getElementById("inputSub"+a).readOnly = true;
	  document.getElementById("inputSub"+a).value=inputValues;
	  $('#subSpan'+a).hide();
	  $('#subbtn'+a).css("display","inline-block");
}

function subPointSubmit(a) { 
	var inputx=$('#inputx'+a).val().trim();
	if(confirm("Are you sure you want to submit?")){
		if(inputx.length==0){
			alert("This field is empty")
			event.preventDefault();
			return false;
		}else{
			return true;
		}
	}else{
		event.preventDefault();
		return false;
	}
}

function reqNameUpdate(a){
	var inputSub=$('#inputSub'+a).val().trim();
		if(inputSub.length==0){
			alert("This field is empty")
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

<%if(MainId!=null){%> 
$( document ).ready(function() {
	 var Mainid=<%=MainId%>;
	 if(Number(Mainid)!=0){
	 showSubpoint(Mainid);
	 }
	 
	 if(Mainid===0){
			$('#buttuonEd1').click()
			}else{
			 $('#btnEditor'+Mainid).click(); 
			}
	 
	});
<%}%>

var editor1 = new RichTextEditor("#div_editor1");

function showEditor(a,b,c,d){
	 $('#editorHeading').html(a);
	 $('#Editor').html(a);
	var x="<input type='hidden' name='MainId' value='"+b+"'><input type='hidden' name='ReqName' value='"+a+"'><input type='hidden' name='ReqParentId' value='"+c+"'><input type='hidden' id='RequirementId' name='RequirementId' value='"+d+"'>"
	$('#EditorDetails').html(x);

	$.ajax({
		type:'GET',
		url:'OtherRequirementsData.htm',
		datatype:'json',
		data:{
			MainId:b,
			ReqParentId:c,
			RequirementId:d,
			projectId:<%=projectId%>,
		},
		success:function(result){
		var ajaxresult=JSON.parse(result);
		console.log(ajaxresult);
		if(ajaxresult[5]==null){
		console.log(ajaxresult[5])
		ajaxresult[5]=""
		$('#Editorspan').html('<button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=EditorValueSubmit()>SUBMIT</button>');
		}else{
		$('#Editorspan').html('<button type="submit" class="btn btn-sm btn-warning mt-2 edit" onclick=EditorValueSubmit()>UPDATE</button>');
		}
		editor1.setHTMLCode(ajaxresult[5]);
		}
	})
	}
$('#myfrm').submit(function() {
	 var data =editor1.getHTMLCode();
	 $('textarea[name=Details]').val(data);
	 });
	 
function EditorValueSubmit(){
	if(confirm("Are you sure you want to submit?")){
	return true;
	}else{
	event.preventDefault();
	return false;
	}
	}
	
	
</script>
</html>