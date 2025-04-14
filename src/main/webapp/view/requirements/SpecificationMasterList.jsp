<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.vts.pfms.requirements.model.SpecificationTypes"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>
	
	<spring:url value="/resources/js/excel.js" var="excel" />
	<script src="${excel}"></script>

<!-- Pdfmake  -->
	<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
	<script src="${pdfmake}"></script>
	<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
	<script src="${pdfmakefont}"></script>
	<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
	<script src="${htmltopdf}"></script>
	
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

/* Container for the tabs */


/* Hover effect for tabs */
.tab:hover {
    background-color: #ddd;
}

/* Active tab styling */
.tab.active {
    background-color: #4CAF50;
    color: white;
    border-color: #4CAF50;
}

/* When clicked, show content */
.tab-content {
    display: none;
}

/* Display content of active tab */
.tab-content.active {
    display: block;
    margin-top: 20px;
}
.tab-content {
    display: none; /* Hide all tab contents initially */
    padding: 15px;
   
    margin-top: 10px;

}

/* Show the active content */
.tab-content.active {
    display: block;
}

/* New sytles for tabs */
.tabs-wrapper {
    /* display: flex;
    align-items: center;
    justify-content: center; */
    width: 118%;
    overflow: hidden;
    /* position: relative;
    padding: 10px 0; */
}

.tabs-container {
    overflow: hidden;
    flex-grow: 1;
    white-space: nowrap;
    max-width: 80%; /* Restrict width */
}

.tabs-track {
    display: flex;
    gap: 10px;
    transition: scroll-left 0.3s ease-in-out;
    overflow-x: auto;
    scrollbar-width: none; /* Hide scrollbar for Firefox */
}

.tabs-track::-webkit-scrollbar {
    display: none; /* Hide scrollbar for Chrome, Safari */
}

.tab {
    padding: 10px 15px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 5px;
    cursor: pointer;
    flex: 0 0 auto; /* Prevent shrinking */
    text-align: center;
    min-width: 160px;
    font-weight: 500;
    transition: background 0.3s, color 0.3s;
}

.tab:hover {
    background: #007bff;
    color: white;
}

.tab.active {
    background: #007bff;
    color: white;
    border-color: #0056b3;
}

.tab-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 40px;
    min-height: 40px;
    font-size: 18px;
    border-radius: 50%;
    transition: background 0.3s;
}

.tab-btn:hover {
    background: #0056b3 !important;
}

.p-2.border {
    transition: 0.3s ease-in-out;
}
.p-2.border:hover {
    box-shadow: 0px 0px 10px rgba(0, 128, 0, 0.5);
    background-color: #e8f5e9; /* Light green background */
}
.p-2.border {
    background: white;
    border: 2px solid #28a745;
    box-shadow: 2px 4px 12px rgba(0, 128, 0, 0.2);
    border-radius: 8px;
}

