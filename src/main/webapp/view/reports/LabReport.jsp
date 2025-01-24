<%@page import="com.vts.pfms.report.model.PfmsLabReportMilestone"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>

<%@page import="java.util.List"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Insert title here</title>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<style type="text/css">
 p{
  text-align: justify; 
  text-justify: inter-word;
}
.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}
.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
	overflow-wrap: break-word;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 	overflow-wrap: break-word;
 }
 
  }
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 
 .containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}

.anchorlink{
	cursor: pointer;
	color: #C84B31;
}
.anchorlink:hover {
    text-decoration: underline;
}

</style>


<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}


.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<!------------------- tree -------------------->
<!----------------- model  tree   ---------------------->
<style>

.caret-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested-1 {
  display: none;
}

.active-1 {
  display: block;
}

 .completed{
	color: green;
	font-weight: 700;
}

.briefactive{
	color: blue;
	font-weight: 700;
}

.inprogress{
	color: #F66B0E;
	font-weight: 700;
}

.assigned{
	color: brown;
	font-weight: 700;
}

.notyet{
	color: purple;
	font-weight: 700;
}
.notassign{
	color:#AB0072;
	font-weight: 700;
}
.ongoing{
	color: #F66B0E;
	font-weight: 700;
}

.completed{
	color: green;
	font-weight: 700;
}

.delay{
	color: maroon;
	font-weight: 700;
}

.completeddelay{
	color:#BABD42;
	font-weight: 700;
}

.inactive{
	color: red;
	font-weight: 700;
}

.delaydays
{
	color:#000000;
	font-weight: 700;
}

.select2-container{
	float:right !important;
	margin-top: 5px;
	
}

.modal-xl{
	max-width: 1400px;
}

.sub-title{
	font-size : 20px !important;
	color: #145374 !important
}

.subtables{
	width: 1100px !important;
}

.date-column{
	max-width:60px !important;
}
 
.status-column{
	max-width:10px !important;
} 

.resp-column{
	max-width:80px !important;
} 
 
.currency{
	color:#367E18 !important;
	font-style: italic;
} 


.subtables th{
	/* background-color: #001253 !important; 
	color: white !important;
	border-color: white; */
	color: #001253 !important;
	
}
 

 
 
.projectattributetable th{
	text-align: left !important;
} 
 
.section {
    margin-bottom: 30px;
}

.section-heading {
    border-bottom: 2px solid #007bff; /* Blue border for the heading */
    margin-bottom: 15px;
}

.section-heading h3 {
    color: #007bff;
    font-weight: bold;
}

.section-content {
    background-color: #f8f9fa; /* Light gray background for content */
    padding: 20px;
    border-radius: 5px; /* Rounded corners for content area */
    border: 1px solid #dee2e6; /* Light gray border for the content */
}

.table-bordered {
    border: 1px solid #dee2e6;
}

.table-bordered td {
    padding: 10px;
}

textarea.form-control {
    width: 100%;
    margin-top: 10px;
}
input[type=checkbox] {
	accent-color: green;
}

</style>

</head>
<body>

<%
DecimalFormat df=new DecimalFormat("####################.##");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); 
List<Object[]> proList=(List<Object[]>)request.getAttribute("proList");
List<Object[]> milestoneData=(List<Object[]>)request.getAttribute("milestoneData");
String filePath=(String)request.getAttribute("filePath");
System.out.println("filePath%%%%"+filePath);
String projectLabCode=(String)request.getAttribute("projectLabCode");
Object[] ProjectEditData=(Object[])request.getAttribute("ProjectEditData");
Object[] editorData=(Object[])request.getAttribute("editorData");
String Project=(String)request.getAttribute("ProjectId");
int currentYear=(int)request.getAttribute("currentYear");
int PastYr=currentYear-1;
int nextYear=(int)request.getAttribute("nextYear");
List<PfmsLabReportMilestone>LabReportMilestoneData = (List<PfmsLabReportMilestone>)request.getAttribute("LabReportMilestoneData");

List<String>activityids= new ArrayList<>();
List<String>activityidsNextYear= new ArrayList<>();


