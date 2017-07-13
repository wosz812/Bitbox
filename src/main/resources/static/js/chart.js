
		$(function() {
			"use strict";

			//DONUT CHART
			var donut = new Morris.Donut({
				element : 'sales-chart',
				resize : true,
				colors : [ "#3c8dbc", "#f56954", "#00a65a", "#ffdf3e" ],
				data : [ {
					label : "Spring",
					value : 12
				}, {
					label : "JAVA",
					value : 50
				}, {
					label : "DB",
					value : 20
				}, {
					label : "Android",
					value : 10
				} ],
				hideHover : 'auto'
			}).on('click', function(i, row) {

				
				if (row.label == "DB") {
					
					var donut2 = new Morris.Donut({
						element : 'sales-chart2',
						resize : true,
						colors : [ "#00a65a", "#8ec96d" ],
						data : [ {
							label : "현재 일수",
							value : 13
						},

						{
							label : "남은 일수",
							value : 7
						} ],
						hideHover : 'auto'
					});
					
					var donut3 = new Morris.Donut({
						element : 'sales-chart3',
						resize : true,
						colors : [ "#00a65a", "#8ec96d" ],
						data : [ {
							label : "현재 일수",
							value : 13
						},

						{
							label : "남은 일수",
							value : 7
						} ],
						hideHover : 'auto'
					});
				} else if (row.label == "Spring") {
					
					var donut2 = new Morris.Donut({
						element : 'sales-chart2',
						resize : true,
						colors : [ "#3c8dbc", "#73d1f7" ],
						data : [ {
							label : "현재 일수",
							value : 1
						},

						{
							label : "남은 일수",
							value : 7
						} ],
						hideHover : 'auto'
					});
					
					var donut3 = new Morris.Donut({
						element : 'sales-chart3',
						resize : true,
						colors : [ "#00a65a", "#8ec96d" ],
						data : [ {
							label : "현재 일수",
							value : 13
						},

						{
							label : "남은 일수",
							value : 7
						} ],
						hideHover : 'auto'
					});
				} else if (row.label == "Android") {
					
					var donut2 = new Morris.Donut({
						element : 'sales-chart2',
						resize : true,
						colors : [ "#ffdf3e", "#ffeeac" ],
						data : [ {
							label : "현재 일수",
							value : 11
						},

						{
							label : "남은 일수",
							value : 10
						} ],
						hideHover : 'auto'
					});
					
					var donut3 = new Morris.Donut({
						element : 'sales-chart3',
						resize : true,
						colors : [ "#00a65a", "#8ec96d" ],
						data : [ {
							label : "현재 일수",
							value : 13
						},

						{
							label : "남은 일수",
							value : 7
						} ],
						hideHover : 'auto'
					});

				} else if (row.label == "JAVA") {
				
					var donut2 = new Morris.Donut({
						element : 'sales-chart2',
						resize : true,
						colors : [ "#da3f3a", "#f56954" ],
						data : [ {
							label : "현재 일수",
							value : 22
						},

						{
							label : "남은 일수",
							value : 6
						} ],
						hideHover : 'auto'
					});
					
					var donut3 = new Morris.Donut({
						element : 'sales-chart3',
						resize : true,
						colors : [ "#00a65a", "#8ec96d" ],
						data : [ {
							label : "현재 일수",
							value : 13
						},

						{
							label : "남은 일수",
							value : 7
						} ],
						hideHover : 'auto'
					});

				}
			});

			//default
			var donut = new Morris.Donut({
				element: 'sales-chart2',
				resize: true,
				colors : [ "#da3f3a", "#f56954" ],
				data : [ {
					label : "현재 일수",
					value : 22
				},

				{
					label : "남은 일수",
					value : 6
				} ],
					hideHover: 'auto'
			});
			
			var donut3 = new Morris.Donut({
				element : 'sales-chart3',
				resize : true,
				colors : [ "#3c8dbc", "#f56954", "#00a65a", "#ffdf3e","#f56954" ],
				data : [ {
					label : "과목1",
					value : 13
				},
				{
					label : "과목2",
					value : 12
				},
				{
					label : "과목3",
					value :5
				},
				{
					label : "과목4",
					value : 11
				},

				{
					label : "과목5",
					value : 7
				} ],
				hideHover : 'auto'
			});


		});

