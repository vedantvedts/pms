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

<title>COMMITTEE SCHEDULE MINUTES</title>

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
@keyframes blink {
    0% {
        opacity: 1;
    }
    50% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}

.blink {
    animation: blink 1.5s infinite;
}
 .spinner {
    position: fixed;
    top: 40%;
    left: 20%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
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
		
		<input type="hidden" name="" value="">
		<button  class="btn  btn-sm back" formaction="TechClosureList.htm" style=" font-size:12px;" >BACK</button>
					
	</form>
	
	
</nav> 	
  
  
  
 <div class="container-fluid" id="main2">          
<div class="row"> 
<div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    	<div class="card-body" style="margin-top: -8px" >
         <div class="panel panel-info" style="margin-top: 10px;" >
      	
      		<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">1. EXECUTIVE SUMMARY</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
  			
			
			<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">2. PROJECT PERFORMANCE</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
           		
           		<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">3. LESSONS LEARNT</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
           		
           		
           		<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">4. SUMMARY OF RECOMMENDATIONS</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
           		
           		
           		<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">5. TOT /PRODUCTION ORDER DETAILS</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
           		
           			<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">6. WAY FORWARD</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
           		
           			<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">7. APPENDICES</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div>
           		
           		<!-- 	<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">2. PROJECT PERFORMANCE</span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse" > <i class="fa fa-plus" style="color:orange" id="5Out" ></i></a></div>
           		</div> -->
           		
           		
           		<div id="collapse" class="panel-collapse in collapse "></div>
			
			
			
			
			
			</div>
			
			
			</div>
		 </div> 
	 </div>
   </div>
</div>





<script type="text/javascript">

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


</script>

<script type="text/javascript">




</script>




		<script type="text/javascript">
						
			   
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
   
  
    

    var regex = /\d+/g;
    var matches = unitt.match(regex);
    
	if(matches!=null){
		if("5"==matches){
			$("#OutCome5").click();	
		}else{
			
			$("#agendaclick").click();	
			unitt=unitt.slice(1);
			$("."+unitt).click();
			$("#"+unitt+'5').click();
		}
	}   
    
	
	function checklength(id){
		
		$('#'+id).on('change', function() { 
	        if($(this).is(':checked')) 
	        {
	        	var data =CKEDITOR.instances['summernote'].getData();
	        	if(data.length>1024){
	        		alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length + '.');
					$(this).prop("checked", false);
				}
	        	
	        }
	    });
	}
	

 
