// Client-side logic for the shared task server
const API_URL = "http://localhost:3000";
const form = document.getElementById("task-form");
const input = document.getElementById("task-input");
const list = document.getElementById("task-list");

let tasks = [];

async function load() {
  try {
    const res = await fetch(`${API_URL}/tasks`);
    if (!res.ok) throw new Error("Failed to load tasks");
    tasks = await res.json();
    render();
  } catch (err) {
    console.error(err);
  }
}

form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const text = input.value.trim();
  if (!text) return;
  try {
    const res = await fetch(`${API_URL}/tasks`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ text }),
    });
    if (!res.ok) throw new Error("Failed to add task");
    input.value = "";
    load();
  } catch (err) {
    console.error(err);
  }
});

function render() {
  list.innerHTML = "";
  tasks.forEach((task) => {
    const li = document.createElement("li");
    li.textContent = task.text;
    if (task.done) li.classList.add("done");
    li.addEventListener("click", async () => {
      try {
        const res = await fetch(`${API_URL}/tasks/${task.id}`, {
          method: "PUT",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ done: !task.done }),
        });
        if (!res.ok) throw new Error("Failed to toggle task");
        load();
      } catch (err) {
        console.error(err);
      }
    });
    const remove = document.createElement("button");
    remove.textContent = "\u2715";
    remove.addEventListener("click", async (e) => {
      e.stopPropagation();
      try {
        const res = await fetch(`${API_URL}/tasks/${task.id}`, {
          method: "DELETE",
        });
        if (!res.ok) throw new Error("Failed to remove task");
        load();
      } catch (err) {
        console.error(err);
      }
    });
    li.appendChild(remove);
    list.appendChild(li);
  });
}

load();
setInterval(load, 5000);
