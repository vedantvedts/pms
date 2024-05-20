		<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>PROJECT INT  LIST</title>

<spring:url value="/resources/css/projectdetails.css" var="projetdetailscss" />
<link href="${projetdetailscss}" rel="stylesheet" />

<style type="text/css">

/* .container-fluid  {
overflow-x: auto;
} */
#initiation  {
padding-left:0px;
}

#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 11%;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 15px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 10px;
	border-radius: 4px;
}
.addreq {
	margin-left: -10%;
	margin-top: 5%;
}
.column p{
	padding: 0px !important;
}
#MyTable1>thead{
    background: #055C9D;
    color: white;
    font-weight: 800;
    font-size: 1rem;
}
#MyTable1:hover{
box-shadow: 2px 2px 2px gray;
margin:8px;
}
#modalreqheader {
	background: #145374;
	height: 44px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}
input[type=radio] {
 accent-color: green;
}
#scrollclass::-webkit-scrollbar {
    width:7px;
}
#scrollclass::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
#scrollclass::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}
.sidelabel{
font-weight:600;
font-size: 15px;
color:#145374;
}
.tab-pane p{
	text-align: justify;
	
}

.card-body{
	padding: 0rem !important;
}
.navigation_btn{
	margin: 1%;
}

 .b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}

.lab_add{
	background-color: #ebecf1;
	padding: 0px !important;
	outline: none !important;
	border: none !important;
	font-family: 'Muli',sans-serif !important;
	font-size: 15px;
	background-color: #ebecf1 !important;
	font-weight: 400;
	font-style: italic;
}
.requirement{
background-color:#80d8ff;
padding:0px 5px 0px 5px; 
border-radius:5px;
height:36px;
}
#reqbtn{
font-weight: 800;
margin-right:16px;
margin-top:3px;
color:buttonshadow;
font-family: 'Montserrat', sans-serif;
}
#addreq{
width:40%;
}
.modalbtn{
font-family: "Montserrat", "Helvetica Neue", Arial, sans-serif !important;
font-weight: 800 !important;
}
#reqmodal{
 width: 140%;
 margin-left: -164px;
 margin-top: 45px;
 }
.nav-link{
	text-align: left;
}
.nav-tabs>.nav-item>.nav-link{
	padding: 11px 15px !important;
}
/* .nav-tabs>.nav-item>#nav{
	padding: 0px 5px !important;
}
 */
body { 
   overflow-x: hidden;
}

.text-center{
	text-align: left !imporatant;
}
#req{
background-color: rgba(50, 115, 220, 0.3);
margin-top:7px;
border-radius:5px;
 height:28px; 

}
#reqbtn1{  

margin-top: 1%;

 font-size:13px;

}
.reqtable::-webkit-scrollbar{
display:none;
}
#reqbtn2{
 float:left;
 height:20px;
margin-left: 20%;
 margin-top:4px;
 font-size:13px;
 width:30px;

}
s/

/*  .table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
} */



/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
} */
#reqaction{
display:flex;
align-items: center;
justify-content: center;
}

#modalbody{
border-radius: 10px;

}
#modalbody:hover{
box-shadow: 4px 4px 4px gray;
margin:30px;
}
.modals{
box-shadow: 2px 2px 2px gray;
}
</style>
</head>
<body>
<%
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes"); 
Object[] ProjectProgressCount=(Object[])request.getAttribute("ProjectProgressCount"); 
String TabId=(String)request.getAttribute("TabId"); 
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");  
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList"); 
Map<String,List<Object[]>> BudgetItemMapList=(Map<String,List<Object[]>>)request.getAttribute("BudgetItemMapList");
NFormatConvertion nfc=new NFormatConvertion();
List<Object[]> IntiationAttachment=(List<Object[]>)request.getAttribute("IntiationAttachment"); 
List<Object[]> AuthorityAttachment=(List<Object[]>)request.getAttribute("AuthorityAttachment"); 
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String Details=(String)request.getAttribute("Details");
String DetailsEdit=(String)request.getAttribute("DetailsEdit");
/* List<Object[]>ReqTypeList=(List<Object[]>)request.getAttribute("reqTypeList");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList"); */
List<Object[]>DemandList=(List<Object[]>)request.getAttribute("DemandList");
//Object[]SQRFile=(Object[])request.getAttribute("SQRFile");
%>


<!-- Old tabs -->


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<div align="center" >
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center" >
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </div>
    
    
 <%} %>
	<div align="center"  id="successdiv" style="display:None"> 
	<div class="alert alert-success" id="divalert"  role="alert">Data Edited Successfully.</div>
	</div>

<!--  new tabs-->


<div class="container-fluid">
  
  <div class="row">
    <div class="col-md-12">
    
