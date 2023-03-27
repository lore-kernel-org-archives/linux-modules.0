Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D613C6FD1D
	for <linux-modules@archiver.kernel.org>; Mon, 27 Mar 2023 18:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjC0SVv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 27 Mar 2023 14:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjC0SVu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 27 Mar 2023 14:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ADC30EF
        for <linux-modules@vger.kernel.org>; Mon, 27 Mar 2023 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679941261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QmIkpEKXa5UxgJDPzN81fUKnNNvP0DAA7O3XVhN+u0=;
        b=RLpooCDwJg94Y1ftCVECYjKPQ6eIbVuf0GzziYT5COFVBh/qAI18+Czy3JpFAz9pAfezaa
        Uj0JvFt2z6m2stnqXYEaysp36OThe9Bj9GqPeqMNL+hHs5niicwfvYgs8nq/v5A2HY9eKY
        qhraeVaFcpumlAhZbuRBewddYF+MfDo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-P4otQsfsOBqpProx1cAtvg-1; Mon, 27 Mar 2023 14:20:59 -0400
X-MC-Unique: P4otQsfsOBqpProx1cAtvg-1
Received: by mail-ed1-f70.google.com with SMTP id k14-20020a508ace000000b005024a8cef5cso2458536edk.22
        for <linux-modules@vger.kernel.org>; Mon, 27 Mar 2023 11:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QmIkpEKXa5UxgJDPzN81fUKnNNvP0DAA7O3XVhN+u0=;
        b=wG9Jv/z5sRA99qtpKMwqQK17+ckd57YV8YE5NAxdWYyvCbdcLVprFgkAYe1yrKdwBb
         L4PQfad0NZvIW1kdwk2eqSbAMqml27zKsEUkjbNhcOaXoq9eVvBHCLq0/TI0fIOGrgHh
         kf5ic8IkPfxNbU8ckWAPmNu1+1Krj0KxGEp0oXgUKRmETl6JcPoIY7Iv+U/TNVf+5kxI
         KZNd3cghg8+FappGoOg3Kg9GOPIyD1G28KSAMsfDnww8CX6HdDsGkOBBSv4lZPlDlWum
         eUynUZ4cG8wwbzTBSrkutFc9Y6c0qfUdN5PW6QFeGDj1M8UBBoKgaipi88ecSAQ+fJLt
         jxSg==
X-Gm-Message-State: AAQBX9fNR+Hn3jLnRt6fUG2hU5NkqFJr7IBZo2wBqfPorTknTjanlN0i
        quhcIjX7ciFNgeqW2z2Ipnq20uAMwGcXR0Preu1zOI9Rr7p/G1gyu013948GKjeVPMGBgyogw+S
        CYmycOrTEd5Nbz6hysDdGI870
X-Received: by 2002:a17:906:578c:b0:88f:a236:69e6 with SMTP id k12-20020a170906578c00b0088fa23669e6mr13411029ejq.7.1679941258631;
        Mon, 27 Mar 2023 11:20:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyqZAVBR4sO7omGkqBh61MtackTk3PX7Mi9DzjBUxd+qSqTRoWMD57UFZPSeAY/JpJfDLw8w==
X-Received: by 2002:a17:906:578c:b0:88f:a236:69e6 with SMTP id k12-20020a170906578c00b0088fa23669e6mr13410994ejq.7.1679941258315;
        Mon, 27 Mar 2023 11:20:58 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id l11-20020a1709066b8b00b00939faf4be97sm9309590ejr.215.2023.03.27.11.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:20:58 -0700 (PDT)
Message-ID: <c076e249-705a-e1bb-c657-f80cd4f2145b@redhat.com>
Date:   Mon, 27 Mar 2023 20:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] kallsyms: move module-related functions under
 correct configs
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZCHWtptOwPPtUe+u@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 3/27/23 19:47, Luis Chamberlain wrote:
> On Mon, Mar 27, 2023 at 06:12:51PM +0200, Viktor Malik wrote:
>> Functions for searching module kallsyms should have non-empty
>> definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
>> only CONFIG_MODULES check was used for many of these, which may have
>> caused complilation errors on some configs.
>>
>> This patch moves all relevant functions under the correct configs.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
> 
> Thanks Viktor!  Does this fix something from an existing commit? If so
> which one?  The commit log should mention it.

Ah, right, I forgot about that. The commit log is missing:

Fixes: bd5314f8dd2d ("kallsyms, bpf: Move find_kallsyms_symbol_value out of internal header")

I can post v2 but I'm also fine with maintainers applying the tag.

Thanks!
Viktor

> 
>    LUis
> 

