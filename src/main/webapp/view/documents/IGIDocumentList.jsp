<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.card{
box-shadow: rgba(0, 0, 0, 0.25) 0px 4px 14px;
border-radius: 10px;
border: 0px;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa-long-arrow-right {
	font-size: 2.20rem;
	padding: 0px 5px;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.card-deck{
display: grid;
  grid-template-columns: 1fr 1fr 1fr;
}

.pagin{
display: grid;
float:left;
  grid-template-columns: 1fr 1fr 1fr;
}

.table-project-n {
	color: #005086;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
	height: 28px;
}

.col-xl{
height: 28px;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 28px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 28px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.sameline{
display: inline-block;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.editable-click{
float: left;
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
}

.editable-clicko{
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
background: none;border-style: none;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}

.label {
	border-radius: 3px;
	color: white;
	padding: 1px 2px;
}

.label-primary {
	background-color: #D62AD0; /* D62AD0 */
}

.label-warning {
	background-color: #5C33F6;
}

.label-info {
	background-color: #006400;
}

.label-success {
	background-color: #4B0082;
}

.trup{
	padding:6px 10px 6px 10px ;			
	border-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}
.trdown{
	padding:0px 10px 5px 10px ;			
	border-bottom-left-radius : 5px; 
	border-bottom-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}

.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}
</style>   

</head>
<body>
<%
    List<Object[]> igiDocumentList = (List<Object[]>) request.getAttribute("igiDocumentList");
    List<Object[]> igiDocumentSummaryList = (List<Object[]>)request.getAttribute("igiDocumentSummaryList");
	Object[] igiApproval=null;
	if(igiDocumentSummaryList!=null && igiDocumentSummaryList.size()>0){
		igiApproval=igiDocumentSummaryList.get(0);
	}
	
	String version = "1.0";
    version = igiDocumentList != null && igiDocumentList.size() > 0 ? igiDocumentList.get(0)[1].toString() : "1.0";
    
    List<String> igiforwardstatus = Arrays.asList("RIN","RRR","RRA");
    
    FormatConverter fc = new FormatConverter();
%>
<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) {
%>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%= ses1 %>
        </div>
    </div>
<% 
    }
    if (ses != null) { 
%>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%= ses %>
        </div>
    </div>
<% 
    } 
%>

<div class="container-fluid mainDiv">        
    <div class="col-md-12">
        <div class="card shadow-nohover">
            <div class="card-header SubmitHeader">
                <div class="row" style="display: flex; justify-content: space-between;">
                    <div class="col-md-10">
                        <h5 class="mb-0"><b>IGI Document List </b></h5> 
                    </div>  
                    <div class="col-md-2 text-md-end">
                       
                    </div>   
                </div>
            </div>
            <div class="card-body">
                <div class="col-md-12">
                    <div class="table-responsive"> 
                        <table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
                            <thead class="center">
                                <tr>
                                    <th style="width: 5%;">SN</th>
                                    <th style="width: 25%;">Initiated By</th>
                                    <th style="width: 10%;">Initiated Date</th>
                                    <th style="width: 10%;">Version</th>
                                    <th style="width: 25%;">Status</th>
                                    <th style="width: 25%;">Action</th>    
                                </tr>
                            </thead>
                            <tbody>    
                                <% if (igiDocumentList != null && igiDocumentList.size() > 0) {
                                    int count = 0;
                                    for (Object[] obj : igiDocumentList) {
                                        count++;
                                %>
                                <tr>
                                    <td class="center" ><%= count %></td>
                                    <td ><%= obj[10]+", "+obj[11] %></td>
                                    <td class="center"><%= fc.sdfTordf(obj[4].toString()) %></td>
                                    <td class="center" >v<%= obj[1] %></td>
                                    <td align="center" >
                      					<form action="#">
			                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			                            	<input type="hidden" name="docId" value="<%=obj[0] %>">
			                            	<input type="hidden" name="docType" value="A">
			                            	<button type="submit" class="btn btn-sm btn-link w-70 btn-status" formaction="IGIDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[13] %>; font-weight: 600;" formtarget="_blank">
										    	<%=obj[12] %>&emsp;<i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
											</button>
                                        </form>
	                      			</td>
                                   	<td class="center">
									    <form action="#" method="POST" name="myfrm" style="display: inline">
									        
									        <%if(obj[5]!=null && igiforwardstatus.contains(obj[5].toString()) ) {%>
													
													<button type="submit" class="editable-clicko" formaction="IGIDocumentDetails.htm">
											            <div class="cc-rockmenu">
											                <div class="rolling">
											                    <figure class="rolling_icon">
											                        <img src="view/images/preview3.png">
											                    </figure>
											                    <span>Preview</span>
											                </div>
											            </div>
											        </button>
													
													<button type="submit" class="editable-clicko" formaction="IGIDocumentApprovalSubmit.htm" data-toggle="tooltip" data-placement="top" title="Forward" onclick="return confirm('Are You Sure To Forward this Document?');">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/forward1.png">
																</figure>
																<span>Forward</span>
															</div>
														</div>
													</button>
													<input type="hidden" name="Action" value="A">
													
												<%} %>
												<%if(obj[5]!=null && "RFA".equalsIgnoreCase(obj[5].toString()) ) {%>
													<button type="button" class="editable-clicko" data-placement="top" title="Amend" data-toggle="modal" data-target="#myModal" onclick="setversiondata('<%=obj[1]%>','<%=obj[0]%>')">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/correction.png" style="width: 28px;">
																</figure>
																<span>Amend</span>
															</div>
														</div>
													</button>
												<%} %>
												<button class="editable-clicko" name="isPdf" value="Y" formaction="IGIDocumentDetails.htm" formtarget="blank" >
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/pdf.png" style="width: 25px;">
															</figure>
															<span>Document</span>
														</div>
													</div>
												</button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="igiDocId" value="<%=obj[0] %>">
									        <input type="hidden" name="docId" value="<%=obj[0] %>">
									        <input type="hidden" name="docType" value="A">
									    </form>
									</td>
                                </tr>
                                
                                <% } }%>
                            </tbody>
                        </table>
                    </div>
                    <div style="margin-top: 20px; text-align: center;"> 
					    <form id="documentForm" action="IGIDocumentAdd.htm">
					        <input type="hidden" name="version" id="versionField" value="<%= version %>">
					        <button class="btn btn-sm " type="button" onclick="confirmAdd()" style="background-color: #428bca;border-color: #428bca;color: white;font-weight: bold;">Create Doc</button>
					    </form>
					</div>
                </div>
                
                <div class="row mt-4">
 					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For IGI Doc</b></div>
 	    		</div>
    			<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
           			<table align="center"  >
        				<tr>
        					<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
         						Prepared By - <%if(igiApproval!=null) {%><%=igiApproval[10] %> <%} else{%>Prepared By<%} %>
         					</td>
             		
                    		<td rowspan="2">
             					<i class="fa fa-long-arrow-right " aria-hidden="true" style="font-size: 20px;"></i>
             				</td>
             						
        					<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
        						Reviewer - <%if(igiApproval!=null) {%><%=igiApproval[9] %> <%} else{%>Reviewer<%} %>
        	    			</td>
             	    				
                    		<td rowspan="2">
             					<i class="fa fa-long-arrow-right " aria-hidden="true" style="font-size: 20px;"></i>
             				</td>
             						
             				<td class="trup" style="background: linear-gradient(to top, #9b999a 10%, transparent 115%);">
             					Approver - <%if(igiApproval!=null) {%><%=igiApproval[8] %> <%} else{%>Approver<%} %>
             	    		</td>
            			</tr> 	
            	    </table>			             
				</div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="SummaryModalSmall" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document"> <!-- Use modal-lg class -->
        <div class="modal-content" style="max-height: 300px; overflow-y: auto;"> <!-- Set max-height and overflow -->
            <div class="modal-header">
                <h6 class="modal-title" id="smallModalLabel">Current Version: <%= version %></h6>
                <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
			    	<span aria-hidden="true" style="color:red;">&times;</span>
			    </button>
            </div>
            <div class="modal-body">
                <h5>Is New version?</h5>
                <div>
                    <label>
                        <input type="radio" name="newVersion" value="yes" onclick="updateVersion('yes')" checked> Yes
                    </label>
                    <label>
                        <input type="radio" name="newVersion" value="no" onclick="updateVersion('no')"> No
                    </label>
                </div>
                <input type="hidden" name="version" id="version" value="<%= version %>">
            </div>
            <div class="modal-footer">
                <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button> -->
                <button type="button" class="btn btn-primary" onclick="submitForm()">Submit</button>
            </div>
        </div>
    </div>
</div>


<!-- DataTables Initialization Script -->
<script>
    $(document).ready(function() {
        $('#myTable').DataTable({
            "lengthMenu": [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 100],
            "pagingType": "simple",
            "pageLength": 5
        });
    });
</script>

<!-- Confirm Add Functionality -->
<script type="text/javascript">
    var a = '<%= igiDocumentList!=null?igiDocumentList.size():0 %>';
    function confirmAdd() {
        if (a == 0) {
            if (confirm('Do you want to Create IGI Document?')) {
                var form = document.getElementById('documentForm');
                var formAction = form.getAttribute('action'); // Get the form action

                if (formAction) {
                    // Apply the formaction to the form if needed
                    form.action = formAction; 
                    form.submit(); // Submit the form
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } else {
            // Show the small modal instead
            $('#SummaryModalSmall').modal('show');
              updateVersion("yes") 
        }
    }

    // Function to update the version based on user selection
    function updateVersion(option) {
        let currentVersion = parseFloat('<%= version %>');
        let newVersion;

        if (option === 'yes') {
        	newVersion = Math.floor(currentVersion) + 1.0; // Increment to the next whole number and ensure it's in decimal format

        } else {
            newVersion = (currentVersion + 0.1).toFixed(1); // Increment by 0.1
        }

        document.getElementById('versionField').value = newVersion; // Update the hidden input
    }

    // Function to submit the form
    function submitForm() {
        var form = document.getElementById('documentForm');
        form.submit(); // Submit the form with the updated version
    }
</script>
</body>
</html>


<%-- <!-- Small Modal for Document Summary -->
<div class="modal fade" id="SummaryModalSmall" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="smallModalLabel">current Version: <%=version %></h6>
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button> -->
            </div>
            <div class="modal-body">
                <h6></h6>
            </div>
            <!-- <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div> -->
        </div>
    </div>
</div> --%>


