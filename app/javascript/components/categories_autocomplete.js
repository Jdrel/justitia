$( "#category" ).autocomplete({
  source: JSON.parse($("#category").attr("data-categories"))
});
