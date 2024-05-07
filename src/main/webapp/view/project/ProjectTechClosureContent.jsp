<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<spring:url value="/resources/richtexteditor/richtexteditor.js" var="richtexteditorjs" />
<spring:url value="/resources/richtexteditor/richtexteditor.css" var="richtexteditorcss" />
<spring:url value="/resources/richtexteditor/plugins/all_plugins.js" var="allpluginsjs" />





<title>COMMITTEE SCHEDULE MINUTES</title>


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
  content: "Add Chapter";
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

String unit3=null;
unit3=(String)request.getAttribute("unit1");
if(unit3==null){
	  unit3="NO";
}
String unit21=null;
unit21=(String)request.getAttribute("unit2");
if(unit21==null){
	  unit21="NO";
}
 
String specname=(String)request.getAttribute("specname");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

String closureId=(String)request.getAttribute("closureId");
List<Object[]> ChapterList=(List<Object[]>)request.getAttribute("ChapterList");

%>



<% String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
 String errorMsg=(String)request.getParameter("errorMsg");
 
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%}if(errorMsg!=null){ %>
                    	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=errorMsg %>
                   </div></div>
           <%} %>         
                    
  
  	
<nav class="navbar navbar-light bg-light justify-content-between" id="main1" style="margin-top: -1%">
		<a class="navbar-brand">
			<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f">Technical Closure Content </span></b>
	   </a>
	
		<form class="form-inline" method="GET" action=""  name="myfrm" id="myfrm"> 
			<input type="hidden" name="closureId" value="<%=closureId%>" >
			<button  class="btn  btn-sm back" formaction="TechClosureList.htm" style=" font-size:12px;" >BACK</button>
		</form>
