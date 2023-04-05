Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49091C7619A
	for <linux-modules@archiver.kernel.org>; Wed,  5 Apr 2023 17:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjDERHc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDERHb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 5 Apr 2023 13:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B069B4
        for <linux-modules@vger.kernel.org>; Wed,  5 Apr 2023 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680714400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jGMyE/H4z0XX1rbokRrj+UlMMC2RKbOMB2U8991WxU=;
        b=gsytrA3zaQKWI+6qf3PBSvOUnP+vnIwl4te0xeaJtSZDGQfDTLA0vefCZTxyq8qG2ytsZ+
        4jngw6fo7dFaaAmdP0LEVPIHvobNQcLQCcaCxDCYrABBrMW4Goju02PrSUUJTI6SZw2wVV
        UwEzCzx8z1lvF0BA2uEzDc0UxCOizZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-hjBKLfwfPlOypQVL-y1s2g-1; Wed, 05 Apr 2023 13:06:39 -0400
X-MC-Unique: hjBKLfwfPlOypQVL-y1s2g-1
Received: by mail-wr1-f70.google.com with SMTP id d5-20020adfa345000000b002d716fc080fso4580250wrb.22
        for <linux-modules@vger.kernel.org>; Wed, 05 Apr 2023 10:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714398;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jGMyE/H4z0XX1rbokRrj+UlMMC2RKbOMB2U8991WxU=;
        b=nNL2RHgE0aOsjDg/zVuEIAtagXIHPScR18Gp2Wjxxb1xUn2VjS49M4KgZYGtwTS7bB
         XEc/LYWoX+TYI0R/NWwTHXZpPJvJ+DQoqioKM/Qtq1/9bv3Gae9oUmOGS2yVSGNlgrOx
         2bgRCw717tmfyyiY3JyQa1c4gCKRIOXWoVzA64LwJvL/51zHSa8i7Jt+bYn2RkEIAdj6
         loPVZytEcY02Xk4O1nxJjlDhMEq1YYrtAomeeJGlYxHEDc2Ikpy7YIB2Lqk+tJ8dD6md
         OiBmKLRwTEoxuBaAWaDyYUDsrsUoh0N+oGREzoQ7mbM09a/E5HQTH0qFYUKzBNlEklZm
         L/tA==
X-Gm-Message-State: AAQBX9e0X685zN1JiJwMe/PLlgJzkoVftl/LGkwHrTwRqE5s4XrKZD6M
        2RSydNbLbI02DT4CEm5DQOfMbeZwotLFyW6+x/DribA2s99658xRTjKFp/rDJ7wilooVYt5fBKw
        bbK0yGVCq5ng6bf43veRy2WO8Fg==
X-Received: by 2002:a05:600c:3644:b0:3eb:42fa:39d5 with SMTP id y4-20020a05600c364400b003eb42fa39d5mr5247557wmq.29.1680714398418;
        Wed, 05 Apr 2023 10:06:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zc3yUUSM0QMVb09Y7+zHVijaxSRVwUv8quFIs59ptAnEOpLeN1hskZOZ5fkbJtamSWNoF0vQ==
X-Received: by 2002:a05:600c:3644:b0:3eb:42fa:39d5 with SMTP id y4-20020a05600c364400b003eb42fa39d5mr5247534wmq.29.1680714398050;
        Wed, 05 Apr 2023 10:06:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b002cefcac0c62sm15631552wrq.9.2023.04.05.10.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:06:37 -0700 (PDT)
Message-ID: <d6f6f4a5-2b6d-d3d6-0806-8c41ac5dcdf0@redhat.com>
Date:   Wed, 5 Apr 2023 19:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/6] module: move finished_loading()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-3-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405022702.753323-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 05.04.23 04:26, Luis Chamberlain wrote:
> This has no functional change, just moves a routine earlier
> as we'll make use of it next.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

I'd simply squash into #3, as that's short enough that the move doesn't 
add significant noise. Anyhow:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

