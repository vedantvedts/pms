<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">

	  
<title>PFMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>


<style>

.control-label{
	font-weight: bold !important;
}


.table thead th{
	
	vertical-align: middle !important;
}

.header{
        position:sticky;
        top: 0 ;
        background-color: #346691;
    }
    
    .table button{
    	
    	font-size: 12px;
    }
    
 label{
 	font-size: 15px !important;
 }
 
 td
{
    text-align: center; 
    vertical-align: middle;
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

<!-- ---------------- tree ----------------- -->
<!-- -------------- model  tree   ------------------- -->
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
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6  ";
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
</style>

<!-- ---------------- model tree ----------------- -->



</head>
<body>


<%

List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");
String ProjectId = (String) request.getAttribute("ProjectId");

String MainSystemValue = (String) request.getAttribute("MainSystemValue");
String s1 = (String) request.getAttribute("s1");
String s2 = (String) request.getAttribute("s2");
String s3 = (String) request.getAttribute("s3");
String s4 = (String) request.getAttribute("s4");
String sublevel = (String) request.getAttribute("sublevel");
String doclev1 = (String) request.getAttribute("doclev1");
String doclev2 = (String) request.getAttribute("doclev2");
String doclev3 = (String) request.getAttribute("doclev3");
String GlobalFileSize=(String) request.getAttribute("GlobalFileSize");
String projectname="";
List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");

%>




<%
String ses=(String)request.getParameter("result"); 
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
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>



<div class="container-fluid"> 
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover" style="min-height: 34rem;">
			<form  method="post" action="TestingFileRepo.htm" id="myform">	
				<div class="card-header">
						<div class="row">
								<div class="col-md-6">
									<h3 class="control-label" >Document Upload</h3>
								</div>
								<div class="col-md-6">
									<table style="float: right;">
										<tr>
											<td><label class="control-label">Project :&nbsp;&nbsp; </label></td>
									    	<td>
									    		<select class="form-control selectdee" id="ProjectId" required="required"  name="projectid" onchange="$('#myform').submit();">
										    		<option disabled="disabled"   value="">Choose...</option>
										    		<option value="0"  <%if(ProjectId.equalsIgnoreCase("0")){ projectname="General"; %>selected="selected" <%} %>>General</option>
										    			<% for (Object[] obj : ProjectList) {%>
															<option value="<%=obj[0]%>"  <%if(ProjectId.equalsIgnoreCase(obj[0].toString())){ projectname=obj[4].toString(); %>selected="selected" <%} %>> <%=obj[4]%>  </option>
														<%} %>
									  			</select>
									  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									  		</td>
									  	</tr>
									</table>
								</div>
						</div>
					</div>
				</form>
		



				<div class="card-body"> 
					<div class="row">
<!-- --------------------------------------------left page ----------------------------------------------------->
					<div class="col-md-5" >		
<!-- -------------------------------- tree ----------------------------- -->
						<div class="row" style="height: 28rem; overflow-y:auto;verflow-x:auto; ">		
							<ul>	
							<%for(Object[] obj :filerepmasterlistall)
							{ 
								if(Long.parseLong(obj[1].toString())==0)
								{%>  
								<li>
									<span class="caret" id="system<%=obj[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','-','','-','','-','','-','',0,this)" >
					             		<%=obj[3] %>
					             	</span>
					             	<span>
							            <button type="button" class="btn"  style="background-color: transparent;margin: -5px 0px" onclick="batchdownload('<%=obj[0]%>')">                                     
											<i class="fa fa-download" aria-hidden="true"></i>
										</button>
					             	</span>
									<ul  class="nested">
										<li>
						<!-- ----------------------------------------level 1------------------------------------- -->	
											<%for(Object[] obj1 :filerepmasterlistall)
											{ 
												if(Long.parseLong(obj1[1].toString())==Long.parseLong(obj[0].toString()))
												{%>  
												<li>
													<span class="caret" id="system<%=obj1[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','-','','-','','-','',1,this)" >
					             						<%=obj1[3] %>
					             					</span>
													<span>
														<button type="button" id="upbutton<%=obj1[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','-','','-','','-','',1)">
							             					<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>
							             				</button>
							             				<button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj1[0]%>')">                                     
															<i class="fa fa-download" aria-hidden="true"></i>
														</button>
					             					</span>
													<ul  class="nested">
														<li>
										<!-- ----------------------------------------level 2------------------------------------- -->	
																<%for(Object[] obj2 :filerepmasterlistall)
																{ 
																	if(Long.parseLong(obj2[1].toString())==Long.parseLong(obj1[0].toString()))
																	{ %>  
																	<li>
																		<span class="caret" id="system<%=obj2[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','-','','-','',2,this)" >
																			<%=obj2[3] %>
																		</span>
																		<span>
																			<button type="button" id="upbutton<%=obj2[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','-','','-','',2)">
											             						<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>
											             					</button>
											             					<button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj2[0]%>')">                                     
																				<i class="fa fa-download" aria-hidden="true"></i>
																			</button>
											             					
									             						</span>
																		<ul  class="nested">
																			<li>
															<!-- ----------------------------------------level 3------------------------------------- -->	
																					<%for(Object[] obj3 :filerepmasterlistall)
																					{ 
																						if(Long.parseLong(obj3[1].toString())==Long.parseLong(obj2[0].toString()))
																						{%>  
																						<li>
																							<span class="caret" id="system<%=obj3[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','-','',3,this)" >
																								<%=obj3[3] %>
																							</span>
																							<span>
																								<button type="button" id="upbutton<%=obj3[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','-','',3)">
																             						<i class="fa fa-upload" style="color: #007bff;" aria-hidden="true" ></i>
																             					</button>
																             					<button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj3[0]%>')">                                     
																									<i class="fa fa-download" aria-hidden="true"></i>
																								</button>
														             						</span>
																							<ul  class="nested">
																								<li>
																				<!-- ----------------------------------------level 4------------------------------------- -->	
																									<%for(Object[] obj4 :filerepmasterlistall)
																									{ 
																										if(Long.parseLong(obj4[1].toString())==Long.parseLong(obj3[0].toString()))
																										{%>  
																										<li>
																											
																												<span class="caret-last"  id="system<%=obj4[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','<%=obj4[0]%>','<%=obj4[3] %>',4,this)">
																													<%=obj4[3] %>
																												</span>
																												<span> 
																													<button type="button" id="upbutton<%=obj4[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','<%=obj4[0]%>','<%=obj4[3] %>',4)">
																					             						<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>
																					             					</button>
																					             					
																					             					<button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj4[0]%>')">                                     
																														<i class="fa fa-download" aria-hidden="true"></i>
																													</button> 
																					             					
																			             						</span>
																											
																										</li>	
																									<%}
																									} %>			
																							
																				<!-- ----------------------------------------level 4------------------------------------- -->
																								</li>
																							</ul>
																						</li>	
																					<%}
																					} %>	
																		
															<!-- ----------------------------------------level 3------------------------------------- -->
																			</li>
																		</ul>
																	</li>	
																<%}
																} %>		
													
										<!-- ----------------------------------------level 2------------------------------------- -->
														</li>
													</ul>
												</li>	
											<%}
											} %>
									
						<!-- ----------------------------------------level 1------------------------------------- -->
										</li>
									</ul>
								</li>	
							<%}
							} %>
							</ul>							
						</div>
<!-- -------------------------------- tree end ----------------------------- -->				
					</div>
<!-- ------------------------------------------left page end --------------------------------------------- -->	



						<div class="col-md-7 border" >
							<div  style="font-size: 17px;padding-top :10px !important;padding-bottom: 25px !important ;" align="center">
								<span id="tablehead" style="display:inline;color: black;font-style: italic;"></span>
							</div>
							<div style="overflow-y: auto;width: 100%; max-height: 35rem;"  >
								<div class="table-responsive " >
				   					<table class="table table-bordered " style="width: 100%;"  id="MyTable1" > 
										<thead>
											<tr>
												<th style="width: 4%;text-align: center;" >SN</th>
												<th style="width: 10%;text-align: center;">DocId</th>
												<th style="width: 60%;text-align: center;">Name</th>
												<th style="width: 15%;text-align: center;" >UpdateOn</th>
												<th style="width: 5%;text-align: center;" >Ver</th>
												<th><i class="fa fa-download" aria-hidden="true"></th>
												<th><i class="fa fa-history" aria-hidden="true"></th>	
											</tr>
										</thead>
										<tbody id="flisttbody">
										
										</tbody>
									</table>		
								</div>	
							</div>			
						</div>	
					</div> 
				</div> 
			</div>
		</div>
	</div>
</div>			

<!-- --------------------------------- Modal Start ---------------------------------------------- -->
	
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 1000px !important">
					<div class="modal-content">
						<div class="modal-header" style="background-color: rgba(0,0,0,.03);">
							<h4 class="modal-title" id="exampleModalLongTitle" style="color: #145374">Document History</h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
					          <span aria-hidden="true">&times;</span>
					        </button>
						</div>
						<div class="modal-body"  style="padding: 0.5rem !important">
							<div class="card shadow-nohover">
								<div class="card-body">
									<h5 style="display:inline;color: black;font-style: italic;" align="center">
										<span id="modelhead"></span>
									</h5>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">	
									<div class="card shadow-nohover">
										<div class="card-body"> 
											<table class="table table-bordered " style="width: 100%;"  id="MyTable" > 
												<thead>
													<tr>
														<th>SN</th>
														<th>DocId</th>
														<th>Doc Name</th>
														<th>Updated Date</th>
														<th>Version</th>
														<th>Download</th>
													</tr>
												</thead>
												<tbody id="fhislisttbody">
												
												</tbody>
											</table>
										</div> 
									</div> <!-- card end -->
								</div>
							</div> 
						</div>
					</div>
					
				</div>
			</div>
			
<!-----------------------------------------------Modal End ----------------------------------------  -->
<!-- --------------------------------------------  model start  -------------------------------------------------------- -->	

		<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 93% !important;">
		
				<div class="modal-content" >
					   
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				      
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374"></h4>
	
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				        				        
				    </div>
					<div class="modal-body"  style="padding: 0.5rem !important;">
							
							<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
				<!-- --------------------------------------- upload box -------------------------- -->
								<div class="row">
													
									<form autocomplete="off" method="POST" action="FileSubAddNew.htm"  name="modelform" 
									id="modelform" enctype="multipart/form-data" style="width:100% " >
										<div id="uploadbox" style="display: none;">					
											  <div class="card shadow-nohover" style="margin-top: -20px;" >	
													<div class="col-md-12">	
															<div class="row" >
																<div class="col-md-9">	
																	<h4 id="upload-card-header" style="color: #3DB2FF"></h4>
																</div>
																<div class="col-md-3" align="right"  >	
																	<h4 style="color: #3DB2FF" style="float: right;" >(Document)</h4>
																</div>
															</div>
															<hr style="width: 100%">
															<div class="row" style=" ">
												             	<div class="col-md-4 ">
													                <div class="form-group">
													                	<label class="control-label">Document Name</label>
																		<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="FileName" name="FileName" required="required" />
													                </div>
												             	</div>
												             	<div class="col-md-2 ">
												             	 	<div class="form-group">
												                    	<label class="control-label">Prev. Version <span id="prevversion"></span></label>
													             	 	<div id="downloaddiv">
													             	 	
													             	 	</div>
													             	 </div>
												             	 </div>
												             	<div class="col-md-4 ">
												             		<div class="form-group">
												                    	<label class="control-label">Upload</label> 
																		<input type="file" name="FileAttach" id="FileAttach" onchange="Filevalidation('FileAttach');"  class="form-control " aria-describedby="inputGroup-sizing-sm" maxlength="255" style="width:260px;" />
												                    </div>
												             	</div>
												             	<div class="col-md-2 ">
												             		<div class="form-group">
												                    	<label class="control-label">Is New Version</label> <br>
																		<input type="radio" name="isnewver" id="isnewvery"  value="Y"  />&nbsp;&nbsp;Yes &emsp;
																		<input type="radio" name="isnewver" id="isnewvern" checked="checked" value="N"  />&nbsp;&nbsp;No
												                    	
												                    </div>
												             	</div>
															</div>
															<div class="row" style="margin-top: -15px;" >
																
																<div class="col-md-12 ">
																		 <div id="showdesc">
																		 	<div class="form-group">
													                            <label class="control-label">Previous Version/Release Description</label><br>
																				<span id="modeldescshow"   ></span>
												                     	   </div>
												                        </div>
												                        <div class="form-group" >
												                            <label class="control-label">Version/Release Description</label>
																			<input class="form-control" name="description" id="modeldesc" maxlength="512"  >
												                        </div>
													             	</div>
																</div>
																
																<div  align="center">
																	<input type="submit" class="btn btn-primary btn-sm submit" style="margin-bottom: 5px;"  id="submitversion" onclick="return submitFileSizeCheck('modelform','FileSubAddNew.htm','FileAttach');" />
															   </div>
														</div>
														
												 </div>  
											</div>
									<!-- --------------------------------------- ammend upload box -------------------------- -->
											<div  id="ammendmentbox"  style="display: none;margin-top: -20px;">
												<div class="card shadow-nohover" style="padding: 10px;">
													
														<div class="row" >
															<div class="col-md-9">	
																<h4 id="upload-card-header1" style="color: #3DB2FF"></h4>
															</div>
															<div class="col-md-3" align="right" >	
																<h4 style="color: #3DB2FF" style="float: right;" >(Amendment)</h4>
															</div>
														</div>
														<hr style="width: 100%">
														
														<div class="row">
															<div class="col-md-4">
																<div class="form-group">
														        	<label class="control-label">Amendment File</label> 
																	<input type="file" name="AmendFileAttach" id="AmendFileAttach" class="form-control" onchange="Filevalidation('AmendFileAttach');" aria-describedby="inputGroup-sizing-sm" maxlength="255" style="width:100%;" required="required"/>
														        </div>
															</div>
															<div class="col-md-8">
																<div class="form-group" >
															        <label class="control-label">Description</label>
																	<input class="form-control" name="Amenddescription" id="Amenddescription" maxlength="512"   />
														        </div>
															</div>
														</div>
													
													<input type="hidden" name="uploaddocid" id="uploaddocid" value="" />
													
													<div  align="center">
														<button type="submit" onclick="return submitFileSizeCheck('modelform','AddDocAmendment.htm','AmendFileAttach');" class="btn btn-primary btn-sm submit" formaction="AddDocAmendment.htm" style="margin-bottom: 5px;"  >Upload <span id="amendsubversion"></span> </button>
													</div>
												</div>
											</div>
									<!-- --------------------------------------- ammend upload box -------------------------- -->
											<input type="hidden" name="mainsystemval" id="mainsystemval" value="" />
											<input type="hidden" name="sublevel" id="sublevel" value="" />
											<input type="hidden" name="s1" id="s1" value="" />
											<input type="hidden" name="s2" id="s2" value="" />
											<input type="hidden" name="s3" id="s3" value="" />
											<input type="hidden" name="s4" id="s4" value="" />
											<input type="hidden" name="projectidvalue" id="projectidvalue" value="<%=ProjectId %>" />
											<input type="hidden" name="projectname" id="projectname" value="<%=projectname %>" />
											<input type="hidden" id="Path" name="Path" value="" />
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											<input type="hidden" id="Rev" name="Rev" value="" />
											<input type="hidden" id="Ver" name="Ver"  value="" />
											<input type="hidden" id="documenttitle" name="documenttitle" />
											<input type="hidden" id="doclev1" name="doclev1" value="" />
											<input type="hidden" id="doclev2" name="doclev2" value="" />			
									</form>
								</div>	
						<!-- --------------------------------------- upload box -------------------------- -->
								<div class="row">
										<div class="col-md-8">
											<div style="margin-top: 5px;" id="fileuploadlist">
							
											</div>
										</div>
										<div class="col-md-4">
											<div style="margin-top: 5px; display: none;border: 1px solid black; border-radius: 5px;" id="amendmentbox">
												<div align="center">
													<h4>Amendment(s) <span id="docno"></span> <img style="height:30px; width: 30px; " src="view/images/amendment-icon.png"> 
														<span id="amendzipdownbtn"></span>
													</h4>
												</div>
												<hr>
												<div >
													<table id="amendmentlist" style="width: 100%; margin-bottom: 3px;">
														
													</table>
												</div>
											</div>
										</div>
				             		</div>					
							</div>
						
					</div>
				</div>
			</div> 
		</div>
		
			
<!-- --------------------------------------------  model end  -------------------------------------------------------- -->

<form method="POST" action="AmendFileUnpack.htm"  id="amenddownloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="amendfileid" id="amendfileid" value="" />
</form>

<form method="POST" action="FileUnpack.htm"  id="downloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="FileUploadId" id="FileUploadId" value="" />
</form>

<form method="POST" action="AmendmentFilesZipDownload.htm"  id="amendzipdownload" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="Amendfileid" id="amendfileidzip" value="" /> 
</form>

<form method="POST" action="DocumentsZipDownload.htm"  id="batchdownloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="filerepmasterid" id="filerepmasterid" value="" />  
</form>

<!-- ------------------------------------------------- basic script ---------------------------------------------------------------  -->
 <script type="text/javascript">

 <%=GlobalFileSize%>
 
function Filevalidation (fileid) 
{
    const fi = $('#'+fileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (file >= <%=GlobalFileSize%> ) 
    {
    	alert("File too Big, please select a file less than <%=GlobalFileSize%> mb");
    } 
}

function submitFileSizeCheck(formid,action,inputid)
{
	
	$('#'+formid).attr('action', action);
	const fi = $('#'+inputid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(inputid).files.length !=0 && file >= <%=GlobalFileSize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=GlobalFileSize%> mb");
    } else
    {
    	 return confirm('Are You Sure To Submit?');
    }
}


$(document).ready(function(){

	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}


	$('#tablehead').html($('#projectname').val());
	
	  $("#MyTable1").DataTable({		 
		 "lengthMenu": [5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5,
		 "language": {
		      "emptyTable": "Files not Found"
		    }
	});
	  
}); 

<%if(MainSystemValue!=null){%>

$(document).ready(function  (){
	
			var $mainid='<%=MainSystemValue%>';
			var $s1='<%=s1%>';
			var $s2='<%=s2%>';
			var $s3='<%=s3%>';
			var $s4='<%=s4%>';
			var $sublevel=<%=sublevel%>;
			
			$('#system'+$mainid).click();
			if($sublevel>=1)
			{
				$('#system'+$s1).click();
				if($sublevel==1)
				{
					$('#upbutton'+$s1).click();
				}
			}
			if($sublevel>=2)
			{
				$('#system'+$s2).click();
				if($sublevel==2)
				{
					$('#upbutton'+$s2).click();
				}
			}
			if($sublevel>=3)
			{
				$('#system'+$s3).click();
				if($sublevel==3)
				{
					$('#upbutton'+$s3).click();
				}
			}
			if($sublevel>=4)
			{
				$('#system'+$s4).click();
				if($sublevel==4)
				{
					$('#upbutton'+$s4).click();
				}
			}
			
		});
<%}%>



$('input:radio[name="isnewver"]').change(function(){	
    if($(this).val() == 'Y'){
    	var ver=Number($('#Ver').val())+1;
    	$('#submitversion').val("Upload Version "+ver+'.0');
    }
    if($(this).val() == 'N'){
    	var ver=Number($('#Ver').val());
    	var rel=Number($('#Ver').val());
    	$('#submitversion').val("Upload Version "+ver+'.'+rel);
    }
});


function onclickchange(ele)
{
	elements = document.getElementsByClassName('caret-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret-last-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");

}



function FileDownload(fileid1)
{
	$('#FileUploadId').val(fileid1);
	$('#downloadform').submit();
}

function AmendFileDownload(fileid1)
{
	$('#amendfileid').val(fileid1); 
	$('#amenddownloadform').submit();
}
function AmendZipFileDownload(fileid1)
{ 
	$('#amendfileidzip').val(fileid1);
	$('#amendzipdownload').submit();
} 
function batchdownload(fileid1)
{ 
	$('#filerepmasterid').val(fileid1);
	$('#batchdownloadform').submit();
}

function setmodelheader(m,l1,l2,l3,l4,lev,project,divid){
	
	var modelhead=project+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+m;
	
	if(lev>=1)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l1;
	}
	if(lev>=2)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l2;
	}
	if(lev>=3)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l3;
	}
	if(lev>=4)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l4;
	}
	$('#'+divid).html(modelhead);
}