</style>
</head>
<body>

	<%
	List<Object[]> specificarionMasterList = (List<Object[]>) request.getAttribute("specificarionMasterList");
	List<SpecificationTypes> specificationTypesList = (List<SpecificationTypes>) request.getAttribute("specificationTypesList");
	String specTypeId = (String) request.getAttribute("specTypeId");
	specTypeId = specTypeId==null?"0":specTypeId;
	
    Map<String, List<Object[]>> specificationTypeMap = new LinkedHashMap<>();
    specificationTypeMap.put("A", specificarionMasterList);
    
	for(SpecificationTypes specificationType : specificationTypesList) {
		
		List<Object[]> specificationListByType = specificarionMasterList.stream().filter(e -> Long.parseLong(e[19].toString())==(specificationType.getSpecTypeId())).collect(Collectors.toList());
		
		specificationTypeMap.computeIfAbsent(specificationType.getSpecTypeCode(), k -> new ArrayList<>()).addAll(specificationListByType);
	}
	
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
	String jsonspecificarionMasterList = gson.toJson(specificarionMasterList);
	
	%>


	<% String ses=(String)request.getParameter("result");
	 	String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<div align="center">
			<div class="alert alert-danger" role="alert">
		    <%=ses1 %>
		    </div>
		</div>
		<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>

	<div class="container-fluid">
		<div class="col-md-12">

			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-7">
							<h4>
								<b>Specification Master List</b>
							</h4>
						</div>
						<div class="col-md-2">
						    <div class="p-2 border rounded shadow bg-light" style="margin-top: -1rem;"> <!-- Added styles -->
						        <form action="SpecificationMasterExcel.htm" method="post" id="excelForm" enctype="multipart/form-data">
						            <div class="d-flex align-items-center">
						                <span class="mr-2">Download:</span>
						                <button class="btn btn-sm btn-outline-success mx-1" type="button" onclick="downloadPdf()">
						                    <i class="fa fa-download" aria-hidden="true"></i>
						                </button>
						                <button class="btn btn-sm btn-success mx-1" type="submit" name="Action" value="GenerateExcel">
						                    <i class="fa fa-file-excel-o" aria-hidden="true"></i>
						                </button>
						            </div>
						
						            <input type="hidden" name="Type" id="specType" value="A">
						            <input type="hidden" class="specTypeId" name="specTypeId" value="<%=specTypeId%>">
						            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						        </form>
						    </div>
						</div>
						<div class="col-md-3"></div>
					</div>
				</div>
				
				<div class="card-body">
				    <div class="tabs-wrapper d-flex align-items-center">
				        <button class="tab-btn prev btn btn-primary mr-2" onclick="scrollTabs(-1)">
				            <i class="fa fa-chevron-left"></i>
				        </button> 
				        <div class="tabs-container">
				            <div class="tabs-track d-flex">
				                <div class="tab <%if(Long.parseLong(specTypeId)==0) {%> active <%} %>" data-target="A" data-spectypeid="0">Total List</div>
				                <%
				                	if(specificationTypesList!=null && specificationTypesList.size()>0) {
										for(SpecificationTypes specificationType : specificationTypesList) {
				                %>
				                	<div class="tab <%if(Long.parseLong(specTypeId)==specificationType.getSpecTypeId()) {%> active <%} %> " data-target="<%=specificationType.getSpecTypeCode()!=null?specificationType.getSpecTypeCode():"-" %>" 
				                	 data-spectypeid="<%=specificationType.getSpecTypeId()%>">
				                		<%=specificationType.getSpecType()!=null?specificationType.getSpecType():"-" %>
				                	</div>
				                <%} }%>
				            </div>
				        </div>
				        <button class="tab-btn next btn btn-primary ml-2" onclick="scrollTabs(1)">
				            <i class="fa fa-chevron-right"></i>
				        </button> 
				    </div>
				</div>

				<form action="SpecificationMasterAdd.htm" method="post" name="frm1">	
				
					<%for(Map.Entry<String, List<Object[]>> entry : specificationTypeMap.entrySet()) { 
						String specType = entry.getKey();
						List<Object[]> specTypeList = entry.getValue();
						
					%>
						
						<div class="card-body tab-content" id="<%=specType%>">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed mytable"
									id="myTable1">
									<thead style="text-align: center;">
									<tr>
									<th style="width:5%;">Select</th>
									<!--<th>Specification Name</th> -->
									<th style="width:20%;">Specification Code</th>
									<!-- <th style="width:10%;">Specification Type</th> -->
									<th style="width:20%;">Parameter</th>
									<th style="width:10%;">Minimum Value</th>
									<th style="width:10%;"> Typical Value</th>
									<th style="width:10%;">Maximum Value</th>
									<th style="width:10%;"> Unit</th>
									</tr>
									</thead>
									<tbody>
										<%
										
										for (Object[] obj : specTypeList) {
										%>
											<tr<%if(obj[14].toString().equalsIgnoreCase("0")){ %> style="background: #9ae59a;"	 <%} %>>
									   			<td align="center">
									   				<input type="radio" name="Did" value=<%=obj[0]%> <%if(!obj[14].toString().equalsIgnoreCase("0")){ %>class="subDid" <%} else {%>class="Did"<%} %> > 
									   			</td>
												<%-- <td><%=obj[1]%></td> --%>
												<td><%=obj[5]%></td>
											
												<td><%=obj[3]%></td>
												<td><%=obj[16]!=null?obj[16]:"-"%></td>
												<td><%=obj[6]!=null?obj[6]:"-"%></td>
												<td><%=obj[15]!=null ? obj[15]:"-"%></td>
												 <td><%=obj[4]!=null?obj[4]:"-" %></td> 
											</tr>
										<% } %>
									</tbody>
								</table>
							</div>
						</div>
					<%} %>
					
				
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="levelType" id="levelType">
					<input type="hidden" class="specTypeId" name="specTypeId" value="<%=specTypeId%>">
					<div align="center">

						<div class="button-group mb-2">
							<button type="submit" class="btn btn-sm add" name="sub" value="add">ADD</button>
							<button type="submit" class="btn btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)">EDIT</button>
							<button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete" formaction="SpecificationMasterDelete.htm" formmethod="get" onclick="return deleteSpecification()">DELETE</button>
						</div>
					</div>
				</form>

			</div>
		</div>

	</div>



	<div class="modal" id="loader">
		<!-- Place at bottom of page -->
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".mytable").DataTable({
				'aoColumnDefs' : [ {
					'bSortable' : false,

					'aTargets' : [ -1 ]
				/* 1st one, start by the right */
				} ]
			});
		});
		
		function Edit(myfrm){
			 var fields = $("input[name='Did']").serializeArray();

			  if (fields.length === 0){
			alert("Please select a record");
			 event.preventDefault();
			return false;
			}
				  return true;	
		}
		
