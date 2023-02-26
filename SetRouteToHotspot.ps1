# SetRouteToHotspot 
# Set a Route using shared network by phone hotspot

# Variable for phone network adapter and DCHP IP range, modify to use of other phone
# phone adapter name ,String , can use wildcard(*) to filter, e.g: *SAMSUNG*
# use "Get-NetAdapter" command and use string in InterdaceDescription
$AdapterName = "*SAMSUNG*"

# RouteToUseSharedNetwork: String, use IPV4/mask, used for add route
$RouteToUseSharedNetwork = "172.20.0.0/16"

# SharedNetworkGetway: String, can use wildcard(*), e.g: 192.168.*, used for setting nexthop
$SharedNetworkGetway = "192.168.*"


# Start of program

Write-Output "Remove old or deprecated route for $RouteToUseSharedNetwork..."
Write-Output ""

$oldRouteExist = Get-NetRoute | Select-Object DestinationPrefix | Select-String $RouteToUseSharedNetwork
if ( $oldRouteExist ){
	try {
		Write-Output "Now Remove the route: $oldRouteExist"
		Write-Output ""
		Remove-NetRoute -DestinationPrefix $RouteToUseSharedNetwork -Confirm:$False
	}
	catch {
		Write-Output "Something threw an exception"
		Write-Output $_
		Read-Host -Prompt "Press Enter to exit"
		return
	}
}

# Get Samsung network interface information

Write-Output "Getting Information of adapter: $AdapterName..."
Write-Output ""

try {
	$ifIndex = Get-NetAdapter -InterfaceDescription $AdapterName | Select-Object -ExpandProperty 'ifIndex'
	$phoneRouteGetway = Get-NetRoute -ifIndex $ifIndex -NextHop $SharedNetworkGetway | Select-Object -ExpandProperty "Nexthop"

	if (!$ifIndex) {
		Write-Output "Cannot find out adapter interface information:$AdapterName. Not plug in or network not shared?"
		Write-Output "Check network sharing configuration on device and try again"
		Read-Host -Prompt "Press Enter to exit"
		return
	}
	
}
catch {
	Write-Output "Something threw an exception"
	Write-Output $_
	return
	Read-Host -Prompt "Press Enter to exit"
}

Write-Output "interface index number of adapter:$AdapterName : $ifIndex\n"
Write-Output "getway: $phoneRouteGetway"
Write-Output ""
# Set new route and change metric, dest:0.0.0.0/0 use new route with low priority

try {
	New-NetRoute -DestinationPrefix $RouteToUseSharedNetwork -NextHop $phoneRouteGetway -InterfaceIndex $ifIndex -RouteMetric 25
	Set-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop $phoneRouteGetway -InterfaceIndex $ifIndex -RouteMetric 100
}
catch {
	<#Do this if a terminating exception happens#>
	Write-Output "Something threw an exception"
	Write-Output $_
	Read-Host -Prompt "Press Enter to exit"
	return
}
Read-Host -Prompt "Press Enter to exit"

