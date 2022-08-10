<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="page_tab">
	<ul>
		<li data-url="cmi"><a href="javascript:void(0);">1.본인인증</a></li>
		<li data-url="sign"><a href="javascript:void(0);" >2.계약서/구비서류</a></li>
	</ul>
</div>

<script>
	(function () {
		const current = location.pathname.split('/')[1];
		if (current === "") return;
		let menuItems = document.querySelectorAll('.page_tab li');
		for (let i = 0; i < menuItems.length; i++) {
			if (menuItems[i].getAttribute("data-url").indexOf(current) !== -1) {
				menuItems[i].className = "actived";
				break;
			}
		}
	})();
</script>