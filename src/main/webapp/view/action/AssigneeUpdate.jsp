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

	<div class="container" style="margin-bottom:20px;">

		
    		<div class="card" style=" ">
    	
    	
    	
	    		<div class="card-header" style="background-color: #055C9D;">
      				<h6 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left"> Action :  <%=Assignee[5] %> (<%=actiono %>)
                     <span style="float: right;font-size: 17px;margin-top: 5px">Assigner : <%=AssignerName %> </span>
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
										<td width="20%"><input type="text" name="Remarks" class="form-control item_name" maxlength="255"  required="required" /></td>      
										<td width="10%"><input type="number" name="Progress" class="form-control item_name" max="100"  min="0"  required="required" /></td>								
						         		<td  width="25%"><input type="file" name="FileAttach" id="FileAttach"  class="form-control wrap" aria-describedby="inputGroup-sizing-sm" maxlength="255" onchange="Filevalidation('FileAttach');"  /></td>										
									</tr>
								</thead>
							</table>

	          				<div align="center">
				            	<input type="submit"  class="btn  btn-sm submit" id="myBtn" onclick="return formsubmit('subsubmitform');" value="SUBMIT"/>
				            	<a type="button" class="btn  btn-sm back" href="AssigneeList.htm"  >BACK</a>
				            	<button type="reset" class="btn btn-sm reset" style="color: white" onclick="formreset()"> RESET</button>
		          				<%if(!"0".equalsIgnoreCase(Assignee[8].toString())){ %>
	 								<%if(Assignee[13].toString().equalsIgnoreCase("S")){ %>
	      				 	  			<input type="submit" class="btn  btn-sm view" value="Meeting Content View" formaction="AgendaView.htm" formtarget="_blank"/>
				       				<%} %>
	                           	<%} %> 
	                           	<% if(SubList.size()>0){ %>  
	                      			<button type="button" class="btn btn-success btn-sm submit" onclick="backfrmsubmit('fwdfrm');" >Forward</button>
	                           	<%} %>
	          				</div>
	        			</div>
	        		
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			     		<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" /> 
	      			</form>
	      	
	      	
	      			<form action="ActionForward.htm" method="post" id="fwdfrm">
	      				<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" /> 
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
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
				   <% if(LinkList.size()>0){ %>  
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
										        if(obj[5].toString().length()!=0 && obj[5]!=null){
										        %>
										        <div  align="center">
														<a  
														 href="ActionAttachDownload.htm?ActionSubId=<%=obj[7]%>" 
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
											 	<!-- <th style="">Upload</th> -->
												<th style="">Action</th>
											</tr>
										</thead>
										<tbody>					
									 	<%int  count=1;
										for(Object[] obj: SubList){ %>
																		
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
										        if(obj[5].toString().length()!=0 && obj[5]!=null){
										        %>
										        <div  align="center">
														<a  
														 href="ActionAttachDownload.htm?ActionSubId=<%=obj[7]%>" 
														 target="_blank"><i class="fa fa-download"></i></a>
													</div>
												
													
												<%}else{ %>
												
												<div  align="center">-</div>
												 <%} %>
													
										
												</td>
												
																		
												<td style="text-align: left; width: 6%;">
												<form method="post" action="SubSubmit.htm" enctype="multipart/form-data">
													
					                                <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
						
				<!-- 									<button type="submit" class="btn btn-warning btn-sm" name="action" value="edit" onclick="return confirm('Are you sure To Submit?')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
				 -->								<button type="submit" class="btn  btn-sm" name="action" value="delete" onclick="return confirm('Are you sure To Delete?')" formaction="ActionSubDelete.htm" style="background-color:  #D3D3D3;"> <i class="fa fa-trash" aria-hidden="true" ></i></button>
													<input type="hidden" name="ActionSubId" value="<%=obj[0]%>"/>
									                <input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" /> 
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