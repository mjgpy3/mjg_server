function box(element) {
  element.style.border = "solid 2px";
}
function unbox(element) {
  element.style.border = "";
}
function color_selected(element) {
  color = element.style.backgroundColor;
  text_field = document.getElementById("todo_color");

  text_field.value = color;
}
