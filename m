Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD6FC43219
	for <linux-modules@archiver.kernel.org>; Mon, 21 Feb 2022 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351327AbiBUJsu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:48:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352912AbiBUJsB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 21 Feb 2022 04:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9218624586
        for <linux-modules@vger.kernel.org>; Mon, 21 Feb 2022 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645435276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GumUOC/tpD4HU1sIpPheYV1+0ORIMlK0adifuiQaD2s=;
        b=E+MdTCx+dS7M7G6qyH+NczW2cPeNwD8rj5F0XFqtxjq9xERNerEP2cQckc+IVw/NXcB2dZ
        o8lPaxYeWdNTuo3JwcE4IXWfcUYVAd6lOiN9MmPOYMxB1dQzmOjYYXgwNUGMVbqKHTr2Oy
        vcYsUl5O4vVrnB+jlIzl6P6V73f9Xr8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-PJ6zAqDMMI2L6j7WtvM7Zw-1; Mon, 21 Feb 2022 04:21:15 -0500
X-MC-Unique: PJ6zAqDMMI2L6j7WtvM7Zw-1
Received: by mail-lf1-f71.google.com with SMTP id z37-20020a0565120c2500b004433b7d95d3so2367467lfu.4
        for <linux-modules@vger.kernel.org>; Mon, 21 Feb 2022 01:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GumUOC/tpD4HU1sIpPheYV1+0ORIMlK0adifuiQaD2s=;
        b=KR1Ox14kZkleikxBtcOFJtVUYZdaBK6x68weZaUVkjmCKeHQ5HuwVv42GKfnV4NNDG
         9B06jTHV3dHlRnpeWsMYxE/TeBQOLcl9Ipzi4+LKUDwUkHsjHlBWQrw3FoXLH8qSHxP/
         Iqf1EhCIXZRVUDOWEkfze5qGKgG6WhLXQ56xIHBs0UVs/mLofFO3vszw1ihTfD5xnRUi
         y90J7A2Hfnjl7+TiT6W0bfjZuvtx7sEaYA8TAYEVlDEZw3AwWBLmfNHBBitJboypjQcn
         /GYb1spIzT1u1oC/oEjwhM+hiqXUd6c6TAO94C0mKlZNYP78II7YvsM48nrAcdnmQnFC
         HwHA==
X-Gm-Message-State: AOAM5335Dv9nIst4sC/imfDMzyQTYS4ZnWfEYxHmTPh/EQOjDONDcKuy
        nDlINLp3awQTFcEFzD5LUjqbWCMRgWEx7kTUjvmz25NRj8h9kV0HJ9ekeuUfeA9G1vINw0bAnkM
        ARnLCed5WgeIlN9+1TjhqZSheLVe0lKy9KZzATxKm
X-Received: by 2002:a05:651c:386:b0:244:e2ab:87f9 with SMTP id e6-20020a05651c038600b00244e2ab87f9mr13464555ljp.201.1645435272754;
        Mon, 21 Feb 2022 01:21:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvHaDSK1yq/EJhp1HN5IPx788Jxxn4WG+3hHVeYtWFW+WKzEDLmnp+QQW9Oi3deV9rKkZ3Si1vrNu1O+WNJLA=
X-Received: by 2002:a05:651c:386:b0:244:e2ab:87f9 with SMTP id
 e6-20020a05651c038600b00244e2ab87f9mr13464535ljp.201.1645435272173; Mon, 21
 Feb 2022 01:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <20220218212511.887059-10-atomlin@redhat.com>
 <98cff67e-d2ca-705b-7c83-bd3f41df98d9@csgroup.eu>