</nav> 	
  
  
  
  
<div class="container-fluid">          
 <div class="row"> 
   <div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
      <div class="card-body" id="scrollclass" style="height:500px;overflow-y:scroll " >
        <% int Sub0Count=1;
           if(ChapterList!=null && ChapterList.size()>0){
           for(Object[]obj:ChapterList) {
           if(obj[1].toString().equalsIgnoreCase("0")) {%>
          
             <div class="panel panel-info" style="margin-top: 10px;" id="">
		       <div class="panel-heading ">
		         <h4 class="panel-title">
                      <span class="ml-2" style="font-size:14px"><%=Sub0Count+" . "+obj[3] %> </span>  
                </h4>
         	       <div style="float: right !important; margin-top:-32px; ;" id="tablediv" >
		 		       <table style="text-align: right;" >
     				       <thead>
	             		      <tr>
	                 		    <th ><input type="hidden" id="subspan" value=""></th>
	             		      </tr>
	         		      </thead>
	         		
	         		<tbody>
	         		<tr>
         		      <td>
			         		<span id="">
 			         		     <a data-toggle="collapse" data-parent="#accordion" href="#collapse1<%=Sub0Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %>"></i></a>
 			         		 </span>
	                  </td>
	                  
	         		   <td>
	         		       <button class="btn bg-transparent"  type="button" id="btnEditor<%=obj[0].toString()%>" onclick="showEditor('<%=obj[3].toString()%>',<%=obj[0].toString()%>,0,<%=obj[2].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true" style="color:orange"></i></button>
	         		  </td> 
	         		</tr>
	         	</tbody>
	          </table>
	        </div>
	     </div>
	         
	        <div id="collapse1<%=Sub0Count%>" class="panel-collapse collapse in"> 
	        
	        <%
		  	int Sub1Count=1;
		  	for(Object[] obj1:ChapterList){
		  	if(obj1[1].toString().equalsIgnoreCase(obj[0].toString())){
	  	    %>
	        
	         	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
	                   <div class="panel-heading">
					        <h4 class="panel-title">
					        	
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %>" action="" method="post">
						 
									<span  style="font-size:14px" ><%=Sub0Count %>.<%=Sub1Count %></span>
									<span  style="font-size:14px" id="span_<%=obj1[0]%>"><%=obj1[3]%>  &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj1[0] %>')"></i> </span>	
						          	<input type="text" name="levelname" class="hiddeninput" id="input_<%=obj1[0]%>" value="<%=obj1[3] %>" style="display: none;" maxlength="255">
						          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj1[0]%>" formaction="" formmethod="post" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
						          	      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          	</form>
					       	  </h4>
					       	  
					       		<div style="float: right !important; margin-top:-20px; " > 
					       			<a data-toggle="collapse" data-parent="#accordion" href="#collapse55<%=Sub0Count %><%=Sub1Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %>"></i></a>
					       		</div>
					      </div>
					      
					   </div>
					</div>
					
					      <%Sub1Count++;}} %>
					      
					      <%------------------------Level-1 Chapter Add ---------------------------------------%>
					      
					      <div class="row">  
				             <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				                   <div class="panel panel-info">
								      <div class="panel-heading">
								        <h4 class="panel-title">
					        	
									           <form  id="myFormB<%=Sub0Count%>" action="SubChapterAdd.htm" method="post">
									 
													<input type="hidden" name="SectionId" value="<%=obj[2]%>">				
													<input type="hidden" name="ChapterParentId" value="<%=obj[0]%>">
													<input type="hidden" name="ClosureId" value="<%=closureId%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									          		<span style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %></span>
									          		
									          		<div style="margin-top:-20px; margin-left:55px;">
									          		     <input class="form-control" type="text" name="ChapterName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
									          		</div>
									          		
									          		<div style="margin-top:-22px; margin-left: 220px;">
									          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
									          		</div>
									          		
									          	</form>
					       
					                       </h4>
					                    </div>
					                </div>
								  </div>
					  			</div>
					  			
					<%------------------------Level-1 Chapter Add End ---------------------------------------%>
	  			
	  		</div>
		 </div>
	         
	       <%Sub0Count++;}}} %>
	    			
			<br>
			<%-------------------------  Add New Section Button ----------------------------------------------------%>
	    	    <button type="button"  class="btn btn-sm  ml-2 font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq" style="color:#31708f;"><i class="fa fa-arrow-right text-primary" aria-hidden="true"></i>&nbsp; </button>
          </div>
	    </div>
	 </div>

        <%-------------------  RichText Editor -------------------------------------%>
                  
	         	<div class="col-md-7">
	         	<form action="OtherRequirementDetailsAdd.htm" method="POST" id="myfrm">
	      		 <div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
	      			<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight:500;color: #31708f;display:none;"></h5><hr>
	      			<h5 class="heading ml-4 mt-3" id="editorHeading1" style="font-weight:500;color: #31708f;"><%if(ChapterList != null && ChapterList.size()>0){ %> <%=ChapterList.get(0)[3] %><%} %> </h5><hr>
					  <div class="card-body" style="margin-top: -8px" >
					    <div class="row">	
					        <div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
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
				    
					    			<input type="hidden" name="projectId" value="">
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					                   <span id="Editorspan">
					                      <button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=EditorValueSubmit()>SUBMIT</button>
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
			
			
			
			
<form action="ChapterAdd.htm" method="POST" id="myform">          	  	
 <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-jump" role="document">
    <div class="modal-content mt-5" style="margin-left:-10%;">
      <div class="modal-header p-1 pl-3" style="background: #C4DDFF">
        <h5 class="modal-title font-weight-bold" id="exampleModalLongTitle" style="color: #31708f">Choose Chapter</h5>
        <button type="button" class="close text-danger mr-1" data-dismiss="modal" aria-label="Close">
          <span class="font-weight-bolder" aria-hidden="true" style="opacity:1;">&times;</span>
        </button>
      </div>
        
     
       <div class="modal-body" style="justify-content: center;align-items:center;">
         <table class="table table-bordered table-hover table-striped table-condensed" style="border:1px solid black;">
            <thead> 
	           <tr style="border:1px solid black;background-color:#055C9D;">
	           
		            <td align="center" style="border:1px solid black;width:10%;color:#FFFF">Select</td>
		            <td align="center" style="border:1px solid black;width:80%;color:#FFFF">Chapter</td>
	          </tr>
	         
	       </thead>
         
         <tbody  id="modal_table_body" ></tbody>
         
       </table>
     
           <div align="center" id="chaptersubmit"></div>
     
   <br>
     
        <div style="text-align:center;">
               <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" id="AddNewSection" onclick="AddSection()">ADD NEW </button>
		</div>
		
		<div align="center" style="display: none" id="SubmitButton">
		
			  <input class="form-control" type="text" name="SectionName" placeholder="Enter New Chapter" >
			  <br>
			  <button type="button" class="btn btn-success" data-toggle="modal"  onclick="SectionSubmit()" >Submit </button>
			  <button type="button" class="btn btn-danger" data-toggle="modal"  onclick="CloseButton()" >Close </button>
		
		</div>
      </div>
   		
	    			<input type="hidden" name="projectId" value=""> 
	    			<input type="hidden" name="closureId" value="<%=closureId%>"> 
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        			
     
			    </div>
			</div>
	    </div>   	
   </form> 


<script type="text/javascript">

