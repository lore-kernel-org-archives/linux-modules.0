Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726F0C433DB
	for <linux-modules@archiver.kernel.org>; Tue, 26 Jan 2021 06:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256A022A84
	for <linux-modules@archiver.kernel.org>; Tue, 26 Jan 2021 06:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbhAZGFB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:05:01 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:36717 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbhAYJV7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 25 Jan 2021 04:21:59 -0500
Received: by mail-ej1-f49.google.com with SMTP id l9so16977372ejx.3
        for <linux-modules@vger.kernel.org>; Mon, 25 Jan 2021 01:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SSHRHht94Aiu/OqQMGfXG9vW3xgxeKKkxAlJUFiLx9I=;
        b=SOaHlgGjwOIbARZj7lqaWHNtfI/hTcO/ThkGLBne/TyIaMXZb/cblu+AuwWhR6aOsl
         XtRVRjyEAfxNebzLk1WkV24VcX0iU3HFt9txmlI8ohKx6bqlVy5PYXLSQ6wtFzLAZpHj
         3aJJdOM4pilUHSAtaDfLX/8diEpwkf7hYwnl0Zd2sYoS5/vB5V+wir6Ybjxjp/Z1oS0h
         nbmUApJnYE4WayyKsBA2d2V1k3nKoXSXGSpfaspA8njES88c3fmK+1nHVnPCDc7g52Ju
         8ItT32rL5Nvm9nV14r/+XeIhI5/ZQark3NbXzL6Yn6kb7F6DIwQaeGxakaRusAouvpx5
         I1ag==
X-Gm-Message-State: AOAM531DvAnp9sO+qaunD7JhWw+WcvJ9L38b5DGyN3wJRgt1R2Ya2Dgi
        hqGVxishj0MURRb2+2frESHtCJBoDLc=
X-Google-Smtp-Source: ABdhPJwTxNSK1wlpBhNXnE1fwlh6qLLMoGGXCceueKQDfbXt9PuZKeE+itjXczE3Fv8mM1uEhlWm7g==
X-Received: by 2002:a17:906:1f8b:: with SMTP id t11mr622146ejr.224.1611564554669;
        Mon, 25 Jan 2021 00:49:14 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x17sm9861902edd.76.2021.01.25.00.49.13
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 00:49:13 -0800 (PST)
To:     linux-modules@vger.kernel.org
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: libkmod mishandles parameters re-quoted by grub2
Message-ID: <70f1ef6c-d016-de57-82a8-db9d9cc414ef@kernel.org>
Date:   Mon, 25 Jan 2021 09:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,

when one passes to the kernel a module parameter from grub2 such as:
   parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
the kernel receives:
   "parport.dyndbg=file drivers/parport/ieee1284_ops.c +mpf"
as grub2 handles quotes this way. It may be a bug in grub2, it was even 
tried to be fixed, but there is no all-cases-working fix yet:
   https://bugzilla.suse.com/show_bug.cgi?id=1181111#c10

The kernel parses the parameter correctly, though:
   parse_one: doing dyndbg params: parport.dyndbg='file 
drivers/parport/ieee1284_ops.c +mpf'

But libkmod doesn't. When parport is modprobe-d, this parameter is not 
passed to it.

kmod_config_parse_kcmdline ignores the parameter as:
   if (is_quoted) {
     /* don't consider a module until closing quotes */

I am not sure how to fix this, can someone look into it and make the 
parser similar to kernel's?

thanks,
-- 
js
suse labs
