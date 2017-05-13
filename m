Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-modules@vger.kernel.org,  linux-kernel@vger.kernel.org,  Lucas De Marchi <lucas.de.marchi@gmail.com>,  Olof Johansson <olof@lixom.net>,  Heiko Stuebner <heiko@sntech.de>
Subject: Re: depmod gets stuck in symlink cycle in arch/arm/boot/dts/include
References: <20170512222307.GA9634@vader.DHCP.thefacebook.com>
Date: Sat, 13 May 2017 08:03:09 +0300
In-Reply-To: <20170512222307.GA9634@vader.DHCP.thefacebook.com> (Omar
	Sandoval's message of "Fri, 12 May 2017 15:23:07 -0700")
Message-ID: <xunyo9ux9wmq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Omar!

>>>>> On Fri, 12 May 2017 15:23:07 -0700, Omar Sandoval  wrote:

 > Hi,
 > Linux kernel commit 4027494ae6e3 ("ARM: dts: add arm/arm64 include
 > symlinks") introduced a couple of symlink cycles:

 > $ ls -al arch/arm{,64}/boot/dts/include
 > arch/arm64/boot/dts/include:
 > total 12
 > drwxr-xr-x 1 osandov users  38 May 11 14:01 .
 > drwxr-xr-x 1 osandov users 320 Jan 25 20:44 ..
 > lrwxrwxrwx 1 osandov users  24 May 11 14:01 arm -> ../../../../arm/boot/dts
 > lrwxrwxrwx 1 osandov users   2 May 11 14:01 arm64 -> ..
 > lrwxrwxrwx 1 osandov users 34 Nov 23 12:07 dt-bindings ->
 > ../../../../../include/dt-bindings

 > arch/arm/boot/dts/include:
 > total 12
 > drwxr-xr-x 1 osandov users    38 May 11 14:01 .
 > drwxr-xr-x 1 osandov users 63102 May 11 14:01 ..
 > lrwxrwxrwx 1 osandov users     2 May 11 14:01 arm -> ..
 > lrwxrwxrwx 1 osandov users    26 May 11 14:01 arm64 -> ../../../../arm64/boot/dts
 > lrwxrwxrwx 1 osandov users 34 Nov 23 12:07 dt-bindings ->
 > ../../../../../include/dt-bindings

 > On my system, /lib/modules/$(uname -r)/kernel is a symlink to
 > /lib/modules/$(uname -r)/build, which is my built linux.git. depmod
 > doesn't like these symlink cycles and ends up in an infinite loop.

 > Maybe I shouldn't be symlinking kernel to build like this, but depmod
 > shouldn't be getting stuck like this either. I wonder if anything else
 > is going to barf on these symlink cycles, too.

depmod checks for special names "build" and "source" to skip them.

I wonder if it worth to implement full symlink loop check.

-- 
WBR,
Yauheni Kaliuta
