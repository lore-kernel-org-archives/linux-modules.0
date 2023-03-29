Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E6C6FD18
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 11:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjC2Lle (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC2Lld (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 07:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6844A2
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680090046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gxc02lB4ReHZJCVlVCYTPAsHaTYfjuyyUkDtNRC+vns=;
        b=IRhvEtlVkyJzVXNspjIjKbJQgjnUY8Ixo26jq22vBk7i/20da8LBHSPg7yi7vZa4gjfzbG
        jMdQJmBMwrpLNuj2ei5L2VxE5MwlxibzvmJwYbXeRe4qt1e603fOH6SspolpDBeSTG4Siz
        JlI9VG8iKKESAculfvGNkUmD93l4bnA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-r3O4G3FkOtmFbMB7hXPgwQ-1; Wed, 29 Mar 2023 07:40:45 -0400
X-MC-Unique: r3O4G3FkOtmFbMB7hXPgwQ-1
Received: by mail-ed1-f72.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so22199242edb.21
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 04:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxc02lB4ReHZJCVlVCYTPAsHaTYfjuyyUkDtNRC+vns=;
        b=siogBW0JDjBkC9ja927jjOvXmXx4UaxthJYpyR6cx0I+tnb/fr5NqmZ8fVZzMdj903
         qlJjEH+n7GgUWu7SUhEmluUFT4qyG3UNDq10a1qxh1oB2kfvs6pFWND814To/4SuJ0O7
         lXZqTbzE+pgJunStlnuAUV91Vxlmit2uxEgrOz3awLo9FmlZw6Mzrjc02qkx8/a9reL8
         XfINT2hVfBrnWXDdOrp2N72jo3NjH19sOuQKd8KsqqUwEb+dtcWYmnA1RRHSav3xxRjD
         F89gWMfzHnxmpWgDCqkKolncYinBajzLd22BmcYUZ5z1Xtukl6HLXAd4RYmkht89d3gX
         iR8w==
X-Gm-Message-State: AAQBX9fLUJYSFqsbg7L9dHs2Qjm8HOs2fQ+xCvEdVNX3zMP4zQcr50MC
        uqLl/sco3sVRTTb4dlqxKIieyc8Eqp1De4wel04aDJQ/mpdFSmtAPphIYOW6EpELWwTS3HEhiRz
        TClytewZNVa5mvBkhvgc+SK/d9N3HtymmYJM=
X-Received: by 2002:a17:906:5acf:b0:8b1:7684:dfab with SMTP id x15-20020a1709065acf00b008b17684dfabmr22972781ejs.38.1680090044125;
        Wed, 29 Mar 2023 04:40:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350aEz9DwwYv9nDpq3n9IzUtlPhBnia/H7+vRksj6SvClDW2OK44VDqv9cJnSNi01Cuk7b4qD+Q==
X-Received: by 2002:a17:906:5acf:b0:8b1:7684:dfab with SMTP id x15-20020a1709065acf00b008b17684dfabmr22972754ejs.38.1680090043759;
        Wed, 29 Mar 2023 04:40:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:7c:5b35:3b22:9bb9? ([2001:67c:1220:8b4:7c:5b35:3b22:9bb9])
        by smtp.gmail.com with ESMTPSA id qq24-20020a17090720d800b008df7d2e122dsm16303445ejb.45.2023.03.29.04.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:40:43 -0700 (PDT)
Message-ID: <9dec8409-6e69-4f14-dcd8-9f47e088ce17@redhat.com>
Date:   Wed, 29 Mar 2023 13:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next] kallsyms: move module-related functions under
 correct configs
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
References: <20230327161251.1129511-1-vmalik@redhat.com>
 <ZCHWtptOwPPtUe+u@bombadil.infradead.org>
 <c076e249-705a-e1bb-c657-f80cd4f2145b@redhat.com>
 <ZCHuU4Wui7Dwmdm2@bombadil.infradead.org>
 <bfaefad6-692f-e687-ad55-05a43aa54883@iogearbox.net>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <bfaefad6-692f-e687-ad55-05a43aa54883@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 3/28/23 10:23, Daniel Borkmann wrote:
> On 3/27/23 9:28 PM, Luis Chamberlain wrote:
>> On Mon, Mar 27, 2023 at 08:20:56PM +0200, Viktor Malik wrote:
>>> On 3/27/23 19:47, Luis Chamberlain wrote:
>>>> On Mon, Mar 27, 2023 at 06:12:51PM +0200, Viktor Malik wrote:
>>>>> Functions for searching module kallsyms should have non-empty
>>>>> definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
>>>>> only CONFIG_MODULES check was used for many of these, which may have
>>>>> caused complilation errors on some configs.
>>>>>
>>>>> This patch moves all relevant functions under the correct configs.
>>>>>
>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
>>>>
>>>> Thanks Viktor!  Does this fix something from an existing commit? If so
>>>> which one?  The commit log should mention it.
>>>
>>> Ah, right, I forgot about that. The commit log is missing:
>>>
>>> Fixes: bd5314f8dd2d ("kallsyms, bpf: Move find_kallsyms_symbol_value out of internal header")
>>>
>>> I can post v2 but I'm also fine with maintainers applying the tag.
>>
>> That patch went through the bpf tree so its fix can go throug that tree.
>> So up to Daniel if he wants a new patch.
> 
> Fixing up is fine with me. Viktor, which config combinations did you test for this
> patch and under which architectures?
> 
> I suspect kbuild bot might still complain. For example, your patch moves
> dereference_module_function_descriptor() stub definition under !CONFIG_MODULES ||
> !CONFIG_KALLSYMS. Looking at ppc's dereference_module_function_descriptor()
> implementation (!CONFIG_PPC64_ELF_ABI_V2 case), it's build under CONFIG_MODULES,
> so you'll have two different implementations of the functions, the generic one
> then w/o __weak attribute.

Right, I didn't notice this one, thanks. Looks like
dereference_module_function_descriptor will need to stay in the original
place (under CONFIG_MODULES only). I'll cross-compile for arches that
redefine this function (powerpc, ia64, parisc) with relevant config
combinations and submit v2. The rest of the functions don't have
arch-dependent implementations, so they should be fine.

> 
> Also small nit, please fix the patch up wrt indentation to align with kernel coding
> style.

Ok, will do.

Thanks,
Viktor

> 
> Thanks,
> Daniel
> 

