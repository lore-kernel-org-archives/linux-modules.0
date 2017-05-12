Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 12 May 2017 15:23:07 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Olof Johansson <olof@lixom.net>, Heiko Stuebner <heiko@sntech.de>
Subject: depmod gets stuck in symlink cycle in arch/arm/boot/dts/include
Message-ID: <20170512222307.GA9634@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-modules.vger.kernel.org>

Hi,

Linux kernel commit 4027494ae6e3 ("ARM: dts: add arm/arm64 include
symlinks") introduced a couple of symlink cycles:

$ ls -al arch/arm{,64}/boot/dts/include
arch/arm64/boot/dts/include:
total 12
drwxr-xr-x 1 osandov users  38 May 11 14:01 .
drwxr-xr-x 1 osandov users 320 Jan 25 20:44 ..
lrwxrwxrwx 1 osandov users  24 May 11 14:01 arm -> ../../../../arm/boot/dts
lrwxrwxrwx 1 osandov users   2 May 11 14:01 arm64 -> ..
lrwxrwxrwx 1 osandov users  34 Nov 23 12:07 dt-bindings -> ../../../../../include/dt-bindings

arch/arm/boot/dts/include:
total 12
drwxr-xr-x 1 osandov users    38 May 11 14:01 .
drwxr-xr-x 1 osandov users 63102 May 11 14:01 ..
lrwxrwxrwx 1 osandov users     2 May 11 14:01 arm -> ..
lrwxrwxrwx 1 osandov users    26 May 11 14:01 arm64 -> ../../../../arm64/boot/dts
lrwxrwxrwx 1 osandov users    34 Nov 23 12:07 dt-bindings -> ../../../../../include/dt-bindings

On my system, /lib/modules/$(uname -r)/kernel is a symlink to
/lib/modules/$(uname -r)/build, which is my built linux.git. depmod
doesn't like these symlink cycles and ends up in an infinite loop.

Maybe I shouldn't be symlinking kernel to build like this, but depmod
shouldn't be getting stuck like this either. I wonder if anything else
is going to barf on these symlink cycles, too.