<%--      <p class="category">Initiation Details <span style="color: #335d2d">( Project Title :&nbsp;<%=ProjectDetailes[7] %> (<%=ProjectDetailes[6] %>) )</span></p> 
 --%>      
      <!-- Nav tabs -->
      
      <div class="card slider">
      
      
        <div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 130px;
        
        
        ">
        
             <h3 class="category">Initiation Details 
             
             <%if(ProjectDetailes[17].toString().equalsIgnoreCase("N")){ %>
             
             	<span style="color: #335d2d">( Project Title :&nbsp; <%=ProjectDetailes[6] %> )</span> 
             
             <%}else{ %>
             
             	<span style="color: #335d2d">( Project Title :&nbsp;<%=ProjectDetailes[7] %> (<%=ProjectDetailes[6] %>) )</span> 
             
             <%} %>

             <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm" style="color: white!important; float: right;">BACK</a>
             
             <span class="mr-2" style="color: #335d2d;float:right;margin-top: 5px;"> <%if(ProjectDetailes[17].toString().equalsIgnoreCase("N")){ %> Main Project : <%=ProjectDetailes[16] %> &nbsp;&nbsp;&nbsp;&nbsp; <%} %> </span>
			 <span style="display:inline-block;float: right">
             <form action="#">
    			  <button type="submit" class="btn btn-sm" formmethod="GET" formaction="ProjectProposal.htm" formtarget="_blank" style="border:none"  data-toggle="tooltip" data-placement="bottom" title="Project Presentation"><img alt="" src="view/images/presentation.png" style="width:19px !important"></button>&nbsp;&nbsp;
				  <button type="submit" class="btn btn-sm" formmethod="GET" style="background: transparent" formtarget="_blank" formaction="ProposalPresentationDownload.htm" data-toggle="tooltip" data-placement="bottom" title="Project Presentation Download"><i class="fa fa-download fa-lg" aria-hidden="true"></i></button>&nbsp;&nbsp;
	 			  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				  <input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
							 
    			</form>
             </span>
             </h3> 
        <hr style=" margin: 0 !important;">
        
          <ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >
            <li class="nav-item" id="nav">
             <%if(TabId==null){ %> <a class="nav-link active " data-toggle="tab" href="#home" id="nav" role="tab"><%}else{ %>
               <a class="nav-link  " data-toggle="tab" href="#home" role="tab">
               <%} %>  
                <svg height="12pt" viewBox="-7 0 503 503.62701" width="15pt" ><path d="m289 338.503906 27.683594-4.488281c1.914062-.3125 3.878906 0 5.597656.898437l163.320312 85.546876c3.375 1.769531 5.265626 5.476562 4.714844 9.25-.546875 3.773437-3.417968 6.789062-7.160156 7.519531l-339.203125 66.230469c-2.527344.492187-5.140625-.117188-7.1875-1.683594l-132.921875-101.652344c-2.851562-2.179688-4.132812-5.847656-3.257812-9.328125s3.738281-6.109375 7.28125-6.679687l144.78125-23.425782zm0 0" fill="#7d6599"/><path d="m281.097656 376.230469 29.460938-4.8125c1.921875-.320313 3.894531-.003907 5.625.898437l62.085937 32.542969c3.375 1.769531 5.265625 5.480469 4.714844 9.253906-.550781 3.773438-3.425781 6.785157-7.167969 7.515625l-222.890625 43.476563c-2.523437.492187-5.140625-.117188-7.1875-1.679688l-53.894531-41.214843c-2.84375-2.175782-4.121094-5.839844-3.25-9.316407.871094-3.476562 3.730469-6.101562 7.265625-6.679687l73.925781-12.019532zm0 0" fill="#3d324c"/><path d="m14.226562 243.742188c1.25-1.097657 14.300782 5.648437 15.648438 6.242187 13.253906 5.828125 26.085938 12.578125 38.390625 20.210937 31.863281 19.5 58.582031 46.359376 77.914063 78.324219 15.730468 26.195313 27.640624 74.871094 65.664062 74.871094 18.214844 0 38.917969.589844 52.761719-13.304687 16.921875-17.003907 17.226562-41.820313 22.457031-63.773438 25.917969-103.535156 75.414062-199.675781 144.617188-280.929688 4.25-5.082031 8.566406-10.113281 12.941406-15.089843 8.886718-9.988281 18.316406-19.480469 28.242187-28.4375 1.347657-1.222657 3.683594-3.726563 6.46875-6.585938 2.550781-2.601562 3.277344-6.488281 1.835938-9.835937-1.4375-3.347656-4.757813-5.496094-8.402344-5.433594-57.191406 1.816406-193.269531 31.753906-269.90625 261.707031 0 0-116.773437-80.84375-188.632813-17.964843zm0 0" fill="#4fba6f"/><g fill="#71c285"><path d="m301.667969 162.898438c-1.523438 0-3.019531-.386719-4.347657-1.132813-4.335937-2.40625-5.898437-7.871094-3.496093-12.207031 45.730469-82.324219 100.363281-110.320313 102.632812-111.472656 4.4375-2.230469 9.839844-.445313 12.074219 3.988281 2.230469 4.4375.445312 9.839843-3.988281 12.074219-.683594.347656-52.222657 27.152343-94.988281 104.125-1.589844 2.863281-4.613282 4.636718-7.886719 4.625zm0 0"/><path d="m274.71875 207.808594c-3.113281 0-6-1.613282-7.636719-4.257813-1.636719-2.648437-1.785156-5.953125-.394531-8.738281l8.984375-17.964844c1.433594-2.871094 4.292969-4.757812 7.496094-4.949218 3.207031-.191407 6.269531 1.339843 8.035156 4.019531 1.769531 2.679687 1.972656 6.097656.539063 8.96875l-8.984376 17.964843c-1.523437 3.042969-4.636718 4.960938-8.039062 4.957032zm0 0"/></g></svg>
                 &nbsp;INITIATION
              </a>
            </li>
            
            
            
             <li class="nav-item"   >
             
             <%if(Integer.parseInt(ProjectProgressCount[4].toString())>0){ %>
              
                  <%if(TabId!=null&&TabId.equalsIgnoreCase("4")){ %>
              <a class="nav-link active" data-toggle="tab" href="#authority" id="nav"role="tab" >
              <%}else{ %>
              <a class="nav-link" data-toggle="tab" href="#authority" role="tab" >
                <%} %>
                <img src="view/images/authority.png" style="vertical-align: sub;height: 22px;">
                  &nbsp; REFERENCE
              </a>
              <%}else{%>
              <form action="ProjectAuthorityAdd.htm" method="POST" id="AuthorityAdd">
                 <a class="nav-link condn-nav-link" data-toggle="tab" href="#" role="tab" onclick='$("#AuthorityAdd").submit()'>
                <img src="view/images/authority.png" style="vertical-align: sub;height: 22px;">
                  &nbsp;REFERENCE
              </a>
              	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
						<input type="hidden" name="option" value="add"/>
			 </form>	
             <%} %> 
            </li>

            <li class="nav-item"  >
             
             <%if(Integer.parseInt(ProjectProgressCount[0].toString())>0){ %>
              
                  <%if(TabId!=null&&TabId.equalsIgnoreCase("1")){ %>
              <a class="nav-link active" id="nav" data-toggle="tab" href="#profile" role="tab" >
              <%}else{ %>
              <a class="nav-link" data-toggle="tab" href="#profile" role="tab" >
                <%} %>
              
             
                <i class="fa fa-folder-open" aria-hidden="true" style="color:orange"></i>
				DETAILS
              </a>
              <%}else{%>
              <form action="ProjectOtherDetailsAdd.htm" method="POST" id="DetailsAdd">
                 <a class="nav-link condn-nav-link" data-toggle="tab" href="#" role="tab" onclick='$("#DetailsAdd").submit()'>
                <i class="fa fa-folder-open" aria-hidden="true" style="color:orange"></i>
				DETAILS
              </a>
              	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
						</form>	
             <%} %> 
            </li>
         
            <li class="nav-item" >
            <%if(Integer.parseInt(ProjectProgressCount[1].toString())>0){ %>
               <%if(TabId!=null&&TabId.equalsIgnoreCase("2")){ %>
              <a class="nav-link active" id="nav" data-toggle="tab" href="#messages" role="tab" >
              <%}else{ %>
              <a class="nav-link" data-toggle="tab" href="#messages" role="tab" >
                <%} %>
              
				<i class="fa fa-inr" aria-hidden="true" style="color:#005086"></i>
				 COST
              </a>
               <%}else{%>
               <form action="ProjectCostAdd.htm" method="POST" id="CostAdd">
                  <a class="nav-link condn-nav-link" data-toggle="tab" href="#messages" role="tab" onclick='$("#CostAdd").submit()'>
				<i class="fa fa-inr" aria-hidden="true" style="color:#005086"></i>
				 COST
              </a>
                   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
						</form>	
                <%} %>
            </li>
            <li class="nav-item" >
             <%if(Integer.parseInt(ProjectProgressCount[2].toString())>0){ %>
              <%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %>
              <a class="nav-link active" id="nav" data-toggle="tab" href="#settings" role="tab" >
              <%}else{ %>
              <a class="nav-link" data-toggle="tab" href="#settings" role="tab" >
                <%} %>
                <img src="view/images/myschedule.png" style="vertical-align: sub">
                 &nbsp;&nbsp;SCHEDULE
              </a>
               <%}else{%>
                <form action="ProjectScheduleAdd.htm" method="POST" id="ScheduleAdd">
                   <a class="nav-link  condn-nav-link" data-toggle="tab" href="#settings" role="tab" onclick='$("#ScheduleAdd").submit()'>
                <img src="view/images/myschedule.png" style="vertical-align: sub">
                 &nbsp;&nbsp;SCHEDULE
              </a>
                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
						</form>	
                <%} %>
            </li>
            
              <li class="nav-item" >
             <%if(Integer.parseInt(ProjectProgressCount[3].toString())>0){ %>
              <%if(TabId!=null&&TabId.equalsIgnoreCase("4")){ %>
              <a class="nav-link active" id="nav" data-toggle="tab" href="#attachment" role="tab" >
              <%}else{ %>
              <a class="nav-link" data-toggle="tab" href="#attachment" role="tab" >
                <%} %>
               <img src="view/images/file.png" style="vertical-align: sub">
                  &nbsp;&nbsp;ATTACHMENT
              </a>
               <%}else{%>
                <form action="ProjectAttachmentAdd.htm" method="POST" id="AttachmentAdd">
                   <a class="nav-link  condn-nav-link" data-toggle="tab" href="#attachment" role="tab" onclick='$("#AttachmentAdd").submit()'>
                <img src="view/images/file.png" style="vertical-align: sub">
                  &nbsp;&nbsp;ATTACHMENT
              </a>
                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
						</form>	
                <%} %>
            </li>
             <li class="nav-item" >
            </li>  
            
          </ul>
        </div>
        
        
        <div class="card-body">
          <!-- Tab panes -->
          <div class="tab-content text-center">
          
          
   <!-- *********** INITIATION  ***********      -->  
   
          
              <%if(TabId==null){ %> <div class="tab-pane active" id="home" role="tabpanel"><%}else{ %>
              <div class="tab-pane " id="home" role="tabpanel">
               <%} %>
            
				
				  <form action="ProjectLabAdd.htm" method="POST" name="myfrm" id="myfrm" >
				 		
					<div class="row" >
			 			<div class="col-md-12" style="margin-left: 60px">
			 			
							<div class="row details">
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;border-top-left-radius: 5px">
							    <h6>Project/Programme</h6>
							    <p><%if(ProjectDetailes[3]!=null){ if(ProjectDetailes[3].toString().equalsIgnoreCase("PRJ")){%> Project <%}if(ProjectDetailes[3].toString().equalsIgnoreCase("PGM")){ %>Program <% } }else{ %>-<%} %></p>
							  </div>
							   <div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Category</h6>
							    <p><%if(ProjectDetailes[4]!=null){%><%=ProjectDetailes[4] %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Security Classification</h6>
							    <p><%if(ProjectDetailes[5]!=null){%><%=ProjectDetailes[5] %><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column b" style="width:23%;border-bottom: 2px solid #394989;border-top-right-radius: 5px">
							    <h6>Planned</h6>
							    <p><%if(ProjectDetailes[10]!=null){ if(ProjectDetailes[10].toString().equalsIgnoreCase("P")){%>Plan<%}if(ProjectDetailes[10].toString().equalsIgnoreCase("N")){%>Non-Plan<%}}else{ %>-<%} %></p>
							  </div>
							</div>
							
							<div class="row details">
								<div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
								    <h6>Short Name</h6>
								    <p><%if(ProjectDetailes[6]!=null){%><%=ProjectDetailes[6] %><%}else{ %>-<%} %></p>
							  	</div>
								
								<div class="column a" style="width:69%;border-bottom: 2px solid #394989;">
								    <h6>Title</h6>
								    <p><%if(ProjectDetailes[7]!=null){%><%=ProjectDetailes[7] %><%}else{ %>-<%} %></p>
							  	</div>		
							</div>
							
							<div class="row details">
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Deliverable</h6>
							    <p><%if(ProjectDetailes[12]!=null && !ProjectDetailes[12].toString().equalsIgnoreCase("")){%>	<%=ProjectDetailes[12] %><%}else{ %>-<%} %></p>
							  </div>
							   <div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
							   <div class="row">
							   	<div class="col">
							   		<h6>Fe Cost</h6>
							    	<p><%if(ProjectDetailes[14]!=null && Double.parseDouble(ProjectDetailes[14].toString().split("\\.")[0])>0 ){%>&#8377;  <%=nfc.convert(Double.parseDouble(ProjectDetailes[14].toString().split("\\.")[0])/100000)%> &nbsp;&nbsp;Lakhs <%}else{ %>&#8377;  0.00<%} %></p>
							   	</div>
							   	<div class="col">
							   		<h6>Re Cost</h6>
							    	<p><%if(ProjectDetailes[15]!=null && Double.parseDouble(ProjectDetailes[15].toString().split("\\.")[0]) >0){%> &#8377;  <%=nfc.convert(Double.parseDouble(ProjectDetailes[15].toString().split("\\.")[0])/100000)%>&nbsp;&nbsp;Lakhs<%}else{ %>&#8377;  0.00<%} %></p>
							   	</div>
							   </div>
							  </div>
							  <div class="column a" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Duration (Months)</h6>
							    <p><%if(ProjectDetailes[9]!=null){%><%=ProjectDetailes[9] %><%}else{ %>-<%} %></p>
							  </div>  
 							<div class="column b" style="width:23%;border-bottom: 2px solid #394989;">
							    <h6>Multi Lab</h6>
							    <p><%if(ProjectDetailes[11]!=null){ if(ProjectDetailes[11].toString().equalsIgnoreCase("Y")){%>
							    	Yes &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-link lab_add"  > <u>Click here to Add Lab</u> </button>  
							    	<%}if(ProjectDetailes[11].toString().equalsIgnoreCase("N")){%>No<%}}else{ %>-<%} %></p>
							  </div>
							</div>
							
							<div class="row details">
							  <div class="column b" style="width:23%;border-bottom: 4px solid #394989;border-bottom-left-radius: 5px">
							    <h6>PDD</h6>
							    <p><%if(ProjectDetailes[1]!=null){%>	<%=ProjectDetailes[1] %><%}else{ %>-<%} %></p>
							  </div>
							   <div class="column a" style="width:23%;border-bottom: 4px solid #394989;">
							   	<h6>Indicative Duration (Months)</h6>
							    <p><%if(ProjectDetailes[9]!=null && Integer.parseInt(ProjectDetailes[9].toString())>0){ %><%=ProjectDetailes[9]%><%}else if(ProjectDetailes[18]!=null){ %><%=ProjectDetailes[18]%><%}else{ %>-<%} %></p>
							  </div>
							  <div class="column b" style="width:23%;border-bottom: 4px solid #394989;">
							    <h6>Indicative Cost (&#8377;.) </h6> 	
							    <p><%if(ProjectDetailes[8]!=null && Double.parseDouble(ProjectDetailes[8].toString())>0){%><%=nfc.convert(Double.parseDouble( ProjectDetailes[8].toString())/100000 )%> &nbsp;&nbsp;Lakhs<%} else if(ProjectDetailes[20]!=null &&  Double.parseDouble( ProjectDetailes[20].toString())>0 ){%><%=nfc.convert(Double.parseDouble( ProjectDetailes[20].toString())/100000 )%>&nbsp;&nbsp;Lakhs<%}else{ %>-<%} %></p>
							  </div>  
 							<div class="column a" style="width:23%;border-bottom: 4px solid #394989;border-bottom-right-radius: 5px">
							    <h6>P&C Remarks</h6>
							    <p><%if(ProjectDetailes[19]!=null){%>	<%=ProjectDetailes[19] %><%}else{ %>-<%} %></p>
							  </div>
							</div>
			 		
			 			</div>
			 			
			 			
	 		
	 			</div>


	            <div style="text-align: right;margin-top: 30px;">
	           
						<div style="margin-top: 30px;" align="center">
							<%-- <%if(ProjectDetailes[11].toString().equalsIgnoreCase("Y")){%>
							 <button type="submit" class="btn btn-primary btn-sm add" >LAB ADD </button>
							 <%} %> --%>
							 <button type="submit" class="btn btn-warning btn-sm edit" formaction="ProjectIntiationEdit.htm"   >EDIT</button>&nbsp;&nbsp;
							 
							 <button type="submit" class="btn btn-warning btn-sm prints" formaction="ExecutiveSummaryDownload.htm" formtarget="_blank" formmethod="GET"  >Print Executive Summary</button>&nbsp;&nbsp;
							 
							 <button type="submit" class="btn btn-warning btn-sm prints" formaction="ProjectProposalDownload.htm" formtarget="_blank" formmethod="GET" >Print Project Proposal</button>&nbsp;&nbsp;
							 <button type="submit" class="btn btn-warning btn-sm prints" formaction="ProjectSanction.htm"  style="background:brown;border:none;"  data-toggle="tooltip" data-placement="top" style="background:" title="Project SOC"><img alt="" src="view/images/requirement.png" style="width:19px !important">&nbsp;SOC</button>
							<!-- <button type="button"  class="btn btn-sm prints bg-secondary" style="border:white;" onclick="showsqrModal()">SQR</button> -->
							<input type="hidden" name="project" value="<%=ProjectDetailes[0]+"/"+ProjectDetailes[6]+"/"+ProjectDetailes[7]%>">
						</div>	 	
					
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
          
          	</div>
          </form>
	           
	            <div class="navigation_btn"  style="text-align: right;">
            		<a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm" style="color: white!important">Back</a>
					<button class="btn btn-info btn-sm next">Next</button>
				</div>
          
            </div>
            
            
 <!-- ***************************************** AUTHORITY ************************************ -->     
            
             <%if(TabId!=null&&TabId.equalsIgnoreCase("5")){ %>
               <div class="tab-pane active" id="authority" role="tabpanel">
              <%}else{ %>
              <div class="tab-pane" id="authority" role="tabpanel">
                <%} %>
            
          
                <div class="table-responsive" style="width: 97%; margin-left: 24px;">
				                    <table class="table">
				                       <thead class="thead" style="color:white!important;background-color: #055C9D">
				                            <tr>
				                            <th scope="col" >Reference Authority</th>
				                            <th scope="col" >Reference Date</th>
				                            <th scope="col" >Reference Number</th>
				                            <th scope="col">Download</th>
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%if(AuthorityAttachment.size()>0){ %>
				                        
				                        
				                        	<%for(Object[] 	obj:AuthorityAttachment){ %>
				                            <tr>
				                             
				                                <td>
				                                	<%if(obj[2].toString().equals("1")) {%> DRDO-HQ<%}else
				                                		if(obj[2].toString().equals("2")) {%> Secy DRDO<%}else
				                                			if(obj[2].toString().equals("3")) {%> Director General <%}else
				                                				if(obj[2].toString().equals("4")) {%> Director <%}else
				                                					if(obj[2].toString().equals("5")) {%> Centre Head <%}else
				                                						if(obj[2].toString().equals("6")) {%> User Army <%}else
				                                							if(obj[2].toString().equals("7")) {%> User Airforce <%}else
				                                								if(obj[2].toString().equals("8")) {%> User Navy <%}else
				                                									if(obj[2].toString().equals("9")) {%> ADA <%}else
				                                	
				                                	
				                                	{ %> -<%} %>
				                               
				                                
				                                </td>
				                                <td><%=sdf.format(obj[3])%></td>
				                                <td><%=obj[4] %></td>
				                               	<td>
				                               		<div >
				                               			<a  href="ProjectAuthorityDownload.htm?AuthorityFileId=<%=obj[7]%>" target="_blank"><i class="fa fa-download"></i>
				                               			</a>
				                               		</div> 
				                               </td>

				                            </tr>
				                            
				                             	<%} %> 	
				                             	
				                             	<%}else{ %>
				                             	
						                             		
						                           <tr>
						                           		<td colspan="4" style="text-align: center">
						                           			No Data !
						                           		</td>
						                           </tr>
				                             	
				                             	<%} %>
				                           
				                        </tbody>
				                    </table>
				                </div>

							<form action="ProjectAuthorityAdd.htm" method="POST" name="myfrm4" id="myfrm4" >

							     <div style="text-align: right;margin-top: 30px;">
								           		
										<div style="margin-top: 30px;" align="center">
										  <%if(Integer.parseInt(ProjectProgressCount[4].toString())>0){ %>
										
											<button type="submit" class="btn  btn-sm edit" >Edit</button>&nbsp;&nbsp;
											<%}else{ %>
												<button type="submit" class="btn  btn-sm add" >Add</button>&nbsp;&nbsp;
											<%} %>
										</div>	 					
												
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
									<input type="hidden" name="option" value="edit"/>
							          
							    </div>
          					</form>

				            <div class="navigation_btn"  style="text-align: right;">
				           
								<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>	
								<button class="btn btn-info btn-sm next">Next</button>
								
							</div>
				
				
            	
            	</div>
            
            
 
 
 
 
  <!-- ***************************************** AUTHORITY END ************************************ -->           
            
            
            
 <!-- *********** DETAILS  ***********      -->             
            
                  <%if(TabId!=null&&TabId.equalsIgnoreCase("1")){ %>
               <div class="tab-pane active" id="profile" role="tabpanel">
              <%}else{ %>
              <div class="tab-pane" id="profile" role="tabpanel">
                <%} %>
            
            <!-- 	<div style="text-align: right;margin-bottom: 20px;margin-top: -35px">
            		<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
					<button class="btn btn-info btn-sm next">Next</button>
				</div> -->
            

             <div class="container-fluid">
		        <div class="row">
		            <div class="col-md-12 details_container">
						        <div class="tab-vertical">
       						 <%for(Object[] 	obj:DetailsList){ %> 
       						
						            <ul class="nav nav-tabs" id="myTab3" role="tablist">
						            
						            		<li class="nav-item"> 
						                
						                	<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("needofProject")){ %> active <%} %> <%if(Details==null){ %> active <%} %> " id="needofprj-vertical-tab" data-toggle="tab" href="#needofprj-vertical" role="tab" aria-controls="home" aria-selected="true">
						                		Need of Project <img src="view/images/check.png" align="right">
						                	</a> 
						                	
						                </li> 
						            
						              
						            
						            	<li class="nav-item">

						                   <%if(obj[13]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("requirement")){ %> active <%} %>  " id="req-vertical-tab" data-toggle="tab" href="#req-vertical" role="tab" aria-controls="contact" aria-selected="false">Requirement <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="Requirement">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#req-vertical" role="tab" onclick='$("#Requirement").submit()'>
                 									Requirement
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="Requirement"/>
											</form>	 
										
										
										<%} %>		                
					</li>

						                
						                <li class="nav-item">
						                <%if(obj[12]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("worldscenario")){ %> active <%} %> " id="worldscenario-vertical-tab" data-toggle="tab" href="#worldscenario-vertical" role="tab" aria-controls="contact" aria-selected="false">World Scenario 
						            		<img src="view/images/check.png" align="right"></a>
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="worldscenario">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#worldscenario-vertical" role="tab" onclick='$("#worldscenario").submit()'>
                 									World Scenario
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="worldscenario"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[1]!=null){ %> 
											
							                 <a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("objective")){ %> active <%} %>" id="obj-vertical-tab" data-toggle="tab" href="#obj-vertical" role="tab" aria-controls="profile" aria-selected="false"> Objective <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="ObjectiveAdd">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#obj-vertical" role="tab" onclick='$("#ObjectiveAdd").submit()'>
                 									Objective
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="objective"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[2]!=null){ %> 
											
						                	<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("scope")){ %> active <%} %> " id="scope-vertical-tab" data-toggle="tab" href="#scope-vertical" role="tab" aria-controls="contact" aria-selected="false">Scope <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="ScopeAdd">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#scope-vertical" role="tab" onclick='$("#ScopeAdd").submit()'>
                 									Scope
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="scope"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[3]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("multilab")){ %> active <%} %> " id="multilab-vertical-tab" data-toggle="tab" href="#multilab-vertical" role="tab" aria-controls="contact" aria-selected="false">Multi Lab Work Share <img src="view/images/check.png" align="right"></a>
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="MultiAdd">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#multilab-vertical" role="tab" onclick='$("#MultiAdd").submit()'>
                 									Multi Lab Work Share
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="multilab"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[4]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("earlierwork")){ %> active <%} %> " id="earlierwork-vertical-tab" data-toggle="tab" href="#earlierwork-vertical" role="tab" aria-controls="contact" aria-selected="false">Earlier Work <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="EarlierWork">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#earlierwork-vertical" role="tab" onclick='$("#EarlierWork").submit()'>
                 									Earlier Work
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="earlierwork"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[5]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("competency")){ %> active <%} %> " id="competency-vertical-tab" data-toggle="tab" href="#competency-vertical" role="tab" aria-controls="contact" aria-selected="false">Competency <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="CompetencyEstablished">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#competency-vertical" role="tab" onclick='$("#CompetencyEstablished").submit()'>
                 									Competency 
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="competency"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                						                
						                <li class="nav-item">
						                <%if(obj[7]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("technology")){ %> active <%} %> " id="technology-vertical-tab" data-toggle="tab" href="#technology-vertical" role="tab" aria-controls="contact" aria-selected="false">Technology Challenges <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="Technology">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#technology-vertical" role="tab" onclick='$("#Technology").submit()'>
                 									Technology Challenges
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="technology"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[8]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("riskmitigation")){ %> active <%} %> " id="risk-vertical-tab" data-toggle="tab" href="#risk-vertical" role="tab" aria-controls="contact" aria-selected="false">Risk Mitigation <img src="view/images/check.png" align="right"></a> 
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="Risk">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#risk-vertical" role="tab" onclick='$("#Risk").submit()'>
                 									Risk Mitigation
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="riskmitigation"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[9]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("proposal")){ %> active <%} %> " id="proposal-vertical-tab" data-toggle="tab" href="#proposal-vertical" role="tab" aria-controls="contact" aria-selected="false">Proposal <img src="view/images/check.png" align="right"></a>
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="Proposal">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#proposal-vertical" role="tab" onclick='$("#Proposal").submit()'>
                 									Proposal
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="proposal"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>
						                
						                <li class="nav-item">
						                <%if(obj[10]!=null){ %> 
											
						            		<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("realization")){ %> active <%} %> " id="realization-vertical-tab" data-toggle="tab" href="#realization-vertical" role="tab" aria-controls="contact" aria-selected="false">Realization Plan <img src="view/images/check.png" align="right"></a>
							                
										 <%}
						                else{ %>
										
											<form action="ProjectOtherDetailsAdd.htm" method="POST" id="realizationplan">
                   								<a class="nav-link  condn-nav-link" data-toggle="tab" href="#realization-vertical" role="tab" onclick='$("#realizationplan").submit()'>
                 									Realization Plan
              									</a>
                  								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details_param" value="realization"/>
											</form>	 
										
										
										<%} %>	 				                
						                </li>	

						            </ul>
						            
						            
						            
						           <div class="tab-content" id="myTabContent3">
						            
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("requirement")){ %> show active <%} %>  " id="req-vertical" role="tabpanel" aria-labelledby="req-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm" id="myForm">
                            	
				                            	<div class="row ">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Requirement</b></h4>
				                            		</div>
				                            		
					                   				<div class="col-md-2" style="margin-bottom: 2px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="requirement" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
											<div class="col-md-1"  id="initiation" ;style="padding-left:0px !important;" align="left">
 											<label style="margin-top:0px;  margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;" ><b>Brief</b></h5>
 											</label></div>
						                  
											<p><%if(obj[13]!=null){%><%=obj[13] %><%}else{ %>-<%} %></p>	
						                </div>
						                
						                
						                
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("objective")){ %> show active <%} %> " id="obj-vertical" role="tabpanel" aria-labelledby="obj-vertical-tab"> 
											<form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm1" id="myForm1">
                            
				                            	<div class="row ">
				                            		
				                            	<!-- 	<div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Objective</b></h4>
				                            		</div>
				                            	
					                   				<div class="col-md-2" >
														<button class="share-button" style="border: none;font-size:13px" form="myForm1" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm1">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="objective" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
											<%-- <p><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></p> --%>
											
													<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px; margin-bottom:0px;font-weight: 800; 	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;"><b>Brief</b></h5>
 											</label></div>
						                   
											<p><%if(obj[14]!=null){%><%=obj[14] %><%}else{ %>-<%} %></p>	
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px;margin-bottom:0px; margin-left:0px;font-weight: 800;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;" ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></p></div>
											
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("scope")){ %> show active <%} %> " id="scope-vertical" role="tabpanel" aria-labelledby="scope-vertical-tab">
						                    
											<form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm2" id="myForm2">
                            
				                            	<div class="row ">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Scope</b></h4>
				                            		</div>
				                            	
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm2" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm2">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="scope" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                			<%-- <p><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></p> --%>
                                					<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;"><b>Brief</b></h5>
 											</label></div>
						                 
											<p><%if(obj[15]!=null){%><%=obj[15] %><%}else{ %>-<%} %></p>
											<hr>
											<div class="col-md-1"  id="initiation"><label style="margin-top:0px; margin-left:0px; margin-bottom:0px;font-weight: 800;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;"  ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></p></div>

										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null && Details.equalsIgnoreCase("multilab")){ %> show active <%} %>" id="multilab-vertical" role="tabpanel" aria-labelledby="multilab-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm3" id="myForm3">
                            
				                            	<div class="row">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Multi-Lab Work Share	</b></h4>
				                            		</div>
				                            		
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm3" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm3">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="multilab" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                			<%-- <p><%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></p>	 --%>
                                					<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;"><b>Brief</b></h5>
 											</label></div>
						                    
											<p><%if(obj[16]!=null){%><%=obj[16] %><%}else{ %>-<%} %></p>
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px; margin-left:0px;margin-bottom:0px; font-weight: 800;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;" ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></p></div>			                
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("earlierwork")){ %> show active <%} %>" id="earlierwork-vertical" role="tabpanel" aria-labelledby="earlierwork-vertical-tab">
						                    
											<form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm4" id="myForm4">
                            
				                            	<div class="row">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Earlier Work</b></h4>
				                            		</div>
				                            		
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm4" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm4">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="earlierwork" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                			<%-- <p><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></p> --%>
                                						<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;" ><b>Brief</b></h5>
 											</label></div>
						                   
											<p><%if(obj[17]!=null){%><%=obj[17] %><%}else{ %>-<%} %></p>
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px; font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;" ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></p></div>	
                                			
                                									                
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("competency")){ %> show active <%} %> " id="competency-vertical" role="tabpanel" aria-labelledby="competency-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm5" id="myForm5">
                            
				                            	<div class="row ">
				                            		
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Competency</b></h4>
				                            		</div>
				                            	
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm5" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm5">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="competency" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                			<%-- <p><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></p> --%>
                                						<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px; 	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;"><b>Brief</b></h5>
 											</label></div>
						                  
											<%if(obj[18]!=null){%><p><%=obj[18] %></p><%}else{ %>-<%} %>
											<hr>
											<div class="col-md-1" id="initiation"><label style="margin-top:0px; margin-left:0px;font-weight: 800;margin-bottom:0px;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;" ><b>Detailed</b></h5></label></div>				                
											<div><%if(obj[5]!=null){%><p><%=obj[5] %></p><%}else{ %>-<%} %></div>		                
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("needofproject")){ %> show active <%} %> <%if(Details==null){ %> show active <%} %> " id="needofprj-vertical" role="tabpanel" aria-labelledby="needofprj-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm6" id="myForm6">
                            
				                            	<div class="row">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Need of Project</b></h4>
				                            		</div>
				                            	
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm6" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm6">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="needofproject" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
											<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;"><b>Brief</b></h5>
 											</label></div>
						                    
											<p><%if(obj[19]!=null){%><%=obj[19] %><%}else{ %>-<%} %></p>
											<hr>
											<div class="col-md-1" id="initiation"><label style="margin-top:0px; margin-left:0px;font-weight: 800;margin-bottom:0px;font-size: 20px; color:#07689f;"><h5  style="font-family: 'Lato',sans-serif;"><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[6]!=null){%><%=obj[6] %><%}else{ %>-<%} %></p></div>	
                                			
                                			<%-- <p><%if(obj[6]!=null){%><%=obj[6] %><%}else{ %>-<%} %></p>	 --%>				                
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("technology")){ %> show active <%} %> " id="technology-vertical" role="tabpanel" aria-labelledby="technology-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm7" id="myForm7">
                            
				                            	<div class="row">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Technology Challenges</b></h4>
				                            		</div>
				                            		
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm7" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm7">			 
														</button>
													</div>       			  	
				                            	</div>
	                            	
	                            				<hr>
	                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="technology" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                				<%-- <p><%if(obj[7]!=null){%><%=obj[7] %><%}else{ %>-<%} %></p>
                                									                 --%>
                                									                 
                                			<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;" ><b>Brief</b></h5>
 											</label></div>
						                  
											<p><%if(obj[20]!=null){%><%=obj[20] %><%}else{ %>-<%} %></p>	
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;" ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[7]!=null){%><%=obj[7] %><%}else{ %>-<%} %></p></div>	
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("riskmitigation")){ %> show active <%} %> " id="risk-vertical" role="tabpanel" aria-labelledby="risk-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm8" id="myForm8">
                            
				                            	<div class="row">
				                            	
				                            	<!-- 	<div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Risk Mitigation</b></h4>
				                            		</div>
				                            		
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm8" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm8">			 
														</button>
													</div>       			  	
				                            	</div>
                            	
                            					<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="riskmitigation" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                			<%-- <p><%if(obj[8]!=null){%><%=obj[8] %><%}else{ %>-<%} %></p> --%>	
                                			<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif;"  ><b>Brief</b></h5>
 											</label></div>
						                    
											<p><%if(obj[21]!=null){%><%=obj[21] %><%}else{ %>-<%} %></p>	
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px; margin-left:0px; margin-bottom:0px;font-weight: 800;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif;" ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[8]!=null){%><%=obj[8] %><%}else{ %>-<%} %></p></div>						                
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("proposal")){ %> show active <%} %> " id="proposal-vertical" role="tabpanel" aria-labelledby="proposal-vertical-tab">
						                   
						                   <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm9" id="myForm9">
                            
				                            	<div class="row">
				                            	
				                            	<!-- 	<div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Proposal</b></h4>
				                            		</div>
				                            		
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm9" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm9">			 
														</button>
													</div>       			  	
				                            	</div>
	                            	
	                            				<hr>
	                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="proposal" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                                		<%-- 	<p><%if(obj[9]!=null){%><%=obj[9] %><%}else{ %>-<%} %></p> --%>		
                                		
                                					<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800;margin-bottom:0px; 	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif"><b>Brief</b></h5>
 											</label></div>
						                  
											<p><%if(obj[22]!=null){%><%=obj[22] %><%}else{ %>-<%} %></p>	
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px; margin-left:0px; margin-bottom:0px;font-weight: 800;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif; " ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[9]!=null){%><%=obj[9] %><%}else{ %>-<%} %></p></div>	
                                						                
										</div>
										
										
										
						                <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("realization")){ %> show active <%} %> " id="realization-vertical" role="tabpanel" aria-labelledby="realization-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm10" id="myForm10">
                            
				                            	<div class="row">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Realization Plan</b></h4>
				                            		</div>
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm10" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm10">			 
														</button>
													</div>       			  	
				                            	</div>
	                            	
	                            				<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="realization" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
											<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif"><b>Brief</b></h5>
 											</label></div>
						                   
											<p><%if(obj[23]!=null){%><%=obj[23] %><%}else{ %>-<%} %></p>	
											<hr>
											<div class="col-md-1" id="initiation" ><label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif"><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[10]!=null){%><%=obj[10] %><%}else{ %>-<%} %></p></div>	
                               	 				
                               	 				<%-- <p><%if(obj[10]!=null){%><%=obj[10] %><%}else{ %>-<%} %></p> --%>						                
										</div>
										
										 <div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("worldscenario")){ %> show active <%} %>    " id="worldscenario-vertical" role="tabpanel" aria-labelledby="worldscenario-vertical-tab">
						                    
						                    <form action="ProjectInitiationDetailsEdit.htm" method="POST" name="myForm11" id="myForm11">
                            
				                            	<div class="row">
				                            	
				                            		<!-- <div class="col-md-1"></div> -->
				                            		<div class="col-md-10" align="left">
				                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>World Scenario</b></h4>
				                            		</div>
					                   				<div class="col-md-2" style="margin-bottom: 5px">
														<button class="share-button" style="border: none;font-size:13px" form="myForm11" >
											  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
											  				<input type="submit"  class="edit-btn" name="sub" value="EDIT" form="myForm11">			 
														</button>
													</div>       			  	
				                            	</div>
	                            	
	                            				<hr>
                            	
		                            			<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
												<input type="hidden" name="details" value="worldscenario" />
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	 
	
											</form>
								
                               	 				<%-- <p><%if(obj[12]!=null){%><%=obj[12] %><%}else{ %>-<%} %></p> --%>	
                               	 				
                               	 							<div class="col-md-1" id="initiation" align="left">
 											<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 											<h5 style="font-family: 'Lato',sans-serif"><b>Brief</b></h5>
 											</label></div>
						                  
											<p><%if(obj[24]!=null){%><%=obj[24] %><%}else{ %>-<%} %></p>	
											<hr>
											<div class="col-md-1" id="initiation"><label style="margin-top:0px; margin-left:0px;font-weight: 800;margin-bottom:0px;font-size: 20px; color:#07689f;"><h5 style="font-family: 'Lato',sans-serif" ><b>Detailed</b></h5></label></div>				                
											<div><p><%if(obj[12]!=null){%><%=obj[12] %><%}else{ %>-<%} %></p></div>						                
										</div>
										
										
										
						            </div>
						         <button onclick="scrollToTop()" id="scrollButton"
			data-toggle="tooltip" data-placement="top" data-original-data=""
			title="Go to Top">
			<i class="fa fa-arrow-up" aria-hidden="true"></i>
		</button>
						            <%} %>
						            
						        </div> <!-- tab-vertical ends -->

            	</div>
            
        </div>
    </div> 
						      
	           
	            <div class="navigation_btn"  style="text-align: right;">
            		<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
					<button class="btn btn-info btn-sm next">Next</button>
				</div>
            
            </div>
            
    			<!--Requirements  -->
                 <%if(TabId!=null&&TabId.equalsIgnoreCase("6")){ %>
               <div class="tab-pane active" id="requirement" role="tabpanel">
              	<%}else{ %>
 				<div class="tab-pane" id="requirement" role="tabpanel" style=" margin-top: -12px;">
                <%} %> 
                 <div class="container-fluid" style="margin-top:7px;">
		        <div class="row">
		            <div class="col-md-12 details_container">
						        <div class="tab-vertical">
						
				 <div class="table-responsive">
				<!--  <form action="ProjectRequirementUpdate.htm" method="POST" name="" id="myform5"> -->
				<%  int i=1;%>
				 <div class="reqtable" style="height: 300px; overflow: auto;border: 1px solid aliceblue; box-shadow: 2px 2px 5px lightgrey;">
	 			 <table class="table" id="myTableReq" style="<%if(i>4) {%> height: 270px;<%}%>"> 
	 			 <thead style="background-color: #055C9D;color:white; top:-2px; position: sticky;">
	 			 <tr >
