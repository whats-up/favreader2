$ ->
  if !window.localStorage
    alert("このブラウザはLocalStorageに対応していないので当サイトを利用できません。最新のブラウザをお使いください。")
  if !window.localStorage.getItem("jsondata")
    $.ajax
      url : "/favever/api/timeline_json/"
      dataType : "json"
      timeout : 30000
      success : (data,datatype) ->
        window.localStorage.setItem("jsondata",JSON.stringify(data))
        alert("データ取得に成功しました。")
      error :(xml,msg,sss) ->
        alert(msg);
  window.AAA_JSONDATAS = $.parseJSON(window.localStorage.getItem("jsondata"));
