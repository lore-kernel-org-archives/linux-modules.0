Return-Path: <SRS0=Fs8F=5I=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FBC4332E
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 19:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4812A20658
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgCWT3O (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:29:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:63908 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgCWT3N (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 Mar 2020 15:29:13 -0400
IronPort-SDR: L3jVlOfVPoX7EdLWIQr5e9/u2VnDgj+aeB7IKMc0p+O8apQ2wynbrmkKY3YhhIKEdjCKziyTVo
 QGamdFme5qkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:29:13 -0700
IronPort-SDR: UdySUgCbk7xiGeuY5O5WDC8D6zD9SmxQ7yhM4JGK1zLGdgDOScliZhmvce+DNyaFJR1sCv7akW
 91aQh8kYrpAg==
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="264883148"
Received: from sganes3-mobl1.amr.corp.intel.com (HELO ldmartin-desk1) ([10.134.73.79])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:29:12 -0700
Date:   Mon, 23 Mar 2020 12:29:11 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Replacement for blacklisting with 'install MOD /bin/false'?
Message-ID: <20200323192911.qm5ismk4h5rrbm5o@ldmartin-desk1>
X-Patchwork-Hint: ignore
References: <c38d8c8d-5290-7ff7-8daa-d8d76dc80ce0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c38d8c8d-5290-7ff7-8daa-d8d76dc80ce0@gmail.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Mar 21, 2020 at 04:22:22PM +0200, Topi Miettinen wrote:
>Hi,
>
>I'm looking for a replacement for the deprecated 'install MOD 
>/bin/{false,true}' modprobe.d rules for always blacklisting a module. 
>The advantage of using the 'install' rule is that the 'blacklist' 
>rules are ignored when loading modules manually, but the 'install' 
>rules is not. Perhaps there should be a new rule ('always_blacklist'?) 
>which is always obeyed?

yeah, I do have a sketch for "hard-blacklist" for that exact reason...

I will try to revive that patches soon.

thanks
Lucas De Marchi

>
>-Topi
