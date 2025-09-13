<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Issue Update</title>
   <spring:url value="/resources/css/issue/issueUpdate.css" var="issueUpdate" />     
<link href="${issueUpdate}" rel="stylesheet" />


<jsp:include page="../static/header.jsp"></jsp:include>


</head>
 
<body>
  <%

  
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  Object[] Assignee=  (Object[]) request.getAttribute("Assignee");
  List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
  Object[] AssigneeDetails=(Object[]) request.getAttribute("AssigneeDetails");
  String filesize=(String) request.getAttribute("filesize");
 %>



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

    <br />
    
    


<div class="container-fluid">

	<div class="container containerDiv" >

		
    		<div class="card" >
      				<div class="card-header cardheader" >
      				  <h6  class="assigneeHeading" align="left"> Issue : <%if(Assignee!=null && Assignee[5]!=null){%> <%=StringEscapeUtils.escapeHtml4(Assignee[5].toString()) %> (<%=Assignee[10]!=null?StringEscapeUtils.escapeHtml4(Assignee[10].toString()):" - " %>)<%}%>
                     	<span  class="assignorSpan">Assigner :<%if(Assignee!=null && Assignee[1]!=null){%> <%=StringEscapeUtils.escapeHtml4(Assignee[1].toString()) %><%}%> </span>
                      </h6>
      		</div>
      		<div class="card-body">
	      			<form method="post" action="SubSubmit.htm" enctype="multipart/form-data" id="subsubmitform">
	        
	        			<div>
	          			 	
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" >
								<thead>  
									<tr id="">
										<th>As On Date</th>
										<th>Remarks</th>
										<th>Progress %</th>
										<th>Attachment</th>
									</tr>							
									<tr id="Memberrow0">									
										<td width="10%"><input  class="form-control "  data-date-format="dd/mm/yyyy" name="AsOnDate" id="DateCompletion" required="required" readonly="readonly" ></td>
										<td width="20%"><input type="text" name="Remarks" class="form-control item_name" maxlength="255"  required="required" /></td>      
										<td width="10%"><input type="number" name="Progress" class="form-control item_name" max="100"  min="0"  required="required" /></td>								
						         		<td width="25%"><input type="file" name="FileAttach" id="FileAttach"  class="form-control wrap" aria-describedby="inputGroup-sizing-sm" maxlength="255" onchange="Filevalidation('FileAttach');"  /></td>										
									</tr>
								</thead>
							</table>

	          				<div align="center">
	          					<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
				            	<input type="submit"  class="btn  btn-sm submit" id="myBtn" onclick="return formsubmit('subsubmitform');" value="SUBMIT"/>
	          					<input type="hidden" name="ActionMainId" <%if(Assignee!=null && Assignee[0]!=null){%> value="<%=Assignee[0]%>" <%}%>>
	          					<input type="hidden" name="ActionAssignId" <%if(Assignee!=null && Assignee[19]!=null){%> value="<%=Assignee[19]%>" <%}%>>
	          					<input type="hidden" name="ActionItem" <%if(Assignee!=null && Assignee[5]!=null){%> value="<%=Assignee[5]%>" <%}%>>
	          					<input type="hidden" name="ProjectId" <%if(Assignee!=null && Assignee[21]!=null){%> value="<%=Assignee[21]%>" <%}%>>
	          					<a class="btn btn-info btn-sm  back"   href="ActionIssue.htm">Back</a>
	          					<% if(SubList.size()>0){ %>  
	                      			<button type="button" class="btn btn-success btn-sm submit" onclick="backfrmsubmit('fwdfrm');"  title="To Review and Close">Action Forward</button>
	                           	<%} %>
	          				</div>
	        			</div>
	      			</form>

					<form action="IssueForward.htm" method="post" id="fwdfrm">
	      				<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" /> 
	      				<input type="hidden" name="ActionAssignId" value="<%=Assignee[19] %>" /> 
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	      				<input type="hidden" name="Type" value="NB" /> 
	      			</form>
				</div>
	    		</div>
    		</div>
   	</div>   
 
 
    
 <div class="row">
	<div class="col-md-12">
    	<div class="card" >
      		<div class="card-body" >
      		 <div class="row">
				<div class="col-md-1"></div>
				   <div class="col-md-10" >
								<% if(SubList!=null && SubList.size()>0){ %>  
											
											<div class="table-responsive">
				    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" >
										<thead>
											<tr>
												<th colspan="7"  class="actionUpdateDetails">Action Updated Details </th>									
											</tr>	
											<tr>					
												<th class="asOnDate">As On Date</th>
												<th >Progress %</th>
												<th >Remarks</th>								
											 	<th >Attachment</th>
												<th >Action</th>
											</tr>
										</thead>
										<tbody>					
									 	<%int  count=1;
										for(Object[] obj: SubList){ %>
																		
										<tr>
										
												<td  class="asOnDateData">
													<%=obj[3]!=null?sdf.format(obj[3]):""%>
												</td>
												
												<td width="6%">
													
													<div class="progress"  class="issueUpdateDiv">
				  										<div class="progress-bar progress-bar-striped width<%=obj[2]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></div>
													</div>
								
														</td>
												
												<td  class="remarkstd" > 
													<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%>
												</td>
												
												<td  class="attachementtd">
												
											 <% 
										        if( obj[5]!=null){
										        %>
										        <div  align="center">
														<a  
														 href="ActionDataAttachDownload.htm?ActionSubId=<%=StringEscapeUtils.escapeHtml4(obj[5].toString())%>" 
														 target="_blank"><i class="fa fa-download"></i></a>
													</div>
												
													
												<%}else{ %>
												
												<div  align="center">-</div>
												 <%} %>
													
										
												</td>
												
																		
												<td  class="subSubmitTd">
												<form method="post" action="SubSubmit.htm" enctype="multipart/form-data">
													
					                                <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
						
													<button type="submit" class="btn  btn-sm" name="action" value="delete" onclick="return confirm('Are you sure To Delete?')" formaction="ActionSubDelete.htm"  class="dltBtn"> <i class="fa fa-trash" aria-hidden="true" ></i></button>
													<input type="hidden" name="ActionSubId" value="<%=obj[0]%>"/>
									                <input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" />
									                <input type="hidden" name="ActionAssignId" value="<%=Assignee[19] %>" /> 
									                <input type="hidden" name="ActionAttachid" value="<%=obj[5]%>"> 
											        </form>
												</td>
										
											</tr>
																		
											<% count++; } %>
										</tbody>
									</table>
								</div> 
							<%} %>
								</div>
			 	
  						</div>

				</div>

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
</script> 


</body>
</html>