#!/bin/sh

ETH0_MAC=`ifconfig eth0 | grep HWaddr | cut -d':' -f2- | cut -d' ' -f4`
DEFAULT_SSID="owf2-$ETH0_MAC"

# Configure DHCP for guest network
uci set dhcp.public=dhcp
uci set dhcp.public.interface='public'
uci set dhcp.public.start='100'
uci set dhcp.public.limit='150'
uci set dhcp.public.leasetime='12h'

# Configure guest network
uci set network.public=interface
uci set network.public.ifname='public'
uci set network.public.force_link='1'
uci set network.public.type='bridge'
uci set network.public.proto='static'
uci set network.public.ipaddr='192.168.100.1'
uci set network.public.netmask='255.255.255.0'

# Configure guest WiFi
uci set wireless.public=wifi-iface
uci set wireless.public.device='radio0'
uci set wireless.public.mode='ap'
uci set wireless.public.network='public'
uci set wireless.public.ifname='public'
uci set wireless.public.ssid=`echo $DEFAULT_SSID`
uci set wireless.public.encryption='none'

uci commit
reload_config