</script>
	

 <script type="text/javascript">
	 
	
	  $('#specadd').submit(function() {
		  
		  var data =CKEDITOR.instances['summernote'].getData();
		  $('textarea[name=NoteText]').val(data);

		  if($('#issue').is(':checked')) 
		    {
				var data =CKEDITOR.instances['summernote'].getData();
				if(data.length>1024){
					alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length+ '.');
					event.preventDefault();
				}
				
			}
			if($('#risk').is(':checked')) 
		    {
				var data =CKEDITOR.instances['summernote'].getData();
				if(data.length>1024){
					alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length+ '.');
					event.preventDefault();
				}
				
			}
			if($('#action').is(':checked')) 
		    {
				var data =CKEDITOR.instances['summernote'].getData();
				if(data.length>1024){
					alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length+ '.');
					event.preventDefault();
				}
				
			}
			

			    if ( $('input:radio', this).is(':checked')) {
			  
			    } else {
			        
			    	alert('Kindly select a action item !');
			        
			        return false;
			    }
			
		  
      });
	  
	  
	  function FormNameB(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#editingair').hide();
    		    $('#deletingair').hide();
    		    $('#addingair').show();
    		    $('#specadd').hide();
    		    $('#specair').show();
    		    $('#OutComeDiv').hide();
    		    $('#PresDiscHeader').hide();
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var formnameadd= $("input[name='formname']",this).val();
    		    var type=$("#OutComesId",this).val();
    		    var unit1idadd= $("input[name='unit1']",this).val();
    		 
    		    $("#minutesidair").val(minutesidadd);
    		    $("#specnameair").val(specnameadd);
    		    $("#agendasubidair").val(agendasubidadd);
    		    $("#scheduleagendaidair").val(scheduleagendaidadd);
    		    $("#formnameair").val(formnameadd);
    		    $("#unit1idair").val(unit1idadd);
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					formname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});

    						if(scheduleagendaidadd==0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = "" ;
        					}	
    						
							if(scheduleagendaidadd!=0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[4]; 
        					}
							
		
							if(agendasubidadd==0){
	    						
	    						document.getElementById('iditemsubspecair').innerHTML = "";
	        				}
    						if(agendasubidadd!=0){
    						
    						document.getElementById('iditemsubspecair').innerHTML = " / " + values[3]; 
        					}
    						
    						
    					document.getElementById('iditemspecair').innerHTML = values[1];

    					$("#remarksair").val('');
    					$("#OutComeAirHead").val(type);
    					$("#editorair").val('');
    					$("#OutComeAir").val('C');
    					document.getElementById('outcomeair').innerHTML = " / "+type;
     					

      	  		         	 
    				}
    			});
    		   
    		  });
    	  

    }  

	  function FormNameA(formId) {
	
		  
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#editingair').hide();
    		    $('#deletingair').hide();
    		    $('#addingair').show();
    		    $('#specadd').hide();
    		    $('#specair').show();
    		    $('#OutComeDiv').hide();
    		    $('#PresDiscHeader').hide();
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var formnameadd= $("input[name='formname']",this).val();
    		    var type=$("select[name='OutComesId']",this).val();
    		    var unit1idadd= $("input[name='unit1']",this).val();
    		 
    		    $("#minutesidair").val(minutesidadd);
    		    $("#specnameair").val(specnameadd);
    		    $("#agendasubidair").val(agendasubidadd);
    		    $("#scheduleagendaidair").val(scheduleagendaidadd);
    		    $("#formnameair").val(formnameadd);
    		    $("#unit1idair").val(unit1idadd);
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					formname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});

    						if(scheduleagendaidadd==0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = "" ;
        					}	
    						
							if(scheduleagendaidadd!=0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[4]; 
        					}
							
		
							if(agendasubidadd==0){
	    						
	    						document.getElementById('iditemsubspecair').innerHTML = "";
	        				}
    						if(agendasubidadd!=0){
    						
    						document.getElementById('iditemsubspecair').innerHTML = " / " + values[3]; 
        					}
    						
    						
    					document.getElementById('iditemspecair').innerHTML = values[1];

    					$("#remarksair").val('');
    					$("#OutComeAir").val(type);
    					$("#editorair").val('');
    					if(type=="D"){
    						document.getElementById('outcomeair').innerHTML = " / Decision";
     					}
     					else if(type=="A"){
     						document.getElementById('outcomeair').innerHTML = " / Action";
     	  		        }
     					else if(type=="R"){
     						document.getElementById('outcomeair').innerHTML = " / Recommendation";
     					}
     					else if(type=="C"){
     						document.getElementById('outcomeair').innerHTML = " / Comment";
     					}
     					else if(type=="I"){
     						document.getElementById('outcomeair').innerHTML = " / Issue";
     					}
     					else if(type=="K"){
     						document.getElementById('outcomeair').innerHTML = " / Risk";
     					}

      	  		         	 
    				}
    			});
    		   
    		  });
    	  

    }  

    function FormName(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#editing').hide();
    		    $('#adding').show();
    		    $('#specadd').show();
    		    $('#specair').hide();
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var unit1idadd= $("input[name='unit1id']",this).val();
    		    var formnameadd= $("input[name='formname']",this).val();
    		    
    		    $("#minutesidadd").val(minutesidadd);
    		    $("#specnameadd").val(specnameadd);
    		    $("#agendasubidadd").val(agendasubidadd);
    		    $("#scheduleagendaidadd").val(scheduleagendaidadd);
    		    $("#unit1idadd").val(unit1idadd);
    		    $("#formnameadd").val(formnameadd);
    		    
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					unit1:unit1idadd,
    					formname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});

    						if(scheduleagendaidadd==0){
    						document.getElementById('iditemsubspecofsub').innerHTML = "" ;
        					}	
    						
							if(scheduleagendaidadd!=0){
    						document.getElementById('iditemsubspecofsub').innerHTML = " / " + values[4]; 
        					}
							
		
							if(agendasubidadd==0){
	    						
	    						document.getElementById('iditemsubspec').innerHTML = "";
	        				}
    						if(agendasubidadd!=0){
    						
    						document.getElementById('iditemsubspec').innerHTML = " / " + values[3]; 
        					}
    						
    					document.getElementById('iditemspec').innerHTML = values[1];
    			
    					
    					CKEDITOR.instances['summernote'].setData();
    					$("#remarks").val('');
    					/* drcdiv */
    					
      						 $("#decision").prop("checked", false);
      	  			         $("#recommendation").prop("checked", false);
      	  		             $("#comments").prop("checked", true); 
      	  		         	 $("#drcdiv").hide();
      	  		        
      	  		         	 
      	  		         if(formId=="myForm34" || formId=="myForm35" || formId=="myForm36"){
      	  	  				CKEDITOR.instances['summernote'].setReadOnly(true);
      	   	  		        }else{
      	   	  		       CKEDITOR.instances['summernote'].setReadOnly(false);
      	   	  		        }    
				
    				}
    			});
    		   
    		  });
    	  

    }  
    
    
    function FormNameEditB(formId, AgendaSubHead) {
  	  $("#"+formId).submit(function(event){
  		    event.preventDefault();
  		  $('#addingair').hide();
  		 $('#editingair').show();
  		 $('#deletingair').show();
  		 $('#specadd').hide();
	       $('#specair').show();
	       $('#OutComeDiv').hide();
	       $('#PresDiscHeader').show();
	       
  		    var itemidadd = $("input[name='scheduleminutesid']",this).val();
  		 	var specnameadd= $("input[name='specname']",this).val();
  		 	var formnameadd= $("input[name='formname']",this).val();
  		 	var unit1idadd= $("input[name='unit1']",this).val();
		 	
  		 	
  		 	$("#specnameair").val(specnameadd);
  		 	$("#formnameair").val(formnameadd);
  		 	$("#unit1idair").val(unit1idadd);
  		 	
  		    $.ajax({
  				type : "GET",
  				url : "CommitteeMinutesSpecEdit.htm",
  				data : {
  					scheduleminutesid : itemidadd,
  					specname:specnameadd,
  					forname:formnameadd,
  					
  				},
  				datatype : 'json',
  				success : function(result) {
  					
  					var result = JSON.parse(result);
  					var values = Object.keys(result).map(function(e) {
  						  return result[e]
  						});
  					
  					$("#scheduleideditair").val(values[2]);	
   		  			$("#minutesideditair").val(values[0]);
   		  		    $("#scheduleminutesideditair").val(values[3]);
   		  		    
   		  			if(values[6]==0){
					document.getElementById('iditemsubspecofsubair').innerHTML = ""; 
					}	
					if(values[6]!=0){
					document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[8]; 
					}	
   		  		    
					if(values[5]==0){	
					document.getElementById('iditemsubspecair').innerHTML = "";
					}

					if(values[5]!=0){
					document.getElementById('iditemsubspecair').innerHTML = " / " + values[7]; 
					}

  					
  					document.getElementById('iditemspecair').innerHTML = values[4];
	
  					
  					$("#remarksair").val(values[9]);
  					$("#OutComeAir").val(values[10]);
  					$("#editorair").val(values[1]);
  					$("#PresDiscHeaderVal").val(AgendaSubHead);
  					document.getElementById('outcomeair').innerHTML = " / "+AgendaSubHead;
  	  			
  				}
  			});
  		    
  		  });
  	  

  } 
    
    function FormNameEditA(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		  $('#addingair').hide();
    		 $('#editingair').show();
    		 $('#deletingair').show();
    		 $('#specadd').hide();
  	         $('#specair').show();
  	       $('#OutComeDiv').show();
  	     $('#PresDiscHeader').hide();
    		    var itemidadd = $("input[name='scheduleminutesid']",this).val();
    		 	var specnameadd= $("input[name='specname']",this).val();
    		 	var formnameadd= $("input[name='formname']",this).val();
    		 	var unit1idadd= $("input[name='unit1']",this).val();
     		    $("#unit1idair").val(unit1idadd);
    		 	
    		 	$("#specnameair").val(specnameadd);
    		 	$("#formnameair").val(formnameadd);
    		 	$("#unit1idair").val(unit1idadd);
    		 	
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecEdit.htm",
    				data : {
    					scheduleminutesid : itemidadd,
    					specname:specnameadd,
    					forname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});
    					
    					$("#scheduleideditair").val(values[2]);	
     		  			$("#minutesideditair").val(values[0]);
     		  		    $("#scheduleminutesideditair").val(values[3]);
     		  		    
     		  			if(values[6]==0){
  					document.getElementById('iditemsubspecofsubair').innerHTML = ""; 
  					}	
  					if(values[6]!=0){
  					document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[8]; 
  					}	
     		  		    
  					if(values[5]==0){	
  					document.getElementById('iditemsubspecair').innerHTML = "";
  					}

  					if(values[5]!=0){
  					document.getElementById('iditemsubspecair').innerHTML = " / " + values[7]; 
  					}
  					

    					
    					document.getElementById('iditemspecair').innerHTML = values[4];
    					

    					
    					$("#remarksair").val(values[9]);
    					$("#OutComeAir").val(values[10]);
    					$("#editorair").val(values[1]);
    					
    					
    	  			    
    					if(values[10]=="D"){
    						document.getElementById('outcomeair').innerHTML = " / Decision";
     					}
     					else if(values[10]=="A"){
     						document.getElementById('outcomeair').innerHTML = " / Action";
     	  		        }
     					else if(values[10]=="R"){
     						document.getElementById('outcomeair').innerHTML = " / Recommendation";
     					}
     					else if(values[10]=="C"){
     						document.getElementById('outcomeair').innerHTML = " / Comment";
     					}
     					else if(values[10]=="I"){
     						document.getElementById('outcomeair').innerHTML = " / Issue";
     					}
     					else if(values[10]=="K"){
     						document.getElementById('outcomeair').innerHTML = " / Risk";
     					}
    	  			
    				}
    			});
    		    
    		  });
    	  

    } 
   
    function FormNameEdit(formId) {
  	  $("#"+formId).submit(function(event){
  		    event.preventDefault();
  		  $('#adding').hide();
  		 $('#editing').show();
  		$('#specadd').show();
	    $('#specair').hide();
  		    var itemidadd = $("input[name='scheduleminutesid']",this).val();
  		 	var specnameadd= $("input[name='specname']",this).val();
  		 	var formnameadd= $("input[name='formname']",this).val();
  		 	
  		 	
  		 	$("#specnameadd").val(specnameadd);
  		 	$("#formnameadd").val(formnameadd);
  		 	
  		    $.ajax({
  				type : "GET",
  				url : "CommitteeMinutesSpecEdit.htm",
  				data : {
  					scheduleminutesid : itemidadd,
  					specname:specnameadd,
  					forname:formnameadd,
  					
  				},
  				datatype : 'json',
  				success : function(result) {
  					
  					var result = JSON.parse(result);
  					var values = Object.keys(result).map(function(e) {
  						  return result[e]
  						});
  					
  					$("#scheduleidedit").val(values[2]);	
   		  			$("#minutesidedit").val(values[0]);
   		  		    $("#scheduleminutesidedit").val(values[3]);
   		  		    
   		  			if(values[6]==0){
					document.getElementById('iditemsubspecofsub').innerHTML = ""; 
					}	
					if(values[6]!=0){
					document.getElementById('iditemsubspecofsub').innerHTML = " / " + values[8]; 
					}	
   		  		    
					if(values[5]==0){	
					document.getElementById('iditemsubspec').innerHTML = "";
					}

					if(values[5]!=0){
					document.getElementById('iditemsubspec').innerHTML = " / " + values[7]; 
					}
					

  					
  					document.getElementById('iditemspec').innerHTML = values[4];
  					
  					CKEDITOR.instances['summernote'].setData(values[1]);
  					
  					$("#remarks").val(values[9]);
  					
  					if(values[10]=="D"){
 						 $("#decision").prop("checked", true);
 					}
 					else if(values[10]=="R"){
 						$("#recommendation").prop("checked", true);
 					}
 					else if(values[10]=="C"){
 						$("#comments").prop("checked",true);
 					}
  					$("#drcdiv").hide();
  	  			    
  	  			   if(formId=="myForm34" || formId=="myForm35" || formId=="myForm36"){
  	  				CKEDITOR.instances['summernote'].setReadOnly(true);
   	  		        }else{
   	  		       CKEDITOR.instances['summernote'].setReadOnly(false);
   	  		        }
  	  			
  				}
  			});
  		    
  		  });
  	  

  } 
 
   	
  
    </script>
   
   <script>
