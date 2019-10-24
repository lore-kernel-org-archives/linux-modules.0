Return-Path: <SRS0=Q6Ms=YR=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0540CCA9EBD
	for <linux-modules@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFFF20659
	for <linux-modules@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceg2kEk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503766AbfJXRZW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:25:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44450 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503725AbfJXRZT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 24 Oct 2019 13:25:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so3615599wro.11
        for <linux-modules@vger.kernel.org>; Thu, 24 Oct 2019 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4jIy/9PLgdClUESLpSH1oBb7soOtCT6K0zg5pdq+foc=;
        b=ceg2kEk6XCofWWxYeQNZ4oqjDheQs2aO5nZdYh60dNio5qhxhIunraTja2HyHywqBW
         a3OY5qFDB4Psnnq0VJUOzbXM9GIkECHjBP5exRFrMiDKR/ErMYY62RiylYeXeBgHlheT
         FNeytfqV0Rukx3e8besnEejBqklsOZ9VVFbXUp+WcaTZzua5g6Mcj0F7rISNqvHq4e2P
         6kXO7q7HKzKk/6+10wcqVUYSxOCevx1aLOB9oyWohtgb9/YritXQWQG1eEgAY/JNRD2k
         Flr2zE3uXxxNfXQBzQ1+obNGzRRFKmfl96SYfMZRkyqwCV/EMfMZFIoEGCP1D5bjybJu
         aExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4jIy/9PLgdClUESLpSH1oBb7soOtCT6K0zg5pdq+foc=;
        b=ccv8C1Brt1RNoIDvudBu3+Gu56lHoUS4fDpVqGCiKD/ik/IO0aWB8PtpWvk9jntKXE
         plHHUZCQHyz/lYs2e01NC9c4m5IEt+KDSBF8oiUFrP0gFXwKGzG2rv8DXKEFtpNefGsO
         OdVta5Sv2qejlt2OHULwBN69/JxR9oWRmyYd5vAv5LdtqNsw9aYquTNZMGwyF2sNlOUN
         5vfCig73Hr2CrhSI2EHtMpSmIuuPATvbBPdbyiFnh24r7/7pay+cKjh5h3BtcqcbIJ+m
         XsTgKLlsQytUjha/1uYwkSGPaAvjPZB1Vc4I9SXd2Ho9dMxPgJVcPzyDMJqk+D/Ifnoa
         n4og==
X-Gm-Message-State: APjAAAVMNFhOGyfFEkzxP0IV04RT9vrkVuoNjUl5ueWjk4S94AnQQY49
        MLRNXLIyaPVWma4bY/hkgrhI3Q==
X-Google-Smtp-Source: APXvYqwcrzuDL+JWtQsvCzdIWB1ivWUjh4QjJpTAdu5NkdX7FWZQobIt9DmUkCDtBDqIm+31HNG7Og==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr4890033wro.326.1571937916702;
        Thu, 24 Oct 2019 10:25:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id o187sm3827277wmo.3.2019.10.24.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:25:15 -0700 (PDT)
Date:   Thu, 24 Oct 2019 18:25:15 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, kernel-team@android.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] depmod: add support for symbol namespaces
Message-ID: <20191024172515.GC140858@google.com>
References: <20191004094136.166621-1-maennich@google.com>
 <20191024150201.4lad7shwhtvgwowx@ldmartin-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191024150201.4lad7shwhtvgwowx@ldmartin-desk1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 24, 2019 at 08:02:01AM -0700, Lucas De Marchi wrote:
>On Fri, Oct 04, 2019 at 10:41:36AM +0100, Matthias Maennich wrote:
>>Linux v5.4 introduces symbol namespaces [1], [2].
>>They appear in the ksymtab as entries with the scheme
>>
>>  __ksymtab_NAMESPACE.symbol_name
>>
>>In order to support these at depmod time, strip out namespaces when
>>loading the System.map.
>>
>>[1] https://lore.kernel.org/lkml/20190906103235.197072-1-maennich@google.com/
>>[2] https://lore.kernel.org/lkml/20191003075826.7478-1-yamada.masahiro@socionext.com/
>>
>>Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>>Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>>Cc: Martijn Coenen <maco@android.com>
>>Cc: linux-modules@vger.kernel.org
>>Signed-off-by: Matthias Maennich <maennich@google.com>
>
>with the new change merged in the kernel to remove the namespace from
>the middle, my understanding is that we don't need this right?

Correct, we should not need this any longer.

Cheers,
Matthias

>
>Lucas De Marchi
>
>>---
>>tools/depmod.c | 10 ++++++++--
>>1 file changed, 8 insertions(+), 2 deletions(-)
>>
>>diff --git a/tools/depmod.c b/tools/depmod.c
>>index 391afe9fe0a0..723f4c7be88c 100644
>>--- a/tools/depmod.c
>>+++ b/tools/depmod.c
>>@@ -2576,7 +2576,7 @@ static int depmod_load_system_map(struct depmod *depmod, const char *filename)
>>
>>	/* eg. c0294200 R __ksymtab_devfs_alloc_devnum */
>>	while (fgets(line, sizeof(line), fp) != NULL) {
>>-		char *p, *end;
>>+		char *p, *end, *delim;
>>
>>		linenum++;
>>
>>@@ -2601,7 +2601,13 @@ static int depmod_load_system_map(struct depmod *depmod, const char *filename)
>>		if (end != NULL)
>>			*end = '\0';
>>
>>-		depmod_symbol_add(depmod, p + ksymstr_len, true, 0, NULL);
>>+		/* Support for namespaced symbols: __ksymtab_NAMESPACE.symbol */
>>+		delim = strrchr(p + ksymstr_len, '.');
>>+		if (delim != NULL)
>>+			depmod_symbol_add(depmod, delim + 1, true, 0, NULL);
>>+		else
>>+			depmod_symbol_add(depmod, p + ksymstr_len, true, 0, NULL);
>>+
>>		continue;
>>
>>	invalid_syntax:
>>-- 
>>2.23.0.581.g78d2f28ef7-goog
>>