</script>
<!-- ------------------------------------------------- basic script ---------------------------------------------------------------  -->
				
<!-- ----------------------------------------- hislist table -------------------------------------------------------------------  -->
<script type="text/javascript">


function doclist(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev,ele){	
	var $proid=$('#ProjectId').val();
	var $slevel='0';	
	var $proname=$('#projectname').val();
	
	
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
	
	if(lev==0)
	{
		setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$proname,'modelhead');
		setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$proname,'tablehead');
		
		var tempx = '<tbody id="flisttbody"></tbody>';
		$('#flisttbody').replaceWith(tempx);					
		$("#MyTable1").DataTable({
			 "destroy": true,							 
			 "lengthMenu": [5,10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5,
			 "language": {
			 "emptyTable": "Files not Found"
			    }
		}); 
		return 0;
	}
	
	$slevel=l1;
	if(lev>=1)
	{
		$slevel=l1;
	}
	if(lev>=2)
	{
		$slevel=l2;
	}
	if(lev>=3)
	{
		$slevel=l3;
	}
	if(lev>=4)
	{
		$slevel=l4;
	}

	setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$proname,'modelhead');
	setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$proname,'tablehead');
	
		if($slevel!=''){
			 $.ajax({
				
					type : "GET",
					url : "AllFilesList.htm",
					data : {
						subid		:	$slevel  ,
						projectid	:	$proid ,
						mainsystem 	:	mid ,
					},
					datatype: 'json',
					success : function(result){
						
						var result= JSON.parse(result);
						var values= Object.keys(result).map(function(e){
							
							return result[e]
							
						})
					 	var x = '<tbody id="flisttbody">';
						
						for (i = 0; i < values.length; i++) {
							
							var sn=i+1;
						
							x += '<tr><td>'+sn+'</td><td>'+values[i][9]+'</td><td>'+values[i][12]+'</td><td>'+values[i][11]+'</td><td>'+values[i][8]+'.'+values[i][6]+'</td>';
							if(Number(values[i][4])>0){
								x +='<td><button type="button" class="btn" onclick="FileDownload(\''+values[i][4]+'\');"><i class="fa fa-download" aria-hidden="true"></i></button></td>'
							}else{
								x +='<td>-</td>'
							}
							
							if(Number(values[i][8])>0 || Number(values[i][6])>0 ){
								x +='<td><button type="button" class="btn"  onclick="DocHistoryList('+values[i][7]+');"><i class="fa fa-history" aria-hidden="true"></i></button></td></tr>';
							}else{
								x +='<td>-</td></tr>'
							}

						}
						x=x+'</tbody>';
						
						 
						$('#flisttbody').replaceWith(x);					
						$("#MyTable1").DataTable({
							 "destroy": true,							 
							 "lengthMenu": [5,10,25, 50, 75, 100 ],
							 "pagingType": "simple",
							 "pageLength": 5,
							 "language": {
							      "emptyTable": "Files not Found"
							    }
						}); 
						 
						 
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						alert("Internal Error Occured !!");
			            alert("Status: " + textStatus);
			            alert("Error: " + errorThrown); 
			        }  
					
					
				}) 
			}
	 	
		}
		

