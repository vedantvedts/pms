<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%-- <%@page import="com.vts.pfms.docs.model.PfmsDoc"%>
<%@page import="com.vts.pfms.docs.model.PfmsDocTemplate"%> --%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet"/>

<title>Document Items</title>
<style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }

label{
  font-weight: bold;
  font-size: 20px;
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

user agent stylesheet
div {
    display: block;
}

.panel-info {
    border-color: #bce8f1;
}

.form-check{
	margin:0px 4%;
}

.editbtn
{
	background-color: green;
	width:auto; 
	height: 22px; 
	font-size:10px;
	font-weight: bold;
	text-align: justify; 
	margin-top : -9px;
	padding: 0px 3px 1px 3px; 
}

.hiddeninput
{
	width:50%;
	height: 25px;
	
	font-size: 1rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 2px;
	
}

 .btnx
{
	width:22px; 
	height: 22px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	
}

.fa-lg
{
	margin-left: -5px;
	vertical-align: 0%;
	font-size: 1.4rem;
} 



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
</head>
<body>

 <!-- ----------------------------------message ------------------------- -->

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

<!-- ----------------------------------message ------------------------- -->


<%
	Object[] pfmsdocdata = (Object[])request.getAttribute("pfmsdocdata");
	
	String filerepmasterid = pfmsdocdata[2].toString();
	String pfmsdocid = pfmsdocdata[0].toString();
	String projectid = pfmsdocdata[1].toString();
	String isfrozen = pfmsdocdata[9].toString();
	
	List<Object[]> tempitemlist=(List<Object[]>)request.getAttribute("tempitemlist");
	List<Object[]> docversionnos=(List<Object[]>)request.getAttribute("docversionnos");
	
	String headertext1 = (String)request.getAttribute("headertext1");
	String headertext2 = (String)request.getAttribute("headertext2");
	String docids = (String)request.getAttribute("docids");
	String systemids = (String)request.getAttribute("systemids");
	
	String collapseids = (String)request.getAttribute("collapseids"); 
	
	FormatConverter fc= new FormatConverter(); 
	SimpleDateFormat sdf1=fc.getRegularDateFormat();
	SimpleDateFormat sdf=fc.getSqlDateFormat();
	String temp="";
	int temp_count=0;
	
%>

	<div class="container-fluid">
		<div class="card">
			<div class="card-header" >
				<div class="row">
					<div class="col-md-3">
						<h4><b>Document Content</b></h4>
					</div> 
					<div class="col-md-8">
					
					</div>
					<div class="col-md-1" align="right">
						<form action="ProjectSystems.htm" method="post">
							<button type="submit" name="projectid" value="<%=projectid%>" class="btn btn-sm back">BACK</button>
							<input type="hidden" name="systemids" value="<%=systemids %>" />
							<input type="hidden" name="docids" value="<%=docids %>" />
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
			<div class="card-body" style="min-height: 30rem;">
			<%if(docversionnos.size()>0){ %>
				<div style="padding: 5px 0px 5px 0px; margin:-20px 0px 5px 0px; width: 100%; border: 1px solid black;" align="center">				
					<form action="DocVersionDownload.htm" method="post" target="_blank">
						<span style="color: black;font-weight: 500;">
							<%=headertext2!=null?StringEscapeUtils.escapeHtml4(headertext2): " - " %> 
							(Ver :&nbsp;&nbsp;<%=docversionnos.get(0)[0]!=null?StringEscapeUtils.escapeHtml4(docversionnos.get(0)[0].toString()): " - " %>)&nbsp;&nbsp;
							
							&nbsp;&nbsp;
							<%if(tempitemlist.size()>0 ){ %>
							<button type="submit" class="btn btn-sm">
								<i class="fa fa-download" aria-hidden="true" style="color: green"></i>
							</button>
							
								&nbsp;&nbsp;<button type="button" class="btn btn-sm"  data-toggle="modal" data-target="#myModal" >
									<i class="fa fa-history" aria-hidden="true"></i>
								</button>
							<%} %>
						
						</span>
						<input type="hidden" name="pfmsdocid" value="<%=pfmsdocid %>" />
						<input type="hidden" name="versionno" value="<%=Integer.parseInt(pfmsdocdata[4].toString())-1 %>" />
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					</form>
				</div>
			<%} %>
				<div class="row" >
					<div class="col-6">
						<div class="col-12" style="margin-left: -10px;" >		
							<div class="col-12" style="text-align: ;">
								<b><%=headertext1!=null?StringEscapeUtils.escapeHtml4(headertext1): " - " %> </b>
							</div>																
						    <div class="panel panel-info" >
						    	<div class="panel-heading " >
						    		<form action="" method="post" target="_blank">
							        	<h3 class="panel-title" style="font-size: 15px; margin: -3px;color: #4FBD45"> 
							        		<%=headertext2!=null?StringEscapeUtils.escapeHtml4(headertext2): " - "%> <%-- (Ver &nbsp;: <%=pfmsdocdata[4]%>) --%>
							        		<%if(tempitemlist.size()>0 && isfrozen.equalsIgnoreCase("N") ){ %>
							        			( Draft )
							        			&nbsp;<button type="submit" class="btn btn-sm" data-toggle="tooltip" data-placement="top" title="Download file"  formaction="DocDraftDownload.htm" ><i class="fa fa-download" aria-hidden="true" style="color: green"></i></button>
								        		&nbsp;<button type="submit" class="btn btn-sm" data-toggle="tooltip" data-placement="top" title="Preview file"  formaction="DocDraftView.htm"><i class="fa fa-eye" aria-hidden="true" ></i></button>
							        		<%}else if(isfrozen.equalsIgnoreCase("Y")){ %>
							        			&nbsp;<button type="submit" class="btn btn-sm" data-toggle="tooltip" data-placement="top" title="Download file" formaction="DocFreezeDownload.htm" ><i class="fa fa-download" aria-hidden="true" style="color: green"></i></button>
								        		&nbsp;<button type="submit" class="btn btn-sm" data-toggle="tooltip" data-placement="top" title="Preview file" formaction="DocFreezeView.htm" ><i class="fa fa-eye" aria-hidden="true" ></i></button>							        		
							        		<%} %>
											<input type="hidden" name="pfmsdocid" value="<%=pfmsdocid%>">
							        	</h3> 	
							        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						        	</form>					         	
									<!-- <div style="float: right !important; margin-top:-20px; ">  
										<a data-toggle="collapse" data-parent="#accordion" href="#collapse0" > <i class="fa fa-plus faplus " id="Clk"></i></a>
								   	</div> -->
								</div>								
								<div id="collapse0" class="panel-collapse collapse in show">
						         	<%	int count = 1, splcount=0; 
						         		for(Object[] item : tempitemlist){
						         		if(item[1].toString().equalsIgnoreCase("1")){
						         			if(count==1){ temp = item[0].toString(); } %>
							      		<div class="panel-heading ">
							        		<h4 class="panel-title">
							        			<span  style="font-size:14px"><%=count %> ) <%=item[4]!=null?StringEscapeUtils.escapeHtml4(item[4].toString()): " - " %>&nbsp;&nbsp;</span>
							        			<%if( isfrozen.equalsIgnoreCase("N")){%>
								        			<%if(item[5]!=null ){ 	splcount++; %> 
								        			<button type="button" class="btn btn-warning btn-sm" id="btn-clk-<%=item[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item[0]%>',0,'','','<%=item[0]%>',1);">EDIT</button>
								        			<%}else { %> 
								        			<button type="button" class="btn btn-primary btn-sm" id="btn-clk-<%=item[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item[0]%>',0,'','','<%=item[0]%>',1);">ADD</button>
								        			<%} %> 
							        			<%}else{ %>
							        				<button type="button" class="btn btn-success btn-sm" id="btn-clk-<%=item[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item[0]%>',0,'','','<%=item[0]%>',1);">VIEW</button>
							        			<%} %>
							        		</h4>									         	
											<div   style="float: right !important; margin-top:-20px; ">  
												<a data-toggle="collapse" data-parent="#accordion" id="collapse-<%=item[0] %>"  href="#collapse<%=item[0] %>" > <i class="fa fa-plus faplus " id="Clk"></i></a>
									   		</div>
									    </div>
								    
									    <div id="collapse<%=item[0] %>" class="panel-collapse collapse in">
			<!-- ---------------------------------------------------------------------------------------------------- --> 
										<div class="row">  
											<%	int count1 = 1;
											for(Object[] item1 : tempitemlist){
							         		if(item1[1].toString().equalsIgnoreCase("2") && item1[2].toString().equalsIgnoreCase(item[0].toString())){	%>
											<div class="col-md-11"  align="left"  style="margin-left: 20px;">
												<div class="panel panel-info">
													<div class="panel-heading">
														<h4 class="panel-title">
															<span>	<%=count %>.<%=count1 %>. <%=item1[4]!=null?StringEscapeUtils.escapeHtml4(item1[4].toString()): " - " %>&nbsp;&nbsp;</span>
															<%if( isfrozen.equalsIgnoreCase("N")){%>
																<%if(item1[5]!=null ){ 	splcount++; %>
											        			<button type="button" class="btn btn-warning btn-sm" id="btn-clk-<%=item1[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item1[0]%>',1,'<%=item[4]%>','','<%=item[0]%>-<%=item1[0]%>',1);">EDIT</button>
											        			<%}else { %>
											        			<button type="button" class="btn btn-primary btn-sm" id="btn-clk-<%=item1[0] %>" style="width:40px;  height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item1[0]%>',1,'<%=item[4]%>','','<%=item[0]%>-<%=item1[0]%>',1);">ADD</button>
											        			<%} %>
										        			<%}else{ %>
									        					<button type="button" class="btn btn-success btn-sm" id="btn-clk-<%=item1[0] %>" style="width:40px;  height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item1[0]%>',1,'<%=item[4]%>','','<%=item[0]%>-<%=item1[0]%>',1);">VIEW</button>
										        			<%} %>
														</h4>
														<div style="float: right !important; margin-top:-20px; " > 
												       		<a data-toggle="collapse" data-parent="#accordion" id="collapse-<%=item1[0] %>"  href="#collapse<%=item1[0] %>" > <i class="fa fa-plus faplus " id="Clk"></i></a>
												       	</div>
													</div>
													
													<div id="collapse<%=item1[0] %>" class="panel-collapse collapse in">
						    <!-- ---------------------------------------------------------------------------------------------------- -->
														<div class="row"> 
															<%	int count2 = 1;
																for(Object[] item2 : tempitemlist){
							         							if(item2[1].toString().equalsIgnoreCase("3") && item2[2].toString().equalsIgnoreCase(item1[0].toString()) ){	%> 
															<div class="col-md-11"  align="left"  style="margin-left: 20px;">
																<div class="panel panel-info">
																	<div class="panel-heading">
																		<h4 class="panel-title">
																			<span ><%=count %>.<%=count1 %>.<%=count2 %>. <%=item2[4]!=null?StringEscapeUtils.escapeHtml4(item2[4].toString()): " - " %>&nbsp;&nbsp; </span>
																			<%if( isfrozen.equalsIgnoreCase("N")){%>
																				<%if(item2[5]!=null ){ 	splcount++; %>
															        			<button type="button" class="btn btn-warning btn-sm" id="btn-clk-<%=item2[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item2[0]%>',2,'<%=item[4]%>','<%=item1[4]%>','<%=item[0]%>-<%=item1[0]%>-<%=item2[0]%>',1);">EDIT</button>
															        			<%}else if( isfrozen.equalsIgnoreCase("N")){ %>
															        			<button type="button" class="btn btn-primary btn-sm" id="btn-clk-<%=item2[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item2[0]%>',2,'<%=item[4]%>','<%=item1[4]%>','<%=item[0]%>-<%=item1[0]%>-<%=item2[0]%>',1);">ADD</button>
															        			<%} %>
														        			<%}else{ %>
													        					<button type="button" class="btn btn-success btn-sm" id="btn-clk-<%=item2[0] %>" style="width:40px; height: 20px; padding-top : 2px; font-size:10px; font-weight: bold; text-align: justify;"  onclick="getItemData('<%=item2[0]%>',2,'<%=item[4]%>','<%=item1[4]%>','<%=item[0]%>-<%=item1[0]%>-<%=item2[0]%>',1);">VIEW</button>
														        			<%} %>
																		</h4>
																	</div>
																
																</div>
															</div>
															<%count2++;}} %>											
														</div>
							<!-- ---------------------------------------------------------------------------------------------------- -->					  	
													</div>      
													
												</div>
											</div>
											<% count1++;}} %>
										</div>
								
			<!-- ---------------------------------------------------------------------------------------------------- --> 
										</div> 
									
								<%count++ ;}
							    }%>
							    <%if(tempitemlist.size()==0){ %>
							    	<div align="center">
								    	<form action="DocumentTemplate.htm" method="get" target="_blank">
								    		<button type="submit" class="btn btn-link">Please add template for this document </button>
								    		<input type="hidden" name="projectid" value="<%=projectid %>" />
								    		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
								    	</form>
							    	</div>
							    <%} %>
							</div>
							
							
						</div>
					</div>
					<%if(tempitemlist.size()>0 ){ %>
					<div align="center">
						<form action="PfmsDocRevise.htm" method="post">
							
							<input type="hidden" name="pfmsdocid" value="<%=pfmsdocid%>" />
							<input type="hidden" name="docids" value="<%=docids %>" />
							<input type="hidden" name="systemids" value="<%=systemids %>" />
							<input type="hidden" name="headertext2" value='<%=headertext2%>' />
							<input type="hidden" name="headertext1" value='<%=headertext1%>' />
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />	
							<%if( isfrozen.equalsIgnoreCase("Y")){ %>
							<button type="submit" class="btn btn-sm submit" style="color: black;border-color:#FF7800 ;background-color: #FF7800" name="action" value="revise" onclick="return confirm('Are You Sure to Revise?');" >REVISE (Ver &nbsp;<%=pfmsdocdata[4].toString()%>)</button>
							<%}else if( isfrozen.equalsIgnoreCase("N") && splcount==tempitemlist.size()){ %>
							<button type="submit" class="btn btn-sm submit" formaction="PfmsDocFreeze.htm" style="color: black;border-color:#86C6F4 ;background-color: #86C6F4" name="action" value="freeze" onclick="return confirm('Are You Sure to Freeze this Document?');" >FREEZE (Ver &nbsp;<%=pfmsdocdata[4].toString()%>)</button>
							<%} %>
						</form>
					</div>		
					<%} %>			
				</div>
