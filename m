Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:33424 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbbIWKpd (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 23 Sep 2015 06:45:33 -0400
To: linux-modules@vger.kernel.org
Cc: linux-arm@vger.kernel.org
From: Alexander Holler <holler@ahsoftware.de>
Subject: depmod (kmod 21 and older) fails for allmodconfig on ARM
Message-ID: <560282C6.6050702@ahsoftware.de>
Date: Wed, 23 Sep 2015 12:45:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hello,

make allmodconfig
make -j4 zImage modules && make modules_install

fails here on an ARM system with a malloc bug in depmod (after finding 
some circles).

It seems to happen with older versions of kmod too, but I haven't found 
the time to search the problem (gdb doesn't help much and my glibc 
doesn't have debug symbols, so valgrind doesn't work).

Maybe someone here likes to go hunting.

Regards,

Alexander Holler
