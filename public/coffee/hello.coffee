
$ ->
  $.ajax
    url : "/favever/api/get_fav_data_all/"
    dataType : "json"
    timeout : 30000
    success : (data,datatype) ->
      if data.result=="ok"
        alert("ok")
      else
        alert("ng")
    error :(xml,msg,sss) ->
      alert(msg);

