Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29348C433F5
	for <linux-modules@archiver.kernel.org>; Tue,  1 Mar 2022 16:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiCAQxP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiCAQxO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Mar 2022 11:53:14 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net (p3plsmtpa08-06.prod.phx3.secureserver.net [173.201.193.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1BDB53
        for <linux-modules@vger.kernel.org>; Tue,  1 Mar 2022 08:52:32 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id P5jinZajW7hrhP5jjnpw7C; Tue, 01 Mar 2022 09:52:31 -0700
X-CMAE-Analysis: v=2.4 cv=EqsXEQQA c=1 sm=1 tr=0 ts=621e4f4f
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=20KFwNOVAAAA:8 a=uMNopYx9kklUAK_Ie8EA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Tue, 1 Mar 2022 16:52:29 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     pmladek@suse.com
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: Re: [PATCH v9 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220301165229.5pwxyhxonbw5za3i@ava.usersys.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-11-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228234322.2073104-11-atomlin@redhat.com>
X-CMAE-Envelope: MS4xfINBdR/q/bcqzriP3IEMbFhi47PsAzTEpGuiTlKK9J3Tu1GOW2hMFU5HeFL6BP0gCS9Ex8GN8S3w1AJ8L1P2s4Zrgy92386sFKRfhJD/bgMWsZfnpPW/
 cOYrDcTuhKpzORxfXNoJUGTy386F7nhO76AFns/9dTo+AShVlsbhd0GmhLOVM9YX55mxgq7+oQZ+mKEhd9N7jKlJ6HHuyNuXNZQpk/hlKfBBJdizJVjToV6z
 SWYppYAiRwTbykNK2073+dJVKMt05vQTOBiguGuebeWOcn0ctbjLZJsev/CmmsuRqhfxinGJZTyQmazFRhMYYKuwNJn9TSK/k/mIaQ7eiPM7t9x0QpupHp0V
 pTwAGN+jZ7ohsIkS6Jmw1T4J3jEqDZOnZYy9bVjM2xxFyvLNUDeCkcvqwdVUjCDEPlHRQ0cL5yNYaTz9/gLUbPwVsacLi1NDscT8ECFEh349CnfiE+TKfRcd
 F+2uwrh8+Bg8Op2W9Ibion+0/nMBTw4atbuBVomw3pEvCZIsK0x54ZxUn8Eh6R3VKH9KmboZ8F5a34hO4OiTQTWZX0ElqST9SWcKcDjasFIx/zP5W63rrVap
 QXLQjRtM1mG6xRGWy+0+UgOf0bxgk6/ZLGtIobTSu5Z++0XO14FCbVuJA+Tphv7Lq3/jxlKHKkcbvAPnUf8Ma/+t
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-02-28 23:43 +0000, Aaron Tomlin wrote:
> No functional change.
> 
> The purpose of this patch is to address the various Sparse warnings
> due to the incorrect dereference/or access of an __rcu pointer.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/module/kallsyms.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Petr,

Any concerns?

Unfortunately, I didn't make enough time to test.


Kind regards,

-- 
Aaron Tomlin
