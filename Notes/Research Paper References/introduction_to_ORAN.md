# 1 Introduction to O-RAN
* "Unlike tradional cellular networks, O-RAN is an open, programmable, interoperable, and virualized Radio Access Network (RAN) architecture that allows network operators to mix and match hardware and software components from different vendors."
* "O-RAN provides increased flexibility, scalability, and cost savings fro network operators.



## 1.1 Evolution of Cellular Technologies
* "The O-RAN specifications are developed by the O-RAN ALLIANCE and support 4G and 5G cellular communications.  As the cellular communication technologies evolve, O-RAN specifications can be augmented to support evolved cellular technologies."
* 1G was developed by Bell Labs in the 1970s.  These technologies were analog.
* Examples of 1G systems include Advanced Mobile Phone System (AMPS) in the United States, and NMT 500 and European Total Access Communication System (ETACS) in Europe.
* 1G provided voice services.
* 1G anaolog systems was replaced by 2G digital systems.
* Examples of 2G systems include Global Systems for Mobile Communication (GSM) and Interim Standard-95 (IS-95).
* These systems provided voice and low-rate data.
* 3G included services such as Universal Mobile Telecommunication System (UMTS) and UMTS enhancements such as High-Speed Downlink Packet Access and High-Speed Uplink Packet Access.
* 2G IS-95 systems evolved to 3G CDMA200 and 1xEV-DO systems.
* 3G peak data rates were a few megabits per second.
* 3G used two types of core networks:
  * Circuit-switched core network
    * Supported circuit-switched voice services
  * Packet-switched core netowrk
    * Supported Internet Protocol (IP)-based services like web browsing, video streaming, and e-mail.
* "4G LTE utilizes orthogonal frequency-division multiple access (OFDMA) on the radio interface.
* 4G uses a single type of core network called Evolved Packet Core (EPC).
* Since there is no cirrcuit-switched core network in LTE, voice calls are supported using Voice over IP (VoIP), or Voice over LTE (VoLTE).
* Supports tens of megabits per second.
* 5G is very flexible in its design.
* Supports ITU usage categories of enhanced mobile broadband (eMBB), ultra-reliable and low-latency communicaiton (URLLC), and massive Internet of Things (mIoT).
* "5G introduces network slicing, where different logical networks are created to meet diverse service and customer requirements using the same physical infrastructure.
* 6G is the first generation of cellular networks that emphasizes human and environmental rights as a requirement.
* 6G is expected to introduce native artificial intelligence (AI), Reflective Intelligent Surface (RIS), and higher frequency spectrum, such as sub-THz spectrum and THz spetrum.



## 1.2 Components of Cellular Systems
* The whole cellular system contains both wireless and wired components.
* A 5G system consists of the user equipment (UE), the 5G access network (AN), and the 5G core network (5GC or 5GCN).
* Various UEs include smartphones, Internet of Things (IoT) devices, smart watches, and augmented reality/virtual reality headsets.
* 5G access network may be 3GPP next-generation RAN (NG-RAN) or non-3GPP access networks.
* The NG-RAN may have next-genreation-Node Bs (gNBs) or next-generation-evolved Node Bs (ng-eNBs).
  * "The gNB communicates with 5G UEs using a New Radio (NR) air interface, while the ng-eNB communicates with UEs using the 4G LTE air interface."
  * Both gNB and ng-eNB connect to the 5GC, or the next-genreation core (NGC).
* "A 5G RAN can be defined as the RAN that utilizes the 5G NR air interface for communications with UEs."  
  * Thus 5G RAN is a subset of NG-RAN
* "A 5G UE exchanges Access Stratum (AS) signaling such as Radio Resource Control (RRC) signaling with the gNB in support of various RAN operations such as RRC connection setup, bearer setup for user traffic exchange, and handover."
* "A 5G UE exchanges Non-Access Stratum (NAS) signaling with the NGC in support of operations such as the registration, mutual authentication, security activiation, and protocol data unit (PDU) session setup."
* "The gNB transparaently transports the NAS signaling messages between the UE and the NGC."
* "A UE can connect to and exchange user traffic with data networks (DNs) such as the internet through the 5G AN and the NGC."
* "The 5G O-RAN represents one possible way of designing and deploying a 5G AN."
* "The O-RAN specifications utilize concepts such as disaggregation, openess, AI, and virtualization and cloud technologies."
* The UE nor the NGC need to be aware or do anything differently in order for the O-RAN to communicate with it.
* The O-RAN is compliant with the 3GPP-defined 5G RAN.



