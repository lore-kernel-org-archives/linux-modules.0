Return-Path: <SRS0=VqPb=2K=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1DAC43603
	for <linux-modules@archiver.kernel.org>; Fri, 20 Dec 2019 18:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A3021655
	for <linux-modules@archiver.kernel.org>; Fri, 20 Dec 2019 18:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFgr38gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTSp3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:45:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46645 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTSp3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 20 Dec 2019 13:45:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so10329460wrl.13
        for <linux-modules@vger.kernel.org>; Fri, 20 Dec 2019 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eKJcDgvh7oFinozlgc0xm7rHfiW32G41hm5ruyUjTxw=;
        b=vFgr38gCGO3HXUPU4T93Lx71SJm4sAVseJbgJD4454/64mjEHmE6OBszPE2hVRILlx
         yPTlw3yaArh7wbciG0r5MahQztcgTRFvHoQw+V+JwJIskizaOB02j5wnAmIh47TvbaNN
         chPeXXQ0Gcyp/jfO7Hc9Sqpzdz7AxxA9p2GVSRyPt8i+NlYkazRU5N/sEwKA4/8Z+8zr
         BPBR1XB5FpFGCk8+sCEvSJPDnUo+qdPBJ+FNjUN7HsbUDRJNoUbU1H3bFLS/a70eYVCQ
         G3urf8PBzDXRzbcXeR+vejCCcpdILs4dvEghZs0al7Jm3iJqRrAb2FPKFN52QWt49RzY
         M6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eKJcDgvh7oFinozlgc0xm7rHfiW32G41hm5ruyUjTxw=;
        b=TbgaQt0Nm75Hr+EOuenz9xiKI3bxYgx2unTAO9QJ4YjIU9UfohOBWilZm1CbzNhoeD
         Kh61p9+6MA/pkzMUCGzox0jXhsJUW7QMRNbVk/F0lezUc15YzVDj4m20Eh3u6xGQ9K7p
         NQzz/d+NaHiSNHzjaON4n+4/zGL54jyZPgPmKEshoC7scpsyEVMqzu7p+94+XNDps1Jr
         s5sxtHPN9HkcNdN61IzeueBArKDyyR+QAxxoIOHVsxVcrs2Cbt1w8hz7X+eUGjrsT7I8
         a8UNnhVtE6rCWPdnVBrW7svqmax8pdayRiIxe1yJgpmQuX9QA5VKPNSp2ub0o87XsQos
         cEAQ==
X-Gm-Message-State: APjAAAU1iA5pXWyCa6IkTi8rCTYrgIzHXk25zojPfHEZ/gMJKhISRMr9
        ZSHIjKV5UNtwku++5o56+wQkwkiwPzQBKPXZtqwVMwRv
X-Google-Smtp-Source: APXvYqxdl7lEBSgJ3aqV+HqHzuF0v8KovRz0iiJBiqvDnG9HAz+wBiT0mwAcbe6quzuPNaUoOePJPBsKhB6MHmsrdSM=
X-Received: by 2002:a5d:4481:: with SMTP id j1mr17387791wrq.348.1576867526625;
 Fri, 20 Dec 2019 10:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20191108172524.468494-1-gladkov.alexey@gmail.com> <20191204152723.nnmumapusw5zeacl@comp-core-i7-2640m-0182e6>
In-Reply-To: <20191204152723.nnmumapusw5zeacl@comp-core-i7-2640m-0182e6>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 20 Dec 2019 10:45:09 -0800
Message-ID: <CAKi4VA+QrgGNWSKwZx5NFQWtFdF_M=6_V4_LrV7dEhqvncePdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add modules.builtin.modinfo support
To:     linux-modules <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Dec 4, 2019 at 7:27 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> On Fri, Nov 08, 2019 at 06:25:19PM +0100, Alexey Gladkov wrote:
> > The kernel since version v5.2-rc1 exports information about built-in
> > modules in the modules.builtin.modinfo. Now, kmod can show complete information
> > about the built-in modules as well as about external modules. Also kmod can
> > understand aliases of built-in modules.
> >
> > Before:
> >
> > $ modinfo block-major-9-1
> > modinfo: ERROR: Module block-major-9-1 not found.
> >
> > After:
> >
> > $ modinfo block-major-9-1
> > name:           md_mod
> > filename:       (builtin)
> > alias:          block-major-9-*
> > alias:          md
> > description:    MD RAID framework
> > license:        GPL
> > parm:           start_dirty_degraded:int
> > parm:           create_on_open:bool
> >
> > v2:
> >
> > * Don't use kmod_file() to parse modules.builtin.modinfo. Instead, parser reads
> > the file into the buffer by chunks, which reduces the amount of memory.
> >
> > Alexey Gladkov (4):
> >   libkmod: Add parser for modules.builtin.modinfo
> >   libkmod: Add function to get list of built-in modules
> >   Lookup aliases in the modules.builtin.modinfo
> >   modinfo: Show information about built-in modules
>
> ping.

sorry for the delay, it took me some time to go through it and review.

Applied,
thanks

Lucas De Marchi

>
> >  Makefile.am                |   1 +
> >  libkmod/libkmod-builtin.c  | 329 +++++++++++++++++++++++++++++++++++++
> >  libkmod/libkmod-internal.h |  10 ++
> >  libkmod/libkmod-module.c   |  73 +++++++-
> >  libkmod/libkmod.c          |  25 +++
> >  libkmod/libkmod.h          |   1 +
> >  tools/depmod.c             |  63 +++++++
> >  tools/modinfo.c            |  39 +++--
> >  8 files changed, 514 insertions(+), 27 deletions(-)
> >  create mode 100644 libkmod/libkmod-builtin.c
> >
> > --
> > 2.21.0
> >
>
> --
> Rgrds, legion
>


-- 
Lucas De Marchi
