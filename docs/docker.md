---
title: "Docker"
output: slidy_presentation
---


#The underlying technology

![architecture](architecture.svg)

#Containers and Namespaces

A __container__ is an isolated workspace, which is a collection of namespaces.

This provides a layer of isolation: each aspect of a container runs in its own namespace and does not have access outside it.

#Containers and Namespaces 2

* The pid namespace: Process isolation (PID: Process ID).
* The net namespace: Managing network interfaces (NET: Networking).
* The ipc namespace: Managing access to IPC resources (IPC: InterProcess Communication).
* The mnt namespace: Managing mount-points (MNT: Mount).
* The uts namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).

#Control groups

Docker Engine on Linux also makes use of another technology called cgroups or control groups. A key to running applications in isolation is to have them only use the resources you want. 

#Union file systems

Union file systems, or UnionFS, are file systems that operate by creating layers, making them very lightweight and fast.

A stack of file systems