List<Object[]>MainProjectList = new ArrayList<>(); 
List<Object[]>subProjectList = new ArrayList<>(); 
if(proList!=null && proList.size()>0){
	MainProjectList = proList.stream().filter(e -> e[22].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	subProjectList = proList.stream().filter(e -> e[22].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}


%>
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br/>
    
     <div class="container-fluid">
		<div class="row" id="main">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header" style="height:auto;padding:4px;">
			   			<div class="col-sm-12 col-md-5">
							<h3 style="margin-bottom:0px;">Lab Report</h3>
						</div>	 
				<%if(session.getAttribute("LoginType").toString().equalsIgnoreCase("A")){ %>		
					<div class="col-md-2">
			       <form action="#"> 
			       <button type="submit" class="btn bg-transparennt" formaction="LabReportChapter1.htm" formmethod="get" data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="CHAPTER 1">
			       <i class="fa fa-download" aria-hidden="true" style="color:green;"></i> 
			       </button>
			       <button type="submit" class="btn bg-transparennt" formaction="LabReportChapter2.htm" formmethod="get" data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="CHAPTER 2">
			       <i class="fa fa-download" aria-hidden="true" style="color:green;"></i> 
			       </button>
			       </form>
			       </div>
					<%} %> 
						<div class="col-sm-12 col-md-5" style="float: right;">
						   <form method="get" action="LabReports.htm" id="projectchange">
							
							<div class="row" style="justify-content: flex-end;">
								<div class="form-inline" style="margin-bottom: 4px;">
	                            		<label class="control-label"style="font-size: 17px"><b>Project Name :&nbsp;</b></label>
										<select class="form-control  selectdee items" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="this.form.submit();">
											<option disabled="disabled"  selected value="">Choose...</option>
											<%for(Object[] obj : proList){ 
												String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
											%>
												<option  value="<%=obj[0] %>" <%if (Project.equalsIgnoreCase(obj[0].toString())) {%>
														selected="selected" <%}%>><%=obj[4] +projectshortName%></option>
											<%} %>
										</select>
							   </div>
							   <button  type="submit" class="btn btn-sm " id="btn-export" style="border: 0 ; margin-left: 30px;size: 25px;background-color: transparent;" formmethod="GET" formaction="LabReportDownload.htm" formtarget="_blank">
							      <!-- <i class="fa fa-file-word-o" aria-hidden="true"></i> -->
							      <i class="fa fa-file-word-o" style="font-size:17px;color: blue;" title="Lab Report New Word Download"></i>
                              </button> 
                                    &nbsp;  &nbsp;  &nbsp;
                              <button data-toggle="tooltip" onclick="showDashboardProjectModal()" class="btn btn-sm bg-transparent faa-pulse animated faa-fast" 
                               style="cursor: pointer;" type="button" data-placement="top" title="" data-original-title="Select DashBoard Projects">
                               <img src="view/images/dashboard.png" style="width: 25px;">
                              </button>
							   
							</div>		
                                        
                         <input type="hidden" name="currentyr" value="<%=currentYear%>">
                         <input type="hidden" name="nextyr" value="<%=nextYear%>">
                         <input type="hidden" name="prjLabCode" value="<%=projectLabCode%>">
                                        
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					 </form>				
			       </div>
		
			     </div>
		       </div>
				
   <div class="container mt-4">
    <!-- Section 1: Project Attributes -->
    <div class="section">
        <!-- Heading -->
        <div class="section-heading" style="border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 15px;">
            <h3 style="color: #007bff; font-weight: bold;">1. Project Attributes</h3>
        </div>
        
        <!-- Content Below Heading -->
      <!-- Content Below Heading -->
        <div class="section-content p-3" style="background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px;">
            
            <!-- Project Name -->
            <div class="attribute">
                <h5 style="font-weight: bold;">Project Name</h5>
                <p style="color: black;"><%=ProjectEditData[2] %></p>
            </div>
            
            <div class="attribute">
                <h5 style="font-weight: bold;">Image</h5>
                <p style="color: black;"><%if(ProjectEditData[18]!=null){ %>
               
											<%
											Path techPath = Paths.get(filePath,projectLabCode,"ProjectSlide",ProjectEditData[18].toString());
											
											File tecfile = techPath.toFile();
											if(tecfile.exists()){ %>
											<img style="max-width:25cm;max-height:17cm;margin-bottom: 5px" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(tecfile))%>" > 											
											<%} %>
										
                <%}else{ %>
                  <p style="color: black;"><div style="color: red;font-weight: 600">To Upload it Please Enter in the Project Slide..</div> </p>
                  <%} %>
            </div>
            <!-- Brief -->
             <div class="attribute">
                <h5 style="font-weight: bold;">Introduction</h5>
               <%--  <p style="color: black;"><%if(ProjectEditData[17]!=null){ %>
                <p style="color: black;">  <%=ProjectEditData[17] %></p>
                <%}else{ %>
                  <p style="color: black;"> <div style="color: red;font-weight: 600">Enter the Brief in Project Slide</div> </p>
                  <%} %> --%>
                  
                  
               <textarea class="form-control" maxlength="2000" rows="4"  id="introduction">
               <%if(editorData!=null && editorData[5]!=null ){ %><%=editorData[5] %><%}else if( ProjectEditData[17]!=null){ %><%=  ProjectEditData[17] %>  <%} %>
               </textarea>   
               <div align="left" class="mt-2"><button class="btn btn-sm submit" onclick="submitIntroduction()">SUBMIT</button></div>
            </div>

            <!-- Total Cost -->
            <div class="attribute mt-3">
                <h5 style="font-weight: bold;">Total Cost</h5>
                <p style="color: black;"><%if(ProjectEditData[6]!=null){ %>
                <p style="color: black;">  <%=ProjectEditData[6] %><span style="font-weight: 800;color:black;">(in Lakhs)</span> </p>
                <%}else{ %>
                  <p style="color: black;"> - </p>
                  <%} %></p>
            </div>

            <!-- Category -->
            <div class="attribute mt-3">
                <h5 style="font-weight: bold;">Category</h5>
                <%if(ProjectEditData[19]!=null){ %>
                <p style="color: black;">  <%=ProjectEditData[19] %> </p>
                <%}else{ %>
                  <p style="color: black;"> - </p>
                  <%} %>
            </div>

            <!-- Participating Lab -->
            <div class="attribute mt-3">
            <h5 style="font-weight: bold;">Participating Lab</h5>
            <%if(ProjectEditData[10]!=null){ %>
            <p style="color: black;">  
            <%=ProjectEditData[10] %> 
            </p>
            <%}else{ %>
            <p style="color: black;"> - </p>
            <%} %>
            </div>

            <!-- Scope -->
            <div class="attribute mt-3">
                <h5 style="font-weight: bold;">Scope</h5>
                  <%if(ProjectEditData[11]!=null){ %>
                <p style="color: black;">  <%=ProjectEditData[11] %> </p>
                <%}else{ %>
                  <p style="color: black;"> - </p>
                  <%} %>
            </div>

            <!-- Objective -->
            <div class="attribute mt-3">
                <h5 style="font-weight: bold;">Objective</h5>
                <p style="color: black;">  <%if(ProjectEditData[9]!=null){ %>
                <p style="color: black;">  <%=ProjectEditData[9] %> </p>
                <%}else{ %>
                  <p style="color: black;"> - </p>
                  <%} %></p>
            </div>

            <!-- Details of Review held till YR -->
            <div class="attribute mt-3">
                <h5 style="font-weight: bold;">Details of Review held till <%=PastYr%></h5>
                <p style="color: black;"><b>EB:</b> <%=ProjectEditData[16] %></p>
                <p style="color: black;"><b>PMRC:</b> <%=ProjectEditData[15] %></p>
              <%--   <table>
                <tr><td><b>EB:</b> <%=ProjectEditData[16] %></td>
                <td><b>PMRC:</b> <%=ProjectEditData[15] %></td>
                </table> --%>
            </div>

            <!-- Current Stage of Project -->
            <div class="attribute mt-3">
                <h5 style="font-weight: bold;">Current Stage of Project</h5>
                <%if(ProjectEditData[14]!=null){ %>
                <p style="color: black;">  <%=ProjectEditData[14] %> </p>
                <%}else{ %>
                  <p style="color: black;"> - </p>
                  <%} %>
            </div>
        </div>
    </div>


    <!-- Section 2: Achievements -->
    <div class="section mt-5">
        <!-- Heading -->
        <div class="section-heading" style="border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 15px;">
            <h3 style="color: #007bff; font-weight: bold;">2. Achievements</h3>
        </div>
        
        <!-- Content Below Heading -->
        <div class="section-content p-3" style="background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px;">
            <h5>
            <b>Planned Activities in the Project for Next Year</b>
               <% 
             if(milestoneData!=null && milestoneData.size()>0){%>
             <button class="btn btn-info" onclick="showModal('N')" style="float:right;">VIEW ALL</button>
             <%}else{ %>
             <span> - No Milestones specified for this Project !</span>
             <%} %>
            </h5>
           
             <%
             if(LabReportMilestoneData!=null && LabReportMilestoneData.size()>0){  
               
             int count1=0;%>
             <br>
             <table class="table table-bordered">
  			 <thead style="border:2px solid #dee2e6">
  			 <tr>
  				<th style="width:10%">SN</th>
  				<th style="width:60%">Activity Name</th>
  				</tr>
  				</thead>
  				<tbody>
            <% if(LabReportMilestoneData!=null && LabReportMilestoneData.size()>0){
            	 for (PfmsLabReportMilestone pm: LabReportMilestoneData) {
            		 if(pm.getActivityFor()!=null && pm.getActivityFor().equalsIgnoreCase("N")) {
            			 activityidsNextYear.add(pm.getMilestoneActivityId()+"");
            		 %>
            	<tr>
             	<td style="text-align: center;"><%=(++count1) %>.</td>
             	<td style="text-align: justify ;"><%= pm.getActivityName() %></td> 
             	</tr>
             	<%}}} %>
      			 <%} %>
      			 </tbody>
      			 </table>
            <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
            
            <br>
            
            <h5><b>Major Achievement/Activities completed during this Year</b>
              <% 
             if(milestoneData!=null && milestoneData.size()>0){%>
             <button class="btn btn-info" onclick="showModal()" style="float:right;">VIEW ALL</button>
             <%}else{ %>
             	<span> - No Milestones specified for this Project !</span>
             <%} %>
             </h5> 

          <div class="modal-body">
            <%
          	 int sn=0;
             if(LabReportMilestoneData!=null && LabReportMilestoneData.size()>0){  
        	  List<PfmsLabReportMilestone>presentYearData  = LabReportMilestoneData.stream().filter(e->e.getActivityFor()!=null &&  e.getActivityFor().equalsIgnoreCase("P")).collect(Collectors.toList());
             %>
  			 <table class="table table-bordered">
  			 <thead style="border:2px solid #dee2e6">
  			 <tr>
  				<th style="width:10%">SN</th>
  				<th style="width:60%">Activity Name</th>
  				</tr>
  				</thead>
            	 <% for (PfmsLabReportMilestone pm : presentYearData) {
            		 activityids.add(pm.getMilestoneActivityId()+"");
            		%>
            <tbody>
            <tr>
           	<td style="text-align: center"><%=++sn %>.</td>
           	<td style="text-align: left;"><%=pm.getActivityName()%></td>
            </tr>
            </tbody>
             <%}} %>
             </table>
             	
             
            </div>
   
     
       <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="largeModal1" data-backdrop="static">
  <div class="modal-dialog modal-lg" style="max-width: 1440px;">
    <div class="modal-content">
    
    <div class="modal-header bg-primary text-light">
        <h5 class="modal-title" id="exampleModalLabel">Project All Major Milestones</h5>
        <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" style="color:red;">×</span>
        </button>
      </div>
           <div class="modal-body" style="overflow: auto;height:600px">
           <span class="text-danger mb-2 t">
           To chnage in Anything Activity Name please unchecked the checkbox 
           then update the data and make it checked again.Only the selected Activities will come in Lab Report
           </span>
            <% int count1=0;
             if(milestoneData!=null && milestoneData.size()>0){%>
            	
  				<table class="table table-bordered">
  				<thead style="border:2px solid #dee2e6">
  				<tr>
  				<th></th>
  				<th style="width:10%">SN</th>
  				<th style="width:15%">Milestone No.</th>
  				<th style="width:60%">Activity Name</th>
  				<th>Progress</th>
  				</tr>
  				</thead>
            	 <% for (Object[] activity : milestoneData) {
            		 List<PfmsLabReportMilestone>NextYearMilestoneData  = LabReportMilestoneData.stream().filter(e->(e.getMilestoneActivityId()+"").equalsIgnoreCase(activity[9].toString()) && e.getActivityFor()!=null &&  e.getActivityFor().equalsIgnoreCase("N")).collect(Collectors.toList());
            		%>
            <tbody>
            <tr>
            <td style="text-align: center;">
            <input type="checkbox" class="" style="transform:scale(2)" name="ActivityIdS"  <%if(activityidsNextYear.contains(activity[9].toString())){ %> checked <%} %>   value="<%=activity[9].toString()%>" >
            </td>
            <td style="text-align: center;"> <%=++count1 %></td>
            <td style="text-align: center;">Milestone - <%=activity[10].toString()%></td>
            <td> 
        	  <%--   <textarea class="form-control" id="text<%=activity[9].toString()%>" > <%=activity[1].toString() %></textarea> --%>
        
            <div class="Editor" ></div>
			<textarea  name="description" style="display: none;" class="form-control" id="textNext<%=activity[9].toString()%>" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters">
			
			<%if(NextYearMilestoneData!=null && NextYearMilestoneData.size()>0){ %>
			<%=NextYearMilestoneData.get(0).getActivityName() %>
			<%}else{ %>
			<%=activity[1].toString() %>
			
			<%} %>
			</textarea>
			    <script>
            
            document.addEventListener("DOMContentLoaded", function () {
                var editorId = 'textNext<%=activity[9].toString()%>';
                CKEDITOR.replace(editorId, editor_config1);

                // Ensure changes in CKEditor are reflected in the textarea for form submission
                CKEDITOR.instances[editorId].on('change', function () {
                    CKEDITOR.instances[editorId].updateElement();
                });
            });
            </script>
             </td>
            <td style="text-align: center;">
        		<%=activity[11].toString()%>
            </td>
            </tr>
            </tbody>
             <%}} %>
             	</table>
           </div>
    		<div align="center" class="mt-2 mb-2"><button class="btn btn-warning" onclick="updateAll('N')">UPDATE</button></div>
      
    </div>
  </div>
</div>
     
     
     
     
   <!-- For Present year  -->
  <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="largeModal" data-backdrop="static">
  <div class="modal-dialog modal-lg" style="max-width: 1440px;">
    <div class="modal-content">
    
    <div class="modal-header bg-primary text-light">
        <h5 class="modal-title" id="exampleModalLabel">Project All Major Milestones</h5>
        <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" style="color:red;">×</span>
        </button>
      </div>
           <div class="modal-body" style="overflow: auto;height:600px">
           <span class="text-danger mb-2 t">
           To chnage in Anything Activity Name please unchecked the checkbox 
           then update the data and make it checked again.Only the selected Activities will come in Lab Report
           </span>
            <% int count=0;
             if(milestoneData!=null && milestoneData.size()>0){%>
            	
  				<table class="table table-bordered">
  				<thead style="border:2px solid #dee2e6">
  				<tr>
  				<th></th>
  				<th style="width:10%">SN</th>
  				<th style="width:15%">Milestone No.</th>
  				<th style="width:60%">Activity Name</th>
  				<th>Progress</th>
  				</tr>
  				</thead>
            	 <% for (Object[] activity : milestoneData) {
            		 List<PfmsLabReportMilestone>SubLabReportMilestoneData  = LabReportMilestoneData.stream().filter(e->(e.getMilestoneActivityId()+"").equalsIgnoreCase(activity[9].toString()) && e.getActivityFor()!=null &&  e.getActivityFor().equalsIgnoreCase("P")).collect(Collectors.toList());
            		%>
            <tbody>
            <tr>
            <td style="text-align: center;">
            <input type="checkbox" class="" style="transform:scale(2)" name="ActivityId"  <%if(activityids.contains(activity[9].toString())){ %> checked <%} %>   value="<%=activity[9].toString()%>" >
            </td>
            <td style="text-align: center;"> <%=++count %></td>
            <td style="text-align: center;">Milestone - <%=activity[10].toString()%></td>
            <td> 
        	  <%--   <textarea class="form-control" id="text<%=activity[9].toString()%>" > <%=activity[1].toString() %></textarea> --%>
        
            <div class="Editor" ></div>
			<textarea  name="description" style="display: none;" class="form-control" id="text<%=activity[9].toString()%>" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters">
			
			<%if(SubLabReportMilestoneData!=null && SubLabReportMilestoneData.size()>0){ %>
			<%=SubLabReportMilestoneData.get(0).getActivityName() %>
			<%}else{ %>
			<%=activity[1].toString() %>
			
			<%} %>
			</textarea>
			    <script>
            
            document.addEventListener("DOMContentLoaded", function () {
                var editorId = 'text<%=activity[9].toString()%>';
                CKEDITOR.replace(editorId, editor_config1);

                // Ensure changes in CKEditor are reflected in the textarea for form submission
                CKEDITOR.instances[editorId].on('change', function () {
                    CKEDITOR.instances[editorId].updateElement();
                });
            });
            </script>
             </td>
            <td style="text-align: center;">
        		<%=activity[11].toString()%>
            </td>
            </tr>
            </tbody>
             <%}} %>
             	</table>
           </div>
    		<div align="center" class="mt-2 mb-2"><button class="btn btn-warning" onclick="updateAll('P')">UPDATE</button></div>
      
    </div>
  </div>
</div>
	
        </div>
    </div>
    

    <!-- Section 3: Likely Spin-Off -->
    <div class="section mt-5">
        <!-- Heading -->
        <div class="section-heading" style="border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 15px;">
            <h3 style="color: #007bff; font-weight: bold;">3. Likely Spin-Off including application for Civil use (if any)</h3>
        </div>
        
        <!-- Content Below Heading -->
        <div class="section-content p-3" style="background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px;">
            <form action="LabReportDataAdd.htm" method="get">
                <div class="form-group">
                    <textarea class="form-control" name="SpinOffData" id="ckeditor"  rows="5" cols="50" maxlength="5" placeholder="Enter Spin-Off details here..."><%if(editorData!=null && editorData[2]!=null){ %> <%=editorData[2] %>  <%}%></textarea> 
                </div>
                <div align="center">
                <button type="submit" class="btn btn-primary btn-sm submit" onclick="return confirm('Are You Sure To Submit ?');"> Submit</button>
                <input type="hidden" name="projectId" value="<%=Project%>">
                <input type="hidden" name="Action" value="Spinoff">
                </div>
            </form>
        </div>
    </div>

    <div class="section mt-5">
        <!-- Heading -->
        <div class="section-heading" style="border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 15px;">
            <h3 style="color: #007bff; font-weight: bold;">4.Details of LSI/DCPP/PA (If Nominated)</h3>
        </div>
        
        <!-- Content Below Heading -->
        <div class="section-content p-3" style="background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px;">
            <form action="LabReportDataAdd.htm" method="get">
                <div class="form-group">

                 <textarea id="Editor1" style="display:none;" class="form-control" name="NominatedDetails"   rows="5" cols="50" maxlength="5" placeholder="Enter Details of LSI/DCPP/PA (If Nominated)..."><%if(editorData!=null && editorData[3]!=null){ %> <%=editorData[3] %> <%}else{%>  <%} %></textarea>
 
                </div>
                <div align="center">
                <button type="submit" class="btn btn-primary btn-sm submit" onclick="return confirm('Are You Sure To Submit ?');">Submit</button>
                <input type="hidden" name="projectId" value="<%=Project%>">
                <input type="hidden" name="Action" value="LSI/DCPP/PA">
                </div>
            </form>
        </div>
    </div>
    
  <%--   <div class="section mt-5">
        <!-- Heading -->
        <div class="section-heading" style="border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 15px;">
            <h3 style="color: #007bff; font-weight: bold;">5.Achievement for the Current Year</h3>
        </div>
        
        <!-- Content Below Heading -->
        <div class="section-content p-3" style="background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px;">
            <form action="LabReportDataAdd.htm" method="get">
                <div class="form-group">
                    <textarea class="form-control" name="CurrentYrAchievement" id="ckeditor2"  rows="5" cols="50" maxlength="5" placeholder="Enter Achievement for the Current Year..."><%if(editorData!=null && editorData[4]!=null){ %> <%=editorData[4] %> <%}else{%>  <%} %></textarea>
                </div>
                <button type="submit" class="btn btn-primary" onclick="return confirm('Are You Sure To Submit ?');">Submit</button>
                <input type="hidden" name="projectId" value="<%=Project%>">
                <input type="hidden" name="Action" value="AchievementofCurrentYr">
            </form>
        </div>
    </div> --%>

   </div>
  </div>
 </div>
 </div>


<!-- modal  -->

<div class="modal fade bd-example-modal-lg" id="DashboardProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document" style="max-width: 1440px;">
    <div class="modal-content">
      <div class="modal-header bg-primary text-light">
        <h5 class="modal-title" id="exampleModalLabel">Lab Reports Projects</h5>
        <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" style="color:red;">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <hr>
  <%--     <div class="row ml-2 mt-2 mb-2"> 
      
 
      
      <hr>
      <% if(proList!=null && proList.size()>0){%>
      <div class="row ml-2 mb-3 mt-2" >
       projects : <input id="mainProject" style="transform:scale(1.5)" type="checkbox"  > 
      </div>
      <%} %>
    
     
      <div class="row" style="">
      <div class="col-md-2 ml-4 mt-3" style="font-weight: 500;font-size: 1.4rem;"> Main Projects :</div>
      <% 
      if(proList!=null && proList.size()>0){
   		List<Object[]>mainProList=proList.stream().filter(e->e[22].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
  
      for(Object[]obj:mainProList) {%>
      <div class="col-md-2 ml-4 mt-3">
      <input class="mainProject" type="checkbox" name="projectId" style="transform:scale(1.5)" value="<%=obj[0].toString()%>"> <span ><%=obj[4].toString() %>&nbsp;/&nbsp;<%=obj[17].toString() %></span>
      </div>
    
       <%}} %>
       
      <div class="col-md-12 " style=" display: flex;">
      <div class="col-md-2 ml-4 mt-3" style="font-weight: 500;font-size: 1.4rem;"> Sub Projects :</div>
     
      <% 
      if(proList!=null && proList.size()>0){
          List<Object[]>subProList =proList.stream().filter(e->e[22].toString().equalsIgnoreCase("0")).collect(Collectors.toList());

      for(Object[]obj:subProList) {%>
      <div class="col-md-2 ml-4 mt-3">
      <input class="mainProject" type="checkbox" name="projectId" style="transform:scale(1.5)" value="<%=obj[0].toString()%>"> <span ><%=obj[4].toString() %>&nbsp;/&nbsp;<%=obj[17].toString() %></span>
      </div>
       <%}} %>
       </div>  
       
       </div> 
       
  
       
        	</div> --%>
     
           <% if(MainProjectList!=null && MainProjectList.size()>0){ %>
      <div class="row ml-2 mb-3 mt-2" style="font-weight: 800;">
      Main projects : &nbsp;<input id="mainProject" style="transform:scale(1.5)" type="checkbox"  > 
      </div>
      <%} %>
      <div class="row" style="">
      <% 
      if(MainProjectList!=null && MainProjectList.size()>0){
      for(Object[]obj:MainProjectList) {%>
      <div class="col-md-2 ml-4 mt-3" style="font-weight: 800;">
      <input class="mainProject" type="checkbox" name="projectId" style="transform:scale(1.5)" value="<%=obj[0].toString()%>"> 
         &nbsp;   <span style="font-weight: 700;"><%=obj[4].toString() %>&nbsp;/&nbsp;<%=obj[17].toString() %></span> 
      </div>
       <%}} %>
       </div> 
        <hr class="mt-2">
       <%if(subProjectList!=null && subProjectList.size()>0){ %>
      <div class="row ml-2 mb-3 mt-2" style="font-weight: 800">
     		 Sub projects :   &nbsp;    <input id="subProject" style="transform:scale(1.5)" type="checkbox"  > 
     		 
      </div>
      <%} %>
      <div class="row" style="">
      <%if(subProjectList!=null && subProjectList.size()>0){
      for(Object[]obj:subProjectList) {%>
       <div class="col-md-2 ml-4 mt-3" >
       <input class="subProject" style="transform:scale(1.5)" type="checkbox" name="projectId" value="<%=obj[0].toString()%>">
       &nbsp;<span style="font-weight: 700;"><%=obj[4].toString() %>&nbsp;/&nbsp;<%=obj[17].toString() %></span> 
      </div>
      <%}} %>
      </div>
     
     
     
     
     
          <div class="col-md-12 mt-3 mb-3" align="center" id="addDiv" style="">
        	<form action="LabReportDownload.htm" method="post">
        	<input type="hidden" name="addFav" id="addFavvalue">
        	<input type="hidden" name="projectid" id="projects">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
        	<button type="submit" class="btn btn-sm submit" onclick="return DashFavAdd()">SUBMIT</button>
        	<button type="button" class="btn btn-danger btn-sm delete" data-dismiss="modal">CLOSE</button>
        	</form>
        
      	</div>
      
    
      	
       
      </div>
 
     
    </div>
  </div>
</div>


	
	<script type="text/javascript">			
	function showDashboardProjectModal(){
	$('#DashboardProjectModal').modal('show');
	
	// Select the "Main Project" checkbox and trigger the change event to select all projects
    $('#mainProject').prop('checked', true).trigger('change');
    $('#subProject').prop('checked', true).trigger('change');
}
	
	function DashFavAdd(){
		var projectArray=[];
		 $("input:checkbox[name=projectId]:checked").each(function() { 
			 projectArray.push($(this).val()); 
	     }); 
		 
		 
		 if(projectArray.length==0){
			 alert("Please, select some projects!")
			 return false;
		 }
		 $('#projects').val(projectArray)
		 
		 
	 if(confirm('Are you sure to submit?')){
			 
		 }else{
			 console.log(projectArray);
			 event.preventDefault();
			 return false;
		 }
	}
	
	
	
	
/* 	// Function to select/deselect all projects when "Main projects" is clicked */
	$('#mainProject').change(function() {
	    var isChecked = $(this).is(':checked');
	   /*  $('input[name="projectId"]').prop('checked', isChecked); */
	    $('input:checkbox.mainProject').prop('checked', isChecked);
	});
	$('#subProject').change(function() {
	    var isChecked = $(this).is(':checked');
	   /*  $('input[name="projectId"]').prop('checked', isChecked); */
	    $('input:checkbox.subProject').prop('checked', isChecked);
	});
	
	</script>
	
	
	
	
	
	<script>
	  jQuery(document).ready(function($) {
    	  $("#btn-export").click(function(event) {
    	    $("#source-html").wordExport("");
    	  });
    	});
	</script>			
			
					  
						
						  
<script>

var editor_config = {
		maxlength: '4000',
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
			height: 300,
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
				{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } },

	]
			
		} ;
		
	CKEDITOR.replace('ckeditor', editor_config );
	CKEDITOR.replace('Editor1', editor_config);


	$(document).ready(function() {
		var locked=0;
		   var editAbstract=CKEDITOR.instances.ckeditor;
		   editAbstract.on("key",function(e) {      
		      var maxLength=e.editor.config.maxlength;
		      e.editor.document.on("keyup",function() {KeyUp(e.editor,maxLength,"letterCount",e);});
		      e.editor.document.on("paste",function() {KeyUp(e.editor,maxLength,"letterCount",e);});
		      e.editor.document.on("blur",function() {KeyUp(e.editor,maxLength,"letterCount",e);});
		   },editAbstract.element.$);
		   //function to handle the count check
		   function KeyUp(editorID,maxLimit,infoID,editor) 
		   {
			   var text=editor.editor.getData().replace(/<("[^"]*"|'[^']*'|[^'">])*>/gi, '').replace(/^\s+|\s+$/g, '');
			   $("#"+infoID).text(text.length);
			   if( text.length  >= maxLimit )
			   {
			      if ( !locked )
			      {
			    	 // Record the last legal content.
			         editAbstract.fire('saveSnapshot'), 
			         locked = 1;			                      
			         editor.cancel();			         
			      }
			      else if( text.length > maxLimit ){ // Rollback the illegal one.
			    	 alert('Cannot Insert content longer than '+maxLimit+' Characters');
			         editAbstract.execCommand( 'undo' );			         
			      }
			      else{
			    	  locked = 0;
			      }
			   }
		   }   
		});
	
	function EditData(MilestoneActivityId){
		
		var ActivityName = $('#text'+MilestoneActivityId).val().trim();
		
		console.log(ActivityName.length)
		
		if(ActivityName.length>=1000){
			alert("ActivityName length should be less than 1000")
			event.preventDefault();
			return false;
		}
		if(ActivityName.length==0){
			alert("ActivityName can not be empty")
			event.preventDefault();
			return false;
		}
		
		console.log(ActivityName)
		console.log(MilestoneActivityId)
		
		if(confirm('Are you sure to update Activity?')){
		$.ajax({
			type:'GET',
			url:'MilestoneActivityNameUpdate.htm',
			dataype:'json',
			data:{
				MilestoneActivityId:MilestoneActivityId,
				ActivityName:ActivityName,
			},
			success :  function(result) {
				
				var ajaxresult = JSON.parse(result);
				console.log(ajaxresult);
				if(ajaxresult>0){
					alert("Activitiy Updated successfully")
				}else{
					alert("Activitiy Update unsuccessful")
				}
				
			}
		})
		}else{
			event.preventDefault();
			return false;
		}
	}
	
	
	var editor_config1 = {
		    maxlength: '4000',
		    toolbar: [
		        {
		            name: 'basicstyles',
		            items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
		        },
		        {
		            name: 'insert',
		            items: ['Image', 'Table']
		        },
		        {
		            name: 'editing',
		            items: ['Scayt']
		        },
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
		    ],
		    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',
		    customConfig: '',
		    disallowedContent: 'img{width,height,float}',
		    extraAllowedContent: 'img[width,height,align]',
		    height: 100,
		    contentsCss: [CKEDITOR.basePath + 'mystyles.css'],
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
		        { name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } },
		    ],
		    // Ensuring pressing "Enter" inserts <p> instead of <br>
		    enterMode: CKEDITOR.ENTER_P,
		    shiftEnterMode: CKEDITOR.ENTER_P,
		    
		    // Clean up unwanted <br> tags
		    removeEmpty: ['br'],
		    removeFormat: true,

		    // Optionally, define a specific class for paragraphs to remove unwanted margins
		    contentsCss: [CKEDITOR.basePath + 'mystyles.css'],
		};
	 
	 function update(ele){
		 var MilestoneActivityId = ele.value;
		 var ActivityName = $('#text'+MilestoneActivityId).val().trim();
		 console.log("ActivityName--"+ActivityName)
		 var isChecked=Number(ele.checked);
			$.ajax({
				type:'GET',
				url:'MilestoneActivityNameUpdate.htm',
				dataype:'json',
				data:{
					MilestoneActivityId:MilestoneActivityId,
					ActivityName:ActivityName,
					isChecked:isChecked,
					ProjectId:<%=Project%>
				},
				success :  function(result) {
					
					var ajaxresult = JSON.parse(result);
					console.log(ajaxresult);
				/* 	if(ajaxresult>0){
						alert("Activitiy Updated successfully")
					}else{
						alert("Activitiy Update unsuccessful")
					} */
					
				}
			})
		 
	 }
	 $(function () {
			$('[data-toggle="tooltip"]').tooltip()
			})


	 
	 function showModal(a){
		 if(a!=='N'){
		 $('#largeModal').modal('show');
		 }else{
			 $('#largeModal1').modal('show');
		 }
	 }
	 
	 
	 
	 function updateAll(ActivityFor){
		 
		 if(ActivityFor==='P'){
		  var checkboxes = document.getElementsByName('ActivityId');
		 }else{
			 var checkboxes = document.getElementsByName('ActivityIdS');
		 }
		  
		  const checkedValues = [];
			var count=0;
		    // Loop through checkboxes to get their values if checked
		    for (var checkbox of checkboxes) {
		         var value = checkbox.checked?"1":"0"
		            checkedValues.push(checkbox.value+","+value);
		        
		    }
		   
		    console.log(ActivityFor+"-"+checkedValues)
		    if(confirm('Are you sure to update ?')){
		    for(var i=0;i<checkedValues.length;i++){
		    	
		    	var values = checkedValues[i].split(",");
		    	var MilestoneActivityId = values[0];
		    	var isChecked=values[1];
		    	 if(ActivityFor==='P'){
		    	var ActivityName = $('#text'+MilestoneActivityId).val().trim();
		    	 }else{
				    	var ActivityName = $('#textNext'+MilestoneActivityId).val().trim();

		    	 }
		    	$.ajax({
				type:'GET',
				url:'MilestoneActivityNameUpdate.htm',
				dataype:'json',
				data:{
					MilestoneActivityId:MilestoneActivityId,
					ActivityName:ActivityName,
					isChecked:isChecked,
					ProjectId:<%=Project%>,
					ActivityFor:ActivityFor,
				},
				success :  function(result) {
					
					var ajaxresult = JSON.parse(result);
					
				
				
					
				}
			})
		    	if(i==checkedValues.length-1){
		    		count=1;
		    	}
		    }
		    }else{
		    	event.preventDefault();
		    	return false;
		    }
		    
		    if(count>0){
		    	alert("Activities Updated successfully !")
		    	location.reload();
		    }
		    
		    
		   
	 }
	 
	 function submitIntroduction(){
		 
		var  introduction = $('#introduction').val();
		
		if(confirm("Are you sure to submit?")){
		
		$.ajax({
			type:'GET',
			url:'LabReportIntroductionSubmit.htm',
			data:{
				introduction:introduction,
				Project:<%=Project%>,
			},
			datatype:'json',
			success :  function(result) {
				
				var ajaxresult = JSON.parse(result);
				
				 if(ajaxresult>0){
				    	alert("Introduction added successfully !")
				    	location.reload();
				    }
			}
		})
		}else{
			event.preventDefault();
			return false;
		}
	 }
</script>
	
	
			
</body>
</html>