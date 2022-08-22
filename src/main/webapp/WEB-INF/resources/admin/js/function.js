// 문자와 숫자 객체에 대한 기본 메소드 추가 정의 시작
// IE에서 지원하지 않는 문자객체의 startsWith 메소드 추가
String.prototype.startsWith = function (searchString, position) {
    position = position || 0;
    return this.indexOf(searchString, position) === position;
}

//trim 메소드 추가
String.prototype.trim = function (str) {
    str = this != window ? this : str;
    return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}

// 전달 받은 문자열에 세자리 단위로 콤마표시 메소드 추가
function fnComma(str) {
    var isMinus = str.startsWith("-");
    if (isMinus) {
        str = str.substring(1);
    }
    var len = str.length;
    var s1 = "", s2 = "";
    if (len <= 3) {
        return isMinus ? "-" + str : str;
    } else {
        for (var i = len - 1; i >= 0; i--) {
            s1 += str.charAt(i);
        }
        for (var i = len - 1; i >= 0; i--) {
            s2 += s1.charAt(i);
            if (i % 3 == 0 && i != 0) {
                s2 += ",";
            }
        }
        return isMinus ? "-" + s2 : s2;
    }
}

// 문자객체에 세자리 단위로 콤마표시 메소드 추가
String.prototype.comma = function (str) {
    str = this != window ? this : str;
    return fnComma(str);
}

// 숫자객체에 세자리 단위로 콤마표시 메소드 추가
Number.prototype.comma = function (val) {
    val = this != window ? this : val;
    var str = val.toString();
    return fnComma(str);
}
// 문자와 숫자 변수에 대한 기본 메소드 추가 정의 끝

/* 정수형 숫자(초 단위)를 "시:분:초" 형태로 표현하는 함수 */
function fnConvertHourMinSec(t) {
    var hour, min, sec;

    // 정수로부터 남은 시, 분, 초 단위 계산
    hour = Math.floor(t / 3600);
    min = Math.floor((t - (hour * 3600)) / 60);
    sec = t - (hour * 3600) - (min * 60);

    // hh:mm:ss 형태를 유지하기 위해 한자리 수일 때 0 추가
    if (hour < 10) hour = "0" + hour;
    if (min < 10) min = "0" + min;
    if (sec < 10) sec = "0" + sec;

    if (hour == 0) {
        return (min + ":" + sec);
    }

    return (hour + ":" + min + ":" + sec);
}

// 상세페이지 이동
function fnAction(seq, seqName, action) {
    if (FORM_ID) {
        var form = $("#" + FORM_ID).get(0);

        if (typeof (seqName) == 'string' && 0 < seqName.length) {
            $("#" + seqName).val(seq);
        }

        if (action) {
            form.action = action;
        }

        form.submit();
    }
}

// 목록 검색
function fnSearch() {
    if (FORM_ID) {
        $("#" + FORM_ID).submit();
    }
}

// 페이지 이동
function fnGoPage(page) {
    if (FORM_ID) {
        var form = $("#" + FORM_ID).get(0);

        $("#page").val(page);

        form.action = location.pathname;

        form.submit();
    }
}

//목록 이동
function fnGoList() {
    if (FORM_ID) {
        $("#" + FORM_ID).submit();
    }
}

/*
 * 페이징블럭 제작 함수
 * @param(totalRecord) - Number : 전체 게시물 수
 * @param(pageSize) - Number : 페이지당 게시물 수
 * @param(blockSize) - Number : 페이징 블록 단위
 * @param(currentPage) - Number : 현재 페이지
 * @param(isMoveBlock) - Boolean : 블록단위 이동 버튼 여부
 * @param(isStartToEnd) - Boolean : 첫페이지 및 끝페이지 이동 버튼 여부
 */
