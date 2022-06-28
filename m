Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BEECCA479
	for <linux-modules@archiver.kernel.org>; Tue, 28 Jun 2022 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiF1IUS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiF1ITN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34DBA6241
        for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2022 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656404351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NEd/F0XlL3oR7gCWidNYp+a8omsLOSzAv169aAg3pR8=;
        b=FSgcZnIPWWwW7X0f/xZJsGWJb9oPxxUlV54BuwzWyL9GgaIDLwLEf7e8ZEwHxyoWKkDQJZ
        MahgHeO/57I63ioIdTA2fXllSXy7VF+a+Cs3/X/4AN4pVTeRpTYfkv0izCzDj4fvWKLSeO
        Wl8TW+lzjMgDcth3RBWyY0xjl6LfXH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-9z-uGTKiPjqHATK9_nHkGQ-1; Tue, 28 Jun 2022 04:19:09 -0400
X-MC-Unique: 9z-uGTKiPjqHATK9_nHkGQ-1
Received: by mail-wr1-f72.google.com with SMTP id s7-20020adfbc07000000b0021a558c09b4so1581188wrg.4
        for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2022 01:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEd/F0XlL3oR7gCWidNYp+a8omsLOSzAv169aAg3pR8=;
        b=Zvs87BFZD2XEIaR81BzNQiYOR2HheiMUN3xUzIv+2hW0AXzYniQr7+ua4r2menhAZm
         bGOhviNosrfHD/i0HCmvR5Vpa1RFIyVQfAMKlRRp5NgszfF0nSjouNBaAGc5zCzU4FGy
         9OLxJxNdTExz8LG47NQJYh35gzaPCDadMnK2r78QKTSlTqX59+7LFBKItw61bSJyrylN
         PYvThkQCDWS1x2ekzzw64GKdXkdLIFLC1nq1NzQGc+uq5zSOydeMBowUL7faShAgkRTY
         ynqrH7Jdn/fpQDRW6PhzoQqluXAAB2Avd9oq3yFfhfwosRYjSHFkukOToNWp2JN/DBgI
         c8wQ==
X-Gm-Message-State: AJIora+gKE57Q66XfJAsWLi1qRf8OCbXOsCLuNyEiilVmdO18YpyZu5U
        3ae6gr9F6f1Ix3KAjz32rpYJcUZrzmLmSKYQOUcCl5w4z4/aPPOqPUjoXzxJiW68Ln+T0SVgbmV
        C6U3KhwgtdpMTLsyEbJwOXCej
X-Received: by 2002:a5d:470a:0:b0:21b:87a0:42e2 with SMTP id y10-20020a5d470a000000b0021b87a042e2mr16684873wrq.55.1656404348580;
        Tue, 28 Jun 2022 01:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqDAN76FDxD/eIGp88G3GBH9kc1M5XcMMxet21b7qaeFHP1bZGPFFRO6e/7U0Nt8rqNgd/VQ==
X-Received: by 2002:a5d:470a:0:b0:21b:87a0:42e2 with SMTP id y10-20020a5d470a000000b0021b87a042e2mr16684837wrq.55.1656404348314;
        Tue, 28 Jun 2022 01:19:08 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b0039c4f53c4fdsm25972468wmq.45.2022.06.28.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:19:07 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:19:06 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20220628081906.jln2ombfej5473xi@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628000526.11c57cd8@gandalf.local.home>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-06-28 00:05 -0400, Steven Rostedt wrote:
> On Thu, 10 Mar 2022 10:24:08 +0000
> Aaron Tomlin <atomlin@redhat.com> wrote:
> 
> > No functional change.
> > 
> 
> And this too has a functional change as well.
> 
> Reported-by: Chuck Lever III <chuck.lever@oracle.com>
> Link: https://lore.kernel.org/all/355D2478-33D3-4046-8422-E512F42C51BC@oracle.com/
> 
> 
> Before this patch:
> 
>  # grep -a '^[0-9a-f]* [^a-zA-Z]' /proc/kallsyms
> 
> Nothing.
> 
> After this patch:
> 
>  # grep -a '^[0-9a-f]* [^a-zA-Z]' /proc/kallsyms
> ffffffffc09df024 ^@ _note_9     [ebtables]
> ffffffffc09df03c ^@ _note_8     [ebtables]
> ffffffffc0e25024 ^@ _note_9     [bridge]
> ffffffffc0e2503c ^@ _note_8     [bridge]
> ffffffffc0e01000 ^@ br_switchdev_event  [bridge]
> ffffffffc0e39548 ^@ __warned.10 [bridge]
> ffffffffc09bd024 ^@ _note_9     [stp]
> ffffffffc09bd03c ^@ _note_8     [stp]
> ffffffffc0849024 ^@ _note_9     [vmw_vmci]
> ffffffffc084903c ^@ _note_8     [vmw_vmci]
> ffffffffc0849454 ^@ __kstrtab_vmci_context_get_priv_flags       [vmw_vmci]
> ffffffffc0849470 ^@ __kstrtabns_vmci_context_get_priv_flags     [vmw_vmci]
> ffffffffc0849054 ^@ __ksymtab_vmci_context_get_priv_flags       [vmw_vmci]
> ffffffffc081d024 ^@ _note_9     [nf_reject_ipv6]
> ffffffffc081d03c ^@ _note_8     [nf_reject_ipv6]
> ffffffffc081d0a8 ^@ __kstrtab_nf_reject_skb_v6_tcp_reset        [nf_reject_ipv6]
> ffffffffc081d0c3 ^@ __kstrtabns_nf_reject_skb_v6_tcp_reset      [nf_reject_ipv6]
> ffffffffc081d078 ^@ __ksymtab_nf_reject_skb_v6_tcp_reset        [nf_reject_ipv6]
> ffffffffc081d0c4 ^@ __kstrtab_nf_reject_skb_v6_unreach  [nf_reject_ipv6]
> 
> The kallsyms get corrupted output, and this breaks trace-cmd.

Hi Steve,

I will look into this straight away.


Kind regards,

-- 
Aaron Tomlin

