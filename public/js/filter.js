$(".btn-dollar").on("click", function(){
  let currentText = $(this).text();
  $(".price-header").html(currentText);
});

$(".btn-review").on("click", function(){
  let currentText = $(this).text();
  $(".review-header").html(currentText);
});

$(".btn-grade").on("click", function(){
  let currentText = $(this).text();
  $(".grade-header").html(currentText);
});

$(".btn-distance").on("click", function(){
  let currentText = $(this).text();
  $(".distance-header").html(currentText);
});