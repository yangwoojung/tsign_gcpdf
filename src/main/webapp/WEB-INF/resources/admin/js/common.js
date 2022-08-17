/**********************************
 @ common
 **********************************/
var common = {

    stageData: {_y: 0, _w: 0, _h: 0},			// page information data
    agent: null,										// check media(true:PC & false:MOBILE)
    btnTopFlag: false,										// button top flag


    //common init
    init: function () {

        common.agent = common.checkMedia();
        gnb.init();


        this.setStageData();
        this.scroll();
        this.resize();

    },

    //common scroll
    scroll: function () {

        this.setStageData();

    },

    //common resize
    resize: function () {

        this.setStageData();
        this.scroll();

    },

    //page scroll top move
    scrollTop: function () {
        $('html,body').stop().animate({scrollTop: 0}, 600);
    },

    //stage data set
    setStageData: function () {
        common.stageData._y = $(window).scrollTop();
        common.stageData._w = $(window).width();
        common.stageData._h = $(window).height();
    },

    //open Content Pop
    contentPopOpen: function (_class) {
        var _target = $('.' + _class);
        _target.stop(true).fadeIn(350);

        if (_target.find('> div').innerHeight() > common.stageData._h) {
            $('body').css({'padding-right': common.getScrollBarWidth() + 'px'})
        } else {
            $('body').attr('style', '');
        }
        common.htmlAddFix();
    },

    //close Content Pop
    contentPopClose: function (_target) {
        $(_target).parents('.pop_wrap').stop(true).fadeOut(350, function () {
            $('body').attr('style', '');
            common.htmlDelFix();
        });
    },

    // html Fix Add
    htmlAddFix: function () {
        $('html').addClass('fix');
    },

    // html Fix Remove
    htmlDelFix: function () {
        $('html').removeClass('fix');
    },

    //page scroll disable add event handler
    parentScrollDisable: function () {
        $('body').on('scroll touchmove mousewheel', function (e) {
            e.preventDefault();
            e.stopPropagation();
            return false;
        });
    },

    //page scroll enable add event handler
    parentScrollEnable: function () {
        $('body').off('scroll touchmove mousewheel');
    },

    //html parameter check (httpUrl?num=1&page=1)
    getParameter: function (key) {
        var url = location.href;
        var spoint = url.indexOf("?");
        var query = url.substring(spoint, url.length);
        var keys = new Array;
        var values = new Array;
        var nextStartPoint = 0;
        while (query.indexOf("&", (nextStartPoint + 1)) > -1) {
            var item = query.substring(nextStartPoint, query.indexOf("&", (nextStartPoint + 1)));
            var p = item.indexOf("=");
            keys[keys.length] = item.substring(1, p);
            values[values.length] = item.substring(p + 1, item.length);
            nextStartPoint = query.indexOf("&", (nextStartPoint + 1));
        }
        item = query.substring(nextStartPoint, query.length);
        p = item.indexOf("=");
        keys[keys.length] = item.substring(1, p);
        values[values.length] = item.substring(p + 1, item.length);
        var value = "";
        for (var i = 0; i < keys.length; i++) {
            if (keys[i] == key) {
                value = values[i];
            }
        }
        return value;
    },

    //browser pc mobile check
    checkMedia: function () {
        var UserAgent = navigator.userAgent;
        var UserFlag = true;
        if (UserAgent.match(/iPhone|iPad|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null) UserFlag = false
        return UserFlag
    },

    //get html scroll width
    getScrollBarWidth: function () {
        var inner = document.createElement('p');
        inner.style.width = "100%";
        inner.style.height = "200px";

        var outer = document.createElement('div');
        outer.style.position = "absolute";
        outer.style.top = "0px";
        outer.style.left = "0px";
        outer.style.visibility = "hidden";
        outer.style.width = "200px";
        outer.style.height = "150px";
        outer.style.overflow = "hidden";
        outer.appendChild(inner);

        document.body.appendChild(outer);
        var w1 = inner.offsetWidth;
        outer.style.overflow = 'scroll';
        var w2 = inner.offsetWidth;
        if (w1 == w2) w2 = outer.clientWidth;

        document.body.removeChild(outer);

        return (w1 - w2);
    },

    datepicker: function (selector, min, max) {
        var option = {
            showOn: "both",
            buttonImage: "/resources/admin/images/datepicker/btn_datepicker.png",
            buttonImageOnly: true,
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            showMonthAfterYear: true,
            yearSuffix: '년'
        }
        if (min != null) {
            option.minDate = min;
        }
        if (max != null) {
            option.maxDate = max;
        }
        $(selector).datepicker(option);
    }
};

var gnb = {

    target: null,

    init: function () {

        this.target = $('#gnb');

        this.target.find('> ul > li').each(function () {
            if ($(this).find('.snb').length > 0) {
                $(this).addClass('two').find('> a').attr('href', 'javascript:;');
            } else {
                $(this).addClass('none');
            }

            if ($(this).hasClass('actived')) {
                $(this).addClass('open');
            }
        });

        this.target.find('> ul > li > a').click(function () {
            var _parent = $(this).parent();
            if (_parent.hasClass('open')) {
                _parent.removeClass('open actived');
            } else {
                _parent.addClass('open');
            }
        });
    }

}

/******************************************************
 @ Init
 ******************************************************/
$(function () {

    common.init();

});


/******************************************************
 @ Document Ready
 ******************************************************/
$(document).ready(function () {

});


/******************************************************
 @ Window Load
 ******************************************************/
$(window).on("load", function () {

});


/******************************************************
 @ Window Scroll
 ******************************************************/
$(window).on("scroll", function () {

    common.scroll();

});


/******************************************************
 @ Window Resize
 ******************************************************/
$(window).on("resize", function () {

    common.resize();

});

/******************************************************
 @ DATATABLES COMMON CONFIG
 ******************************************************/
$.extend(true, $.fn.dataTable.defaults, {
    processing: true,
    searching: true,
    search: {
        return: true,
    },
    ordering: true,
    serverSide: true,
    responsive: true,
    lengthChange: true,
    // dom: 'Bfltip',
    scrollCollapse: true,
    // deferRender: true,
    scrollX: true,
    scroller: {
        loadingIndicator: true
    },
    columnDefs: [
        {
            className: 'dt-center', targets: '_all'
        },
        {
            defaultContent: "", targets: '_all'
        },
    ],
    ajax: {
        data: function (data, settings) {

            let orderBy = "";
            for (let i = 0; i < data.order.length; i++) {
                const {column, dir} = data.order[i];
                orderBy = data.columns[column].name + " " + dir
            }
            data.orderBy = orderBy;

            if (data.search.value) {
                data.searchWord = data.search.value;
            }
            return JSON.stringify(data);

        },
    },
    language: {
        "emptyTable": "데이터가 없습니다",
        "info": "_START_ - _END_ \/ _TOTAL_",
        "infoEmpty": "0 - 0 \/ 0",
        "infoFiltered": "(총 _MAX_ 개)",
        "infoThousands": ",",
        // "lengthMenu": "페이지당 줄수 _MENU_",
        "lengthMenu": "_MENU_",
        // "loadingRecords": "읽는중...",
        "loadingRecords": "<div class=\"spinner\"></div>",
        "processing": "처리중...",
        // "search": "검색:",
        "search": "",
        "zeroRecords": "검색 결과가 없습니다",
        "paginate": {
            "first": "처음",
            "last": "마지막",
            "next": "다음",
            "previous": "이전"
        },
        "aria": {
            "sortAscending": ": 오름차순 정렬",
            "sortDescending": ": 내림차순 정렬"
        },
        "buttons": {
            "copyKeys": "ctrl키 나 u2318 + C키로 테이블 데이터를 시스텝 복사판에서 복사하고 취소하려면 이 메시지를 클릭하거나 ESC키를 누르면됩니다. to copy the table data to your system clipboard. To cancel, click this message or press escape.",
            "copySuccess": {
                "_": "%d행을 복사판에서 복사됨",
                "1": "1행을 복사판에서 복사됨"
            },
            "copyTitle": "복사판에서 복사",
            "csv": "CSV",
            "excel": "엑설",
            "pageLength": {
                "-1": "모든 행 보기",
                "_": "%d행 보기"
            },
            "pdf": "PDF",
            "print": "인쇄",
            "collection": "집합 <span class=\"ui-button-icon-primary ui-icon ui-icon-triangle-1-s\"><\/span>",
            "colvis": "컬럼 보기",
            "colvisRestore": "보기 복원",
            "copy": "복사"
        },
        "searchBuilder": {
            "add": "조건 추가",
            "button": {
                "0": "빌더 조회",
                "_": "빌더 조회(%d)"
            },
            "clearAll": "모두 지우기",
            "condition": "조건",
            "data": "데이터",
            "deleteTitle": "필터 규칙을 삭제",
            "logicAnd": "And",
            "logicOr": "Or",
            "title": {
                "0": "빌더 조회",
                "_": "빌더 조회(%d)"
            },
            "value": "값"
        },
        "autoFill": {
            "cancel": "취소",
            "fill": "모든 셀에서 <i>%d<i>을(를) 삽입<\/i><\/i>",
            "fillHorizontal": "수평 셀에서 값을 삽입",
            "fillVertical": "수직 설에서 값을 삽입"
        }
    }
});

/******************************************************
 @ SWEET ALERT2 COMMON CONFIG
 ******************************************************/