function AddSection(){
	
	$('#AddNewSection').hide();
	$('#SubmitButton').show();
}

function CloseButton(){
	
	$('#AddNewSection').show();
	$('#SubmitButton').hide();
	
}

// to show the existing sections list
$(document).ready(function() {
	
    
    $.ajax({
        type: 'GET',
        url: 'AddSection.htm', 
        dataType: 'json',
        data:{
        	closureId:<%=closureId%>,
        	ExistingSection:'Y',
        },
        success: function(existingData) {
            
            if (existingData.length > 0) {
                var htmlStr = '';
                
                for (var i = 0; i <existingData.length; i++) {
                    htmlStr += '<tr>';
                    htmlStr += '<td class="tabledata" style="text-align: center;" ><input type="checkbox" name="SectionId"  value="' + existingData[i][0] + '" ></td>';
                    htmlStr += '<td class="tabledata" style="text-align: left;" >' + existingData[i][2] + '</td>';
                    htmlStr += '</tr>';
                    htmlStr += '</tr>';
                }
                $('#chaptersubmit').html('<button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=ChapterAdd()>SUBMIT</button>');
                
                $('#modal_table_body').html(htmlStr);
                
            }
        },
       
    });
});


function SectionSubmit(){
	
	
	$.ajax({
		type:'GET',
		url:'AddSection.htm',
		datatype:'json',
		data:{
			closureId:<%=closureId%>,
			SectionName:$('input[name="SectionName"]').val(),
		},
		success:function(result){
			var result=JSON.parse(result);
			var htmlStr='';
			
			if(result.length>0){
				
			var lastResult = result[result.length - 1];
			
			htmlStr += '<tr>';
			htmlStr += '<td class="tabledata" style="text-align: center;" ><input type="checkbox" class="" name="SectionId" value='+lastResult[0]+' ></td>';
			htmlStr += '<td class="tabledata" style="text-align: left;" >'+ lastResult[2] + '</td>';
		    htmlStr += '</tr>';
		    
			$('#modal_table_body').append(htmlStr);
				
			$('input[name="SectionName"]').val('');
			
			}
		},
		
	 })
	 
}


function ChapterAdd(){
	
	if(confirm("Are you sure you want to submit?")){
		
		 $('#myForm').submit();
	    return true;
	}else{
	   event.preventDefault();
	   return false;
	  }
	}



function showSubpoint(a) { 
	 $('#subdiv'+a).css("display","block");
	 $('#inputDiv'+a).css("display","block");
	 $('#span'+a).html('<button class="btn btn-sm bg-transparent" id="btn'+a+'" onclick="hideSubpoint('+a+')"><i class="fa fa-minus" aria-hidden="true"></</button>');
	// to disabled the checkbox when subdivs are open
	 var checkboxes = document.getElementsByName('check-1');
	
	var subspan = $('#subspan'+a).val();
	
	 var Mainid=$('#Mainid'+a).val();
	 document.getElementById('subdiv'+a).innerHTML="";
<%-- 	 $.ajax({
		 type:'GET',
		 url:'', //
		 datatype:'json',
		 data:{
			 Mainid:Mainid,
			 projectId:'',
		 },
		 success:function(result){
			 var ajaxresult=JSON.parse(result);
			 
			  var x=document.getElementById('subdiv'+a).innerHTML
			  
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
	 }); --%>
}




$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".fa").addClass("fa-minus").removeClass("fa-plus");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".fa").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".fa").removeClass("fa-minus").addClass("fa-plus");
    });
});

$('#Clk').click();

<%String FormName=(String)request.getAttribute("FromName");
if(FormName!=null){
	String [] id=FormName.split("/");
	String IdName="Clk";
	for(int i=0;i<id.length;i++){
		IdName=IdName.concat(id[i]);
%>
      $('#<%=IdName%>').click();
<%}}%>






var editor1 = new RichTextEditor("#div_editor1");

function showEditor(a,b,c,d){
	
	 $('#editorHeading').show();
	 $('#editorHeading1').hide();
	 $('#editorHeading').html(a);
	 $('#Editor').html(a);
	var x="<input type='hidden' name='MainId' value='"+b+"'><input type='hidden' name='ReqName' value='"+a+"'><input type='hidden' name='ReqParentId' value='"+c+"'><input type='hidden' id='RequirementId' name='RequirementId' value='"+d+"'>"
	$('#EditorDetails').html(x);

	$.ajax({
		type:'GET',
		url:'',
		datatype:'json',
		data:{
			MainId:b,
			ReqParentId:c,
			RequirementId:d,
			projectId:'',
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
</body>
</html>



