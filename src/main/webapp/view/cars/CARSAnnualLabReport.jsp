<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.cars.model.CARSAnnualReport"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <jsp:include page="../static/header.jsp"></jsp:include>
    
    <!-- Pdfmake  -->
	<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
	<script src="${pdfmake}"></script>
	<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
	<script src="${pdfmakefont}"></script>
	<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
	<script src="${htmltopdf}"></script>
	
<spring:url value="/resources/css/cars/CARSAnnualLabReport.css" var="carsAnnualLabReport" />
<link href="${carsAnnualLabReport}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon2" />
<link href="${carscommon2}" rel="stylesheet" />
	
</head>
<body>
<%
	String annualYear = (String) request.getAttribute("annualYear");
    List<Object[]> initiationList = (List<Object[]>) request.getAttribute("initiationList");
    List<CARSAnnualReport> annualReportList = (List<CARSAnnualReport>) request.getAttribute("annualReportList");
    List<Long> carsInitiationIds =  annualReportList.stream().map(e -> e.getCARSInitiationId()).collect(Collectors.toList());
    
    Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
    String jsoninitiationList = gson.toJson(initiationList);
    
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

	<div class="container-fluid">        
	    <div class="col-md-12">
	        <div class="card shadow-nohover">
	            <div class="card-header">
	            	<form action="#">
	            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                <div class="row dis-flex" >
		                    <div class="col-md-8">
		                        <h5 class="mb-0"><b>CARS Annual Report </b></h5> 
		                    </div>  
		                    <div class="col-md-1 right">
	 	                       <label class="form-label fw-bold input-font">Year:</label>
		                    </div>   
		                    <div class="col-md-1">
	 	                       <input class="form-control mt-minus-5" type="text" id="annualYear" value="<%=annualYear %>" name="annualYear" onchange="this.form.submit()" readonly>
		                    </div>  
		                    <div class="col-md-2 right">
		                    	<button type="button" class="btn btn-sm submit mt-minus-5" onclick="saveAndGenerateAnnualReportPdf()" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Generate Report">
		                    		Generate Report <i class="fa fa-download col-fff"></i>
		                    	</button>
		                    </div> 
		                </div>
		        	</form>        
	            </div>
	            <div class="card-body">
	                <div class="col-md-12">
	                    <div class="table-responsive table-wrapper"> 
	                    	<input type="text" id="searchBar" class="search-bar form-control w-auto" placeholder="Search..."  />
        					<br>
	                        <table class="customtable" id="dataTable">
	                            <thead class="center">
	                                <tr>
	                                    <th class="w-3" >SN</th>
	                                    <th class="w-5" >Select &nbsp;<input type="checkbox" class="selectAll" id="selectAll" ></th>
	                                    <th class="w-25" >Title</th>
	                                    <th class="w-25" >Institution / College</th>
	                                    <th class="w-15" >PI</th>
	                                    <th class="w-17" >Status</th>
	                                </tr>
	                            </thead>
	                            <tbody>    
	                                <% if (initiationList != null && initiationList.size() > 0) {
	                                    int slno = 0;
	                                    for (Object[] obj : initiationList) {
	                                %>
	                                <tr>
	                                    <td class="center" ><%= ++slno %></td>
										<td class="center">
											<input type="checkbox" class="carsInitiationId" id="carsInitiationId" name="carsInitiationId" value="<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"" %>"
											<% if(carsInitiationIds.size()>0){
												if(carsInitiationIds.contains(Long.parseLong(obj[0].toString()))) {%>checked <%} %> 
											<%} else{%>
												checked
											<%} %>  > 
										</td>
	                                    <td ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-" %></td>
	                                    <td >
	                                    	<%=(obj[21]!=null?StringEscapeUtils.escapeHtml4(obj[21].toString()):"-")%>, <%=(obj[23]!=null?StringEscapeUtils.escapeHtml4(obj[23].toString()):"-") %>	<br>
			    				  			<%=(obj[22]!=null?StringEscapeUtils.escapeHtml4(obj[22].toString()):"-")%>, <%=(obj[23]!=null?StringEscapeUtils.escapeHtml4(obj[23].toString()):"-")%>, <%=(obj[24]!=null?StringEscapeUtils.escapeHtml4(obj[24].toString()):"-")%> - <%=(obj[25]!=null?StringEscapeUtils.escapeHtml4(obj[25].toString()):"-") %> <br>
			    							Phone : <%=(obj[30]!=null?StringEscapeUtils.escapeHtml4(obj[30].toString()):"-") %> <br>
			    				 			Fax :&nbsp;<%=(obj[32]!=null?StringEscapeUtils.escapeHtml4(obj[32].toString()):"-") %> <br>
			    							Email :&nbsp;<%=(obj[31]!=null?StringEscapeUtils.escapeHtml4(obj[31].toString()):"-") %><br>
			    						</td>
	                                    <td > 
	                                    	<%=(obj[26]!=null?StringEscapeUtils.escapeHtml4(obj[26].toString()):"-")%> . <%=(obj[27]!=null?StringEscapeUtils.escapeHtml4(obj[27].toString()):"-")%>, <%=(obj[28]!=null?StringEscapeUtils.escapeHtml4(obj[28].toString()):"-") %>
	                                    </td>
	                                   	<td>
	                                   		<form action="#">
	                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                        	<input type="hidden" name="carsInitiationId" value="<%=obj[0] %>">
	                                       	  	<button type="submit" class="btn btn-sm btn-link-1 w-100 btn-status fw-600 color-<%=obj[11].toString().replace("#", "") %>" formaction=CARSTransStatus.htm value="<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    				<%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true"></i>
								    			</button>
                                      		</form>
	                                   	</td>
	                                </tr>
	                                
	                                <% } }%>
	                            </tbody>
	                        </table>
	                    </div>
	                    
	                </div>
	               
	            </div>
	        </div>
	    </div>
	</div>

