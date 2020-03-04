Return-Path: <SRS0=cK9R=4V=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA41CC3F2D1
	for <linux-modules@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D0C20848
	for <linux-modules@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nwphqfem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgCDLem (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54841 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDLem (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so1649155wml.4
        for <linux-modules@vger.kernel.org>; Wed, 04 Mar 2020 03:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQ6JteJFpQIhec40xTZagWTgiX07l7a4gvzXtzl/BmY=;
        b=NwphqfemnVcGOxaWdTElj84LTefMU6UeuY5BVYCp41KdwecI74GLHHxjX32mu8DTJD
         mNK+FjsX4wiC/97KI6J7d4LW6gBChLOaa/48b/hDVS7xZ1kvlI7v4AltvsiUC5QaPQ9C
         +a75p5I4JaF2d3DLfTSOpx4byr5dch60Y8mNd8XcpLoYsn7mgovznj58PBgclWuBU5U2
         +nsaunbQib9pPC7+YslEaEEadfsWHI2Lv4cZkLfVkcKX2EHLiMpDjDfm3Oz8RYLtIe0K
         xyv0U2lX9TcRd+OU71RsDwpnaz3v7JgIaXKCy83XCJGs5zyoTTaDrHlPl+pQwaL0IPJR
         q2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQ6JteJFpQIhec40xTZagWTgiX07l7a4gvzXtzl/BmY=;
        b=VTT9vJeJUio/Hkeh5tGcEGf2knMaJwGdfylQUL3gPnmJHuz4sL/fUlhLNlFMH5r6QS
         qy6Mnr+Kf+2pv8uqN1Oto8dGk47S+ebJqMCLGrNwrMGX6diR9gSar1LIkKp7hrOr79Ub
         pBdgjeRN7AMAMg/RA/mTez7j5UtlR9soFv4z/VKNjWxWSnMo/ZMoJUVpk6UcoD9vM4fp
         FGb8eBfl6AapRnx0GBSjrrjBZ8P8uX7wSWY/huKDJkSlQ22oN+cVKioayWrIm/o2o2er
         diA/XEhmL6hxwfJ1wxHQzDu39gSmjlXWKnel7tHZAFIMcIqG1+lINr36Zr2/IZ3soIVm
         kuhA==
X-Gm-Message-State: ANhLgQ24t/ckWrB3gC1Lil9/kiKTCj5U7CbpP101dUe976ikv6OVRQfr
        QtRpakA9zpAQdbLfuXm+rc64wg==
X-Google-Smtp-Source: ADFU+vt532czteFBFM3TUwt9//Y0tP2xVzP1sSTxn41o9D99tK6cy9MyzBUxwfoAF38oj8vdAnSA2A==
X-Received: by 2002:a05:600c:301:: with SMTP id q1mr3351931wmd.182.1583321678687;
        Wed, 04 Mar 2020 03:34:38 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id b13sm3931011wme.2.2020.03.04.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:34:38 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:34:37 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] depmod: account for new namespace field in
 Module.symvers (for kernel versions >= 5.4)
Message-ID: <20200304113437.GB66900@google.com>
References: <20200221165243.25100-1-jeyu@kernel.org>
 <CAKi4VA+uO-mdZ=gKpWdU6vq2_VJjhDkHS3KVZb3_6N2YGVhgiA@mail.gmail.com>
 <20200304091833.GA14910@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200304091833.GA14910@linux-8ccs>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 04, 2020 at 10:18:33AM +0100, Jessica Yu wrote:
>+++ Lucas De Marchi [03/03/20 22:28 -0800]:
>>On Fri, Feb 21, 2020 at 8:53 AM Jessica Yu <jeyu@kernel.org> wrote:
>>>
>>>depmod -e -E is broken for kernel versions >= 5.4, because a new
>>>namespace field was added to Module.symvers. Each line is tab delimited
>>>with 5 fields in total. E.g.,
>>>
>>>        0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL
>>>
>>>When a symbol doesn't have a namespace, then the namespace field is empty:
>>>
>>>        0xb352177e\tfind_first_bit\t\tvmlinux\tEXPORT_SYMBOL
>>
>>Why is namespace added in the *middle*? We remember we specifically
>>talked about compatibility back when this was added. Why is it not at
>>the end so tools that don't know about namespace don't stop working?
>>
>>Lucas De Marchi
>
>Sigh, I do remember we had a short discussion upstream back in August
>[1] when we were tossing around Module.symvers format preferences. It
>is my fault for not having pushed the backwards compatibility option
>more instead of thinking it could be patched up in kmod tools. I think
>maybe the best course of option is to revert this upstream instead and
>Cc:stable.
>
>Sorry about this. :-/

Sorry, my fault. The discussion went first all around whether we should
append the namespace to the symbol name. This we did not do.
Then we discussed whether the last values of this line are actually
optional and we settled with the format now merged as nobody further
objected in the tail end of this discussion:
  https://lore.kernel.org/linux-modules/20190828101640.GB25048@linux-8ccs/

We could probably move the namespace to the end as the other fields are
not optional (at least judging from write_dump() in modpost.c).

Cheers,
Matthias

>
>[1] https://lore.kernel.org/r/20190828094325.GA25048@linux-8ccs
>