function DocHistoryList(fileid){	
	
	$('#ProjectId').val();
		if(fileid>0){
			 $.ajax({
				
					type : "GET",
					url : "FileHistoryList.htm",
					data : {
						filerepid:fileid,						
					},
					datatype: 'json',
					success : function(result){
						
						var result= JSON.parse(result);
						var values= Object.keys(result).map(function(e){
							
							return result[e]
							
						})
					 	var x1 = '<tbody id="fhislisttbody">';
						
						for (i = 0; i < values.length; i++) {
							
							var sn1=i+1;
						
							x1 += '<tr><td>'+sn1+'</td><td>'+values[i][2]+'</td><td>'+values[i][3]+'</td><td>'+values[i][6]+'</td><td>'+values[i][4]+'.'+values[i][5]+'</td><td>'
							
							+'<button type="button" class="btn" value="" onclick="FileDownload('+values[i][0]+');"><i class="fa fa-download" aria-hidden="true"></i></button>'+'</td></tr>';
									
						}
						x1=x1+'</tbody>';
						
						 
						$('#fhislisttbody').replaceWith(x1);					
						$("#MyTable").DataTable({
							 "destroy": true,							 
							 "lengthMenu": [5,10,25, 50, 75, 100 ],
							 "pagingType": "simple",
							 "pageLength": 5,
							 "language": {
							      "emptyTable": "Files not Found"
							    }
						}); 
						$('#exampleModalCenter').modal('show');
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						alert("Internal Error Occured !!");
			            alert("Status: " + textStatus);
			            alert("Error: " + errorThrown); 
			        }  
					
					
					
				}) 
			}else{
				alert('Document Not Found');
			}
}
		
		
		
		
</script>
<!-- ----------------------------------------- hislist table -------------------------------------------------------------------  -->

