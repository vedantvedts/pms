<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />

</head>
<body class="slides-container" id="slides-container">
<%
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
List<Object[]> freezedproject = (List<Object[]>)request.getAttribute("getAllProjectSlidedata"); 
String filepath = (String)request.getAttribute("filepath");
%>

<div id="presentation-slides" class="carousel slide " data-ride="carousel">
	<div class="carousel-inner" align="center">
		<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">
				
				<div class="content" align="center" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					
					<div class="firstpage"  > 

						<div align="center" ><h2 style="color: #145374 !important;font-family: 'Muli'!important">Presentation</h2></div>
						<div align="center" ><h3 style="color: #145374 !important">of</h3></div>
							
						<div align="center" >
							<h3 style="color: #4C9100 !important" >  Projects of <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %></h3>
				   		</div>
						
						<div align="center" ><h3 style="color: #4C9100 !important"></h3></div>
						
							<table class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
								<tr>			
									<th colspan="8" style="text-align: center; font-weight: 700;">
										<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
										<br>
									</th>
								</tr>
							</table>	
						
						<br><br><br><br><br>
						
						<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
						<% if(labInfo!=null){ %>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %></th>
						</tr>
						<%}%>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
						</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
						</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
						</tr>
						<tr> <th colspan="8" style="text-align: center;"><a href="downloadMaduguru.htm" target="blank"><i class="fa fa-download" style="color: green;" aria-hidden="true"></i></a> </th></tr>
						</table>			
						
						
					</div>
					
				</div>
				
			</div>
			<!-- ----------------------------------------  P-0  Div ----------------------------------------------------- -->
			
		<!-- ----------------------------------------  Freezed Project Slide ----------------------------------------------------- -->
		
		<%if(freezedproject!=null && freezedproject.size()>0){
			for(Object[] obj:freezedproject){%>
			<div class="carousel-item " style="height: 645px;">
				<div class="container-fluid">
				<div style="width:1180px;top:-6.5em;position:relative;">
					<iframe	width="1200" id="myiframeid" height="800" src="data:application/pdf;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filepath+obj[1].toString()+obj[2].toString())))%>"   > </iframe>
				</div>
				</div>
			</div>	
		<%}}%>	
		<!-- ----------------------------------------  Freezed Project Slide ----------------------------------------------------- -->
		
		<!-- ----------------------------------------  Thank you Div ----------------------------------------------------- -->

			<div class="carousel-item " >

				<div class="content" style=" border: 6px solid green;border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					
					
					<div style=" position: absolute ;top: 40%;left: 34%;">
						<h1 style="font-size: 5rem;">Thank You !</h1>
					</div>
					
				</div>

			</div>
</div>
		<!-- ----------------------------------------   Thank you Div ----------------------------------------------------- -->
		
			 <a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a> 
	
		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="0"  class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
			<% int i=0;if(freezedproject!=null && freezedproject.size()>0){
			for(Object[] obj:freezedproject){%>
			<li data-target="#presentation-slides" data-slide-to="<%=++i%>"  class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="<%=i%>. <%=obj[6]%>"><b><%=i%></b></li>
			<%}}%>
			<li data-target="#presentation-slides" data-slide-to="<%=i+1%>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="Thank You"><b>End</b></li>
			<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_full_screen" data-toggle="tooltip" data-placement="top" title="Full Screen Mode"><b><i class="fa fa-expand fa-lg" aria-hidden="true"></i></b></li>
			<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_reg_screen" data-toggle="tooltip" data-placement="top" title="Exit Full Screen Mode"><b><i class="fa fa-compress fa-lg" aria-hidden="true"></i></b></li>		
		</ol>
	
</div>	
<script type="text/javascript">
$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})
	
	  function onTryItClick() {
        var content = document.getElementById("iframecontent").innerHTML;
        var iframe = document.getElementById("myiframeid");

        var frameDoc = iframe.document;
        if (iframe.contentWindow)
            frameDoc = iframe.contentWindow.document;

        frameDoc.open();
        frameDoc.writeln(content);
        frameDoc.close();
    }
    
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


/* Get the documentElement (<html>) to display the page in fullscreen */
var elem = document.documentElement;

/* View in fullscreen */
function openFullscreen() {
  if (elem.requestFullscreen) {
    elem.requestFullscreen();
  } else if (elem.webkitRequestFullscreen) { /* Safari */
    elem.webkitRequestFullscreen();
  } else if (elem.msRequestFullscreen) { /* IE11 */
    elem.msRequestFullscreen();
  }
}

/* Close fullscreen */
function closeFullscreen() {
  if (document.exitFullscreen) {
    document.exitFullscreen();
  } else if (document.webkitExitFullscreen) { /* Safari */
    document.webkitExitFullscreen();
  } else if (document.msExitFullscreen) { /* IE11 */
    document.msExitFullscreen();
  }
}

</script>
</body>
</html>