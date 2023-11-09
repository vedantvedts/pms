<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Action Assignee</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden; 
}
h6{
	text-decoration: none !important;
}


</style>
</head>
 
<body>
  <%

  
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  Object[] Assignee=  (Object[]) request.getAttribute("Assignee");
  List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
  List<Object[]> LinkList=(List<Object[]> ) request.getAttribute("LinkList");
  String AssignerName=(String) request.getAttribute("AssignerName");
  Object[] AssigneeDetails=(Object[]) request.getAttribute("AssigneeDetails");
  String actiono=(String) request.getAttribute("actiono");
  String filesize=(String) request.getAttribute("filesize");
  String back = (String) request.getAttribute("back");
  String empId = ((Long)session.getAttribute("EmpId")).toString();
  String projectid=(String)request.getAttribute("projectid");
  String committeeid=(String)request.getAttribute("committeeid");
  String meettingid=(String)request.getAttribute("meettingid");
  String flag=(String)request.getAttribute("flag");
  String ActionPath=(String)request.getAttribute("ActionPath");
  int length=0;
  if(Assignee!=null && Assignee[5]!=null){
	  length=Assignee[5].toString().length();
  }
  String Empid=(String)request.getAttribute("Empid");
 %>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></div>
                    <%} %>

    <br/>
    
    


