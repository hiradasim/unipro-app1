const form = document.getElementById("task-form");
const input = document.getElementById("task-input");
const list = document.getElementById("task-list");

let tasks = JSON.parse(localStorage.getItem("tasks") || "[]");
render();

form.addEventListener("submit", (e) => {
  e.preventDefault();
  const text = input.value.trim();
  if (!text) return;
  tasks.push({ text, done: false });
  input.value = "";
  save();
  render();
});

function render() {
  list.innerHTML = "";
  tasks.forEach((task, index) => {
    const li = document.createElement("li");
    li.textContent = task.text;
    if (task.done) li.classList.add("done");
    li.addEventListener("click", () => {
      tasks[index].done = !tasks[index].done;
      save();
      render();
    });
    const remove = document.createElement("button");
    remove.textContent = "\u2715";
    remove.addEventListener("click", (e) => {
      e.stopPropagation();
      tasks.splice(index, 1);
      save();
      render();
    });
    li.appendChild(remove);
    list.appendChild(li);
  });
}

function save() {
  localStorage.setItem("tasks", JSON.stringify(tasks));
}
