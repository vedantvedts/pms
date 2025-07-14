<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<link href="${sweetalertCss}" rel="stylesheet" />
<script src="${sweetalertJs}"></script>
<title>COMMITTEE AGENDA </title>
<style type="text/css">
label{  
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
}
h6{
	text-decoration: none;
}

h6 span{
	font-size: 16px;
	color:white;
}

</style>



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
 
.attachlist
{
	width: 100%;
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


.folder-tree {
  list-style: none;
  padding-left: 0;
}

.folder-tree .list-group-item {
  border: none;
  padding: 8px 15px;
  transition: all 0.3s ease;
  border-radius: 6px;
  background: #fff;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.folder-tree .folder-item:hover {
  background: #f0f8ff;
  transform: translateX(5px);
}

.folder-tree .file-item:hover {
  background: #f9f9f9;
  transform: scale(1.02);
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.folder-tree .subfolder {
  display: none;
  margin-left: 20px;
  padding-left: 10px;
  border-left: 2px dashed #ddd;
}

.folder-tree .folder-item.open > .subfolder {
  display: block;
}

.folder-icon {
  margin-right: 8px;
  transition: transform 0.3s;
  font-size: 18px;
}

.pdf-check {
  cursor: pointer;
}

.folder-item.open > .folder-icon {
  color: #f39c12 !important;
  transform: scale(1.3);
  transition: all 0.3s ease;
}

.folder-tree .folder-item:hover {
  background: #f0f8ff;
  transform: translateX(5px);
}


</style>

</head>
 
<body>
  <%
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  
  Object[] labdata=(Object[])request.getAttribute("labdata");
  String filesize=  (String)request.getAttribute("filesize");
  
  List<Object[]> AllLabList=(List<Object[]>) request.getAttribute("AllLabList");
  Object[] scheduledata=(Object[])request.getAttribute("scheduledata");
  List<Object[]> projectlist=  (List<Object[]> ) request.getAttribute("projectlist");
  List<Object[]> committeeagendalist =  (List<Object[]>)request.getAttribute("committeeagendalist");
  List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");
  List<Object[]> AgendaDocList=(List<Object[]>) request.getAttribute("AgendaDocList");
  List<Object[]> LabEmpList=(List<Object[]>)request.getAttribute("LabEmpList");
  String LabCode =  (String)request.getAttribute("LabCode");
  
  String scheduleid=scheduledata[6].toString();
  String projectid=scheduledata[9].toString();
  String divisionid=scheduledata[16].toString();
  String initiationid=scheduledata[17].toString();
  

 %>
 
 
 
 
<% 
	String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null)
	{ %>
		<div align="center">	
			<div class="alert alert-danger" role="alert" >  <%=ses1 %>  </div>
		</div>
	<%} if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert"  >  <%=ses %> </div>
	     </div>
   <%} %>


