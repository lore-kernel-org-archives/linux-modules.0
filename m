Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2DC3F6B0
	for <linux-modules@archiver.kernel.org>; Wed, 27 Jul 2022 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiG0SGK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Jul 2022 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbiG0SFo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Jul 2022 14:05:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BEFB89
        for <linux-modules@vger.kernel.org>; Wed, 27 Jul 2022 10:10:09 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A2EA3F147
        for <linux-modules@vger.kernel.org>; Wed, 27 Jul 2022 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658941808;
        bh=NfXH6hm4kgWIqx0lHEWq8VeginCP4cCI5Cn5JdXlLaM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZgIAA2O1EY70JkuafW2URjGlzv5b/K6qYASKnDwUeGYJZAZwOC9N64DeJe6HEg09W
         IePC6fA0bIJvHySu/3qQFTDz+/6Ng7wnlumI0rn0Ts81b6I+xjQnjc40AiLsIrqPnj
         C6Yi/1jOkgeCOCFkY5d2lSAcKtJjqf1BPJD+2+2BLUJtFLP8W0d+GMw6lkb2XmNkna
         4htvKxJ4DA6k3nMPAF6iTUl7UaXKZ2xNOXPdMcIuOK0MtYtXuLVnRe88muSE/SD2Fx
         69CTHB/jgsGcYrOb4Tw2BZwuAW/XeJgGD3Ng5m0PqX+AwnyKEbuvJGcU5J1izhzQ8x
         0oh0A7HhFUejw==
Received: by mail-ot1-f72.google.com with SMTP id 102-20020a9d04ef000000b0061c50a3c031so8969931otm.18
        for <linux-modules@vger.kernel.org>; Wed, 27 Jul 2022 10:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfXH6hm4kgWIqx0lHEWq8VeginCP4cCI5Cn5JdXlLaM=;
        b=uqG/VxWYu5y3AApBjnnkCnmQkDjeHznL0YymUoRvyX9kc3z3akTcmLpl7X7U5NnJ3s
         ZVxJNI3Ab6yRZBH25e/daLr1mzoS4M2IZ2pxYpicMuG8dAN2amPyCYHngMkabDy64Rx2
         4kGZNTQ8jCP+MfybeR5D4/8nzSyDW5McGAfudO5D8KAt+gVnwtnrj7DSs9Dm290dgjE0
         xzpnM94Pxl8M5NpJTpQjxafD/MnDYyG95EUHkh/UebDyQcO5c1lv4q8zl6hj69LOHJS4
         t3PjsiZVJeB5IHgx068tvQ47VaI5IV2OJL4zAYh6lRK47O5BonbfGjj7CbpMbCCHYwn0
         TeBg==
X-Gm-Message-State: AJIora9boy7JIJJVBlNs7XkKpxY4b7u7856hEExi5Vhhy9PpRCo0zMso
        wmUGrFKRW2G8dw2VOCidmmLIcPUAh1WnqsCoCJe4MKbnj59kpgzfKOjCmTNv4VWGZm5Vr8AHuni
        gNxMsQ4W4ZcLKSFJ8zRtR1FZRZtYRLlHIBzTsuZooRhEgSliTDzOLDVyTjP4=
X-Received: by 2002:a05:6870:33a5:b0:f5:febe:1b27 with SMTP id w37-20020a05687033a500b000f5febe1b27mr2482230oae.229.1658941805732;
        Wed, 27 Jul 2022 10:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFs8/+IsuCBrPeiaHAaQOq1C18vqr44g3q6xAFKThuVPaHngeo+zLgMOlOfj5HA0v7cyP6dgeCDdgi+1tvU2o=
X-Received: by 2002:a05:6870:33a5:b0:f5:febe:1b27 with SMTP id
 w37-20020a05687033a500b000f5febe1b27mr2482201oae.229.1658941805415; Wed, 27
 Jul 2022 10:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com> <CAK7LNAR=7zgOiqTD9okXfZXroFH1yagMFsRuq0G-z6OfSUPLQg@mail.gmail.com>
In-Reply-To: <CAK7LNAR=7zgOiqTD9okXfZXroFH1yagMFsRuq0G-z6OfSUPLQg@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 27 Jul 2022 14:09:53 -0300
Message-ID: <CAO9xwp2X+qOB4PNp-TAoqgwt-CJ68HXXgoHWb81=BsON0yK3Eg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Introduce "sysctl:" module aliases
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hey Masahiro,

