<%@page import="com.ibm.icu.text.DecimalFormat"%>
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

<title>Audit Patches</title>

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



.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa {
	font-size: 1.20rem;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
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
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
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
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
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

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}
.glow-text {
            color: green;
            text-shadow: 0 0 10px green, 0 0 25px green, 0 0 25px green;
            text-align: center;
        }
.glow-text-red {
            color: red;
            text-shadow: 0 0 10px red, 0 0 25px red, 0 0 25px red;
            text-align: center;
        }

        /* Customizing the modal animation */
        .modal-dialog {
            transform: translateY(-50px); /* Start with modal above view */
            transition: transform 0.3s ease-out; /* Smooth transition */
        }

        .modal.show .modal-dialog {
            transform: translateY(0); /* Bring modal to center */
        }
        .btn-custom {
            padding: 4px 16px; /* Same padding */
            height :30px;
            font-size: 14px; 
              /* Same font size */
        }
        .btn-back {
            background-color: #17a2b8;
            border-color: #17a2b8;
            color: white;
        }
        .btn-back:hover {
            background-color: #138496;
            border-color: #117a8b;
        }
        .form-info p {
            margin: 5px 0; /* Adjust this value as needed */
            color: red;
            font-size: 14px;
        }
        
    </style>
</head>
<body>
    <% 
        // Fetching list of Audit Patches
        List<Object[]> AuditPatchesList = (List<Object[]>) request.getAttribute("AuditPatchesList");
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
                        <form action="AuditPatchEdit.htm" method="post" style="display: inline">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
							    <thead style="text-align: center;">
							        <tr>
							            <th>Select</th>
							            <th>Version No</th>
							            <th style="width: 610px">Description</th>
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
							            <td style="text-align: center; vertical-align: middle;">
							                <input type="radio" name="ProjectId" value="<%= obj[4].toString() %>" style="display: block; margin: auto;">
							            </td>
							            <td style="text-align: center;"><%= obj[0] %></td>
							            <td>
										    <span id="short-description-<%= count %>"><%= shortDescription %></span>
										    <% if (longDescription) { %>
										        <span id="dots-<%= count %>" style="display:inline;">...</span>
										        <span id="more-<%= count %>" style="display:none; margin: 0; padding: 0;"><%= description.substring(90) %></span>
										        <span class="btn btn-link" id="toggle-link-<%= count %>" style="margin: 0; padding: 0;" onclick="toggleDescription('<%= count %>')">Show More</span>
										    <% } %>
										    <span style="display: none;" class="full-description" data-description="<%= description %>"></span> <!-- Added this line -->
										</td>
							            <% if(obj[5] != null) {
							                java.util.Date date = (java.util.Date) obj[5];
							                SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
							                String formattedDate1 = formatter.format(date);
							            %>
							            <td style="text-align: center;"><%= formattedDate1 %></td>
							            <% } else { %>
							            <td style="text-align: center;">-</td>
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
							            <td class="glow-text"><%= formattedDate %></td>
							            <% } else { %>
							            <td class="glow-text-red"><%= formattedDate %></td>
							            <% } %>
							            <td style="text-align: center;">
							                <% if(obj[3] != null) { %>
							                    <a href="PatchesAttachDownload.htm?attachid=<%= obj[4] %>" title="Download">
							                        <i class="fa fa-download fa-2x" aria-hidden="true" style="width: 15px;"></i>
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
                        <p style="margin-bottom: 5px; color: red">*Please attach .sql or .txt file only</p>
						<p style="margin-bottom: 5px; color: red">*Attachment size should be less than 100KB</p>

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