<!-- -------------------------------------------------- RIGHT SIDE --------------------------------------------------------- -->
					<div class="col-6">
						<%if(tempitemlist.size()>0){ %>
							<div id="e-header" style="width : 100%;min-height: 30px;background-color: #EAEAEA;margin-top: 0px;padding: 5px 10px; font-weight: 600;">
								
							</div>
							<form method="post" action="TempItemContentAdd.htm" autocomplete="off" id="f2">
								<div>
									 <textarea  name="itemcontent" id="summernote" ></textarea>
								</div>
								<div align="center" style="margin: 10px 0px 10px 0px;">
									<input type="radio" name="isdependent"  id="isdependent" value="Y"> <b>Dependent </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="isdependent"  id="isindependent" value="N"> <b>Independent</b>
								</div>								
								
								<input type="hidden" name="templateitemid" id="form-templateitemid" value="0">
								<input type="hidden" name="itemcontentid" id="form-itemcontentid" value="0">
								<input type="hidden" name="collapseids" id="form-collapseids" value="0">
																
								<input type="hidden" name="pfmsdocid" value="<%=pfmsdocid%>" />								
								<input type="hidden" name="docids" value="<%=docids %>" />
								<input type="hidden" name="systemids" value="<%=systemids %>" />
								<input type="hidden" name="headertext2" value='<%=headertext2%>' />
								<input type="hidden" name="headertext1" value='<%=headertext1%>' />
								<input type="hidden" id="form-depend" value='' />
						<!-- ------------------------------------------------------------------------------------------------------ -->	
								<input type="hidden" name="linkversoionno" id="f2-link-versionno" value="">
								<input type="hidden" name="linkitemcontentid" id="f2-link-itemcontentid" value="0">
								<input type="hidden" name="mainiversoionno" id="f2-main-versionno" value="<%=pfmsdocdata[4]%>">
								<input type="hidden" name="mainitemcontentid" id="f2-main-itemcontentid" value="0">
						<!-- ------------------------------------------------------------------------------------------------------ -->
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />

								<%if(tempitemlist.size()>0 && isfrozen.equalsIgnoreCase("N") ){ %>
									<div align="center" style="margin-top: 5px;">
										<button type="submit" id="form-submit-btn"  class="btn btn-sm submit" name="action" value="add" onclick="return confirm('Are You Sure to Submit?');" >SUBMIT</button>
										<button type="button"  class="btn btn-sm edit" id="form-edit-btn"  name="action" value="edit" formaction="" onclick="return ShowDependentItems();" >UPDATE</button>
										<button type="button" class="btn btn-sm edit" id="form-link-btn" style="background-color: #8A39E1;border-color:#8A39E1 ;color: white;" name="action" value="link" id="form-edit-btn" onclick="return showSystemsList();">Link</button>
									</div>
								<%} %>
							</form>
							<%} %>
						</div>
					</div>
				
				</div>
			</div>
		</div>
	
