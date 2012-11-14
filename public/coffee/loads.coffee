class TwController
  constructor : ->
    if !window.localStorage
      alert("このブラウザはLocalStorageに対応していないので当サイトを利用できません。最新のブラウザをお使いください。")
      retern
    if !window.localStorage.getItem("jsondata")
      $.ajax
        url : "/favever/api/timeline_json/"
        dataType : "json"
        timeout : 30000
        success : (data,datatype) ->
          window.localStorage.setItem("jsondata",JSON.stringify(data))
        error :(xml,msg,sss) ->
          alert(msg);
  JsonData: $.parseJSON(window.localStorage.getItem("jsondata"))
  showPage1 : (data=this.JsonData) ->
    cont=$("#contents")
    cont.empty();
    $('#tmpl_home_base').tmpl({}).appendTo(cont)
    $('#head_alert').hide()
    $.each data,->

      if this.fields.status.retweet_count
        RT="<span class='badge badge-warning'>#{this.fields.status.retweet_count}RT</span>"
      else
        RT=""
      txt=this.fields.status.text.replace('\n','<br>')
      pict=""
      if this.fields.status.Urls
        $.each this.fields.status.Urls,->
          link = $.url(this.expanded_url)
          host=link.attr('host')
          seg1 = link.segment(1);
          seg2 = link.segment(2);
          seg3 = link.segment(3);
          seg4 = link.segment(4);
          seg5 = link.segment(5);

          console.log(this.expanded_url)
          console.log("1:#{seg1}")
          console.log("2:#{seg2}")
          console.log("3:#{seg3}")
          console.log("4:#{seg4}")
          console.log("5:#{seg5}")
          switch host
            when 'twitpic.com'
              #http://twitpic.com/show/thumb/[image-id]
              l="http://twitpic.com/show/thumb/#{seg1}"
              pict="<img src='#{l}' alt='pict' />"
            when 'instagr.am'
              l=this.expanded_url+"media/?size=t"
              pict="<img src='#{l}' alt='pict' />"
            when 'miil.me'
              l=this.expanded_url+".jpeg?size=160"
              pict="<img src='#{l}' alt='pict' />"
            when 'miil.me'
              l=this.expanded_url+".jpeg?size=160"
              pict="<img src='#{l}' alt='pict' />"
            else

              console.log('')
          href="<a href='#{this.url}' target='_blank'>#{this.display_url}</a>"
          txt=txt.replace(this.url,href)
      elem="""
            <li class='alert alert-fav status'>
                <h3 class='thin'>
                    <span class='label label-success point'>#{this.fields.point}</span>
                    <img src='#{this.fields.status.user.profile_image_url}' width='36' height='36' alt=''>

                    <span class='tw-name'>#{this.fields.status.user.screen_name}</span>

                    <a href='https://twitter.com/#{this.fields.status.user.screen_name}/status/#{this.fields.status.id}' target='_blank'>
                        <img src='/files/image/twitter_icons/bird_blue_16.png' alt='twitterで開く' title='twitterで開く'>
                    </a>
                </h3>
                <h6>#{this.fields.status.user.name}</h6>
                #{RT}
                <p>
                #{txt}
                #{pict}
                </p>
                <span class='tw-footer'>#{this.fields.status.created_at}</span>

                <div class='star-btn' id=star-btn-#{this.fields.status.id}>
                    <div class='btn-group'>
                        <button class='btn btn-large star_btn_add'><i class='icon-plus'></i></button>
                        <button class='btn btn-large star_btn_omit'><i class='icon-minus'></i></button>

                    </div>
                </div>

            </li>
            """
      $('#status_ul').append(elem)


    setTimeout ->
      $('.statuses li').wookmark
        offset: 20,
        itemWidth: 300,
        autoResize: true
      ,1
  loadData1 : ->
    $.ajax
      url : "/favever/api/get_fav_data/"
      dataType : "json"
      timeout : 30000
      success : (data,datatype) ->

        if data.add_count
          window.localStorage.setItem("jsondata",JSON.stringify(data.datas))
          $("#fav_get_msg").text("#{data.add_count}件の新規Favを取得しました。")
          $('#head_alert').fadeIn(300)
      error :(xml,msg,sss) ->
        alert(msg);
  getLinkJson : ->
    linkJson=new Array()
    for j in this.JsonData
      if j.fields.status.Urls.length>0
        linkJson.push(j)
    return linkJson
window.TwController=TwController