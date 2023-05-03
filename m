Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8ECC77B75
	for <linux-modules@archiver.kernel.org>; Wed,  3 May 2023 17:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjECRm2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 3 May 2023 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjECRm1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 May 2023 13:42:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1E5BBC
        for <linux-modules@vger.kernel.org>; Wed,  3 May 2023 10:42:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b996127ec71so7977199276.0
        for <linux-modules@vger.kernel.org>; Wed, 03 May 2023 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683135744; x=1685727744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyWASKhXrRNVBOOq8h+mxQvWE1hyBqHS7EnIBAfoYzo=;
        b=lILby+6OTcd6uGew9Gqa7pI7NZDERobvBEoUxW0HhFyA1BRI3IbjTEpaxJY5cI5dqK
         DA1zSIWnr7NZMDeUF05eCVuGGh2CT9vrOAzryneu8JduHDYkP6FYutQNmyLESxSwuuGA
         QuyLAcoDwkidYgw1urIbr/7WmePlI+jjpkr/y8SQuG47YOMKyQjyUqQZLY1V6cSIQnsN
         gF8ibE844UGbtwqhvwKyiswwRZ5DNj7ChXG/ByW2u3EBE9OETY+04pa10/S8xbX8Bwfw
         LuAtgmQvuglHVzqT12ntCD4oe90ZORyd/+eYUAlMEp51urNfjxmt4VM8J4BfTDsPwJJU
         u65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135744; x=1685727744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyWASKhXrRNVBOOq8h+mxQvWE1hyBqHS7EnIBAfoYzo=;
        b=I0NgwyDDRaaUt2dCAuEQZYTGBv5zneJNdmcS96OsLBV6UhQhAs1iOOvwuH0NzrLLF3
         8NBWWH+OMm8gLcm+E6o6gowt4gWdOMB6l3jcDbbCaezv1+o7TNTa6jr0an9X07JQ8LaJ
         tnPbjA3UIdA8WzwJ56tTU09G6gjP4S+Sos77onW2/Nbkqta3Y2KjYO7rBO+us8uBTbEP
         KoMSCRyw/csVCJ9p12hDe7FfmOrSDJVXeRwaSYsEizueDGhAvSM5QIwR21ZBxy1mYuRX
         2I+CxyKSIIVPj7XoCCEtT3WFGjX0Vp2ZuPiA9yHKCJtvdQiUtjhrp4hGg8u7OgdRlXd8
         Q6nA==
X-Gm-Message-State: AC+VfDyqYreg3IrW+0B7hnaVmCa7G4MwG5zlpSUkgKBdZzgt7V5V4T/s
        5yl7uWWqdWUHf63M2RDioHbqeOvGQs9YL8XzN/Q4Rg==
X-Google-Smtp-Source: ACHHUZ6HYcPlZ5XV5ms52xY8zbnWoIv3zn5EqbRVrrcEPiOmdQ5uGEsqCqZVvbNEmhoG/dl+nd9SSzxveD8s4GLGz9w=
X-Received: by 2002:a25:b782:0:b0:b95:2bd5:8f86 with SMTP id
 n2-20020a25b782000000b00b952bd58f86mr19664721ybh.26.1683135743488; Wed, 03
 May 2023 10:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan> <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan> <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
In-Reply-To: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 10:42:11 -0700
Message-ID: <CAJuCfpEFV7ZB4pvnf6n0bVpTCDWCVQup9PtrHuAayrf3GrQskg@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Tejun Heo <tj@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev,
        rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, May 3, 2023 at 9:35=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Kent.
>
> On Wed, May 03, 2023 at 04:05:08AM -0400, Kent Overstreet wrote:
> > No, we're still waiting on the tracing people to _demonstrate_, not
> > claim, that this is at all possible in a comparable way with tracing.
>
> So, we (meta) happen to do stuff like this all the time in the fleet to h=
unt
> down tricky persistent problems like memory leaks, ref leaks, what-have-y=
ou.
> In recent kernels, with kprobe and BPF, our ability to debug these sorts =
of
> problems has improved a great deal. Below, I'm attaching a bcc script I u=
sed
> to hunt down, IIRC, a double vfree. It's not exactly for a leak but leaks
> can follow the same pattern.

Thanks for sharing, Tejun!

>
> There are of course some pros and cons to this approach:
>
> Pros:
>
> * The framework doesn't really have any runtime overhead, so we can have =
it
>   deployed in the entire fleet and debug wherever problem is.

Do you mean it has no runtime overhead when disabled?
If so, do you know what's the overhead when enabled? I want to
understand if that's truly a viable solution to track all allocations
(including slab) all the time.
Thanks,
Suren.

>
> * It's fully flexible and programmable which enables non-trivial filterin=
g
>   and summarizing to be done inside kernel w/ BPF as necessary, which is
>   pretty handy for tracking high frequency events.
>
> * BPF is pretty performant. Dedicated built-in kernel code can do better =
of
>   course but BPF's jit compiled code & its data structures are fast enoug=
h.
>   I don't remember any time this was a problem.
>
> Cons:
>
> * BPF has some learning curve. Also the fact that what it provides is a w=
ide
>   open field rather than something scoped out for a specific problem can
>   make it seem a bit daunting at the beginning.
>
> * Because tracking starts when the script starts running, it doesn't know
>   anything which has happened upto that point, so you gotta pay attention=
 to
