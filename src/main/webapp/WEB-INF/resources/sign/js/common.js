var ComUtil = {

    /**
     * 문자열 전체 변경
     * @parameter find        : 변경할 문자열
     * @parameter replace    : 변경될 문자열
     * @parameter str        : 변경대상 문자열
     * @return                : 변경 완료한 문자열
     */
    replaceAll: function (find, replace, str) {
        return str.toString().replace(new RegExp(find, 'g'), replace);
    },

    /**
     * 문자열 앞뒤 공백 제거
     * @parameter str        : 변경대상 문자열
     * @return                : 변경 완료한 문자열
     */
    replaceEmpty: function (str) {
        if (!ComUtil.isNull(str)) {
            return str.toString().replace(/(^\s*)|(\s*$)/gi, '');
        } else {
            return null;
        }
    },

    /**
     * 숫자 3자리마다 , 넣기
     * @parameter str        : ,를 넣을 숫자
     * @return                : ,가 들어간 숫자
     */
    setComma: function (str) {
        if (/^[+-]?\d*(\.?\d*)$/.test(str)) {
            if (str.toString().indexOf('.') == -1) {
                return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            } else {
                str = str.toString();
                var intVal = str.substring(0, str.indexOf('.'));
                var floatVal = str.substring(str.indexOf('.') + 1, str.length);
                intVal = intVal.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                return intVal + '.' + floatVal;
            }
        } else {
            return str;
        }
    },

    /**
     * null check
     * @parameter data        : null 여부 체크할 데이터
     * @return                : null 이면 true, null이 아니면 false
     */
    isNull: function (data) {
        if (data === undefined || data === 'undefined'
            || data === null || data === 'null' || (typeof (data) == 'string' && data.replace(/(^\s*)|(\s*$)/gi, '') === '')
            || (data != null && typeof (data) == 'object' && !Object.keys(data).length)) {
            return true;
        } else {
            return false;
        }
    },

    /**
     * 숫자만 있는지 확인
     * @parameter str        : 확인할 문자열
     * @return                : 숫자면 true, 숫자가 아니면 false
     */
    isNum: function (str) {
        if (!ComUtil.isNull(str)) {
            return /^[+-]?\d*(\.?\d*)$/.test(str.toString());
        } else {
            return false;
        }
    },

    /**
     * 숫자만 있는지 확인
     * @parameter str        : 확인할 tag
     */
    changeNum: function (tagObj) {
        var chkVal = $(tagObj).val();
        if (!ComUtil.isNull(chkVal) && !ComUtil.isNum(chkVal)) {
            $(tagObj).val('');
            $(tagObj).focus();
        }
    },

    /**
     * 한글+숫자만 있는지 확인
     * @parameter str        : 확인할 문자열
     * @return                : 한글+숫자 면 true, 한글+숫자가 아니면 false
     */
    isKoreanAndNum: function (str) {
        if (!ComUtil.isNull(str)) {
            return /^[가-힣\s0-9]*$/.test(str.toString());
        } else {
            return false;
        }
    },

    /**
     * 한글+숫자만 있는지 확인
     * @parameter str        : 확인할 tag
     */
    changeKoreanAndNum: function (tagObj) {
        var chkVal = $(tagObj).val();
        console.log($(tagObj));
        if (!ComUtil.isNull(chkVal) && !ComUtil.isKoreanAndNum(chkVal)) {
            $(tagObj).val('');
            $(tagObj).focus();
        }
    },

    /**
     * 한글+영문만 있는지 확인
     * @parameter str        : 확인할 문자열
     * @return                : 한글+영문 면 true, 한글+영문가 아니면 false
     */
    isLetter: function (str) {
        if (!ComUtil.isNull(str)) {
            return /^[가-힣a-zA-Z\s]*$/.test(str.toString());
        } else {
            return false;
        }
    },

    /**
     * 한글+영문만 있는지 확인
     * @parameter str        : 확인할 tag
     */
    changeLetter: function (tagObj) {
        var chkVal = $(tagObj).val();
        if (!ComUtil.isNull(chkVal) && !ComUtil.isLetter(chkVal)) {
            $(tagObj).val('');
            $(tagObj).focus();
        }
    },


    /**
     * 영문(대문자)+숫자 만 있는지 확인
     * @parameter str        : 확인할 문자열
     * @return                : 영문(대문자) 면 true, 영문(대문자)가 아니면 false
     */
    isCapitalAndNum: function (str) {
        if (!ComUtil.isNull(str)) {
            return /^[A-Z0-9\s]*$/.test(str.toString());
        } else {
            return false;
        }
    },

    /**
     * 영문(대문자)+숫자 만 있는지 확인
     * @parameter str        : 확인할 tag
     */
    changeCapitalAndNum: function (tagObj) {
        var chkVal = $(tagObj).val();
        if (!ComUtil.isNull(chkVal) && !ComUtil.isCapitalAndNum(chkVal)) {
            $(tagObj).val('');
            $(tagObj).focus();
        }
    },

    /**
     * E-mail 형식인지 확인
     * @parameter str        : 확인할 문자열
     * @return                :
     */
    isEmail: function (str) {
        if (!ComUtil.isNull(str)) {
            return /(\w+\.)*\w+@(\w+\.)+[A-Za-z]+/.test(str);
        } else {
            return false;
        }
    },

    /**
     * 세션스토리지 데이터 저장
     * @parameter key        : 저장할 데이터의 이름
     * @parameter value    : 저장할 데이터
     */
    setSessionStorage: function (key, value) {
        if (key == undefined) {
            console.error('저장할 key가 없습니다.');
        } else if (value == undefined) {
            console.error('저장할 value가 없습니다.');
        } else {
            if (typeof (value) == 'object') {
                value = JSON.stringify(value);
            }
            sessionStorage.setItem(key, value);
        }
    },

    /**
     * 세션스토리지 데이터 호출
     * @parameter key        : 호출할 데이터의 이름
     */
    getSessionStorage: function (key) {
        var ssValue = null;
        if (key == undefined) {
            console.warn('조회할 key가 없습니다.');
        } else if (sessionStorage.getItem(key) == undefined) {
            console.warn('저당된 data가 없습니다.');
        } else {
            try {
                ssValue = JSON.parse(sessionStorage.getItem(key));
            } catch (e) {
                ssValue = sessionStorage.getItem(key);
            }
            return ssValue;
        }
    },

    /**
     * 세션스토리지 데이터 삭제
     * @parameter key        : 삭제할 데이터의 이름
     */
    removeSessionStorage: function (key) {
        if (key == undefined) {
            console.warn('삭제할 key가 없습니다.');
        } else {
            var ssValue = sessionStorage.getItem(key);
            if (ssValue == undefined) {
                console.warn('삭제할 value가 없습니다.');
            } else {
                sessionStorage.removeItem(key);
            }
        }
    },

    /**
     * 쿠키 데이터 저장
     * @parameter cookieName    : 저장할 쿠키명
     * @parameter value            : 저장할 데이터
     * @parameter value            : 저장할 기간(날자)
     */
    setCookie: function (cookieName, value, exdays) {
        var exdate = new Date();
        if (ComUtil.isNull(exdays)) {
            exdays = 1;
        }
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays == null) ? '' : '; expires=' + exdate.toGMTString());
        document.cookie = cookieName + '=' + cookieValue;
    },

    /**
     * 쿠키 데이터 삭제
     * @parameter cookieName    : 삭제할 쿠키의 이름
     */
    deleteCookie: function (cookieName) {
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + '= ' + '; expires=' + expireDate.toGMTString();
    },

    /**
     * 쿠키 데이터 삭제
     * @parameter cookieName    : 삭제할 쿠키의 이름
     */
    getCookie: function (cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if (start != -1) {
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if (end == -1) end = cookieData.length;
            cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    },

    /**
     * JSON 객체 복제
     * @parameter jsonObj    : 삭제할 쿠키의 이름
     * @return                : 주소값이 다른 복사된 객체
     */
    copyJsonObj: function (jsonObj) {
        var returnObj = {};
        try {
            returnObj = JSON.parse(JSON.stringify(jsonObj));
        } catch (e) {
            for (var key in jsonObj) {
                returnObj[key] = jsonObj[key];
            }
        }

        return returnObj;
    },

    /**
     * 숫자값 한글로 변환
     * @parameter numStr    : 변환할 숫자값
     * @return                : 변환된 한글 문자열
     */
    getKoreanNumStr: function (numStr) {
        var danArr = ['', '만', '억', '조', '경'];
        var hanDanArr = ['', '십', '백', '천'];
        var hanArr = ['', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구'];

        var han = '';
        var result = '';

        numStr = numStr.toString();

        if (!/^[0-9]*$/.test(numStr)) {
            return result;
        }

        for (var i = 0; i < numStr.length; i++) {
            str = '';

            han = hanArr[numStr.charAt(numStr.length - (i + 1))];

            if (han != '' && (i / 4) < danArr.length) {
                str += han + hanDanArr[i % 4];
            } else if ((i / 4) >= danArr.length) {
                str += numStr.charAt(numStr.length - (i + 1));
            }

            if (i % 4 == 0) {
                if ((i / 4) < danArr.length) {
                    str += danArr[i / 4];
                }
            }
            result = str + result;
        }
        return result;
    },

    /**
     * 현재날자 시간 조회
     * @parameter sep        : 날자구분자
     * @parameter typeof    : 날자만 사용할지 여부(true : 날자만, false : 시간포함)
     * @return                : 현재날자
     */
    getCurrentTime: function (sep, type) {
        var d = new Date();
        var year = d.getFullYear().toString();
        var month = (d.getMonth() + 1).toString();
        var date = d.getDate().toString();
        var hour = d.getHours().toString();
        var min = d.getMinutes().toString();
        var sec = d.getSeconds().toString();

        if (ComUtil.isNull(sep)) {
            sep = '/';
        }

        var cd = year + sep;
        cd += (month.length == 1 ? '0' : '') + month + sep;
        cd += (date.length == 1 ? '0' : '') + date;

        var ct = (hour.length == 1 ? '0' : '') + hour + ':';
        ct += (min.length == 1 ? '0' : '') + min + ':';
        ct += (sec.length == 1 ? '0' : '') + sec;

        if (ComUtil.isNull(type) || type) {
            return cd;
        } else {
            return cd + ct;
        }
    },

    /**
     * 날자 계산
     * @parameter dateVal                : 계산하고자 하는 날자 (ex. 2018-10-22)
     * @parameter calcVal                : 더하거나 뺄 값
     * @parameter ymdFlag                : 어디에 더할지 년 (YY) 월 (MM) 일 (DD)
     */
    calcDate: function (dateVal, calcVal, ymdFlag) {
        var date;

        if (ComUtil.isNull(dateVal) || ComUtil.isNull(calcVal) || ComUtil.isNull(ymdFlag) || !ComUtil.isNum(calcVal)) {
            return '';
        }

        calcVal = parseInt(calcVal);

        var y = parseInt(dateVal.substring(0, 4));
        var m = parseInt(dateVal.substring(5, 7), 10) - 1;
        var d = parseInt(dateVal.substring(8, 10), 10);

        if (ymdFlag == 'YY') {
            date = new Date(y + (calcVal), m, d);
        } else if (ymdFlag == 'MM') {
            date = new Date(y, m + (calcVal), d);
        } else if (ymdFlag == 'DD') {
            date = new Date(y, m, d + (calcVal));
        }

        d = date.getDate();
        m = date.getMonth() + 1;
        y = date.getFullYear();

        return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
    },

    /**
     * 날짜 차이 계산
     * @parameter firstDt            : 계산할 첫 번째 날짜
     * @parameter secondDt            : 계산할 두 번째 날짜
     */
    compareDate: function (firstDt, secondDt) {
        if (ComUtil.isNull(firstDt) || ComUtil.isNull(secondDt)) {
            return 0;
        }
        var fDt = new Date(firstDt);
        var sDt = new Date(secondDt);
        return (fDt.getTime() - sDt.getTime()) / (1000 * 60 * 60 * 24);
    },

    /**
     * 자릿수 반올림
     * @parameter num                    : 반올림할 숫자
     * @parameter digit                    : 자릿수 (ex. 10의 단위로 끊을 경우 10, 소숫점 첫번째 자리까지 표시된 반올림의 경우 0.1)
     */
    round: function (num, digit) {
        if (ComUtil.isNum(num) && ComUtil.isNum(digit)) {
            num = parseFloat(num);
            digit = parseFloat(digit);

            var digitVal;
            if (digit < 1) {
                digitVal = digit.toString().substring(digit.toString().indexOf('.') + 1, digit.length).length;
            }
            num = (Math.round(num / digit) * digit);
            if (digit < 1) {
                num = parseFloat(num.toFixed(digitVal));
            }
            return num;
        } else {
            return 0;
        }
    },

    /**
     * 자릿수 버림
     * @parameter num                    : 버림할 숫자
     * @parameter digit                    : 자릿수 (ex. 10의 단위로 끊을 경우 10, 소숫점 첫번째 자리까지 표시된 버림의 경우 0.1)
     */
    roundDown: function (num, digit) {
        if (ComUtil.isNum(num) && ComUtil.isNum(digit)) {
            num = parseFloat(num);
            digit = parseFloat(digit);
            var digitVal;
            if (digit < 1) {
                digitVal = digit.toString().substring(digit.toString().indexOf('.') + 1, digit.length).length;
            }
            num = (Math.floor(num / digit) * digit);
            if (digit < 1) {
                num = parseFloat(num.toFixed(digitVal));
            }
            return num;
        } else {
            return 0;
        }
    },

    /**
     * 자릿수 올림
     * @parameter num                    : 올림할 숫자
     * @parameter digit                    : 자릿수 (ex. 10의 단위로 끊을 경우 10, 소숫점 첫번째 자리까지 표시된 올림의 경우 0.1)
     */
    roundUp: function (num, digit) {
        if (ComUtil.isNum(num) && ComUtil.isNum(digit)) {
            num = parseFloat(num);
            digit = parseFloat(digit);
            var digitVal;
            if (digit < 1) {
                digitVal = digit.toString().substring(digit.toString().indexOf('.') + 1, digit.length).length;
            }
            num = (Math.ceil(num / digit) * digit);
            if (digit < 1) {
                num = parseFloat(num.toFixed(digitVal));
            }
            return num;
        } else {
            return 0;
        }
    },

    /**
     * Array 특정 key의 value 기준으로 정렬
     * @parameter dataList                : 정렬할 객체 Array
     * @parameter sortKey                : 객체의 정렬의 기준이 될 key
     * @parameter reFlag                : 정렬 역순 여부
     */
    sortBySpecificKey: function (dataList, sortKey, reFlag) {
        if (ComUtil.isNull(dataList) || dataList.length == 0 || ComUtil.isNull(sortKey)) {
            return dataList;
        }
        var tmpSort = [];
        var isNumFlag = true;
        for (var i = 0; i < dataList.length; i++) {
            if (!ComUtil.isNull(dataList[i][sortKey])) {
                tmpSort.push(dataList[i][sortKey]);
                if (ComUtil.isNum(dataList[i][sortKey]) == false) {
                    isNumFlag == false;
                }
            }
        }
        // 해당 key 값이 없는 경우 정렬 불가
        if (tmpSort.length != dataList.length) {
            return dataList;
        }

        if (isNumFlag) {
            tmpSort.sort(function (a, b) {
                return a - b;
            });
        } else {
            tmpSort.sort();
        }

        if (!ComUtil.isNull(reFlag) && reFlag == true) {
            tmpSort.reverse();
        }
        var tmpDataList = [];
        var cnt = 0;
        var i = 0;
        while (true) {
            if (dataList[i][sortKey] == tmpSort[cnt]) {
                tmpDataList.push(dataList[i]);
                dataList.splice(i, 1);
                cnt++;
                if (dataList.length == 0) {
                    break;
                }
                i = -1;
            }
            i++;
        }
        return tmpDataList;
    },

    /**
     * Null Undefined 를 '' Empty String 으로 변환
     * @parameter data                    : 변환할 Data
     */
    makeNullToEmptyStr: function (data) {
        if (!ComUtil.isNull(data)) {
            for (var key in data) {
                if (data[key] == undefined || data[key] == null) {
                    data[key] = '';
                } else if (typeof (data[key]) == 'object') {
                    data[key] = ComUtil.makeNullToEmptyStr(data[key]);
                }
            }
        }
        return data;
    },

    /**
     * Ajax 호출
     * @parameter paramMap                : parameter
     * @parameter successCallBackFunc    : 성공시 호출 함수
     * @parameter errorCallBackFunc    : 에러시 호출 함수
     * @parameter async                    : 동기/비동기 여부 (false:동기, true:비동기)
     * @parameter isLoading                : 로딩바 호출 여부
     */
    request: function (paramMap, successCallBackFunc, errorCallBackFunc, async, isLoading) {

        var dataParam;
        var contentType;
        var url;

        if (ComUtil.isNull(paramMap)) {
            console.warn('param 이 존재 하지 않습니다.');
            return;
        }

        if (ComUtil.isNull(paramMap['dataParam'])) {
            paramMap['dataParam'] = {};
        }

        url = paramMap['url'];

        if (ComUtil.isNull(url)) {
            console.warn('url 이 존재 하지 않습니다.');
            return;
        }

        contentType = paramMap['contentType'];

        if (ComUtil.isNull(contentType)) {
            dataParam = JSON.stringify(paramMap['dataParam']);
            contentType = 'application/json; charset=utf-8';
        } else {
            dataParam = paramMap['dataParam'];
            contentType = contentType;
        }

        if (ComUtil.isNull(async)) {
            async = true;
        }

        $.ajax({
            type: 'POST',
            url: url,
            contentType: contentType,
            data: dataParam,
            async: async,
            success: function (response, status, jqXhr) {
                if (!ComUtil.isNull(response) && !ComUtil.isNull(successCallBackFunc) && typeof (successCallBackFunc) == 'function') {
                    successCallBackFunc(response);
                } else if (ComUtil.isNull(successCallBackFunc)) {
                    console.warn('Callback 함수가 없습니다.');
                } else {
                    console.error('조회에 실패하였습니다.');
                }
            },
            beforeSend: function () {

            },
            error: function (e) {
                console.error(e);
                if (errorCallBackFunc != undefined && errorCallBackFunc != null && typeof (errorCallBackFunc) == 'function') {
                    errorCallBackFunc(e);
                }
            },
            ajaxComplete: function () {

            }
        });
    },

    /**
     * Submit 호출
     * @parameter moveUrl                : submit할 URL
     * @parameter params                : parameter
     * @parameter method                : GET/POST 구분
     */
    submit: function (moveUrl, params, method) {
        if (ComUtil.isNull(moveUrl)) {
            console.warn('URL 이 존재하지 않습니다.');
            return;
        }

        if (ComUtil.isNull(method)) {
            method = 'POST';
        }

        if (0 < $('#submitForm').length) {
            return;
        }

        $('body').append('<form id="submitForm" action="' + moveUrl + '" method="' + method + '"></form>');

        if (!ComUtil.isNull(params)) {
            for (var key in params) {
                var input = $('<input>').attr('type', 'hidden').attr('name', key).val(params[key]);
                $('#submitForm').append($(input));
            }
        }

        $('#submitForm').submit();
    },

    /**
     * 소수점 이하 0 붙이기
     * @parameter decVal                : 0을 붙일 대상 값
     * @parameter digit                : 소수점 자릿수
     */
    setDecimalPlace: function (decVal, digit) {
        if (ComUtil.isNull(decVal) || ComUtil.isNull(digit) || !ComUtil.isNum(decVal) || !ComUtil.isNum(digit) || parseInt(digit) <= 0) {
            return decVal;
        }
        decVal = decVal.toString();
        var index = decVal.indexOf('.');

        if (index == -1) {
            decVal += '.';
            for (var i = 0; i < digit; i++) {
                decVal += '0';
            }
        } else {
            var length = decVal.substring(decVal.indexOf('.') + 1, decVal.length).length;
            if (length < digit) {
                while (length < digit) {
                    decVal += '0';
                    length++;
                }
            } else {
                decVal = decVal.substring(0, decVal.indexOf('.') + 1 + digit);
            }
        }
        return decVal;
    },

    /**
     * Validation
     * @parameter type                : valid type
     * @parameter value                : valid value
     */
    isValid: function (type, value) {
        if (isEmptyString(type) || isEmptyString(value)) {
            return false;
        }

        type = type.toUpperCase();

        if (type == 'ID') {
            if (/^[^가-힇]*$/.test(value)) {
                return false;
            }
            if (value.length < 6 || value.length > 30) {
                return false;
            }
        } else if (type == 'NAME') {
            if (value.length > 50) {
                return false;
            }
        } else if (type == 'DATE') {
            if (!/^(19|20)[0-9]{2}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/.test(value)) {
                return false;
            }
        } else if (type == 'TEL_01') {
            if (/^[^0-9]*$/.test(value)) {
                return false;
            }
            if (value.length > 4) {
                return false;
            }
        } else if (type == 'TEL_02') {
            if (/^[^0-9]*$/.test(value)) {
                return false;
            }
            if (value.length > 4) {
                return false;
            }
        } else if (type == 'TEL_03') {
            if (/^[^0-9]*$/.test(value)) {
                return false;
            }
            if (value.length > 7) {
                return false;
            }
        } else if (type == 'MOB_01') {
            if (/^[^0-9]*$/.test(value)) {
                return false;
            }
            if (value.length < 1 || value.length > 3) {
                return false;
            }
        } else if (type == 'MOB_02') {
            if (/^[^0-9]*$/.test(value)) {
                return false;
            }
            if (value.length < 1 || value.length > 10) {
                return false;
            }
        } else if (type == 'EMAIL') {
            if (!/^[a-z0-9._-]+@[a-z0-9._-]+\.[a-z]{2,}$/.test(value)) {
                return false;
            }
        } else {
            return false;
        }

        return true;

        function isEmptyString(str) {
            if (str == undefined || str == null || str == '') {
                return true;
            }
            return false;
        }
    },

    /**
     * Mobile OS Check
     */
    checkMobileOS: function () {
        var userAgent = navigator.userAgent || navigator.vendor || window.opera;

        if (/windows phone/i.test(userAgent)) {
            return 'WIN';
        }

        if (/android/i.test(userAgent)) {
            return 'AND';
        }

        if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
            return 'IOS';
        }
    },

    /**
     * 바이트 length 계산
     * @parameter s                : 계산할 문자열
     */
    getByteLength: function (s) {
        var b, i, c;
        for (b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3 : c >> 7 ? 2 : 1) ;
        return b;
    },

    /**
     * Pin Code 발송
     */
    sendPinCode: function (param, callback) {
        var requestMap = {
            dataParam: param,
            url: '/sign/pin/send'
        };
        ComUtil.request(requestMap, callback);
    },

    certPhone: function () {
        var requestMap = {
            dataParam: null,
            url: '/sign/cert/initPhone'
        };
        ComUtil.request(requestMap, function (data) {
            if (!ComUtil.isNull(data)) {
                var popup = window.open('', 'PHONE_CHECK', 'width=450, height=800, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200');
                console.log(data);
                $('body').append('<form id="phoneCertForm" name="phoneCertForm" action="https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp" target="PHONE_CHECK" method="post"></form>');
                $('#phoneCertForm').append($('<input>').attr('type', 'hidden').attr('name', 'reqNum').val(data['reqNum']));
                $('#phoneCertForm').append($('<input>').attr('type', 'hidden').attr('name', 'reqInfo').val(data['reqInfo']));
                $('#phoneCertForm').append($('<input>').attr('type', 'hidden').attr('name', 'retUrl').val(data['retUrl']));

                document.phoneCertForm.submit();
                $('#phoneCertForm').remove();
                return true;
            } else {
                alert('휴대폰인증 초기화에 실패하였습니다.');
            }
        });
    },

    certAccount: function () {
        var requestMap = {
            dataParam: null,
            url: '/cert/initAcc'
        };
        ComUtil.request(requestMap, function (data) {
            if (!ComUtil.isNull(data)) {
                var popup = window.open('', 'ACCOUNT_CHECK', 'width=450, height=800, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200');
                console.log(data);
                $('body').append('<form id="accountCertForm" name="accountCertForm" action="https://www.goodpaper.co.kr/account/v2/account_check" target="ACCOUNT_CHECK" method="post"></form>');
                $('#accountCertForm').append($('<input>').attr('type', 'hidden').attr('name', 'req_info').val(data['req_info']));
                $('#accountCertForm').append($('<input>').attr('type', 'hidden').attr('name', 'call_back').val(data['call_back']));
                $('#accountCertForm').append($('<input>').attr('type', 'hidden').attr('name', 'real_account_type').val('account'));

                document.accountCertForm.submit();
                $('#accountCertForm').remove();
                return true;
            } else {
                alert('계좌인증 초기화에 실패하였습니다.');
            }
        });
    }

};

