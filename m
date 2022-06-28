Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858DC43334
	for <linux-modules@archiver.kernel.org>; Tue, 28 Jun 2022 04:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbiF1EFc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbiF1EFc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Jun 2022 00:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6362BB2F;
        Mon, 27 Jun 2022 21:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDF35616D4;
        Tue, 28 Jun 2022 04:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3542CC3411D;
        Tue, 28 Jun 2022 04:05:28 +0000 (UTC)
Date:   Tue, 28 Jun 2022 00:05:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220628000526.11c57cd8@gandalf.local.home>
In-Reply-To: <20220310102413.3438665-10-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
        <20220310102413.3438665-10-atomlin@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 10 Mar 2022 10:24:08 +0000
Aaron Tomlin <atomlin@redhat.com> wrote:

> No functional change.
> 

And this too has a functional change as well.

Reported-by: Chuck Lever III <chuck.lever@oracle.com>
Link: https://lore.kernel.org/all/355D2478-33D3-4046-8422-E512F42C51BC@oracle.com/


Before this patch:

 # grep -a '^[0-9a-f]* [^a-zA-Z]' /proc/kallsyms

Nothing.

After this patch:

 # grep -a '^[0-9a-f]* [^a-zA-Z]' /proc/kallsyms
ffffffffc09df024 ^@ _note_9     [ebtables]
ffffffffc09df03c ^@ _note_8     [ebtables]
ffffffffc0e25024 ^@ _note_9     [bridge]
ffffffffc0e2503c ^@ _note_8     [bridge]
ffffffffc0e01000 ^@ br_switchdev_event  [bridge]
ffffffffc0e39548 ^@ __warned.10 [bridge]
ffffffffc09bd024 ^@ _note_9     [stp]
ffffffffc09bd03c ^@ _note_8     [stp]
ffffffffc0849024 ^@ _note_9     [vmw_vmci]
ffffffffc084903c ^@ _note_8     [vmw_vmci]
ffffffffc0849454 ^@ __kstrtab_vmci_context_get_priv_flags       [vmw_vmci]
ffffffffc0849470 ^@ __kstrtabns_vmci_context_get_priv_flags     [vmw_vmci]
ffffffffc0849054 ^@ __ksymtab_vmci_context_get_priv_flags       [vmw_vmci]
ffffffffc081d024 ^@ _note_9     [nf_reject_ipv6]
ffffffffc081d03c ^@ _note_8     [nf_reject_ipv6]
ffffffffc081d0a8 ^@ __kstrtab_nf_reject_skb_v6_tcp_reset        [nf_reject_ipv6]
ffffffffc081d0c3 ^@ __kstrtabns_nf_reject_skb_v6_tcp_reset      [nf_reject_ipv6]
ffffffffc081d078 ^@ __ksymtab_nf_reject_skb_v6_tcp_reset        [nf_reject_ipv6]
ffffffffc081d0c4 ^@ __kstrtab_nf_reject_skb_v6_unreach  [nf_reject_ipv6]

The kallsyms get corrupted output, and this breaks trace-cmd.

-- Steve


> This patch migrates kallsyms code out of core module
> code kernel/module/kallsyms.c
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/module/Makefile   |   1 +
>  kernel/module/internal.h |  29 +++
>  kernel/module/kallsyms.c | 502 ++++++++++++++++++++++++++++++++++++
>  kernel/module/main.c     | 531 +--------------------------------------
>  4 files changed, 538 insertions(+), 525 deletions(-)
>  create mode 100644 kernel/module/kallsyms.c
> 
