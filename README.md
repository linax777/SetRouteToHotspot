# Set Route To Hotsop

## Purpose

Windows Powershell script to set new ip route using shared network by mobile phone hotspot.

## TOC

- [Set Route To Hotsop](#set-route-to-hotsop)
  - [Purpose](#purpose)
  - [TOC](#toc)
  - [Document Tree](#document-tree)
  - [How to use](#how-to-use)
  - [Version History](#version-history)
    - [2023-02-26 (V1.0)](#2023-02-26-v10)

## Document Tree

```text
.
├── SetRouteToHotspot.ps1
└── README.md
```

## How to use

1. Run Powershell, use "Get-NetAdapter" command to see network adapter information

```Powershell

Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed
----                      --------------------                    ------- ------       ----------             ---------
藍牙網路連線 5            Bluetooth Device (Personal Area Ne...#5      21 Disconnected ??-??-??-??-??-??         3 Mbps
乙太網路 3                SAMSUNG Mobile USB Remote NDIS Net...#2      18 Up           ??-??-??-??-??-??     426.0 Mbps
區域連線                  Xbox Wireless Adapter for Windows            12 Up           ??-??-??-??-??-??       150 Mbps
VirtualBox Host-Only Net… VirtualBox Host-Only Ethernet Adapter         9 Up           ??-??-??-??-??-??         1 Gbps
乙太網路                  Intel(R) I211 Gigabit Network Connecti…       3 Up           ??-??-??-??-??-??         1 Gbps

```

1. Modify below variable in SetRouteToHotspot.ps1 to fit your requirement:
   - $AdapterName - string in InterfaceDescription of above command output, can use wildcard(\*) to filter, e.g: \*SAMSUNG\*
   - $RouteToUseSharedNetwork -  String, use IPV4/mask, used for add route. e.g. "172.20.0.0/16"
   - $SharedNetworkGetway - can use wildcard(\*), e.g: 192.168.\*, used for setting nexthop

2. Run this script use Powershell (run as adiministrator)

```Powershell
.\SetRouteToHotspot.ps1
```

## Version History

### 2023-02-26 (V1.0)

First release
