Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02729C432BE
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CBA60EBC
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 12:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhHRMGA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Aug 2021 08:06:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhHRMGA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Aug 2021 08:06:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20A0120070;
        Wed, 18 Aug 2021 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629288325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qel0zAoiCF51myRaX4ulaDOSARYxeX0wbGHp9AVuUzI=;
        b=fScINlNCl4JNGI4BaK3wRQjxQe/mjlxxsApDlCCypCiChEX0GhdW2+hTlJAFeXNv9nPE9r
        OQkHLB3vDp4lywoohRcw0vnWaLeISErTfXXksaZ+TQV/SW1KJaWv8/CQ6QyOO2jUfh+ibQ
        GuNPy8/jVUq9WKRTniL5FozLgs2Ho4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629288325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qel0zAoiCF51myRaX4ulaDOSARYxeX0wbGHp9AVuUzI=;
        b=nAU7SkejPucpGTQDXd1D0iBg068Zc3mYtobd61YttH9DLRkVGxmQ99VADA/S7qUawAMcBA
        zSBGpJNK3z6dmIAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DA63D136DE;
        Wed, 18 Aug 2021 12:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id CU8bM4T3HGF8RAAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Wed, 18 Aug 2021 12:05:24 +0000
Date:   Wed, 18 Aug 2021 14:05:23 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-modules@vger.kernel.org,
        Michal =?iso-8859-2?Q?Such=E1nek?= <msuchanek@suse.cz>
Subject: Re: [PATCH] modinfo: don't parse built-in for explicitly given
 module files
Message-ID: <YRz3g5ZqJKIv1yCf@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210818112203.24863-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818112203.24863-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
