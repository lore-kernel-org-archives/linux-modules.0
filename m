Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:52851 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab3EEOzE (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sun, 5 May 2013 10:55:04 -0400
Received: from [192.168.0.7] ([94.218.198.212]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MNcIg-1Uf2ku24ba-007erb for
 <linux-modules@vger.kernel.org>; Sun, 05 May 2013 16:55:02 +0200
Subject: depmod difference between module-init-tools and kmod
From: Stefan Achatz <stefan_achatz@web.de>
To: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 05 May 2013 16:55:01 +0200
Message-ID: <1367765701.2383.11.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hello,

I'm writing kernel modules for usb peripheries that are in mainline kernel and
also available as external compileable package[1].

The external modules have the newest code before it gets into the next kernel,
also backported for older kernels. To distinguish between outdated kernel
included and newer external modules they have different names. The device
specific kernel internal modules are called hid-roccat-* whereas the external
ones are called just *. This way a blacklist can prohibit loading the internal
modules when the external are installed.

Nevertheless, having both, internal and external, modules installed leads to
double symbols. depmod from module-init-tools has no problem with that (some
of the last versions tested), where the variant from kmod has its problem (v5
up to v12 tested). I observed this using Fedora 18, which seems to be the first
distro that uses kmods depmod.

Some outputs of both depmods for comparison are further down this text.

My question: Should this behaviour be fixed in kmods depmod, or is there a
intended, perhaps more intelligent, way for me to do what I intend?

Thanks and have a nice day
Stefan

**** depmod from module-init-tools

$ grep roccat /lib/modules/$(uname -r)/modules.dep

kernel/drivers/hid/hid-roccat.ko:
kernel/drivers/hid/hid-roccat-common.ko:
kernel/drivers/hid/hid-roccat-arvo.ko: extra/roccat-common.ko extra/roccat.ko
kernel/drivers/hid/hid-roccat-isku.ko: extra/roccat-common.ko extra/roccat.ko
kernel/drivers/hid/hid-roccat-kone.ko: extra/roccat.ko
kernel/drivers/hid/hid-roccat-koneplus.ko: extra/roccat-common.ko extra/roccat.ko
kernel/drivers/hid/hid-roccat-kovaplus.ko: extra/roccat-common.ko extra/roccat.ko
kernel/drivers/hid/hid-roccat-lua.ko: extra/roccat-common.ko
kernel/drivers/hid/hid-roccat-pyra.ko: extra/roccat-common.ko extra/roccat.ko
kernel/drivers/hid/hid-roccat-savu.ko: extra/roccat-common.ko extra/roccat.ko
extra/koneplus.ko: extra/roccat-common.ko extra/roccat.ko
extra/roccat.ko:
extra/kone.ko: extra/roccat.ko
extra/pyra.ko: extra/roccat-common.ko extra/roccat.ko
extra/arvo.ko: extra/roccat-common.ko extra/roccat.ko
extra/kovaplus.ko: extra/roccat-common.ko extra/roccat.ko
extra/savu.ko: extra/roccat-common.ko extra/roccat.ko
extra/konepure.ko: extra/roccat-common.ko extra/roccat.ko
extra/isku.ko: extra/roccat-common.ko extra/roccat.ko
extra/roccat-common.ko:
extra/lua.ko: extra/roccat-common.ko

$ grep roccat /lib/modules/$(uname -r)/modules.symbols

alias symbol:roccat_connect roccat
alias symbol:roccat_connect hid_roccat
alias symbol:roccat_disconnect roccat
alias symbol:roccat_disconnect hid_roccat
alias symbol:roccat_common2_send roccat_common
alias symbol:roccat_common2_send hid_roccat_common
alias symbol:roccat_common2_receive roccat_common
alias symbol:roccat_common2_receive hid_roccat_common
alias symbol:roccat_common2_send_with_status roccat_common
alias symbol:roccat_common2_send_with_status hid_roccat_common
alias symbol:roccat_report_event roccat
alias symbol:roccat_report_event hid_roccat



* depmod from kmod

$ grep roccat /lib/modules/$(uname -r)/modules.dep

kernel/drivers/hid/hid-roccat.ko:
kernel/drivers/hid/hid-roccat-common.ko:
kernel/drivers/hid/hid-roccat-arvo.ko:
kernel/drivers/hid/hid-roccat-isku.ko:
kernel/drivers/hid/hid-roccat-kone.ko:
kernel/drivers/hid/hid-roccat-koneplus.ko:
kernel/drivers/hid/hid-roccat-kovaplus.ko:
kernel/drivers/hid/hid-roccat-lua.ko:
kernel/drivers/hid/hid-roccat-pyra.ko:
kernel/drivers/hid/hid-roccat-savu.ko:
extra/roccat.ko:
extra/roccat-common.ko:

$ grep roccat /lib/modules/$(uname -r)/modules.symbols

alias symbol:roccat_disconnect roccat
alias symbol:roccat_common2_receive roccat_common
alias symbol:roccat_report_event roccat
alias symbol:roccat_connect roccat
alias symbol:roccat_common2_send roccat_common
alias symbol:roccat_common2_send_with_status roccat_common



[1] http://sourceforge.net/projects/roccat/files/linux/kmod-roccat/kmod-roccat-0.8.2.tar.bz2/download




