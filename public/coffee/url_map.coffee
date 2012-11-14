$ ->
  $(window).hashchange ->
    url = $.url();
    page = url.fsegment(2);
    method = url.fsegment(3);
    index = url.fsegment(4);
    switch page
      when 'links'
        con=new TwController()
        test=con.getLinkJson()
        con.showPage1(test)
      when 'test2'
        alert('page2')
      else
        con=new TwController()
        con.showPage1()
        test=con.getLinkJson()
        con.loadData1()

  $(window).hashchange()
  return
test_func= ->
  alert("test OK!")