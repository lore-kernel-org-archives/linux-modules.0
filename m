Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95EC433F5
	for <linux-modules@archiver.kernel.org>; Thu,  3 Mar 2022 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiCCPAl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCCPAk (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Mar 2022 10:00:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4EC14CCB8
        for <linux-modules@vger.kernel.org>; Thu,  3 Mar 2022 06:59:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j17so8337428wrc.0
        for <linux-modules@vger.kernel.org>; Thu, 03 Mar 2022 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNxMNrhC8hxbhlWJ6ODupu1+HNUrX3voNWdFu6lxXOA=;
        b=oVMw6jWiyYVEcfm/nYooZXG16phKkvUAL/Z5ODqDvwEfWHb2lbKABvUR5k+81VEkIe
         LMOwSPD+nxj0ZBLjeVgKdH+XzT/OC8Gbsqkn4k5ofDgqy2qca3HSQMkGy+9tweukADAn
         AFQrv9t/zslVKWirf5B5f2esn0L8MfMzLFGUjoe2AZpiVYTsibSx+IBcgbMcAyiSCq2I
         ELP3WCpTjEuhHXiTr9SM3KAQDhQrGalpAkhJ6v1ZmNTFFVqYv00QJSR7rWoZm4xmxiLd
         uZIO1MYIlGjdDnK+bqHC+SKu+7m4ZyvTJBPpAI056iPZA/XSf6Pvsqq9RCHue9QPLI01
         vfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNxMNrhC8hxbhlWJ6ODupu1+HNUrX3voNWdFu6lxXOA=;
        b=ZcuR2vmITldPctYFfC0rZ+j7clBHSqkvYkMS6BJPhWlT7n+TrEANTvIgoGhjPT3c0R
         MFIGDOSeQhnLOLjc+R84e1R2XQM6iHsiORcDAK1f/UlmubAx761F2c81/k3xav3SzSxb
         i9GSj3BQyK/Pw46pqa02WhtHs43EGu5kdQf5tHjm3JmHFB6pqLReLwJjrWm8h1Wg0tQo
         ceVu1d7AyvhKVhjrqeXJMwWrOB++O9X8NMqtagBc6lS2iCqAWr1EqTuKprPGNI3CzVne
         Ny+FA6xYc1vA/5FC/UtQ1EvFsRIpjlOy7XQ22B5ehHmVCxIV/xNhwcq8Q7Cz/RYwTznR
         yysA==
X-Gm-Message-State: AOAM533Ic92ku7VlBeN4f73erhZHoqTO9G6eREpxu3bFVWgPuSXUvc18
        +jMVsrl0nGfyDZe71KK7p2UQYg==
X-Google-Smtp-Source: ABdhPJx05mYM4sjB0FOVEW1Pa7DDwK8ny1KwoP/DgYLnmhoVXk7sB2d/Ouenui3Gq8IoOMULZvVUHQ==
X-Received: by 2002:adf:d1c9:0:b0:1ea:830d:f1b0 with SMTP id b9-20020adfd1c9000000b001ea830df1b0mr27232134wrd.522.1646319592535;
        Thu, 03 Mar 2022 06:59:52 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00380ee4a78fdsm3100578wmq.4.2022.03.03.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:59:51 -0800 (PST)
Date:   Thu, 3 Mar 2022 14:59:49 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220303145949.inaz2tecmfuek2hf@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDEmRf3X0fxSayK@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 03, 2022 at 05:37:29AM -0800, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 08:56:23PM +0000, Christophe Leroy wrote:
> > Do we really want to hide the 'struct list_head modules' from external 
> > world ?
> > 
> > Otherwise we could declare it in include/linux/module.h ?
> 
> I'd just move the trivial code that uses it from kernel/kdb/ to
> kernel/module/ as it is tied to module internals and just uses the
> KDB interfaces exposed to other parts of the kernel.

One of the best ways that we can common up code might be to dust
off some code I wrote a while back to display seq_files from
kdb.

The basic idea worked well enough but it often needs special
start/stop operatings to ensure the start meeds kdb's rather
odd locking restrictions. If there is a willingness for
something like the below to be included in the module code then we
could replace kdb_lsmod() with something that reused the code to
 format /proc/modules.


Daniel.


diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e159..ab43ee23cdba0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4664,7 +4664,33 @@ static int __init proc_modules_init(void)
        return 0;
 }
 module_init(proc_modules_init);
-#endif
+
+#ifdef CONFIG_KGDB_KDB
+static void *kdb_m_start(struct seq_file *m, loff_t *pos)
+{
+       static LIST_HEAD(empty);
+       struct list_head *modlist = &modules;
+
+       if (mutex_is_locked(&module_mutex)) {
+               pr_info("Cannot display module list because it is
locked\n");
+               modlist = empty;
+       }
+
+       return seq_list_start(modlist, *pos);
+}
+
+const struct seq_operations kdb_modules_seqops = {
+       .start  = kdb_m_start,
+       .next   = m_next,
+       .show   = m_show
+};
+#endif /* CONFIG_KGDB_KDB */
+
+/*
+ * TODO: Need to decide if it OK to disable kdb lsmod if
+ * !CONFIG_PROC_FS... but it probably is!
+ */
+#endif /* CONFIG_PROC_FS */
 
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned
long addr)
