Return-Path: <SRS0=4mbF=4U=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C684C3F2CD
	for <linux-modules@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2197E20714
	for <linux-modules@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583245876;
	bh=KwjBgQXzsah7oi1fUtF1a7x6k9SXrQZTFxNCNLW02dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kFZ8krQrtMAijYwUodVumQMnlsYNWlNiLwSckphWeGxzYRKpQKWaq7G78OA/KWJfQ
	 vFAn9Ii1ywT07eWDbT0LTdl41PaULm6AG6yJz+TyxmKpkpbvf/tKXJv4hQRsd46b/L
	 4KvQU9rv/+mXnfSDha5Y4zNRh5PP49vIv4iJk8mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgCCObP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbgCCObP (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Mar 2020 09:31:15 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2702D2073D;
        Tue,  3 Mar 2020 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583245875;
        bh=KwjBgQXzsah7oi1fUtF1a7x6k9SXrQZTFxNCNLW02dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epZ3ryNVMfUV/7ArS0j0HzzxM9jdFpVBesP96RQILiZBwlm+p4tmLNUkxFD/pznLT
         ipZ2tPZSu3wlkdwLMRQ05nqYlkmUE26/keamhpSPAHSSeqETxalXKDtQ/h12sA418j
         ohyYZa1hmkUeIBz4mg6DuIYy660f7RGaqr2aYrcY=
Date:   Tue, 3 Mar 2020 15:31:09 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] depmod: account for new namespace field in
 Module.symvers (for kernel versions >= 5.4)
Message-ID: <20200303143109.GA18979@linux-8ccs>
References: <20200221165243.25100-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200221165243.25100-1-jeyu@kernel.org>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+++ Jessica Yu [21/02/20 17:52 +0100]:
>depmod -e -E is broken for kernel versions >= 5.4, because a new
>namespace field was added to Module.symvers. Each line is tab delimited
>with 5 fields in total. E.g.,
>
>	0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL
>
>When a symbol doesn't have a namespace, then the namespace field is empty:
>
>	0xb352177e\tfind_first_bit\t\tvmlinux\tEXPORT_SYMBOL
>
>Fix up depmod_load_symvers() so it finds the crc, symbol, and module
>("where") fields correctly. Since there can be empty fields, strsep() is
>used instead of strtok(), since strtok() cannot handle empty fields
>(i.e., two delimiters in succession).
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>

Friendly ping? :-)

Thanks,

Jessica