<%if(docversionnos.size()>0){ %>
<!-- -----------------------------------------------------------------------  history modal -------------------------------------------------- -->
	<div class="modal" id="myModal">
    <div class="modal-dialog modal-dialog-centered modal-lg" >
      <div class="modal-content"   >
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Revision History</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div align="center"><b><%=headertext2%></b></div>
        	<form action="DocVersionDownload.htm" method="post" target="_blank">
	         	<table class="table table-bordered" id="MyTable">
	         		<tr>
	         			<th></th>
	         			<th>Version</th>
	         			<th>Revision Date</th>
	         			<th></th>
	         		</tr>
	         		<%	int count1=1;
	         			for(Object[] obj :docversionnos){ %>
		         		<tr>
		         			<td><%=count1 %></td>
		         			<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td>
		         			<td><%=obj[1]!=null?sdf1.format(sdf.parse(obj[1].toString())):" - " %> </td>
		         			<td>
		         				<button type="submit" class="btn btn-sm" name="versionno" value="<%=obj[0] %>">
									<i class="fa fa-download" aria-hidden="true" style="color: green"></i>
								</button>
		         			</td>
		         		</tr>
	         		<%} %>
	         	</table>
	         	<input type="hidden" name="pfmsdocid" value="<%=pfmsdocid %>" />
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
			</form>
        </div>
        
      
      </div>
    </div>
  </div>
<!-- -----------------------------------------------------------------------  history modal -------------------------------------------------- -->
<%} %>