<!-- ------------------------------------------------- modal box -------------------------------------------------------------------  -->
<script type="text/javascript">
var $doclev1=<%=doclev1%>;
var $doclev2=<%=doclev2%>;
var $doclev3=<%=doclev3%>;
function showamuploadbox(a,b,c,ver,rev,documenttitle,docid,desc,doclev1,doclev2,docuploadid)
{
	document.getElementById("modelform").reset();
	$('#doclev1').val(doclev1);
	$('#doclev2').val(doclev2);
	$('#uploaddocid').val(docuploadid);	
	$('#documenttitle').val(documenttitle);
	$('#FileAttach').prop('required', false);
	$('#FileName').prop('required', false);
	$('#modeldesc').prop('required', false);
	$('#Amenddescription').prop('required', true);
	$('#AmendFileAttach').prop('required', true);
	
	
	var uploadheader1= a+' <i class="fa fa-long-arrow-right" aria-hidden="true"></i> '+b;
	uploadheader1+=' <i class="fa fa-long-arrow-right" aria-hidden="true"></i> '+c +'('+docid+')';
	$('#upload-card-header1').html(uploadheader1);
	
	$.ajax({
		
		type : "GET",
		url : "AmendmentData.htm",
		data : {
			DocUploadId : docuploadid,
		},
		datatype : 'json',
		success : function(result) {
			
			if(result != 'null')
			{
				var result = JSON.parse(result);
				var Amendvalue = Object.keys(result).map(function(e) {
				  return result[e]
				})
							
				var temp=Number(Amendvalue[0][4])+1;
				$('#amendsubversion').html('Amendment '+temp);
				$('#Amenddescription').prop('required', true);
									
				var amdstr='';
				for(var i=Amendvalue.length-1;i>=0;i--)
				{
				
					amdstr	+=	'<tr>';
					amdstr	+=		'<td style="width:70%;" >';
					amdstr	+=			'Amendment : '+Amendvalue[i][4];		
					amdstr	+=		'</td>';
					amdstr	+=		'<td>';
					amdstr	+=			'<button type="button" name="downloadbtn" id="downloadbtn" class="btn btn-light"  onclick="AmendFileDownload(\''+Amendvalue[i][0]+'\');"   ><i class="fa fa-download" aria-hidden="true"></i></button>';
					amdstr	+=		'</td>';
					amdstr	+=	'</tr>';
				
					$('#amendmentlist').html(amdstr);				
					$('#amendmentbox').css('display','block');/*  */
					var zipdownbtn= '   <button type="button" name="downloadbtn" id="downloadbtn" class="btn btn-light"  onclick="AmendZipFileDownload(\''+Amendvalue[0][1]+'\');"   ><i class="fa fa-download" aria-hidden="true"></i></button>';
					$('#amendzipdownbtn').html(zipdownbtn);
				}
								
			}else
			{ 
				$('#amendsubversion').html('Amendment 1');				
				$('#amendmentlist').html('<tr><td>No Amendments<td><td>');
				$('#Amenddescription').prop('required', false);
				$('#amendmentbox').css('display','block');
				$('#amendzipdownbtn').html('');
			
			}
			$('#docno').html('('+docid+') ');
			$('#uploadbox').css('display','none');
			$('#ammendmentbox').css('display','block');
			 $('div').animate({
			    scrollTop: $("#ammendmentbox").offset()
			 }, 700); 	
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Internal Error Occured !!");
            alert("Status: " + textStatus);
            alert("Error: " + errorThrown); 
        }    
		
		
		
	});
	
	
}