## 1.3 Evolution of the RAN
* The 3GPP has defined the logical architecutres for 3G, 4G, and 5G, where logical links between the network nodes, network elemetns, or network functions (NFs) are defined.
* "The 3GPP does not dictate or mandate any specific physical implementation or realization of the architecture."  Thus, the network operator has freedom in applying their own hardware and architecture.
* "The older generations of cellular technologies from 1G to 3G utilize the RAN architecture with centralized RAN controllers called Base Station Controllers (BSCs) or Radio Network Controllers (RNCs)."
* A BSC or RNC typpically controls hundreds of base stations (BSs) or Node Bs.
* "Certain radio resource management (RRM) tasks, such as the handover algorithm, are implemented at the BSC/RNC."
* The RAN consists of one or more BSCs and numerous BSs or Node Bs.
* "The BSs are distributed across the cellular service area."
* "In commercial deployments, it is common to divide a BS into two parts, a baseband unit (BBU) and a radio unit (RU).
* "An RU includes components such as radio frequency (RF) amplifiers and filters and is often situated next to the antenna that transmits and receives RF signals in support of wireless communications."
* "A BBU carries out technology-specific processing at the baseband."
* The BBU and RU can be connected via a RF cable or optical fiber to carry an analog signal.
* "Common Public Radio Interface (CPRI) is a widely used protocol between the BBU and the RU."
* "In a distributed RAN, BSs are distributed across the service area and a centralized RAN controller is absent."
* In this architecture, the BSs handle their own radio resources and can communicate with other BSs.
* "In a centralized RAN (C-RAN) approach, a set of BBUs is placed in a realitvely central data center and remote radio units (RRUs) or remote radio heads (RRHs) are placed at cell sites.
* This architecture is common in LTE networks.
* Benefits include cost/energy savings, real estate cost savings, and performance enhancements due to enhanced collaboration of radio resources across multiple cells.



### 1.3.1 Horizontal Disaggregation of RAN: A Protocol Perspective
* "A disaggregated RAN divides the BS into a central unit (CU) and a distributed unit (DU).
* 5G usually uses a distributed RAN.  However, the distribution of the BS into gNB-Cu and gNB-DU is still possible within this structure.
* Time-sensitive processing is carried out at the gNB-DU.
* Less time-sensitive processing is carried out at the gNB-CU.
* gNB-DUs are placed at cell sites.
* gNB-CUs are often in data centers (although they could also be placed at the cell site).
* The gNB-CU connects to other gNB-CUs and the NGC.
* The 3GPP also allows the decomposition of the gNB-CU into the gNB-CU-control plane (gNB-CU-CP) and the gNB-CU-user plane (gNB-CU-UP).
* "...the CU implements RRC, and PDCP protocols; the DU implements RLC, MAC, and selected PHY layer functions; and the RU implements selected PHY layer functions and the RF front end."
* There is also the software-defined networking SDN pricniples, which lead to the development of a software-defined RAN.
* Allows the use of programmatic API to support software-based control over the RAN UP pipeline.
* This programmatic API is commonly known as the RAN Intelligent Controller (RIC).
* "When the RAn components are implemented using suitable RAN component software (e.g. the gNB-CU software) on generic commercial-off-the-shelf (COTS) hardware, such RAN implementation is termed as virtualized RAN (vRAN)."
* Cloud resources could also be used to deploy a vRAN, known as a Cloud-RAN.



## 1.4 Introduction to the O-RAN ALLIANCE and the O-RAN Architecture
* "The O-RAN ALLIANCE is an operator-driven industry alliance that has defined the O-RAN architecture."



### 1.4.1 O-RAN ALLIANCE: A Brief Overview
* "The O-RAN ALLIANCE was founded in February 2018 by AT&T, China Mobile, Deutsche Telekom, NTT DOCOMO, and Orange."
* Today, the O-RAN ALLIANCE is made up of mobile network operators (MNOs), vendors, and research and academic institutions.
* "The mission of the O-RAN ALLIANCE is to "re-shape the RAN industry towards more intelligent, open, virtualized and fully interoperable mobile networks""
* "Open interfaces enable operators to build cost-effective and agile RAN through multivendor deploymnets in a more competitive RAN supplier ecosystem."
* "The use of open-source software and reference hardware designs can accelerate the pace of RAN innovations.  Intelligence is important to manage increasing complex RAN by minimizing human involvment, harnessing the power of AI/machine learning (ML), and automating netowkr operations."
* The three main focus streams of the O-RAN ALLIANCE include:
  * Specification efforts
  * Testing and Integration Efforts
  * O-RAN Softwarre Community (OSC)
* The O-RAN ALLIANCE has a board of 5 founding members and 10 elected members.
* Elections for the board members take place every two years.
* "The executive committee (EC) supports the board by proposing agendas, priorities, projects, and releases for the board to consider and approve."
* The EC consists of elected representatives based off the 5 founding members and two elected representatives from the board members.
* "The Technical Steering Committee (TSC) decides or gives guidance on O-RAN technical topics and approves O-RAN specifications prior to the Board approval and publication."
* "The TSC consists of member representatives and teh WG and focus group cocharis."



### 1.4.2 The O-RAN Architecture in a Nutshell
* 