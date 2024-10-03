<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>PMS</title>
    <jsp:include page="../static/header.jsp"></jsp:include>
    
    <spring:url value="/resources/css/Overall.css" var="StyleCSS" />
    <link href="${StyleCSS}" rel="stylesheet" />
    <spring:url value="/resources/js/excel.js" var="excel" />
    <script src="${excel}"></script>
    
    <spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
    <spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
    <script src="${ckeditor}"></script>
    <link href="${contentCss}" rel="stylesheet" />
    
    


</head>
<body>

<%
List<Object[]> IgiDocumentSummaryList=(List<Object[]>)request.getAttribute("IgiDocumentSummaryList");
Object[]DocumentSummary=null;
if(IgiDocumentSummaryList!=null && IgiDocumentSummaryList.size()>0){
	DocumentSummary=IgiDocumentSummaryList.get(0);
}
String DocIgiId =(String)request.getAttribute("DocIgiId");
List<Object[]>TotalEmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");

List<Object[]>MemberList = (List<Object[]>)request.getAttribute("MemberList");
List<Object[]>EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");

%>

    <% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
            </div>
        </div>
    <% } %>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow-nohover" style="margin-top: -0.6pc">
                    <div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
                        <div class="col-md-10" id="projecthead" align="left">
                            <h5 id="text" style="margin-left: 1%; font-weight: 600">
                                IGI Document Details -
                                <small></small>
                            </h5>
                        </div>
                        <div class="col-md-2" align="right">
                            <a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;" href="IgiDocument.htm">Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" id="container" style="height: 80%;">
        <div class="row" style="display:inline;height: 90%;">
            <div class="requirementid mt-2 ml-2" style="height: 90%;">
                <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDocPDF()"><img alt="" src="view/images/pdf.png" >&nbsp;IGI Document</span> 
                <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSummaryModal()"><img alt="" src="view/images/requirements.png" />&nbsp;&nbsp;Document Summary</span>
                <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSentModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Distribution</span>
                <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showChapter1()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Chapter 1 : Introduction</span>
                <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showChapter2()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Chapter 2 : Interfaces</span>
            </div>

            <div class="mt-2" id="reqdiv">
                <div style="margin-left: 5%; overflow:auto" id="scrollclass">
                </div>
            </div>
        </div>
    </div>

