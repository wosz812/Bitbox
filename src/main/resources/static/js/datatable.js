$(document)
					.ready(
							function() {
								var table = $('#test')
										.DataTable(
												{
													"paging" : true,
													"lengthChange" : true,
													"searching" : true,
													"ordering" : true,
													"info" : true,
													"autoWidth" : true,			
													
													"ajax" : {
														url : "/bitbox/getData",
														contentType : "application/x-www-form-urlencoded; charset=UTF-8"
													},
													"columns" : [
															{
																data : "p_boardseq"
															},
															{
																data : "p_category"
															},
															{
																data : "p_title"
															},
															{
																data : "p_date"
															},
															{
																data : "p_filename",
																"render" : function(
																		data,
																		type,
																		row,
																		meta) {
																	if(data!=null){
																	if (type === 'display') {
																		data = '<a href=/bitbox/download?p_boardseq='
																				+ row.p_boardseq
																				+ '>'
																				+ data
																				+ '</a>';
																	}
																	}
																	return data;
																}
															},
															
															{

																data : "null",
																"targets" : 0,
																"defaultContent" : '<button  class="btn_view" type="submit" >상세보기</button>'
															} ]

												});
								$('#test tbody')
										.on(
												'click',
												'.btn_view',
												function() {

													var a = table.row(
															$(this).parents(
																	'tr'))
															.data();
													var boardseq = a.p_boardseq;
													var category=a.p_category;
													var title = a.p_title;
													var date = a.p_date;
													var filename = a.p_filename;
											
													var content = a.p_content;
													location.href="/bitbox/detailProject?p_boardseq="+boardseq+"&p_title="+title+"&p_date="+date+"&p_filename="+filename+
													"&p_content="+content+"&p_category="+category;
												});

							});
			function gourl(type) {
				var ds = document.getElementById("dataset");
				var url = "/bitbox/";
				if (type == 1) {
					url = "/bitbox/projectDelete";
				} else if (type == 2) {
					url = "/bitbox/projectUpdate";
				}
				ds.action = url;
				ds.submit();
			}			