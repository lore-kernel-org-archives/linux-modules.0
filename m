Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:55425 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab3IKBch (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 10 Sep 2013 21:32:37 -0400
Received: by mail-ve0-f177.google.com with SMTP id db12so5124754veb.8
        for <linux-modules@vger.kernel.org>; Tue, 10 Sep 2013 18:32:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <522FC4B0.8090704@barfooze.de>
References: <522FC4B0.8090704@barfooze.de>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 10 Sep 2013 22:32:16 -0300
Message-ID: <CAMOw1v6U3e68JWj_FQ3UKT3Wj6=APzTTr--mpCrXTQY3fjpDZw@mail.gmail.com>
Subject: Re: [PATCH] make kmod compatible with GCC < 4.6
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi John,

On Tue, Sep 10, 2013 at 10:17 PM, John Spencer
<maillist-kmod@barfooze.de> wrote:
> hello list, find attached a patch that fixes compilation with
> non-bleeding-edge compilers (we use GCC 4.5.4 in production).
>
> the missing C11 feature is emulated on compilers that feature a __LINE__
> macro.

there's a patch for this applied already, restoring our previous
behavior. Doesn't it work for you? See dc8ed09 (Add configure check
for _Static_assert())



Lucas De Marchi
