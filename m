Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <505695E3.7040603@gmail.com>
Date: Sun, 16 Sep 2012 22:15:47 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@inai.de>
CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-modules <linux-modules@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hotplug <linux-hotplug@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 10
References: <CAMOw1v6MYW6O2f4AR9yRvh200j5R6mFTRqDT3TFbG-TjknmUmw@mail.gmail.com> <alpine.LNX.2.01.1209170427220.6182@nerf07.vanv.qr>
In-Reply-To: <alpine.LNX.2.01.1209170427220.6182@nerf07.vanv.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Jan Engelhardt wrote:
>
> On Thursday 2012-09-06 21:37, Lucas De Marchi wrote:
>>
>> kmod 10 is out:
>>
>> ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-10.tar.xz
>> ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-10.tar.sign
>
> make check fails here with glibc-2.15, gcc-4.7, x86_64,
> due to what seems to be duplicated symbols(?)

On my LFS system, glibc-2.16, gcc-4.7.1, x86_64, I do not see these errors:

./configure --prefix=/usr --bindir=/bin --libdir=/lib \
             --sysconfdir=/etc --with-xz --with-zlib
make
make check

==================
All 9 tests passed
==================

What is interesting is that if I run the checks again:

make check

I get:

TESTSUITE: running modprobe_softdep_loop, in forked context
TESTSUITE: ERR: rootfs 
/usr/src/kmod/kmod-10/testsuite/rootfs/test-modprobe/softdep-loop is 
dirty, please run 'make rootfs' before runnning this test
TESTSUITE: ERR: 'modprobe_softdep_loop' [16407] exited with return code 1
TESTSUITE: ERR: FAILED: modprobe_softdep_loop
FAIL: testsuite/test-modprobe

TESTSUITE: running test_insert, in forked context
TESTSUITE: ERR: rootfs /usr/src/kmod/kmod-10/testsuite/rootfs/test-init/ 
is dirty, please run 'make rootfs' before runnning this test
TESTSUITE: ERR: 'test_insert' [16373] exited with return code 1
TESTSUITE: ERR: FAILED: test_insert
FAIL: testsuite/test-init

==============================================
2 of 9 tests failed
Please report to linux-modules@vger.kernel.org
==============================================

'make rootfs' does not do anything but make distclean && configure && 
make && make check is clean for me.

   -- Bruce

