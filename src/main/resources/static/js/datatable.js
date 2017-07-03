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
																data : "p_upload",
																"render" : function(
																		data,
																		type,
																		row,
																		meta) {
																	if (type === 'display') {
																		data = '<a href=/bitbox/download?filename='
																				+ data
																				+ '>'
																				+ data
																				+ '</a>';
																	}

																	return data;
																}
															},
															{

																data : "null",
																"targets" : 0,
																"defaultContent" : '<button class="btn_view" data-toggle="modal" data-target="#myModal" >상세보기</button>'
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
													var title = a.p_title;
													var date = a.p_date;
													var upload = a.p_upload;
													var content = a.p_content;
													$('#myModal')
															.on(
																	'shown.bs.modal',
																	function() {
																		$(
																				"#myModal")
																				.modal(
																						'show');
																		$(
																				'.modal-body #p_title')
																				.val(
																						title);
																		$(
																				'.modal-body #p_date')
																				.val(
																						date);
																		$(
																				'.modal-body #p_upload')
																				.val(
																						upload);
																		$(
																				'.modal-body #p_content')
																				.val(
																						content);
																		$(
																				'.modal-body #p_boardseq')
																				.val(
																						boardseq);
																		$(
																				'#myInput')
																				.focus()
																	});

												});

							});
			function test(type) {
				var ds = document.getElementById("dataset");
				var url = "/bitbox/";
				if (type == 1) {
					url = "/modify";
				} else if (type == 2) {
					url = "/bitbox/projectUpdate";
				}
				ds.action = url;
				ds.submit();
			}