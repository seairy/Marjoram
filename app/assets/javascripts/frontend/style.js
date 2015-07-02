$(document).ready(function() {
  $('div#navi ul li').hover(function() {
    $('ul', this).slideDown(100);
  }, function() {
    $('ul', this).slideUp(100);
  });
  $("div.portlet div.title").corner("top 6px");
  $("div.portlet div.content").corner("bottom 6px");
  $("ol").corner();
  $("fieldset.form-generic li:even").addClass("even");
  $("table.list-generic tbody tr:even").addClass("even");
  $("table.list-generic thead td:last").addClass("action");
});

function submitForm(formId) {
  $('#' + formId).submit();
}

function selectInterviewType(typeId) {
  if (typeId.value != "") {
    $.ajax({
      url : "/interview_types/" + typeId.value + "/answer_attached",
      cache : false,
      success : function(data) {
        if (data == "true") {
          $("li#answer").addClass("dn");
        } else {
          $("li#answer").removeClass("dn");
        }
     }
  });
  }
}

function countSummaryWord() {
  $('#summary-word-count-tip').html('当前已输入' + $('#summary').val().length + '个字符');
}
