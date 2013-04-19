jQuery.fn.dataTableExt.oSort['num-html-asc']  = function(a,b) {
  var x = parseFloat( a.replace( /<.*?>/g, "" ).replace("$","").replace(/,/g,'') ),
      y = parseFloat( b.replace( /<.*?>/g, "" ).replace("$","").replace(/,/g,'') );
  return ((x < y) ? -1 : ((x > y) ?  1 : 0));
};

jQuery.fn.dataTableExt.oSort['num-html-desc'] = function(a,b) {
  var x = parseFloat( a.replace( /<.*?>/g, "" ).replace("$","").replace(/,/g,'') ),
      y = parseFloat( b.replace( /<.*?>/g, "" ).replace("$","").replace(/,/g,'') );
  return ((x < y) ?  1 : ((x > y) ? -1 : 0));
};