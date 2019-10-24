Return-Path: <SRS0=Q6Ms=YR=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27709CA9EAF
	for <linux-modules@archiver.kernel.org>; Thu, 24 Oct 2019 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA482070B
	for <linux-modules@archiver.kernel.org>; Thu, 24 Oct 2019 15:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502981AbfJXPCC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:02:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:40609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502980AbfJXPCC (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 24 Oct 2019 11:02:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 08:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="223584784"
Received: from lkebler-mobl.amr.corp.intel.com (HELO ldmartin-desk1) ([10.255.64.149])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2019 08:02:01 -0700
Date:   Thu, 24 Oct 2019 08:02:01 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-modules@vger.kernel.org, kernel-team@android.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] depmod: add support for symbol namespaces
Message-ID: <20191024150201.4lad7shwhtvgwowx@ldmartin-desk1>
References: <20191004094136.166621-1-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004094136.166621-1-maennich@google.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Oct 04, 2019 at 10:41:36AM +0100, Matthias Maennich wrote:
>Linux v5.4 introduces symbol namespaces [1], [2].
>They appear in the ksymtab as entries with the scheme
>
>   __ksymtab_NAMESPACE.symbol_name
>
>In order to support these at depmod time, strip out namespaces when
>loading the System.map.
>
>[1] https://lore.kernel.org/lkml/20190906103235.197072-1-maennich@google.com/
>[2] https://lore.kernel.org/lkml/20191003075826.7478-1-yamada.masahiro@socionext.com/
>
>Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>Cc: Martijn Coenen <maco@android.com>
>Cc: linux-modules@vger.kernel.org
>Signed-off-by: Matthias Maennich <maennich@google.com>

with the new change merged in the kernel to remove the namespace from
the middle, my understanding is that we don't need this right?

Lucas De Marchi

>---
> tools/depmod.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/tools/depmod.c b/tools/depmod.c
>index 391afe9fe0a0..723f4c7be88c 100644
>--- a/tools/depmod.c
>+++ b/tools/depmod.c
>@@ -2576,7 +2576,7 @@ static int depmod_load_system_map(struct depmod *depmod, const char *filename)
>
> 	/* eg. c0294200 R __ksymtab_devfs_alloc_devnum */
> 	while (fgets(line, sizeof(line), fp) != NULL) {
>-		char *p, *end;
>+		char *p, *end, *delim;
>
> 		linenum++;
>
>@@ -2601,7 +2601,13 @@ static int depmod_load_system_map(struct depmod *depmod, const char *filename)
> 		if (end != NULL)
> 			*end = '\0';
>
>-		depmod_symbol_add(depmod, p + ksymstr_len, true, 0, NULL);
>+		/* Support for namespaced symbols: __ksymtab_NAMESPACE.symbol */
>+		delim = strrchr(p + ksymstr_len, '.');
>+		if (delim != NULL)
>+			depmod_symbol_add(depmod, delim + 1, true, 0, NULL);
>+		else
>+			depmod_symbol_add(depmod, p + ksymstr_len, true, 0, NULL);
>+
> 		continue;
>
> 	invalid_syntax:
>-- 
>2.23.0.581.g78d2f28ef7-goog
>
