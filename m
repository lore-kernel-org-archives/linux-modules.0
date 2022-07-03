Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9206C43334
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 08:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiGCIdg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiGCIdf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 04:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7F06A18A
        for <linux-modules@vger.kernel.org>; Sun,  3 Jul 2022 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656837213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2agBExMK3C9mHR+WZLQeszR+IgajYWASmVgSqI4ZbE=;
        b=dmiHDn+FLkUJd+PxSJU4wU9hZDeWFOElTwQ3yw7WGv0002Kn3jQ4Hur4gRK3xivubN001q
        SHIElMv1d0eJ39gobQfus2Wa9jIPb00ytEBvE5/4TmgjGl23YQh2U4B0zlvTU41826ZDa9
        9CJOoi/JRQgIs3pDGSGqi+6FsfOjCA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-eq1f0l05MA2CMwxjdGCE_g-1; Sun, 03 Jul 2022 04:33:32 -0400
X-MC-Unique: eq1f0l05MA2CMwxjdGCE_g-1
Received: by mail-wm1-f70.google.com with SMTP id az40-20020a05600c602800b003a048edf007so2982616wmb.5
        for <linux-modules@vger.kernel.org>; Sun, 03 Jul 2022 01:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2agBExMK3C9mHR+WZLQeszR+IgajYWASmVgSqI4ZbE=;
        b=26le/d09zBUAs9C7FMeq/RPgRMxLdbZzAET5mPIMr5ISH8J8srGbVwblp+nrNuhDMC
         PmvuGcrKyduIqtZyI/OqPItd270G9QhpW8zdb2V16SkTj7xKCmHfBXnsyDIozAL9qTwk
         WJ4k0z4O/79c37wfaFz8sNaITOEXBYq14SrFKz2PVM8PAerS0SexPuTbQk8dQxWGp258
         KUwZOjFkII9TKUvNGxw/x33Y71Olu7fudNgAaWLUxrSqzlajbq9Sv0V7czDl6kn/OpJJ
         BMPtxRX56tUmHagxLOQ6++CmSezO8vK3B7YzVWD/GU/9leeJMVs/6UER3vqUoZe7fKqT
         MWfw==
X-Gm-Message-State: AJIora+wmwDrurMJFp9asjoj8xOs3iqndeptZAD2nMl/arZJAf/V0pEX
        X8P6zaBCL3Cp4An3MSM1TBv0zBez1xj2dMr+E1RN84qxtj+iiVd/JPh7uLeZ1DsHuH2hEzSvbua
        hOPshc6wYr/x9tzBX80mX3Wpd
X-Received: by 2002:a05:600c:4fd1:b0:3a0:5416:2fd0 with SMTP id o17-20020a05600c4fd100b003a054162fd0mr27386761wmq.197.1656837206540;
        Sun, 03 Jul 2022 01:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vI3d41GGsw6gayBQ1WEUA7lNU7AEm1R98SC0VYyiRBeJhUyUK8LvB+hE9pZUWPGMxmPmydZw==
X-Received: by 2002:a05:600c:4fd1:b0:3a0:5416:2fd0 with SMTP id o17-20020a05600c4fd100b003a054162fd0mr27386740wmq.197.1656837206324;
        Sun, 03 Jul 2022 01:33:26 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020d07d90b71sm26485519wrp.66.2022.07.03.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 01:33:25 -0700 (PDT)
Date:   Sun, 3 Jul 2022 09:33:24 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr92YtG12f+II+ea@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 2022-07-01 15:34 -0700, Luis Chamberlain wrote:
> Poke, did you get to implement this yet?

Hi Luis, Steve,

Firstly, apologies for the delay.

I believe I found the issue:

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1b0780e20aab..84808706af5c 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -197,7 +197,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
                            mod->kallsyms->typetab[i];
                        dst[ndst] = src[i];
                        dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-                       s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
+                       s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
                                     KSYM_NAME_LEN) + 1;
                }
        }

That being said, I need to examine the precise differences between each
implementation; albeit, I believe we can revert this particular change. I
will send a patch for a wider discussion shortly.

 - Before

      $ grep -a -E '^[0-9a-f]{16} [^a-z].*\[virtio_console\]' /proc/kallsyms
      0000000000000000  notifier_del_vio      [virtio_console]
      0000000000000000  show_port_name        [virtio_console]
      0000000000000000  port_debugfs_open     [virtio_console]

 - After the above modification

      $ grep -a -E '^[0-9a-f]{16} [^a-z].*\[virtio_console\]' /proc/kallsyms
      $ grep -a -m 3 -E '^[0-9a-f]{16} [a-z].*\[virtio_console\]' /proc/kallsyms
      0000000000000000 t notifier_del_vio     [virtio_console]
      0000000000000000 t show_port_name       [virtio_console]
      0000000000000000 t port_debugfs_open    [virtio_console]


Kind regards,

-- 
Aaron Tomlin