<!-- Document Summary Modal Structure -->
<div class="modal fade" id="SummaryModal" tabindex="-1" aria-labelledby="SummaryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width:150%;margin-left: -20%">
            <div class="modal-header">
                <h5 class="modal-title" id="SummaryModalLabel">IGI Document Summary</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
               <form action="IgiDocumentSummaryAdd.htm" method="post">
               
                  <div class="row">
   							<div class="col-md-4">
   								<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Additional Information:</label>
   							</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="information" class="form-control" id="additionalReq" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[1]!=null){%><%=DocumentSummary[1]%><%}else{%><%}%></textarea>
				   			</div>
   				 </div>
   				 
   				 <div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Abstract:</label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="abstract" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[2]!=null){%><%=DocumentSummary[2]%><%}else{%><%}%></textarea>
				   			</div>
			   	</div>
			   	
			   	<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Keywords:</label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="keywords" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[3]!=null){%><%=DocumentSummary[3]%><%}else{%><%}%></textarea>
				   			</div>
   				</div>
   			
   		    	<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Distribution:</label>
				   			</div>
				   			<div class="col-md-8">
				   				<input required="required" name="distribution" class="form-control" id="" maxlength="255"
								 placeholder="Maximum 255 Chararcters" required value="<%if(DocumentSummary!=null && DocumentSummary[4]!=null){%><%=DocumentSummary[4]%><%}else{%><%}%>">
				   			</div>
   				</div>
   				
   				
   			
   				<div class="row mt-2">
   				
   				            <div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Release Date:</label>
			   				</div>	
   				
   				 			<div class="col-md-4">
	   							<input id="pdc-date" data-date-format="dd/mm/yyyy" readonly name="pdc" <%if(DocumentSummary!=null && DocumentSummary[10]!=null){%> value="<%=DocumentSummary[10].toString() %> " <%}%> class="form-control form-control">
   				
   							</div>
   				
   							<div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Prepared By:</label>
			   				</div>
			   				<div class="col-md-4">
	   							<select class="form-control selectdee"name="preparedBy" id=""data-width="100%" data-live-search="true"  required>
	          						<option value="" selected disabled>--SELECT--</option>
	        						<%for(Object[]obj:TotalEmployeeList){ %>
	        							<option value="<%=obj[0].toString()%>" <%if(DocumentSummary!=null && DocumentSummary[9]!=null && DocumentSummary[9].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
	        							</option>
	        						<%} %>
	        					</select>
   					      </div>
   				</div>
   				
   				<div class="row mt-2">
			   				<div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Reviewer:</label>
			   				</div>	
   				
   				 			<div class="col-md-4">
	   							<select class="form-control selectdee"name="reviewer" id=""data-width="100%" data-live-search="true" required>
	       		 					<option value="" selected disabled="disabled">--SELECT--</option>
	       		 					<%for(Object[]obj:TotalEmployeeList){ %>
	        							<option value="<%=obj[0].toString()%>" <%if(DocumentSummary!=null && DocumentSummary[5]!=null &&  DocumentSummary[5].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
	        							</option>
	        						<%} %>
	        					</select>
   				
   							</div>
   				
			   				<div class="col-md-2">
						   		<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f;float:right;">Approver:</label>
						   	</div>	
   							<div class="col-md-4">
		   						<select class="form-control selectdee"name="approver" id=""data-width="100%" data-live-search="true"  required>
		       						<option value="" selected disabled="disabled">--SELECT--</option>
	        						<%for(Object[]obj:TotalEmployeeList){ %>
	       	 							<option value="<%=obj[0].toString()%>" <%if(DocumentSummary!=null && DocumentSummary[6]!=null && DocumentSummary[6].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
	        							</option>
	        						<%} %>
		        				</select>
   							</div>
   						</div>
   						
   						<div class="mt-2" align="center">
   							<%if(IgiDocumentSummaryList!=null && IgiDocumentSummaryList.size()>0) {%>
   								<button class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm ('Are you sure to submit?')">UPDATE</button>
   								<input type="hidden" name="summaryId" value="<%=DocumentSummary[0]%>"> 
   							<%}else{ %>
   								<button class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
   							<%} %>
   							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="DocIgiId" value="<%=DocIgiId%>"> 
   						</div>
               </form>
            </div>
        </div>
    </div>
</div>

<!-- modal for Document Distribution -->
	<div class="modal fade" id="DistributionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
    		<div class="modal-content">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color:white;">
			        <h5 class="modal-title" >Document Sent to</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<%if(MemberList!=null && !MemberList.isEmpty()) {%>
      					<div class="row mb-2">
							<div class="col-md-12">
								<table class="table table-bordered" id="myTables">
									<thead>
										<tr>
											<th  style="text-align: center;">SN</th>
											<th  style="text-align: center;">Name</th>
											<th  style="text-align: center;">Designation</th>
											<th  style="text-align: center;">Action</th>
										</tr>
									</thead>
									<tbody>
									<%int rowCount=0;
										for(Object[]obj:MemberList) {%>
											<tr>
												<td style="text-align: center;width:10%;"><%=++rowCount %></td>
												<td style="width:50%;margin-left: 10px;"><%=obj[1].toString() %></td>
												<td style="width:40%;margin-left: 10px;"><%=obj[2].toString() %></td>
												<td style="width:40%; margin-left: 10px;">
												    <form id="deleteForm_<%= obj[5] %>" action="#" method="POST" name="myfrm" style="display: inline">
												        <button type="submit" class="editable-clicko" formaction="DeleteIgiDocument.htm" onclick="return confirmDeletion('<%= obj[5] %>');">
												            <img src="view/images/delete.png" alt="Delete">
												        </button>
												        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
												        <input type="hidden" name="IgiMemeberId" value="<%= obj[5] %>">
												        <input type="hidden" name="DocIgiId" value="<%= DocIgiId %>">
												    </form>
												</td>

											</tr>
										<%} %>
									</tbody>
								</table>
							</div>      
      					</div>
      				<%} %>
      				
       				<form action="IgiDocumentMemberSubmit.htm" method="post">
      					<div class="row">
							<div class="col-md-10">
								<select class="form-control selectdee"name="Assignee" id="Assignee"data-width="100%" data-live-search="true" multiple required>
							        <%for(Object[]obj:EmployeeList){ %>
							        	<option value="<%=obj[0].toString()%>"> <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
							        <%} %>
							       
        						</select>
        					</div>
					      	<div class="col-md-2" align="center">
					      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
		
								<input type="hidden" name="DocIgiId" value="<%=DocIgiId%>">	 
					    		<button type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')"> SUBMIT</button>
					      	</div>
      					</div>
      				</form>
      			</div>
    		</div>
  		</div>
	</div>
	
	<!--Downlaod PDF Document  -->
			
		<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<button class="btn bg-transparent" id="DownLoadPdf" formaction="TestPlanDownlodPdf.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="DocIgiId" value="<%=DocIgiId%>">
		</form>
		
		
		
		<!--Downlaod PDF End -->


	<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="DocIgiId" value="<%=DocIgiId%>"> 
		
			<button class="btn bg-transparent" id="interfacebtn" formaction="IgiInterfaces.htm" formmethod="post" formnovalidate="formnovalidate"  style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
		</form>


    <script type="text/javascript">
        function showSummaryModal() {
            $('#SummaryModal').modal('show');
        }
        function showSentModal(){
    		$('#DistributionModal').modal('show');
    	}
        function DownloadDocPDF(){
        	$("#DownLoadPdf").click();
        }
    </script>
    
    <script type="text/javascript">
    function confirmDeletion(memberId) {
        if (confirm('Are you sure you want to delete this member?')) {
            var form = $('#deleteForm_' + memberId);
            form.submit();
            return true;
        } else {
            return false;
        }
    }

    </script>
    
    <script type="text/javascript">
	$('#pdc-date').daterangepicker({
		
		"singleDatePicker": true,
		"showDropdowns": true,
		"cancelClass": "btn-default",
		
		<%if(DocumentSummary==null || DocumentSummary[10]==null) {%>
		"startDate":new Date() ,
	<%}%>
	
		locale: {
	    	format: 'DD-MM-YYYY'
			}
	});
	
	function showChapter2(){
		$('#interfacebtn').click();
	}
	
	</script>
    
 

</body>
</html>
