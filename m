Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5DC6FD18
	for <linux-modules@archiver.kernel.org>; Tue, 28 Mar 2023 21:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjC1VEF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjC1VEC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Mar 2023 17:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873131FE8
        for <linux-modules@vger.kernel.org>; Tue, 28 Mar 2023 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680037373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4Hb/CRF5zwZSBNRFYwXcQFmKxAiRnjWuMb3e2gT9JU=;
        b=P3Yvo1wKNkoaAYhDMatmnK7jtSgdHmgDpBSVaIBAE7PnGMZa1jkRmsMjxypOLcSiBe3/0N
        9W7zZS+BxC2OqsnTkXiqsIAoICWyR/BUu2zdBsv7wj9BKzkJSkl38YYiHe6kxhkunlCEOu
        XmWEGVgAk0ijhai7h+iWQ9uvuGv//I0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-48vBPTzeMYO_LnxenKe0FQ-1; Tue, 28 Mar 2023 17:02:52 -0400
X-MC-Unique: 48vBPTzeMYO_LnxenKe0FQ-1
Received: by mail-pg1-f198.google.com with SMTP id e36-20020a631e24000000b0050f76fb84b6so3490101pge.8
        for <linux-modules@vger.kernel.org>; Tue, 28 Mar 2023 14:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680037371;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4Hb/CRF5zwZSBNRFYwXcQFmKxAiRnjWuMb3e2gT9JU=;
        b=DY51SedYm9tE5jTYvavMPaZO2t25SQTpEnBQKehenhyEMI91xPMw5SIB/o0u12t2US
         g+eTUOp0xpXI2LDvmT7XqzylJkMYc0wQ+ug+Z1VTaxXonbdfMK5OiBgtouLWh0NExmfl
         h9y3+ghxpnusbaQ21jpA7xkwI/rma9Cu5oizLQemIs+42JLxvJApy0bbWzJMi5rchoBs
         DcWEuOHxS2KO0Evewo37TfuJ0eLWbZRPcdfpMZN4BfkqH2KDC6dg1CWLVlbsgaMeiVYO
         SY33oUbL+EdCbzAP+6+yUGrt02W8pmV8gJT338InDBhnouft8OkLG6xw+JSUOx6f/FQM
         1pPQ==
X-Gm-Message-State: AAQBX9fdMsMO8fuGYt04blzwFyh/tPEpcOrcAU4qB65NOCgqv6TuMgCf
        3RQLDbYLaTVm893Yvcm6/MOZ6ideSl36WvWZfjhGEB2sfD3TieZ0x55+Oo1DEmlkcvwGCeatQrM
        Fk+SSKcMEtbo//WMKJEsaQm95KA==
X-Received: by 2002:a17:90b:3e8e:b0:23f:58a2:7d86 with SMTP id rj14-20020a17090b3e8e00b0023f58a27d86mr19045888pjb.10.1680037370947;
        Tue, 28 Mar 2023 14:02:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zvibmm8JL1bafJ+55KHNzs63rRWoHtokMZT5d2OvCtDImB8VHj3wLTxjFfULVKtHkj/39Ykw==
X-Received: by 2002:a17:90b:3e8e:b0:23f:58a2:7d86 with SMTP id rj14-20020a17090b3e8e00b0023f58a27d86mr19045849pjb.10.1680037370436;
        Tue, 28 Mar 2023 14:02:50 -0700 (PDT)
Received: from [192.168.35.160] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id jm2-20020a17090304c200b001a04d27ee92sm16499425plb.241.2023.03.28.14.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 14:02:49 -0700 (PDT)
Message-ID: <5aceccdf-d268-7872-abb5-c14e9aa8b7b7@redhat.com>
Date:   Tue, 28 Mar 2023 23:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
References: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <e5c2183a-f62a-6ca9-eec6-a7fab7ce4c91@redhat.com>
 <ZCKGI1LxktS7pKS9@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
In-Reply-To: <ZCKGI1LxktS7pKS9@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 28.03.23 08:16, Luis Chamberlain wrote:
> On Tue, Mar 28, 2023 at 05:44:40AM +0200, David Hildenbrand wrote:
>> ... do you have an updated patch/branch that includes the feedback from
>> Linus so I can give it a churn tomorrow?
> 
> Yeah sure:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230327-module-alloc-opts
> 