<script>
    $(document).ready(function() {
    	/* ***************************** Annual Year Initializer **************************** */
    	$('#annualYear').datepicker({
    		 format: "yyyy",
    		    viewMode: "years", 
    		    minViewMode: "years",
    		    autoclose: true,
    		    todayHighlight: true,
    		    endDate: new Date() 
    	});

    	/* ***************************** Custom Search Bar **************************** */
    	$('#searchBar').on('keyup', function () {
            const searchTerm = $(this).val().toLowerCase();
            $('#dataTable tbody tr').filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
            });
        });
    	
        /* $('#myTable').DataTable({
            "lengthMenu": [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 100],
            "pagingType": "simple",
            "pageLength": 5
        }); */
        
    });
    
    /* ***************************** Selection of Contents **************************** */
	$('#selectAll').prop('checked', true);

	// Function to handle select-all logic
	function selectAllShortCodes() {
	    var isChecked = $('#selectAll').prop('checked');
	    $('.carsInitiationId').prop('checked', isChecked);
	}

	// Function to handle individual shortcode click logic
	function updateSelectAllStatus() {
	    var checkedCount = $('.carsInitiationId:checked').length;
	    var totalCount = $('.carsInitiationId').length;
	    $('#selectAll').prop('checked', checkedCount === totalCount);
	}


    $('#selectAll').change(function() {
        selectAllShortCodes();
    });

    $('.carsInitiationId').click(function() {
        updateSelectAllStatus();
    });
	    
    
    /* ***************************** Generate PDF **************************** */
    
    function saveAndGenerateAnnualReportPdf() {
    	
    	var checkedCount = $('.carsInitiationId:checked').length;
    	var annualYear = '<%=annualYear%>';
    	
    	var carsInitiationIdArray = [];
    	$("input[name='carsInitiationId']:checked").each(function() {
    		carsInitiationIdArray.push($(this).val());
		});
    	
    	var carsInitiationIdList = carsInitiationIdArray.toString();

    	if(checkedCount>0) {
    		
    		// Submit the Selected CARS for Annual Year
    		$.ajax({
    			type : "GET",
    			url : "CARSAnnualReportSubmit.htm",	
    			datatype : 'json',
    			data : {
    				annualYear : annualYear,				
    				carsInitiationIdList : carsInitiationIdList,				
    			},
    			success : function(result) {
    				var initiationList = JSON.parse(result);
    				
    				var filteredInitiationList = initiationList.filter(function(item) {
    				    return carsInitiationIdArray.includes(item[0].toString());
    				});
    				
    				GenerateAnnualReportPdf(filteredInitiationList);
    			}
    		});
    		
    	}else {
    		alert('Please Select Atleast One CARS');
    		return false;
    	}
    }
    
    function GenerateAnnualReportPdf(initiationList) {
    	
		var docDefinition = {
				pageOrientation: 'landscape',
	            content: [
	                
	            	/* ************************************** CARS Annual Report *********************************** */
	                {
	                    text: 'CARS Annual Report - <%=annualYear%>',
	                    style: 'chapterHeader',
	                    tocItem: false,
	                    id: 'chapter1',
	                    alignment: 'center',
	                },

	                { text: '\n' },

	                {
	                    table: {
	                        headerRows: 1,
	                        widths: ['6%', '25%', '30%', '18%', '21%'],
	                        body: (() => {
	                            let body = [
	                                // Table header
	                                [
	                                    { text: 'SN', style: 'tableHeader' },
	                                    { text: 'Title', style: 'tableHeader' },
	                                    { text: 'Institution / College', style: 'tableHeader' },
	                                    { text: 'PI', style: 'tableHeader' },
	                                    { text: 'Status', style: 'tableHeader' },
	                                ],
	                            ];

	                            // Dynamically add rows for the filteredInitiationList
	                            for (var i = 0; i < initiationList.length; i++) {
	                                body.push([
	                                    { text: i + 1, style: 'tableData', alignment: 'center' }, // SN starts from 1
	                                    { text: initiationList[i][4] || '-', style: 'tableData', alignment: 'left' },
	                                    { text: (initiationList[i][21] || '-') + ", " + (initiationList[i][23] || '-') + "\n" +
	                                    		(initiationList[i][22] || '-') + ", " + (initiationList[i][23] || '-') + ", " + (initiationList[i][24] || '-') + " - " + (initiationList[i][25] || '-') + "\n" +
	                                    		'Phone : '+ (initiationList[i][30] || '-') + "\n" +
	                                    		'Fax : '+ (initiationList[i][32] || '-') + "\n" +
	                                    		'Email : '+ (initiationList[i][31] || '-') 
	                                    	, style: 'tableData' },
	                                    { text: (initiationList[i][26] || '-') + ". " + (initiationList[i][27] || '-') + ", " + (initiationList[i][28] || '-') , style: 'tableData' },
	                                    { text: initiationList[i][10] || '-', style: 'tableData', alignment: 'left' },
	                                  ]);
	                            }

	                            return body;
	                        })(),
	                    },
	                    layout: {
	                        hLineWidth: function (i, node) {
	                            return i === 0 || i === node.table.body.length ? 1 : 0.5;
	                        },
	                        vLineWidth: function (i) {
	                            return 0.5;
	                        },
	                        hLineColor: function (i) {
	                            return '#aaaaaa';
	                        },
	                        vLineColor: function (i) {
	                            return '#aaaaaa';
	                        },
	                    },
	                },
	                /* ************************************** CARS Annual Report End*********************************** */

	                
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


