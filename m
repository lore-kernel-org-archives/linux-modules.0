Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6B4C48BCF
	for <linux-modules@archiver.kernel.org>; Wed,  9 Jun 2021 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D272861376
	for <linux-modules@archiver.kernel.org>; Wed,  9 Jun 2021 17:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhFIRUr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:20:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:27228 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhFIRUq (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Jun 2021 13:20:46 -0400
IronPort-SDR: 6O+ZdzBHcfouuxI7nVLyDuhgBQyybHXvlAlq9ib/DAXLhIdINJ4MQ8klN1KPYL+X/PlvhXT6Rg
 e+QR2WoUMT9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="184809772"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="184809772"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:18:51 -0700
IronPort-SDR: y1Bvby02EgSUJQT5MHw0lC54xErlgtkCEK07Yos9i4cwoNeQD5gBxuLTr6bFUj2+a5N3gKx7jo
 jgsvPzd9edkA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="477023692"
Received: from lfbrown-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.254.4.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:18:50 -0700
Date:   Wed, 9 Jun 2021 10:18:49 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Subject: Re: [PATCH 2/2] libkmod-builtin: consider final NIL in name length
 check
Message-ID: <20210609171849.xvbgrsvyehxueowd@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20210608062859.93959-1-ykaliuta@redhat.com>
 <20210608062923.94017-1-ykaliuta@redhat.com>
 <20210608062923.94017-2-ykaliuta@redhat.com>
 <20210609171053.c72kzwcdkdrgcwpv@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210609171053.c72kzwcdkdrgcwpv@ldmartin-desk2>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 09, 2021 at 10:10:53AM -0700, Lucas De Marchi wrote:
>On Tue, Jun 08, 2021 at 09:29:23AM +0300, Yauheni Kaliuta wrote:
>>There is potential buffer overrun in kmod_builtin_iter_get_modname()
>>for the name of length PATH_MAX. The required buffer size is
>>PATH_MAX, so `modname[len] = '\0'` with len == PATH_MAX will write
>>right beyond the buffer.
>
>this doesn't look correct. "with len == PATH_MAX" we will actually
>return an error.
>
>What indeed is happening is truncation: since we are not reserving 1
>char for NUL termination, we will truncate the name. If we update the
>commit message to state the right reasoning, then we can land this patch.
>
>I don't see any buffer overflow here, but I may be missing something.

another thing... what is your git-sendemail setup? This is putting patch
2 as a reply to patch 1 and that breaks b4. See:
https://lore.kernel.org/linux-modules/20210608062923.94017-1-ykaliuta@redhat.com/T/#u

Lucas De Marchi

>
>thanks
>LUcas De Marchi
>
>>
>>Check the length against PATH_MAX - 1.
>>
>>Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
>>---
>>libkmod/libkmod-builtin.c | 2 +-
>>1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
>>index a002cb5ee2c6..3d4d77ab29b3 100644
>>--- a/libkmod/libkmod-builtin.c
>>+++ b/libkmod/libkmod-builtin.c
>>@@ -246,7 +246,7 @@ bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
>>
>>	len = dot - line;
>>
>>-	if (len >= PATH_MAX) {
>>+	if (len >= PATH_MAX - 1) {
>>		sv_errno = ENAMETOOLONG;
>>		goto fail;
>>	}
>>-- 
>>2.31.1
>>