Thanks for looking into this!

On Tue, Jul 26, 2022 at 6:04 AM Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
[...]
> > I have tested it on x86_64 with next-20220721, and it looks correct
> > ('modprobe sysctl:nf_conntrack_max' works; other aliases there; see bel=
ow).
[...]

> I see two locations for the "fib_multipath_hash_fields" parameter
> for example.
>
> #  find /proc/sys/ -name fib_multipath_hash_fields
> /proc/sys/net/ipv4/fib_multipath_hash_fields
> /proc/sys/net/ipv6/fib_multipath_hash_fields
>
>
> If I run
>
>    modprobe sysctl:fib_multipath_hash_fields
>
> Which one will be loaded, net/ipv4/sysctl_net_ipv4.c
> or ipv6/sysctl_net_ipv6.c ?
>
> Of course, IPv4 is always built-in, so ipv6.ko will be loaded in this cas=
e.
> But, let's think. The basename is not enough to identify
> which code resulted in that sysctl property.
> The PCI vendor/device ID is meant to be unique. That's the difference.
>
>
> You may argue the full path is globally unique, so
>
>   modprobe  sysctl:net/ipv6/fib_multipath_hash_fields
>
> should work, but that may not be so feasible to implement
> because not all file paths are static.
>
>
> On my machine:
>
> # find  /proc/sys  -name  forwarding
> /proc/sys/net/ipv4/conf/all/forwarding
> /proc/sys/net/ipv4/conf/br-22440b7735e7/forwarding
> /proc/sys/net/ipv4/conf/br-3e8284a56053/forwarding
> /proc/sys/net/ipv4/conf/br-9b27f0f9e130/forwarding
> /proc/sys/net/ipv4/conf/br-bc5fbfa838fc/forwarding
> /proc/sys/net/ipv4/conf/br-ca51e25e8af8/forwarding
> /proc/sys/net/ipv4/conf/default/forwarding
> /proc/sys/net/ipv4/conf/docker0/forwarding
> /proc/sys/net/ipv4/conf/lo/forwarding
> /proc/sys/net/ipv4/conf/lxcbr0/forwarding
> /proc/sys/net/ipv4/conf/veth6e3e4b8/forwarding
> /proc/sys/net/ipv4/conf/virbr0/forwarding
> /proc/sys/net/ipv4/conf/vpn0/forwarding
> /proc/sys/net/ipv4/conf/wlp0s20f3/forwarding
> /proc/sys/net/ipv6/conf/all/forwarding
> /proc/sys/net/ipv6/conf/br-22440b7735e7/forwarding
> /proc/sys/net/ipv6/conf/br-3e8284a56053/forwarding
> /proc/sys/net/ipv6/conf/br-9b27f0f9e130/forwarding
> /proc/sys/net/ipv6/conf/br-bc5fbfa838fc/forwarding
> /proc/sys/net/ipv6/conf/br-ca51e25e8af8/forwarding
> /proc/sys/net/ipv6/conf/default/forwarding
> /proc/sys/net/ipv6/conf/docker0/forwarding
> /proc/sys/net/ipv6/conf/lo/forwarding
> /proc/sys/net/ipv6/conf/lxcbr0/forwarding
> /proc/sys/net/ipv6/conf/veth6e3e4b8/forwarding
> /proc/sys/net/ipv6/conf/virbr0/forwarding
> /proc/sys/net/ipv6/conf/vpn0/forwarding
> /proc/sys/net/ipv6/conf/wlp0s20f3/forwarding
>
>
> I do not know how to do it correctly.

Good point. So, these are actually 2 similar, but subtly different cases.

1) Multiple sysctl entries with identical procname in the _same_
module (e.g., forwarding in either ipv4/ipv6).

This should be fine, as the same module is backing the entries.

2) Multiple sysctl entries with identical procname in _different_
modules (e.g., forwarding in both ipv4/ipv6).

This would load all the different modules, per modprobe's behavior.

Note that a similar case exists with PCI IDs too: alternative device driver=
s;
and a way is to define which module to choose/ignore, as in modprobe.d(5).
(e.g., alias a particular, duplicated sysctl entry to the chosen
module/ignored).

