Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:51608 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbaJELDt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sun, 5 Oct 2014 07:03:49 -0400
Message-ID: <5431258D.3020904@web.de>
Date: Sun, 05 Oct 2014 13:03:41 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
CC: Hans de Goede <hdegoede@redhat.com>
Subject: uas module not loaded automatically
References: <54303DF6.4050203@web.de> <54310A74.3090404@redhat.com> <54310C04.5060008@web.de> <54310DF9.8070904@redhat.com> <54310FFF.10504@web.de> <543112A6.8070503@redhat.com> <543113FF.7050900@web.de> <54311549.4070808@redhat.com>
In-Reply-To: <54311549.4070808@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vPdwWPTVK2Hd1VdUTQ792QNS927As0Btc"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vPdwWPTVK2Hd1VdUTQ792QNS927As0Btc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm migrating this conversation over from LKML as it is probably a kmod
issue. I've just retried the scenario with kmod 18 (from OpenSUSE
Factory) and can still confirm it. Please see below for details.

On 2014-10-05 11:54, Hans de Goede wrote:
> Hi,
>=20
> On 10/05/2014 11:48 AM, Jan Kiszka wrote:
>> On 2014-10-05 11:43, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/05/2014 11:31 AM, Jan Kiszka wrote:
>>>> On 2014-10-05 11:23, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 10/05/2014 11:14 AM, Jan Kiszka wrote:
>>>>>> On 2014-10-05 11:08, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 10/04/2014 08:35 PM, Jan Kiszka wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> my Delock external USB drive stopped working after updating from=
 a
>>>>>>>> UAS-disabled distro kernel to latest 3.17-rc7 with UAS on. That =
UAS was
>>>>>>>> key became clear to me only after looking at storage_probe(): th=
e device
>>>>>>>> is ignored by usb-storage if it is UAS-capable. However, nothing=
 causes
>>>>>>>> uas.ko to be loaded when the drive is plugged here. How is this =
supposed
>>>>>>>> to work in the normal case?
>>>>>>>
>>>>>>> Is the uas.ko module installed, and was depmod run after installi=
ng it ?
>>>>>>
>>>>>> Definitely. Just retried after another depmod -a, and only modprob=
e uas
>>>>>> made it work.
>>>>>>
>>>>>>>
>>>>>>> uas.c has the following:
>>>>>>>
>>>>>>>         { USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, USB_SC_SCSI,=
 USB_PR_BULK) },
>>>>>>>         { USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, USB_SC_SCSI,=
 USB_PR_UAS) },
>>>>>>>
>>>>>>> Which should make it load automatically on your device.
>>>>>>
>>>>>> Should this match with what lsusb -v reports for the device?=20
>>>>>
>>>>> Yes, and it does, for both alt settings of your device:
>>>>>
>>>>>       bInterfaceClass         8 Mass Storage
>>>>>       bInterfaceSubClass      6 SCSI
>>>>>       bInterfaceProtocol     80 Bulk-Only
>>>>>
>>>>>       bInterfaceClass         8 Mass Storage
>>>>>       bInterfaceSubClass      6 SCSI
>>>>>       bInterfaceProtocol     98
>>>>>
>>>>> Where 98 =3D=3D USB_PR_UAS, seems you have an quite old lsusb if it=
 does not
>>>>
>>>> It says "007".
>>>>
>>>>> know that though. Could it be the rest of your userspace is old too=
, and is
>>>>> not smart enough to load all matching drivers, instead only loading=
 the first matching
>>>>> driver (which happens to be usb-storage) ?
>>>>
>>>> OpenSUSE 13.1, all updates installed. Which components are involved?=

