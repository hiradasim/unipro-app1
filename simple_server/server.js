 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/simple_server/server.js
index 0000000000000000000000000000000000000000..fea5c2ad89e515e5578c2a4312f3b42e8c64a1e2 100644
--- a//dev/null
+++ b/simple_server/server.js
@@ -0,0 +1,102 @@
+const http = require("http");
+const fs = require("fs").promises;
+const url = require("url");
+
+const PORT = process.env.PORT || 3000;
+const DATA_FILE = __dirname + "/tasks.json";
+
+async function readTasks() {
+  try {
+    const data = await fs.readFile(DATA_FILE, "utf8");
+    return JSON.parse(data);
+  } catch (e) {
+    return [];
+  }
+}
+
+async function writeTasks(tasks) {
+  await fs.writeFile(DATA_FILE, JSON.stringify(tasks, null, 2));
+}
+
+function send(res, status, data) {
+  res.writeHead(status, {
+    "Content-Type": "application/json",
+    "Access-Control-Allow-Origin": "*",
+    "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",
+    "Access-Control-Allow-Headers": "Content-Type",
+  });
+  res.end(JSON.stringify(data));
+}
+
+const server = http.createServer(async (req, res) => {
+  const parsed = url.parse(req.url, true);
+  const method = req.method;
+
+  if (method === "OPTIONS") {
+    res.writeHead(204, {
+      "Access-Control-Allow-Origin": "*",
+      "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",
+      "Access-Control-Allow-Headers": "Content-Type",
+    });
+    return res.end();
+  }
+
+  if (parsed.pathname === "/tasks" && method === "GET") {
+    const tasks = await readTasks();
+    return send(res, 200, tasks);
+  }
+
+  if (parsed.pathname === "/tasks" && method === "POST") {
+    let body = "";
+    req.on("data", (chunk) => (body += chunk));
+    req.on("end", async () => {
+      const tasks = await readTasks();
+      const data = JSON.parse(body || "{}");
+      const task = {
+        id: Date.now().toString(),
+        text: data.text || "",
+        done: false,
+      };
+      tasks.push(task);
+      await writeTasks(tasks);
+      send(res, 200, task);
+    });
+    return;
+  }
+
+  const match = parsed.pathname.match(/^\/tasks\/(.+)$/);
+  if (match) {
+    const id = match[1];
+
+    if (method === "PUT") {
+      let body = "";
+      req.on("data", (chunk) => (body += chunk));
+      req.on("end", async () => {
+        const data = JSON.parse(body || "{}");
+        const tasks = await readTasks();
+        const task = tasks.find((t) => t.id === id);
+        if (!task) return send(res, 404, { error: "Not found" });
+        if (typeof data.done === "boolean") task.done = data.done;
+        if (typeof data.text === "string") task.text = data.text;
+        await writeTasks(tasks);
+        send(res, 200, task);
+      });
+      return;
+    }
+
+    if (method === "DELETE") {
+      const tasks = await readTasks();
+      const index = tasks.findIndex((t) => t.id === id);
+      if (index === -1) return send(res, 404, { error: "Not found" });
+      const [removed] = tasks.splice(index, 1);
+      await writeTasks(tasks);
+      return send(res, 200, removed);
+    }
+  }
+
+  send(res, 404, { error: "Not found" });
+});
+
+server.listen(PORT, () => {
+  console.log(`Server listening on http://localhost:${PORT}`);
+});
 
EOF
)