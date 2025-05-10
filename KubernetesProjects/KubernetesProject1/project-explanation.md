# Simple Explanations of Our Kubernetes Mini-Projects

## 1. basic-pod.yaml

**What**: This is our most basic pod - just a simple NGINX web server running in Kubernetes.

**Why**: It's like the "Hello World" of Kubernetes. It shows the minimum required to get an application running in a cluster.

**How**: We just defined a container using the NGINX image and told Kubernetes to run it. Super simple, but it shows how easy it is to deploy a container.

## 2. pod-with-probes.yaml

**What**: This pod adds health checks (liveness and readiness probes) and resource limits to our web server.

**Why**: Health checks make sure our application is actually working, not just running. Resource limits prevent one pod from hogging all the server's CPU and memory.

**How**: We added HTTP checks that ping the web server regularly. If the liveness check fails, Kubernetes restarts the container. If the readiness check fails, Kubernetes stops sending traffic to it until it recovers.

## 3. lifecycle-pod.yaml

**What**: This pod demonstrates how containers start, run, and restart when they fail.

**Why**: Understanding the lifecycle helps you debug problems and control how Kubernetes handles failures.

**How**: We created a pod that intentionally crashes after 10 seconds, then we set a restart policy to make Kubernetes restart it when it fails. This shows how Kubernetes provides self-healing for applications.

## 4. multi-container-pod.yaml

**What**: This pod runs two containers that work together - a web server and a content generator.

**Why**: Sometimes applications have multiple parts that need to work closely together. This pattern is perfect for sidecars, adapters, or tightly coupled components.

**How**: We created two containers in the same pod and gave them a shared volume to communicate. The content generator updates an HTML file every 30 seconds, and the web server serves that file. They work together like a team sharing the same workspace.

---

That's the essence of our mini-projects! We started with the bare minimum, added reliability with health checks, explored container lifecycle, and finished with a multi-container setup. Each one builds on the previous concept to show how Kubernetes helps run applications reliably.