var cm = {
    input: {
        check: function (o) {
            return cm.input._type(o) && cm.input._size(o);
        },
        slice: function (o) {
            if (o.maxLength > 0 && o.value.length > o.maxLength)
                o.value = o.value.slice(0, o.maxLength);
        },
        _type: function (o) {
            if ('number' === o.type)
                return event.keyCode > 47 && event.keyCode < 58;
            return true;
        },
        _size: function (o) {
            if (o.maxLength > 0)
                return o.value.length < o.maxLength;
            return true;
        }
    },
    validator: {
        number: function (v, s) {
            var r = /^[0-9]+$/;
            if (s) r = new RegExp('^\\d{' + s + '}$');
            return r.test(v);
        },
        phone: function (v) {
            var r = /^\d{10,11}$/;
            return r.test(v);
        }
    },
    str: {
        lpad: function (v, s) {
            v = v + '';
            return v.length >= s ? v : new Array(s - v.length + 1).join('0') + v;
        }
    }
};

function onlyNumber(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ((48 <= keyID && keyID <= 57) || (96 <= keyID && keyID <= 105)
        || keyID == 8 || keyID == 9 || keyID == 13 || keyID == 17 || keyID == 35
        || keyID == 36 || keyID == 37 || keyID == 39 || keyID == 46 || keyID == 67 || keyID == 86) {
        return;
    } else {
        return false;
    }
}

function removeChar(event) {
    event = event || window.event;
    event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function removeSpaces(event) {
    event = event || window.event;
    event.target.value = event.target.value.split(' ').join('');
}
