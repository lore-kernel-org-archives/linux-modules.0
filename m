Return-Path: <SRS0=jP7v=5G=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EF6C4332D
	for <linux-modules@archiver.kernel.org>; Sat, 21 Mar 2020 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9561320658
	for <linux-modules@archiver.kernel.org>; Sat, 21 Mar 2020 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/lEaimB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCUOW2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:22:28 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33624 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUOW1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 21 Mar 2020 10:22:27 -0400
Received: by mail-lj1-f181.google.com with SMTP id r22so2548481ljh.0
        for <linux-modules@vger.kernel.org>; Sat, 21 Mar 2020 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=o7YPuPA+Lvo3Vo3LoMsg1n6BEuSVWknRkdTk7foBna8=;
        b=N/lEaimB4M38RGNueZKja3zkhj4p4xRx9pXGNBqDLN+IoyWU/AOPdJZWLu1pgXBVz1
         oEyETBO3SB/pSNkudNH7oTrZgRn0LaF2WSHE/PtmEFZ5HQErA/sXgGSXTiz4Ul5fJJVf
         sTjT/QWJJDo5cC5ydzh2HprVE+wOiCUPkrq+FBmoo+sIo4RHDIz5Ur52MRATMbtSYIJ8
         I9lxJpT/gQg4EaorOWARV7KZ/KFyrIcRHJJNF2dl3IfUkqKvVQ+iawxBvj7lDW0qp8Mk
         YIp0j7dG9mF7m+UzjPP/ljRTW1Dkg2wrh9wg+rG+xhhEvw3dvrxLLmrUhNv7RFhX2QIH
         ElLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=o7YPuPA+Lvo3Vo3LoMsg1n6BEuSVWknRkdTk7foBna8=;
        b=GrmA3aGcCD0vaWSHy4K6uQdcPe2cfjXmQbG+stq8NkSYXZMh3FEbNMY8000qPSh/ou
         CCDrBqL/CVqQCUrFCsDPzWmu8Hgr0fe/12GbrfZt791O2fKHI9vWEkbZi9tvcmgMVtdd
         FvD8UvdjVol3KGWqhnC15yapoaoAx5O301vSbj6kjpntf8wzvGTCNAVDxDICpC5UWsT6
         z+D+Wy5Xf/AHrAPQNTT7tJzSd3xKoYl/fGAxaq9YimZZknszIzQhKuD8filGogtDgYYt
         CNe3U5yXyN6yXNBy6fDCYHwFlkQArZVmqj1vSHcZ9xnQ2k7GSKKyVyAnZVEO7er7xlBE
         ffAg==
X-Gm-Message-State: ANhLgQ2g1GvQtwJBeL7dYQoVP4bkiIPy3dsfwv50sY1BB7X8NYG4EYiM
        mcRAy0ZF/+q4ZDzAXiyI82IyUyCV
X-Google-Smtp-Source: ADFU+vtlT98P0t+b9Xy9DeVpZDoslvoED8b0Ajyd7hH1sVtdyLi/t8R3+qDUF1k8ARVexwcWtFm3Dw==
X-Received: by 2002:a2e:a483:: with SMTP id h3mr4424892lji.264.1584800543829;
        Sat, 21 Mar 2020 07:22:23 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id h25sm5377693ljg.31.2020.03.21.07.22.22
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 07:22:23 -0700 (PDT)
To:     linux-modules <linux-modules@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Replacement for blacklisting with 'install MOD /bin/false'?
Message-ID: <c38d8c8d-5290-7ff7-8daa-d8d76dc80ce0@gmail.com>
Date:   Sat, 21 Mar 2020 16:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,

I'm looking for a replacement for the deprecated 'install MOD 
/bin/{false,true}' modprobe.d rules for always blacklisting a module. 
The advantage of using the 'install' rule is that the 'blacklist' rules 
are ignored when loading modules manually, but the 'install' rules is 
not. Perhaps there should be a new rule ('always_blacklist'?) which is 
always obeyed?

-Topi