I gave that one a go and get for system bootup:

#1:

13.761s tuned.service
12.261s chrony-wait.service
  7.386s NetworkManager-wait-online.service
  5.227s systemd-udev-settle.service
  2.893s initrd-switch-root.service
  2.148s polkit.service
  2.137s smartd.service
  1.893s dracut-initqueue.service
  1.290s NetworkManager.service
  1.032s cups.service


#2

13.881s tuned.service
  9.255s chrony-wait.service
  7.404s NetworkManager-wait-online.service
  5.826s systemd-udev-settle.service
  2.859s initrd-switch-root.service
  2.847s smartd.service
  2.172s polkit.service
  1.884s dracut-initqueue.service
  1.371s NetworkManager.service
  1.119s ModemManager.service


So we're a bit faster (0.2 -- 0.7s) than the original version without 
the rcu patch (~6s).


> The commit log needs updateing to reflect the results I just collected:
> 
> With the alloc patch ("module: avoid allocation if module is already
> present and ready") I see 145 MiB in memory difference in comparison
> to its last patch, "module: extract patient module check into helper".
> So I think that's a clear keeper and should help large CPU count boots.
> 
> The patch "module: add concurrency limiter" which puts the concurency
> delimiter on the kread only saves about 2 MiB with 100 stress-ng ops,
> which seems to be what I needed to reproduce your 400 CPU count original
> issue.
> 
> The program used to reproduce is stress-ng with the new module option:
> 
> echo 0 > /proc/sys/vm/oom_dump_tasks
> ./stress-ng --module 100 --module-name xfs

Above command fills for me with nfs (but also ext4) the kernel log with:

...
[  883.036035] nfs: Unknown symbol xdr_reserve_space (err -2)
[  883.042221] nfs: Unknown symbol rpc_init_wait_queue (err -2)
[  883.048549] nfs: Unknown symbol put_rpccred (err -2)
[  883.054104] nfs: Unknown symbol __fscache_invalidate (err -2)
[  883.060540] nfs: Unknown symbol __fscache_use_cookie (err -2)
[  883.066969] nfs: Unknown symbol rpc_clnt_xprt_switch_has_addr (err -2)
[  883.074264] nfs: Unknown symbol __fscache_begin_write_operation (err -2)
[  883.081743] nfs: Unknown symbol nlmclnt_init (err -2)
[  883.087396] nfs: Unknown symbol nlmclnt_done (err -2)
[  883.093074] nfs: Unknown symbol nfs_debug (err -2)
[  883.098429] nfs: Unknown symbol rpc_wait_for_completion_task (err -2)
[  883.105640] nfs: Unknown symbol __fscache_acquire_cookie (err -2)
[  883.163764] nfs: Unknown symbol rpc_put_task (err -2)
[  883.169461] nfs: Unknown symbol __fscache_acquire_volume (err -2)
[  883.176297] nfs: Unknown symbol rpc_proc_register (err -2)
[  883.182430] nfs: Unknown symbol rpc_shutdown_client (err -2)
[  883.188765] nfs: Unknown symbol rpc_clnt_show_stats (err -2)
[  883.195097] nfs: Unknown symbol __fscache_begin_read_operation (err -2)
...


I do *not* get these errors on manual morprobe/rmmod. BUG in concurrent 
handling or just side-effect of the concurrent loading?

> 
> To see how much max memory I use, I just use:
> 
> free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > foo.log
> 
> Run the test in another window, CTRL-C the test when above
> finishes after 40 seconds and then:
> 
> sort -n -r foo.log  | head -1

[root@lenovo-sr950-01 fs]# sort -n -r foo.log  | head -1
14254024
[root@lenovo-sr950-01 fs]# sort -n -r foo.log  | tail -1
12862528

So 1391496 (KiB I assume, so 1.3 GiB !?) difference compared to before 
the test (I first start capturing and then run stress-ng).


> 
> If you have xfs loaded already you probably wanna pick module just as big
> that you don't have loaded. You must have dependencies loaded already as
> it doesn't call modprobe, it just finit_module's the module.


My setup already has xfs in use. nfs and ext4 are a bit smaller, but 
still big.

-- 
Thanks,

David / dhildenb

