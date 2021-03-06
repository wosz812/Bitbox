<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<a href="/bitbox/myPage" style="width: 50px; height: 50px;"><img id="profile" src="/pngFiles/${img}" class="img-circle" alt="User Image"
				style="width:36px; height: 48px;"></a>
			</div>
			<div class="pull-left info">
				<p>${id}</p>
				<a href="/bitbox/logout"><i class="fa fa-sign-out"></i>Sign out</a>
			</div>
		</div>

		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header">BitBox Menu</li>
			<li><a href="/bitbox/myPage"> <i class="fa fa-child"></i> <span>MY</span>
					<span class="pull-right-container"> </span>
			</a></li>
			<li class="treeview"><a href="#"> <i class="fa fa-dashboard"></i>
					<span>PROJECT</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="/bitbox/listAll"><i class="fa fa-user"></i>
							Personal Project</a></li>
					<li><a href="/bitbox/getGroupList"><i class="fa fa-users"></i>
							Group Project <span class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">

							<c:forEach items="${groupList}" var="group">
								<li><a href="/git/gitBoard?title=${group.title}"><i
										class="fa fa-group"></i> ${group.title}</a></li>
							</c:forEach>
						</ul></li>
				</ul></li>
			<li class="treeview"><a href="#"><i class="fa fa-pencil"></i><span>MEMO</span>
					<span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/memo/pMemo?group_seq=0"><i
							class="fa fa-user"></i> Personal MEMO</a></li>
					<li><a href="#"><i class="fa fa-users"></i> Group MEMO <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<c:forEach items="${groupList}" var="group">
								<li><a href="/memo/gMemo?group_seq=${group.group_seq}"><i
										class="fa fa-group"></i> ${group.title}</a></li>
							</c:forEach>
						</ul></li>
				</ul></li>

			<li><a href="#"><i class="fa fa-commenting-o"></i> <span>Meeting</span>
					<span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span></a>
				<ul class="treeview-menu">
					<c:forEach items="${groupList}" var="group">
						<li><a
							href="/bitbox/minutesList?group_seq=${group.group_seq}&group_title=${group.title}"><i
								class="fa fa-group"></i>${group.title}</a></li>
					</c:forEach>
				</ul></li>

			<li><a href="#"><i class="fa fa-bar-chart"></i> <span>Gantt
						Chart</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span></a>
				<ul class="treeview-menu">
					<c:forEach items="${groupList}" var="group">
						<li><a
							href="/bitbox/ganttForm?group_seq=${group.group_seq}&group_title=${group.title}"><i
								class="fa fa-group"></i>&nbsp;${group.title}</a></li>
					</c:forEach>
				</ul></li>

			<li><a href="/bitbox/calendar"> <i class="fa fa-calendar"></i>
					<span>Calendar</span> <span class="pull-right-container"> </span>
			</a></li>
			<li><a href="/bitbox/qna"> <i class="fa fa-question"></i> <span>Q
						& A</span> <span class="pull-right-container"> </span>
			</a></li>

			<li><a href="/bitbox/group"> <i class="fa fa-users"></i> <span>Group</span>
					<span class="pull-right-container"> </span>
			</a></li>

			<li><a href="/bitbox/diff"> <i class="fa fa-check"></i> <span>Diff</span>
					<span class="pull-right-container"> </span>
			</a></li>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>