/* 		document.querySelectorAll('.tab').forEach(function(tab) {
		    tab.addEventListener('click', function() {
		        // Remove 'active' class from all tabs
		        document.querySelectorAll('.tab').forEach(function(tab) {
		            tab.classList.remove('active');
		        });

		        // Add 'active' class to clicked tab
		        tab.classList.add('active');

		        // Optionally, display corresponding content for each tab here
		        // Example:
		        // let index = Array.from(tab.parentElement.children).indexOf(tab);
		        // showContentForTab(index);
		    });
		}); */
		
		
		$('.tab').on('click', function () {
		    // Remove 'active' class from all tabs
		    $('.tab').removeClass('active');
		    // Add 'active' class to the clicked tab
		    $(this).addClass('active');

		    // Hide all tab contents
		    $('.tab-content').removeClass('active');
		    // Show the content corresponding to the clicked tab
		    const targetId = $(this).data('target');
		    const spectypeid = $(this).data('spectypeid');
			
		    $('#specType').val(targetId);
		    $('.specTypeId').val(spectypeid=='A'?'0':spectypeid);
		    $('#' + targetId).addClass('active');
		});
		
		
		// Disable and Enable Edit button based on main and sub-level
		$('.subDid').on('click', function() {
			$('.edit').prop('disabled', true);
		});
		$('.Did').on('click', function() {
			$('.edit').prop('disabled', false);
		});
		
		
		function deleteSpecification() {

			var fields = $("input[name='Did']").serializeArray();

			var checkedInput = $("input[name='Did']:checked");
			var className = checkedInput.attr("class");

			console.log("Class Name:", className);

			if (fields.length === 0){
				alert("Please select a record");
				event.preventDefault();
				return false;
			}else {
				if(className=="Did") {
					$('#levelType').val('M');
					return confirm('Are you sure you want to Delete?\nDeleting a main level will also remove all its sub-levels.');
				}else {
					$('#levelType').val('S');
					return confirm("Are you sure to Delete?");
				}
			}
		}
		
		
		function scrollTabs(direction) {
		    const container = document.querySelector(".tabs-container");
		    const track = document.querySelector(".tabs-track");

		    const scrollAmount = container.clientWidth * 0.8;
		    track.scrollLeft += direction * scrollAmount;
		}

		$(document).ready(function() {
		    var activetab = $('.tab.active');
		    var datatarget = activetab.data('target');
		    
		    $('#' + datatarget).addClass('active');
		});

		
		// Download pdf function
		var specificarionMasterList = JSON.parse('<%= jsonspecificarionMasterList %>');
		function downloadPdf() {
			var specTypeId = $('.specTypeId').val();
			console.log('specificarionMasterList: ',specificarionMasterList);
			console.log('******************************');
			console.log('specTypeId: ',specTypeId);
			
			// Filter specificarionMasterList based on specTypeId
		    var filteredList = specificarionMasterList;
			if(specTypeId!="0") {
				 filteredList = specificarionMasterList.filter(item => item[19] == specTypeId);
			}
		    console.log('Filtered List:', filteredList);
		    
		 // Prepare table body
            var tableBody = [
                [
                    { text: 'SN', style: 'tableHeader' },
                    { text: 'Specification Code', style: 'tableHeader' },
                    { text: 'Parameter', style: 'tableHeader' },
                    { text: 'Min Value', style: 'tableHeader' },
                    { text: 'Typical Value', style: 'tableHeader' },
                    { text: 'Max Value', style: 'tableHeader' },
                    { text: 'Unit', style: 'tableHeader' },
                ]
            ];

            if (filteredList.length > 0) {
                filteredList.forEach((obj, index) => {
                    tableBody.push([
                        { text: (index + 1).toString(), style: 'tableData', alignment: 'center', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                        { text: obj[5] ? obj[5] : '-', style: 'tableData', alignment: 'left', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                        { text: obj[3] ? obj[3] : '-', style: 'tableData', alignment: 'left', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                        { text: obj[16] ? obj[16] : '-', style: 'tableData', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                        { text: obj[6] ? obj[6] : '-', style: 'tableData', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                        { text: obj[15] ? obj[15] : '-', style: 'tableData', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                        { text: obj[4] ? obj[4] : '-', style: 'tableData', fillColor: obj[14] == "0" ? '#9ae59a' : null },
                    ]);
                });
            } else {
                tableBody.push([{ text: 'No Data Available', style: 'tableData', alignment: 'center', colSpan: 7 }]);
            }
            
		    var docDefinition = {
					pageOrientation: 'landscape',
		            content: [
		                
		                /* ************************************** Specification Master List *********************************** */ 
		                {
		                    text: 'Specification Master List',
		                    style: 'chapterHeader',
		                    tocItem: false,
		                    id: 'chapter1',
		                    alignment: 'center',
		                },
		                
		                {
		                    table: {
		                        headerRows: 1,
		                        widths: ['7%', '18%', '15%', '15%', '15%', '15%', '15%'],
		                        body: tableBody,
		                    },
		                    layout: {
		                        /* fillColor: function(rowIndex) {
		                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
		                        }, */
		                        hLineWidth: function(i, node) {
		                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
		                        },
		                        vLineWidth: function(i) {
		                            return 0.5;
		                        },
		                        hLineColor: function(i) {
		                            return '#aaaaaa';
		                        },
		                        vLineColor: function(i) {
		                            return '#aaaaaa';
		                        }
		                    }
		                },
		                /* ************************************** Specification Master List End*********************************** */

		                
					],
					styles: {
						chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
		                tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
		                tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
		            },
		            footer: function(currentPage, pageCount) {
		                /* if (currentPage > 2) { */
		                    return {
		                        stack: [
		                        	{
		                                canvas: [{ type: 'line', x1: 30, y1: 0, x2: 820, y2: 0, lineWidth: 1 }]
		                            },
		                            {
		                                columns: [
		                                    { text: '', alignment: 'left', margin: [30, 0, 0, 0], fontSize: 8 },
		                                    { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
		                                ]
		                            },
		                            { text: '', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
		                        ]
		                    };
		                /* }
		                return ''; */
		            },
		            /* header: function (currentPage) {
		                return {
		                    stack: [
		                        
		                        {
		                            columns: [
		                                {
		                                    // Center: Text
		                                    text: 'Restricted',
		                                    alignment: 'center',
		                                    fontSize: 10,
		                                    bold: true,
		                                    margin: [0, 10, 0, 0]
		                                },
		                            ]
		                        },
		                        
		                    ]
		                };
		            }, */
					pageMargins: [30, 40, 20, 20],
		            
		            defaultStyle: { fontSize: 12, color: 'black', }
		        };
				
		        pdfMake.createPdf(docDefinition).open();
		}
	</script>
</body>
</html>