Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAFEC4361B
	for <linux-modules@archiver.kernel.org>; Thu, 10 Dec 2020 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708DE23B85
	for <linux-modules@archiver.kernel.org>; Thu, 10 Dec 2020 23:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392230AbgLJXOe (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:14:34 -0500
Received: from omta012.uswest2.a.cloudfilter.net ([35.164.127.235]:54092 "EHLO
        omta012.uswest2.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393087AbgLJXOT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Dec 2020 18:14:19 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 18:14:19 EST
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.208])
        by cmsmtp with ESMTP
        id nIzCk8qHGcxd0nV2Hkhk5k; Thu, 10 Dec 2020 23:07:45 +0000
Received: from thunder.sweets ([68.100.138.62])
        by cmsmtp with ESMTPSA
        id nV2EkxgWsASf9nV2GkNJVA; Thu, 10 Dec 2020 23:07:45 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=jbuehler@cox.net
X-Authority-Analysis: v=2.4 cv=EJrDb3VC c=1 sm=1 tr=0 ts=5fd2aa41
 a=3mkzfl4ircflX6G+lDqBYw==:117 a=3mkzfl4ircflX6G+lDqBYw==:17
 a=8nJEP1OIZ-IA:10 a=zTNgK-yGK50A:10 a=TNYumuwFysTXnyQBsCsA:9 a=wPNLvfGTeEIA:10
Received: by thunder.sweets (Postfix, from userid 116)
        id 7C0DC11B0E; Thu, 10 Dec 2020 18:07:36 -0500 (EST)
Received: from [10.10.10.15] (thunder.sweets [10.10.10.15])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by thunder.sweets (Postfix) with ESMTPS id 0C28511AFF
        for <linux-modules@vger.kernel.org>; Thu, 10 Dec 2020 18:07:34 -0500 (EST)
Message-ID: <5FD2AA34.3000409@cox.net>
Date:   Thu, 10 Dec 2020 18:07:32 -0500
From:   Joe Buehler <aspam@cox.net>
User-Agent: Thunderbird 1.5.0.12 (X11/20120201)
MIME-Version: 1.0
To:     linux-modules@vger.kernel.org
Subject: lspci: Unable to load libkmod resources: error -12
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP3wnVxgcWDFl5MRDSlGCNwfLkigLJ9yx8hlLrBK6Rqqis0OwTB6+GTccF3TV1t8ou1RHuHgD+fX8tWEh6b0OOYCDPuI9fduHIo8Nl9bfco2590jQJv8
 OjBdlZG+xuKmMCVmJqB9OKlzS63J8IMe/gcgNqdg2edOKY1r7FOpCXLuXPx8trKRkPCWAkmNVs7SoA==
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When running lspci -v on Ubuntu 20.40, I get the error message:

lspci: Unable to load libkmod resources: error -12

I tracked this down to a possible libkmod issue.  The kernel I am using
has an empty modules.builtin.aliases.bin file (modules.builtin.aliases
does not exist).

kmod_load_resources() doesn't like this.  It calls index_mm_open() which
checks the file size, sees that it is less than sizeof(hdr), error
terminates, causing kmod_load_resources() to return -ENOMEM.

kmod version 27 as shipped with ubuntu 20.04

Please copy me on any responses, I am not on this list.

Joe Buehler