<div class="modal" id="LinkModal"> 
	<div class="modal-dialog modal-dialog-centered modal-xl" style="max-width: 90%;">
		<div class="modal-content" >
		
			 <div class="modal-header">
		         <h4 >Document Linking</h4>
		         <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <div class="modal-body">
	        	<div class="row">
        			<div class="col-4" style="overflow-x:auto; ">
        				<div align="center" style="margin-bottom: 5px;">
        					<h5>Project Modules</h5>
        					<hr>
        				</div>
        				<div style="width: 100%;" id="modal-project-systems">
        				</div>        			
        			</div>
        			<div class="col-4" style="overflow-x:auto;">
        				<div align="center" style="margin-bottom: 5px;">
        					<h5>Documents</h5>
        					<hr>
        				</div>
        				<div style="width: 100%;" id="modal-systems-docs">
        				</div>        			
        			</div>
        			<div class="col-4" style="overflow-x:auto;">
        				<div align="center" style="margin-bottom: 5px;">
        					<h5>Document Items</h5>
        					<hr>
        				</div>
        				<div style="width: 100%;" id="modal-docs-items">
        				</div>        			
        			</div>
	        	</div>
	        </div>		
		
		</div>
	</div>
		
</div>


<div class="modal" id="LinkedItemsModal">
	<div class="modal-dialog modal-dialog-centered modal-xl" style="max-width: 50%;">
		<div class="modal-content" >
		
			 <div class="modal-header">
		         <h4 >Linked Items</h4>
		         <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <div class="modal-body">
	        	<div class="row">
        			<div class="col-12" style="overflow-x:auto; ">
        				<div align="center" style="margin-bottom: 5px;">
        					<div  >
        						<span title="this is a apan title abbr" style="font-weight: 600; color: red;">Updating This Content Will Affect the Following Content from Respective Documents</span>
        					</div>
        					<table style="width:100%;margin-top: 5px; ">
        						<thead>
        							<tr>
        								<th>SN</th>
        								<th>Document</th>
        								<th>Section</th>
        								<th>View</th>
        							</tr>
        						</thead>
        						<tbody id="links-modal-table">
        						
        						</tbody>
        					</table>        					
        				</div>        				      			
        			</div>        			
	        	</div>
	        </div>		
	        
	        <div class="modal-header" align="center">
		    	<div class="col-md-12">
		        	<button type="button" class="btn btn-danger"  data-dismiss="modal" onclick="SubmitUpdating()">OK</button>
		        	<button type="button" class="btn btn-secondary" data-dismiss="modal">CANCEL</button>
		    	</div> 
	        </div>
		
		</div>
	</div>