<div class="container-fluid">
	<div style="margin-bottom:20px;"> 
    		<div class="card">
    	
	    	<form action="CommitteeScheduleView.htm" name="myfrm" id="myfrm" method="post">
	    		<div class="card-header" style="background-color: #055C9D;">
      				<h6 style="color: orange;font-weight: bold;font-size: 1.2rem !important " align="left"><%=scheduledata[7] %> <span> (Meeting Date and Time :      				
	      				 &nbsp;<%=sdf.format(sdf1.parse(scheduledata[2].toString()))%> - <%=scheduledata[3] %>) </span>      				
						<input type="hidden" name="projectid" value="<%=projectid%>"/>
	      				<input type="submit" class="btn  btn-sm view" value="VIEW" style="float:right;" />
	      				<span  style="float:right;margin: 5px 12px;" > (Meeting Id : <%=scheduledata[11] %>) </span> 
	      				<input type="hidden" name="scheduleid" value="<%=scheduledata[6] %>">
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />      				
      				 </h6>
      			</div>
	      	</form>		
      		
	      		<div class="card-body">
	      			<form method="post" action="CommitteeAgendaSubmit.htm"  id="addagendafrm" name="addagendafrm">	        
	        			<div >
	        			
	          				<div style="float: right;"><span style="font-size: 15px ;color: blue ; font-weight: ">Duration in Minutes</span></div>
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										<th>Agenda Item</th>
										<th>Reference</th>
										<th>Remarks</th>
										<th>Lab</th>
										<th>Presenter</th>
										<th>Duration </th>
										<th>Attach File </th> 
										<th> <button type="button" class="tr_clone_addbtn btn " name="add"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></th>	
									</tr>
										
									<tr class="tr_clone">
									
										<td width="20%"><input type="text" name="agendaitem" class="form-control item_name child" maxlength="500" required="required" /></td>
										
										<td width="15%">
											<%if(Long.parseLong(projectid) > 0) { %>
												<select class="form-control child  items" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
												
											    <% for (Object[] obj : projectlist) {
											    	if(obj[0].toString().equals(projectid)){%>						    				 	
									     				<option value="<%=obj[0]%>"><%=obj[3]%> (<%=obj[2] %>)</option>
									    			<%} 
									    		}%>					
												</select>
											<%}else if(Long.parseLong(initiationid) > 0) {%>
												<select class="form-control child  items" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
											    	<option value="0"><%=labdata[1] %>(GEN)</option>		
												</select>
											<%}else{ %>									
												<select class="form-control items" name="projectid" required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																							
									        		<option disabled  selected value="">Choose...</option>
									        		<option value="0"><%=labdata[1] %>(GEN)</option>
											  		<% for (Object[] obj : projectlist) {%>						    				 	
								     					<option value="<%=obj[0]%>"><%=obj[3]%> (<%=obj[2] %>)</option>
								    				<%} %>					
												</select>
											<%} %>
										</td>		
						         		<td  width="20%"><input type="text" name="remarks" class="form-control item_name child" maxlength="255" required="required" /></td>      
						         		 
						         		 <td>
						         		 	<select class="form-control items PresLabCode" name="PresLabCode" id="PresLabCode_0"  required="required" style="width: 200px" onchange="AgendaPresentors('0')"  data-live-search="true" data-container="body">
												<option disabled="disabled"  selected value="">Lab Name</option>
											    <% for (Object[] obj : AllLabList) {%>
												    <option value="<%=obj[3]%>" <%if(LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %>  ><%=obj[3]%></option>
											    <%} %>
											    <option value="@EXP">Expert</option>
											</select>
						         		 
						         		 </td>
						         		         	                             
						         		<td width="15%">						         		
											<select class="form-control items presenterid" name="presenterid" id="presenterid_0"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body" onchange="getEmployee(this)">
								        		<option disabled="disabled" selected value="">Choose...</option>
										        <% for(Object[] emp : LabEmpList){ %>
										        	<option value="<%=emp[0] %>"><%=emp[1] %>(<%=emp[3] %>)</option>
										        <%} %>
											</select>
										</td>		
										<td  width="10%">
										 	<input type="number" name="duration" class="form-control item_name child" min="1"   placeholder="Minutes" required/>
										</td>						         		                                      
																	
										<td style="text-align: left; width: 15%;">
										
											<button type="button" class=" btn btn-sm btnfileattachment" name="add" onclick="openMainModal('0','0',' ','<%=projectid %>','0','add')" > <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button> 
											<br>
											<table class="attachlist" id="attachlistdiv_0">
												
											</table>										
										</td>							
										<td>
											<button type="button" class="tr_clone_sub btn  " name="sub" > <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
										</td>								
									</tr>
								</thead>
							</table>

	          				<div align="center">
				            	<input type="submit"  class="btn  btn-sm submit" value="SUBMIT" onclick="return allfilessizecheck('addagendafrm'); "/> <!-- return confirm('Are You Sure To Add This Agenda(s) ?') -->
				            	<button type="reset" class="btn btn-sm reset" style="color: white" onclick="$('.hidden').val(''); $('.attachname').html('');" > RESET</button>
				            	<input type="button"  class="btn  btn-sm edit" value="Copy Agenda from old Meetings" onclick="submitForm('agendasprevious'); "/>
	          				</div>
	        			</div>
	        		
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			        	<input type="hidden" name="scheduleid" value="<%=scheduledata[6] %>">
			     		<input type="hidden" name="schedulesub" value="<%=scheduledata[5]%>"/>
			         	<input type="hidden" name="projectid" value="<%=projectid%>"/>
			    
	      			</form>
	    		</div>
    		</div>
	   	</div>   
	   	
	   	<form action="AgendasFromPreviousMeetingsAdd.htm"  method="post" id="agendasprevious">
	   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	   		<input type="hidden" name="scheduleidto" value="<%=scheduledata[6]%>"/>	   
		</form>


<% if(committeeagendalist.size()>0){ %> 
<div class="row">

	<div class="col-md-12">
    	<div class="card" style="">
      		<div class="card-body" >
      			<div class="row">

		   			<div class="col-md-12" style="padding-left: 0px">
		   
		   				<div class="table-responsive">
		   				
		    				<table class="table table-bordered table-hover  table-condensed" id="myTable3" style="margin-top: 20px;">
								<thead>
									<tr>
										<th colspan="10" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;" >Agenda Details</th>									
									</tr>	
									<tr>			
										<th style="padding-top: 50px;">Priority</th>		
										<th style="text-align: left;">Agenda Item</th>
										<th>Reference</th>
										<th>Remarks</th>	
										<th>Presenter Lab</th>							
									 	<th>Presenter</th>
									 	<th>Duration </th>
									 	<th>Attachment</th>
									 	<th>Upload</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>					
							 		<%int  count=1;
									for(Object[] obj: committeeagendalist){ %>
									<form name="myForm1" id="myForm1<%=count%>" action="CommitteeScheduleAgendaEdit.htm" method="POST"  > <!-- enctype="multipart/form-data" -->
										<tr>
											<td width="5%" >
												<input type="number" class="form-control" style="line-height: 1.6 !important" name="priority" value="<%=obj[8]%>" onkeypress="return isNumber(event)" min="1" max="<%=committeeagendalist.size()%>" form="priority_form">
												<input type="hidden" name="agendaid"  value="<%=obj[0]%>" form="priority_form">
											</td>
											<td width="12%">
												<input type="text" class="form-control form-control" name="agendaitem" value="<%=obj[3].toString()%>"  maxlength="255" >	 
											</td>
											<td width="4%">
												<%if(Long.parseLong(projectid) > 0) { %>
													<select class="form-control" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
														<% for (Object[] obj1 : projectlist) {
															if(obj1[0].toString().equals(projectid)){%>						    				 	
											     				<option value="<%=obj1[0]%>"><%=obj1[3]%> (<%=obj1[2] %>)</option>
											    			<%} 
											    		}%>					
													</select>
												<%}else{ %>
													<select class="form-control items" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 220px;" data-live-search="true" data-container="body">
										          		<option value="0" ><%=labdata[1] %></option>
												    	<% for (Object[] obj1 : projectlist) {%>
									     					<option value="<%=obj1[0]%>" <%if(obj[5].toString().equals(obj1[0].toString()))  {%> selected <%} %>><%=obj1[3]%> (<%=obj1[2] %>)</option>
									    				<%} %>					
													</select>
												<%} %>
											</td>
											<td style="text-align: left; width: 10%;"> 
												<input type="text" class="form-control form-control" name="remarks" value="<%=obj[6].toString()%>"  maxlength="255" >
											</td>
											<td>
							         		 	<select class="form-control items " name="PresLabCode" id="PresLabCode_Edit_<%=obj[0] %>"  required="required" style="width: 200px" onchange="AgendaPresentors('Edit_<%=obj[0] %>')"  data-live-search="true" data-container="body">
													<option disabled="disabled"  selected value="">Lab Name</option>
												    <% for (Object[] lab : AllLabList) {%>
													    <option value="<%=lab[3]%>" <%if(obj[14].toString().equalsIgnoreCase(lab[3].toString())){ %>selected <%} %>><%=lab[3]%></option>
												    <%} %>
												    <option value="@EXP" <%if(obj[14].toString().equalsIgnoreCase("@EXP")) {%>selected<%} %>>Expert</option>
												</select>
							         		</td>
											<td style="width:1%">
												<select class="form-control edititemsdd" name="presenterid" id="presenterid_Edit_<%=obj[0] %>" required="required" style=" font-weight: bold; text-align-last: left; width: 220px;" data-live-search="true" data-container="body">
													<option disabled="true"  selected value="">Choose...</option>
										        					
												</select>
											</td>	
											<td  width="10%">
												<input type="number" name="duration" class="form-control item_name" min="1"  placeholder="Minutes " value="<%=obj[12] %>" required />
											</td>
											<td style="text-align: left; width: 18%;">
												<table>
												<%for(Object[] doc : AgendaDocList) { 
													if(obj[0].toString().equalsIgnoreCase(doc[1].toString())){%>
													<tr>
														<td><%= doc[3] + " <span class='text-muted'> Ver " + doc[4] + "." + doc[5] + "</span>" %></td>
														<td style="width:1% ;white-space: nowrap;" ><a href="AgendaDocLinkDownload.htm?filerepid=<%=doc[2]%>" target="blank"><i class="fa fa-download" style="color: green;" aria-hidden="true"></i></a></td>
														<td style="width:1% ;white-space: nowrap;" ><a type="button" onclick="removeDocRow(this,<%=doc[0] %>);" > <i class=" fa fa-minus" style="color: red;"   ></i> </a></td>
													<tr>													
												<%} }%>
												</table>
									
											</td>
										
											<td style="text-align: center; width: 5%;"> 
												<span id="editattachname_<%=obj[0] %>" class="attachname"></span>
												<button type="button" class=" btn btn-sm" name="add" id="attacheditbtn_<%=obj[0] %>" onclick="openMainModal('<%=obj[0] %>','<%=obj[1] %>','<%=obj[3] %>','<%=obj[5] %>','0','edit')" > <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
												<input type="hidden" name="attachid" id="editattachid_<%=obj[0] %>" value="">												
											</td>																	
											<td style="text-align: left; width: 6%;">
				                                <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
												<input type="hidden"  name="AgendaPriority" value="<%= obj[8]%>"/>
												<input type="hidden" name="committeescheduleagendaid" id="committeescheduleagendaid" value="<%=obj[0]%>"/>
												<input type="hidden" name="scheduleid" value="<%=scheduleid%>"/>
												<button type="submit" class="btn  btn-sm" name="action" value="edit" onclick="return confirm('Are you sure To Edit this Agenda?')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
												<button type="submit" class="btn  btn-sm" name="action" value="delete" onclick="return confirm('Are you sure To Delete this Agenda?')" formaction="CommitteeAgendaDelete.htm"> <i class="fa fa-trash" aria-hidden="true" ></i></button>
											</td>
										 
										</tr>
									</form> 								
										<% count++; } %>
										<%if( committeeagendalist.size()!=1 ){ %>
										<tr>
											<td ><input type="submit" value="Update" class="btn  btn-sm submit" onclick="return confirm('Are You Sure to Update the Priorities ?');" form="priority_form"></td>
											<td colspan="9"></td>
										</tr>
										<%} %>
								</tbody>
							</table>
						
						</div> 
					</div>
 <!-- ----------------------------- -->		 	
  				</div>
			</div>
			</div>
		</div>
	</div>
</div>  

 <form method="get" action="CommitteeAgendaPriorityUpdate.htm" id="priority_form">
	<input type="hidden" name="scheduleid" value="<%=committeeagendalist.get(0)[1]%>"/>
</form>
<%} %>  



<form method="POST" action="FileUnpack.htm"  id="downloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="FileUploadId" id="FileUploadId" value="" />
</form>


<div class="modal fade" id="meetingModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 180%;margin-left: -50%;">
      <div class="modal-header">
        <h6 class="modal-title" id="exampleModalLabel"> Presenter is already Having meeting on  That Particular Day</h6>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered table-stripped" id="myTable">
        	<thead>
        		<tr>
        		<th>SN</th>
        		<th>Meeting Id </th>
        		<th>Meeting Venue</th>
        		<th>Meeting Time</th>
        		<th>Meeting Role</th>
        		</tr>
        	</thead>
        	<tbody id="meetingbody">
        	
        	</tbody>
        </table>
      </div>
 <!--      <div align="center" class="mt-2 mb-2">
        <button type="button" class="btn btn-sm submit" id="submitbtn" onclick="submitAddForm()">CREATE</button>
        <button type="button" class="btn  btn-sm btn-danger delete" data-dismiss="modal">Close</button>
     
     
      </div> -->
      <div class="text-danger p-2">
      Please make sure his/her meeting times are not clashing!
     </div>
    </div>
  </div>
</div>


<!-- File Repo Modal -->
<div class="modal fade" id="pdfModal" tabindex="-1" role="dialog" aria-labelledby="pdfModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content shadow-lg border-0">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modalTitleId"><i class="fa fa-folder-open"></i></h5>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Folder Tree List -->
         <ul class="list-group folder-tree" id="folderTree"></ul>
      </div>
	  <div class="modal-footer">
		 <div style="color: red;font-weight: 500;">Note - Please upload PDF files only and PDF size should be smaller than 10mb.</div>
	  </div>
    </div>
  </div>
</div>

<script type="text/javascript">

$('.edititemsdd').select2();
$('.items').select2();

var count=1;
$("table").on('click','.tr_clone_addbtn' ,function() {
   $('.items').select2("destroy");        
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  
  count++;
  
  $clone.find(".btnfileattachment").attr("onclick", 'openMainModal(\'0\',\'0\',\' \',\''+'<%=projectid %>'+'\',\''+count+'\',\'add\')').val("").end();
  $clone.find(".hidden").prop("id", 'attachid_'+count).prop("name", 'attachid_'+count).val("").end();
  $clone.find(".attachlist").prop("id","attachlistdiv_"+count).html("").end();
  $clone.find(".attachname").prop("id", 'attachname_'+count).html("").end();
  $clone.find('.items presenterid' ).attr('id', 'select'+count);
  $clone.find(".PresLabCode").prop("id", 'PresLabCode_'+count).attr("onchange", 'AgendaPresentors(\''+count+'\')').end();
  $clone.find(".presenterid").prop("id", 'presenterid_'+count).end();
  
  $('.items').select2();
  $clone.find('.items' ).select2('val', ''); 
  $clone.find("input").val("").end();
  
  AgendaPresentors(count+'');
  
});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   $('.items').select2("destroy");        
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
   $('.items').select2();
   
}
   
});
</script>


