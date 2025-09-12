<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"
	%>
	<%@ page import="java.time.LocalDateTime, java.time.LocalDate,java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/AuditPatches.css" var="auditpatches" />
<link href="${auditpatches}" rel="stylesheet" />
<title>Audit Patches</title>
</head>
<body>
    <% 
        // Fetching list of Audit Patches
        List<Object[]> AuditPatchesList = (List<Object[]>) request.getAttribute("AuditPatchesList");
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
    
    <br>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow-nohover">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-10">
                                <h4>Audit Patches List</h4>
                            </div>
                        </div>
                    </div>

                    <div class="card-body">
                        <form action="AuditPatchEdit.htm" method="post" class="form-display" >
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
							    <thead class="text-center">
							        <tr>
							            <th>Select</th>
							            <th>Version No</th>
							            <th class="w-610">Description</th>
							            <th>Patch Date</th>
							            <th>Updated Date</th>
							            <th>Attachment</th>
							        </tr>
							    </thead>
							    <tbody>
							        <% 
							            int count = 0;
							            for (Object[] obj : AuditPatchesList) { 
							                count++; 
							                String description = (String) obj[1];
							                boolean longDescription = description.length() > 90;
							                String shortDescription = description.substring(0, Math.min(description.length(), 90));
							        %>
							        <tr>
							            <td class="text-center v-align">
							                <input type="radio" name="ProjectId" value="<%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): "" %>" class="d-block m-auto">
							            </td>
							            <td class="text-center"><%= obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td>
							            <td>
										    <span id="short-description-<%= count %>"><%= shortDescription!=null?StringEscapeUtils.escapeHtml4(shortDescription): " - " %></span>
										    <% if (longDescription) { %>
										        <span id="dots-<%= count %>" class="d-inline" >...</span>
										        <span id="more-<%= count %>" class="d-none m-0 p-0" ><%= description!=null?StringEscapeUtils.escapeHtml4(description.substring(90)): " - " %></span>
										        <span class="btn btn-link m-0 p-0" id="toggle-link-<%= count %>"  onclick="toggleDescription('<%= count %>')">Show More</span>
										    <% } %>
										    <span class="full-description d-none" data-description="<%= description %>"></span> <!-- Added this line -->
										</td>
							            <% if(obj[5] != null) {
							                java.util.Date date = (java.util.Date) obj[5];
							                SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
							                String formattedDate1 = formatter.format(date);
							            %>
							            <td class="text-center" ><%= formattedDate1!=null?StringEscapeUtils.escapeHtml4(formattedDate1): " - " %></td>
							            <% } else { %>
							            <td class="text-center" >-</td>
							            <% } %>
							            <%
							                String sqlDate = obj[2].toString().split("\\.")[0];
							                DateTimeFormatter sqlFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
							                LocalDateTime dateTime = LocalDateTime.parse(sqlDate, sqlFormatter);
							                DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
							                String formattedDate = dateTime.format(outputFormatter); 
							                LocalDate updatedDate = dateTime.toLocalDate();
							                LocalDate currentDate = LocalDate.now();
							                if (updatedDate.isEqual(currentDate)) {
							            %>
							            <td class="glow-text"><%= formattedDate!=null?StringEscapeUtils.escapeHtml4(formattedDate): " - " %></td>
							            <% } else { %>
							            <td class="glow-text-red"><%= formattedDate!=null?StringEscapeUtils.escapeHtml4(formattedDate): " - " %></td>
							            <% } %>
							            <td class="text-center">
							                <% if(obj[3] != null) { %>
							                    <a href="PatchesAttachDownload.htm?attachid=<%= obj[4] %>" title="Download">
							                        <i class="fa fa-download fa-2x" aria-hidden="true" class="w-15"></i>
							                    </a>
							                <% } else { %>
							                    --
							                <% } %>
							            </td>
							        </tr>
							        <% } %>
							    </tbody>
							</table>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                        <div align="center">
                        	<%if(AuditPatchesList.size()>0){ %>
                            <button type="button" class="btn btn-warning btn-custom" onclick="triggerEditModal()">Edit</button><%} %>
                            <a class="btn btn-back btn-custom" href="MainDashBoard.htm">Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Structure -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Patch</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editPatchForm" action="AuditPatchEditSubmit.htm" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" id="auditIdEdit" name="auditId" />
                        <div class="form-group">
                            <label for="versionNoEdit">Version No:</label>
                            <input type="text" id="versionNoEdit" name="versionNo" class="form-control" maxlength="10" readonly="readonly">
                        </div>
                        <div class="form-group">
                            <label for="DescriptionEdit">Description:</label>
                            <textarea id="DescriptionEdit" name="Description" class="form-control" rows="4" maxlength="200" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileEdit">Attachment:</label>
                            <input type="file" id="fileEdit" name="file" class="form-control" accept=".sql,.txt" oninput="return validateFileEdit()">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Submit</button>
                        </div>
                        <p class="c-red" >*Please attach .sql or .txt file only</p>
						<p class="c-red" >*Attachment size should be less than 100KB</p>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            // DataTable initialization
            $("#myTable").DataTable({
                "lengthMenu": [5, 10, 25, 50, 75, 100],
                "pagingType": "simple",
                "pageLength": 5
            });
        });

        function toggleDescription(id) {
            var dots = document.getElementById("dots-" + id);
            var moreText = document.getElementById("more-" + id);
            var toggleLink = document.getElementById("toggle-link-" + id);

            if (dots.style.display === "inline") {
                dots.style.display = "none"; // Hide the dots
                moreText.style.display = "inline"; // Show the additional text
                toggleLink.innerHTML = "Show Less"; // Change the button text to "Show Less"
            } else {
                dots.style.display = "inline"; // Show the dots
                moreText.style.display = "none"; // Hide the additional text
                toggleLink.innerHTML = "Show More"; // Change the button text to "Show More"
            }
        }


        function triggerEditModal() {
            var selected = document.querySelector('input[name="ProjectId"]:checked');
            if (selected) {
                // Populate the modal with data
                var row = selected.closest("tr");
                document.getElementById("auditIdEdit").value = selected.value;
                document.getElementById("versionNoEdit").value = row.cells[1].innerText;

                // Get the full description from the hidden span
                var fullDescription = row.querySelector('.full-description').getAttribute('data-description');
                document.getElementById("DescriptionEdit").value = fullDescription;

                $('#editModal').modal('show');
            } else {
                alert("Please select a patch to edit.");
            }
        }


     // File validation for Edit modal
        function validateFileEdit() {
            var fileInput = document.getElementById('fileEdit');
            var filePath = fileInput.value;

            // Check the file extension
            var allowedExtensions = /(\.txt|\.sql)$/i;
            if (!allowedExtensions.exec(filePath)) {
                alert('Please upload a file with .sql or .txt extension.');
                fileInput.value = ''; // Reset file input
                return false;
            }

            // Check the file size (1 KB = 1024 bytes)
            var fileSize = fileInput.files[0].size;
            if (fileSize > 102400) {
                alert('File size must be less than 100 KB.');
                fileInput.value = ''; // Reset file input
                return false;
            }

            return true;
        }
    </script>
    
    






</body>
</html>