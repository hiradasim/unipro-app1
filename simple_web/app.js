const API_URL = "http://localhost:3000";
const form = document.getElementById("task-form");
const input = document.getElementById("task-input");
const list = document.getElementById("task-list");

let tasks = [];

async function load() {
  const res = await fetch(`${API_URL}/tasks`);
  tasks = await res.json();
  render();
}

form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const text = input.value.trim();
  if (!text) return;
  await fetch(`${API_URL}/tasks`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ text }),
  });
  input.value = "";
  load();
});

function render() {
  list.innerHTML = "";
  tasks.forEach((task) => {
    const li = document.createElement("li");
    li.textContent = task.text;
    if (task.done) li.classList.add("done");
    li.addEventListener("click", async () => {
      await fetch(`${API_URL}/tasks/${task.id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ done: !task.done }),
      });
      load();
    });
    const remove = document.createElement("button");
    remove.textContent = "\u2715";
    remove.addEventListener("click", async (e) => {
      e.stopPropagation();
      await fetch(`${API_URL}/tasks/${task.id}`, {
        method: "DELETE",
      });
      load();
    });
    li.appendChild(remove);
    list.appendChild(li);
  });
}

load();
setInterval(load, 5000);