<script>
function editsubmit(agendaid) {
	var attacharr = [];
	$('input[name="editattachid_'+agendaid+'"').each(function() {
		attacharr.push($(this).val());
	});
	return false;
} 
</script>



<script type="text/javascript">
function removeDocRow(elem,attachid)
{
	if(confirm('Are You Sure To unlink this Document ?')){
	
		$.ajax({
			type : "GET",
			url : "AgendaUnlinkDoc.htm",
			data : {
				AttachDocid : attachid
			},
			datatype: 'json',
			success : function(result)
				{
					var result= JSON.parse(result);
					if(result==1){
						alert('Document Removed Successfully');
						$(elem).parent('td').parent('tr').remove();
					}else
					{
						alert('Document Removal Unsuccessful \n Internal Error occured !!');
					}
				}
		});
	}
}
</script>


<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 

function submitForm1(msg,frmid)
{ 
	myconfirm(msg,frmid);
	event.preventDefault(); 
}
</script>

<script type="text/javascript">
  function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
  </script>

<input type="hidden" id="addoredit" value="" />
<input type="hidden" id="agendano" value="" />
<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->

<script type="text/javascript">

function setagendaattachval(attachid, attchName)
{
	$addedit=$('#addoredit').val();
	$agendaelem=$('#agendano').val();
	if($addedit==='add'  )
	{
		let agendano=$('#agendano').val();
		let html= $("#attachlistdiv_"+agendano).html();
		let attname =attchName;
		/* if(attchName.length>5){
			attname = attchName.substring(0, 5).concat("...");
		}else{
			attname=attchName;
		} */
		html += '<tr id="a_'+agendano+'"><td title='+attchName+'> '+attname+'</td><td style="width:1% ;white-space: nowrap;">';
		html += '<button type="button"  onclick="$(this).parent(\'td\').parent(\'tr\').remove();"  > <i class="btn btn-sm fa fa-minus" style="color: red;"   ></i> </button>';  /* onclick="$(\'#a_'+agendano+'\').remove();" */
		html += '<input type="hidden" name="attachid_'+agendano+'" value="'+attachid+'" /></td>';
		html += '</tr>';
		$("#attachlistdiv_"+agendano).html(html);
	}
	/* else if($addedit==='edit'){		
		$('#editattachid_'+$agendaelem).val(attachid);
		$('#editattachname_'+$agendaelem).html(attchName+'&nbsp;&nbsp; <i class="btn btn-sm fa fa-minus" style="color: red;" onclick="editattachremove('+$agendaelem+');"  ></i>');
		$('#attacheditbtn_'+$agendaelem).hide();
	} */
	$('#pdfModal').modal('hide');
/* 	$('#attachmentmodal').modal('hide'); */
}
 

