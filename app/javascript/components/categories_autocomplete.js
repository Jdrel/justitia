const categoryInput = document.getElementById('categories_search_home')

if (categoryInput){
  $( "#categories_search_home" ).autocomplete({
    source: JSON.parse($("#categories_search_home").attr("data-categories"))
  });
}