</div>
	
<div class="modal" id="ContentModal">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" style="max-width: 50%;">
		<div class="modal-content" >
		
			 <div class="modal-header">
		         <h4 >Content</h4>
		         <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <div class="modal-body">
	        	<div class="row">
        			<div class="col-12" style="overflow-x:auto; ">
        				<div align="center" style="margin-bottom: 5px;">
        					<h5 id="content-modal-itemname"></h5>
        					<hr>
        					<div id="content-modal-content" style="text-align: justify; overflow: auto;  " ></div>
        				</div>
        				      			
        			</div>
        			
	        	</div>
	        </div>		
		
		</div>
	</div>
</div>

	

<script type="text/javascript">


	 function SubmitUpdating ()
	 {
	 	if(confirm('Are You Sure To Update ?')){
	 		$('#f2').attr('action', 'TempItemContentUpdate.htm'); 		   
	 		$('#f2').submit();
	 	}
	 }


function ShowDependentItems()
{
	maintempcontentid = $('#form-itemcontentid').val();
	$.ajax({
		type : 'GET',
		url : 'ItemLinksListAjax.htm',
		datatype : 'json',
		data : {
			
			maintempcontentid : maintempcontentid,
			
		},
		success : function(result){
			
			if(result!=='null' && $('#form-depend').val()==='Y'){
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e]
				})
				var z=0;
				let html='';
				for(z=0;z<values.length;z++)
				{
					html +='<tr>';
					html +='<td>'+(z+1)+'</td>';
					html +='<td>'+values[z][7]+' ('+values[z][6]+')'+'</td>';
					html +='<td>'+values[z][3]+'</td>';
					html +='<td>';
					
					html += '	<button type="button" class="btn" onclick=" contentPreview('+values[z][0]+')" data-toggle="tooltip" data-placement="top" title="Preview Content" style="background-color: transparent;margin: -5px 0px;" >';
					html += '	<i class="fa fa-eye" aria-hidden="true"></i>';
					html += '	</button>';
					
		            html +='</td>';
					html +='</tr>';
					
				}
				
					$('#links-modal-table').html(html);
					$('#LinkedItemsModal').modal('toggle');
				
				
			}else if($('#form-depend').val()==='N'){
				SubmitUpdating();
			}
		},
		error: function()
		{
			alert('Internal Error Occured !');
		}
		
	})	
}
</script>


