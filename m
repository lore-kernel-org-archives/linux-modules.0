Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mutluit.com ([82.211.8.197]:40502 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933896AbeF1JmF (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jun 2018 05:42:05 -0400
Received: from [37.139.71.2] (ip4d16cd28.dynamic.kabel-deutschland.de [77.22.205.40]:59206)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:50025) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16F0C03> for <linux-modules@vger.kernel.org> from <um@mutluit.com>;
        Thu, 28 Jun 2018 11:33:49 +0200
To: linux-modules@vger.kernel.org
From: "U.Mutlu" <um@mutluit.com>
Subject: Diagnosing network module for missing link establishment (cxgb3,
 Chelsio T320)
Message-ID: <5B34AB7D.4000809@mutluit.com>
Date: Thu, 28 Jun 2018 11:33:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

I have got a pair of used old dual port 10GbE NICs (Chelsio T320
10GBASE-R RNIC (rev 3) PCI Express x4 MSI-X) with 2 modular
transceivers on board the 2 NICs (ie. these can be taken off
of the card for replacement etc.).

The problem is that the cards don't establish a link;
the green LEDs go off after a few seconds after loading
the driver named cxgb3, and there is no indication in the syslog
about any error.

The behavior is the same whether the transceivers are present
on the card or not; the drivers always load successfully.

In the kernel sources the driver is located under
drivers/net/ethernet/chelsio/cxgb3
(I haven't recompiled it; just using the stock kernel from Debian repo).

Below, the interfaces are eth4 and eth5.

There was just once a link, but it never happens again, and
such log entries about link are not happening since then:

Jun 27 13:06:09 c6-local vmunix: [  504.108102] cxgb3 0000:01:00.0 eth4: link 
up, 10Gbps, full-duplex
Jun 27 13:17:30 c6-local vmunix: [ 1185.450256] cxgb3 0000:01:00.0 eth4: link down

How can I diagnose and pinpoint what the reason is for not establishing a link?


The following is from a later reboot:

# dmesg | grep -i "Chelsio\|cxgb3\|eth[0-9]"
[    0.979800] cxgb3: Chelsio T3 Network Driver - version 1.1.5-ko
[    0.984162] r8169 0000:02:00.0 eth0: RTL8168evl/8111evl at 
0xffffc90000002000, 74:d4:35:92:72:1b, XID 0c900800 IRQ 43
[    0.984163] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes, tx 
checksumming: ko]
[    1.319780] cxgb3 0000:01:00.0: irq 55 for MSI/MSI-X
[    1.319785] cxgb3 0000:01:00.0: irq 56 for MSI/MSI-X
[    1.319788] cxgb3 0000:01:00.0: irq 57 for MSI/MSI-X
[    1.319791] cxgb3 0000:01:00.0: irq 58 for MSI/MSI-X
[    1.319794] cxgb3 0000:01:00.0: irq 59 for MSI/MSI-X
[    1.319797] cxgb3 0000:01:00.0: irq 60 for MSI/MSI-X
[    1.319799] cxgb3 0000:01:00.0: irq 61 for MSI/MSI-X
[    1.319803] cxgb3 0000:01:00.0: irq 62 for MSI/MSI-X
[    1.319805] cxgb3 0000:01:00.0: irq 63 for MSI/MSI-X
[    1.319828] cxgb3 0000:01:00.0: Port 0 using 4 queue sets.
[    1.319868] cxgb3 0000:01:00.0: Port 1 using 4 queue sets.
[    1.319909] cxgb3 0000:01:00.0 eth1: Chelsio T320 10GBASE-R RNIC (rev 3) 
PCI Express x8 MSI-X
[    1.319949] cxgb3: eth1: 128MB CM, 256MB PMTX, 256MB PMRX, S/N: PT37080022
[    1.319986] cxgb3 0000:01:00.0 eth2: Chelsio T320 10GBASE-R RNIC (rev 3) 
PCI Express x8 MSI-X
[    5.217529] systemd-udevd[384]: renamed network interface eth0 to eth3
[    5.342653] systemd-udevd[387]: renamed network interface eth2 to eth4
[    5.358663] systemd-udevd[383]: renamed network interface eth1 to eth5
[   11.563555] r8169 0000:02:00.0 eth3: link down
[   11.563668] r8169 0000:02:00.0 eth3: link down
[   13.917486] r8169 0000:02:00.0 eth3: link up


# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP 
mode DEFAULT group default qlen 1000
     link/ether 74:d4:35:92:72:1b brd ff:ff:ff:ff:ff:ff
3: eth5: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode 
DEFAULT group default qlen 1000
     link/ether 00:07:43:05:8b:16 brd ff:ff:ff:ff:ff:ff
4: eth4: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode 
DEFAULT group default qlen 1000
     link/ether 00:07:43:05:8b:17 brd ff:ff:ff:ff:ff:ff


# ethtool eth4
Settings for eth4:
     Supported ports: [ AUI FIBRE ]
     Supported link modes:   10000baseT/Full
     Supported pause frame use: No
     Supports auto-negotiation: No
     Advertised link modes:  Not reported
     Advertised pause frame use: No
     Advertised auto-negotiation: No
     Speed: Unknown!
     Duplex: Unknown! (255)
     Port: FIBRE
     PHYAD: 1
     Transceiver: external
     Auto-negotiation: off
     Supports Wake-on: d
     Wake-on: d
     Current message level: 0x000000ff (255)
                    drv probe link timer ifdown ifup rx_err tx_err
     Link detected: no


# ifconfig
...
eth4      Link encap:Ethernet  HWaddr 00:07:43:05:8b:17
           inet addr:192.168.50.4  Bcast:192.168.50.255  Mask:255.255.255.0
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
           Interrupt:18 Memory:fe811000-fe811fff

eth5      Link encap:Ethernet  HWaddr 00:07:43:05:8b:16
           inet addr:192.168.60.5  Bcast:192.168.60.255  Mask:255.255.255.0
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
           Interrupt:18 Memory:fe811000-fe811fff

(I also tried same network 192.168.50 for both, no difference in outcome)


Btw, can a link be established between the 2 transceiver ports on the same 
card? I think this should be possible, right?


Kernel: 3.16.0-4-amd64 (Debian v8 stock kernel)

-- 
Thx