<!-- 	 			  <th style="width: 5%;">Select</th> -->
				<th style="width: 3%; ">SN</th>
				<th style="width:8%" class="text-nowrap">ID</th>
				<!-- <th style="width:8%" class="text-nowrap">Requirement Type</th> -->
				<th style="width:70%" class="text-nowrap" >Brief</th>
				<th style="width:14%">Action</th>
			<!-- 	<th style="width:20%">ADD</th> -->
	 			 </table>
	 			</div>
	 			<hr>
				</form>	
				  <form action="ProjectRequirementAdd.htm" method="POST" id="ReqAdd">
                   					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>" />
				                  	  	 <button type="submit" class="btn btn-success " id="reqbtn" style="margin-left: 22px;">ADD
				                 	 </button>
				                  	</form>		
	 			</div>
	 
				 </div> 
						        </div>
						        </div>
						        </div>
						        
						        
                  <div class="navigation_btn"  style="text-align: right;">
            		<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
					<button class="btn btn-info btn-sm next">Next</button>
				</div>
                
                </div> 
                
            
  <!-- *********** COST  ***********      -->       
            
                       <%if(TabId!=null&&TabId.equalsIgnoreCase("2")){ %>
               <div class="tab-pane active" id="messages" role="tabpanel">
              <%}else{ %>
              <div class="tab-pane" id="messages" role="tabpanel">
                <%} %>
            
          
              <form action="ProjectCostAdd.htm" method="POST" name="myfrm" id="myfrm" >
				 	
				 	<div class="container-fluid">
				 	
				    <div class="row">
				    
				    
				        <div class="col-md-12">
				            <div class="card">
				               
				                <div class="table-responsive">
				                  <table class="table table-bordered table-hover table-striped table-condensed ">
                                        <thead style="background: #055C9D;color:white;">
                                         
                                            <tr>
                                                <th >Item</th>
                                                <th >Item Detail</th>
                                                <th >Cost (In Lakhs)</th>
                                                <th >Procurement Plan</th>
                                            </tr>
                                        </thead>
                                        
	    								<tbody>
	    								
						    	<%Double totalcost=0.0;
						    	for(Map.Entry<String, List<Object[]>> entry:BudgetItemMapList.entrySet()){ %>
	    	
	    	
	    									<tr>
	    										<td align="left">
	    											<b><%=entry.getKey()%></b>
	    										</td>
	    							
	    									</tr>
	    									
	    			    		<%Double cost=0.0;
									    for(Object[] 	obj:entry.getValue()){ 	    %>

											<tr>
		 										<td style="width: 500px; " align="left"> <%=obj[3] %> (<%=obj[6]%>) (<%=obj[7]%>)</td>
									    		<td style="width: 550px;" align="left"><%=obj[4] %></td>
									    		<td style="text-align: right">&#8377; <%=nfc.convert(Double.parseDouble(obj[5].toString().split("\\.")[0])/100000) %></td>
								 				<td align="center"><%-- <button type="button" class="btn btn-sm btn-success ml-2" onclick="showAddModal(<%=obj[0].toString()%>,<%=obj[5].toString()%>,<%=obj[1].toString()%>)">ADD</button>  --%>
								 				<button type="button" class="btn btn-sm btn-info ml-2" onclick="viewModal(<%=obj[0].toString()%>,<%=obj[5].toString()%>,<%=obj[1].toString()%>)" style="font-family: "Montserrat", "Helvetica Neue", Arial, sans-serif">VIEW</button></td>
								 			</tr>
								
									    <% cost=cost+Double.parseDouble(obj[5].toString()) ;
									    } totalcost=totalcost+cost; %>
									    
	    									<tr>
	    										<td colspan="2" style="text-align: right"><b style="color: green;"> <%=entry.getKey() %> Cost</b></td>
	    										<td  style="text-align: right"><b style="color: green; text-align: right;">&#8377; <%=nfc.convert(cost/100000) %></b></td>
	    										<td></td>
	    									</tr>
	
	    						<%} %>
	    	
								    		<tr>
								    			<td colspan="2" align="right"><b style="color: green;"> Total Cost</b></td>
								    			<td style="text-align: right"><b style="color: green;">&#8377; <%=nfc.convert(totalcost/100000) %>&nbsp;&nbsp;Lakhs</b></td>
								    			<td > </td>
								    		</tr>
							
									    </tbody>
	 
	    
                                    </table>
				                </div>
				            </div>
				        </div>
				      
				        
				    </div>
				    
				    </div>

       <div style="text-align: right;margin-top: 30px;">
	           
	           		<center>
						<div style="margin-top: 30px;">
						
							 <button type="submit" class="btn btn-warning btn-sm edit" >EDIT</button>&nbsp;&nbsp;
							 
						</div>	 
					</center>
					
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
          
          	</div>
          
          </form>

	            <div class="navigation_btn"  style="text-align: right">
	           
					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>	
					<button class="btn btn-info btn-sm next">Next</button>
				</div>
				
				
            	
            </div>
            
            
