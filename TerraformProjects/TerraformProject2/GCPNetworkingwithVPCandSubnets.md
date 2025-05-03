# Terraform Project 2: GCP Networking with VPC and Subnets

## Concept Focus: Resource Dependencies and Networking

### What is this project about?
This project focuses on creating the foundation of cloud networking in GCP using Terraform. You'll create a custom Virtual Private Cloud (VPC) with public and private subnets, firewall rules, and a NAT gateway. This represents the networking foundation upon which most cloud infrastructures are built.

### Why are these concepts important?
Network infrastructure is critical because:
- It defines the security boundaries for your applications
- Proper network segmentation is a fundamental security practice
- Public/private subnet separation allows for controlled internet access
- Understanding resource dependencies in Terraform prevents creation ordering issues

Most cloud security breaches involve network misconfigurations, making this knowledge essential for any cloud engineer.

### Real-world application
In enterprise environments, network infrastructure is typically:
- Designed once and reused across multiple projects
- Structured with clear separation between internet-facing and internal resources
- Subject to strict security and compliance requirements
- The foundation that supports all other infrastructure components

### Project Components

#### 1. VPC Network
The Virtual Private Cloud (VPC) is a logically isolated section of GCP where you can launch resources in a virtual network that you define. Think of it as your own private data center in the cloud.

```
Key concepts:
- Custom mode VPCs vs auto mode
- Global vs regional resources in GCP
- Network definition and attributes
```

#### 2. Subnets
Subnets are subdivisions of your VPC network. They allow you to segment your network into smaller, more manageable pieces and control traffic flow between them.

```
Key subnet concepts:
- Public vs private subnets
- CIDR notation and IP addressing
- Regional deployment
- Private Google access
```

#### 3. Firewall Rules
Firewall rules control what traffic is allowed to flow between your subnets and to/from external networks. They are essential for securing your infrastructure.

```
Key firewall concepts:
- Ingress vs egress rules
- Source and destination filtering
- Protocol and port specification
- Service account association
```

#### 4. Cloud Router and NAT Gateway
These components allow resources in private subnets to access the internet without having public IP addresses assigned to them, maintaining security while providing necessary connectivity.

```
Key NAT concepts:
- Outbound-only connectivity
- IP allocation methods
- Subnet selection
```

#### 5. Resource Dependencies
In Terraform, resources often depend on other resources. Understanding how to properly express these dependencies ensures resources are created in the correct order.

```
Key dependency concepts:
- Implicit vs explicit dependencies
- Reference expressions
- Dependency graphs
```

### Learning Goals
After completing this project, you should be able to:
- Design and implement a custom VPC network in GCP
- Create and configure public and private subnets
- Understand CIDR notation and IP address allocation
- Implement appropriate firewall rules for network security
- Configure NAT for private instances to access the internet
- Manage resource dependencies in Terraform

### Common Mistakes to Avoid
1. **Overlapping CIDR ranges**: Ensure subnet ranges don't overlap with each other or with other networks you might connect to later
2. **Too permissive firewall rules**: Follow the principle of least privilege when defining firewall access
3. **Forgetting egress rules**: Consider both incoming and outgoing traffic when setting up firewalls
4. **Missing NAT for private subnets**: Private instances need NAT to access the internet for updates and dependencies
5. **Ignoring Private Google Access**: This is essential for private instances to access GCP APIs and services

### Ways to Extend This Project
1. **Multi-region deployment**: Extend your network design to span multiple GCP regions for high availability
2. **VPC peering**: Set up VPC peering between multiple networks to allow private communication
3. **Advanced routing**: Implement custom routes between subnets or to on-premises networks

### How This Maps to Larger Projects
In production environments, networking is the foundation on which all other resources are built:
- Application infrastructure is deployed into specific subnets based on security requirements
- Microservices are often separated into different network segments
- Database systems typically reside in private subnets with strict access controls
- Network design directly impacts compliance with regulations like PCI-DSS, HIPAA, or SOC2

The network architecture decisions you make at the beginning of a project can be difficult to change later, making it one of the most important aspects of infrastructure design.