Sure enough, this isn't efficient, and a kernel-only approach is required.

I'd say it's possible to compromise with a wildcard (e.g., sysctl:*/procnam=
e),
so the user/tool knows it's not necessarily unique -- this can be done now.

For some uniqueness, I guess we could add the static parts of the path
(as you mentioned, not all parts of the path are static) in some field(s)
in the alias (similar to PCI IDs, as well), and introduce logic in modprobe
to match closer it multiple modules are found.

This would likely need some of the plumbing I mentioned below, between
the syscl register functions and module macros, I guess; so it'd be new.

But for an initial implementation, maybe the compromise above is fine?

(ie, that if only the basename or '*/basename' is specified you may get
more modules loaded (and will get the sysctl asked!), but that you can
configure appropriately with modprobe.d if needed.)

Thanks,
Mauricio



>
>
>
>
> >
> > I plan to test other archs by cross-building 'allmodconfig' and checkin=
g
> > the .mod.c files and modpost output (eg, warnings) for no changes at al=
l,
> > and nf_conntrack.mod.c for expected sysctl aliases. [based on feedback.=
]
> > (i.e., changes didn't break modpost, and ELF code works on other archs.=
)
> >
> > Happy to receive suggestions to improve test coverage and functionality=
.
> >
> > I didn't look much at auto-registration with modpost using the register
> > functions for sysctl, but it seems it would need plumbing, if possible.
> >
> > Let's see review/feedback on the basics first.
> >
> > thanks,
> > Mauricio
> >
> > ...
> >
> > Some context.
> >
> > Even though that issue might be expected and obvious, its consequences
> > sometimes are not.
> >
> > An example is the nf_conntrack_max value, that in busy gateways/routers
> > /cloud deployments can affect performance and functionality more subtly=
,
> > or even fill the kernel log non-stop with 'table full, dropping packet'=
,
> > if a value greater than the default value is not used.
> >
> > The current solution (workaround, arguably) for this is to include such
> > modules in /etc/modules (or in /etc/modules-load.d/*.conf with systemd)=
,
> > which loads them before an userspace tool (procps's sysctl or systemd's
> > systemd-sysctl{,.service}) runs, so /proc/sys/... exists when it runs.
> >
> > ...
> >
> > That is simple, indeed, but comes w/ technical debt. (ugly stuff warnin=
g!)
> >
> > Now there are many _different_ pieces of code that use the _same_ modul=
e
> > doing that (eg, deployment tools/scripts for openstack nova and neutron=
,
> > firewalls, and maybe more).
> >
> > And sometimes when components are split or deployed to different nodes
> > it turns out that in the next reboot we figure (through an issue) that
> > some component did set /etc/sysctl.conf but not /etc/modules.conf, or
> > relied in the ex-colocated component doing that.
> >
> > This has generated several one-off fixes at this point in some projects=
.
> > (I have submitted one of those, actually, a while ago.)
> >
> > Also, some of those fixes (or original code) put 'nf_conntrack_ipv{4,6}=
'
> > in /etc/modules, getting 'nf_conntrack' loaded via module dependencies
> > (maybe it was the right module for them at the time, for some reason).
> >
> > So, that component (or a colocated component) got nf_conntrack.ko too.
> >
> > *BUT* after an upgrade from Ubuntu 18.04 (4.15-based kernel) to 20.04
> > (5.4-based kernel), the nf_conntrack_ipv{4,6}.ko modules do not exist
> > anymore, and now nf_conntrack.ko is no longer loaded, and the sysctl
> > nf_conntrack_max is no longer applied. (Someone had to figure it out.)
> >
> > And now maybe we'd need release/kernel-version checks in scripts that
> > use the workaround of /etc/modules for /etc/sysctl.conf configuration.
> >
> > (Yes, it was ugly stuff.)
> >
> > ...
> >
> > Well, this last point seemed like "ok, that's enough; we can do better.=
"
> >
> > I'm not sure this approach is "better" in all reasons, but hopefully it
> > might help starting something that is. =F0=9F=99=8F
> >
> > cheers,
> > Mauricio
> >
> > ...
> >
> > Tests:
> >
> >     $ cat /proc/sys/kernel/modprobe_sysctl_alias
> >     1
> >
> >     $ cat /proc/sys/net/netfilter/nf_conntrack_max
> >     cat: /proc/sys/net/netfilter/nf_conntrack_max: No such file or dire=
ctory
> >
> >     $ lsmod | grep nf_conntrack
> >     $
> >
> >     $ sudo modprobe sysctl:nf_conntrack_max
> >
> >     $ cat /proc/sys/net/netfilter/nf_conntrack_max
> >     262144
> >
> >     $ lsmod | grep nf_conntrack
> >     nf_conntrack          110592  0
> >     nf_defrag_ipv6         20480  1 nf_conntrack
> >     nf_defrag_ipv4         16384  1 nf_conntrack
> >
> >     $ modinfo nf_conntrack | grep ^alias:
> >     alias:          nf_conntrack-10
> >     alias:          nf_conntrack-2
> >     alias:          ip_conntrack
> >     alias:          sysctl:nf_conntrack_icmpv6_timeout
> >     alias:          sysctl:nf_conntrack_icmp_timeout
> >     alias:          sysctl:nf_conntrack_udp_timeout_stream
> >     alias:          sysctl:nf_conntrack_udp_timeout
> >     alias:          sysctl:nf_conntrack_tcp_max_retrans
> >     alias:          sysctl:nf_conntrack_tcp_ignore_invalid_rst
> >     alias:          sysctl:nf_conntrack_tcp_be_liberal
> >     alias:          sysctl:nf_conntrack_tcp_loose
> >     alias:          sysctl:nf_conntrack_tcp_timeout_unacknowledged
> >     alias:          sysctl:nf_conntrack_tcp_timeout_max_retrans
> >     alias:          sysctl:nf_conntrack_tcp_timeout_close
> >     alias:          sysctl:nf_conntrack_tcp_timeout_time_wait
> >     alias:          sysctl:nf_conntrack_tcp_timeout_last_ack
> >     alias:          sysctl:nf_conntrack_tcp_timeout_close_wait
> >     alias:          sysctl:nf_conntrack_tcp_timeout_fin_wait
> >     alias:          sysctl:nf_conntrack_tcp_timeout_established
> >     alias:          sysctl:nf_conntrack_tcp_timeout_syn_recv
> >     alias:          sysctl:nf_conntrack_tcp_timeout_syn_sent
> >     alias:          sysctl:nf_conntrack_generic_timeout
> >     alias:          sysctl:nf_conntrack_helper
> >     alias:          sysctl:nf_conntrack_acct
> >     alias:          sysctl:nf_conntrack_expect_max
> >     alias:          sysctl:nf_conntrack_log_invalid
> >     alias:          sysctl:nf_conntrack_checksum
> >     alias:          sysctl:nf_conntrack_buckets
> >     alias:          sysctl:nf_conntrack_count
> >     alias:          sysctl:nf_conntrack_max
> >
> >     $ modinfo r8169 | grep ^alias:
> >     alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
> >     alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
> >     alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
> >     alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
> >     alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
> >     alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
> >     alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
> >     alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
> >     alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
> >     alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
> >     alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
> >
> > Mauricio Faria de Oliveira (6):
> >   modpost: factor out elf/arch-specific code from section_rel[a]()
> >   modpost: deduplicate section_rel[a]()
> >   sysctl, mod_devicetable: shadow struct ctl_table.procname for
> >     file2alias
> >   module, modpost: introduce support for MODULE_SYSCTL_TABLE
> >   netfilter: conntrack: use MODULE_SYSCTL_TABLE
> >   sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias
> >
> >  fs/proc/proc_sysctl.c                   |  27 ++++
> >  include/linux/mod_devicetable.h         |  25 ++++
> >  include/linux/module.h                  |   8 ++
> >  include/linux/sysctl.h                  |  11 +-
> >  kernel/sysctl.c                         |  10 ++
> >  net/netfilter/nf_conntrack_standalone.c |   4 +
> >  scripts/mod/devicetable-offsets.c       |   3 +
> >  scripts/mod/file2alias.c                | 111 +++++++++++++++
> >  scripts/mod/modpost.c                   | 178 +++++++++++++-----------
> >  scripts/mod/modpost.h                   |   3 +
> >  10 files changed, 296 insertions(+), 84 deletions(-)
> >
> > --
> > 2.25.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Mauricio Faria de Oliveira
