# Kubernetes Project 4: Persistent Storage with PVs and PVCs

## Concept Focus: Volume Management and Data Persistence

### What is this project about?
This project introduces Kubernetes persistent storage concepts, focusing on PersistentVolumes (PVs) and PersistentVolumeClaims (PVCs). You'll learn how to create, manage, and use persistent storage to maintain data beyond the lifecycle of individual Pods. This is essential knowledge for running stateful applications in Kubernetes.

### Why are these concepts important?
Persistent storage is critical because:
- **Data Persistence**: Containers are ephemeral, but data often needs to persist
- **Stateful Applications**: Databases and other stateful apps require persistent storage
- **Storage Abstraction**: PVCs separate storage requests from implementation details
- **Dynamic Provisioning**: Storage can be automatically created based on requirements
- **Data Protection**: Storage lifecycle can be independent of application lifecycle
- **Storage Classes**: Different performance tiers can be offered for different needs

Without proper persistent storage, Kubernetes would be limited to stateless applications only.

### Real-world application
In production environments, persistent storage enables:
- Running databases and other stateful services in Kubernetes
- Maintaining critical data through application updates and restarts
- Implementing storage tiers for different performance and cost requirements
- Automating storage provisioning as part of application deployment
- Implementing backup and recovery strategies
- Supporting compliance requirements for data persistence

### Project Components

#### 1. PersistentVolume Basics
PersistentVolumes (PVs) are cluster resources that provide storage that can outlive any individual Pod.

```
Key PV concepts:
- Volume types (GCE PD, NFS, etc.)
- Capacity and access modes
- Reclaim policies
- Storage classes
- Volume lifecycle
```

#### 2. PersistentVolumeClaims
PersistentVolumeClaims (PVCs) are requests for storage by users that can be fulfilled by matching PVs.

```
Key PVC concepts:
- Storage requests and requirements
- Access mode specifications
- PV binding process
- Claim status and phases
- Volume expansion
```

#### 3. StorageClasses
StorageClasses define different tiers or types of storage with varying performance characteristics or policies.

```
Key StorageClass concepts:
- Provisioner configuration
- Parameters and options
- Default StorageClass
- Reclaim policies
- Volume binding modes
```

#### 4. Dynamic Provisioning
Dynamic provisioning allows storage volumes to be created on-demand when PVCs are created.

```
Key dynamic provisioning concepts:
- Provisioner selection
- Storage parameter configuration
- Claim matching
- GCP-specific storage options
- Provisioning failures
```

#### 5. Using Persistent Storage in Pods
Once provisioned, persistent storage needs to be mounted and used by Pods.

```
Key usage concepts:
- Volume mounts in Pod specs
- Mount paths and options
- ReadOnly vs ReadWrite access
- Multi-Pod access considerations
- Storage cleanup and lifecycle
```

### Learning Goals
After completing this project, you should be able to:
- Understand the difference between ephemeral and persistent storage
- Create and manage PersistentVolumes manually
- Request storage using PersistentVolumeClaims
- Configure StorageClasses for different storage requirements
- Implement dynamic provisioning for automatic storage creation
- Mount and use persistent storage in Pod configurations
- Understand storage reclamation and cleanup

### Common Mistakes to Avoid
1. **Access mode mismatches**: PVs and PVCs must have compatible access modes
2. **Ignoring reclaim policies**: Default policies may delete data unexpectedly
3. **Namespace confusion**: PVs are cluster-wide, but PVCs are namespaced
4. **Storage class assumptions**: Different environments may have different default storage classes
5. **Missing capacity requests**: PVCs must specify storage requirements
6. **Over-requesting storage**: Cloud storage often incurs costs based on requested size
7. **Ignoring backup requirements**: PVs don't automatically provide data backups

### Ways to Extend This Project
1. **Multi-writer volumes**: Explore volumes that support ReadWriteMany access modes
2. **Volume snapshots**: Implement backup and restore using volume snapshots
3. **Storage quotas**: Implement namespace quotas for storage resources

### How This Maps to Larger Projects
In production Kubernetes deployments:
- Storage is often a critical component of application architecture
- Different applications may require different storage classes
- Storage provisioning is integrated into deployment pipelines
- Backup and disaster recovery systems interact with persistent volumes
- Storage performance is a key factor in application performance
- Volume lifecycle management becomes part of operational processes

The persistent storage concepts you learn in this project are fundamental to running any stateful application in Kubernetes, from simple configuration stores to complex database systems. Understanding storage provisioning, access, and lifecycle management is essential for a complete Kubernetes skill set.