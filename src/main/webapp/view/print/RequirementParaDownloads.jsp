<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<title>Project Para</title>
<script src="./webjars/jquery/3.4.0/jquery.min.js"></script>
<script src="./webjars/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="./webjars/bootstrap/4.0.0/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="./webjars/font-awesome/4.7.0/css/font-awesome.min.css" />
	
<spring:url value="/resources/js/FileSaver.min.js" var="FileSaver" />
<script src="${FileSaver}"></script>
<spring:url value="/resources/js/jquery.wordexport.js" var="wordexport" />
<script src="${wordexport}"></script>
<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
<script src="${pdfmake}"></script>
<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
<script src="${pdfmakefont}"></script>
<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
<script src="${htmltopdf}"></script>
</head>
<body>
<%
String lablogo = (String)request.getAttribute("lablogo");
String reqInitiationId = (String)request.getAttribute("reqInitiationId");
Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
Object[] sqrFile = (Object[])request.getAttribute("SQRFile");
Object[] LabList = (Object[])request.getAttribute("LabList");
List<Object[]> ParaDetails = (List<Object[]>)request.getAttribute("ParaDetails");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
int port=new URL( request.getRequestURL().toString()).getPort();
String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";
%>


<%=path %>


	  <button onclick="generatePDF()">Download PDF</button>
	  <script>
	  var arr=[];
		  $.ajax({
			   type:'GET',
				url:'RequirementParaDetails.htm',
				datatype:'json',
				data:{
					reqInitiationId:<%=reqInitiationId%>,
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					arr=ajaxresult;
				
				}
		   })
		 
	      function generatePDF() {
			  
		
			  var slno =0;
			  
			  var contentArray = [
			        {
			            text: `QR 
			            
			            		FOR 
			            		
			            	PROJECT ${projectDetails != null && projectDetails[2] != null ? projectDetails[2] : "-"}`,
			            style: 'DocumentName',
			            alignment: 'center',
			            fontSize: 18,
			            margin: [0, 200, 0, 20]
			        },
			        {
			            text: '',
			            style: 'DocumentSubName',
			            alignment: 'center',
			        },
			        // Other static content can go here
			    ];

				 var table= {
				            table: {
				                widths: ['10%', '45%', '45%'], // Define column widths
				                body: [
				                    [
				                        { text: ++slno + ".", alignment: 'center', margin: [5, 5, 5,5] }, 
				                        { text: 'Ref to General Staff Policy Statement No.', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text: '<%=sqrFile!=null && sqrFile[1]!=null?sqrFile[1]:"-" %>', margin: [5, 5, 5,5] }
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center', margin: [5, 5, 5,5] }, 
				                        { text: 'SQR No.', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text: '<%=sqrFile!=null && sqrFile[6]!=null?sqrFile[6]:"-" %>', margin: [5, 5, 5,5] }
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center', margin: [5, 5, 5,5] }, 
				                        { text: 'Other Previous SQR No.', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text: '<%=sqrFile!=null && sqrFile[8]!=null?sqrFile[8]:"-" %>' , margin: [5, 5, 5,5]}
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center', margin: [5, 5, 5,5] }, 
				                        { text: 'Ref of Meeting', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text: '<%=sqrFile!=null && sqrFile[9]!=null?sqrFile[9]:"-" %>', margin: [5, 5, 5,5], alignment: 'top' }
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center' , margin: [5, 5, 5,5]}, 
				                        { text: 'Line Directorate File No.', margin: [5, 5, 5,5],bold:true },
				                       
				                        htmlToPdfmake('<a href="<%=path%>SQRDownload.htm?reqInitiationId=<%=sqrFile[2]%>" target="blank">Download</a>')
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center' , margin: [5, 5, 5,5]}, 
				                        { text: 'Nomenclature', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text:'<%=projectDetails!=null && projectDetails[3]!=null?projectDetails[3]:"-" %> (<%=projectDetails!=null && projectDetails[2]!=null?projectDetails[2]:"-" %>)', margin: [5, 5, 5,5]}
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center', margin: [5, 5, 5,5] }, 
				                        { text: 'Security Classification', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text: '<%=projectDetails!=null && projectDetails[12]!=null?projectDetails[12]:"-"%>', margin: [5, 5, 5,5] }
				                    ],
				                    [
				                        { text: ++slno + ".", alignment: 'center', margin: [5, 5, 5,5] }, 
				                        { text: 'Priority for Development', margin: [5, 5, 5,5],bold:true },
				                       
				                        { text: '<%=sqrFile!=null && sqrFile[10]!=null?(sqrFile[10].toString().equalsIgnoreCase("E")?"Early":(sqrFile[10].toString().equalsIgnoreCase("I")?"Immediate":"Late")):"-" %>', margin: [5, 5, 5,5] }
				                    ]
				                ]
				            }
				        }
			
			  
			  
			    // Conditionally add the logo
			    <% if (lablogo != null) { %>
			        contentArray.push({
			            image: 'data:image/png;base64,<%= lablogo %>',
			            width: 95,
			            height: 95,
			            alignment: 'center',
			            margin: [0, 20, 0, 20]
			        });
			    <% } %>

			    // Conditionally add the lab details
			    contentArray.push({
			        text: <% if (LabList != null && LabList[1] != null) { %> '<%= LabList[1].toString() + "(" + LabList[0].toString() + ")" %>' <% } else { %> '-' <% } %>,
			        alignment: 'center',
			        fontSize: 16,
			        bold: true,
			        margin: [0, 20, 0, 20]
			    });
			    
			    contentArray.push( {
                    text: 'Government of India, Ministry of Defence \n\n' + 'Defence Research & Development Organization',
                    alignment: 'center',
                    bold: true,
                    fontSize: 16,
                  });
			    
			    contentArray.push({
               	 text:	<%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					'<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>'
					<%}else{ %>
					'-'
					<%} %>,
					alignment: 'center',
                   bold: true,
                   fontSize: 16,
                 });

			    // Add the table of contents
			    contentArray.push({
			        toc: {
			            title: { text: 'INDEX', style: 'header', pageBreak: 'before' }
			        }
			    });

			    contentArray.push({
	           	     text:'DRAFT GENERAL STAFF QUALITATIVE REQUIREMENT FOR PROJECT DEVELOPEMNT SYSTEMS (<%=projectDetails != null && projectDetails[2] != null ? projectDetails[2] : "-" %>)',
           		 	fontSize: 16,
           		 	pageBreak: 'before',
           			 alignment: 'center',
           		   tocItem: true,
           			id: 'chapter0',
           		 	margin: [0, 0, 0, 10]
           			});
				 contentArray.push(table);
			    
			    // Loop through the `arr` and add dynamic content
			    if (arr.length > 0) {
			        for (var i = 0; i < arr.length; i++) {
			        	var chapter = {
			        		    text: ''+arr[i][3]+'',
			        		    style: 'chapterHeader',
			        		    tocItem: true,
			        		    id: 'chapter' + (i+1),
			        		    fontSize: 12
			        		};
			        

			        		// Conditionally add the pageBreak property if it's the first item
			        	if(i==0)
			        		chapter.pageBreak= 'before'
			        	
			        		// Push the chapter object into the contentArray
			        		contentArray.push(chapter);
			        		
			        		if(arr[i][4]!==null){
			        			var chapter1= htmlToPdfmake(arr[i][4])
			        		
			        			 contentArray.push(chapter1);
			        		}else{
			        			
			        			contentArray.push(htmlToPdfmake("<p style='text-align:center;'>No Details Found</p>"));
			        		}
			        }
			    }
	    	  
			
        var docDefinition = {
            content:
            	
            	contentArray ,
            	 watermark: {
            	        text: 'DRAFT',  // Your watermark text here
            	        color: 'gray',         // Watermark color
            	        opacity: 0.3,          // Watermark transparency (0 to 1)
            	        bold: true,            // Whether to make the text bold
            	        italics: false,        // Whether to make the text italic
            	        fontSize: 80,          // Size of the watermark text
            	        angle: -45              // Angle of the watermark text
            	    },
            	    
            	    
            	    info: {
            	        title: 'QR_PARA_<%=projectDetails!=null && projectDetails[2]!=null?projectDetails[2]:"" %>',  // Set document name here
            	      
            	    },
            // Styles for headers and text
            styles: {
                header: { fontSize: 19, bold: true, margin: [0, 0, 0, 10] },
                chapterHeader: { fontSize: 16, bold: true, margin: [0, 10, 0, 10] }
            },

            // Footer for page numbers
footer: function(currentPage, pageCount) {
    if (currentPage > 2) {
        return {
            stack: [
                // First line at the top of the footer
                {
                    canvas: [
                        {
                            type: 'line',
                            x1: 30, y1: 0,   // Start of the line (left side)
                            x2: 565, y2: 0,  // End of the line (right side)
                            lineWidth: 1
                        }
                    ]
                },
                // Footer content with document number and page number
                {
                    columns: [
                        {
                            text: 'Document Number',
                            alignment: 'left',
                            margin: [30, 0, 0, 0],
                            fontSize: 8
                        },
                        {
                            text: (currentPage).toString() + ' of ' + pageCount,
                            alignment: 'right',
                            margin: [0, 0, 30, 0],
                            fontSize: 8
                        }
                    ]
                },
                // Sentence on the next line
                {
                    text: '<%=projectDetails!=null && projectDetails[12]!=null?projectDetails[12]:"Restricted"%>',
                    alignment: 'center',
                    fontSize: 8,
                    margin: [0, 5, 0, 0]  // Add some margin above to create space
                }
            ]
        };
    } else {
        return ''; // No footer for the first two pages
    }
}
,
header: function(currentPage, pageCount) {
    return {
        stack: [
            {
                columns: [
                    {
                        text: '<%=projectDetails!=null && projectDetails[12]!=null?projectDetails[12]:"Restricted"%>',
                        alignment: 'center',
                        margin: [0, 10, 0, 0], // Adjust margins as needed
                        fontSize: 8,
                        bold: true
                    },
                  
                ]
            }
      
        ]
    };
},
            // Default style for the text
            defaultStyle: {
                fontSize: 12
            }
            

        };

     <%--    pdfMake.createPdf(docDefinition).download('QR_PARA_<%=projectDetails!=null && projectDetails[2]!=null?projectDetails[2]:"" %>.pdf'); --%>
        pdfMake.createPdf(docDefinition).open();
    }
        </script>
</body>
</html>