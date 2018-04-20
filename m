Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from w2.tutanota.de ([81.3.6.163]:49018 "EHLO w2.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755318AbeDTPsT (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 20 Apr 2018 11:48:19 -0400
Received: from w1.tutanota.de (unknown [192.168.1.162])
        by w2.tutanota.de (Postfix) with ESMTP id B054BC63874
        for <linux-modules@vger.kernel.org>; Fri, 20 Apr 2018 15:48:17 +0000 (UTC)
Date: Fri, 20 Apr 2018 17:48:17 +0200 (CEST)
From: <stack@tutamail.com>
To: Linux Modules <linux-modules@vger.kernel.org>
Message-ID: <LAYjT_a--3-0@tutamail.com>
Subject: modprobe man page
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Greetings,
I would like to report a correction for the modprobe man page:
https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/man/modprobe.xml <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/man/modprobe.xml>

Under the "force-vermagic" option it says "so this using option is dangerous". I believe that should read "so using this option is dangerous". Especially as the corrected phrasing is used several times elsewhere in the document.

Thanks!
~Stack~