function showuploadbox(a,b,c,ver,rev,documenttitle,docid,desc,doclev1,doclev2)
{
	document.getElementById("modelform").reset();
	var sublevel=$('#sublevel').val();
	$('#amendmentbox').css('display','none');
	$('#uploaddocid').val('');
	$('#doclev1').val(doclev1);
	$('#doclev2').val(doclev2);
	$('#Rev').val(rev);
	$('#Ver').val(ver);
	$('#documenttitle').val(documenttitle);
	$('#submitversion').val('');
	$('#prevversion').text('');
	$('#downloadbtn').remove();
	$('#FileName').prop('readonly',false);
	$('#FileName').val(c);
	$('#modeldescshow').text(desc);
	$('#FileAttach').prop('required', true);
	$('#FileName').prop('required', true);
	$('#modeldesc').prop('required', true);
	$('#modeldesc').val('');
	$('#Amenddescription').prop('required', false);
	$('#AmendFileAttach').prop('required', false);
	 
	
	var $projectvalue = $('#projectidvalue').val();
	var $mainsystemval = $('#mainsystemval').val();
	
	var $documenttitle=documenttitle;
	
	
	var $subsysteml1=$('#s'+sublevel).val();
	
	$.ajax({

		type : "GET",
		url : "VersionCheckList.htm",
		data : {
			projectid : $projectvalue,
			mainsystemid : $mainsystemval,
			subsysteml1 : $subsysteml1,
			documenttitle : $documenttitle
		},
		datatype : 'json',
		success : function(result) {

			var result = JSON.parse(result);
			var value1 = Object.keys(result).map(function(e) {
			  return result[e]
			})
			
			if(value1.length>0){
				var	s ='<button type="button" name="downloadbtn" id="downloadbtn" class="btn btn-light"  onclick="FileDownload(\''+value1[0][0]+'\');"   ><i class="fa fa-download fa-2x" aria-hidden="true"></i></button>';
				$('#prevversion').text(value1[0][4]+'.'+value1[0][2]);
				$('#FileUploadId').val(value1[0][0]);
				$('#FileName').val(value1[0][1]);
				$('#FileName').prop('readonly',true);
				var rel=value1[0][2]+1;		
				var ver=value1[0][4];		
				$('#submitversion').val("Upload Version "+ver+'.'+rel);
				$('#isnewvern').prop('checked', true);
				$('#isnewvern').prop('disabled', false);
				if(desc=='-' || desc=='null' || desc==''  ){
					$('#showdesc').css('display','none');
				}else
				{
					$('#showdesc').css('display','block');
				}
				$('#modeldesc').prop('required', true);				
			}else 
			{
				$('#isnewvery').prop('checked', true);
				$('#isnewvern').prop('disabled', true);
				$('#submitversion').val('Upload Version 1.0');				
				$('#showdesc').css('display','none');
				$('#modeldesc').prop('required', false);
				
			}
			var uploadheader= a+' <i class="fa fa-long-arrow-right" aria-hidden="true"></i> '+b;
			uploadheader+=' <i class="fa fa-long-arrow-right" aria-hidden="true"></i> '+c+'('+docid+')';;
			
			$('#upload-card-header').html(uploadheader);
			
			$('#downloaddiv').html(s);
			$('#uploadbox').css('display','block');
			$('#ammendmentbox').css('display','none');
			
			 
			 $('div').animate({
		        scrollTop: $("#uploadbox").offset()
		    }, 700); 
			
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Internal Error Occured !!");
            alert("Status: " + textStatus);
            alert("Error: " + errorThrown); 
        }    
		
		
		
	});
	
} 




