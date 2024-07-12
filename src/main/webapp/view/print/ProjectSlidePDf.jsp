<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">


<title>Project Slides</title>
<style type="text/css">


 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
		@page{             
          size: 1120px 790px;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
          border: 2px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
          @top-right {
         
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
   		   
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
          <%--   content: "<%=Labcode%>"; --%>
          }  
          @top-center { 
          font-size: 13px;
          margin-top: 30px;
          
          }  
          @bottom-center { 
          font-size: 13px;
           margin-bottom: 30px;
         
          }
          @bottom-left { 
           font-size: 13px;
	        margin-bottom: 30px;

          }   
 }



 .border-black{
	 border:1px solid black !important;
	 border-collapse: collapse !important;
	 padding:2px;
 }
span {
	font-size: 1.2rem !important;
	font-weight: bold !important;
}

</style>

</head>
<body style="background-color: rgb(249, 242, 223);">
<%
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String lablogo = (String)request.getAttribute("lablogo");
String Drdologo = (String)request.getAttribute("Drdologo");
String filePath = (String)request.getAttribute("filepath");
List<Object[]> freezedproject = (List<Object[]>)request.getAttribute("getAllProjectSlidedata");
//List<Object[]> FreezedSlide = (List<Object[]>)request.getAttribute("getAllProjectSlidesdata"); //status ,  slide , ImageName , path ,SlideId ,attachmentname, brief
List<Object[]> projects = (List<Object[]>)request.getAttribute("getAllProjectdata");
String[] a = new String[projects.size()];
for(int i=0;i<projects.size();i++)
{a[i]=projects.get(i)[0].toString();}
String filepath = (String)request.getAttribute("filepath");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
String reviewedby = "";
String reviewDate = "";
FormatConverter fc = new FormatConverter();
List<Object[]> mainProjectList =  projects!=null && projects.size()>0 ? (projects.stream().filter(e-> e[21]!=null && e[21].toString().equals("1")).collect(Collectors.toList())): new ArrayList<Object[]>();
List<Object[]> subProjectList =  projects!=null && projects.size()>0 ? (projects.stream().filter(e-> e[21]!=null && e[21].toString().equals("0")).collect(Collectors.toList())): new ArrayList<Object[]>();
projects.clear();
projects.addAll(mainProjectList);
projects.addAll(subProjectList);

