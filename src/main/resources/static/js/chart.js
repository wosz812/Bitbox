$.ajax({
	url : '/bitbox/getSubject',
	type : 'GET',
	dataType : "json",
	success : function(datas) {

		$(function() {
			var donut3 = new Morris.Donut({
				element : 'sales-chart',
				resize : true,
				colors : [ "#E1F5F2", "#6BC5D2", "#5A5D9D", "#390050" ],
				data : datas,
				hideHover : 'auto'
			}).on('click', function(i, row) {
				// Do your actions
				// Example:
				displayData(i, row);
			});
		});
	}
});
$.ajax({
	url : '/bitbox/getSubSubject?subject=JAVA',
	type : 'GET',
	dataType : "json",
	success : function(datas) {
		$(function() {
			var donut3 = new Morris.Donut({
				element : 'sales-chart3',
				resize : true,
				colors : [ "#E1F5F2", "#6BC5D2" ],
				data : datas,
				hideHover : 'auto'
			});
		});
	}
});
$.ajax({
	url : '/bitbox/getSubjectDate?subject=JAVA',
	type : 'GET',
	dataType : "json",
	success : function(datas) {
		$(function() {
			// default
			var donut3 = new Morris.Donut({
				element : 'sales-chart2',
				resize : true,
				colors : [ "#E1F5F2", "#5A5D9D" ],
				data : datas,
				hideHover : 'auto'
			});
		});
	}
});

function displayData(i, row) {
	if (row.label == 'JAVA') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=JAVA',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : ["#E1F5F2", "#6BC5D2"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=JAVA',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : ["#E1F5F2", "#5A5D9D"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});

	} else if (row.label == 'DBMS') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=DBMS',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : [ "#E1F5F2", "#6BC5D2" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=DBMS',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'JSP') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=JSP',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : [ "#E1F5F2", "#6BC5D2"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=JSP',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'XML') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=XML',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : ["#E1F5F2", "#6BC5D2" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=XML',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'JPA/hibernate') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=JPA/hibernate',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : [ "#E1F5F2", "#6BC5D2" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=JPA/hibernate',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'Spring') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=Spring',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : [ "#E1F5F2", "#6BC5D2" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=Spring',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'Junit/TDD') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=Junit/TDD',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : [ "#E1F5F2", "#6BC5D2"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=Junit/TDD',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'Android') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=Android',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : ["#E1F5F2", "#6BC5D2" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=Android',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : [ "#E1F5F2", "#5A5D9D" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	} else if (row.label == 'UML') {
		$.ajax({
			url : '/bitbox/getSubSubject?subject=UML',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart3',
					resize : true,
					colors : ["#E1F5F2", "#6BC5D2" ],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
		$.ajax({
			url : '/bitbox/getSubjectDate?subject=UML',
			type : 'GET',
			dataType : "json",
			success : function(datas) {
				var donut3 = new Morris.Donut({
					element : 'sales-chart2',
					resize : true,
					colors : ["#E1F5F2", "#5A5D9D"],
					data : datas,
					hideHover : 'auto'
				});
			}
		});
	}
}