>>>> udev - Version 208? Below is the udevadm monitor output.
>>>
>>> Hmm, that is not all that old, I would expect that to work.
>>>
>>> Here is how things "work" on my system:
>>>
>>> [hans@shalem ~]$ lsmod | grep uas
>>> uas                    22414  0
>>> usb_storage            65065  1 uas
>>> [hans@shalem ~]$ sudo rmmod uas
>>> [hans@shalem ~]$ lsmod | grep uas
>>> [hans@shalem ~]$ sudo modprobe usb:v174Cp5136d0100dc00dsc00dp00ic08is=
c06ip50in00
>>> [hans@shalem ~]$ lsmod | grep uas
>>> uas                    22414  0
>>> usb_storage            65065  1 uas
>>>
>>> So as you can see the modalias taken from your udev debug output caus=
es
>>> uas to get loaded, can you try the above ?
>>
>> That command sequence doesn't cause uas to be reloaded. Anything I nee=
d
>> to customize for my setup?
>=20
> Not that I know of, so this seems to be a modprobe issue, and this shou=
ld
> probably be taken to the relevant list for modprobe. Please put me in t=
he CC
> when you send a mail there, and you likely will want to include the out=
put
> of the above commands + the modinfo output for both uas and usb-storage=
=2E
>=20
>>
>>>
>>> Also what does "modinfo uas" say? For me it says:
>>>
>>> [hans@shalem ~]$ modinfo uas
>>> filename:       /lib/modules/3.17.0-rc6+/kernel/drivers/usb/storage/u=
as.ko
>>> author:         Hans de Goede <hdegoede@redhat.com>, Matthew Wilcox a=
nd Sarah Sharp
>>> license:        GPL
>>> alias:          usb:v*p*d*dc*dsc*dp*ic08isc06ip62in*
>>> alias:          usb:v*p*d*dc*dsc*dp*ic08isc06ip50in*
>>> alias:          usb:v174Cp5106d*dc*dsc*dp*ic*isc*ip*in*
>>> alias:          usb:v152Dp0567d*dc*dsc*dp*ic*isc*ip*in*
>>> alias:          usb:v0BC2pAB20d*dc*dsc*dp*ic*isc*ip*in*
>>> alias:          usb:v0BC2p3312d*dc*dsc*dp*ic*isc*ip*in*
>>> alias:          usb:v0BC2p2312d*dc*dsc*dp*ic*isc*ip*in*
>>> depends:        usb-storage
>>> vermagic:       3.17.0-rc6+ SMP mod_unload
>>> signer:         Magrathea: Glacier signing key
>>> sig_key:        9B:56:00:B2:C4:97:8D:4A:A9:B3:0B:54:32:F7:B7:B2:2F:3E=
:FB:D8
>>> sig_hashalgo:   sha256
>>>
>>> Note the alias-es with vendor and product ids are from quirks, and yo=
ur version
>>> will likely not have these. But the first 2 generic ones should be th=
ere, and
>>> match the modalias from the udev output.
>>
>> filename:       /lib/modules/3.17.0-rc7-homebrewed+/kernel/drivers/usb=
/storage/uas.ko
>> author:         Hans de Goede <hdegoede@redhat.com>, Matthew Wilcox an=
d Sarah Sharp
>> license:        GPL
>> srcversion:     597B27EF314ADC559827CBD
>> alias:          usb:v*p*d*dc*dsc*dp*ic08isc06ipAAin*
>> alias:          usb:v*p*d*dc*dsc*dp*ic08isc06ip62in*
>> alias:          usb:v*p*d*dc*dsc*dp*ic08isc06ip50in*
>> depends:        usb-storage
>> intree:         Y
>> vermagic:       3.17.0-rc7-homebrewed+ SMP preempt mod_unload modversi=
ons=20
>=20
> That looks good, so no idea why modprobe is not loading it.
>=20
> Regards,
>=20
> Hans
>=20
>=20

For reference, here is the lsusb -v of the device again (to prove that
it should match the alias):

Bus 002 Device 010: ID 174c:5136 ASMedia Technology Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x174c ASMedia Technology Inc.
  idProduct          0x5136
  bcdDevice            1.00
  iManufacturer           2 Delock
  iProduct                3 42514
  iSerial                 1 200000000CB4
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          121
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               36mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk-Only
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           4
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     98
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
        MaxStreams             16
        Data-in pipe (0x03)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
        MaxStreams             16
        Data-out pipe (0x04)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
        MaxStreams             16
        Status pipe (0x02)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
        Command pipe (0x01)
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           22
  bNumDeviceCaps          2
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat        2047 micro seconds
Device Status:     0x0001
  Self Powered

Thanks,
Jan


--vPdwWPTVK2Hd1VdUTQ792QNS927As0Btc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlQxJZEACgkQitSsb3rl5xQl5wCfbt1l+cLrcpJ9AfKcywzjSFWc
dKoAoJY7ZXPUXiak9x3yKppL8oZ48Yqw
=Qsaf
-----END PGP SIGNATURE-----

--vPdwWPTVK2Hd1VdUTQ792QNS927As0Btc--