<script type="text/javascript">


 

 function contentPreview(tempcontentfrzid)
{
	$.ajax({
		type : 'GET',
		url : 'ItemsFrzContentAjax.htm',
		datatype : 'json',
		data : {
			
			tempcontentfrzid : tempcontentfrzid,
			
		},
		success : function(result){
			
			if(result!=='null'){
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e]
				})
				
				$('#content-modal-itemname').html(values[1]);
				$('#content-modal-content').html(values[2]);
				$('#ContentModal').modal('toggle');
				
				
			}else
			{
				alert('Internal Error Occured !');
			}
		},
		error: function()
		{
			alert('Internal Error Occured !');
		}
		
	})
	
	
}

 function showSystemsList()
{
	$("#modal-systems-docs").html('');
	$("#modal-docs-items").html('');
	$.ajax({
		type : 'GET',
		url : 'DocProjectSystemsAjax.htm',
		datatype : 'json',
		data : {
					
			projectid : <%=projectid%>
		},
		success : function(result){
			
			if(result!=='null'){
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e]
				})
				
				let htmlstr ='<ul>';
				for(var s1=0;s1<values.length;s1++){
					
					if(values[s1].LevelId==1){
						
						htmlstr += '<li>';
						htmlstr += '<span class="caret" id="system'+values[s1].FileRepMasterId+'" onclick="onclickchangeMain(this);" >';
						htmlstr +=	values[s1].LevelName ;
		             	htmlstr += '</span>';
		             	htmlstr += '<span>';				           
						htmlstr += '</span>';
						htmlstr += '<ul  class="nested">';
						htmlstr += '<li>';
			<!-- ----------------------------------------level 1------------------------------------- -->	
								for(var s2 =0;s2<values.length;s2++){
					
									if(values[s2].LevelId==2 && values[s2].ParentLevelId==values[s1].FileRepMasterId) {
										
										htmlstr += '<li>';
										htmlstr += '<span class="caret" id="system'+values[s2].FileRepMasterId+'" onclick="onclickchangeMain(this);" >';
										htmlstr +=	values[s2].LevelName ;
										htmlstr += '</span>';
						             	htmlstr += '<span>';
						             	htmlstr += '	<button type="button" onclick="ShowrepMasterDocs('+values[s2].FileRepMasterId+')" id="upbutton'+values[s2].FileRepMasterId+'"  data-toggle="tooltip" data-placement="top" title="View Module Documents"  class="btn"  style="background-color: transparent;margin: -5px 0px;" >';
						             	htmlstr += '	<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>';
						             	htmlstr += '</button>';
						             	htmlstr += '</span>';
						             	htmlstr += '<ul  class="nested">';
										htmlstr += '<li>';
							<!-- ----------------------------------------level 2------------------------------------- -->	
													for(var s3 =0;s3<values.length;s3++){
					
													if(values[s3].LevelId==3 && values[s3].ParentLevelId==values[s2].FileRepMasterId){
														htmlstr += '<li>';
														htmlstr += '<span class="caret" id="system'+values[s3].FileRepMasterId+'" onclick="onclickchangeMain(this);" >';
														htmlstr +=	values[s3].LevelName ;
														htmlstr += '</span>';
										             	htmlstr += '<span>';
										             	htmlstr += '	<button type="button" onclick="ShowrepMasterDocs('+values[s3].FileRepMasterId+')" id="upbutton'+values[s3].FileRepMasterId+'"   data-toggle="tooltip" data-placement="top" title="View Module Documents"  class="btn"  style="background-color: transparent;margin: -5px 0px;" >';
										             	htmlstr += '	<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>';
										             	htmlstr += '</button>';
										             	htmlstr += '</span>';
										             	htmlstr += '<ul  class="nested">';
														htmlstr += '<li>';
												<!-- ----------------------------------------level 3------------------------------------- -->	
																		for(var s4 =0;s4<values.length;s4++){
					
																		if(values[s4].LevelId==4 && values[s4].ParentLevelId==values[s3].FileRepMasterId){
																			htmlstr += '<li>';
																			htmlstr += '<span class="caret" id="system'+values[s4].FileRepMasterId+'" onclick="onclickchangeMain(this);" >';
																			htmlstr +=	values[s4].LevelName ;
																			htmlstr += '</span>';
															             	htmlstr += '<span>';
															             	htmlstr += '	<button type="button" onclick="ShowrepMasterDocs('+values[s4].FileRepMasterId+')" id="upbutton'+values[s4].FileRepMasterId+'" data-toggle="tooltip" data-placement="top" title="View Module Documents"  class="btn"  style="background-color: transparent;margin: -5px 0px;" >';
															             	htmlstr += '	<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>';
															             	htmlstr += '</button>';
															             	htmlstr += '</span>';
															             	htmlstr += '<ul  class="nested">';
																			htmlstr += '<li>';
																	<!-- ----------------------------------------level 4------------------------------------- -->	
																						for(var s5 =0;s5<values.length;s5++){
					
																						if(values[s5].LevelId==5 && values[s5].ParentLevelId==values[s4].FileRepMasterId){

																							htmlstr += '<li>';
																								
																							htmlstr += ' <span class="caret-last"  id="system'+values[s5].FileRepMasterId+'" onclick="onclickchangeMain(this);" >';
																							htmlstr +=	values[s5].LevelName ;
																							htmlstr += '</span>';
																			             	htmlstr += '<span>';
																			             	htmlstr += '	<button type="button" onclick="ShowrepMasterDocs('+values[s5].FileRepMasterId+')" id="upbutton'+values[s5].FileRepMasterId+'" class="btn" data-toggle="tooltip" data-placement="top" title="View Module Documents"  style="background-color: transparent;margin: -5px 0px;" >';
																			             	htmlstr += '	<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>';
																			             	htmlstr += '</button>';
																			             	htmlstr += '</span>';
																			             	htmlstr += '<li>';		
																								
																							}
																						} 			
																				
																	<!-- ----------------------------------------level 4------------------------------------- -->
																			htmlstr += '</li>';
																			htmlstr += '</ul>';
																			htmlstr += '</li>';	
																			}
																		} 	
															
												<!-- ----------------------------------------level 3------------------------------------- -->
												htmlstr += '</li>';
												htmlstr += '</ul>';
												htmlstr += '</li>';
													}
												}
										
							<!-- ----------------------------------------level 2------------------------------------- -->
							htmlstr += '</li>';
							htmlstr += '</ul>';
							htmlstr += '</li>';
									}
								} 
						
			<!-- ----------------------------------------level 1------------------------------------- -->
			htmlstr += '</li>';
			htmlstr += '</ul>';
			htmlstr += '</li>';
					}
				} 
		htmlstr += '</ul>';
				
				
				
				$("#modal-project-systems").html(htmlstr);
				$('#LinkModal').modal('toggle');
				setTooltip();
				docready();
			}
		},
		error: function()
		{
			alert('Internal Error Occured !');
		}
		
	})
	
}





