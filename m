Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF25DC433FE
	for <linux-modules@archiver.kernel.org>; Fri, 18 Nov 2022 17:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiKRRfb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiKRRfH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Nov 2022 12:35:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43024920B1
        for <linux-modules@vger.kernel.org>; Fri, 18 Nov 2022 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668792778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TydPydB++R7u+oQGl1q73u032SmAgan46ItVYeROsmQ=;
        b=dSFzVuNFjdXfbyLPsL+RlbkH8QyivHgK++pF4JLNQVPPRQUkc4eV5bQ2qnSl26U93mumAq
        9RDUhIlsikTeo/FKHbLqKn4miDhN8VjsrQufvJX1vFQ+4pXifN5TQ9jauOU34svdPFlFs7
        QpE+kTgK86m45V9l4uKL0ARMXT03pbs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-gbMRxe8SMhG_tSsT4lzzTQ-1; Fri, 18 Nov 2022 12:32:57 -0500
X-MC-Unique: gbMRxe8SMhG_tSsT4lzzTQ-1
Received: by mail-wm1-f70.google.com with SMTP id 84-20020a1c0257000000b003cfe9e8e3f9so2573468wmc.0
        for <linux-modules@vger.kernel.org>; Fri, 18 Nov 2022 09:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TydPydB++R7u+oQGl1q73u032SmAgan46ItVYeROsmQ=;
        b=X03b4mzAoJH60qELauZWsd2+C0WNY8dObIxFZbZkWxjLWbLlNr/E6O3lq4vqwff7Tn
         g+NEt+c+T7w9s4o3mOs2yJUXBgl3VI8+HcciVVSZRGPdUNJfqAjRj/YLVAhGWRATdyKz
         oe9Q4NyxDBKkmtMX0L4qm4DQM9IvS0l3SD0UUr4y/Mbw3MFJ4lDWGnswmlweQq8VGaFU
         laTI6n7emhiX01GVOADBb+STcvL3OLe6TzCDQI5EEOeTVeuDZgcqZvHJKOlFb9N2iIxV
         +UTzi2h++gjxuZNZ82hN2YrSBl6FciSiVsSTVxgz9z+GQL/PLNOohSaqGkXXlqq3grvv
         TUdg==
X-Gm-Message-State: ANoB5pmg6eqTM6Yv/7Iudz13z7wzub9YTomcbALiXeLbYBOiNGSWcTTW
        LiNnsAT0HHX9xYFBAqJW2KcAsFdu7FQmvb3Yh2qNURJmnN8Q6dDBdlImUTfM01OLXQ8B4q2HYDN
        exgPUuiB90Xztgaq7gaEZazJh1g==
X-Received: by 2002:a5d:4406:0:b0:22d:6988:30de with SMTP id z6-20020a5d4406000000b0022d698830demr4874348wrq.186.1668792775959;
        Fri, 18 Nov 2022 09:32:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6h6uJI53TwrfBbOFhzVPE+9cul+4RlRYm2mCAY21zH5E2yX6081R0EKooIKFTacK6p6dCbLQ==
X-Received: by 2002:a5d:4406:0:b0:22d:6988:30de with SMTP id z6-20020a5d4406000000b0022d698830demr4874330wrq.186.1668792775614;
        Fri, 18 Nov 2022 09:32:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:f500:6512:fac3:2687:15ff? (p200300cbc704f5006512fac3268715ff.dip0.t-ipconnect.de. [2003:cb:c704:f500:6512:fac3:2687:15ff])
        by smtp.gmail.com with ESMTPSA id y7-20020adff6c7000000b002368f6b56desm4806305wrp.18.2022.11.18.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 09:32:55 -0800 (PST)
Message-ID: <8c826c96-62ec-2f72-c4cb-30139d5639d1@redhat.com>
Date:   Fri, 18 Nov 2022 18:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 15.11.22 20:29, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>> I don't have the machine at hand right now. But, again, I doubt this will
>> fix it.
> 
> There are *more* modules processed after that commit. That's all. So
> testing would be appreciated.

I just tested that change on top of 6.1.0-rc5+ on that large system
and CONFIG_KASAN_INLINE=y. No change.


[  207.955184] vmap allocation for size 2490368 failed: use vmalloc=<size> to increase size
[  207.955891] vmap allocation for size 2490368 failed: use vmalloc=<size> to increase size
[  207.956253] vmap allocation for size 2490368 failed: use vmalloc=<size> to increase size
[  207.956461] systemd-udevd: vmalloc error: size 2486272, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=1-7
[  207.956573] CPU: 88 PID: 4925 Comm: systemd-udevd Not tainted 6.1.0-rc5+ #4
[  207.956580] Hardware name: Lenovo ThinkSystem SR950 -[7X12ABC1WW]-/-[7X12ABC1WW]-, BIOS -[PSE130O-1.81]- 05/20/2020
[  207.956584] Call Trace:
[  207.956588]  <TASK>
[  207.956593] vmap allocation for size 2490368 failed: use vmalloc=<size> to increase size
[  207.956593]  dump_stack_lvl+0x5b/0x77
[  207.956613]  warn_alloc.cold+0x86/0x195
[  207.956632]  ? zone_watermark_ok_safe+0x2b0/0x2b0
[  207.956641]  ? slab_free_freelist_hook+0x11e/0x1d0
[  207.956672]  ? __get_vm_area_node+0x2a4/0x340
[  207.956694]  __vmalloc_node_range+0xad6/0x11b0
[  207.956699]  ? trace_contention_end+0xda/0x140
[  207.956715]  ? __mutex_lock+0x254/0x1360
[  207.956740]  ? __mutex_unlock_slowpath+0x154/0x600
[  207.956752]  ? bit_wait_io_timeout+0x170/0x170
[  207.956761]  ? vfree_atomic+0xa0/0xa0
[  207.956775]  ? load_module+0x1d8f/0x7ff0
[  207.956786]  module_alloc+0xe7/0x170
[  207.956802]  ? load_module+0x1d8f/0x7ff0
[  207.956822]  load_module+0x1d8f/0x7ff0
[  207.956876]  ? module_frob_arch_sections+0x20/0x20
[  207.956888]  ? ima_post_read_file+0x15a/0x180
[  207.956904]  ? ima_read_file+0x140/0x140
[  207.956918]  ? kernel_read+0x5c/0x140
[  207.956931]  ? security_kernel_post_read_file+0x6d/0xb0
[  207.956950]  ? kernel_read_file+0x21d/0x7d0
[  207.956971]  ? __x64_sys_fspick+0x270/0x270
[  207.956999]  ? __do_sys_finit_module+0xfc/0x180
[  207.957005]  __do_sys_finit_module+0xfc/0x180
[  207.957012]  ? __ia32_sys_init_module+0xa0/0xa0
[  207.957023]  ? __seccomp_filter+0x15e/0xc20
[  207.957066]  ? syscall_trace_enter.constprop.0+0x98/0x230
[  207.957078]  do_syscall_64+0x58/0x80
[  207.957085]  ? asm_exc_page_fault+0x22/0x30
[  207.957095]  ? lockdep_hardirqs_on+0x7d/0x100
[  207.957103]  entry_SYSCALL_64_after_hwframe+0x63/0xcd


I have access to the system for a couple more days, if there
is anything else I should test.

-- 
Thanks,

David / dhildenb