function editattachremove(agendaid)
{
	$('#editattachid_'+$agendaelem).val(0);
	$('#editattachname_'+$agendaelem).html('');
	$('#attacheditbtn_'+$agendaelem).show();
}
</script>
<script type="text/javascript">
function FileDownload(fileid1)
{
	$('#FileUploadId').val(fileid1);
	$('#downloadform').submit();
}

$(document).ready(function(){
	<%for( Object[] agenda : committeeagendalist){ %>
		EditAgendaPresentors('<%=agenda[0]%>','<%=agenda[9]%>');
	<%}%>
	
});
</script>

<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->
<script type="text/javascript">
function editcheck(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(editfileid).files.length !=0 && file >= <%=filesize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=filesize%> mb");
    } else
    {
    	 return confirm('Are You Sure To Edit This Agenda?');
    }
}
</script>
<script type="text/javascript">
var filexcount=0;
	function allfilessizecheck(frmid)
	{	
		filexcount=0;
		var fileidarr=[];
		$(".filex").each(function() {			
            if (this.id) {            	
            	fileidarr.push(this.id);
            }
        });
		for(var z=0; z<fileidarr.length;z++)
		{
			if(document.getElementById(fileidarr[z]).files.length !=0 ){
				const fi = $('#'+fileidarr[z] )[0].files[0].size;							 	
		        const file = Math.round((fi / 1024/1024));
		       
		        if (file >= <%=filesize%>) 
		        {
		        	filexcount++;
		        }	        
			}
		}
		if(filexcount>0)
		{
			event.preventDefault();
			alert('File too Big, please select a file less than <%=filesize%> mb');
		}else
		{
			return confirm('Are You Sure to Submit These Agenda (s)?')
		}
	}					
