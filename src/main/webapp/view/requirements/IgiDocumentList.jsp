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
    

</head>
<body>
<%
    List<Object[]> IgiDocumentList = (List<Object[]>) request.getAttribute("IgiDocumentList");
    int documentListSize = (int) request.getAttribute("documentListSize");
    FormatConverter fc = new FormatConverter();
    
    String version = "1.0";
    version = IgiDocumentList != null && IgiDocumentList.size() > 0 ? IgiDocumentList.get(0)[1].toString() : "1.0";
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
                        <h5 class="mb-0"><b>&nbsp; &nbsp;IGI Document List </b></h5> 
                    </div>  
                    <div class="col-md-2 text-md-end">
                        <table style="float:right!important;">
                            <tr>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="left" style="padding-top:0px!important;">     
                                    <div style="margin-top: -6px;">
                                        <a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;" href="MainDashBoard.htm">Back</a>
                                    </div>
                                </td>  
                            </tr>
                        </table>
                    </div>   
                </div>
            </div>
            <div class="card-body">
                <div class="col-md-12">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="table-responsive"> 
                        <table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
                            <thead>
                                <tr>
                                    <th style="text-align:center;white-space: nowrap;">SN</th>
                                    <th style="text-align:center;white-space: nowrap;">Initiated By</th>
                                    <th style="text-align:center;white-space: nowrap;">Initiated Date</th>
                                    <th style="text-align:center;white-space: nowrap;">Version</th>
                                    <th style="text-align:center;white-space: nowrap;">Status</th>
                                    <th style="text-align:center;white-space: nowrap;">Action</th>    
                                </tr>
                            </thead>
                            <tbody>    
                                <% if (IgiDocumentList != null && IgiDocumentList.size() > 0) {
                                    int count = 0;
                                    for (Object[] obj : IgiDocumentList) {
                                        count++;
                                %>
                                <tr>
                                    <td align="center" style="width:1%"><%= count %></td>
                                    <td align="left" style="width:4%"><%= obj[10] %></td>
                                    <td align="center" style="width:3%"><%= fc.SqlToRegularDate(obj[4].toString()) %></td>
                                    <td align="center" style="width:2%">v<%= obj[1] %></td>
                                    <td align="center" style="width:10%"></td>
                                   <td align="center" style="width:5%">
									    <form action="#" method="POST" name="myfrm" style="display: inline">
									        <button type="submit" class="editable-clicko" formaction="IgiDocumentDetails.htm">
									            <div class="cc-rockmenu">
									                <div class="rolling">
									                    <figure class="rolling_icon">
									                        <img src="view/images/preview3.png">
									                    </figure>
									                    <span>Preview</span>
									                </div>
									            </div>
									        </button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="DocIgiId" value="<%= obj[0] %>">
									    </form>
									</td>
                                </tr>
                                <% 
                                    }
                                } else { 
                                %>
                                <tr><td colspan="5" align="center">No Records Found.</td></tr>
                                <% 
                                } 
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div style="margin-top: 20px; text-align: center;"> 
					    <form id="documentForm" action="addIgiDocument.htm">
					        <input type="hidden" name="version" id="versionField" value="<%= version %>">
					        <button type="button" class="btn btn-primary" onclick="confirmAdd();">CREATE DOC</button>
					    </form>
					</div>
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
            </div>
            <div class="modal-body">
                <h5>Is new version?</h5>
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
    var a = '<%= documentListSize %>';
    function confirmAdd() {
        if (a == 0) {
            if (confirm('Are you want to Add IGI Document?')) {
                var form = document.getElementById('documentForm');
                var formAction = form.getAttribute('action'); // Get the form action

                console.log("formAction--" + formAction);

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


