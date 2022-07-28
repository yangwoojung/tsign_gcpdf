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