</script>
	
<script type="text/javascript">
		function AgendaPresentors($AddrowId){
			$('#presenterid_'+$AddrowId).val("");
				var $PresLabCode = $('#PresLabCode_'+$AddrowId).val();
						if($PresLabCode !=""){
						$.ajax({		
							type : "GET",
							url : "CommitteeAgendaPresenterList.htm",
							data : {
								PresLabCode : $PresLabCode,
								   },
							datatype : 'json',
							success : function(result) {
		
							var result = JSON.parse(result);	
							var values = Object.keys(result).map(function(e) {
										 return result[e]
							});
								
					var s = '';
						s += '<option value="" selected disabled>Choose...</option>';
								 for (i = 0; i < values.length; i++) {									
									s += '<option value="'+values[i][0]+'">'
											+values[i][1] + " (" +values[i][3]+")" 
											+ '</option>';
								} 
								$('#presenterid_'+$AddrowId).html(s);
							}
						});
		}
	}
		function EditAgendaPresentors($AddrowId,PresentorID){
			$('#presenterid_Edit_'+$AddrowId).val("");
				var $PresLabCode = $('#PresLabCode_Edit_'+$AddrowId).val();
						if($PresLabCode !=""){
						$.ajax({		
							type : "GET",
							url : "CommitteeAgendaPresenterList.htm",
							data : {
								PresLabCode : $PresLabCode,
								   },
							datatype : 'json',
							success : function(result) {
		
							var result = JSON.parse(result);	
							var values = Object.keys(result).map(function(e) {
										 return result[e]
							});
								
					var s = '';
						s += '<option value="" selected disabled>Choose...</option>';
								 for (i = 0; i < values.length; i++) {									
									s += '<option value="'+values[i][0]+'">'
											+values[i][1] + " (" +values[i][3]+")" 
											+ '</option>';
								} 
								$('#presenterid_Edit_'+$AddrowId).html(s);
								$('#presenterid_Edit_'+$AddrowId).val(PresentorID).trigger('change');
							}
						});
		}
	}
