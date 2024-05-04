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
		
		<input type="hidden" name="closureId" value="<%=closureId%>">
		<button  class="btn  btn-sm back" formaction="TechClosureList.htm" style=" font-size:12px;" >BACK</button>
					
	</form>
	
	
</nav> 	
  
  
  
  
  <div class="container-fluid">          
<div class="row"> 
<div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    <div class="card-body" id="scrollclass" style="height:500px;overflow-y:scroll " >
  
    <form action="#">
      <div class="panel panel-info" style="margin-top: 10px;" id="">
      	<div class="panel-heading ">
        <h4 class="panel-title">
        <span class="ml-2" style="font-size:14px"> </span>  
        </h4>
         	<div   style="float: right !important; margin-top:-32px; ;" id="tablediv" >
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
	         		<button class="btn btn-sm bg-transparent"  id="" onclick="showSubpoint()"><i class="fa fa-plus" aria-hidden="true"></</button>
	         		</span>
	         		</td><td>
	         		<!-- <input class="btn btn-success btn-sm ml-3" type="submit"  value="ADD" style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;margin-top: -10%;display:inline-block;"> -->
	         		<button class="btn bg-transparent buttuonEd"  type="button" id="btnEditor" onclick="showEditor('')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
	         		</td> 
	         		</tr>
	         		</tbody>
	         		</table>
	         		</div>
	         		</div>
	         		<div id="" style="display: none;">
	         		<!--  -->
	         		<!--  -->
	         		</div>
	         	    <div class="row" id="inputDiv" style="display: none;">  
   					<div class="col-md-11 mt-1"  align="left"  style="margin-left: 10px;">
					<div class="panel panel-info">
					<div class="panel-heading">
	    			<h4 class="panel-title">
	    			<input type="hidden" id="Mainid" name="Mainid" value="">
	    			<input type="hidden" id="ReqName" name="ReqName" value="">
	    			
	    			<input type="hidden" name="projectId" value="<">
	    			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	           		<input class="form-control inputx" id="inputx" name="subreqName" style="padding:0px; line-height: 0px;" maxlength="255 characters">
	           		<button class="btn btn-success btn-sm ml-3" type="submit"  onclick="subPointSubmit()"
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
	    			
			<br>
	    			<button type="button"  class="btn btn-sm  ml-2 font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq" style="color:#31708f;"><i class="fa fa-arrow-right text-primary" aria-hidden="true"></i>&nbsp; </button>
          </div>
	         		</div>
	         		</div>

	         	<div class="col-md-7">
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
				    
	    			<input type="hidden" name="projectId" value="">
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
			
			
			
			
<form action="AddSection.htm" method="POST">	         	  	
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
        
        <tr style="border:1px solid black;background-color:#055C9D;">
            <td align="center" style="border:1px solid black;width:10%;color:#FFFF">Select</td>
            
            <td align="center" style="border:1px solid black;width:80%;color:#FFFF">Chapter</td>
            
         </tr>
         
          <tr style="border:1px solid black;">
            <td align="center" style="border:1px solid black;"><!-- <input name="" type="checkbox" value=""> --></td>
            
            <td align="center" style="border:1px solid black;"></td>
            
         </tr>
         
     </table>
      
      <br>
     
        <div style="text-align:center;">
               <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" id="AddnewButton" onclick="AddNew()" >ADD NEW </button>
		</div>
		
		<div align="center" style="display: none" id="newchapter">
		
		 <input class="form-control" type="text" name="NewChapter" value="">
		 <br>
		 <button type="submit" class="btn btn-success" data-toggle="modal" id="AddnewButton" onclick="AddSection()" >Submit </button>
		  <button type="button" class="btn btn-danger" data-toggle="modal" id="CloseButton" onclick="Close()" >Close </button>
		
		</div>
	 </div>
   		
	    			<input type="hidden" name="projectId" value=""> 
	    				<input type="hidden" name="closureId" value="<%=closureId%>"> 
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        			<!-- <button type="submit" class="btn btn-sm btn-success submit" onclick="EditorValueSubmit()">SUBMIT</button> -->
     
    </div>
  </div>
</div>   	
  </form> 
			
  




<script type="text/javascript">

function AddNew(){
	
	$('#AddnewButton').hide();
	$('#newchapter').show();
	
}

function Close(){
	
	$('#AddnewButton').show();
	//$('#CloseButton').hide();
	$('#newchapter').hide();
	
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

$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".btn").addClass("btn-danger btn-sm").removeClass("btn-info btn-sm");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".btn").removeClass("btn-info btn-sm").addClass("btn-danger btn-sm");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".btn").removeClass("btn-danger btn-sm").addClass("btn-info btn-sm");
    });
});




function AddSection(){
	
	
	$.ajax({
		type:'GET',
		url:'AddSection.htm',
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
			
			editor1.setHTMLCode(ajaxresult[5]);
			}
	 })
}

</script>

	



<script>


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
    
    $(document).ready(function(){
        // Add minus icon for collapse element which is open by default
        $(".collapse.show").each(function(){
        	$(this).prev(".panel-heading").find(".btn").addClass("btn-danger btn-sm").removeClass("btn-info btn-sm");
        });
        
        // Toggle plus minus icon on show hide of collapse element
        $(".collapse").on('show.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".btn").removeClass("btn-info btn-sm").addClass("btn-danger btn-sm");
        }).on('hide.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".btn").removeClass("btn-danger btn-sm").addClass("btn-info btn-sm");
        });
    });
   
  
    



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



