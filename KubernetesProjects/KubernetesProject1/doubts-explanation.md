# Kubernetes Pod Basics and Health Checks
#kubectl port-forward multi-container-pod 8080:80

This README provides a comprehensive explanation of Kubernetes Pod networking, port configuration, and health probes (liveness and readiness).

## Pod IP Addresses

### What are Pod IP addresses?
When a Pod is created in Kubernetes, it receives its own unique IP address. In your case, the Pod received IP `10.42.0.9`.

### Private vs Public IP
- The Pod IP (10.42.0.9) is a **private IP address**
- It's only accessible within the Kubernetes cluster
- It's not directly accessible from the internet without additional configuration (like Services or Ingress)

### How Pod IPs are created
- Pod IPs are assigned by the **CNI (Container Network Interface)** plugin
- Common CNI plugins include Calico, Flannel, Weave Net, etc.
- The CNI plugin manages a pool of IP addresses and assigns them to Pods
- Each Pod gets a unique IP from this pool
- This IP is different from Docker's default networking, where containers often share the host's network

### Pod IP vs Node IP
- The Pod IP is separate from the Node (server) IP
- Each Pod has its own network namespace and unique IP address
- Pods on the same Node have different IP addresses
- This is referred to as "IP-per-Pod" model in Kubernetes

## Container Ports

### Understanding containerPort in Kubernetes
In your YAML file, you specified `containerPort: 80`. This:

- Is primarily for documentation purposes
- Tells Kubernetes that your application inside the container listens on this port
- Doesn't actually open any ports or create firewall rules
- Helps with service discovery and network policies

### Application, Docker Image, and Kubernetes

The port configuration follows this chain:

1. **Application Level**: The developer configures the application to listen on a specific port (e.g., NGINX listens on port 80)
2. **Docker Image Level**: When the Docker image is built, this port is often exposed using the `EXPOSE` instruction in the Dockerfile
3. **Kubernetes Level**: In the Pod definition, you document this port using `containerPort`

### Why Port 80?
- Port 80 is the standard port for HTTP web traffic
- NGINX is a web server that by default listens on port 80
- This configuration happens in the NGINX Docker image
- We're simply telling Kubernetes about this existing configuration

## Health Checks: Liveness and Readiness Probes

### The Purpose of Probes

**Liveness Probes**:
- Detect if an application is alive but unhealthy
- Check if an application is functioning correctly, not just running
- Provide Kubernetes with a way to restart containers when they're in a bad state
- Solve the problem of "zombie" processes that are running but not working

**Readiness Probes**:
- Detect if an application is ready to serve traffic
- Allow applications time to warm up before receiving requests
- Remove Pods from service load balancing when they're not ready
- Prevent users from experiencing errors during Pod startup or temporary issues

### How Probes Work

Both probes can use one of three mechanisms:
1. **HTTP GET**: Perform an HTTP GET request to a specified path
2. **TCP Socket**: Try to establish a TCP connection to a specified port
3. **Exec**: Execute a command inside the container and check its exit code

### Probe Configuration Parameters

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 15  # Wait before first check
  periodSeconds: 10        # Check every 10 seconds
  timeoutSeconds: 5        # Timeout for the probe
  failureThreshold: 3      # Restart after 3 failures
```

- **initialDelaySeconds**: Time to wait after container starts before checking
- **periodSeconds**: How often to perform the probe
- **timeoutSeconds**: How long to wait for a response before considering the probe failed
- **successThreshold**: Minimum consecutive successes required to be considered successful
- **failureThreshold**: Number of consecutive failures before taking action

### What Happens Without Probes?

**Without Liveness Probes**:
- Kubernetes only checks if the container process is running
- Applications can be in a broken state (deadlocked, out of memory) but Kubernetes won't know
- The Pod will continue to run and receive traffic even if the application isn't functioning properly

**Without Readiness Probes**:
- Kubernetes assumes the Pod is ready to receive traffic as soon as the container starts
- Applications that need time to initialize (load data, warm caches) will receive traffic before they're ready
- Users may experience errors during application startup

### Default Restart Behavior

Kubernetes does have a default restart policy for Pods: `restartPolicy: Always` (unless specified otherwise), but:
- It only triggers if the container process crashes completely (exits with non-zero code)
- It doesn't detect application-level problems (hanging, unresponsive, returning errors)
- Liveness probes provide application-aware health checking that the default policy cannot

### Probe Failure Consequences

**When a Liveness Probe Fails**:
1. Kubernetes records the failure
2. After `failureThreshold` consecutive failures, Kubernetes restarts the container
3. The restart is visible in `kubectl get pods` (RESTARTS column increases)
4. Events are recorded in the Pod's event log (`kubectl describe pod`)
5. Container is killed and restarted according to the restart policy

**When a Readiness Probe Fails**:
1. Kubernetes marks the Pod as not ready
2. The Pod is removed from Service endpoints (won't receive traffic)
3. The Pod shows as not ready in `kubectl get pods` (e.g., "0/1" in READY column)
4. The container is NOT restarted - it remains running but doesn't receive traffic
5. When the probe starts succeeding again, the Pod is added back to Service endpoints

### Debugging Probe Failures

When probes fail, you can find information in:

1. **Pod events**: 
   ```
   kubectl describe pod <pod-name>
   ```
   Look for events like "Liveness probe failed: HTTP probe failed with statuscode: 404"

2. **Container logs**: 
   ```
   kubectl logs <pod-name>
   ```
   May show application errors related to the failing health check

3. **Kubelet logs**: 
   These logs (on the node) may contain more details about the probe failures

### Best Practices for Probes

1. **Always use both probes** for production applications
2. **Set appropriate delays** - especially initialDelaySeconds based on your application startup time
3. **Make liveness probes lightweight** - they run frequently and shouldn't consume lots of resources
4. **Set readiness checks more strict than liveness** - a Pod that's alive but not ready should not receive traffic
5. **Start with longer timeouts** and tune based on application behavior
6. **Test failure scenarios** to ensure probes work as expected

## Common Commands for Working with Pods

```bash
# Get pod details
kubectl get pods
kubectl describe pod <pod-name>

# Check pod logs
kubectl logs <pod-name>

# Execute commands in the pod
kubectl exec -it <pod-name> -- /bin/bash

# Watch pod events in real-time
kubectl get pods -w

# Check events related to the pod
kubectl get events | grep <pod-name>
```

## Advanced Topics

### Multi-Container Pods
Pods can contain multiple containers that work together:
- **Sidecar Pattern**: Helper container enhances the main container (logging, monitoring)
- **Ambassador Pattern**: Proxy container handles external communication
- **Adapter Pattern**: Container transforms output to match expected format

### Init Containers
Containers that run and complete before app containers start:
- Useful for setup, migration, or dependency checks
- Run sequentially, in the order specified
- App containers only start when all init containers complete successfully

### Resource Management
Setting appropriate CPU and memory requests/limits:
- **Requests**: Minimum resources guaranteed to the container
- **Limits**: Maximum resources the container can use
- Affects scheduling, QoS, and pod eviction