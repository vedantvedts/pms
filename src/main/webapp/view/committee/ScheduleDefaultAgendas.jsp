<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

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


</head>
 
<body>
  <%
  

  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");

  Object[] scheduledata=(Object[])request.getAttribute("scheduledata");
  List<Object[]> projectlist=  (List<Object[]> ) request.getAttribute("projectlist");
  List<Object[]> employeelist=(List<Object[]>)request.getAttribute("employeelist");
  
  List<Object[]> defagendalist=(List<Object[]>)request.getAttribute("defAgendaList");
  
  String projectid=scheduledata[9].toString();
  String divisionid=scheduledata[16].toString();
  String initiationid=scheduledata[17].toString();
  Object[] labdata=(Object[])request.getAttribute("labdata");
  String filesize=  (String)request.getAttribute("filesize");
  
  
  List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");

  
  
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

    <br />
    
    


<div class="container-fluid">
	<!-- <div class="container" style="margin-bottom:20px;">  -->
	<div style="margin-bottom:20px;"> 
  
		<div id="error"></div>
		
    		<div class="card" style=" ">
    	
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
	      			<form method="post" action="ScheduleDefAgendaAdd.htm"  id="addagendafrm" name="addagendafrm">	        
	        			<div >
	          				<div style="float: right;"><span style="font-size: 15px ;color: blue ; font-weight: ">Duration in Minutes</span></div>
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr>
										<th>Select</th>
										<th>Agenda Item</th>
										<th>Reference</th>
										<th>Remarks</th>
										<th>Presenter</th>
										<th>Duration </th>
										<th>Attachment</th> 
									</tr>
										<%if(defagendalist.size()>0){
											for(Object[] agenda:defagendalist){ %>
											<tr>
												<td align="center">
													<input type="checkbox" class="" name="defagendaid" id="defagendaid_<%=agenda[0] %>" checked="checked"  value="<%=agenda[0]%>" onchange="selectCheck('<%=agenda[0]%>')">
													<input type="hidden" name="defagendaid1" value="<%=agenda[0]%>" >
												</td>	
												<td width="20%">
													<input type="hidden" name="agendaitem" id="agendaitem_<%=agenda[0] %>" class="form-control item_name child" value="<%=agenda[2] %>" required="required" />
													<span><%=agenda[2] %></span>
												</td>
												<td width="15%">
													<%if(Long.parseLong(projectid) > 0) {%>
														<select class="form-control child  items" name="projectid"  required="required" id="projectid_<%=agenda[0] %>" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
														     <% for (Object[] obj : projectlist) {
														    	 if(obj[0].toString().equals(projectid)){%>						    				 	
												     			<option value="<%=obj[0]%>"><%=obj[3]%> (<%=obj[2] %>)</option>
												    			<%} 
												    		}%>					
														</select>
													<%}else if(Long.parseLong(initiationid) > 0) {%>
														<select class="form-control child  items" name="projectid"  required="required" id="projectid_<%=agenda[0] %>"  style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
													    	<option value="0"><%=labdata[1] %>(GEN)</option>		
														</select>
													<%}else{ %>									
														<select class="form-control child items" name="projectid" required="required" id="projectid_<%=agenda[0] %>"  style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																									
											        		<option disabled  selected value="">Choose...</option>
											        		<option value="0"><%=labdata[1] %>(GEN)</option>
													  		<% for (Object[] obj : projectlist) {%>						    				 	
										     					<option value="<%=obj[0]%>"><%=obj[3]%> (<%=obj[2] %>)</option>
										    				<%} %>					
														</select>
													<%} %>
												</td>								
								         		<td  width="20%">
								         			<input type="text" name="remarks" id="remarks_<%=agenda[0]%>" class="form-control item_name child" maxlength="255" required="required" value="<%=agenda[3] %>" />
								         		</td>      
								         		<td  width="15%"> 
								         		
													<select class="form-control items " name="presenterid" id="presenterid_<%=agenda[0] %>" required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" >
														<option disabled="disabled" selected value="">Choose...</option>
										          		<% for (Object[] obj : employeelist) {%>						    				 	
									     					<option value="<%=obj[0]%>"><%=obj[1]%> (<%=obj[2] %>)</option>
									    				<%} %>					
													</select>
													
												</td>		
												<td  width="10%">
												 	<input type="number" name="duration" id="duration_<%=agenda[0] %>"  value="<%=agenda[4] %>" class="form-control item_name child" min="1"   placeholder="Minutes" required/>
												</td>						         		                                      
												<td style="text-align: left; width: 15%; display: none;">
													
													
													<input type="file" name="FileAttach" id="file<%=agenda[0] %>" class="form-control wrap child filex" aria-describedby="inputGroup-sizing-sm" maxlength="255" style=";font-size: 11px;padding: 8px" onchange="Filevalidation('file<%=agenda[0] %>');" />
													
												</td>										
												<td style="text-align: left; width: 15%;"> 
													<button type="button" class="tr_clone_attach btn btnfileattachment" name="add" onclick="openMainModal('<%=agenda[0] %>','a')" > <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button> 
													<br>
													<table class="attachlist" id="attachlistdiv_<%=agenda[0] %>">
														
													</table> 	
												
												</td>												
																			
											</tr>
										<%}
										} else {%>
										
										<tr>
											<td colspan="7" style="text-align: center;">
												No Agendas Found
											</td>
										</tr>
										
										<%} %>
								</thead>
							</table>
							
							

	          				<div align="center">
	          					<%if(defagendalist.size()>0){ %>
				            	<input type="submit"  class="btn  btn-sm submit" value="SUBMIT" onclick="return allfilessizecheck('addagendafrm'); "/>
				            	<%} %> 
				            	<button type="submit"  class="btn  btn-sm submit" style="color:white;border-color:#C56824 ; background-color: #C56824" name="skip" value="yes" form="skipfrm" >
					            	<i class="fa fa-fast-forward" aria-hidden="true"></i>
					            	Skip 
				            	</button> 
	          				</div>
	        			</div>
	        		
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			        	<input type="hidden" name="scheduleid"  value="<%=scheduledata[6] %>">
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
	<form action="CommitteeScheduleAgenda.htm"  method="post" id="skipfrm">
   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	   	<input type="hidden" name="scheduleid"  value="<%=scheduledata[6] %>">   
	   	
	</form>
	