<!-- *********** SCHEDULE  ***********      -->      
            
            
                    <%if(TabId!=null&&TabId.equalsIgnoreCase("3")){ %>
               <div class="tab-pane active" id="settings" role="tabpanel">
              <%}else{ %>
              <div class="tab-pane" id="settings" role="tabpanel">
                <%} %> 
            
           	<form action="ProjectScheduleAdd.htm" method="POST" name="myfrm" id="myfrm" >
				 	
				    <div class="row">
				        <div class="col-12"  style="max-width: 97%;margin-left: 24px;">
				            <div class="card">
				               
				                <div class="table-responsive">
				                    <table class="table">
				                       <thead class="thead" style="color:white!important;background-color: #055C9D">
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox m-b-20"> <input type="checkbox" id="mainCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                            <th scope="col" >Milestone No</th>
				                                <th scope="col">Milestone Activity</th>
				                                <th scope="col">Milestone Month</th>
				                                <th scope="col">Remarks</th>
				                                
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%for(Object[] 	obj:ScheduleList){ %>
				                            <tr>
<!-- 				                                <th> <label class="customcheckbox"> <input type="checkbox" class="listCheckbox"> <span class="checkmark"></span> </label> </th>
 -->				                                     
				                                <td><%if(obj[0]!=null){%><%=obj[0] %><%}else{ %>-<%} %></td>
				                                <td align="left" ><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></td>
				                                <td><%if(obj[2]!=null){%><%="T"%><sub><%=obj[5].toString() %></sub><%="+"+obj[2] %><%}else{ %>-<%} %></td>
				                                 <td align="left"><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></td>
				                    
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                        </tbody>
				                    </table>
				                </div>
				            </div>
				        </div>
				    </div>

     <div style="text-align: right;margin-top: 30px;">
	           
	           		<center>
						<div style="margin-top: 30px;">
						
							 <button type="submit" class="btn btn-warning btn-sm edit" >EDIT</button>&nbsp;&nbsp;
							 
						</div>	 
					</center>
					
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
          
          	</div>

	           
				
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
          
          </form>
               <div class="navigation_btn"  style="text-align: right;">
	           
					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>	
					<button class="btn btn-info btn-sm next">Next</button>
				</div>
            
            </div>
            
            
            
            <!-- *********** ATTACHMENT  ***********      -->       
            
                       <%if(TabId!=null&&TabId.equalsIgnoreCase("4")){ %>
               <div class="tab-pane active" id="attachment" role="tabpanel">
              <%}else{ %>
              <div class="tab-pane" id="attachment" role="tabpanel">
                <%} %>
            
          
                <div class="table-responsive" style="width: 97%;margin-left: 24px;">
				                    <table class="table">
				                       <thead class="thead" style="color:white!important;background-color: #055C9D">
				                            <tr>
				                            <th scope="col" >File Name</th>
				                            <th scope="col" >Created By</th>
				                            <th scope="col" >Created Date</th>
				                            <th scope="col">Download</th>
				                            <th scope="col">Delete</th>   
				                            </tr>
				                        </thead>
				                        <tbody class="customtable">
				                        
				                        	<%if(IntiationAttachment.size()>0) {%>
				                        
				                        
				                        	<%for(Object[] 	obj:IntiationAttachment){ %>
				                            <tr>
				                                <td align="left">
				                                 	<form action="ProjectAttachmentEdit.htm" method="POST" name="myfrm5" id="myfrm5" >
				                    
				                    					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				      									<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
														<input type="hidden" name="InitiationAttachmentId"	value="<%=obj[0] %>" /> 
				 
				      									<button  type="submit" ><i class="fa fa-pencil-square-o "></i></button><%=obj[2] %>           	
				                 					</form>
				                 				</td>
				                                <td><%=obj[4]%></td>
				                                <td><%=sdf1.format(obj[5])%></td>
				                               <td><div ><a  href="ProjectAttachDownload.htm?InitiationAttachmentId=<%=obj[6]%>" target="_blank"><i class="fa fa-download"></i></a></div> </td>
				                   
				               <%--      <td>
				                    <form action="ProjectAttachmentEdit.htm" method="POST" name="myfrm5" id="myfrm5" >
				                    
				                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				         <input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
				<input type="hidden" name="InitiationAttachmentId"	value="<%=obj[0] %>" /> 
				            	
				                 	</form>   
				                    </td> --%>
				                   
				                   
				                    <td>
				                    	<form method="post" action="ProjectAttachmentDelete.htm">
				                    		<button type="submit" onclick="return confirm ('Are You Sure To Delete This File?');" ><i class="fa fa-trash "></i></button>
				                    		<input type="hidden" name="IntiationId" value="<%=ProjectDetailes[0] %>"/>
											<input type="hidden" name="InitiationAttachmentId" value="<%=obj[0]%>"/>		
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 		                    		
				                    	</form>
				                    </td>
				                           
				                           
				                            </tr>
				                            
				                             	<%} %> 	
				                           
				                           <%}else{ %>
				                           
				                           
				                           <tr>
				                           		<td colspan="5" style="text-align: center">
				                           			No Data !
				                           		</td>
				                           </tr>
				                           
				                           
				                           <%} %>
				                           
				                           
				                        </tbody>
				                    </table>
				                </div>

<form action="ProjectAttachmentAdd.htm" method="POST" name="myfrm4" id="myfrm4" >

     <div style="text-align: right;margin-top: 30px;">
	           
	           		<center>
						<div style="margin-top: 30px;">
						
							 <button type="submit" class="btn  btn-sm add" >Add</button>&nbsp;&nbsp;
							 
						</div>	 
					</center>
					
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				<input type="hidden" name="IntiationId"	value="<%=ProjectDetailes[0] %>" /> 
          
          	</div>
          	</form>

	            <div class="navigation_btn"  style="text-align: right;">
	           
					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>	
					
				</div>
				
				
            	
            </div>  
            
            
          </div>
        </div>

      </div><!-- card end -->
    </div>
    </div>

  </div>
</div>

</div>
</div>
</div>
</div>


</div>
<!-- 	<form class="form-horizontal" role="form"
		action="ProjectProcurementSubmit.htm" method="POST" id="myform1"> -->
		<div class="modal fade bd-example-modal-lg" id="procurementModal"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Procurement
							Plan</h5>
							<h6 class="mt-3 ml-5" id="addBugetLeft" style="margin-left: 40% !important;"></h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="color: white" id="cross2">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="col-md-12">
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Item:</label><span class="mandatory" style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Item" name="Item"
										maxlength="300" >
								</div>
							</div>
							<input type="hidden" id="InitiationCostId" value="0">
							<input type="hidden" id="initiationid" value="0">
							<input type="hidden" id="totabudgetcost" value="0">
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Purpose:</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Purpose"
										name="Purpose" maxlength="450" style="line-height: 3rem"
										required="required">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Source:</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Source"
										name="Source" maxlength="300" required="required">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Mode:</label><span class="mandatory" style="color: red;">*</span>
								</div>
								<div class="col-md-5">
									<div class="form-group">


										<select class="form-control" name="Mode" id="Mode"
											data-width="80%" data-live-search="true">
											<option value="" disabled="disabled" value="" selected="selected">---Choose----</option>
											<%
											for (Object[] obj : DemandList) {
											%>
											<option value="<%=obj[1]%>"><%=obj[2]%></option>
											<%
											}
											%>
										</select> 

									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Cost (in &#8377;):</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-3">
									<input type="text" id="cost" class="form-control" name="cost"
										placeholder="0.0" required="required" onchange="balanceCheck()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-3 label">
									<label class="sidelabel">EPC Approval required</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-2" >
									<input type="radio" name="Approved" value="Y" id="Approve"	>
									&nbsp;YES <input style="margin-left: 15px;" type="radio"
									id="Approve"	name="Approved" value="N" checked> &nbsp;NO
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-6 label">
									<label class="sidelabel">Estimated months after Project Sanction Date
										&nbsp;&nbsp;(T<sub>0</sub>)
									</label>
									<hr style="margin-left: 0% !important; width: 80%">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-1 label">
									<label class="sidelabel">Demand:</label>
								</div>
								<div class="col-md-2">
									<input style="width: 59%;" type="text" id="Demand"
										class="form-control" name="Demand" placeholder="Months" value="0"
										required="required"  onchange="showcostvalues()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-1 label">
									<label class="sidelabel">Tender:</label>
								</div>
								<div class="col-md-2">
									<input type="text" style="width: 59%;" id="Tender" value="0" readonly
										class="form-control" name="Tender" placeholder="Months" onchange="checKDemand()"
										required="required"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-1 label">
									<label class="sidelabel">Order:</label>
								</div>
								<div class="col-md-2">
									<input type="text" id="Order" style="width: 59%;" value="0" readonly
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
										class="form-control" name="Order" placeholder="Months"
										required="required"onchange="chechKTender()">
								</div>
								<div class="col-md-1 label">
									<label class="sidelabel">Payment:</label>
								</div>
								<div class="col-md-2">
									<input type="text" style="width: 59%;" id="Payout" readonly
										class="form-control" value="0" name="Payout" placeholder="Months"
										required="required" onchange="chechkOrder()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
							</div>

						<%-- 	<input type="hidden" name="IntiationId"
								value="<%=initiationid %>" /> <input type="hidden"
								name="projectshortName" value="<%=projectshortName %>" /> --%>
							<div class="form-group" align="center" style="margin-top: 3%;">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<button type="submit" class="btn btn-primary btn-sm submit"
									id="add" name="action" value="SUBMIT"
									onclick="submitProcurementPlan()">SUBMIT</button>

							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>

<!-- 	</form>
 -->
 						<div class="modal fade bd-example-modal-lg" id="ProcurementList"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 150%;margin-left: -25%">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Procurement Plan</h5>
							<h6 class="ml-5 mt-3"  id="totalBudget"></h6>
							<h6 class="ml-5 mt-3"  id="BudgetAdded">Expenditure Done-&#8377;0.00 Lakhs</h6>
							<h6 class="ml-5 mt-3"  id="Budgetleft">Expenditure left-&#8377;0.00 Lakhs</h6>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross1">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<input type="hidden" id="maincost">
					<input type="hidden" id="planid" value=0>
					<div class="modal-body">
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:35%">Item</th>
					<th style="width:10%">Mode </th>
					<th style="width:15%">Source</th>
					<th style="width:10%">Cost</th>
					<th style="width:10%">Months</th>
					<th style="width:10%" align="left">EPC (Y/N)</th>
					</tr>
					</thead>
					<tbody id="tbody2">
					
					</tbody>
					</table>
					</div>
					</div>
					<div align="center" id="buttons">
					
					</div>
					</div>
					</div>
					</div>
					
			<!--Procurement Edit  -->		
					
						<div class="modal fade bd-example-modal-lg" id="procurementModalEdit"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Procurement
							Plan</h5>
							<h6 class="mt-3 ml-4" id="EditTotalBudget" style="margin-left: 40% !important;"></h6> 
							<h6 class="mt-3" id="EditPlannedBudget" ></h6> 
							<h6 id="values"></h6>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="color: white" id="cross3">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="col-md-12">
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Item:</label><span class="mandatory" style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Itemedit" name="Item"
										maxlength="300" >
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Purpose:</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Purposeedit"
										name="Purpose" maxlength="450" style="line-height: 3rem"
										required="required">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Source:</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Sourceedit"
										name="Source" maxlength="300" required="required">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Mode:</label><span class="mandatory" style="color: red;">*</span>
								</div>
								<div class="col-md-5">
									<div class="form-group">


										<select class="form-control" name="Mode" id="Modeedit"
											data-width="80%" data-live-search="true">
											<option value="" disabled="disabled" value="" selected="selected">---Choose----</option>
											<%
											for (Object[] obj : DemandList) {
											%>
											<option value="<%=obj[1]%>"><%=obj[2]%></option>
											<%
											}
											%>
										</select> 

									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label class="sidelabel">Cost (in &#8377;):</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-3">
									<input type="text" id="costedit" class="form-control" name="cost"
										placeholder="0.0" required="required" onchange="balanceCheckforEdit()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								<input type="hidden" id="previouscost">
								</div>
								<div class="col-md-3 label">
									<label class="sidelabel">EPC Approval required</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-2"  id="Approvededit">
<!-- 									<input type="radio" name="Approvededit" value="Y" id="Approve"	>
									&nbsp;YES <input style="margin-left: 15px;" type="radio"
									id="Approve"	name="Approvededit" value="N" checked> &nbsp;NO -->
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-6 label">
									<label class="sidelabel">Estimated months after Project Sanction Date
										&nbsp;&nbsp;(T<sub>0</sub>)
									</label>
									<hr style="margin-left: 0% !important; width: 80%">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-1 label">
									<label class="sidelabel">Demand:</label>
								</div>
								<div class="col-md-2">
									<input style="width: 59%;" type="text" id="Demandedit"
										class="form-control" name="Demand" placeholder="Months" value="0"
										required="required"  onchange="showcostvalues()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-1 label">
									<label class="sidelabel">Tender:</label>
								</div>
								<div class="col-md-2">
									<input type="text" style="width: 59%;" id="Tenderedit" value="0" 
										class="form-control" name="Tender" placeholder="Months" onchange="checKDemand()"
										required="required"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-1 label">
									<label class="sidelabel">Order:</label>
								</div>
								<div class="col-md-2">
									<input type="text" id="Orderedit" style="width: 59%;" value="0" 
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
										class="form-control" name="Order" placeholder="Months"
										required="required"onchange="chechKTender()">
								</div>
								<div class="col-md-1 label">
									<label class="sidelabel">Payment:</label>
								</div>
								<div class="col-md-2">
									<input type="text" style="width: 59%;" id="Payoutedit" 
										class="form-control" value="0" name="Payout" placeholder="Months"
										required="required" onchange="chechkOrder()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
							</div>

						<%-- 	<input type="hidden" name="IntiationId"
								value="<%=initiationid %>" /> <input type="hidden"
								name="projectshortName" value="<%=projectshortName %>" /> --%>
							<div class="form-group" align="center" style="margin-top: 3%;" id="editModal">
								<button type="submit" class="btn btn-primary btn-sm submit"id="" name="action" value="SUBMIT"onclick="EditProcurement()">SUBMIT</button>

							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	<%-- <div class="modal fade bd-example-modal-lg" id="sqrModal"tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" style="margin-left:-10%;width:120%;">
        <div class="modal-header" style="background: antiquewhite;">
        <h5 class="modal-title" id="exampleModalLabel" style="color:#07689f !important;">Staff Qualification Requirement</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hidemodalbody()">
          <span aria-hidden="true" style="color:red;">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <table class="table table-bordered" id="MyTable1">
      <thead>
      <tr style="text-align: center;">
      <th>SN</th>
      <th>User</th>
      <th>Ref No.</th>
      <th>Date</th>
      <th>Version</th>
      <th>Issuing Authority</th>
      <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <%if(SQRFile==null){ %>
      <tr>
      <td colspan="7" style="text-align:center;">No Data Available</td>
      </tr>
      <%}else{ %>
      <tr>
      <td style="text-align: center">1.</td>
      <td>
      <%if(SQRFile[0].toString().equalsIgnoreCase("IA")) {%>Indian Army<%} %>
      <%if(SQRFile[0].toString().equalsIgnoreCase("IN")) {%>Indian Navy<%} %>
      <%if(SQRFile[0].toString().equalsIgnoreCase("OH")) {%>Others<%} %>
      <%if(SQRFile[0].toString().equalsIgnoreCase("DO")) {%>DRDO<%} %>
      <%if(SQRFile[0].toString().equalsIgnoreCase("IAF")) {%>Indian Air Force<%} %>
      </td>
      <td ><%if(SQRFile[1]!=null) {%><%=SQRFile[1].toString()%><%} %></td>
      <td><%if(SQRFile[5]!=null){%><%=(sdf.format(SQRFile[5])) %><%} %></td>
      <td style="text-align: right"><%if(SQRFile[4]!=null) {%><%=SQRFile[4].toString()%><%}%></td>
       <td><%if(SQRFile[3]!=null) {%><%=SQRFile[3].toString()%><%}%></td>
       <td align="center"><button class="btn btn-sm bg-transparent"><i class="fa fa-download" aria-hidden="true" style="color:green;"></i></button></td>
      </tr>
      <%} %>
      </tbody>
      </table>
      <div align="center">
<!--       <button type="button" class="btn btn-success btn-sm modalbtn" onclick="showmodalbody()">ADD</button>
      <button type="button" class="btn btn-warning btn-sm ml-2 modalbtn">EDIT</button></div> -->
     <span id="SQRdata"> <button class="btn btn-lg bg-transparent" id="sqr" onclick="showmodalbody()"><i class="fa fa-lg fa-caret-down" aria-hidden="true" style="color:green"></i></button></span>
     <form action="ProjectSqrSubmit.htm" method="post" enctype="multipart/form-data">
      <div id="modalbody" class="mt-2" style="padding:20px;display:none;background: aliceblue">
      <div class="col-md-12">
      <div class="row">
      <div class="col-md-3">
      <label style="font-size: 17px; margin-top: 5%;  margin-left: 5%; color: #07689f;font-weight:bold">User:</label>
     <span class="mandatory" style="color: red;">*</span>
      </div>
      <div class="col-md-4">
      <select class="form-control modals" required name="users">
      <option value="IA" <%if(SQRFile!=null && SQRFile[0].toString().equalsIgnoreCase("IA")) {%>selected<%} %>>Indian Army</option>
      <option value="IN" <%if(SQRFile!=null && SQRFile[0].toString().equalsIgnoreCase("IN")) {%>selected<%} %>>Indian Navy</option>
      <option value="IAF" <%if(SQRFile!=null && SQRFile[0].toString().equalsIgnoreCase("IAF")) {%>selected<%} %>>Indian Air Force</option>
      <option value="DO" <%if(SQRFile!=null && SQRFile[0].toString().equalsIgnoreCase("DO")) {%>selected<%} %>>DRDO</option>
      <option value="OH"  <%if(SQRFile!=null && SQRFile[0].toString().equalsIgnoreCase("OH")) {%>selected<%} %>>Other</option>
      </select>
      </div>
      </div>
      <div class="row mt-2" >
      <div class="col-md-3">
      <label style="font-size: 17px; margin-top: 5%;  margin-left: 5%; color: #07689f;font-weight:bold">Refernce No:</label>
      <span class="mandatory" style="color: red;">*</span>
      </div>
      <div class="col-md-4">
      <input class="form-control modals" type="text" required name="refNo" maxlength="255 characters" value="<%if(SQRFile!=null && SQRFile[1]!=null) {%><%=SQRFile[1].toString()%><%} %>">
      </div>
      </div>
       <div class="row mt-2">
       <div class="col-md-4">
      <label style="font-size: 17px; margin-top: 5%;  margin-left: -5%; color: #07689f;font-weight:bold">Issuing Authority:</label>
     	<span class="mandatory" style="color: red;">*</span>
      </div>
      <div class="col-md-4" style="margin-left: -6%;">
      <input type="text" class="form-control modals" name="IssuingAuthority" required maxlength="255 characters" value="<%if(SQRFile!=null && SQRFile[3]!=null) {%><%=SQRFile[3].toString()%><%} %>">
      </div>
      </div>
      <div class="row mt-2">
      <div class="col-md-3">
      <label style="font-size: 17px; margin-top: 5%;  margin-left: 5%; color: #07689f;font-weight:bold">  Version No.&nbsp;:</label>
     	<span class="mandatory" style="color: red;">*</span>
      </div>
      <div class="col-md-4">
      <input class="form-control modals" id="versionUpdates" type="text" style="width:50%;float:left;" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" name="version" 
      value="<%if(SQRFile!=null && SQRFile[4]!=null) {%><%=SQRFile[4].toString()%><%} %>" <%if(SQRFile!=null) {%>readonly<%} %>>
      <%if(SQRFile!=null){%>
     <span id="versionUpdatespan"> <button class="bt btn-sm bg-transparent" type="button" style="border:none;" onclick="versionUpdate()"><i class="fa fa-pencil" aria-hidden="true" style="color:blue"></i></button><%} %>  </span> </div>
      </div>
      <div class="row mt-2">
      <div class="col-md-3">
      <label style="font-size: 17px; margin-top: 5%;  margin-left: 5%; color: #07689f;font-weight:bold">Choose file:</label>
		<span class="mandatory" style="color: red;">*</span>     
      </div>
      <div class="col-md-6">
      <input type="file" class="form-control modals" required accept=".pdf" name="Attachments">
      </div>
      </div>
      <div align="center" class="mt-3">
  	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />	
	<input type="hidden" name="initiationid"	value="<%=ProjectDetailes[0] %>" /> 
	<input type="hidden" name="projectShortName"	value="<%=ProjectDetailes[6] %>" /> 
     <span>
     <%if(SQRFile!=null) {%>
     <button class="btn btn-sm edit" type="submit" onclick="return confirm('Are you sure you want to update?')" style="box-shadow:2px 2px 2px gray;">UPDATE</button>
     <%}else{ %>
     <button class="btn btn-sm submit" type="submit" onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button>
      <%} %>
      </span>
      </div>
      </div>
      </div>
      </form>
      </div>
    </div>
  </div>
</div>	
</div>	 --%>
<script type="text/javascript">


/* function tabcontrol(){
	
	
	
	 var i, items = $('.tab-control');
	

	 $('.next').on('click', function(){
		 

	       for(i = 0; i < items.length; i++){
	    	  
	 
	          if($(items[i]).defaultChecked = true){
	      
	 
	        	  
	              break;
	          }
	      } 
	      
	      
	      if(i < items.length - 1){
	     
	    	  $(items[i]).checkboxObject=false;
	    	 	
	    	  $(items[i-1]).checkboxObject=true;
  
	           $(items[i+1]).trigger('click'); 
	        
	      }
	      
	      

	  }); 
	 
	 
	 
	 $('.previous').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).defaultChecked = true){
	        	  
	        	  alert('inside previous');
	        	  
	              break;
	          }
	      }
	      if(i != 0){
	         
	          $(items[i-1]).trigger('click');
	         
	      }
	  });
	
}
tabcontrol(); */

 function bootstrapTabControl(){
	  var i, items = $('.nav-link'), pane = $('.tab-pane');
	  // next
	  $('.next').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i < items.length - 1){
	          // for tab
	         // $(items[i]).removeClass('active');
	          $(items[i+1]).trigger('click');
	          // for pane
	         // $(pane[i]).removeClass('show active');
	         // $(pane[i+1]).addClass('show active');
	      }

	  });
	  // Prev
	  $('.previous').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i != 0){
	          // for tab
	         // $(items[i]).removeClass('active');
	          $(items[i-1]).trigger('click');
	          // for pane
	         // $(pane[i]).removeClass('show active');
	          //$(pane[i-1]).addClass('show active');
	      }
	  });
	}
	bootstrapTabControl(); 

	
	 
	function showOnChange() {
		
		  var select_value = document.getElementById("custom-select").selectedIndex;
		 
		  var tab_value = document.getElementsByClassName("details_tab");
		  
		  for (len = 0;len < tab_value.length; len++)
			  tab_value[len].style.display = "none";
		  	  tab_value[select_value].style.display = "block";
		}
	
	function submitForm()
	{ 
	  document.getElementById('myreqfrm').submit(); 
	} 
	