>   handling e.g. handling frees which don't match allocs. It's kinda annoy=
ing
>   but not a huge problem usually. There are ways to build in BPF progs in=
to
>   the kernel and load it early but I haven't experiemnted with it yet
>   personally.
>
> I'm not necessarily against adding dedicated memory debugging mechanism b=
ut
> do wonder whether the extra benefits would be enough to justify the code =
and
> maintenance overhead.
>
> Oh, a bit of delta but for anyone who's more interested in debugging
> problems like this, while I tend to go for bcc
> (https://github.com/iovisor/bcc) for this sort of problems. Others prefer=
 to
> write against libbpf directly or use bpftrace
> (https://github.com/iovisor/bpftrace).
>
> Thanks.
>
> #!/usr/bin/env bcc-py
>
> import bcc
> import time
> import datetime
> import argparse
> import os
> import sys
> import errno
>
> description =3D """
> Record vmalloc/vfrees and trigger on unmatched vfree
> """
>
> bpf_source =3D """
> #include <uapi/linux/ptrace.h>
> #include <linux/vmalloc.h>
>
> struct vmalloc_rec {
>         unsigned long           ptr;
>         int                     last_alloc_stkid;
>         int                     last_free_stkid;
>         int                     this_stkid;
>         bool                    allocated;
> };
>
> BPF_STACK_TRACE(stacks, 8192);
> BPF_HASH(vmallocs, unsigned long, struct vmalloc_rec, 131072);
> BPF_ARRAY(dup_free, struct vmalloc_rec, 1);
>
> int kpret_vmalloc_node_range(struct pt_regs *ctx)
> {
>         unsigned long ptr =3D PT_REGS_RC(ctx);
>         uint32_t zkey =3D 0;
>         struct vmalloc_rec rec_init =3D { };
>         struct vmalloc_rec *rec;
>         int stkid;
>
>         if (!ptr)
>                 return 0;
>
>         stkid =3D stacks.get_stackid(ctx, 0);
>
>         rec_init.ptr =3D ptr;
>         rec_init.last_alloc_stkid =3D -1;
>         rec_init.last_free_stkid =3D -1;
>         rec_init.this_stkid =3D -1;
>
>         rec =3D vmallocs.lookup_or_init(&ptr, &rec_init);
>         rec->allocated =3D true;
>         rec->last_alloc_stkid =3D stkid;
>         return 0;
> }
>
> int kp_vfree(struct pt_regs *ctx, const void *addr)
> {
>         unsigned long ptr =3D (unsigned long)addr;
>         uint32_t zkey =3D 0;
>         struct vmalloc_rec rec_init =3D { };
>         struct vmalloc_rec *rec;
>         int stkid;
>
>         stkid =3D stacks.get_stackid(ctx, 0);
>
>         rec_init.ptr =3D ptr;
>         rec_init.last_alloc_stkid =3D -1;
>         rec_init.last_free_stkid =3D -1;
>         rec_init.this_stkid =3D -1;
>
>         rec =3D vmallocs.lookup_or_init(&ptr, &rec_init);
>         if (!rec->allocated && rec->last_alloc_stkid >=3D 0) {
>                 rec->this_stkid =3D stkid;
>                 dup_free.update(&zkey, rec);
>         }
>
>         rec->allocated =3D false;
>         rec->last_free_stkid =3D stkid;
>         return 0;
> }
> """
>
> bpf =3D bcc.BPF(text=3Dbpf_source)
> bpf.attach_kretprobe(event=3D"__vmalloc_node_range", fn_name=3D"kpret_vma=
lloc_node_range");
> bpf.attach_kprobe(event=3D"vfree", fn_name=3D"kp_vfree");
> bpf.attach_kprobe(event=3D"vfree_atomic", fn_name=3D"kp_vfree");
>
> stacks =3D bpf["stacks"]
> vmallocs =3D bpf["vmallocs"]
> dup_free =3D bpf["dup_free"]
> last_dup_free_ptr =3D dup_free[0].ptr
>
> def print_stack(stkid):
>     for addr in stacks.walk(stkid):
>         sym =3D bpf.ksym(addr)
>         print('  {}'.format(sym))
>
> def print_dup(dup):
>     print('allocated=3D{} ptr=3D{}'.format(dup.allocated, hex(dup.ptr)))
>     if (dup.last_alloc_stkid >=3D 0):
>         print('last_alloc_stack: ')
>         print_stack(dup.last_alloc_stkid)
>     if (dup.last_free_stkid >=3D 0):
>         print('last_free_stack: ')
>         print_stack(dup.last_free_stkid)
>     if (dup.this_stkid >=3D 0):
>         print('this_stack: ')
>         print_stack(dup.this_stkid)
>
> while True:
>     time.sleep(1)
>
>     if dup_free[0].ptr !=3D last_dup_free_ptr:
>         print('\nDUP_FREE:')
>         print_dup(dup_free[0])
>         last_dup_free_ptr =3D dup_free[0].ptr
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