function fnMakePaging(totalRecord, pageSize, blockSize, currentPage, isMoveBlock, isStartToEnd, target) {
    if (isNaN(totalRecord) || isNaN(pageSize) || isNaN(blockSize) || isNaN(currentPage)) {
        alert('페이징 처리 시 기본 정보가 잘못 되었습니다.');
        return;
    }

    if (totalRecord == 0) return;

    if (typeof (isMoveBlock) == 'undefined') isMoveBlock = true;
    if (typeof (isStartToEnd) == 'undefined') isStartToEnd = false;

    var totalPage = Math.ceil(totalRecord / pageSize);
    var startPage = Math.floor(currentPage / blockSize) * blockSize + 1;

    // 현재 페이지가 블럭 마지막 페이지일 경우 startPage를 현재 블럭의 startPage로 변경
    var isBlockEndPage = ((currentPage % blockSize) == 0);
    if (isBlockEndPage) startPage -= 10;

    $('p.list_total').html('조회결과 : ' + totalRecord.comma() + '건');

    var endPage = startPage + blockSize - 1;
    endPage = (totalPage < endPage) ? totalPage : endPage;
    var html = '';
    if (isStartToEnd) {
        html += '<a href="javascript:fnGoPage(1);" class="btn_page_first">&lt;&lt;</a>';
    }

    if (isMoveBlock) {
        if (currentPage > blockSize) {
            html += '<a href="javascript:fnGoPage(' + (startPage - blockSize) + ');" class="btn_page_prev">&lt;</a>';
        } else {
            html += '<a href="javascript:fnGoPage(1);" class="btn_page_prev">&lt;</a>';
        }
    }

    html += '<ol>';
    for (var i = startPage; i <= endPage; i++) {
        if (i == currentPage) {
            // 현재 페이지
            html += '<li><a href="javascript:;" class="current">' + i + '</a></li>';
        } else {
            html += '<li><a href="javascript:fnGoPage(' + i + ');">' + i + '</a></li>';
        }
    }
    html += '</ol>';

    if (isMoveBlock) {
        if (totalPage > endPage) {
            html += '<a href="javascript:fnGoPage(' + (startPage + blockSize) + ');" class="btn_page_next">&gt;</a>';
        } else {
            html += '<a href="javascript:;" class="btn_page_next">&gt;</a>';
        }
    }

    if (isStartToEnd) {
        html += '<a href="javascript:fnGoPage(' + totalPage + ');" class="btn_page_end">&gt;&gt;</a>';
    }

    target.html(html)
}


/*
 * 페이징블럭 제작 함수(Ajax용 - 화면단에서 별도 처리 필요)
 * @param(totalRecord) - Number : 전체 게시물 수
 * @param(pageSize) - Number : 페이지당 게시물 수
 * @param(blockSize) - Number : 페이징 블록 단위
 * @param(currentPage) - Number : 현재 페이지
 * @param(isMoveBlock) - Boolean : 블록단위 이동 버튼 여부
 * @param(isStartToEnd) - Boolean : 첫페이지 및 끝페이지 이동 버튼 여부
 */
function fnMakePagingForAjax(totalRecord, pageSize, blockSize, currentPage, isMoveBlock, isStartToEnd, target) {
    if (isNaN(totalRecord) || isNaN(pageSize) || isNaN(blockSize) || isNaN(currentPage)) {
        alert('페이징 처리 시 기본 정보가 잘못 되었습니다.');
        return;
    }

    if (totalRecord == 0) return;

    if (typeof (isMoveBlock) == 'undefined') isMoveBlock = true;
    if (typeof (isStartToEnd) == 'undefined') isStartToEnd = false;

    var totalPage = Math.ceil(totalRecord / pageSize);
    var startPage = Math.floor(currentPage / blockSize) * blockSize + 1;

    // 현재 페이지가 블럭 마지막 페이지일 경우 startPage를 현재 블럭의 startPage로 변경
    var isBlockEndPage = ((currentPage % blockSize) == 0);
    if (isBlockEndPage) startPage -= 10;

    $('p.list_total').html('조회결과 : ' + totalRecord.comma() + '건');

    var endPage = startPage + blockSize - 1;
    endPage = (totalPage < endPage) ? totalPage : endPage;
    var html = '';
    if (isStartToEnd) {
        html += '<a href="javascript:;" data="1" class="btn_page_first">&lt;&lt;</a>';
    }

    if (isMoveBlock) {
        if (currentPage > blockSize) {
            html += '<a href="javascript:;" data="' + (startPage - blockSize) + '" class="btn_page_prev">&lt;</a>';
        } else {
            html += '<a href="javascript:;" data="1" class="btn_page_prev">&lt;</a>';
        }
    }

    html += '<ol>';
    for (var i = startPage; i <= endPage; i++) {
        if (i == currentPage) {
            // 현재 페이지
            html += '<li><a href="javascript:;" class="current">' + i + '</a></li>';
        } else {
            html += '<li><a href="javascript:;" data="' + i + '">' + i + '</a></li>';
        }
    }
    html += '</ol>';

    if (isMoveBlock) {
        if (totalPage > endPage) {
            html += '<a href="javascript:;" data="' + (startPage + blockSize) + '" class="btn_page_next">&gt;</a>';
        } else {
            html += '<a href="javascript:;" class="btn_page_next">&gt;</a>';
        }
    }

    if (isStartToEnd) {
        html += '<a href="javascript:;" page="' + totalPage + '" class="btn_page_end">&gt;&gt;</a>';
    }

    target.html(html)
}

function setValueFromObject(selector, data) {
    const $target = $(selector);
    $target.find('input').each(function (index, element) {
        let $element = $(element);
        let name = $element.attr("name");

        if (data.hasOwnProperty(name)) {
            let value = data[name];
            $element.val(value);
        }
    });
}

(function ($) {

    $.fn.initValidation = function () {

        $(this).removeData("validator");
        $(this).removeData("unobtrusiveValidation");
        $.validator.unobtrusive.parse(this);

        return this;
    };

}(jQuery));