</script>

<!--  Get the modal


 /*   function modal(){
var modal = document.getElementById("myModal");

console.log(modal);
// Get the button that opens the modal
var btn = document.getElementById("reqbtn2");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
}   -->
<script type="text/javascript">
function balanceCheck(){
	var cost=$('#cost').val();
	var totabudgetcost=$('#totabudgetcost').val();
	if(Number(cost)>totabudgetcost){
		alert("The given cost is exceeding the total budget left.")
	}
}

function balanceCheckforEdit(){
	var cost=Number($('#costedit').val());
	var previouscost=Number($('#previouscost').val());
	var BudgetTotalEdit=Number($('#BudgetTotalEdit').val());
	var BudgetPlannedEdit=Number($('#BudgetPlannedEdit').val());
	var totalNow=(Number(BudgetPlannedEdit)-Number(previouscost)+Number(cost))
 	if(Number(totalNow)>Number(BudgetTotalEdit)){
		alert("The cost is exceeding the total budget")
		document.getElementById('costedit').value=previouscost;
	} 

}
function AddEditValues(x){
	document.getElementById('planid').value=x;
}
function showAddModal(a,b,c){
	let str =b;  
	let num = parseFloat(str)/100000;  
	let formattedNum = num.toLocaleString('en-IN', {
	  style: 'currency',
	  currency: 'INR',
	  minimumFractionDigits: 2,
	  maximumFractionDigits: 2,
	});	
	document.getElementById('addBugetLeft').innerHTML="Budget left-"+formattedNum+"Lakhs"
	$('#cross1').click();
	document.getElementById('InitiationCostId').value =a;
	document.getElementById('initiationid').value=c;
	document.getElementById('totabudgetcost').value=b;
	$('#procurementModal').modal('show');
}
function showcostvalues(){
	$("#Order ").attr("readonly", false); 
	$("#Tender ").attr("readonly", false); 
	$("#Payout ").attr("readonly", false); 
	var demand=$('#Demand').val().trim();
	document.getElementById("Tender").value=demand;document.getElementById("Order").value=demand;document.getElementById("Payout").value=demand;
}
function viewModal(x,y,z){
	var initiationid=z;
	var InitiationCostId=x;
	document.getElementById('maincost').value=y
	let str =y;  
	let num = parseFloat(str)/100000;  
	let formattedNum = num.toLocaleString('en-IN', {
	  style: 'currency',
	  currency: 'INR',
	  minimumFractionDigits: 2,
	  maximumFractionDigits: 2,
	});	
	var bgtleft=0
	var j=0;
	document.getElementById('totalBudget').innerHTML="Total Budget -"+formattedNum+ " Lakhs ";
	document.getElementById('BudgetAdded').innerHTML="Planned-&#8377;0.00 Lakhs"
	document.getElementById('Budgetleft').innerHTML="Budget left-"+formattedNum+" Lakhs" 
	$('#buttons').html('<button class="btn btn-primary btn-sm submit mb-1" type="button" onclick="showAddModal('+x+','+y+','+z+')">ADD</button><button class="btn btn-warning btn-sm edit ml-1 mb-1" type="button" onclick="openEditModal()">EDIT</button>')
	$.ajax({
		type:'GET',
		url:'ProcurementList.htm',
		datatype:'json',
		data:{
			initiationid:initiationid,
			InitiationCostId:InitiationCostId,
		},
		success:function(result){
			var ajaxresult=JSON.parse(result);
			if(ajaxresult.length==0){
				$('#tbody2').html('<tr><td align="center" colspan="8"><h6>No procurement plan added for this</h6> </td></tr>')
			}else{
				var html="";
				
				for(var i=0;i<ajaxresult.length;i++){
					j=j+ ajaxresult[i][6];
					let str1 = ajaxresult[i][6];  
					let num1 = parseFloat(ajaxresult[i][6])/100000;  


					let formattedNum1 = num1.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});
					html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange="AddEditValues('+ajaxresult[i][0]+')"></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td align="center">'+ajaxresult[i][4]+'</td>'+'<td >'+ajaxresult[i][5]+'</td>'+'<td align="right">'+formattedNum1+'</td>'+'<td align="center">'+ajaxresult[i][7]+'</td>'+'<td align="center">'+ajaxresult[i][8]+'</td>'+'</tr>'	
				}
				/* budget done */
				let numdone= parseFloat(j)/100000;
				let formattedNumDone = numdone.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});	
				bgtleft=y-j;
				document.getElementById('BudgetAdded').innerHTML="Planned -"+formattedNumDone+ " Lakhs ";
				let formattedleft = (num-numdone).toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});	
				document.getElementById('Budgetleft').innerHTML="Budget left-"+(formattedleft)+ " Lakhs ";
				if(bgtleft==0){
					$('#buttons').html('<button class="btn btn-warning btn-sm edit ml-1 mb-1" type="button" onclick="openEditModal('+y+','+j+','+z+','+x+')">EDIT</button>')	
				}else{
				$('#buttons').html('<button class="btn btn-primary btn-sm submit mb-1" type="button" onclick="showAddModal('+x+','+bgtleft+','+z+')">ADD</button><button class="btn btn-warning btn-sm edit ml-1 mb-1" type="button" onclick="openEditModal('+y+','+j+','+z+','+x+')">EDIT</button>')
				}
				$('#tbody2').html(html);
			}
		}
	})
