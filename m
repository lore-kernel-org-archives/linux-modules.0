Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46045C43217
	for <linux-modules@archiver.kernel.org>; Mon, 17 Oct 2022 07:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJQH13 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Oct 2022 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJQH11 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Oct 2022 03:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA445A3F5
        for <linux-modules@vger.kernel.org>; Mon, 17 Oct 2022 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665991644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjWUtxQLwEV8jEI6Zuh3YSz4Df1i1QcpeTHLe3Byoa8=;
        b=T23Qo/G26iKTBlUpfB6S09H8LPniPfw/Gzb6MthRJNw4CifDw9QgpASIsAyHnzawd30wuM
        VdqrPk6pX3MLIxU2QnUER316yHFBMuqFEgAFSFo1oDo3LoiLJphumn5PT96ati+tDoCpui
        ELRNSfplEuULwoTQvUB7pgBcjSnKkIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-H0siYTJlM2GchYYxTtD6BA-1; Mon, 17 Oct 2022 03:27:22 -0400
X-MC-Unique: H0siYTJlM2GchYYxTtD6BA-1
Received: by mail-wm1-f72.google.com with SMTP id r188-20020a1c44c5000000b003c3a87d8abdso3360000wma.2
        for <linux-modules@vger.kernel.org>; Mon, 17 Oct 2022 00:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjWUtxQLwEV8jEI6Zuh3YSz4Df1i1QcpeTHLe3Byoa8=;
        b=g0aRAIHqV+bFuIt/xkpPlGuQaMaR8lI2/YVkUtyvwQd+vIlBoIR3XI/3UlpCy6A6Sz
         lYL0Zg6+wdwBBtANH8/66kbsXgOpORrqD7rX+/mu57J7GM9a2MQeOrwI9vTru3CAcJ3T
         MCWR0KDXMif7zi98RsFn0AuuKVz1kU1a16gtjIG8bsVgMd5cmdP+V/lFXcABQCjq3KaS
         5/CyqKfhfSgZ81TJ1I2qsjKa9V23fb5T2sPXRtFOLqcy+FoLp4mqxlNsRNUSjq9+hNL6
         iD+S4M2ls1TlL4E0XmyPjzqkCKDPJlAswfTh3/fjfBnbL/B3HXQVoPIdUuS72NKgOjqC
         O3Ng==
X-Gm-Message-State: ACrzQf0M9XQU6fRzwUwYFwOARVvsna3WV0fEH1QNH0w2WWXHxnGUyxhq
        gIxzI9JHR2IWBzTYpdMz1G3szSR94nFUBDaUS6BekdqaM8ulAfu0ZPQx9gvfWqWBL7HctpeUrDI
        ImN7z81QhkyK9j2p9s3Dz+jKBiw==
X-Received: by 2002:a05:600c:255:b0:3c6:e58d:354e with SMTP id 21-20020a05600c025500b003c6e58d354emr6243019wmj.168.1665991641220;
        Mon, 17 Oct 2022 00:27:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SwYLNo8rpwflySjZODiH6m0DdIanJn9se9sxjS30MEcWLnqg9kzlxEUK4f8asHCYjKCJq5w==
X-Received: by 2002:a05:600c:255:b0:3c6:e58d:354e with SMTP id 21-20020a05600c025500b003c6e58d354emr6243008wmj.168.1665991640975;
        Mon, 17 Oct 2022 00:27:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2300:e5ce:21ba:1d93:4323? (p200300cbc7072300e5ce21ba1d934323.dip0.t-ipconnect.de. [2003:cb:c707:2300:e5ce:21ba:1d93:4323])
        by smtp.gmail.com with ESMTPSA id w3-20020adfee43000000b0022add5a6fb1sm7702303wro.30.2022.10.17.00.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:27:20 -0700 (PDT)
Message-ID: <4cc17c82-4f80-d0cc-acb9-c83f8ccf729c@redhat.com>
Date:   Mon, 17 Oct 2022 09:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 2/4] module: Update a comment describing what is
 protected by module_mutex
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-3-petr.pavlu@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221016123031.3963-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 16.10.22 14:30, Petr Pavlu wrote:
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   kernel/module/main.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a12e177ea81f..5288843ca40f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -62,10 +62,11 @@
>   
>   /*
>    * Mutex protects:
> - * 1) List of modules (also safely readable with preempt_disable),
> + * 1) list of modules (also safely readable with preempt_disable, delete and add
> + *    uses RCU list operations).
>    * 2) module_use links,
> - * 3) mod_tree.addr_min/mod_tree.addr_max.
> - * (delete and add uses RCU list operations).
> + * 3) mod_tree.addr_min/mod_tree.addr_max,
> + * 4) list of unloaded_tainted_modules.
>    */
>   DEFINE_MUTEX(module_mutex);
>   LIST_HEAD(modules);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

