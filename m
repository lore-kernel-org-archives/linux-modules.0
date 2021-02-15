Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58EC4332E
	for <linux-modules@archiver.kernel.org>; Mon, 15 Feb 2021 15:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A564664EDC
	for <linux-modules@archiver.kernel.org>; Mon, 15 Feb 2021 15:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhBOPcW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhBOPbO (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 15 Feb 2021 10:31:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 773DE64E8E;
        Mon, 15 Feb 2021 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613402944;
        bh=Eu3WUePvokAybOU7GbeBtzYQy9xxEUNFFHjzBI8P/ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvslVtfzKTEiNQkYwZ/2uQKmnmRwqi3KSDBpwBQWaHcKkTE+7R+X8F0HywxzBD5D2
         t1HISJVq5kGB8zdiL0UM8PuXYKI/cAdqEQBJ6CPczLxzJHYJetjmVz75haXNaeMoT2
         RV90zxtEBUa6sSTog32N1PQeTts2AQfmv7q1eVdjIjrdoD3wR4LNWrDfLH6PD5indd
         cTdAiJ9cSUdgBQ0VuxKK5wlD7ayd45lsQIjzzyDDN2OiFJEshpVzrKmUQ7ZH2eigd4
         pUsXL0yyXjF6psf3HXnonwUtZPX5cJA5FxIhqz3xIjrfaSC85cfrsIpfrjt3sDOWKX
         NCCnB77dIZwhw==
Date:   Mon, 15 Feb 2021 16:28:59 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 2/4] libkmod-config: re-quote option from kernel cmdline
Message-ID: <YCqTOzfcWkbguKDO@gunter>
References: <20210212094524.170861-1-lucas.demarchi@intel.com>
 <20210212094524.170861-2-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210212094524.170861-2-lucas.demarchi@intel.com>
X-OS:   Linux gunter 5.11.0-rc4-1-default+ x86_64
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+++ Lucas De Marchi [12/02/21 01:45 -0800]:
>It was reported that grub mangles the kernel cmdline. It turns
>
>	acpi_cpufreq.dyndbg="file drivers/cpufreq/acpi-cpufreq.c +mpf"
>
>	into
>
>	"acpi_cpufreq.dyndbg=file drivers/cpufreq/acpi-cpufreq.c +mpf"
>
>However, even though we could blame grub for doing that, the kernel
>happily accepts and re-quotes it when the module is built-in.
>So, it's better if kmod also understands it this way and does the same.
>
>Here we basically add additional code to un-mangle it, moving the quote
>in way that is acceptable to pass through init_module(). Note that the
>interface [f]init_module() gives us mandates the quote to be part of the
>value: the module name is not passed and the options are separated by
>space.
>
>Reported-by: Jiri Slaby <jirislaby@kernel.org>
>Link: https://bugzilla.suse.com/show_bug.cgi?id=1181111#c10

Hi Lucas,

Thanks a lot for working on this. I applied this patchset on top of
kmod master and after some light testing it appears to be able to
handle the mangled quoting from grub now:

     Tested-by: Jessica Yu <jeyu@kernel.org>

