Return-Path: <SRS0=0d5+=TU=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939CCC04AAC
	for <linux-modules@archiver.kernel.org>; Mon, 20 May 2019 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694712171F
	for <linux-modules@archiver.kernel.org>; Mon, 20 May 2019 15:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvYHTfKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfETPx5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 May 2019 11:53:57 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36951 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbfETPx4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 May 2019 11:53:56 -0400
Received: by mail-yb1-f196.google.com with SMTP id z12so337152ybr.4
        for <linux-modules@vger.kernel.org>; Mon, 20 May 2019 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=lmIaqHe3kJEae4ZT8Ci6rQjATn9jbGR5o+lwM4qbbGc=;
        b=NvYHTfKN8omqOXAtZ9o1Eo+ASQtzotGsym1ksb1PAhjmGrgyQXErFZycVpIci2INtK
         B1vr8GI1anaMJr6vvF7ctlc14ju/xWL1+7lC75u5GHcxw/GA8F4oogEnPeWvRgX1D4zB
         8j4CbZ/U4BPjcV0WyyHf4wZn+RMXMGkZZ668pbM0IXDgRAxxxmI+bTGbvPWJGnSQMqzg
         3nEbZkhmokw4sVJANhUtwrEi9u7ed+KXhHbAFl5WyXihu51IzHBg8UMtn5tKVGw7bejq
         gxYoQZW7PLeNlN+JqSeTaiQ8/cQ4RvZCrKaJzjAFMrwRTgZfcutBUkIlbBxp72B4+9qw
         e1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=lmIaqHe3kJEae4ZT8Ci6rQjATn9jbGR5o+lwM4qbbGc=;
        b=sjhDApkLrNurnj4hrNcIDSeblZtkwa04Y/LfFOuR0mpY0Mxg5b89kyEXf7ZQtN2B91
         OQkC22IwrB1+huIfrjJnaaiVSz+IhR5h5oWUWdXr6uMLWsWt0GDxnXJtzya1HHxsVhzQ
         rIW0IyvgGhorYKBo7pg8QI4Pc0l7rp1Sh7Q53SpjRvV9k0wi1RXya72tHi8PckfnGs7A
         tKHOCZGTTUSH5cXHXC9X2Em2NPS6Fusn8lSV5SkgFMf9uCWX33bdkrQu2xst5g0iAQtL
         pW+4K/W2v8f/8Az+nWaYj437JyJMcoXWvenf6pHRrKsH2a5dgee6st2QhFsKxBnZwGlc
         P7jQ==
X-Gm-Message-State: APjAAAW9e35A0mCRAD+4im1jUhxa6cUPRoz1nfIgtXbPh98ZVnmWXUce
        0RR8UmLD6vRtsC86tuB9/HnnY/np
X-Google-Smtp-Source: APXvYqwBE6IMFv1Ux/1uuGXUAti/W6cWBTIc3KrP/HqYwG4CzOEIemVA5Fkjq0bZJffg+Tpq8wEApQ==
X-Received: by 2002:a25:76d4:: with SMTP id r203mr35271349ybc.83.1558367635987;
        Mon, 20 May 2019 08:53:55 -0700 (PDT)
Received: from [172.26.16.3] ([76.229.134.243])
        by smtp.googlemail.com with ESMTPSA id f206sm5283520ywf.77.2019.05.20.08.53.54
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 08:53:55 -0700 (PDT)
To:     linux-modules@vger.kernel.org
From:   Brian Mason <brianmason386@gmail.com>
Subject: Documentation error in depmod.d.5
Message-ID: <aee4bc92-d34c-ff9f-2a86-f7b0c41c3d2f@gmail.com>
Date:   Mon, 20 May 2019 11:53:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello list,


I wasn't sure how to report this but I figured the mailing list was a
good bet.


In man/depmod.d.xml it says "/usr/lib/depmod.d" is one of the
directories depmod will check for configuration files, but
tools/depmod.c says "/lib/depmod.d" instead. I believe the sources are
correct and the documentation is in error because modprobe uses a
similar layout and its source and doc are consistent about
"/lib/modprobe.d".


Trivial fix but I'm sending a patch anyway!


Thanks,

Brian


diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 4341a56..602f72d 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -39,7 +39,7 @@
   </refnamediv>
 
   <refsynopsisdiv>
-    <para><filename>/usr/lib/depmod.d/*.conf</filename></para>
+    <para><filename>/lib/depmod.d/*.conf</filename></para>
     <para><filename>/etc/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
   </refsynopsisdiv>