function ShowrepMasterDocs(filerepmasterid)
{
	$("#modal-systems-docs").html('');
	$("#modal-docs-items").html('');
	let thisdocid=<%=pfmsdocid%>;
	$.ajax({
		type : 'GET',
		url : 'ProjectDocsAllAjax.htm',
		datatype : 'json',
		data : {
					
			filerepmasterid : filerepmasterid,
		},
		success : function(result){
			
				if(result!=='null'){
					var result= JSON.parse(result);
					var values= Object.keys(result).map(function(e){
						return result[e]
					})				
					var s1=0;
					let htmlstr ='<ul>';
					for(s1=0;s1<values.length;s1++)
					{
						if(thisdocid!=values[s1][6] && values[s1][0]!=null )
						{
							htmlstr +='<li>';
							htmlstr +=  values[s1][3]+' ('+values[s1][4]+')';
							htmlstr += '<button type="button" class="btn" onclick="ShowDocItemsList('+values[s1][6]+','+values[s1][7]+')"  style="background-color: transparent;margin: -5px 0px;" data-toggle="tooltip" data-placement="top" title="View Content">';
				            htmlstr += '<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>';
				            htmlstr += '</button>';
							htmlstr +='</li>';
						}
					}
					htmlstr +='</ul>';
					if(s1==0){
						htmlstr='<ul><li>list not found</li></ul>';
					}
					$("#modal-systems-docs").html(htmlstr);
					setTooltip();
					
			}
		},
		error: function()
		{
			alert('Internal Error Occured !');
		}
		
	})
	
}


 function ShowDocItemsList(pfmsdocid,versionno)
{
	$('#f2-link-versionno').val(versionno);
	$.ajax({
		type : 'GET',
		url : 'DocItemsAllAjax.htm',
		datatype : 'json',
		data : {
					
			pfmsdocid : pfmsdocid,
			mainitemcontentid : $('#f2-main-itemcontentid').val(),
		},
		success : function(result){
			
			if(result!=='null'){
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e]
				})
				console.log(values);
				
				let count1=count2=count3=1;
				let htmlstr ='<table> ';
				for(var s1=0;s1<values.length;s1++)
				{
					if(values[s1][3]==1)
					{
						 htmlstr +='<tr><td>';
						 if(values[s1][7]!==null){
						 	htmlstr += '<b style="color:green;">'+count1+')'+values[s1][6]+'</b>';
						 }else{
							 htmlstr += count1+')'+values[s1][6];
						 }
						 if(values[s1][7]===null){
							 htmlstr += '	<button type="button" class="btn" onclick=" SubmitLinking('+values[s1][2]+')" data-toggle="tooltip" data-placement="top" title="Link this Item" style="background-color: transparent;margin: -5px 0px;" >';
				             htmlstr += '	<i class="fa fa-link" aria-hidden="true"></i>';
				             htmlstr += '	</button>';
						 }
						 htmlstr += '	<button type="button" class="btn" onclick=" contentPreview('+values[s1][0]+')"  data-toggle="tooltip" data-placement="top" title="Preview Content"  style="background-color: transparent;margin: -5px 0px;" >';
			             htmlstr += '	<i class="fa fa-eye" aria-hidden="true"></i>';
			             htmlstr += '	</button>';
			             
						 htmlstr +='</td></tr>';
/* --------------------------------------------------------------------------------------------------------------- */								 
						 for(var s2=0;s2<values.length;s2++)
							{
								if(values[s2][3]==2 && values[s1][1]==values[s2][4] )
								{
									htmlstr +='<tr><td style="padding-left:10px;">';
									if(values[s2][7]!==null){
									 	htmlstr += '<b style="color:green;" >'+count1+'.'+count2+')'+values[s2][6]+'</b>';
									 }else{
										 htmlstr += count1+'.'+count2+')'+values[s2][6];
									 }
									 if(values[s2][7]===null){
										 htmlstr += '	<button type="button" class="btn" onclick=" SubmitLinking('+values[s2][2]+')" data-toggle="tooltip" data-placement="top" title="Link this document" style="background-color: transparent;margin: -5px 0px;" >';
							             htmlstr += '	<i class="fa fa-link" aria-hidden="true"></i>';
							             htmlstr += '	</button>';
									 }
									 htmlstr += '	<button type="button" class="btn" onclick=" contentPreview('+values[s2][0]+')" data-toggle="tooltip" data-placement="top" title="Preview Content" style="background-color: transparent;margin: -5px 0px;" >';
						             htmlstr += '	<i class="fa fa-eye" aria-hidden="true"></i>';
						             htmlstr += '	</button>';
						             
						             
									 htmlstr +='</td></tr>';
				/* --------------------------------------------------------------------------------------------------------------- */								 
									 for(var s3=0;s3<values.length;s3++)
										{
											if(values[s3][3]==3 && values[s2][1]==values[s3][4] )
											{
												 htmlstr +='<tr><td style="padding-left:20px;">';
												 if(values[s3][7]!==null){
												 	htmlstr += '<b style="color:green;" >'+count1+'.'+count2+'.'+count3+')'+values[s3][6]+'</b>';
												 }else{
													 htmlstr += +count1+'.'+count2+'.'+count3+')'+values[s3][6];
												 }
												 if(values[s3][7]===null){ 
													 htmlstr += '	<button type="button" class="btn" onclick=" SubmitLinking('+values[s3][2]+')" data-toggle="tooltip" data-placement="top" title="Link this document" style="background-color: transparent;margin: -5px 0px;" >';
										             htmlstr += '	<i class="fa fa-link" aria-hidden="true"></i>';
										             htmlstr += '	</button>';
												 }
												 htmlstr += '	<button type="button" class="btn" onclick=" contentPreview('+values[s3][0]+')" data-toggle="tooltip" data-placement="top" title="Preview Content" style="background-color: transparent;margin: -5px 0px;" >';
									             htmlstr += '	<i class="fa fa-eye" aria-hidden="true"></i>';
									             htmlstr += '	</button>';
									             
												 htmlstr +='</td></tr>';
												 count3++;
											}
										}
				/* --------------------------------------------------------------------------------------------------------------- */										 
									 count2++;
								}
							}
/* --------------------------------------------------------------------------------------------------------------- */						 
						 count1++; 
					}
				}
				htmlstr +='</table>';
				
				$("#modal-docs-items").html(htmlstr);
				setTooltip();
				
			}
		},
		error: function()
		{
			alert('Internal Error Occured !');
		}
	})
}



 function SubmitLinking (tempcontentid)
{
	$('#f2-link-itemcontentid').val(tempcontentid);
	if(confirm('Are You Sure To Link This Item ?')){
		$('#f2').attr('action', 'DocContentLinkAdd.htm'); 		   
		$('#f2').submit();
		
	}
}



 function onclickchangeMain(ele)
{
	elements = document.getElementsByClassName('caret');
	for (var i1 = 0; i1 < elements.length; i1++) {
		$(elements[i1]).css("color", "black");
		$(elements[i1]).css("font-weight", "");
	}
	elements = document.getElementsByClassName('caret-last');
	for (var i1 = 0; i1 < elements.length; i1++) {
		$(elements[i1]).css("color", "black");
		$(elements[i1]).css("font-weight", "");
	}
	$(ele).css("color", "green");
	$(ele).css("font-weight", "700");
}


 function docready(){

	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}
}

 function setTooltip()
{
	$('[data-toggle="tooltip" ]').tooltip({ trigger: "hover" });
}