<div class="container-fluid">

	<div class="container" style="margin-bottom:20px;max-width: 100%;">

		
    		<div class="card" style=" ">
    	
    	
    	
	    		<div class="card-header" style="background-color: #055C9D; padding: 10px; box-sizing: border-box;display: table;"
	    		>
      				  <h6 style="color: white;font-weight: bold;font-size: 1.1rem !important " align="left"> Action : <%if(Assignee!=null && Assignee[5]!=null){%> 
      				  <%if(Assignee[5].toString().length()>100){ %>
      				  <%=Assignee[5].toString().substring(0,100) %> 
      				  <input type="hidden" id="actionValue" value='"<%=Assignee[5].toString()%>"'>
      				  <span style="text-decoration: underline;font-size:13px;color: greenyellow;cursor: pointer;" onclick="showAction('<%=actiono.toString()%>')">show more..</span>
      				  (<%=actiono %>)
      				  <%}else{ %>
      				  <%=Assignee[5] %> (<%=actiono %>)<%}}%>
      				  
                     	<span style="float: right;font-size: 17px;margin-top: 5px">Assigner :<%if(Assignee!=null && Assignee[1]!=null){%> <%=Assignee[1] %><%}%> </span>
                      </h6>
      				
      			</div>
      		
      		
	      		<div class="card-body">
	      			<form method="post" action="SubSubmit.htm" enctype="multipart/form-data" id="subsubmitform">
	        
	        			<div>
	          			 	
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										<th>As On Date</th>
										<th>Remarks</th>
										<th>Progress %</th>
										<th>Attachment</th>
									</tr>							
									<tr id="Memberrow0">									
										<td width="10%"><input  class="form-control "  data-date-format="dd/mm/yyyy" name="AsOnDate" id="DateCompletion" required="required" readonly="readonly" ></td>
										<td width="20%"><input type="text" name="Remarks" class="form-control item_name" maxlength="500"  required="required" /></td>      
										<td width="10%"><input type="number" name="Progress" class="form-control item_name" max="100"  min="0"  required="required" /></td>								
						         		<td  width="25%"><input type="file" name="FileAttach" id="FileAttach"  class="form-control wrap" aria-describedby="inputGroup-sizing-sm" maxlength="255" onchange="Filevalidation('FileAttach');"  /></td>										
									</tr>
								</thead>
							</table>

	          					<div align="center">
				            	<input type="submit"  class="btn  btn-sm submit" id="myBtn" onclick="return formsubmit('subsubmitform');" value="SUBMIT"/>
				            	<%if(flag==null) {%>
				            	<%if("backToReview".equalsIgnoreCase(back)){%>
				            	<a type="button" class="btn  btn-sm back"  <%if(ActionPath==null ) {%>href="ActionForwardList.htm?Type=NB"<%}else{ %>href="ActionIssue.htm" <%} %>>BACK</a>
				            	<%}else if("backTotodo".equalsIgnoreCase(back)){%>
				            	<a type="button" class="btn  btn-sm back" <%if(ActionPath==null ) { %>   href="ToDoReviews.htm"  <%}else{ %>href="ActionIssue.htm"<%} %>>BACK</a>
				            	<%}else{%>
				            	<a type="button" class="btn  btn-sm back"   <%if(ActionPath==null ) { %> href="AssigneeList.htm" <%}else{ %>href="ActionIssue.htm" <%} %>>BACK</a>
				            	<%}%>
				            	<%}else{ %>
	                           	<a type="button" class="btn  btn-sm back" href="MeettingAction.htm?projectid=<%=projectid %>&committeeid=<%=committeeid %>&meettingid=<%=meettingid %>&Empid=<%=empId %>" >BACK</a>
	          					<%} %>
				            	<button type="reset" class="btn btn-sm reset" style="color: white" onclick="formreset()"> RESET</button>
	                           	<% if(SubList.size()>0 && (!Empid.equalsIgnoreCase(Assignee[22].toString())||Assignee[22].toString().equalsIgnoreCase(Assignee[23].toString()))){ %>  
	                      		<button type="button" class="btn btn-success btn-sm submit" onclick="backfrmsubmit('fwdfrm');"  title="To Review and Close">Action Forward</button>
	                           	<%} %>
	                           	
	          					</div>
	        			</div>
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			     		<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" /> 
			     		<input type="hidden" name="ActionAssignId" value="<%=Assignee[18] %>" /> 
	      				</form>
	      	
	      	
	      				<form action="ActionForward.htm" method="post" id="fwdfrm">
	      				<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" /> 
	      				<input type="hidden" name="ActionAssignId" value="<%=Assignee[18] %>" /> 
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	      				<input type="hidden" name="Type" value="NB" /> 
	      				<input type="hidden" name="projectid" value="<%=projectid %>" /> 
	      				<input type="hidden" name="committeeid" value="<%=committeeid %>" /> 
	      				<input type="hidden" name="meettingid" value="<%=meettingid %>" />  
	      				</form>
					</div>
	    		</div>
    		</div>
   	</div>   
 
 
    
 <div class="row">
	<div class="col-md-12">
    	<div class="card" style="">
      		<div class="card-body" >
      		 <div class="row">
				<div class="col-md-1"></div>
				   <div class="col-md-10" style="padding-left: 0px">
				   <% if(LinkList!=null && LinkList.size()>0){ %>  
				   				<div class="table-responsive">
				    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
										<thead>
											<tr>
												<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Old Action  Details  <%=AssigneeDetails[0] %><%=AssigneeDetails[1] %> </th>									
											</tr>	
											<tr>					
												<th style="text-align: left;">As On Date</th>
												<th style="">Progress %</th>
												<th style="">Remarks</th>								
											 	<th style="">Attachment</th>
												<th style="">Action</th>
											</tr>
										</thead>
										<tbody>					
										<%
										for(Object[] obj: LinkList){ %>
																		
										<tr >
												<td width="12%">
													<%=sdf.format(obj[3])%>
												</td>
												
												<td width="6%">
													
													<div class="progress" style="background-color:#cdd0cb !important">
				  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[2]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
													</div>
								
														</td>
												
												<td style="text-align: left; width: 10%;"> 
													<%=obj[4]%>
												</td>
												
												<td style="text-align: left; width: 3%;">
												
												 <% 
											        if( obj[5]!=null){
											        %>
											        <div  align="center">
															<a  
															 href="ActionDataAttachDownload.htm?ActionSubId=<%=obj[5]%>" 
															 target="_blank"><i class="fa fa-download"></i></a>
														</div>
													
														
													<%}else{ %>
													
													<div  align="center">-</div>
													 <%} %>
													
										
												</td>
											
																		
												<td style="text-align: left; width: 6%;">
											     Old Action
												</td>
										
										</tr>
																		
											<%  } %>	
													</tbody>
									</table>
								</div> 
								<%} %>
								
								<% if(SubList.size()>0){ %>  
											
											<div class="table-responsive">
				    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
										<thead>
											<tr>
												<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Action Updated Details </th>									
											</tr>	
											<tr>					
												<th style="text-align: left;">As On Date</th>
												<th style="">Progress %</th>
												<th style="">Remarks</th>								
											 	<th style="">Attachment</th>
												<!-- <th style="">Action</th> -->
											</tr>
										</thead>
										<tbody>					
									 	<%int  count=1;
										for(Object[] obj: SubList){ %>
																		
										<tr>
											<td width="12%"><%=sdf.format(obj[3])%></td>
											<td width="6%">
													<div class="progress" style="background-color:#cdd0cb !important">
				  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[2]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
													</div>
											</td>
											<td style="text-align: left; width: 10%;"><%=obj[4]%></td>
											<td style="text-align: left; width: 3%;">
												<%if( obj[5]!=null){%>
											        <div  align="center">
															<a  href="ActionDataAttachDownload.htm?ActionSubId=<%=obj[5]%>"  target="_blank"><i class="fa fa-download"></i></a>
													</div>
												<%}else{%>
												<div  align="center">-</div>
												 <%}%>
												</td>
											<%-- <td style="text-align: left; width: 6%;">
												<form method="post" action="SubSubmit.htm" enctype="multipart/form-data">
					                                <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
				 									<button type="submit" class="btn  btn-sm" name="action" value="delete" onclick="return confirm('Are you sure To Delete?')" formaction="ActionSubDelete.htm" style="background-color:  #D3D3D3;"> <i class="fa fa-trash" aria-hidden="true" ></i></button>
													<input type="hidden" name="ActionSubId" value="<%=obj[0]%>"/>
									                <input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" />
									                <input type="hidden" name="ActionAssignId" value="<%=Assignee[18] %>" /> 
									                <input type="hidden" name="ActionAttachid" value="<%=obj[5]%>"> 
											        </form>
												</td> --%>
											</tr>				
											<% count++; } %>
										</tbody>
									</table>
								</div> 
							<%}%>
							</div>
  						</div>
				</div>
			</div>
		</div>
	</div>
 <!-- Modal for action -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height:50px;">
        <h5 class="modal-title" id="exampleModalLongTitle">Action</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalbody">
     
      </div>
      <div align="right" id="header" class="p-2"></div>
    </div>
  </div>
