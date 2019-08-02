Return-Path: <SRS0=Ez/n=V6=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890DC433FF
	for <linux-modules@archiver.kernel.org>; Fri,  2 Aug 2019 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF072087C
	for <linux-modules@archiver.kernel.org>; Fri,  2 Aug 2019 18:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcBkiXxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406768AbfHBScs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:32:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45081 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405915AbfHBScr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Aug 2019 14:32:47 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so154232014ioc.12
        for <linux-modules@vger.kernel.org>; Fri, 02 Aug 2019 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwS6NVysKT0+c8CCpncR1xles8KnBQ/GENNp/Um2p3U=;
        b=TcBkiXxbnhV/MWUK2s+mfMK7pkG7NY4DEPoAMMOJjd/vyhEz3bH+gHWq5+qJSC6URN
         RUcmA11JGQELN+NNSeckZXDfKGfTG1AJGsnqKM4jzhTSWmU2Abz+gxDeXEIacYq7LXXI
         6cGGbdyIWRsTOguk+S8J4Vhwv8/+STSyNxgCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwS6NVysKT0+c8CCpncR1xles8KnBQ/GENNp/Um2p3U=;
        b=JsRWcuSIregC6kU0ViRfnMo2vKrNziesYR9/+Tn1OaWqTNhEKFp9AsVcFTXBVkeeKN
         oPRLLitOkZIdGWVhY7Rs0oRmiWMCq9zrxTRiqCZKXOumXgGN5X4hh7RfxA60N3ZMKBJ9
         UgFmrjOEefOuEI49Ur4d2B9YgwQSbQ0hw68HwKtCqZmXEdvcnswPM07BFG6S4GOlRD84
         yBOFDEWTNJMtzMHZ2QrtDHnU/46mrG/dx9Sf5i6plEUewtQCUW/xWGpFmfL0Uj62gqaX
         P+GTVzqixfUoyJO2+J+b6fSWKifosx484CE9HQYoWtziM966udFFu+YveYF7AA50CNdT
         u9dQ==
X-Gm-Message-State: APjAAAU9ZcHXrD6or7kO3NtzcvMbkwiOeWAkH4zyH7dtQ5wfp20ea7jd
        /9RIvuDx8DNz90Rr+oh3+YKQ+cBtkww=
X-Google-Smtp-Source: APXvYqycP4ZU7GEn2C+guLFOiUqpEeRsE0zvl+pEf1wgAuFzvDf6D4K8Q2K2W1KyTlRyXoCX09pVeg==
X-Received: by 2002:a02:cd82:: with SMTP id l2mr2159128jap.96.1564770766616;
        Fri, 02 Aug 2019 11:32:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:b9c3:6ca9:e77c:7d59])
        by smtp.gmail.com with ESMTPSA id v3sm21625243ioh.58.2019.08.02.11.32.45
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 11:32:46 -0700 (PDT)
Date:   Fri, 2 Aug 2019 12:32:44 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-modules@vger.kernel.org
Subject: Module compression & loadpin
Message-ID: <20190802183243.GA246294@chromium.org>
References: <20190731222209.GA101140@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731222209.GA101140@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Has anyone looked into what it may take to support both module
compression and loadpin (ensures modules come from trusted filesystem)?

From my understanding, this is not supported as kmod currently does the
decompression of modules, and loadpin prefers fload_module as it can
tell where the module came from. (https://crbug.com/777204)

In a gist, I am thinking supporting this scenario would require the
module decompression to happen on the kernel side. Wondering if anyone
has looked into this before I go making a solution...

Thanks,

Jack