In-Reply-To: <98cff67e-d2ca-705b-7c83-bd3f41df98d9@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Mon, 21 Feb 2022 09:21:00 +0000
Message-ID: <CANfR36gBNC0ZPJPAn2H04cOC+ztQdeBC19LzaF5hU2fhHqrr9A@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] module: Move kallsyms support into a separate file
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-02-21 08:15 +0000, Christophe Leroy wrote:
> [   36.421711] BUG: Unable to handle kernel data access on write at
> 0xbe79bb40
> [   36.428435] Faulting instruction address: 0xc008b74c
> [   36.433342] Oops: Kernel access of bad area, sig: 11 [#1]
> [   36.438672] BE PAGE_SIZE=16K PREEMPT CMPC885
> [   36.442947] SAF3000 DIE NOTIFICATION
> [   36.446421] Modules linked in:
> [   36.449436] CPU: 0 PID: 374 Comm: insmod Not tainted
> 5.17.0-rc4-s3k-dev-02274-g7d4ec8831803 #1016
> [   36.458211] NIP:  c008b74c LR: c00897ac CTR: c001145c
> [   36.463200] REGS: caf8bcf0 TRAP: 0300   Not tainted
> (5.17.0-rc4-s3k-dev-02274-g7d4ec8831803)
> [   36.471633] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 24002842  XER: 00000000
> [   36.478261] DAR: be79bb40 DSISR: c2000000
> [   36.478261] GPR00: c00899a0 caf8bdb0 c230a980 be74c000 caf8beb8
> 00000008 00000000 c035629c
> [   36.478261] GPR08: be75c000 caf9c9fc be79bb40 00000004 24002842
> 100d166a 00000290 00000000
> [   36.478261] GPR16: c0747320 caf9c9fc c11ff918 caf9b2a7 be75c290
> 00000550 00000022 c0747210
> [   36.478261] GPR24: c11ff8e8 be74c000 c11ff8fc 100b8820 00000000
> 00000000 be74c000 caf8beb8
> [   36.516729] NIP [c008b74c] add_kallsyms+0x48/0x30c
> [   36.521465] LR [c00897ac] load_module+0x16f8/0x2504
> [   36.526286] Call Trace:
> [   36.528693] [caf8bdb0] [00000208] 0x208 (unreliable)
> [   36.533598] [caf8bde0] [c00899a0] load_module+0x18ec/0x2504
> [   36.539107] [caf8beb0] [c008a7a8] sys_finit_module+0xb4/0xf8
> [   36.544700] [caf8bf30] [c00120a4] ret_from_syscall+0x0/0x28
> [   36.550209] --- interrupt: c00 at 0xfd5e7c0
> [   36.554339] NIP:  0fd5e7c0 LR: 100144e8 CTR: 10013238
> [   36.559331] REGS: caf8bf40 TRAP: 0c00   Not tainted
> (5.17.0-rc4-s3k-dev-02274-g7d4ec8831803)
> [   36.567763] MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 24002222  XER:
> 00000000
> [   36.574735]
> [   36.574735] GPR00: 00000161 7fc5a130 7792f4e0 00000003 100b8820
> 00000000 0fd4ded4 0000d032
> [   36.574735] GPR08: 00000000 10013238 00000000 00000002 142d2297
> 100d166a 100a0920 00000000
> [   36.574735] GPR16: 100cac0c 100b0000 1013c3cc 1013d685 100d0000
> 100d0000 00000000 100a0900
> [   36.574735] GPR24: ffffffa2 ffffffff 1013c3a4 00000003 1013c3cc
> 100b8820 1013c3f0 1013c3cc
> [   36.610535] NIP [0fd5e7c0] 0xfd5e7c0
> [   36.614065] LR [100144e8] 0x100144e8
> [   36.617593] --- interrupt: c00
> [   36.620609] Instruction dump:
> [   36.623534] 7c7e1b78 81040038 8124003c 81430100 55082036 7d0a4214
> 1d490028 81240010
> [   36.631365] 9103015c 7d295214 8109000c 8143015c <910a0000> 81290014
> 8143015c 5529e13e
> [   36.639376] ---[ end trace 0000000000000000 ]---

Hi Christophe,

Unfortunately, I do not have the debuginfo data. Albeit, based on the stack
trace, I suspect this was the result of the dereference attempt (below) due
to the invalid pointer stored in mod->kallsyms i.e. mod->kallsyms = (struct
mod_kallsyms __rcu *)mod->init_layout.base + info->mod_kallsyms_init_off:

  177             /* The following is safe since this pointer cannot change */
  178             rcu_dereference_sched(mod->kallsyms)->symtab = (void
*)symsec->sh_addr;

Kind regards,

-- 
Aaron Tomlin