</div>

<script type="text/javascript">

	function formreset()
	{
		document.getElementById("myBtn").disabled = false;
	
		document.getElementById("DateCompletion").click();	
		
	}




		var fsizeindi=0;
			  function Filevalidation (fileid) 
			    {
			        const fi = $('#'+fileid )[0].files[0].size;							 	
			        const file = Math.round((fi / 1024/1024));
			        if (file >= <%=filesize%>) 
			        {
			        	fsizeindi++;
			        	alert("File too Big, please select a file less than <%=filesize%> mb");
			        	document.getElementById("myBtn").disabled = true;
			        }else{
			        	fsizeindi=0;
			        	document.getElementById("myBtn").disabled = false;
			        }
			    }
   		function formsubmit(formid)
   		{
   			if(fsizeindi>0)
   			{
   				alert("File too Big, please select a file less than 50mb");
   				event.preventDefault();
   				return false;
   				
   			}else
   			{
   				return confirm('Are You Sure To Submit?');
   			}
   		}
   		$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" :new Date(), */
			"startDate" : new Date(),

			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
   		function backfrmsubmit (formid)
   			{  		
   			if(confirm('Are You Sure To Forward?')){
   				$('#'+formid).submit();
   			}
   			}
   		function showAction(b){
   			var actionValue=$('#actionValue').val();
   			$('#modalbody').html(actionValue);
   			$('#header').html(b);
   			$('#exampleModalCenter').modal('show');
   		}
</script> 


</body>
</html>