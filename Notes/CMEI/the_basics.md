# IT Sim vs OT Sim
* IT is information technology simulation. OT is operational technology simulation.
* Both are simulated in virtual machines within the Phenix architecture.
* IT
  * Focuses on virtualizing data and logical processes
* OT
  * Focuses on real-time control and physical physics of the real world
  * Require specilized simulation engines that utilize math and physics.


# IT
* Simulates business logic, data storage, and enterprise workflows
* VMs
  * Windows/Linux Servers
  * Active directory
  * Databases
  * Enterprise firewalls
* Network protocols
  * TCP/IP
  * HTTP/S
  * DNS
  * LDAP
  * SSH
* High software fidelity and logical accuracy
* Completely virtual/software-driven
* Uses VMware ESXi or Proxmox VE for standard framework
* Human centric
* Typical devices
  * Laptops
  * Smartphones
  * Printers
  * Email servers
  * Cloud databases



# OT
* Simulates real-time control loops and physical processes (temperature, pressure, flow)
* VMs
  * Virtual PLCs (vPLCs)
  * HMIs
  * SCADA servers
  * RTUs
  * Engineering workstations
* Network protocols
  * Modbus TCP
  * DNP3
  * EtherNet/IP
  * PROFINET
  * OPC UA
* Microsend-level dterminism and precise time synchronization
* Requires a physics engine or mathematical model (e.g MATLAB) to simulate phyiscal outcomes
* Uses virtualized sotware controllers (CODESYS Virtual Control or OpenPLC) running inside lightweight VMs or docker containers.
* Machine centric
* Typical Devices
  * Pumps
  * Motors
  * Robotic arms
  * Wind turbines
  * Electric grids



# The Bridge
* SCADA (Supervisory Control and Data Aquisition) servers and Human-Machine Interfaces (HMIs)
* These VMs bridge the gap between IT and OT.  
* Run using standard operating systems (like Windows) but communicate using industrial OT protocols




# Cyber Attacks Against IT/OT
* 