function modalbox(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev)
{
		
		var $projectid=$('#ProjectId').val();		
		setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$('#projectname').val(),'model-card-header');		
		$('#amendmentbox').css('display','none');
		$('#submitversion').val('');
		$('#prevversion').text('');
		$('#downloadbtn').remove();
		$('#FileName').prop('readonly',false);
		$('#FileName').val('');
		$('#modeldescshow').text('');
		$('#uploadbox').css('display','none');
		$('#ammendmentbox').css('display','none');
		
		$.ajax({
				type : "GET",
				url : "FileHistoryListAjax.htm",
				data : {
					projectid : $projectid,
					mainsystemval : mid,
					sublevel : lev ,
					s1:l1,
					s2:l2,
					s3:l3,
					s4:l4,				
				},
				datatype: 'json',
				success : function(result)
					{
						var result= JSON.parse(result);
						var values= Object.keys(result).map(function(e){
						return result[e];
					})			
						
					
					/* --------------------------------------------ajax nested--------------------------------------- */		
							
							 $.ajax({
									type : "GET",
									url : "FileDocMasterListAll.htm",
									data : {
										projectid : $projectid,		
									},
									datatype: 'json',
									success : function(result1)
											{
												var result1= JSON.parse(result1);
												var values1= Object.keys(result1).map(function(e){
													return result1[e];
												})
														
												var values2=values1;
												/* --------------------------------------------------tree making--------------------------------------------------------- */			
													var str='<ul>';
													for(var v1=0;v1<values1.length;v1++)
													{ 
														if(values1[v1][2]===1)
														{  
															str +='<li> <span class="caret-1" id="docsysl1'+values1[v1][0]+'" onclick="onclickchange(this);" >'+values1[v1][3] +'</span> <ul  class="nested-1"> <li>'; 
													 /* ----------------------------------------level 1------------------------------------- */	
																for(var v2=0;v2<values2.length;v2++)
																{ 
																	if(values1[v2][2]===2 && values2[v2][1]==values1[v1][0] )
																	{  
																		str += '<li> <span class="caret-1" id="docsysl2'+values2[v2][0]+'" onclick="onclickchange(this);" >' +values2[v2][3]+'</span> <ul  class="nested-1"> <li>'; 
																/* ----------------------------------------level 2------------------------------------- */
																			
																			for(var v3=0;v3<values.length;v3++)
																			{ 
																				if(  values[v3][1]==values2[v2][0])
																				{
																					str +='<li> <span class="caret-last-1" id="docsysl3'+values[v3][0]+'" onclick="onclickchange(this);">'+values[v3][3]+'('+values[v3][9]+')</span>';
																						
																					str +='<span><button type="button" class="btn"  style="background-color: transparent;margin: -3px 0px;" onclick="showuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][3]+'\',\''+values[v3][8]+'\',\''+values[v3][6]+'\',\''+values[v3][0]+'\',\''+values[v3][9]+'\',\''+values[v3][10]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\')" >';
																					
																					str +=		'<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>';
																					str +=		'</button>';
																					if(values[v3][4]!=0)
																					{ 
																						str +=' <span class="version">Ver '+values[v3][8]+'.'+values[v3][6];
																						str +=		' <button type="button" class="btn"  style="background-color: transparent;margin: -5px 0px;" onclick="FileDownload(\''+values[v3][4]+'\')">';                                     
																						str += 			'<i class="fa fa-download" aria-hidden="true"></i>';
																						str +=		'</button> ';
																				
																						str +=		'  <button type="button" class="btn"  style="background-color: #CFFFFE;padding : 0px 5px 3px;margin: 0px -10px;border: 0.1px solid grey;" onclick="showamuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][3]+'\',\''+values[v3][8]+'\',\''+values[v3][6]+'\',\''+values[v3][0]+'\',\''+values[v3][9]+'\',\''+values[v3][10]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\',\''+values[v3][4]+'\')" >';                                     
																						str += 			' Amendment <img style="height:20px; width: 20px; " src="view/images/amendment-icon-2.png"> ';   /* <i class="fa fa-plus" style="color: #3DB2FF" aria-hidden="true"></i> <i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i> */
																						str +=		'</button> </span>';
																					} 
																							
																							
																					str +='	</span> </li>';
																						
																				}
																			}			
																	
																			
																/* ----------------------------------------level 2------------------------------------- */			
																		str +=	'</li> </ul> </li>';
																	}
																} 
															
												 	/* ----------------------------------------level 1------------------------------------- */
																			
															str +='</li> 	</ul> 	</li>';	
														} 
													} 
												/* --------------------------------------------------tree making--------------------------------------------------------- */
													str += '</ul>';
													
													$('#fileuploadlist').html(str);
													
													var toggler = document.getElementsByClassName("caret-1");
													$('#s1').val(l1);
													$('#s2').val(l2);
													$('#s3').val(l3);
													$('#s4').val(l4);
													$('#mainsystemval').val(mid);
													$('#sublevel').val(lev);
													$('#Path').val(mname+'/'+lname1);
													
													var i;
													for (i = 0; i <toggler.length; i++) {
													  toggler[i].addEventListener("click", function() {	
														this.parentElement.querySelector(".nested-1").classList.toggle("active-1");   
													    this.classList.toggle("caret-down-1");
													  });
													}
													$('#exampleModalCenter1').modal('show');
															
															if($doclev1>0)
															{
																$('#docsysl1'+$doclev1).click();
															}
															if($doclev2>0)
															{
																$('#docsysl2'+$doclev2).click();
															}
															if($doclev3>0)
															{
																$('#docsysl3'+$doclev3).css("font-weight", "700")
															}
															
															$doclev1=0;
															$doclev2=0;
															$doclev3=0;
													
													
											},
											error: function(XMLHttpRequest, textStatus, errorThrown) {
												alert("Internal Error Occured !!");
									            alert("Status: " + textStatus);
									            alert("Error: " + errorThrown); 
									        }  
											
							 		})
							 
						/* --------------------------------------------ajax nested--------------------------------------- */
						
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Internal Error Occured !!");
		            alert("Status: " + textStatus);
		            alert("Error: " + errorThrown); 
		        }  
		 })
				
}


</script>
<!-- ------------------------------------------------- modal box ---------------------------------------------------------------  -->
 
 

</body>
</html>	