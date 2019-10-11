Return-Path: <SRS0=2Kvf=YE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4449DECE58C
	for <linux-modules@archiver.kernel.org>; Fri, 11 Oct 2019 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F09E222C3
	for <linux-modules@archiver.kernel.org>; Fri, 11 Oct 2019 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3vZDG8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfJKPnP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:43:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36982 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJKPnP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Oct 2019 11:43:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so10671230wmc.2
        for <linux-modules@vger.kernel.org>; Fri, 11 Oct 2019 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IkvpMa/Wbpx2VqhnGR9Yn3NTs6llmrr8FmiZZgZjer8=;
        b=X3vZDG8yiduvmHkrBKdm66t60S2SmVt7Hj4fmdcMZ9LRkp8FNQ5jAnkRGJf8POzXRn
         ZEPrUuEA3sjz31G7Y9MBGEg7tTqpLOgVdDXqiEMfgQqhoQdd6vB1WyxWmXPJM+K0yepf
         ftDr+itzH0IsdPAiGU6jnb9Rp1PjWD57efySuYo06Y4A8D/xpLj+zhfX9ZXdovaI3IN6
         dBzcy/EDVFQj7UDYNh325+ZdIyxnami4RvpcuTMpwIkaw2j4OYAfXqTA6DXki7NbT/Uw
         2Dfml6WB1+tx2UD8EtcC+pFFiDQSfgST/KKkzypSFFKVKwOOhG+HvaNXU1oKtc4fkeIx
         dNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IkvpMa/Wbpx2VqhnGR9Yn3NTs6llmrr8FmiZZgZjer8=;
        b=MTDSNfJV70F1FJXkxFblbP4nwpdamcQ1bnumQ6/3507HIeCVtDLc9cpUGEdSFz4oU8
         dal7p+7/bQFdta/Rdb83N0drbOyFnaCWRNXKXTF1BTwv64oULubn0tGrOhnppxNImUOp
         IdwHQKTaWYeLj/y4nJgqriJmylan/OhgSvh7VJ+f619qUqgvcrKAaW+ZRQDCU8hsu91U
         N1Z1jRGMWU9Im8BfUai2dgqgKkj1l5QL8oNlUq3eoKj8DgCUx292KnO2qc5Mor9SP7IY
         rYkMVbhSl8cHN0ERUNzU6XybfmI2Evf8A2oU2B9DJo5l+9v2bIIM+QNcmDG8qq7lRYPm
         FsIw==
X-Gm-Message-State: APjAAAViSfplu0RYmWUJRuM7ndLJ9GLvFtN8fQO8h4CtSD5tZZ7vsOq0
        46IktmLRPmSEacpV5/3yDho1AQ==
X-Google-Smtp-Source: APXvYqxt3UXygeXinwIg1evC6ymRhLH+w7/H5e3CEQMemZD1O0osIhi1XeCl3mzp06xPlgUPPoUUnA==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr3785533wmc.121.1570808592952;
        Fri, 11 Oct 2019 08:43:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id r2sm13732272wrm.3.2019.10.11.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:43:11 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:43:11 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/4] export: avoid code duplication in
 include/linux/export.h
Message-ID: <20191011154311.GA192647@google.com>
References: <20191010151443.7399-1-maennich@google.com>
 <20191010151443.7399-5-maennich@google.com>
 <20191011153127.GA1283883@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191011153127.GA1283883@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Oct 11, 2019 at 05:31:27PM +0200, Greg Kroah-Hartman wrote:
>On Thu, Oct 10, 2019 at 04:14:43PM +0100, Matthias Maennich wrote:
>> Now that the namespace value is not part of the __ksymtab entry name
>> anymore, we can simplify the implementation of EXPORT_SYMBOL*. By
>> allowing the empty string "" to represent 'no namespace', we can unify
>> the implementation and drop a lot redundant code.  That increases
>> readability and maintainability.
>>
>> As Masahiro pointed out earlier,
>> "The drawback of this change is, it grows the code size. When the symbol
>> has no namespace, sym->namespace was previously NULL, but it is now am
>> empty string "". So, it increases 1 byte for every no namespace
>> EXPORT_SYMBOL. A typical kernel configuration has 10K exported symbols,
>> so it increases 10KB in rough estimation."
>
>10Kb of non-swapable memory isn't good.  But if you care about that, you
>can get it back with the option to compile away any non-used symbols,
>and that shouldn't be affected by this change, right?

Rasmus suggested to put the 'aMS' flags on the __ksymtab_strings section
to mitigate this:
https://lore.kernel.org/lkml/f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk/

I was not yet able to properly test this, so I did not include it in
this series. As I said in the cover letter, this 4th patch might be
optional for 5.4. So, we could defer it to a later time when we have
addressed that properly.

Cheers,
Matthias

>
>That being said, the code is a lot cleaner, so I have no objection to
>it.
>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