</div>
	
  




<!--  -----------------------------------------------agenda attachment ---------------------------------------------- -->

			<div class="modal" tabindex="-1" role="dialog" id="attachmentmodal" aria-labelledby="myLargeModalLabel" aria-hidden="true">
 				 <div class="modal-dialog modal-dialog-centered " style="max-width: 75% !important; ">
   					 <div class="modal-content">
   						 <div class="modal-header">
					        <h4 class="modal-title" style="color: #145374">Select Document for linking</h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
						 </div>
						<div class="modal-body">   
		<!-- --------------------------------------------left page ----------------------------------------------------->
							<div class="col-md-12" >		
		<!-- -------------------------------- tree ----------------------------- -->
								<div class="row" style="height: 28rem; overflow-y:auto;verflow-x:auto; ">		
									<ul>	
									<%for(Object[] obj :filerepmasterlistall)
									{ 
										if(Long.parseLong(obj[1].toString())==0)
										{%>  
										<li>
											<span class="caret" id="system<%=obj[0]%>"  >
							             		<%=obj[3] %>
							             	</span>
							             	<span>
									           <%--  <button type="button" class="btn"  style="background-color: transparent;margin: -5px 0px" onclick="batchdownload('<%=obj[0]%>')">                                     
													<i class="fa fa-download" aria-hidden="true"></i>
												</button> --%>
							             	</span>
											<ul  class="nested">
												<li>
								<!-- ----------------------------------------level 1------------------------------------- -->	
													<%for(Object[] obj1 :filerepmasterlistall)
													{ 
														if(Long.parseLong(obj1[1].toString())==Long.parseLong(obj[0].toString()))
														{%>  
														<li>
															<span class="caret" id="system<%=obj1[0]%>" >
							             						<%=obj1[3] %>
							             					</span>
															<span>
																<button type="button" id="upbutton<%=obj1[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','-','','-','','-','',1)">
									             					<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
									             				</button>
									             				<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj1[0]%>')">                                     
																	<i class="fa fa-download" aria-hidden="true"></i>
																</button> --%>
							             					</span>
															<ul  class="nested">
																<li>
												<!-- ----------------------------------------level 2------------------------------------- -->	
																		<%for(Object[] obj2 :filerepmasterlistall)
																		{ 
																			if(Long.parseLong(obj2[1].toString())==Long.parseLong(obj1[0].toString()))
																			{ %>  
																			<li>
																				<span class="caret" id="system<%=obj2[0]%>" >
																					<%=obj2[3] %>
																				</span>
																				<span>
																					<button type="button" id="upbutton<%=obj2[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','-','','-','',2)">
													             						<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
													             					</button>
													             					<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj2[0]%>')">                                     
																						<i class="fa fa-download" aria-hidden="true"></i>
																					</button> --%>
													             					
											             						</span>
																				<ul  class="nested">
																					<li>
																	<!-- ----------------------------------------level 3------------------------------------- -->	
																							<%for(Object[] obj3 :filerepmasterlistall)
																							{ 
																								if(Long.parseLong(obj3[1].toString())==Long.parseLong(obj2[0].toString()))
																								{%>  
																								<li>
																									<span class="caret" id="system<%=obj3[0]%>" >
																										<%=obj3[3] %>
																									</span>
																									<span>
																										<button type="button" id="upbutton<%=obj3[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','-','',3)">
																		             						<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
																		             					</button>
																		             					<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj3[0]%>')">                                     
																											<i class="fa fa-download" aria-hidden="true"></i>
																										</button> --%>
																             						</span>
																									<ul  class="nested">
																										<li>
																						<!-- ----------------------------------------level 4------------------------------------- -->	
																											<%for(Object[] obj4 :filerepmasterlistall)
																											{ 
																												if(Long.parseLong(obj4[1].toString())==Long.parseLong(obj3[0].toString()))
																												{%>  
																												<li>
																													
																														<span class="caret-last"  id="system<%=obj4[0]%>" >
																															<%=obj4[3] %>
																														</span>
																														<span> 
																															<button type="button" id="upbutton<%=obj4[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','<%=obj4[0]%>','<%=obj4[3] %>',4)">
																							             						<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
																							             					</button>
																							             					
																							             					<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj4[0]%>')">                                     
																																<i class="fa fa-download" aria-hidden="true"></i>
																															</button>  --%>
																							             					
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
						</div>	
					</div> 
				</div> 
			</div>
<!--  -----------------------------------------------agenda attachment ---------------------------------------------- -->


<!-- --------------------------------------------  model start  -------------------------------------------------------- -->



		<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered "  style="max-width: 60% !important;">
		
				<div class="modal-content" >
					   
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				      
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374"></h4>
	
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				        				        
				    </div>
					<div class="modal-body"  style="padding: 0.5rem !important;">
							
							<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
			
								<div class="row">
										<div class="col-md-8">
											<div style="margin-top: 5px;" id="fileuploadlist">
							
											</div>
										</div>
										
				             		</div>					
							</div>
						
					</div>
				</div>
			</div> 
		</div>
		
		<input type="hidden" name="projectid" id="ProjectId" value="<%=projectid %>" />
<!-- --------------------------------------------  model end  -------------------------------------------------------- -->

<form method="POST" action="FileUnpack.htm"  id="downloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="FileUploadId" id="FileUploadId" value="" />
</form>


<input type="hidden" id="agendatempid" value="" />
<input type="hidden" id="addoredit" value="" />
<input type="hidden" id="agendano" value="" />





						<script type="text/javascript">
							
								function selectCheck(id)
								{
									if($('#defagendaid_'+id).is(':checked')) 
									{
										console.log('cheked '+id);
										$('#agendaitem_'+id).attr('required','required');
										$('#projectid_'+id).attr('required','required');
										$('#remarks_'+id).attr('required','required');
										$('#presenterid_'+id).attr('required','required');
										$('#duration_'+id).attr('required','required');
										
										$('#presenterid_'+id+' option[value=""]' ).attr('disabled','disabled');
									}
									else if(!$('#defagendaid_'+id).is(':checked'))
									{
										console.log('uncheked '+id);
										$('#agendaitem_'+id).removeAttr('required');
										$('#projectid_'+id).removeAttr('required');
										$('#remarks_'+id).removeAttr('required');
										$('#presenterid_'+id).removeAttr('required');
										$('#duration_'+id).removeAttr('required');
										
										$('#presenterid_'+id+' option[value=""]' ).removeAttr('disabled');
										
										
									}
									
								}
								
							</script>

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
						
    function Filevalidation (fileid) 
    {
        const fi = $('#'+fileid )[0].files[0].size;							 	
        const file = Math.round((fi / 1024/1024));
        if (file >= <%=filesize%> ) 
        {
        	alert("File too Big, please select a file less than <%=filesize%> mb");
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

  function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}

$('.edititemsdd').select2();
$('.items').select2();

var count=0;
$("table").on('click','.tr_clone_addbtn' ,function() {
   $('.items').select2("destroy");        
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
   $('.items').select2();
   $clone.find('.items' ).select2('val', '');    
   $clone.find("input").val("").end();
  /*  $clone.find("input:number").val("").end(); */
 
  count++;
  
  var id='\''+'file'+count+'\'';
  
   $clone.find("input:file").prop("id", 'file'+count).attr("onchange", 'Filevalidation('+id+')').val("").end() 
     
});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   $('.items').select2("destroy");        
   var $tr = $(this).closest('.tr_clone');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   $('.items').select2();
   /* $clone.find('.items').select2('val', ''); */
   
}
   
});
</script>
 
 

<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->

<script type="text/javascript">

function openMainModal (agendatempid,addedit)
{
	$('#addoredit').val(addedit);
	$('#agendano').val(agendatempid);
	$('#attachmentmodal').modal('show');
}

function setagendaattachval(attachid, attchName)
{
	$addedit=$('#addoredit').val();
	$agendaelem=$('#agendatempid').val();
	console.log(attachid+'  '+attchName+'  '+$addedit+'  '+$agendaelem);
	if($addedit==='a'){
				
		let agendano=$('#agendano').val();
		let html= $("#attachlistdiv_"+agendano).html();
		html += '<tr id="a_'+agendano+'"><td>'+attchName+'</td><td style="width:1% ;white-space: nowrap;">';
		html += '<button type="button" onclick="$(this).parent(\'td\').parent(\'tr\').remove();" > <i class="btn btn-sm fa fa-minus" style="color: red;"   ></i> </button>';  /* onclick="$(\'#a_'+agendano+'\').remove();" */
		html += '<input type="hidden" name="attachid_'+agendano+'" value="'+attachid+'" /></td>';
		
		html += '</tr>';
		 $("#attachlistdiv_"+agendano).html(html);
		
		
	}else if($addedit==='e'){		
		$('#editattachid_'+$agendaelem).val(attachid);
		$('#editattachname_'+$agendaelem).html(attchName);
	}
	$('#exampleModalCenter1').modal('hide');
	$('#attachmentmodal').modal('hide');
		
}


</script>




<script type="text/javascript">
function FileDownload(fileid1)
{
	$('#FileUploadId').val(fileid1);
	$('#downloadform').submit();
}
</script>

<script type="text/javascript">



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






$(document).ready(function(){

	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}
});

function setmodelheader(m,l1,l2,l3,l4,lev,project,divid){
	
	/* var modelhead=project+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+m; */
	
	var modelhead=m;
	
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
																					str += '<li>';
																					
																					if(values[v3][4]!=0)
																					{
																						str += '<input type="radio" class="selectradio" onchange="setagendaattachval(\''+ values[v3][7] +'\', \''+values[v3][3] +'\');" ></button>' ;
																					}else
																					{
																						str += '<input type="radio" class="selectradio" disabled ></button>' ;
																					}
																					
																					str +=' <span class="" id="docsysl3'+values[v3][0]+'" onclick="onclickchange(this);">'+values[v3][3]+'('+values[v3][9]+')</span>';
																						
																					/* str +='<span><button type="button" class="btn"  style="background-color: transparent;margin: -3px 0px;" onclick="showuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][3]+'\',\''+values[v3][8]+'\',\''+values[v3][6]+'\',\''+values[v3][0]+'\',\''+values[v3][9]+'\',\''+values[v3][10]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\')" >';
																					
																					str +=		'<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>';
																					str +=		'</button>'; */
																					if(values[v3][4]!=0)
																					{ 
																						str +=' <span class="version">Ver '+values[v3][8]+'.'+values[v3][6];
																						str +=		' <button type="radio" name="selectattach" class="btn"  style="background-color: transparent;margin: -5px 0px;" onclick="FileDownload(\''+values[v3][4]+'\')">';                                     
																						str += 			'<i class="fa fa-download" aria-hidden="true"></i>';
																						str +=		'</button> ';
																				
																						/* str +=		'  <button type="button" class="btn"  style="background-color: #CFFFFE;padding : 0px 5px 3px;margin: 0px -10px;border: 0.1px solid grey;" onclick="showamuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][3]+'\',\''+values[v3][8]+'\',\''+values[v3][6]+'\',\''+values[v3][0]+'\',\''+values[v3][9]+'\',\''+values[v3][10]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\',\''+values[v3][4]+'\')" >';                                     
																						str += 			' Amendment <img style="height:20px; width: 20px; " src="view/images/amendment-icon-2.png"> ';   /* <i class="fa fa-plus" style="color: #3DB2FF" aria-hidden="true"></i> <i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i> 
																						str +=		'</button> </span>'; */
																						
																						str += '</span>';
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
															
															/* if($doclev1>0)
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
													 */
													
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
<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->


 
 
 
 
 
</body>
</html>