/* 	$('#buttons').html('<button class="btn btn-primary btn-sm submit mb-1" type="button" onclick="showAddModal('+x+','+y+','+z+')">SUBMIT</button><button class="btn btn-warning btn-sm edit ml-1 mb-1" type="button">EDIT</button>') */
	$('#ProcurementList').modal('show');
}

function checKDemand(){
	var Demand=$('#Demand').val().trim();
	var tender=$('#Tender').val().trim();
	console.log(Demand+"----")
	if(Number(Demand)>Number(tender)){
	alert("Tender Month should be more than demand month!")
	document.getElementById("Tender").value=Demand;}
	else{
		document.getElementById("Tender").value=tender;document.getElementById("Order").value=tender;document.getElementById("Payout").value=tender;
	}
	}
 function chechKTender(){
	var tender=$('#Tender').val().trim();
	var Order=$('#Order').val().trim();
	if(Number(tender)>Number(Order)){
	alert("Order Month should be more than tender month!")
	document.getElementById("Order").value=tender;
	}else{
		document.getElementById("Order").value=Order;document.getElementById("Payout").value=Order;
	}
	
}
function chechkOrder(){
	var Order=$('#Order').val().trim();
	var Payment=$('#Payout').val();
	if(Number(Order)>Number(Payment)){
	alert("Payment Month should be more than Order month!")
	document.getElementById("Payout").value=Order;
	}
}
function submitProcurementPlan(){
	var Item=$('#Item').val().trim();
	var Purpose=$('#Purpose').val().trim();
	var Source=$('#Source').val().trim();
	var Mode=$('#Mode').val();
	var cost=$('#cost').val();
	var Approve=$('input[name="Approved"]:checked').val();
	var Demand=$('#Demand').val();
	var Tender=$('#Tender').val();
	var Order=$('#Order').val();
	var Payout=$('#Payout').val();
	var InitiationCostId=$('#InitiationCostId').val();
	var initiationid=$('#initiationid').val();
	var y;
	 if(Item.lenght==0||Purpose.lenght==0||Source.lenght==0||Mode==null||cost.length==0){
		 alert("please fill all the fields");
	 }
 		 else{
		 if(confirm("Are you sure you want to submit")){
				$('#successdiv').css("display","none");
			 $.ajax({
				 type:'GET',
				 url:'ProcurementSubmit.htm',
				 datatype:'json',
				 data:{
				 Item:Item, 
				 Purpose:Purpose,
				 Source:Source,
				 Mode:Mode,
				 cost:cost,
				 Approve:Approve,
				 Demand:Demand,
				 Tender:Tender,
				 Order:Order,
				 Payout:Payout,
				 InitiationCostId:InitiationCostId,
				 initiationid:initiationid,
				 },
				 success:function(result){
						if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  added Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#cross2').click();
							y=document.getElementById('maincost').value;
						
						}else{
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-danger" id="divalert"  role="alert">Data  add unsuccessful</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#cross2').click();	
						}
						 setTimeout(viewModal(InitiationCostId,y,initiationid), 8000);
				 }
				
			 })
	
		 }else{
			 event.preventDefault();
			 return false;
		 }
	 } 
}
$('#cross2').click(function (){
	document.getElementById("Item").value="";
	document.getElementById("Purpose").value="";
	document.getElementById("Source").value="";
	document.getElementById("Mode").value="";
	document.getElementById("cost").value="";
	/* $('input[name="Approved"]:checked').val("N"); */
	document.getElementById("Demand").value="";
	document.getElementById("Tender").value="";
	document.getElementById("Order").value="";
	document.getElementById("Payout").value="";
	$("#Order ").attr("readonly", true); 
	$("#Tender ").attr("readonly", true); 
	$("#Payout ").attr("readonly", true); 
})
 function openEditModal(a,b,c,d){
	let str =a;  
	let num = parseFloat(str)/100000;  
	let formattedNum = num.toLocaleString('en-IN', {
	  style: 'currency',
	  currency: 'INR',
	  minimumFractionDigits: 2,
	  maximumFractionDigits: 2,
	});	
	
	/*  formmatting in indian ruppes*/
		let str1 =b;  
	let num1 = parseFloat(str1)/100000;  
	let formattedNum1 = num1.toLocaleString('en-IN', {
	  style: 'currency',
	  currency: 'INR',
	  minimumFractionDigits: 2,
	  maximumFractionDigits: 2,
	});	
	document.getElementById("EditTotalBudget").innerHTML="Total Budget -"+formattedNum+"Lakhs ";
	$('#values').html('<input type="hidden" id="BudgetTotalEdit" value="'+a+'"> <input type="hidden" id="BudgetPlannedEdit" value="'+b+'"> ')
	document.getElementById("EditPlannedBudget").innerHTML="&nbsp;,&nbsp; Planned -"+formattedNum1+"Lakhs ";
	var planid=$('#planid').val();
	if(planid==0){
		alert("Please select any one");
	}else{
		$.ajax({
			type:'GET',
			url:'PocurementPlanEditDetails.htm',
			datatype:'json',
			data:{
			Planid:planid,
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				 $('#Itemedit').val(ajaxresult[0]);
				 $('#Purposeedit').val(ajaxresult[1]);
				 $('#Sourceedit').val(ajaxresult[2]); 
				 $('#Modeedit').val(ajaxresult[3]);
				 $('#costedit').val(ajaxresult[4]);
			/* 	 $('#Approvededit').val(ajaxresult[9]); */
				 if(ajaxresult[9]=="Y"){
					 $('#Approvededit').html('<input type="radio" name="Approved1"  value="Y" checked>  YES  <input style="margin-left: 15px;" type="radio" name="Approved1" value="N">  NO');
				 }else{
					 $('#Approvededit').html('<input type="radio" name="Approved1"  value="Y" >  YES  <input style="margin-left: 10px;" type="radio" name="Approved1" value="N" checked>  NO');

				 }
				 $('#previouscost').val(ajaxresult[4]);
				 $('#Demandedit').val(ajaxresult[5]);
				 $('#Tenderedit').val(ajaxresult[6]);
				 $('#Orderedit').val(ajaxresult[7]);
				 $('#Payoutedit').val(ajaxresult[8]);
					$('#editModal').html('<button type="submit" class="btn btn-primary btn-sm submit"id="" name="action" value="SUBMIT"onclick="EditProcurement('+c+','+d+')">SUBMIT</button>')
			}
		})	
		
		
		
		$('#cross1').click();
		$('#procurementModalEdit').modal('show');
	}
}
$('#cross3').click(function (){
	document.getElementById("planid").value=0;
})
function EditProcurement(a,b){
	var Item=$('#Itemedit').val().trim();
	var Purpose=$('#Purposeedit').val().trim();
	var Source=$('#Sourceedit').val().trim();
	var Mode=$('#Modeedit').val();
	var cost=$('#costedit').val();
	var Approve=$('input[name="Approved1"]:checked').val();
	var Demand=$('#Demandedit').val();
	var Tender=$('#Tenderedit').val();
	var Order=$('#Orderedit').val();
	var Payout=$('#Payoutedit').val();
	var planid=$('#planid').val();
	var BudgetTotalEdit=Number($('#BudgetTotalEdit').val());
	if(Item.length==0||Purpose.length==0||Source.length==0||cost.length==0||Demand.length==0||Tender.length==0||Order.length==0||Payout.length==0){
		alert("please fill all the fields")
	}else{
		if(confirm("Are you sure,you want to submit?")){
			$('#successdiv').css("display","none");
			$.ajax({
				type:'GET',
				url:'ProcurementEdit.htm',
				datatype:'json',
				data:{
					Item:Item,
					Purpose:Purpose,
					Source:Source,
					Mode:Mode,
					cost:cost,
					Approve:Approve,
					Demand:Demand,
					Tender:Tender,
					Order:Order,
					Payout:Payout,
					planid:planid,
				},
				success:function(result){
					if(result>0){
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  updated successfully</div>');
						$('#successdiv').delay(3000).hide(0);
						$('#cross3').click();
						 setTimeout(viewModal(b,BudgetTotalEdit,a), 4000);
					}else{
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-danger" id="divalert"  role="alert">Data  update unsuccessful</div>');
						$('#successdiv').delay(3000).hide(0);
					}
				}
			})
		
		}else{
			event.preventDefault();
			return false;
		}
	}
}
function showsqrModal(){
	$('#sqrModal').modal('show');
}
function showmodalbody(){
	$('#modalbody').show();
	$('#SQRdata').html('<button class="btn btn-lg bg-transparent" id="sqr" onclick="hidemodalbody()"><i class="fa fa-lg fa-caret-up" aria-hidden="true" style="color:green"></i></button>')
}
function hidemodalbody(){
	$('#modalbody').hide();
	$('#SQRdata').html('<button class="btn btn-lg bg-transparent" id="sqr" onclick="showmodalbody()"><i class="fa fa-lg fa-caret-down" aria-hidden="true" style="color:green"></i></button>')
	$('#versionUpdatespan').html('<button class="bt btn-sm bg-transparent" type="button" style="border:none;" onclick="versionUpdate()"><i class="fa fa-pencil" aria-hidden="true" style="color:blue"></i></button>');
	/* $("#versionUpdates").attr("readonly", true); */
}

function versionUpdate(){
	$('#versionUpdatespan').html('<button class="bt btn-sm bg-transparent" type="button" style="border:none;" onclick="versionUpdateClose()"><i class="fa fa-lg fa-times" aria-hidden="true" style="color:red"></i></button>');
	$("#versionUpdates").attr("readonly", false);
}
function versionUpdateClose(){
	$('#versionUpdatespan').html('<button class="bt btn-sm bg-transparent" type="button" style="border:none;" onclick="versionUpdate()"><i class="fa fa-pencil" aria-hidden="true" style="color:blue"></i></button>');
	$("#versionUpdates").attr("readonly", true);
}
$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})
</script>
	<script>
  // Show the button when the user scrolls down a certain distance
  window.onscroll = function() { scrollFunction() };
  		function scrollFunction() {
	    var scrollButton = document.getElementById("scrollButton");
	    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	      scrollButton.style.display = "block";
	    } else {
	      scrollButton.style.display = "none";
	    }
	  	}
  	// Scroll to the top when the button is clicked
  	function scrollToTop(){
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
 	}
  </script>
</body>
</html>
       									