var mainAgendaId="";
var attachRepIds = [];
var agendadocId=[];
function openMainModal(agendaid,scheduleid,agendaname,projectid,cloneId,agendatype){
	mainAgendaId="";
	$('#addoredit').val(agendatype);
	$('#agendano').val(cloneId);
	mainAgendaId=agendaid;
	if(agendaid!=0){
		 $.ajax({
             url: 'getAgendaAttachId.htm',
             type: 'GET',
             data: {agendaid: agendaid},
             success: function(response) {
            	 try {
                     var parsedResponse = JSON.parse(response);
                     if (Array.isArray(parsedResponse)) {
                       parsedResponse.forEach(item => {
                         attachRepIds.push(item[1]);
                         agendadocId.push(item[0]);
                       });
                     } else {
                       console.error('Response is not an array:', parsedResponse);
                     }
                   } catch (e) {
                     console.error('Error parsing JSON response:', e);
                   }
             },
          }); 
	}
	
    $.ajax({
        type: "GET",
        url: "FileRepMasterListAllAjax.htm",
        data: { projectid: projectid },
        success: function(result) {
            var data = JSON.parse(result);
            var folderMap = {};
            var html = '';
            if (data.length > 0) {
                projectName = data[0][4];
           }

            // First pass: build main folders
            for (var i = 0; i < data.length; i++) {
                var mainId = data[i][0];
                var parentId = data[i][1];
                var name = data[i][3];

                if (parentId === 0) { // Main Folder
                    folderMap[mainId] = { name: name, subfolders: [] };
                }
            }

            // Second pass: attach subfolders
            for (var j = 0; j < data.length; j++) {
                var subId = data[j][0];
                var subParentId = data[j][1];
                var subName = data[j][3];

                if (subParentId !== 0 && folderMap[subParentId]) { // Subfolder
                    folderMap[subParentId].subfolders.push({ id: subId, name: subName });
                }
            }

            // Generate HTML
            if (folderMap && Object.keys(folderMap).length > 0) {
                for (var mainId in folderMap) {
                    if (folderMap.hasOwnProperty(mainId)) {
                        html += '<li class="list-group-item folder-item" data-id="' + mainId + '" onclick="toggleFolder(this, ' + mainId + ', '+ projectid +', \'mainLevel\', \'' + agendatype + '\', '+ agendaid +')">';
                        html += '<i class="fa fa-folder folder-icon text-warning"></i> ' + folderMap[mainId].name;
                        html += '<ul class="list-group subfolder" style="display:none;">';

                        var subfolders = folderMap[mainId].subfolders;
                        for (var k = 0; k < subfolders.length; k++) {
                            var sub = subfolders[k];
                            html += '<li class="list-group-item folder-item" data-id="' + sub.id + '" onclick="toggleFolder(this, ' + sub.id + ', '+ projectid +', \'subLevel\', \'' + agendatype + '\', '+ agendaid +')">';
                            html += '<i class="fa fa-folder folder-icon text-warning"></i> ' + sub.name;
                            html += '<ul class="list-group subfolder" id="subfolder-files-' + sub.id + '" style="display:none;"></ul>';
                            html += '</li>';
                        }

                        html += '<div class="" id="mainfolder-files-' + mainId + '" style="display:none;"></div>';
                        html += '</ul></li>';
                    }
                }
            }else {
                html += '<div>No Data Available.</div></br>';
                html += '<div>Please go to <span style="font-weight: 500; color: blue;">Document Repository Module &rarr; Document Rep Master</span>, create a folder, and upload pdfs.</div></br>';
            }

            $('.folder-tree').html(html);
            $('#pdfModal').modal('show');
            if (projectName !== undefined && projectName.trim() !== '' && agendatype !== "add") {
                $('#modalTitleId').text('PDF Files Explorer for ' + agendaname);
            }else{
            	$('#modalTitleId').text('PDF Files Explorer');
            }
        }
    });
}

function toggleFolder(element, folderId, projecId, type, agendatype, agendaid) {
	
    if ($(event.target).closest('.file-item').length > 0 || $(event.target).hasClass('pdf-check')) {
        return;
    }
    event.stopPropagation(); // Prevent parent toggling

    var $elem = $(element);
    var $icon = $elem.children('.folder-icon');
    var $subfolder = $elem.children('ul.subfolder');

    if ($subfolder.is(':visible')) {
        $subfolder.slideUp(200);
        $elem.removeClass('open');
        $icon.removeClass('fa-folder-open').addClass('fa-folder');
    } else {
        $subfolder.slideDown(200);
        $elem.addClass('open');
        $icon.removeClass('fa-folder').addClass('fa-folder-open');

        // Load files if not loaded yet
        var fileContainerId = '';
        if (type === 'mainLevel') {
            fileContainerId = '#mainfolder-files-' + folderId;
        } else {
            fileContainerId = '#subfolder-files-' + folderId;
        }

        if ($(fileContainerId).is(':empty')) {
            loadFolderFiles(folderId, projecId, type, agendatype, agendaid);
        }
    }
}