$(document).ready( function docready(){
	
	setTooltip();
	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  	toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}
});


</script>


<script type="text/javascript">
$("#MyTable").DataTable({
	 "destroy": true,							 
	 "lengthMenu": [5,10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5,
	 "language": {
	      "emptyTable": "Files not Found"
	    }
}); 


 function getItemData(ItemId,level,l1name,l2name,collapseids,temp)
{
	$('#form-collapseids').val(collapseids);
	$.ajax({
		type : 'GET',
		url : 'DocTempItemDataAjax.htm',
		datatype : 'json',
		data : {
			
			itemid : ItemId,
			pfmsdocid : <%=pfmsdocid%>
		},
		success : function(result){
			
			if(result!=='null'){
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e]
				})
				
				$('#form-templateitemid').val(values[0]);
				
				CKEDITOR.instances.summernote.setData(values[5], function() { this.resetUndo(); });
								
				if(values[4]==null)
				{
					$('#form-submit-btn').show();
					$('#form-edit-btn').hide();
					$('#form-link-btn').hide();
					$('#isindependent').click();
				}else{
					$('#form-itemcontentid').val(values[4]);
					$('#f2-main-itemcontentid').val(values[4]);
					
					$('#form-submit-btn').hide();
					$('#form-edit-btn').show();
					
					if(values[6]==='Y'){						
						$('#isdependent').click();	
						$('#form-link-btn').show();										
						
					}else if(values[6]==='N'){						
						$('#isindependent').click();	
						$('#form-link-btn').hide();		
					}
					$('#form-depend').val(values[6]);
				}
				
				
				
				if(level==0){
					$('#e-header').html(values[3]); 
				}else if(level==1){
					$('#e-header').html(l1name+' / '+values[3]); 
				}else if(level==2){
					$('#e-header').html(l1name+' / '+l2name+' / '+values[3]); 
				}
				
				
			}else
			{
				alert('Internal Error Occured !');
			}
		},
		error: function()
		{
			alert('Internal Error Occured !');
		}
		
	})
	
	
}


</script>
	
<script type="text/javascript">
$(document).ready(function(){
   
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".faplus").addClass("fa-minus").removeClass("fa-plus");
    });
    
   
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-minus").addClass("fa-plus");
    });
});

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
        },
        {
            name: 'lineheight',
            items: ['1.5', ]
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

<script type="text/javascript">

<% if(collapseids!=null){%>
$(document).ready(function() {
	
 var $collapseids='<%=collapseids%>';
 var colids = $collapseids.split('-');
 
 for(let i=0;i<colids.length;i++)
 {	
	 if(i==colids.length-1){
		$('#btn-clk-'+colids[i]).click();
		break;
	 }
	$('#collapse-'+colids[i]).click(); 
 }
 
});

<%}else{%>
$(document).ready(function() {
	$('#btn-clk-<%=temp%>').click();
});
<%}%>
</script>
</body>
</html>