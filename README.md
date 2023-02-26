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

1. Modify below variable in SetRouteToHotspot.ps1 to fit your requirement:
   - $AdapterName
   - $RouteToUseSharedNetwork
   - $SharedNetworkGetway

2. Run this script use Powershell (run as adiministrator)

```Powershell
.\SetRouteToHotspot.ps1
```

## Version History

### 2023-02-26 (V1.0)

First release