function loadFolderFiles(folderId, projecId, type, agendatype, agendaid) {
    $.ajax({
        type: "GET",
        url: "getOldFileDocNames.htm",
        data : {
   			projectId : projecId,
   			fileId : folderId,
   			fileType : type,
	    },
        success: function(result) {
            var data = JSON.parse(result);
            var html = '';

            for (var i = 0; i < data.length; i++) {
                var fileName = data[i][6];
                html += '<li class="list-group-item file-item">';
                html += '<input type="checkbox" class="pdf-check mr-2" id="checkId'+data[i][0]+'" value="' + data[i][7] + '" data-filename="'+data[i][6]+'" ';
                if(data[i][7]!= 0 && attachRepIds.length>0 && attachRepIds.includes(data[i][7]) && agendatype !== "add") {
                    html += ' checked disabled';
                }
                html += '/>';
                html += '<i class="fa fa-file-pdf-o text-danger"></i> ' + fileName;
                html += '<span class="text-muted" style="font-size:13px"> Ver '+data[i][4]+'.'+data[i][5]+'</span>';
                html += '<i class="fa fa-download" style="cursor: pointer; margin-left:8px;" onclick="fileDownload(' + data[i][7] + ', \'' + type + '\')"></i>';
                html += '<i class="fa fa-upload" aria-hidden="true" style="color: #0a5dff; cursor: pointer; margin-left:12px;" onclick="fileUpload(\''+data[i][0]+'\')"></i></button><br/>';
                html += '<label for="fileInput" id="uploadlabel'+data[i][0]+'" style="margin-left: 20px; margin-top: 10px; display: none;">'
                html += '<input type="file" name="docFileInput" id="fileInput'+data[i][0]+'" required="required"  accept="application/pdf"/> '
                html += '<button type="button" class="btn btn-sm back" onclick="fileSubmit(\''+type+'\',\''+data[i][0]+'\',\''+data[i][2]+'\',\''+data[i][3]+'\',\''+data[i][4]+'\',\''+data[i][5]+'\',\''+data[i][6]+'\', '+agendaid+')">Upload</button>'
                html += '</label>'
                html += '</li>';
            }

            if (type === 'mainLevel') {
                $('#mainfolder-files-' + folderId).html(html).show();
            } else {
                $('#subfolder-files-' + folderId).html(html).show();
            }
        }
    });
}

function fileDownload(fileId, fileType) {
    $.ajax({
        url: 'fileDownload.htm/' + fileId + '?fileType=' + encodeURIComponent(fileType),
        type: 'GET',
        xhrFields: {
            responseType: 'blob'
        },
        success: function (data, status, xhr) {
        	  const blob = new Blob([data], { type: 'application/pdf' });
              const blobUrl = URL.createObjectURL(blob);
              window.open(blobUrl, '_blank');
              setTimeout(() => URL.revokeObjectURL(blobUrl), 5000);
        },
        error: function (xhr, status, error) {
		     Swal.fire({
			        icon: 'error',
			        title: 'Error',
			        text: 'Failed to download/open file.',
			 });
        }
    });
}

// Allow only one checkbox to be selected at a time
function singleSelect(checkbox) {
    $('.pdf-check').not(checkbox).not(':disabled').prop('checked', false);
}

// Event delegation for dynamically added checkboxes
$(document).on('change', '.pdf-check', function() {
  // Send AJAX request with the selected checkbox value
  var selectedValue = $(this).val();
  var filename = $(this).data('filename');
  var isChecked = $(this).prop('checked');
  var agendtype=$('#addoredit').val();
  
  if(isChecked){
	  if (agendtype==='add') {
      	setagendaattachval(selectedValue,filename);
      }else{
 	     Swal.fire({
	            title: 'Are you sure to linking?',
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: 'green',
	            cancelButtonColor: '#d33',
	            confirmButtonText: 'Yes'
	        }).then((result) => {
	            if (result.isConfirmed) {
	          	  $.ajax({
	        	        url: 'addAgendaLinkFile.htm', 
	        	        type: 'GET',
	        	        data: { attachId: selectedValue,agendaId: mainAgendaId},
	        	        success: function(response) {
	        	        	 Swal.fire({
	        	    	            icon: 'success',
	        	    	            title: 'Success',
	        	    	            text: 'Document linked successfully!',
	        	    	            allowOutsideClick :false
	        	    	          });
	        	        	 $('#pdfModal').hide();
	        	        	$('.swal2-confirm').click(function() {
	        	                location.reload();
	        	            });
	        	        },
	        	        error: function() {
	        	          Swal.fire({
	        	            icon: 'error',
	        	            title: 'Error',
	        	            text: 'An error occurred while submitting the checkbox selection.',
	        	          });
	        	        }
	        	    });
	          }else{
	        	  $('.pdf-check').not(':disabled').prop('checked', false);
	          }
	     });
      }
    }
});

