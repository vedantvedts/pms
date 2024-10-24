<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CARS Presentation</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />

<style type="text/css">
td{
height:15px;
color: #00416A ;
}

span {
	font-size: 1.2rem !important;
	font-weight: bold !important;
}
tr.clickable:hover{
cursor:pointer;
background-color: rgba(247,236,208);
}


.card-title.col-md-10{
color: black;
}
.zoom {
  transition: transform .4s; 
}
.zoom:hover {
  transform: scale(1.5); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
  z-index: 99999928374 !important;
}
.modal-list{
	font-size: 14px;
	text-align: left;
	padding: 0px !important;
	margin-bottom: 5px;
}

.modal-list li{
	display: inline-block;
}

.modal-list li .modal-span{
	font-size: 1.5rem;
	padding: 0px 7px;
}

.modal-list li .modal-text{
	font-size: 1rem;
	vertical-align: text-bottom;
	font-family: Lato;
}
.zoom {
  transition: transform .4s; 
}
.zoom:hover {
  transform: scale(1.2); /* (130% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
  z-index: 99999928374 !important;
}
.zoom2 {
  transition: transform .4s; 
}
.zoom2:hover {
  transform: scale(1.7); /* (180% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
  z-index: 99999928374 !important;
}

/* --------------------------------- Slide Styles ----------------------------------------- */
.content-header {
	background-color: darkblue !important;
}

.slideNames {
	margin-top: 1rem;
	margin-right: 3rem;
	font-size: 3rem;
}

.refNoHeading {
	margin-top: 1.5rem;
	font-size: 1.5rem !important;
}
.firstpagefontfamily  {
	font-family: 'Muli' !important;
}

.data-table{
	width: 100%;
}
.data-table td{
	padding: 10px !important;
}
.data-table tbody{
	font-size: 1.2rem !important;
}
.data-table th{
	font-size: 1.5rem !important;
}
</style>

</head>
<body style="background-color: #e7f9ff !important;" class="slides-container" id="slides-container">
	<%
		LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
		String lablogo = (String)request.getAttribute("lablogo");
		List<Object[]> initiationList = (List<Object[]>)request.getAttribute("initiationList");
	%>
	<% String ses=(String)request.getParameter("result");
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
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>
	
	<div id="presentation-slides" class="carousel slide " data-ride="carousel">
		<div class="carousel-inner" align="center">
			<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">
					
				<div class="content" align="center" style="height:93vh !important;">
						
					<div class="firstpage"  > 
		
						<div class="mt-2" align="center"><h2 style="color: #145374 !important;">Presentation</h2></div>
						<div align="center" ><h2 style="color: #145374 !important;">of</h2></div>
								
						<div align="center" >
							<h2 style="color: #145374 !important;" >CARS Projects</h2>
				   		</div>
						
						<div align="center" ><h2 style=" color: #145374 !important;"></h2></div>
						
						<table style="margin-top:35px;" class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
							<tr>			
								<th colspan="8" style="text-align: center; font-weight: 700;">
									<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
									<br>
								</th>
							</tr>
						</table>	
						<br><br><br><br>

						<br><br><br><br><br>
						<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;font-weight: bold;"  >
							<% if(labInfo!=null){ %>
								<tr>
									<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: bolder;font-size: 22px"> <h2 style="color: #145374 !important;font-weight: bolder;"> <%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %> ( <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %> ) </h2> </th>
								</tr>
							<%}%>
							<tr>
								<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px">Government of India, Ministry of Defence</th>
							</tr>
							<tr>
								<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px">Defence Research & Development Organization</th>
							</tr>
							<tr>
								<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
							</tr>
						</table>
					</div>
						
				</div>
					
			</div>
			
			<!-- ----------------------------------------  P-0  Div End----------------------------------------------------- -->
			
			<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->
			<div class="carousel-item">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						
					</div>
					<div class="col-md-2" align="left" style="display: inherit;" >
						<b class="refNoHeading"></b>
					</div>
					<div class="col-md-7">
						<h3 class="slideNames">CARS List</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%="" %></b>
					</div>
					<div class="col-md-1">
					</div>
					
				</div>
				
				<div class="content" >
					<table class="table table-bordered table-hover table-condensed data-table">
		     	    	<thead style="background-color: #4B70F5; color: #ffff !important;">
		            		<tr>
		                    	<th style="width: 5%;">SN</th>
		                       	<th style="width: 15%;">CARS No</th> 
		                       	<th style="width: 20%;">Title</th>
		                       	<th style="width: 20%;">Funds From</th>
		                       	<th style="width: 20%;">Duration</th>
		                       	<th style="width: 20%;">Cost</th>
		                    </tr>
		              	</thead> 
			            <tbody>
			            	<%if(initiationList!=null && initiationList.size()>0) {
			            		int slno = 0;
			            		for(Object[] obj : initiationList) {
			            	%>
			            		<tr>
			            			
			            		</tr>
			            	<%} }%>
			            </tbody>
			    	</table> 
				</div>
			</div>
			
			<!-- ----------------------------------------  P-1  Div End----------------------------------------------------- -->
			
		</div>
		
		<a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a>

		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="0" class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
			<li data-target="#presentation-slides" data-slide-to="1" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="CARS List"><b>1</b></li>
			
			<li data-target="#presentation-slides" data-slide-to="2" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="End"><b>End</b></li>
			<li data-slide-to="1" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_full_screen" data-toggle="tooltip" data-placement="top" title="Full Screen Mode"><b><i class="fa fa-expand fa-lg" aria-hidden="true"></i></b></li>
			<li data-slide-to="1" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_reg_screen" data-toggle="tooltip" data-placement="top" title="Exit Full Screen Mode"><b><i class="fa fa-compress fa-lg" aria-hidden="true"></i></b></li>
			<li style="background-color:  white;width: 55px;margin-left: 20px;">
				<a target="_blank" href="CARSPresentationDownload.htm?" data-toggle="tooltip" title="Download CARS Presentation" >
					<i class="fa fa-download" style="color: green;font-size: 1.2rem;padding: 0.1rem;" aria-hidden="true"></i>
				</a>	
			</li>
		</ol>
		
	</div>		

	
<script type="text/javascript">

window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 4000);

$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
})

$('.content_reg_screen').hide();
$('.content_full_screen, .content_reg_screen').on('click', function(e){
	  
	  if (document.fullscreenElement) {
	    	document.exitFullscreen();
	  } else {
		  $('.slides-container').get(0).requestFullscreen();
	  }
	});

$('.content_full_screen').on('click', function(e){ contentFullScreen() });

$('.content_reg_screen').on('click', function(e){ contentRegScreen() });

function contentFullScreen()
{
	$('.content_full_screen').hide();
	$('.content_reg_screen').show();
	openFullscreen();
}

function contentRegScreen()
{
	$('.content_reg_screen').hide();
	$('.content_full_screen').show();
	closeFullscreen();
}

</script>	
</body>
</html>