CKEDITOR.replace( 'summernote', {
	
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 380,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );

 
    
   

</script>


<script type='text/javascript'> 
function submitForm(formname)
{ 
  document.getElementById(formname).submit(); 
} 





function showModal(a){
	document.getElementById('filltext').innerHTML=a;
	$('#myModal').modal('show');
}

function sendEmail(a){
	  $('body').css("filter", "blur(1.0px)");
	 $('#spinner').show();
	 $('#main1').hide();
	 $('#main2').hide();
	var committeescheduleid= a;
	
 	$.ajax({
		type:'GET',
		url:'SendMinutes.htm',
		data:{
			committeescheduleid:committeescheduleid,
		},
		datatype:'json',
		
		success:function (result){
				
			console.log( result);

			if(result.length>0){
				 $('#main1').show();
				 $('#main2').show();
				 $('#spinner').hide();
				 $('body').css("filter", "none");
				 console.log("Email Sent");
				 alert("MoM sent to the Participating members")
			}
			
		}
	}) 
	
}


function sendEmails(a){
	  $('body').css("filter", "blur(1.0px)");
		 $('#spinner').show();
		 $('#main1').hide();
		 $('#main2').hide();
		var committeescheduleid= a;

		$.ajax({
			type:'GET',
			url:'SendNonProjectMinutes.htm',
			data:{
				committeescheduleid:committeescheduleid,
			},
			datatype:'json',
			
			success:function (result){
					
				console.log( typeof result);
				console.log(result)
				if(result.length>0){
					 $('#main1').show();
					 $('#main2').show();
					 $('#spinner').hide();
					 $('body').css("filter", "none");
					 console.log("Email Sent");
					 alert("MoM sent to the Participating members")
				}
				
			}
		}) 
}
</script>

</body>
</html>