int pageCOunt=1;
%>


		<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
		<div style="background-color: rgb(249, 242, 223);">
				
			<div class="content" align="center" style="   border-radius: 5px !important;height:93vh !important;padding-top: 15px;">
					
				<div class="firstpage"  > 
	
					<div class="mt-2" align="center"><h2 style="color: #145374 !important;">Presentation</h2></div>
					<div align="center" ><h2 style="color: #145374 !important;">of</h2></div>
							
					<div align="center" >
						<h2 style="color: #145374 !important;" >  <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=labInfo.getLabCode()%><%} %> Projects</h2>
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
				
					<% Boolean flag=false;
						for(int i=0;i<freezedproject.size();i++)
						{
							for(int j=0;j<projects.size();j++)
							{
								if(freezedproject.get(i)[3].toString().equals(projects.get(j)[0].toString())){
									reviewedby=freezedproject.get(i)[4].toString();
									reviewDate=sdf.format(freezedproject.get(i)[5]).toString();
									flag=true;
									break;
								}
								if(flag)break;
							}
							
						}
					%>
					<h4 style="color: #145374 !important;text-align: center;"><%if( reviewedby!="" ) {%> Review By - <%=reviewedby %>  <%} %></h4>
					<h4 style="color: #145374 !important;text-align: center;"><%if( reviewDate!="" ) {%> Review Date - <%=reviewDate %> <%} %></h4>
				
					<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;font-weight: bold; background-color: rgb(249, 242, 223);"  >
						<% if(labInfo!=null){ %>
							<tr>
								<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size: 22px"> <h2 style="color: #145374 !important;"> <%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %> </h2> </th>
							</tr>
						<%}%>
						<tr>
							<th colspan="8" style="color: #145374 !important;text-align: center; font-weight: 700;font-size:20px"><br>Government of India, Ministry of Defence</th>
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
					<p style=" page-break-before: always;"></p>	
		<!-- ----------------------------------------  P-0  Div ----------------------------------------------------- -->

	
			
				<div align="center"><h2 style="color: #145374 !important;font-family: 'Muli'!important">Project Outline</h2></div>
				<div class="card-body shadow-nohover" >
					<div class="">
						<div class="">
						
			        	<% for(int i=0;i<mainProjectList.size();i++){ %><%} %>
			        	<% for(int i=0;i<subProjectList.size();i++){ %><%} %>
			        	<!-- ----------------------------------Main projects List -------------------------- -->	
			        	<% int val=0;
			        	if(mainProjectList.size()>0){ %>
			        	<div style="margin-left:10px"><h4 style="text-align: left;magin-left:50px;">Main Project</h4></div>
							<table class="border-black" style="width: 100%;margin-left:10px; margin-right:10px; font-size: 14px;">
								<thead class="border-black" style="background-color: rgb(249, 242, 223); color: black;">
									<tr >
										<th class="border-black" style="background-color: bisque;">SN</th>
										<th class="border-black" style="background-color: bisque;">Code</th>
										<th class="border-black" style="background-color: bisque;">Project Name</th>
										<th class="border-black" style="background-color: bisque;">Category</th> 
										<th class="border-black" style="background-color: bisque;">DOS</th>
										<th class="border-black" style="background-color: bisque;">PDC</th>
										<th class="border-black" style="background-color: bisque;">Sanction Cost<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Expenditure<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Out Commitment<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Dipl<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Balance<br>(In Cr, &#8377)</th>
									</tr>
								</thead>
								<tbody>
									<% if(mainProjectList!=null && mainProjectList.size()>0) {
										
										for(int i=0;i<mainProjectList.size();i++ ){val=i; %>
										<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=(++pageCOunt)%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;">
											<td class="border-black" style="text-align: center;font-weight: bold;"><%=1+i %> </td>
											<td class="border-black" style="text-align: center;font-weight: bold;">
												<%=mainProjectList.get(i)[12]!=null?mainProjectList.get(i)[12]:"-" %>
											</td>
											<td class="border-black" style="font-weight: bold;"  >
														<div >
															<%if (mainProjectList.get(i) != null )
																if(mainProjectList.get(i)[1] != null) { %><%=mainProjectList.get(i)[1]%> - <%=mainProjectList.get(i)[13]!=null?mainProjectList.get(i)[13]:"-"%> 
															<%}%>
														</div>
											</td>
											
											<td class="border-black" style="font-weight: bold;text-align: center;">
												<%if(mainProjectList.get(i)[32]!=null){%><%=mainProjectList.get(i)[32] %><%}else {%>-<%} %>
											</td>
											
											
											<td class="border-black" style="font-weight: bold;text-align: center;">
												<%if (mainProjectList.get(i) != null )
													
													if(mainProjectList.get(i)[5]!= null) {	%>
													<%=fc.SqlToRegularDate(mainProjectList.get(i)[5].toString())%>
												<%}%>
											</td>
											<td class="border-black" style="font-weight: bold;text-align: center;<%
													DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
											LocalDate regularDate = LocalDate.parse(fc.SqlToRegularDate(mainProjectList.get(i)[4].toString()), formatter);
													if (mainProjectList.get(i) != null )
														if(mainProjectList.get(i)[4]!= null)
											if(regularDate.isBefore(LocalDate.now())){%>  color: red;  <%}%> ">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[4]!= null) {
													 formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
														 regularDate = LocalDate.parse(fc.SqlToRegularDate(mainProjectList.get(i)[4].toString()), formatter);
														%>
													<%=fc.SqlToRegularDate(mainProjectList.get(i)[4].toString())%>
												<%}%>
											</td>
											<td class="border-black" style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[3]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[3].toString())/10000000)%>
												<%}%>
											</td>
											<td class="border-black" style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[16]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[16].toString())/10000000)%>
												<%}%>
											</td>
											<td class="border-black" style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[17]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[17].toString())/10000000)%>
												<%}%>
											</td>
											<td class="border-black" style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[18]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[18].toString())/10000000)%>
												<%}%>
											</td>
											<td class="border-black" style="font-weight: bold;text-align: right;">
												<%if (mainProjectList.get(i) != null )
													if(mainProjectList.get(i)[19]!= null) { %>
													<%=String.format("%.2f", Double.parseDouble(mainProjectList.get(i)[19].toString())/10000000)%>
												<%}%>
											</td>
										</tr>
									<%} }%>
								</tbody>
					
							</table>
						<%} %>
									<!-- ----------------------------------sub projects List -------------------------- -->		
									<br>
									<%if(subProjectList.size()>0){ %>
			        	<div style="margin-left:10px"><h4 style="text-align: left;magin-left:50px;">Sub Project</h4></div>
								<table class="border-black" style="width: 100%;margin-left:10px; margin-right:10px; font-size: 14px;">
								<thead class="border-black" style="background-color: rgb(249, 242, 223); color: black;">
									<tr >
										<th class="border-black" style="background-color: bisque;">SN</th>
										<th class="border-black" style="background-color: bisque;">Code</th>
										<th class="border-black" style="background-color: bisque;">Project Name</th>
										<th class="border-black" style="background-color: bisque;">Category</th> 
										<th class="border-black" style="background-color: bisque;">DOS</th>
										<th class="border-black" style="background-color: bisque;">PDC</th>
										<th class="border-black" style="background-color: bisque;">Sanction Cost<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Expenditure<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Out Commitment<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Dipl<br>(In Cr, &#8377)</th>
										<th class="border-black" style="background-color: bisque;">Balance<br>(In Cr, &#8377)</th>
									</tr>
								</thead>
									<tbody>
									
										<% if(subProjectList!=null && subProjectList.size()>0) {
											if(val>0)val++;
											for(int i=0;i<subProjectList.size();i++ ){ %>	
											<tr class="clickable " data-target="#presentation-slides" data-slide-to="<%=(++pageCOunt)%>" data-toggle="tooltip" data-placement="top" title="" style="cursor: pointer;">
												<td class="border-black" style="text-align: center;font-weight: bold;"><%=1+i %> </td>
												<td class="border-black" style="text-align: center;font-weight: bold;">
													<%=subProjectList.get(i)[12]!=null?subProjectList.get(i)[12]:"-" %>
												</td>
												<td class="border-black" style="font-weight: bold;"  >
													
															<div class="col">
																<%if (subProjectList.get(i) != null )
																	if(subProjectList.get(i)[1] != null) { %><%=subProjectList.get(i)[1]%> - <%=subProjectList.get(i)[13]!=null?subProjectList.get(i)[13]:"-"%>
																<%}%>
															</div>
														
												</td>
												<td class="border-black" style="font-weight: bold;text-align: center;">
													<%if(subProjectList.get(i)[32]!=null){%><%=subProjectList.get(i)[32] %><%}else {%>-<%} %>
												</td>
												
												<td class="border-black" style="font-weight: bold;text-align: center;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[5]!= null) { %>
														<%=fc.SqlToRegularDate(subProjectList.get(i)[5].toString())%>
													<%}%>
												</td>
												<td class="border-black" style="font-weight: bold;text-align: center;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[4]!= null) { %>
														<%=fc.SqlToRegularDate(subProjectList.get(i)[4].toString())%>
													<%}%>
												</td>
												<td class="border-black" style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[3]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[3].toString())/10000000)%>
													<%}%>
												</td>
												<td class="border-black" style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[16]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[16].toString())/10000000)%>
													<%}%>
												</td>
												<td class="border-black" style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[17]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[17].toString())/10000000)%>
													<%}%>
												</td>
												<td class="border-black" style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[18]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[18].toString())/10000000)%>
													<%}%>
												</td>
												<td class="border-black" style="font-weight: bold;text-align: right;">
													<%if (subProjectList.get(i) != null )
														if(subProjectList.get(i)[19]!= null) { %>
														<%=String.format("%.2f", Double.parseDouble(subProjectList.get(i)[19].toString())/10000000)%>
													<%}%>
												</td>
											</tr>
										<%} }%>
									</tbody>
						
									</table>
									<%} %>
						</div>
					</div>
							
				</div>
		

							<p style=" page-break-before: always;"></p>	
							<!-- ----------------------------------------- Slide Two ------------------------------------------------------------ -->
			<%if(projects!=null && projects.size()>0){
				for(int i=0;i<projects.size();i++ ){
					if(projects.get(i)[22]!=null || projects.get(i)[23]!=null || projects.get(i)[24]!=null ||
							projects.get(i)[25]!=null || projects.get(i)[27]!=null || projects.get(i)[29]!=null ||
							projects.get(i)[26]!=null || projects.get(i)[30]!=null || projects.get(i)[31]!=null){
							if(projects.get(i)[23].toString().equals("2")){ %>
								<div class="carousel-item " >
									<div class="container-fluid" >
										<div class="container-fluid"  >
											<div id="slide2" >
								
												<%
												double cost = Double.parseDouble(projects.get(i)[3].toString());
												String enduser = "--";
												if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IA")) {
												enduser = "Indian Army";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IN")) {
												enduser = "Indian Navy";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IAF")) {
												enduser = "Indian Air Force";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IH")) {
												enduser = "Home Land Security";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("DRDO")) {
												enduser = "DRDO";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("OH")) {
												enduser = "Others";
												}
												%>
								
															<div  style="border-radius:5px;background:#ffd8b1;margin:10px10px 10px 5px;" > 
													<span style="margin-top:10px;"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></span>	
													<h2 style="display: inline-block; margin-left:200px;font-size: 1.25rem!important;margin-top:-10px;">
															<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
															%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
															<%}%>
													</h2>
													<h6 class="col" style="display: inline-block;">
								 						<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
															<a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a>
														<%} %>
							 						</h6>
							 						
							 						 <span  style="float: right;margin-top:10px;margin-right:5px;"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></span> 
							 						
												</div>
												<div >
													<div class="row" >
														<div class="col-md-12">
												
															<table class="border-black" style="width: 99%;font-weight: bold;margin-left: 10px;margin-right: 10px;font-size: 1.25rem;">
																<tr class="border-black">
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%;">Project No </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%;">DoS </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">PDC </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%">User </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%;">Category </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">Cost (In Cr) </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">Application </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">Current Stage </td>
																	
																	
																	
																</tr>
																<tr class="border-black">
																	<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																	<td class="border-black" colspan="1" style="width: 12%;color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[5])%></td>
																	<td class="border-black" colspan="1" style="color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[4])%></td>
																	<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[6]!=null?projects.get(i)[6]:"--"%></td>
																	<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[32]!=null?projects.get(i)[32]:"--"%></td>
																	<td class="border-black" colspan="1" style="color:#007bff;text-align:right"><%=nfc.convert(cost / 10000000)%> </td>
																	<td class="border-black" colspan="1" style="color:#007bff;"> <%if (projects.get(i) != null && projects.get(i)[10] != null) {%> <%=projects.get(i)[10]%>
																		<%} else {%> -- <%}%></td>
																	<td class="border-black" colspan="1" style="color:#007bff;"> <%if(projects.get(i)[14]!=null){%> <%=projects.get(i)[14]%>
																		<%} else {%> -- <%}%></td>
																</tr>
																<tr class="border-black">
																	<td class="border-black" colspan="1" style="font-size: 1.25rem; font-weight: bold; color: #021B79;vertical-align: top;">Brief :</td>
																	<td class="border-black" colspan="7" style="font-size: 1.25rem;color: black;">
																		<%if(projects.get(i)[28]!=null){%>
																			<%=projects.get(i)[28]%>
																		<%}else{%>
																			--
																		<%}%>
																	</td>
																</tr>
																<tr>
																	<td class="border-black" colspan="1"><b style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Objectives : </b></td>
																	<td class="border-black" colspan="7"style="color: black;">
																			<%if(projects.get(i)[7]!=null) {%>
																				<%=projects.get(i)[7]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																<%-- <tr>
																	<td colspan="1"><b style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Scope : </b></td>
																	<td colspan="7"style="color: black;">
																			<%if(projects.get(i)[9]!=null) {%> 
																				<%=projects.get(i)[9]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr> --%>
																
																<tr>
																	<td class="border-black" colspan="1"><b style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Deliverables : </b> </td>
																	<td class="border-black" colspan="7"style="color: black;">
																			<%if(projects.get(i)[8]!=null) {%>
																				<%=projects.get(i)[8]%> 
																			<%} else{%>
																				--
																			<%} %>
																	</td>
																</tr>
																
																
															</table>
															<br>
															<div class="container-fluid">
																<div class="row">
																	<div class="col" style="margin-left:10px">
																	<p>
																	<span style="text-align: left;font-size: 1.25rem; font-weight: bold; color: #021B79;">
																				Current Status :</span> 
																				<%if(projects.get(i)!=null && projects.get(i)[20]!=null && projects.get(i)[20].toString().length()>0) {%>
																				<%-- 	<%=projects.get(i)[20].toString().substring(3,projects.get(i)[20].toString().length()-1 )%> --%>
																				<div class="ml-3" style="text-align: left; margin-left:10px"><%=projects.get(i)[20]%></div>
																				<%} else{%><div align="center">No Data</div><%} %>
																	</div>
																</div>
																<%if(projects.get(i)[31]!=null && projects.get(i)[31]!=""){%>
																		
																			
																<div class="row">
																	<div class="col" style="margin-left:10px">
																	<p>
																		<span style="text-align: left;font-size: 1.25rem; font-weight: bold; color: #021B79;">
																			Way Forward : 
																			</span>
																	<%-- 	<%=projects.get(i)[31].toString().substring(3,projects.get(i)[31].toString().length()-1 )%> --%>
																		<div class="ml-4">
																				<%=projects.get(i)[31].toString() %>
																				</div>
																	</div>
																		
																</div>
																<%}%>
																	
																	<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
															<div class="row ml-3">
												<span>	<i class="fa fa-lg fa-angle-double-right text-success" aria-hidden="true" style="font-size: 2rem"></i>	<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" ><b>Show more</b></a></span>
														</div>
														<%} %>
															</div>
																	
																	
													
														</div>
														<!-- <div class="col-md-7">
															<table style="width: 100%;font-weight: bold;vertical-align: top;">
																
																
															</table>
														</div> -->
													</div>
										
													<div class="col-md-12" style="padding-top: 40px">
														<table  style="width: 100%;height: 100%;border-style: hidden;">
															<tbody >
																
																<tr style="border-style: hidden;">
																	<td  style="border-style: hidden;text-align: center; ">
																		<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[24]).exists()){%>
																		<div style="max-height: 300px; max-width: 600px;margin: auto;">
																		<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
																			<a  href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>" target="_blank" >
																				<img class=" d-flex justify-content-center zoom2" data-enlargable style="max-height: 300px; max-width: 600px; margin-bottom: 5px;margin: auto;" 
																				src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																			</a>
																		<%}else{ %>
																				<img class=" d-flex justify-content-center zoom2" data-enlargable style="max-height: 300px; max-width: 600px; margin-bottom: 5px;margin: auto;" 
																				src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																			
																			<%} %>
																		</div>
																		<%} else{ %>image<%} %>
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
									
													<%-- <div class="row" style="margin-top: 10%;">
														<div class="col-md-2" align="left">
															<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[4]%>" target="_blank" title="PDF File"><b>Show more</b></a>
														</div>
													</div> --%>
												</div>
								
											</div>
										</div>
									</div>
								</div>
								<p style=" page-break-before: always;"></p>	
								<!-- ----------------------------------------- Slide One ------------------------------------------------------------ -->
							<%}%><% if(projects.get(i)[23].toString().equals("1")){ %> 
								<div class="carousel-item " >
									<div class="container-fluid" >
											<div class="container-fluid"  >
											<div class="" id="slide1">
												<%	double cost = Double.parseDouble(projects.get(i)[3].toString());
												 String enduser="--";
												if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IA")){
													enduser="Indian Army";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IN")){
													enduser="Indian Navy";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IAF")){
													enduser="Indian Air Force";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("IH")){
													enduser="Home Land Security";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("DRDO")){
													enduser="DRDO";
												}else if(projects!=null && projects.get(i)[6]!=null && projects.get(i)[6].toString().equalsIgnoreCase("OH")){
													enduser="Others";
												}
												%>
										<div  style="border-radius:5px;background:#ffd8b1;margin:10px10px 10px 5px;" > 
													<span style="margin-top:10px;"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></span>	
													<h2 style="display: inline-block; margin-left:200px;font-size: 1.25rem!important;margin-top:-10px;">
															<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
															%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
															<%}%>
													</h2>
													<h6 class="col" style="display: inline-block;">
								 						<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
															<a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a>
														<%} %>
							 						</h6>
							 						
							 						 <span  style="float: right;margin-top:10px;margin-right:5px;"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></span> 
							 						
												</div>
												
												<div >
													<table class="border-black" style="width: 99%;font-weight: bold;margin-left:10px ; margin-right:10px;font-size: 1.25rem;">
														<tr>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%;">Project No </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%;">DoS </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">PDC </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%">User </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;width: 12%;">Category </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">Cost (In Cr) </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">Application </td>
															<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold; color: maroon;">Current Stage </td>
														</tr>
														<tr>
															<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
															<td class="border-black" colspan="1" style="width: 12%;color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[5])%></td>
															<td class="border-black" colspan="1" style="color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[4])%></td>
															<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[6]!=null?projects.get(i)[6]:"--"%></td>
															<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[32]!=null?projects.get(i)[32]:"--"%></td>
															<td class="border-black" colspan="1" style="color:#007bff;text-align:right"><%=nfc.convert(cost / 10000000)%> </td>
															<td class="border-black" colspan="1" style="color:#007bff;"> <%if (projects.get(i) != null && projects.get(i)[10] != null) {%> <%=projects.get(i)[10]%>
																<%} else {%> -- <%}%></td>
															<td class="border-black" colspan="1" style="color:#007bff;"> <%if(projects.get(i)[14]!=null){%> <%=projects.get(i)[14]%>
																<%} else {%> -- <%}%></td>
														</tr>
													</table>
													<div class="row" style="">
														<div class="col-md-6">
															<div class="row">
																<div class="col left">
																	<table class="border-black" style="width: 98.1%;font-weight: bold;font-size: 1.25rem;margin-left: 1%">
																		<tr class="border-black" class="border-black">
																			<td  class="border-black" style="border-top: none;width: 24.8%;vertical-align: top;">
																				<b style="font-size: 1.25rem;font-weight: bold;color: #021B79;"> Brief:</b>
																			</td>
																			<td class="border-black" colspan="3" style="font-size: 1.25rem;border-top: none;vertical-align: top;color: black;">
																				<%if(projects.get(i)[28]!=null){%>
																					<%=projects.get(i)[28]%>
																				<%}else{%>
																					--
																				<%}%>
																			</td>
																		</tr>
																		<tr>
																			<td class="border-black">
																				<b style="font-size: 1.25rem;font-weight: bold;color: #021B79;vertical-align: top;">Objectives : </b>
																			</td>
																			<td class="border-black" colspan="3" style="color: black;"> 
																					<%=projects.get(i)[7]==null?"--":projects.get(i)[7]%> 
																			</td>
																		</tr>
																		<%-- <tr>
																			<td>
																				<b style="font-size: 1.25rem;font-weight: bold;color: #021B79;vertical-align: top;">Scope : </b>
																			</td>
																			<td colspan="3" style="color: black;"> 
																					<%=projects.get(i)[9]==null?"--":projects.get(i)[9]%> 
																			</td>
																		</tr> --%>
																				
																		<tr class="border-black">
																			<td class="border-black">
																				<b style="font-size: 1.25rem;font-weight: bold;color: #021B79;vertical-align: top;">Deliverables : </b>
																			</td >
																			<td class="border-black" colspan="3" style="color: black;"> 
																					<%=projects.get(i)[8]==null?"--":projects.get(i)[8]%> 
																			</td>
																		</tr>
																					
																	</table>
																	<br>
																	<div class="container-fluid">
																	<div class="row">
																		<div class="col" style="margin-left:10px">
																			<p><span style="text-align: left;font-size: 1.25rem; font-weight: bold; color: #021B79;">
																				Current Status : 
																			</span>
																			<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																				<%-- <%=projects.get(i)[20].toString().substring(3, projects.get(i)[20].toString().length())%> --%>
																					<div class="ml-3" style="text-align: left;margin-left:10px"><%=projects.get(i)[20]%></div>
																			<%} else{%><div align="center">No Data</div><%} %> 
																		</div>
																	</div>
																	<%if(projects.get(i)[31]!=null && projects.get(i)[31]!=""){%>	
																		<div class="row">
																			<div class="col" style="margin-left:10px">
																				<span style="text-align: left;font-size: 1.25rem; font-weight: bold; color: #021B79;">
																					Way Forward :</span> 
																				<div class="ml-3">
																				<%=projects.get(i)[31].toString() %>
																				</div>
																			</div>
																		</div>
																	<%}%>
																	
																	<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
															<div class="row ml-3">
													<span><i class="fa fa-lg fa-angle-double-right text-success" aria-hidden="true" style="font-size: 2rem"></i>	<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" ><b>Show more </b></a> </span>	
														</div>
														<%} %>
																	
																</div>
																</div>
																
															</div>
														</div>
														<br>
														<div class="col-md-6">
															<table style="width: 100%;height: 100%;border-style: hidden;">
																<tbody>
																	<tr >
																		<td style="border-bottom: none;max-height: 300px; max-width: 600px;margin: auto;">
																			<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[24]).exists()){%>
																				<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[27]).exists()){%>
																					<a href="SlidePdfOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>" target="_blank" >
																						<img class="zoom" data-enlargable height="600" style=" max-width: 70%; margin: auto; position: relative;display: flex;" align="middle" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																					</a>
																				<%}else{ %>
																					<img class=" d-flex justify-content-center zoom mx-auto d-block" data-enlargable style="max-height: 600px; max-width: 600px;" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath + projects.get(i)[25] + projects.get(i)[24])))%>">
																				<%} %>
																			<%} else{%>image<%}%>
																		</td>
																
																	</tr>
																</tbody>
															</table>
															<br>
															
							
														</div>
															  	 	
														
														</div>
														
														
												</div>	
											</div>
					
											</div>
					
									</div>
								</div>
								<p style=" page-break-before: always;"></p>	
						<!-- ----------------------------------------- Slide Three - No Data ------------------------------------------------------------ -->
						<%}}else{%>
							
							<div class="carousel-item " >
									<div class="container-fluid" >
										<div class="container-fluid"  >
											<div id="slide2" >
								
												<%
												double cost = Double.parseDouble(projects.get(i)[3].toString());
												String enduser = "--";
												if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IA")) {
												enduser = "Indian Army";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IN")) {
												enduser = "Indian Navy";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IAF")) {
												enduser = "Indian Air Force";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("IH")) {
												enduser = "Home Land Security";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("DRDO")) {
												enduser = "DRDO";
												} else if (projects != null && projects.get(i)[6] != null && projects.get(i)[6].toString().equalsIgnoreCase("OH")) {
												enduser = "Others";
												}
												%>
								
							<div  style="border-radius:5px;background:#ffd8b1;margin:10px10px 10px 5px;" > 
													<span style="margin-top:10px;"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></span>	
													<h2 style="display: inline-block; margin-left:200px;font-size: 1.25rem!important;margin-top:-10px;">
															<%if (projects.get(i) != null )if(projects.get(i)[1] != null) {
															%><%=projects.get(i)[1]%> - <%=projects.get(i)[13]!=null?projects.get(i)[13]:"-"%> (<%=projects.get(i)[12]!=null?projects.get(i)[12]:"-" %>)
															<%}%>
													</h2>
													<h6 class="col" style="display: inline-block;">
								 						<%if(new File(filePath + projects.get(i)[25] + projects.get(i)[30]).exists()){%>
															<a href="SlideVideoOpenAttachDownload.htm?slideId=<%=projects.get(i)[26]%>"  target="_blank" title="Video File"><b>Show Video</b></a>
														<%} %>
							 						</h6>
							 						
							 						 <span  style="float: right;margin-top:10px;margin-right:5px;"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></span> 
							 						
												</div>
												<div >
													<div class="row" >
														<div class="col-md-12">
												
															<table class="border-black" style="width: 99%;font-weight: bold;margin-left:10px ; margin-right:10px;font-size: 1.25rem;">
																<tr class="border-black">
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;width: 12%;">Project No </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;width: 12%;">DoS </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;">PDC </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;width: 12%">User </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;width: 12%;">Category </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;">Cost (In Cr) </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;">Application </td>
																	<td class="border-black" colspan="1" style="text-align:center;font-size: 1.25rem; font-weight: bold;color: maroon;">Current Stage </td>
																</tr>
																<tr>
																	<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[11]!=null?projects.get(i)[11]:"--"%></td>
																	<td class="border-black" colspan="1" style="width: 12%;color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[5])%></td>
																	<td class="border-black" colspan="1" style="color:#007bff;text-align:center"><%=sdf.format(projects.get(i)[4])%></td>
																	<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[6]!=null?projects.get(i)[6]:"--"%></td>
																	<td class="border-black" colspan="1" style="text-align:center;width: 12%;color:#007bff;"><%=projects.get(i)[32]!=null?projects.get(i)[32]:"--"%></td>
																	<td class="border-black" colspan="1" style="color:#007bff;text-align:right;"><%=nfc.convert(cost / 10000000)%> </td>
																	<td class="border-black" colspan="1" style="color:#007bff;"> <%if (projects.get(i) != null && projects.get(i)[10] != null) {%> <%=projects.get(i)[10]%>
																		<%} else {%> -- <%}%></td>
																	<td class="border-black" colspan="1" style="color:#007bff"> <%if(projects.get(i)[14]!=null){%> <%=projects.get(i)[14]%>
																		<%} else {%> -- <%}%></td>
																</tr>
																<tr>
																	<td class="border-black" colspan="1" style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Brief :</td>
																	<td class="border-black" colspan="7" style="font-size: 1.25rem;color: black;">
																		--
																	</td>
																</tr>
																<tr>
																	<td class="border-black" colspan="1"><b style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Objectives : </b></td>
																	<td class="border-black" colspan="7" style="color: black;">
																	 <%if(projects.get(i)[7] != null && projects.get(i)[7].toString().length() > 320) {%>
																		<%=projects.get(i)[7].toString().substring(0, 280)%>
																	<%} else {%> 
																		<%=projects.get(i)[7]!=null?projects.get(i)[7]:"--"%> 
																	<%}%>
																	</td>
																</tr>
															<%-- 	<tr>
																	<td colspan="1">
																		<b style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Scope : </b>
																	</td>
																	<td colspan="7" style="color: black;">
																		<%if (projects.get(i)[9] != null && projects.get(i)[9].toString().length() > 600) {%>
																			<%=projects.get(i)[9].toString().substring(0, 600)%>
																		<%} else {%> 
																			<%=projects.get(i)[9]!=null?projects.get(i)[9]:"--"%> 
																		<%}%>
																	</td>
																</tr> --%>
																
																<tr>
																	<td class="border-black" colspan="1"><b style="font-size: 1.25rem; font-weight: bold; color: #021B79;">Deliverables : </b> </td>
																	<td class="border-black" colspan="7" style="color: black;">
																		<% if (projects.get(i)[8] != null && projects.get(i)[8].toString().length() > 320) {%>
																			<%=projects.get(i)[8].toString().substring(0, 280)%>
																		<%} else {%> 
																			<%=projects.get(i)[8]!=null?projects.get(i)[8]:"--"%> 
																		<% } %>
																	</td>
																</tr>
																
															</table>
															<br>
															<div class="container-fluid">
															<div class="row">
															<div class="col-2" style="margin-left:10px">
															<h4 style="text-align: left;font-size: 1.25rem; font-weight: bold; color: #021B79;">
																		Current Status : 
																	</h4>
															</div>
															<div class="col" style="margin-left:10px">
															
																	<%if(projects.get(i)!=null && projects.get(i)[20]!=null) {%>
																				<div class="ml-3" style="text-align: left;"><%=projects.get(i)[20]%></div>
																		<%} else{%><div align="center">No Data</div> <%} %> 
						
															</div>
															</div>
															</div>
															
													
														</div>
													</div>
										
												
												</div>
								
											</div>
										</div>
									</div>
								</div>
							
							<p style=" page-break-before: always;"></p>	
						<%}}}else{%><% } %>
							
							
							
							
							
			
							<!-- ----------------------------------------  Thank you Div ----------------------------------------------------- -->
						
					<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<div align="center" style="text-align: center; vertical-align: middle ;font-size:60px;font-weight: 600;margin: auto; position: relative;color:black !important" >THANK YOU !</div>
				
							
				
						<!-- ----------------------------------------   Thank you Div Ends ----------------------------------------------------- -->
		 
			 		
	




</body>
</html>