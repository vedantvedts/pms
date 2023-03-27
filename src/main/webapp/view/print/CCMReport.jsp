<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CCM Report</title>

<style type="text/css">
#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
}  
@page {             
      size: 1120px 790px; 
      margin-top: 49px;
      margin-left: 72px;
      margin-right: 39px;
      margin-buttom: 49px; 	
      border: 1px solid black;
      
      @bottom-left {          		
	      content : "The information in this Document is proprietary of DRDO , MOD Government of India. Unauthorized possession/use is violating the Government procedure which may be liable for prosecution. ";
	      margin-bottom: 30px;
	      margin-right: 5px;
	      font-size: 10px;
      }
      @bottom-right {          		
	      content: "Page " counter(page) " of " counter(pages);
	      margin-bottom: 30px;
	      margin-right: 10px;
      }
          
          
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 div
 {
  	width: 1000px !important;
  	margin: 0px !important;
 }
 
table
{
	width: 990px !important;
 	margin-left: 10px;
}
.center{
 	
 	text-align: center;
 }
 
.bordered-table
{
	border-collapse:  collapse; 
}
.bordered-table th, .bordered-table td
{
	border: 1px solid black;
}

p{
  text-align: justify;
  text-justify: inter-word;
}

th
{
	border: 0px;
 	text-align: center;
 	padding: 5px;
	overflow-wrap: break-word;
	word-break :normal;
}
 
 td
 {
 	border: 0px;
 	text-align: left;
 	padding: 5px;
 	overflow-wrap: break-word;
 	word-break :normal;
 }

.break
{
	page-break-after: always;
	margin: 25px 0px 25px 0px;
}

.heading
{
	width: 987px !important;
    font-size: 30px;
    font-weight: bold;
    margin: 0px 0px 10px 0px !important;
    color: #000000;
    padding: 10px;
    background-color: #A6BDFF;
    /* border-radius: 10px; */
}
</style>


</head>
<body>
	<%
		String DRDOLogo=(String)request.getAttribute("DRDOLogo");
	%>
	<div align="center" >
		
 <!-- ---------------------------------------- Page -1 --------------------------------------- -->
			<div align="center" id="page1"> 
				<br><br><br><br><br>
				<div><h1 style="color: #145374 !important;font-family: 'Muli'!important">CCM Report </h1></div>
				
					<div><h2 style="color: #145374 !important" >Cluster Council Meeting </h2></div>
					<div><h2 style="color: #145374 !important" >Electronics and Communication Systems (ECS)</h2></div>
					<br><br><br><br><br>
					<table style="margin-left: 0px !important;">
						<tr>			
							<th>
								<img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(DRDOLogo!=null ){ %> src="data:image/*;base64,<%=DRDOLogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
							</th>
						</tr>
					</table>
					<br><br><br>
					<table>
					<tr>
						<th>Defence Research & Development Organization</th>
					</tr>
					<tr>
						<th>Government of India, Ministry of Defence</th>
					</tr>
				</table>			
				
			</div>
 <!-- ---------------------------------------- Page -1 --------------------------------------- -->
 <!-- ---------------------------------------- Page -2 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page2">
						<div class="heading">Agenda</div>
						
						<!-- <section style="font-weight: 600;margin:0px 0px 15px 0px;color: blackS; ">_________________________________________________________________________________________________________________________</section> -->
						
						<table class="bordered-table">
							<thead>
								<tr>
									<th style="width:5%">SN</th>
									<th style="width:80%">AGENDA</th>
									<th style="width:15%">Time</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">1</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">2</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">3</td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
				</div>
<!-- ---------------------------------------- Page -2 --------------------------------------- -->

<!-- ---------------------------------------- Page -3 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page3">
						<div class="heading">Action Taken Report of CCM</div>
						
						<!-- <section style="font-weight: 600;margin:0px 0px 15px 0px;color: blackS; ">_________________________________________________________________________________________________________________________</section> -->
						
						<table class="bordered-table">
							<thead>
								<tr>
									<th style="width:5%">SN</th>
									<th style="width:50%">Action Point</th>
									<th style="width:45%">Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">1</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">2</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">3</td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
				</div>
<!-- ---------------------------------------- Page -3 --------------------------------------- -->
<!-- ---------------------------------------- Page -4 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page4">
						<div class="heading">DMC July 2022</div>
						
						<!-- <section style="font-weight: 600;margin:0px 0px 15px 0px;color: blackS; ">_________________________________________________________________________________________________________________________</section> -->
						
						<table class="bordered-table">
							<thead>
								<tr>
									<th style="width:5%">SN</th>
									<th style="width:10%">DMC Date</th>
									<th style="width:70%">DMC Decision</th>
									<th style="width:15%">Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">1</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">2</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">3</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
				</div>
<!-- ---------------------------------------- Page -4 --------------------------------------- -->	
<!-- ---------------------------------------- Page -5 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page5">
						<div class="heading">EB Calendar</div>
						
						<!-- <section style="font-weight: 600;margin:0px 0px 15px 0px;color: blackS; ">_________________________________________________________________________________________________________________________</section> -->
						
						<table class="bordered-table">
							<thead>
								<tr>
									<th style="width:10%">Labs</th>
									<th style="width:30%">EB Proposed</th>
									<th style="width:30%">EB Held</th>
									<th style="width:30%">EB Proposed</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">CASDIC</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">CHESS</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">LRDE</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
				</div>
<!-- ---------------------------------------- Page -5 --------------------------------------- -->

<!-- ---------------------------------------- Page -6 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page6">
						<div class="heading">PMRC Calendar</div>
						
						<!-- <section style="font-weight: 600;margin:0px 0px 15px 0px;color: blackS; ">_________________________________________________________________________________________________________________________</section> -->
						
						<table class="bordered-table">
							<thead>
								<tr>
									<th style="width:10%">Labs</th>
									<th style="width:30%">PMRC Proposed</th>
									<th style="width:30%">PMRC Held</th>
									<th style="width:30%">PMRC Proposed</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">CASDIC</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">CHESS</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="center">LRDE</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
				</div>
<!-- ---------------------------------------- Page -6 --------------------------------------- -->
<!-- ---------------------------------------- Page -7 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page7">
						<div class="heading">Achievements</div>
						
						<!-- <section style="font-weight: 600;margin:0px 0px 15px 0px;color: blackS; ">_________________________________________________________________________________________________________________________</section> -->
						
						<table class="bordered-table">
							<thead>
								<tr>
									<th style="width:10%">Labs</th>
									<th style="width:90%">Achievement</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">CASDIC</td>
									<td>
											<ul>
												<li></li>
												<li></li>
											</ul>
									</td>
								</tr>
								<tr>
									<td class="center">CHESS</td>
									<td>
											<ul>
												<li></li>
												<li></li>
											</ul>
									</td>
								</tr>
								<tr>
									<td class="center">LRDE</td>
									<td>
											<ul>
												<li></li>
												<li></li>
											</ul>
									</td>
								</tr>
							</tbody>
						</table>
				</div>
<!-- ---------------------------------------- Page -7 --------------------------------------- -->

<!-- ---------------------------------------- Page -8 --------------------------------------- -->
				<h1 class="break"></h1>
				<div id="page2">
					<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
					<div align="center" style="text-align: center; vertical-align: middle ;font-size:60px;font-weight: 600;margin: auto; position: relative;" >THANK YOU</div>
	
				</div>
<!-- ---------------------------------------- Page -8 --------------------------------------- -->
			
		
	</div><!-- main div -->
	
	
</body>
</html>