function fileUpload(Id){
	 var label = document.getElementById("uploadlabel"+Id);
   if (label.style.display === "none") {
       label.style.display = "inline-block";
   } else {
       label.style.display = "none";
   }
}

function fileSubmit(type,repid,mainId,subId,version,release,docName,agendaid) {
    event.preventDefault();
    var fileInput =  $("#fileInput"+repid)[0].files[0];
    var agendtype=$('#addoredit').val();
    
	 if (fileInput === undefined) {
	       Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: 'Please select a file to upload!',
	            allowOutsideClick :false
	       });
	       return;
	  }
	// Check if the file is a PDF
	   var fileType = fileInput.type;
	   if (fileType !== 'application/pdf') {
	       Swal.fire({
	           icon: 'error',
	           title: 'Invalid File Type',
	           text: 'Please select a PDF file!',
	           allowOutsideClick: false
	       });
	       return;
	   }
	   // Check if the file size is less than 10MB (10 * 1024 * 1024 bytes)
	   var fileSize = fileInput.size;
	   if (fileSize > 10 * 1024 * 1024) {
	       Swal.fire({
	           icon: 'error',
	           title: 'File Too Large',
	           text: 'Please select a file smaller than 10MB!',
	           allowOutsideClick: false
	       });
	       return;
	   }
	   
       Swal.fire({
            title: 'Are you sure to upload?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: 'green',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
		        var projectid = <%= projectid %>;
		        var formData = new FormData();
		        formData.append("file", $("#fileInput"+repid)[0].files[0]);
		        formData.append("fileType", type);
		        formData.append("fileRepId", repid);
		        formData.append("projectid", projectid);
		        formData.append("mainId", mainId);
		        formData.append("subId", subId);
		        formData.append("docName", docName);
		        formData.append("version", version);
		        formData.append("release", release);
		        formData.append("agendaid", agendaid);
		        formData.append("${_csrf.parameterName}", "${_csrf.token}");
		        // Use AJAX to submit the form data
		        $.ajax({
		            url: 'DocFileUpload.htm',
		            type: 'POST',
		            data: formData,
		            contentType: false,
		            processData: false,
		            success: function(response) {
		            	attachid=response;
		              	 if (agendtype==='add') {
		      	        	setagendaattachval(attachid,docName);
		      	        }else{
		             	  Swal.fire({
		 		    	       	title: "Success",
		 		                text: "File Uploaded Successfully",
		 		                icon: "success",
		 		                allowOutsideClick :false
		 		         		});
		             	  $('#pdfModal').hide();
		             	  $('.swal2-confirm').click(function() {
		   	                location.reload();
		   	               });
		             	}
		            },
		            error: function(xhr, status, error) {
		            	  Swal.fire({
		                      icon: 'error',
		                      title: 'Error',
		                      text: 'An error occurred while uploading the file'
		                  });
		                  console.log(xhr.responseText);
		             }
		        });
        }
    });
}


var table1=$("#myTable").DataTable({		 
	 "lengthMenu": [5,10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5,
	 "language": {
	      "emptyTable": "Files not Found"
	    }
});
function getEmployee(ele){

	
	var empid=ele.value;
	


	var labocode= $("#PresLabCode_"+ ele.id.split("_")[1]).val()
	$.ajax({
		type:'GET',
		url:'checkMeetingEmpWise.htm',
		datatype:'json',
		data:{
			empid:empid,
			labocode:labocode,
			scheduleid:<%=scheduleid%>
		},
		success:function(result){
			var ajaxresult = JSON.parse(result);
			
			if(ajaxresult.length>0){
				table1.destroy();
				
				
				
				var html=''
				for(var i=0;i<ajaxresult.length;i++){
					html+='<tr><td>'+ (i+1)   +'</td>'
					html+='<td>'+ajaxresult[i].MeetingId   +'</td>'
					html+='<td>'+ ajaxresult[i].MeetingVenue  +'</td>'
					html+='<td>'+ ajaxresult[i].ScheduleStartTime  +'</td>'
					html+='<td>'+ ajaxresult[i].description  +'</td></tr>'
				}		
				
				$('#meetingbody').html(html);
			
				
				 
				 table1=$("#myTable").DataTable({		 
					 "lengthMenu": [5,10,25, 50, 75, 100 ],
					 "pagingType": "simple",
					 "pageLength": 5,
					 "language": {
					      "emptyTable": "Files not Found"
					    }
				}); 
				 $('#meetingModal').modal('show');
				
				
			}
			
			
		}
	})
	
}
</script>

</body>
</html>